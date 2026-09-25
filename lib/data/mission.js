import { shuffle, todayStr } from "@/lib/util";
import { fetchAllFlashcards } from "@/lib/data/flashcards";
import { fetchOptionsForQuestions } from "@/lib/data/questions";

export async function fetchDailyMissionItems(supabase, userId) {
  const today = todayStr();

  const [{ data: wrongRows, error: e1 }, allFlashcards] = await Promise.all([
    supabase.from("user_wrong_bank").select("question_id, in_bank, dormant_until").eq("user_id", userId),
    fetchAllFlashcards(supabase),
  ]);
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

  const [{ data: questions, error: e3 }, options] = await Promise.all([
    supabase.from("questions").select("id, tema, ano, instituicao, enunciado, comentario").in("id", chosenIds),
    fetchOptionsForQuestions(supabase, chosenIds),
  ]);
  if (e3) throw e3;
  const byId = Object.fromEntries(questions.map((q) => [q.id, q]));
  const orderedQuestions = chosenIds.map((id) => byId[id]).filter(Boolean);

  const flashcards = shuffle(allFlashcards).slice(0, 5);

  return { questions: orderedQuestions, flashcards, options };
}

export async function completeDailyMission(supabase) {
  const { data, error } = await supabase.rpc("complete_daily_mission");
  if (error) throw error;
  return data[0];
}
