// Sessões antigas de questões (as últimas 50 por pessoa). Guardadas na tabela
// question_sessions (supabase/add_question_sessions.sql). Se a tabela ainda não
// existir, tudo aqui falha em silêncio e o app funciona sem o histórico.

export const MAX_SESSIONS = 50;

const LIST_COLS = "id, created_at, updated_at, filters, total, answered, finished";

// Só o necessário dos filtros para mostrar na lista e restaurar o modo.
export function compactFilters(filters) {
  return {
    temas: filters.temas || [],
    anos: filters.anos || [],
    instituicoes: filters.instituicoes || [],
    favoritasOnly: !!filters.favoritasOnly,
    modoProva: !!filters.modoProva,
    mostrarAntigas: !!filters.mostrarAntigas,
  };
}

// Quantas questões foram respondidas NESTA sessão (respostas antigas já abertas
// "pré-preenchidas" não contam).
export function countAnswered(session) {
  return session.ids.filter((id) => session.answers?.[id] && !session.prefilled?.[id]).length;
}

// Andamento enxuto: índice atual, alternativas riscadas e, por questão
// respondida, { s: marcada, c: acertou, o: alternativa correta, p: pré-preenchida }.
export function packProgress(session) {
  const answers = {};
  for (const [qid, a] of Object.entries(session.answers || {})) {
    if (!a) continue;
    answers[qid] = { s: a.selected, c: !!a.correct, o: a.correct_option ?? null, p: session.prefilled?.[qid] ? 1 : 0 };
  }
  return { index: session.index || 0, struck: session.struck || {}, answers };
}

export function unpackProgress(progress, validIds) {
  const valid = new Set(validIds);
  const answers = {};
  const selected = {};
  const prefilled = {};
  for (const [qid, a] of Object.entries(progress?.answers || {})) {
    if (!valid.has(qid)) continue;
    answers[qid] = { selected: a.s, correct: !!a.c, correct_option: a.o };
    selected[qid] = a.s;
    if (a.p) prefilled[qid] = true;
  }
  const struck = {};
  for (const [qid, list] of Object.entries(progress?.struck || {})) if (valid.has(qid)) struck[qid] = list;
  return { answers, selected, prefilled, struck, index: Math.min(progress?.index || 0, Math.max(0, validIds.length - 1)) };
}

export async function fetchQuestionSessions(supabase, userId) {
  const { data, error } = await supabase
    .from("question_sessions")
    .select(LIST_COLS)
    .eq("user_id", userId)
    .order("updated_at", { ascending: false })
    .limit(MAX_SESSIONS);
  if (error) return [];
  return data || [];
}

export async function fetchQuestionSessionFull(supabase, id) {
  const { data, error } = await supabase
    .from("question_sessions")
    .select("id, filters, question_ids, progress, total, answered, finished")
    .eq("id", id)
    .single();
  if (error) throw error;
  return data;
}

// Retorna o id da sessão criada, ou null se não foi possível guardar.
export async function createQuestionSession(supabase, userId, { filters, ids, progress, answered }) {
  const { data, error } = await supabase
    .from("question_sessions")
    .insert({ user_id: userId, filters: compactFilters(filters), question_ids: ids, progress, total: ids.length, answered })
    .select("id")
    .single();
  if (error) return null;
  return data.id;
}

export async function deleteQuestionSession(supabase, id) {
  const { error } = await supabase.from("question_sessions").delete().eq("id", id);
  if (error) throw error;
}

export async function saveQuestionSession(supabase, id, { progress, answered, finished }) {
  await supabase.from("question_sessions").update({ progress, answered, finished: !!finished }).eq("id", id);
}
