export async function fetchLeaderboard(supabase) {
  const { data, error } = await supabase.rpc("get_leaderboard");
  if (error) throw error;
  return data;
}
