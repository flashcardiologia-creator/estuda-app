import { inChunks } from "./chunk";

// Pagina a consulta: o PostgREST corta a resposta em 1000 linhas por
// padrão — hoje são 449 questões, mas sem paginação isso voltaria a
// quebrar silenciosamente assim que o banco crescer além de 1000.
export async function fetchAllQuestions(supabase) {
  const pageSize = 1000;
  let all = [];
  let from = 0;
  while (true) {
    const { data, error } = await supabase
      .from("questions")
      .select("id, tema, ano, instituicao, enunciado, comentario, comentario_completo, imagem_url")
      .order("id")
      .range(from, from + pageSize - 1);
    if (error) throw error;
    all = all.concat(data);
    if (data.length < pageSize) break;
    from += pageSize;
  }
  return all;
}

// Instituições com subopções são gravadas como "GRUPO subopção" (ex.:
// "INCOR R+ Hemodinâmica") — o texto antes do primeiro espaço é o grupo.
// Instituições sem espaço (BP, DANTE, SUS-SP...) não têm subopções.
export function parseInstituicao(instituicao) {
  const i = instituicao.indexOf(" ");
  if (i < 0) return { group: instituicao, sub: null };
  return { group: instituicao.slice(0, i), sub: instituicao.slice(i + 1) };
}

// Subopções que já aparecem no filtro mesmo antes de existir qualquer
// questão importada pra elas.
const INSTITUICOES_FIXAS = ["INCOR R+ Transplante", "INCOR R+ Cardio-onco"];

// Ordem de exibição das subopções conhecidas; as demais vêm depois, em
// ordem alfabética.
const ORDEM_SUBOPCOES = ["R+ Hemodinâmica", "R+ Transplante", "R+ Cardio-onco"];

// Grupos que ficam fixos no topo da lista (logo abaixo de "Todos").
const GRUPOS_NO_TOPO = ["TEC"];

function compareInstituicoes(a, b) {
  const pa = parseInstituicao(a);
  const pb = parseInstituicao(b);
  const ta = GRUPOS_NO_TOPO.indexOf(pa.group);
  const tb = GRUPOS_NO_TOPO.indexOf(pb.group);
  if (ta >= 0 || tb >= 0) {
    if (ta !== tb) return ta < 0 ? 1 : tb < 0 ? -1 : ta - tb;
  }
  if (pa.group !== pb.group) return pa.group.localeCompare(pb.group);
  const ia = ORDEM_SUBOPCOES.indexOf(pa.sub);
  const ib = ORDEM_SUBOPCOES.indexOf(pb.sub);
  if (ia >= 0 && ib >= 0) return ia - ib;
  if (ia >= 0) return -1;
  if (ib >= 0) return 1;
  return (pa.sub || "").localeCompare(pb.sub || "");
}

export function deriveFilterOptions(allQuestions) {
  const temas = [...new Set(allQuestions.map((q) => q.tema))].sort();
  const anos = [...new Set(allQuestions.map((q) => q.ano))].sort((a, b) => a - b);
  const instituicoes = [...new Set([...allQuestions.map((q) => q.instituicao), ...INSTITUICOES_FIXAS])].sort(
    compareInstituicoes
  );
  return { temas, anos, instituicoes };
}

export function applyQuestionFilters(allQuestions, filters, favoriteIds) {
  return allQuestions.filter((q) => {
    if (filters.temas.length && !filters.temas.includes(q.tema)) return false;
    if (!filters.anos.includes(q.ano)) return false;
    if (!filters.instituicoes.includes(q.instituicao)) return false;
    if (filters.favoritasOnly && !favoriteIds.includes(q.id)) return false;
    return true;
  });
}

