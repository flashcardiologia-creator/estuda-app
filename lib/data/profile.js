const PROFILE_COLUMNS = "id, name, streak, best_streak, last_mission_date, friend_code, stats_visible_to_friends, ranking_visible, question_font_size, flashcard_font_size";

// A coluna bandages vem do SQL bandagem_sequencia.sql. Enquanto ele não foi rodado, a leitura cai para as colunas de antes
// (bandages = 0) em vez de quebrar o app.
export async function fetchProfile(supabase, userId) {
  const withBandages = await supabase.from("profiles").select(`${PROFILE_COLUMNS}, bandages`).eq("id", userId).single();
  if (!withBandages.error) return withBandages.data;
  if (!/bandages|42703|does not exist/i.test(`${withBandages.error.code || ""} ${withBandages.error.message || ""}`)) throw withBandages.error;
  const { data, error } = await supabase.from("profiles").select(PROFILE_COLUMNS).eq("id", userId).single();
  if (error) throw error;
  return { ...data, bandages: 0 };
}

export async function updateDisplayName(supabase, userId, name) {
  const { error } = await supabase.from("profiles").update({ name }).eq("id", userId);
  if (error) throw error;
}

// Tema (escuro/claro) guardado na conta, para seguir a pessoa entre aparelhos. Lido à parte do perfil para o
// app não quebrar se a coluna theme ainda não existir no banco: nesse caso devolve undefined (recurso desligado).
// null = a conta ainda não tem tema registrado.
export async function fetchAccountTheme(supabase, userId) {
  const { data, error } = await supabase.from("profiles").select("theme").eq("id", userId).single();
  if (error) return undefined;
  return data.theme === "dark" || data.theme === "light" ? data.theme : null;
}

export async function updateAccountTheme(supabase, userId, theme) {
  const { error } = await supabase.from("profiles").update({ theme }).eq("id", userId);
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

// streak só é recalculado quando a pessoa conclui uma missão (ou zerado
// ativamente se ela estava no meio de uma quando o dia virou) — se ela
// sumir por alguns dias sem abrir o app, o valor fica congelado. Chamado
// quando fetchProfile detecta essa situação, pra corrigir o valor salvo.
export async function resetStreak(supabase, userId) {
  const { error } = await supabase.from("profiles").update({ streak: 0 }).eq("id", userId);
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
