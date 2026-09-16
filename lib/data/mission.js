import { shuffle, todayStr } from "@/lib/util";
import { fetchAllFlashcards } from "@/lib/data/flashcards";

export async function fetchDailyMissionItems(supabase, userId) {
  const today = todayStr();

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
    const chosenSet = new Set(chosenIds);
    const pool = allQuestions.map((q) => q.id).filter((id) => !dormantIds.has(id) && !chosenSet.has(id));
    const need = 5 - chosenIds.length;
    chosenIds = [...chosenIds, ...shuffle(pool).slice(0, need)];
  }

  const { data: questions, error: e3 } = await supabase
    .from("questions")
    .select("id, tema, ano, instituicao, enunciado, comentario")
    .in("id", chosenIds);
  if (e3) throw e3;
  const byId = Object.fromEntries(questions.map((q) => [q.id, q]));
  const orderedQuestions = chosenIds.map((id) => byId[id]).filter(Boolean);

  const allFlashcards = await fetchAllFlashcards(supabase);
  const flashcards = shuffle(allFlashcards).slice(0, 5);

  return { questions: orderedQuestions, flashcards };
}

export async function completeDailyMission(supabase) {
  const { data, error } = await supabase.rpc("complete_daily_mission");
  if (error) throw error;
  return data[0];
}
