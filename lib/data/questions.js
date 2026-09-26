export async function fetchAllQuestions(supabase) {
  const { data, error } = await supabase
    .from("questions")
    .select("id, tema, ano, instituicao, enunciado, comentario, imagem_url");
  if (error) throw error;
  return data;
}

export function deriveFilterOptions(allQuestions) {
  const temas = [...new Set(allQuestions.map((q) => q.tema))].sort();
  const anos = [...new Set(allQuestions.map((q) => q.ano))].sort((a, b) => a - b);
  const instituicoes = [...new Set(allQuestions.map((q) => q.instituicao))].sort();
  return { temas, anos, instituicoes };
}

export function applyQuestionFilters(allQuestions, filters, favoriteIds) {
  return allQuestions.filter((q) => {
    if (filters.temas.length && !filters.temas.includes(q.tema)) return false;
    if (filters.anos.length && !filters.anos.includes(q.ano)) return false;
    if (filters.instituicoes.length && !filters.instituicoes.includes(q.instituicao)) return false;
    if (filters.favoritasOnly && !favoriteIds.includes(q.id)) return false;
    return true;
  });
}

// Nunca inclui a coluna `correta` aqui — a correção sempre passa pela RPC
// record_answer, para não expor o gabarito antes de o usuário responder.
export async function fetchOptionsForQuestions(supabase, questionIds) {
  if (!questionIds.length) return {};
  const { data, error } = await supabase
    .from("question_options")
    .select("id, question_id, letra, texto")
    .in("question_id", questionIds);
  if (error) throw error;
  const byQuestion = {};
  for (const o of data) {
    (byQuestion[o.question_id] ||= []).push(o);
  }
  for (const qid in byQuestion) byQuestion[qid].sort((a, b) => a.letra.localeCompare(b.letra));
  return byQuestion;
}

// Usado só na revisão final do Modo Prova, depois que a sessão já terminou —
// inclui `correta` para montar o gabarito de questões não respondidas também.
export async function fetchOptionsWithAnswerKey(supabase, questionIds) {
  if (!questionIds.length) return {};
  const { data, error } = await supabase
    .from("question_options")
    .select("id, question_id, letra, texto, correta")
    .in("question_id", questionIds);
  if (error) throw error;
  const byQuestion = {};
  for (const o of data) {
    (byQuestion[o.question_id] ||= []).push(o);
  }
  for (const qid in byQuestion) byQuestion[qid].sort((a, b) => a.letra.localeCompare(b.letra));
  return byQuestion;
}

export async function fetchAttemptHistory(supabase, userId, questionIds) {
  if (!questionIds.length) return {};
  const { data, error } = await supabase
    .from("user_question_attempts")
    .select("question_id, selected_option, correct, answered_at")
    .eq("user_id", userId)
    .in("question_id", questionIds)
    .order("answered_at");
  if (error) throw error;
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
  return data[0];
}

export async function fetchFavoriteIds(supabase, userId) {
  const { data, error } = await supabase.from("user_favorites").select("question_id").eq("user_id", userId);
  if (error) throw error;
  return data.map((r) => r.question_id);
}

export async function setFavorite(supabase, userId, questionId, shouldFavorite) {
  if (shouldFavorite) {
    const { error } = await supabase
      .from("user_favorites")
      .insert({ user_id: userId, question_id: questionId });
    if (error && error.code !== "23505") throw error;
  } else {
    const { error } = await supabase
      .from("user_favorites")
      .delete()
      .eq("user_id", userId)
      .eq("question_id", questionId);
    if (error) throw error;
  }
}
