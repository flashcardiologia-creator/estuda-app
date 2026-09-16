export async function fetchChallenges(supabase, userId) {
  await supabase.rpc("expire_my_challenges");

  const { data, error } = await supabase
    .from("challenges")
    .select("id, from_user, to_user, tema, qtd, status, created_at, expires_at")
    .or(`from_user.eq.${userId},to_user.eq.${userId}`)
    .order("created_at", { ascending: false });
  if (error) throw error;
  if (!data.length) return [];

  const userIds = [...new Set(data.flatMap((c) => [c.from_user, c.to_user]))];
  const { data: profiles, error: e2 } = await supabase.rpc("get_profile_names", { p_ids: userIds });
  if (e2) throw e2;
  const nameOf = Object.fromEntries(profiles.map((p) => [p.id, p.name]));

  const { data: answers, error: e3 } = await supabase
    .from("challenge_answers")
    .select("challenge_id, user_id, correct")
    .in("challenge_id", data.map((c) => c.id));
  if (e3) throw e3;

  return data.map((c) => {
    const theirUserId = c.from_user === userId ? c.to_user : c.from_user;
    const mine = answers.filter((a) => a.challenge_id === c.id && a.user_id === userId);
    const theirs = answers.filter((a) => a.challenge_id === c.id && a.user_id === theirUserId);
    return {
      ...c,
      fromName: nameOf[c.from_user] || "?",
      toName: nameOf[c.to_user] || "?",
      isMine: c.from_user === userId,
      myAnswered: mine.length,
      myCorrect: mine.filter((a) => a.correct).length,
      theirAnswered: theirs.length,
      theirCorrect: theirs.filter((a) => a.correct).length,
    };
  });
}

export async function createChallenge(supabase, friendId, tema, qtd) {
  const { data, error } = await supabase.rpc("create_challenge", {
    p_friend_id: friendId,
    p_tema: tema,
    p_qtd: qtd,
  });
  if (error) throw error;
  return data;
}

export async function fetchChallengeQuestions(supabase, challengeId) {
  const { data, error } = await supabase
    .from("challenge_questions")
    .select("question_id, ordem")
    .eq("challenge_id", challengeId)
    .order("ordem");
  if (error) throw error;
  const ids = data.map((r) => r.question_id);
  if (!ids.length) return [];
  const { data: questions, error: e2 } = await supabase
    .from("questions")
    .select("id, tema, ano, instituicao, enunciado, comentario")
    .in("id", ids);
  if (e2) throw e2;
  const byId = Object.fromEntries(questions.map((q) => [q.id, q]));
  return ids.map((id) => byId[id]).filter(Boolean);
}

export async function fetchMyChallengeAnswers(supabase, challengeId, userId) {
  const { data, error } = await supabase
    .from("challenge_answers")
    .select("question_id, selected_option, correct")
    .eq("challenge_id", challengeId)
    .eq("user_id", userId);
  if (error) throw error;
  return data;
}

export async function recordChallengeAnswer(supabase, challengeId, questionId, selectedOption) {
  const { data, error } = await supabase.rpc("record_challenge_answer", {
    p_challenge_id: challengeId,
    p_question_id: questionId,
    p_selected_option: selectedOption,
  });
  if (error) throw error;
  return data[0];
}
