export async function fetchFriends(supabase) {
  const { data, error } = await supabase.rpc("get_my_friends");
  if (error) throw error;
  return data;
}

function friendlyRequestError(err) {
  const msg = err.message || "";
  if (msg.includes("ja_sao_amigos")) return "Vocês já são amigos.";
  if (msg.includes("pedido_ja_enviado")) return "Você já enviou um pedido para essa pessoa.";
  if (msg.includes("nao_pode_adicionar_a_si_mesmo")) return "Você não pode adicionar a si mesmo.";
  return err.message || "Não foi possível enviar o pedido.";
}

// Retorna { status: "requested" | "accepted", friend }. "accepted" acontece
// quando a outra pessoa já tinha te enviado um pedido antes.
export async function addFriendByName(supabase, nameOrCode) {
  const isCode = /^\d{9}$/.test(nameOrCode.trim());
  const { data: matches, error } = isCode
    ? await supabase.rpc("search_profile_by_code", { p_code: nameOrCode.trim() })
    : await supabase.rpc("search_profile_by_name", { p_name: nameOrCode });
  if (error) throw error;
  if (!matches.length) {
    throw new Error(isCode ? "Nenhum estudante encontrado com esse código." : "Nenhum estudante encontrado com esse nome.");
  }
  if (matches.length > 1) {
    throw new Error("Mais de um estudante com esse nome — peça para conferir o nome exato, ou use o código dele.");
  }
  const friend = matches[0];
  const { data: status, error: e2 } = await supabase.rpc("send_friend_request", { p_target_id: friend.id });
  if (e2) throw new Error(friendlyRequestError(e2));
  return { status, friend };
}

export async function fetchIncomingFriendRequests(supabase) {
  const { data, error } = await supabase.rpc("get_incoming_friend_requests");
  if (error) throw error;
  return data;
}

export async function respondToFriendRequest(supabase, requesterId, accept) {
  const { error } = await supabase.rpc("respond_friend_request", {
    p_requester_id: requesterId,
    p_accept: accept,
  });
  if (error) throw error;
}

export async function removeFriend(supabase, friendId) {
  const { error } = await supabase.rpc("remove_friend", { p_friend_id: friendId });
  if (error) throw error;
}

export async function fetchFriendStats(supabase, friendId) {
  const { data, error } = await supabase.rpc("get_friend_stats", { p_friend_id: friendId });
  if (error) throw error;
  return data[0];
}

export async function fetchFriendsMissionStatus(supabase, friendIds) {
  if (!friendIds.length) return [];
  const { data, error } = await supabase.rpc("get_friends_mission_status", { p_friend_ids: friendIds });
  if (error) throw error;
  return data;
}
