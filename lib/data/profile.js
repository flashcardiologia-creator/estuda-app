export async function fetchProfile(supabase, userId) {
  const { data, error } = await supabase
    .from("profiles")
    .select("id, name, streak, last_mission_date")
    .eq("id", userId)
    .single();
  if (error) throw error;
  return data;
}

export async function updateDisplayName(supabase, userId, name) {
  const { error } = await supabase.from("profiles").update({ name }).eq("id", userId);
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
