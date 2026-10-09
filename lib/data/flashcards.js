import { inChunks } from "./chunk";

// Colunas novas vêm de SQLs: dificuldade e imagem (flashcards_dificuldade_imagem.sql) e
// ordem/aula (flashcards_aulas.sql). Se algum ainda não tiver sido rodado, o app cai
// para o conjunto de colunas anterior em vez de quebrar.
const COLUMN_SETS = [
  "id, tema, pergunta, resposta, dificuldade, imagem_url, imagem_credito, imagem_lado, ordem, aula",
  "id, tema, pergunta, resposta, dificuldade, imagem_url, imagem_credito, imagem_lado",
  "id, tema, pergunta, resposta",
];
let columnSetIndex = 0;

async function selectFlashcards(supabase, build) {
  for (; columnSetIndex < COLUMN_SETS.length; columnSetIndex++) {
    const { data, error } = await build(supabase.from("flashcards").select(COLUMN_SETS[columnSetIndex]));
    if (!error) return data;
    const isMissingColumn = /dificuldade|imagem_|ordem|aula|42703|does not exist/i.test(`${error.code || ""} ${error.message || ""}`);
    if (!isMissingColumn || columnSetIndex === COLUMN_SETS.length - 1) throw error;
  }
  throw new Error("Não foi possível carregar os flashcards.");
}

// Ordem de "aula": por tema e, dentro dele, pela sequência didática (ordem). Cards sem ordem vão ao fim.
export function sortLesson(cards) {
  return [...cards].sort(
    (a, b) =>
      (a.tema || "").localeCompare(b.tema || "") ||
      (a.ordem ?? 1e9) - (b.ordem ?? 1e9) ||
      (a.id < b.id ? -1 : a.id > b.id ? 1 : 0)
  );
}

export async function fetchFlashcardThemeCounts(supabase) {
  const { themeCounts } = await fetchFlashcardCounts(supabase);
  return themeCounts;
}

// Contagem por tema e, dentro de cada tema, por dificuldade (cards sem
// dificuldade só entram na contagem "Todos").
export async function fetchFlashcardCounts(supabase) {
  const data = await fetchAllFlashcards(supabase);
  const themeCounts = {};
  const difficultyCounts = {};
  for (const f of data) {
    themeCounts[f.tema] = (themeCounts[f.tema] || 0) + 1;
    if (f.dificuldade) {
      const d = (difficultyCounts[f.tema] ||= { facil: 0, medio: 0, dificil: 0 });
      d[f.dificuldade] = (d[f.dificuldade] || 0) + 1;
    }
  }
  return { themeCounts, difficultyCounts };
}

export async function fetchFlashcardsByTheme(supabase, tema) {
  return selectFlashcards(supabase, (q) => q.eq("tema", tema));
}

// Pagina a consulta: o PostgREST corta a resposta em 1000 linhas por
// padrão, e o app já passou disso (1045 flashcards) — sem paginação, os
// últimos ~45 flashcards ficavam invisíveis pra missão diária e estatísticas.
export async function fetchAllFlashcards(supabase) {
  const pageSize = 1000;
  let all = [];
  let from = 0;
  while (true) {
    const data = await selectFlashcards(supabase, (q) => q.order("id").range(from, from + pageSize - 1));
    all = all.concat(data);
    if (data.length < pageSize) break;
    from += pageSize;
  }
  return all;
}

export async function fetchFlashcardsByIds(supabase, ids) {
  if (!ids.length) return [];
  return inChunks(ids, (chunk) => selectFlashcards(supabase, (q) => q.in("id", chunk)));
}

export async function recordFlashcardView(supabase, userId, flashcardId) {
  const { error } = await supabase.from("user_flashcard_views").insert({ user_id: userId, flashcard_id: flashcardId });
  if (error) throw error;
}
