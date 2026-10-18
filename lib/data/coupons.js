// Cupom de boas-vindas (supabase/cupom_boas_vindas.sql). Qualquer falha aqui é silenciosa: se o SQL
// ainda não foi rodado, ou a consulta falhar, a janela simplesmente não aparece.

// Devolve { code, days, validUntil } se esta conta deve ver a janela do cupom, senão null.
export async function fetchCouponOffer(supabase) {
  try {
    const { data, error } = await supabase.rpc("my_coupon_offer");
    if (error) return null;
    const row = Array.isArray(data) ? data[0] : data;
    if (!row?.out_code) return null;
    return { code: row.out_code, days: row.out_days, validUntil: row.out_valid_until };
  } catch {
    return null;
  }
}

// "Agora não": a janela não volta mais para esta conta.
export async function dismissCouponOffer(supabase, code) {
  try {
    await supabase.rpc("dismiss_coupon_offer", { p_code: code });
  } catch {
    // sem rede: a janela pode voltar na próxima abertura
  }
}

// Ativa o cupom (mesma função do cupom digitado). Devolve { status, days, until }.
// status: "ok" | "invalido" | "expirado" | "ja_usado" | "erro"
export async function activateCoupon(supabase, code) {
  const { data, error } = await supabase.rpc("redeem_coupon", { p_code: code });
  const row = Array.isArray(data) ? data[0] : data;
  if (error || !row) return { status: "erro" };
  return { status: row.out_status, days: row.out_days, until: row.out_expires_at };
}
