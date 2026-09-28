export async function fetchProfile(supabase, userId) {
  const { data, error } = await supabase
    .from("profiles")
    .select(
      "id, name, streak, best_streak, last_mission_date, friend_code, stats_visible_to_friends, ranking_visible, question_font_size, flashcard_font_size"
    )
    .eq("id", userId)
    .single();
  if (error) throw error;
  return data;
}

export async function updateDisplayName(supabase, userId, name) {
  const { error } = await supabase.from("profiles").update({ name }).eq("id", userId);
  if (error) throw error;
}

export async function updateStatsVisibility(supabase, userId, visible) {
  const { error } = await supabase
    .from("profiles")
    .update({ stats_visible_to_friends: visible })
    .eq("id", userId);
  if (error) throw error;
}

export async function updateRankingVisibility(supabase, userId, visible) {
  const { error } = await supabase
    .from("profiles")
    .update({ ranking_visible: visible })
    .eq("id", userId);
  if (error) throw error;
}

export async function updateQuestionFontSize(supabase, userId, fontSize) {
  const { error } = await supabase
    .from("profiles")
    .update({ question_font_size: fontSize })
    .eq("id", userId);
  if (error) throw error;
}

export async function updateFlashcardFontSize(supabase, userId, fontSize) {
  const { error } = await supabase
    .from("profiles")
    .update({ flashcard_font_size: fontSize })
    .eq("id", userId);
  if (error) throw error;
}

export async function fetchStats(supabase, userId) {
  const { count: answered, error: e1 } = await supabase
    .from("user_question_attempts")
    .select("*", { count: "exact", head: true })
    .eq("user_id", userId);
  if (e1) throw e1;

  const { count: correct, error: e2 } = await supabase
    .from("user_question_attempts")
    .select("*", { count: "exact", head: true })
    .eq("user_id", userId)
    .eq("correct", true);
  if (e2) throw e2;

  return {
    answered: answered || 0,
    accuracy: answered ? Math.round(((correct || 0) / answered) * 100) : 0,
  };
}
