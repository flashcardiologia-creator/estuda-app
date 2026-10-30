import { NextResponse } from "next/server";
import { createClient as createAdmin } from "@supabase/supabase-js";
import { createClient } from "@/lib/supabase/server";
import { MP_API, PLANS, isPlan } from "@/lib/billing";

const DEFAULT_SITE = "https://www.flashcardiologia.com";

// Só aceita como endereço de retorno o próprio site (ou localhost, em teste): o cabeçalho Origin vem do
// navegador e não pode virar um endereço qualquer.
function trustedOrigin(origin) {
  try {
    const u = new URL(origin);
    const host = u.hostname;
    const configured = process.env.SITE_URL ? new URL(process.env.SITE_URL).hostname : null;
    if (host === "localhost" || host.endsWith("flashcardiologia.com") || (configured && host === configured)) return u.origin;
  } catch {
    // sem Origin válido
  }
  return null;
}

// Link de entrada de uso único para a volta do pagamento. O pagamento pode terminar em outro navegador
// ou fora do app instalado, onde o login não existe; com este link a pessoa volta logada, na tela de
// início. É gerado pelo próprio Supabase: vale uma vez e por pouco tempo. Devolve null se não der
// para gerar (aí a volta usa o endereço comum).
async function magicToken(email) {
  try {
    if (!process.env.NEXT_PUBLIC_SUPABASE_URL || !process.env.SUPABASE_SERVICE_ROLE_KEY) return null;
    const admin = createAdmin(process.env.NEXT_PUBLIC_SUPABASE_URL, process.env.SUPABASE_SERVICE_ROLE_KEY, {
      auth: { persistSession: false },
    });
    const { data, error } = await admin.auth.admin.generateLink({ type: "magiclink", email });
    return error ? null : data?.properties?.hashed_token || null;
  } catch (err) {
    console.error("[pagamento] não foi possível gerar o link de entrada:", err.message);
    return null;
  }
}
// Cria a cobrança no Mercado Pago (Checkout Pro) para quem está logado e devolve o link de pagamento.
// O valor vem de lib/billing.js, nunca do navegador. A liberação do acesso acontece no webhook
// (app/auth/mercadopago/route.js), quando o Mercado Pago confirma o pagamento.
export async function POST(request) {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) return NextResponse.json({ error: "unauthorized" }, { status: 401 });

  let body;
  try {
    body = await request.json();
  } catch {
    return NextResponse.json({ error: "invalid_body" }, { status: 400 });
  }
  if (!isPlan(body?.plan)) return NextResponse.json({ error: "invalid_plan" }, { status: 400 });
  const plan = PLANS[body.plan];

  // Cupom de preço (supabase/cupom_preco.sql): o banco confere e reserva um uso; o preço cobrado vem daí, nunca do navegador.
  let priceCents = plan.priceCents;
  let reservation = null;
  const couponCode = typeof body?.coupon === "string" ? body.coupon.trim().slice(0, 40) : "";
  if (couponCode) {
    try {
      const admin = createAdmin(process.env.NEXT_PUBLIC_SUPABASE_URL, process.env.SUPABASE_SERVICE_ROLE_KEY, { auth: { persistSession: false } });
      const { data, error } = await admin.rpc("reserve_price_coupon", { p_user_id: user.id, p_code: couponCode, p_plan: plan.id });
      const row = Array.isArray(data) ? data[0] : data;
      if (error || !row) {
        console.error("[pagamento] não foi possível reservar o cupom:", error?.message);
        return NextResponse.json({ error: "coupon_unavailable" }, { status: 503 });
      }
      if (row.out_status !== "ok") return NextResponse.json({ error: "coupon", status: row.out_status }, { status: 400 });
      priceCents = row.out_price_cents;
      reservation = row.out_reservation;
    } catch (err) {
      console.error("[pagamento] erro ao reservar o cupom:", err.message);
      return NextResponse.json({ error: "coupon_unavailable" }, { status: 503 });
    }
  }

  const token = process.env.MERCADOPAGO_ACCESS_TOKEN;
  if (!token) {
    console.error("[pagamento] MERCADOPAGO_ACCESS_TOKEN não configurada");
    return NextResponse.json({ error: "not_configured" }, { status: 503 });
  }

  // A volta do pagamento precisa cair no MESMO endereço em que a pessoa está logada: o login fica em
  // cookies de cada endereço (www.flashcardiologia.com não compartilha com o endereço do Netlify, por
  // exemplo). Por isso vale primeiro o endereço de onde veio o pedido (cabeçalho Origin).
  const site = (trustedOrigin(request.headers.get("origin")) || process.env.SITE_URL || DEFAULT_SITE).replace(/\/$/, "");
  // Os dois destinos de sucesso (aprovado e em análise) usam o mesmo link de entrada: só um deles é visitado.
  const entryToken = await magicToken(user.email);
  const backUrl = (status) =>
    entryToken
      ? `${site}/auth/confirm?token_hash=${encodeURIComponent(entryToken)}&type=magiclink&next=${encodeURIComponent(`/?pagamento=${status}`)}`
      : `${site}/?pagamento=${status}`;
  const preference = {
    items: [
      {
        id: plan.id,
        title: `FlashCardio - Plano ${plan.label} (${plan.days} dias)${reservation ? " com cupom" : ""}`,
        quantity: 1,
        currency_id: "BRL",
        unit_price: priceCents / 100,
      },
    ],
    payer: { email: user.email },
    // Quem pagou e o que comprou: o webhook lê isto para liberar o acesso.
    // Com cupom de preço, o terceiro item é o número da reserva do cupom (o webhook consome no pagamento aprovado).
    external_reference: reservation ? `${user.id}:${plan.id}:${reservation}` : `${user.id}:${plan.id}`,
    notification_url: `${site}/auth/mercadopago`,
    back_urls: {
      // Na volta do pagamento a pessoa entra sozinha (link de uso único, ver loginLink); se não for
      // possível gerar o link, volta para o endereço comum e o login vale se ela ainda estiver logada.
      success: backUrl("ok"),
      pending: backUrl("pendente"),
      failure: `${site}/?pagamento=erro`,
    },
    statement_descriptor: "FLASHCARDIO",
    // Só Pix e cartão: boleto e pagamento em lotérica demoram dias para confirmar.
    // Parcelamento no cartão limitado por plano (lib/billing.js). Os juros do parcelamento são do comprador: isso é configurado
    // na conta do Mercado Pago (Custos > pagamentos online), deixando "sem acréscimo" desligado.
    payment_methods: { excluded_payment_types: [{ id: "ticket" }, { id: "atm" }], installments: plan.maxInstallments },
  };
  // O retorno automático só funciona com endereço https público.
  if (site.startsWith("https://")) preference.auto_return = "approved";

  let res;
  try {
    res = await fetch(`${MP_API}/checkout/preferences`, {
      method: "POST",
      headers: { Authorization: `Bearer ${token}`, "Content-Type": "application/json" },
      body: JSON.stringify(preference),
    });
  } catch (err) {
    console.error("[pagamento] Mercado Pago inacessível:", err.message);
    return NextResponse.json({ error: "gateway_unreachable" }, { status: 502 });
  }
  if (!res.ok) {
    console.error("[pagamento] Mercado Pago recusou a cobrança:", res.status, (await res.text()).slice(0, 300));
    return NextResponse.json({ error: "gateway_error" }, { status: 502 });
  }
  const data = await res.json();
  const url = data.init_point;
  if (!url) return NextResponse.json({ error: "gateway_error" }, { status: 502 });
  // `id` abre o pagamento numa janela dentro do próprio site; `url` é o plano B (página do Mercado Pago).
  return NextResponse.json({ url, id: data.id });
}
