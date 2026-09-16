export async function fetchFriends(supabase, userId) {
  const { data, error } = await supabase.from("friendships").select("friend_id").eq("user_id", userId);
  if (error) throw error;
  const ids = data.map((r) => r.friend_id);
  if (!ids.length) return [];
  const { data: profiles, error: e2 } = await supabase.rpc("get_profile_names", { p_ids: ids });
  if (e2) throw e2;
  return profiles;
}

export async function addFriendByName(supabase, userId, name) {
  const { data: matches, error } = await supabase.rpc("search_profile_by_name", { p_name: name });
  if (error) throw error;
  if (!matches.length) throw new Error("Nenhum estudante encontrado com esse nome.");
  if (matches.length > 1) {
    throw new Error("Mais de um estudante com esse nome — peça para conferir o nome exato.");
  }
  const friend = matches[0];
  const { error: e2 } = await supabase
    .from("friendships")
    .insert({ user_id: userId, friend_id: friend.id });
  if (e2) {
    if (e2.code === "23505") throw new Error("Vocês já são amigos.");
    throw e2;
  }
  return friend;
}
