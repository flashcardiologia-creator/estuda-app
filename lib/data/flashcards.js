export async function fetchFlashcardThemeCounts(supabase) {
  const { data, error } = await supabase.from("flashcards").select("tema");
  if (error) throw error;
  const counts = {};
  for (const f of data) counts[f.tema] = (counts[f.tema] || 0) + 1;
  return counts;
}

export async function fetchFlashcardsByTheme(supabase, tema) {
  const { data, error } = await supabase
    .from("flashcards")
    .select("id, tema, pergunta, resposta")
    .eq("tema", tema);
  if (error) throw error;
  return data;
}

export async function fetchAllFlashcards(supabase) {
  const { data, error } = await supabase.from("flashcards").select("id, tema, pergunta, resposta");
  if (error) throw error;
  return data;
}

export async function fetchFlashcardsByIds(supabase, ids) {
  if (!ids.length) return [];
  const { data, error } = await supabase.from("flashcards").select("id, tema, pergunta, resposta").in("id", ids);
  if (error) throw error;
  return data;
}

export async function recordFlashcardView(supabase, userId, flashcardId) {
  const { error } = await supabase.from("user_flashcard_views").insert({ user_id: userId, flashcard_id: flashcardId });
  if (error) throw error;
}
