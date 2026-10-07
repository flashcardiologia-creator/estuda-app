import { inChunks } from "./chunk";

// Colunas novas (dificuldade e imagem) vêm do SQL supabase/flashcards_dificuldade_imagem.sql.
// Se o SQL ainda não tiver sido rodado, cai para as colunas antigas em vez de quebrar o app.
const COLS_FULL = "id, tema, pergunta, resposta, dificuldade, imagem_url, imagem_credito, imagem_lado";
const COLS_BASE = "id, tema, pergunta, resposta";
let useFullCols = true;

async function selectFlashcards(supabase, build) {
  if (useFullCols) {
    const { data, error } = await build(supabase.from("flashcards").select(COLS_FULL));
    if (!error) return data;
    if (!/dificuldade|imagem_|42703|does not exist/i.test(`${error.code || ""} ${error.message || ""}`)) throw error;
    useFullCols = false;
  }
  const { data, error } = await build(supabase.from("flashcards").select(COLS_BASE));
  if (error) throw error;
  return data;
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
