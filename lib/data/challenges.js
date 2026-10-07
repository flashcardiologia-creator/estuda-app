import { fetchOptionStats } from "@/lib/data/questions";

const CHALLENGE_COLS = "id, from_user, to_user, tema, qtd, status, created_at, expires_at";

// Participantes de cada desafio: vem de challenge_participants (desafios em
// grupo). Se o SQL add_group_challenges.sql ainda não tiver sido rodado, cai
// para o modelo antigo (quem criou + o convidado).
async function loadChallengeRows(supabase, userId) {
  const { data: mine, error: eMine } = await supabase
    .from("challenge_participants")
    .select("challenge_id")
    .eq("user_id", userId);
  if (!eMine) {
    const ids = [...new Set(mine.map((r) => r.challenge_id))];
    if (!ids.length) return { rows: [], participantsOf: {} };
    const [{ data: rows, error: e1 }, { data: parts, error: e2 }] = await Promise.all([
      supabase.from("challenges").select(CHALLENGE_COLS).in("id", ids).order("created_at", { ascending: false }),
      supabase.from("challenge_participants").select("challenge_id, user_id").in("challenge_id", ids),
    ]);
    if (e1) throw e1;
    if (e2) throw e2;
    const participantsOf = {};
    for (const p of parts) (participantsOf[p.challenge_id] ||= []).push(p.user_id);
    return { rows, participantsOf };
  }
  const { data: rows, error } = await supabase
    .from("challenges")
    .select(CHALLENGE_COLS)
    .or(`from_user.eq.${userId},to_user.eq.${userId}`)
    .order("created_at", { ascending: false });
  if (error) throw error;
  const participantsOf = Object.fromEntries(rows.map((c) => [c.id, [c.from_user, c.to_user]]));
  return { rows, participantsOf };
}

export async function fetchChallenges(supabase, userId) {
  await supabase.rpc("expire_my_challenges");

  const { rows: data, participantsOf } = await loadChallengeRows(supabase, userId);
  if (!data.length) return [];

  const userIds = [...new Set(data.flatMap((c) => [c.from_user, c.to_user, ...(participantsOf[c.id] || [])]))];
  const { data: profiles, error: e2 } = await supabase.rpc("get_profile_names", { p_ids: userIds });
  if (e2) throw e2;
  const nameOf = Object.fromEntries(profiles.map((p) => [p.id, p.name]));

  const { data: answers, error: e3 } = await supabase
    .from("challenge_answers")
    .select("challenge_id, user_id, correct")
    .in("challenge_id", data.map((c) => c.id));
  if (e3) throw e3;

  return data.map((c) => {
    const memberIds = [...new Set([c.from_user, ...(participantsOf[c.id] || [c.from_user, c.to_user])])];
    const participants = memberIds.map((id) => {
      const list = answers.filter((a) => a.challenge_id === c.id && a.user_id === id);
      return {
        id,
        name: nameOf[id] || "?",
        isMe: id === userId,
        answered: list.length,
        correct: list.filter((a) => a.correct).length,
      };
    });
    const me = participants.find((p) => p.isMe) || { answered: 0, correct: 0 };
    const others = participants.filter((p) => !p.isMe);
    return {
      ...c,
      fromName: nameOf[c.from_user] || "?",
      toName: nameOf[c.to_user] || "?",
      isMine: c.from_user === userId,
      participants,
      isGroup: participants.length > 2,
      myAnswered: me.answered,
      myCorrect: me.correct,
      // melhor resultado entre os outros participantes (em 1 contra 1, é o do adversário)
      theirAnswered: Math.max(0, ...others.map((p) => p.answered)),
      theirCorrect: Math.max(0, ...others.map((p) => p.correct)),
    };
  });
}

// friendIds: 1 a 3 amigos. Se o SQL de desafios em grupo ainda não existir e
// for só 1 amigo, usa a função antiga.
export async function createChallenge(supabase, friendIds, tema, qtd) {
  const ids = Array.isArray(friendIds) ? friendIds : [friendIds];
  const { data, error } = await supabase.rpc("create_challenge", {
    p_friend_ids: ids,
    p_tema: tema,
    p_qtd: qtd,
  });
  if (!error) return data;
  if (ids.length === 1 && /could not find the function|PGRST202/i.test(`${error.code || ""} ${error.message || ""}`)) {
    const legacy = await supabase.rpc("create_challenge", { p_friend_id: ids[0], p_tema: tema, p_qtd: qtd });
    if (legacy.error) {
      if (tema === "Todos" && /sem_questoes_no_tema/.test(legacy.error.message || "")) {
        throw new Error('A opção "Todos" ainda não está ativa no banco (falta rodar o SQL).');
      }
      throw legacy.error;
    }
    return legacy.data;
  }
  if (tema === "Todos" && /sem_questoes_no_tema/.test(error.message || "")) {
    throw new Error('A opção "Todos" ainda não está ativa no banco (falta rodar o SQL).');
  }
  throw new Error(friendlyChallengeError(error));
}

function friendlyChallengeError(err) {
  const msg = err.message || "";
  if (msg.includes("maximo_3_amigos")) return "Você pode chamar no máximo 3 amigos.";
  if (msg.includes("escolha_pelo_menos_um_amigo")) return "Escolha pelo menos 1 amigo.";
  if (msg.includes("limite_diario_atingido")) return "Você já criou 5 desafios hoje.";
  if (msg.includes("nao_e_amigo")) return "Só dá para desafiar quem é seu amigo.";
  if (msg.includes("sem_questoes_no_tema")) return "Esse tema não tem questões disponíveis.";
  if (/could not find the function|PGRST202/i.test(`${err.code || ""} ${msg}`)) {
    return "Desafios em grupo ainda não estão ativos no banco (falta rodar o SQL).";
  }
  return msg || "Não foi possível criar o desafio.";
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
    .select("id, tema, ano, instituicao, enunciado, comentario, comentario_completo, imagem_url")
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
  const optionStats = await fetchOptionStats(supabase, questionId).catch(() => ({}));
  return { ...data[0], optionStats };
}
