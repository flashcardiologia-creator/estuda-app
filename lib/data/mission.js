import { shuffle, todayStr } from "@/lib/util";
import { fetchAllFlashcards, fetchFlashcardsByIds } from "@/lib/data/flashcards";
import { fetchOptionsForQuestions } from "@/lib/data/questions";

async function pickTodaysItems(supabase, userId, today) {
  const { data: wrongRows, error: e1 } = await supabase
    .from("user_wrong_bank")
    .select("question_id, in_bank, dormant_until")
    .eq("user_id", userId);
  if (e1) throw e1;

  const dormantIds = new Set(
    wrongRows.filter((r) => r.dormant_until && r.dormant_until > today).map((r) => r.question_id)
  );
  const candidateIds = wrongRows
    .filter((r) => r.in_bank && (!r.dormant_until || r.dormant_until <= today))
    .map((r) => r.question_id);

  let chosenIds = shuffle(candidateIds).slice(0, 5);

  if (chosenIds.length < 5) {
    const { data: allQuestions, error: e2 } = await supabase.from("questions").select("id");
    if (e2) throw e2;
    const allIds = allQuestions.map((q) => q.id);
    const chosenSet = new Set(chosenIds);

    const freshPool = allIds.filter((id) => !dormantIds.has(id) && !chosenSet.has(id));
    let need = 5 - chosenIds.length;
    chosenIds = [...chosenIds, ...shuffle(freshPool).slice(0, need)];

    // Banco pequeno + muita dormência pode esgotar até esse plano B — a
    // dormência é só espaçamento, nunca deve travar a missão diária.
    if (chosenIds.length < 5) {
      const chosenSet2 = new Set(chosenIds);
      const anyPool = allIds.filter((id) => !chosenSet2.has(id));
      need = 5 - chosenIds.length;
      chosenIds = [...chosenIds, ...shuffle(anyPool).slice(0, need)];
    }
  }

  const allFlashcards = await fetchAllFlashcards(supabase);
  const flashcardIds = shuffle(allFlashcards.map((f) => f.id)).slice(0, 5);

  return { questionIds: chosenIds, flashcardIds };
}

export async function fetchDailyMissionItems(supabase, userId) {
  const today = todayStr();

  // A escolha de hoje fica gravada, pra continuar a mesma mesmo que o
  // usuário feche o app e volte (em qualquer dispositivo).
  const { data: existingPick, error: eSel } = await supabase
    .from("daily_mission_picks")
    .select("question_ids, flashcard_ids")
    .eq("user_id", userId)
    .eq("mission_date", today)
    .maybeSingle();
  if (eSel) throw eSel;

  let questionIds, flashcardIds;

  if (existingPick) {
    questionIds = existingPick.question_ids;
    flashcardIds = existingPick.flashcard_ids;
  } else {
    const picked = await pickTodaysItems(supabase, userId, today);
    questionIds = picked.questionIds;
    flashcardIds = picked.flashcardIds;

    const { error: eIns } = await supabase.from("daily_mission_picks").insert({
      user_id: userId,
      mission_date: today,
      question_ids: questionIds,
      flashcard_ids: flashcardIds,
    });
    if (eIns) {
      if (eIns.code !== "23505") throw eIns;
      // Outra aba/dispositivo gravou no mesmo instante — usa o que ficou salvo.
      const { data: raceWinner, error: eRace } = await supabase
        .from("daily_mission_picks")
        .select("question_ids, flashcard_ids")
        .eq("user_id", userId)
        .eq("mission_date", today)
        .single();
      if (eRace) throw eRace;
      questionIds = raceWinner.question_ids;
      flashcardIds = raceWinner.flashcard_ids;
    }
  }

  const [{ data: questions, error: e3 }, options, flashcardRows] = await Promise.all([
    supabase.from("questions").select("id, tema, ano, instituicao, enunciado, comentario, imagem_url").in("id", questionIds),
    fetchOptionsForQuestions(supabase, questionIds),
    fetchFlashcardsByIds(supabase, flashcardIds),
  ]);
  if (e3) throw e3;
  const byId = Object.fromEntries(questions.map((q) => [q.id, q]));
  const orderedQuestions = questionIds.map((id) => byId[id]).filter(Boolean);

  const flashcardsById = Object.fromEntries(flashcardRows.map((f) => [f.id, f]));
  const orderedFlashcards = flashcardIds.map((id) => flashcardsById[id]).filter(Boolean);

  return { questions: orderedQuestions, flashcards: orderedFlashcards, options };
}

export async function completeDailyMission(supabase) {
  const { data, error } = await supabase.rpc("complete_daily_mission");
  if (error) throw error;
  return data[0];
}

export async function expireDailyMission(supabase) {
  const { data, error } = await supabase.rpc("expire_daily_mission");
  if (error) throw error;
  return data[0];
}
