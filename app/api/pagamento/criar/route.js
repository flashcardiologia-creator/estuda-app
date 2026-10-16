import { NextResponse } from "next/server";
import { createClient } from "@/lib/supabase/server";
import { MP_API, PLANS, isPlan } from "@/lib/billing";

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

  const token = process.env.MERCADOPAGO_ACCESS_TOKEN;
  if (!token) {
    console.error("[pagamento] MERCADOPAGO_ACCESS_TOKEN não configurada");
    return NextResponse.json({ error: "not_configured" }, { status: 503 });
  }

  const site = (process.env.SITE_URL || new URL(request.url).origin).replace(/\/$/, "");
  const preference = {
    items: [
      {
        id: plan.id,
        title: `FlashCardio - Plano ${plan.label} (${plan.days} dias)`,
        quantity: 1,
        currency_id: "BRL",
        unit_price: plan.priceCents / 100,
      },
    ],
    payer: { email: user.email },
    // Quem pagou e o que comprou: o webhook lê isto para liberar o acesso.
    external_reference: `${user.id}:${plan.id}`,
    notification_url: `${site}/auth/mercadopago`,
    back_urls: {
      success: `${site}/?pagamento=ok`,
      pending: `${site}/?pagamento=pendente`,
      failure: `${site}/?pagamento=erro`,
    },
    statement_descriptor: "FLASHCARDIO",
    // Só Pix e cartão: boleto e pagamento em lotérica demoram dias para confirmar.
    // Parcelamento no cartão em até 12x. Os juros do parcelamento são do comprador: isso é configurado
    // na conta do Mercado Pago (Custos > pagamentos online), deixando "sem acréscimo" desligado.
    payment_methods: { excluded_payment_types: [{ id: "ticket" }, { id: "atm" }], installments: 12 },
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
  return NextResponse.json({ url });
}
