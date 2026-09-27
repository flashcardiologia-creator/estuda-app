export async function reportContentIssue(supabase, userId, itemType, itemId, reason, details) {
  const { error } = await supabase.from("content_reports").insert({
    user_id: userId,
    item_type: itemType,
    item_id: itemId,
    reason,
    details: details || null,
  });
  if (error) throw error;
}
