import { dateStrAt, todayStr } from "@/lib/util";

function daysBetween(dateStrA, dateStrB) {
  const [ya, ma, da] = dateStrA.split("-").map(Number);
  const [yb, mb, db] = dateStrB.split("-").map(Number);
  const msPerDay = 24 * 60 * 60 * 1000;
  return Math.round((Date.UTC(yb, mb - 1, db) - Date.UTC(ya, ma - 1, da)) / msPerDay);
}

export async function fetchFullStats(supabase, userId, questionsById, flashcardsById, flashcardThemeCounts = {}) {
  const [{ data: attempts, error: e1 }, { data: views, error: e2 }] = await Promise.all([
    supabase.from("user_question_attempts").select("question_id, correct, answered_at").eq("user_id", userId),
    supabase.from("user_flashcard_views").select("flashcard_id, viewed_at").eq("user_id", userId),
  ]);
  if (e1) throw e1;
  if (e2) throw e2;

  const questionsByTema = {};
  for (const a of attempts) {
    const tema = questionsById[a.question_id]?.tema;
    if (!tema) continue;
    const bucket = (questionsByTema[tema] ||= { tema, total: 0, correct: 0 });
    bucket.total += 1;
    if (a.correct) bucket.correct += 1;
  }
  const temaQuestionStats = Object.values(questionsByTema)
    .map((b) => ({ ...b, accuracy: Math.round((b.correct / b.total) * 100) }))
    .sort((a, b) => b.total - a.total);

  const flashcardViewsByTema = {};
  for (const v of views) {
    const tema = flashcardsById[v.flashcard_id]?.tema;
    if (!tema) continue;
    (flashcardViewsByTema[tema] ||= new Set()).add(v.flashcard_id);
  }
  const flashcardThemes = new Set([...Object.keys(flashcardThemeCounts), ...Object.keys(flashcardViewsByTema)]);
  const temaFlashcardStats = [...flashcardThemes]
    .map((tema) => {
      const viewed = flashcardViewsByTema[tema]?.size || 0;
      const total = flashcardThemeCounts[tema] || 0;
      return { tema, viewed, total, pct: total ? Math.round((viewed / total) * 100) : 0 };
    })
    .sort((a, b) => b.viewed - a.viewed);

  const daysWithQuestions = new Set(attempts.map((a) => dateStrAt(new Date(a.answered_at))));
  const daysWithFlashcards = new Set(views.map((v) => dateStrAt(new Date(v.viewed_at))));
  const activeDaySet = new Set([...daysWithQuestions, ...daysWithFlashcards]);
  const activeDays = activeDaySet.size;

  const firstActiveDay = activeDays ? [...activeDaySet].sort()[0] : null;
  const totalDaysSpan = firstActiveDay ? daysBetween(firstActiveDay, todayStr()) + 1 : 0;
  const activeDaysPct = totalDaysSpan ? Math.round((activeDays / totalDaysSpan) * 100) : 0;

  return {
    totalQuestions: attempts.length,
    totalFlashcards: views.length,
    activeDays,
    totalDaysSpan,
    activeDaysPct,
    avgQuestionsPerDay: activeDays ? Math.round((attempts.length / activeDays) * 10) / 10 : 0,
    avgFlashcardsPerDay: activeDays ? Math.round((views.length / activeDays) * 10) / 10 : 0,
    temaQuestionStats,
    temaFlashcardStats,
  };
}
