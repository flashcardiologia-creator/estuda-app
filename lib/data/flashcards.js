export async function fetchFlashcardThemeCounts(supabase) {
  const data = await fetchAllFlashcards(supabase);
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

// Pagina a consulta: o PostgREST corta a resposta em 1000 linhas por
// padrão, e o app já passou disso (1045 flashcards) — sem paginação, os
// últimos ~45 flashcards ficavam invisíveis pra missão diária e estatísticas.
export async function fetchAllFlashcards(supabase) {
  const pageSize = 1000;
  let all = [];
  let from = 0;
  while (true) {
    const { data, error } = await supabase
      .from("flashcards")
      .select("id, tema, pergunta, resposta")
      .order("id")
      .range(from, from + pageSize - 1);
    if (error) throw error;
    all = all.concat(data);
    if (data.length < pageSize) break;
    from += pageSize;
  }
  return all;
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
