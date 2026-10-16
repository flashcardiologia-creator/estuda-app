import { NextResponse } from "next/server";
import { createClient } from "@supabase/supabase-js";
import { MP_API, PLANS, isPlan } from "@/lib/billing";

// Aviso (webhook) do Mercado Pago: quando um pagamento muda de situação, ele chama esta rota.
// Não confiamos no aviso: pegamos o número do pagamento e perguntamos ao Mercado Pago, com o
// nosso token, qual é a situação real, o valor e de quem é. Só então liberamos o acesso.
// Fica em /auth/* porque o Mercado Pago chama sem login (o proxy só libera /auth e /login assim).
//
// Responder 200 = "recebi". Erro nosso ou do Mercado Pago responde 5xx para ele tentar de novo.
// Pagamento inválido ou que não é nosso responde 200 para ele parar de insistir.

const UUID = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;
const ok = (extra = {}) => NextResponse.json({ received: true, ...extra });

async function handle(request) {
  const url = new URL(request.url);
  let body = {};
  try {
    body = await request.json();
  } catch {
    // aviso no formato antigo vem só com parâmetros na URL
  }

  const topic = body?.type || body?.topic || url.searchParams.get("type") || url.searchParams.get("topic");
  const paymentId = String(body?.data?.id || url.searchParams.get("data.id") || (topic === "payment" ? url.searchParams.get("id") : "") || "");
  if (topic !== "payment" || !/^\d+$/.test(paymentId)) return ok({ ignored: true });

  const token = process.env.MERCADOPAGO_ACCESS_TOKEN;
  if (!token || !process.env.SUPABASE_SERVICE_ROLE_KEY) {
    console.error("[mercadopago] variáveis de ambiente faltando");
    return NextResponse.json({ error: "not_configured" }, { status: 503 });
  }

  let res;
  try {
    res = await fetch(`${MP_API}/v1/payments/${paymentId}`, { headers: { Authorization: `Bearer ${token}` } });
  } catch (err) {
    console.error("[mercadopago] não foi possível consultar o pagamento:", err.message);
    return NextResponse.json({ error: "gateway_unreachable" }, { status: 502 });
  }
  if (res.status === 404) return ok({ ignored: true });
  if (!res.ok) {
    console.error("[mercadopago] consulta do pagamento falhou:", res.status);
    return NextResponse.json({ error: "gateway_error" }, { status: 502 });
  }
  const pay = await res.json();

  const [userId, planId] = String(pay.external_reference || "").split(":");
  if (!UUID.test(userId || "") || !isPlan(planId)) return ok({ ignored: true });
  const plan = PLANS[planId];

  const admin = createClient(process.env.NEXT_PUBLIC_SUPABASE_URL, process.env.SUPABASE_SERVICE_ROLE_KEY, {
    auth: { persistSession: false },
  });
  const ref = `mp-${paymentId}`;

  if (pay.status === "approved") {
    const cents = Math.round(Number(pay.transaction_amount) * 100);
    if (pay.currency_id !== "BRL" || !(cents >= plan.priceCents)) {
      console.error("[mercadopago] valor diferente do plano, ignorado:", paymentId, pay.currency_id, pay.transaction_amount, planId);
      return ok({ ignored: true });
    }
    const { data: found, error: userError } = await admin.auth.admin.getUserById(userId);
    const email = found?.user?.email;
    if (userError || !email) {
      console.error("[mercadopago] usuário não encontrado para o pagamento", paymentId);
      return ok({ ignored: true });
    }
    // Quem pagou os juros do parcelamento: fee_payer "payer" = comprador (o esperado); "collector" = nós.
    // Fica anotado no pagamento e no log para conferir depois de um pagamento de teste.
    const installments = Number(pay.installments) || 1;
    const financing = (Array.isArray(pay.fee_details) ? pay.fee_details : []).filter((f) => /financ/i.test(String(f?.type || "")));
    const financingPayer = financing.length ? financing.map((f) => f.fee_payer).join("+") : "sem juros";
    const totalPaid = Number(pay.transaction_details?.total_paid_amount);
    const detail = `${installments}x; comprador pagou ${Number.isFinite(totalPaid) ? `R$ ${totalPaid.toFixed(2)}` : "?"}; juros: ${financingPayer}`;
    console.log(`[mercadopago] pagamento ${paymentId} aprovado: ${planId}, ${detail}`);
    if (financing.some((f) => f?.fee_payer === "collector")) {
      console.warn(`[mercadopago] ATENÇÃO: juros do parcelamento do pagamento ${paymentId} ficaram por conta do vendedor`);
    }

    // grant_access ignora o pagamento repetido (mesmo p_external_ref), então reenvios não dão dias extras.
    const { error } = await admin.rpc("grant_access", {
      p_email: email,
      p_plan: planId,
      p_paid_at: pay.date_approved || new Date().toISOString(),
      p_amount_cents: cents,
      p_method: "mercado_pago",
      p_external_ref: ref,
      p_days: null,
      p_notes: `Mercado Pago ${pay.payment_method_id || ""} #${paymentId}; ${detail}`.replace(/\s+/g, " ").trim(),
    });
    if (error) {
      console.error("[mercadopago] falha ao liberar acesso:", error.message);
      return NextResponse.json({ error: "grant_failed" }, { status: 500 });
    }
    return ok({ granted: true });
  }

  // Estorno ou disputa: tira o acesso desse pagamento.
  if (pay.status === "refunded" || pay.status === "charged_back" || pay.status === "cancelled") {
    const { error } = await admin
      .from("payments")
      .update({ status: pay.status === "cancelled" ? "cancelled" : "refunded" })
      .eq("external_ref", ref)
      .eq("status", "approved");
    if (error) {
      console.error("[mercadopago] falha ao registrar estorno:", error.message);
      return NextResponse.json({ error: "update_failed" }, { status: 500 });
    }
    return ok({ revoked: true });
  }

  return ok({ status: pay.status });
}

export const POST = handle;
export const GET = handle;