// Nunca inclui a coluna `correta` aqui — a correção sempre passa pela RPC
// record_answer, para não expor o gabarito antes de o usuário responder.
//
// Pagina a consulta: o PostgREST corta a resposta em 1000 linhas por padrão,
// e sessões grandes (ex.: "Todos" os temas, ~449 questões x 5 alternativas)
// passam disso facilmente — sem paginação, questões aleatórias ficavam sem
// nenhuma alternativa na tela.
export async function fetchOptionsForQuestions(supabase, questionIds) {
  if (!questionIds.length) return {};
  const pageSize = 1000;
  const all = await inChunks(questionIds, async (chunk) => {
    let rows = [];
    let from = 0;
    while (true) {
      const { data, error } = await supabase
        .from("question_options")
        .select("id, question_id, letra, texto")
        .in("question_id", chunk)
        .order("id")
        .range(from, from + pageSize - 1);
      if (error) throw error;
      rows = rows.concat(data);
      if (data.length < pageSize) break;
      from += pageSize;
    }
    return rows;
  });
  const byQuestion = {};
  for (const o of all) {
    (byQuestion[o.question_id] ||= []).push(o);
  }
  for (const qid in byQuestion) byQuestion[qid].sort((a, b) => a.letra.localeCompare(b.letra));
  return byQuestion;
}

// Usado só na revisão final do Modo Prova, depois que a sessão já terminou —
// inclui `correta` para montar o gabarito de questões não respondidas também.
export async function fetchOptionsWithAnswerKey(supabase, questionIds) {
  if (!questionIds.length) return {};
  const data = await inChunks(questionIds, async (chunk) => {
    const { data: rows, error } = await supabase
      .from("question_options")
      .select("id, question_id, letra, texto, correta")
      .in("question_id", chunk);
    if (error) throw error;
    return rows;
  });
  const byQuestion = {};
  for (const o of data) {
    (byQuestion[o.question_id] ||= []).push(o);
  }
  for (const qid in byQuestion) byQuestion[qid].sort((a, b) => a.letra.localeCompare(b.letra));
  return byQuestion;
}

export async function fetchAttemptHistory(supabase, userId, questionIds) {
  if (!questionIds.length) return {};
  const data = await inChunks(questionIds, async (chunk) => {
    const { data: rows, error } = await supabase
      .from("user_question_attempts")
      .select("question_id, selected_option, correct, answered_at")
      .eq("user_id", userId)
      .in("question_id", chunk)
      .order("answered_at");
    if (error) throw error;
    return rows;
  });
  data.sort((a, b) => (a.answered_at < b.answered_at ? -1 : a.answered_at > b.answered_at ? 1 : 0));
  const byQuestion = {};
  for (const r of data) {
    (byQuestion[r.question_id] ||= []).push({ selected: r.selected_option, correct: r.correct, date: r.answered_at });
  }
  return byQuestion;
}

export async function recordAnswer(supabase, questionId, selectedOption, isDaily) {
  const { data, error } = await supabase.rpc("record_answer", {
    p_question_id: questionId,
    p_selected_option: selectedOption,
    p_is_daily: !!isDaily,
  });
  if (error) throw error;
  const optionStats = await fetchOptionStats(supabase, questionId).catch(() => ({}));
  return { ...data[0], optionStats };
}

// Percentual de usuários (entre todos, não só o atual) que escolheram cada
// alternativa dessa questão — buscado de novo depois de cada resposta pra
// já incluir o clique que acabou de ser dado.
export async function fetchOptionStats(supabase, questionId) {
  const { data, error } = await supabase.rpc("get_option_stats", { p_question_id: questionId });
  if (error) throw error;
  const stats = {};
  for (const row of data) stats[row.letra] = { pct: row.pct, total: row.total };
  return stats;
}

export async function fetchFavoriteIds(supabase, userId) {
  const { data, error } = await supabase.from("user_favorites").select("question_id").eq("user_id", userId);
  if (error) throw error;
  return data.map((r) => r.question_id);
}

export async function setFavorite(supabase, userId, questionId, shouldFavorite) {
  if (shouldFavorite) {
    // upsert + ignoreDuplicates em vez de insert: se o estado local estiver
    // dessincronizado do banco (ex.: favoritada em outra aba/dispositivo),
    // não gera erro 409 de chave duplicada — só ignora silenciosamente.
    const { error } = await supabase
      .from("user_favorites")
      .upsert({ user_id: userId, question_id: questionId }, { ignoreDuplicates: true });
    if (error) throw error;
  } else {
    const { error } = await supabase
      .from("user_favorites")
      .delete()
      .eq("user_id", userId)
      .eq("question_id", questionId);
    if (error) throw error;
  }
}
