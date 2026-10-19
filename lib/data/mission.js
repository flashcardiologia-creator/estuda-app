import { shuffle, todayStr } from "@/lib/util";
import { fetchAllFlashcards, fetchFlashcardsByIds } from "@/lib/data/flashcards";
import { fetchOptionsForQuestions, fetchQuestionRows } from "@/lib/data/questions";
import { getDailyMode } from "@/lib/data/dailyMode";
import { isContentOpen, rpcMissing } from "@/lib/data/content";

async function pickTodaysItems(supabase, userId, today, mode) {
  // "mix": 5 questões + 5 flashcards; "questions": 10 questões (ver lib/data/dailyMode.js).
  // "free" (sem assinatura, só se a função do banco não existir): 3 questões e nenhum flashcard.
  const questionCount = mode === "free" ? 3 : mode === "questions" ? 10 : 5;
  const flashcardCount = mode === "questions" || mode === "free" ? 0 : 5;
  // Plano gratuito: as 3 questões são sorteadas de todo o banco, sem puxar as do banco de erradas.
  const { data: wrongRows, error: e1 } =
    mode === "free"
      ? { data: [], error: null }
      : await supabase.from("user_wrong_bank").select("question_id, in_bank, dormant_until").eq("user_id", userId);
  if (e1) throw e1;

  const dormantIds = new Set(
    wrongRows.filter((r) => r.dormant_until && r.dormant_until > today).map((r) => r.question_id)
  );
  const candidateIds = wrongRows
    .filter((r) => r.in_bank && (!r.dormant_until || r.dormant_until <= today))
    .map((r) => r.question_id);

  let chosenIds = shuffle(candidateIds).slice(0, questionCount);

  if (chosenIds.length < questionCount) {
    const { data: allQuestions, error: e2 } = await supabase.from("questions").select("id");
    if (e2) throw e2;
    const allIds = allQuestions.map((q) => q.id);
    const chosenSet = new Set(chosenIds);

    const freshPool = allIds.filter((id) => !dormantIds.has(id) && !chosenSet.has(id));
    let need = questionCount - chosenIds.length;
    chosenIds = [...chosenIds, ...shuffle(freshPool).slice(0, need)];

    // Banco pequeno + muita dormência pode esgotar até esse plano B — a
    // dormência é só espaçamento, nunca deve travar a missão diária.
    if (chosenIds.length < questionCount) {
      const chosenSet2 = new Set(chosenIds);
      const anyPool = allIds.filter((id) => !chosenSet2.has(id));
      need = questionCount - chosenIds.length;
      chosenIds = [...chosenIds, ...shuffle(anyPool).slice(0, need)];
    }
  }

  if (flashcardCount === 0) return { questionIds: chosenIds, flashcardIds: [] };

  // Prioriza flashcards dos mesmos temas das questões sorteadas hoje, pra
  // missão reforçar o mesmo assunto nos dois formatos. Completa com
  // flashcards de qualquer tema se não houver 5 suficientes nesses temas.
  const { data: chosenQuestions, error: e3 } = await supabase
    .from("questions")
    .select("id, tema")
    .in("id", chosenIds);
  if (e3) throw e3;
  const chosenTemas = [...new Set(chosenQuestions.map((q) => q.tema).filter(Boolean))];

  // Não sorteia flashcards que a pessoa mandou para a lixeira.
  const allFlashcards = await fetchAllFlashcards(supabase, { trash: true });
  let chosenFlashcards = shuffle(allFlashcards.filter((f) => chosenTemas.includes(f.tema))).slice(0, flashcardCount);

  if (chosenFlashcards.length < flashcardCount) {
    const chosenFlashcardSet = new Set(chosenFlashcards.map((f) => f.id));
    const restPool = allFlashcards.filter((f) => !chosenFlashcardSet.has(f.id));
    const need = flashcardCount - chosenFlashcards.length;
    chosenFlashcards = [...chosenFlashcards, ...shuffle(restPool).slice(0, need)];
  }

  const flashcardIds = chosenFlashcards.map((f) => f.id);

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

  // Sem assinatura o sorteio é feito no banco (pick_daily_mission), porque o app não lê o banco de
  // questões inteiro. Se a função ainda não existir, cai no sorteio daqui.
  let restricted = null;
  if (!existingPick && !isContentOpen(supabase)) {
    const { data, error } = await supabase.rpc("pick_daily_mission", { p_mode: await getDailyMode(supabase, userId) });
    if (error && !rpcMissing(error)) throw error;
    if (!error) restricted = data[0];
  }

  if (existingPick) {
    questionIds = existingPick.question_ids;
    flashcardIds = existingPick.flashcard_ids;
  } else if (restricted) {
    questionIds = restricted.question_ids;
    flashcardIds = restricted.flashcard_ids;
  } else {
    const picked = await pickTodaysItems(supabase, userId, today, isContentOpen(supabase) ? await getDailyMode(supabase, userId) : "free");
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

  const [questions, options, flashcardRows] = await Promise.all([
    fetchQuestionRows(supabase, questionIds),
    fetchOptionsForQuestions(supabase, questionIds),
    fetchFlashcardsByIds(supabase, flashcardIds),
  ]);
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
