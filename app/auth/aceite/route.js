import { createHash } from "node:crypto";
import { NextResponse } from "next/server";
import { createClient } from "@supabase/supabase-js";
import { createClient as createServerClient } from "@/lib/supabase/server";
import { ACCEPT_LABEL, LEGAL_VERSION, PRIVACY, TERMS } from "@/lib/legal/content";

// Registra o aceite dos Termos de Uso e da Política de Privacidade: no cadastro (context "signup")
// ou na tela de aceite exibida após o login (context "gate").
// Fica em /auth/* de propósito: logo após o cadastro ainda pode não haver sessão (o e-mail
// precisa ser confirmado), e o proxy só libera rotas sem login sob /auth e /login.
// O IP e o aparelho vêm dos cabeçalhos da requisição, nunca do corpo enviado pelo navegador.

const MAX_AGE_MS = 15 * 60 * 1000; // só aceita registrar para contas criadas há poucos minutos

const sha256 = (value) => createHash("sha256").update(JSON.stringify(value)).digest("hex");
const clip = (value, max) => (typeof value === "string" && value.trim() ? value.trim().slice(0, max) : null);

function clientIp(headers) {
  const direct = headers.get("x-nf-client-connection-ip") || headers.get("x-real-ip");
  const chain = headers.get("x-forwarded-for");
  const first = chain ? chain.split(",")[0].trim() : null;
  return { ip: clip(direct || first, 64), chain: clip(chain, 500) };
}

export async function POST(request) {
  let body;
  try {
    body = await request.json();
  } catch {
    return NextResponse.json({ error: "invalid_body" }, { status: 400 });
  }

  if (!process.env.SUPABASE_SERVICE_ROLE_KEY) {
    console.error("[aceite] SUPABASE_SERVICE_ROLE_KEY não configurada");
    return NextResponse.json({ error: "not_configured" }, { status: 503 });
  }
  const admin = createClient(process.env.NEXT_PUBLIC_SUPABASE_URL, process.env.SUPABASE_SERVICE_ROLE_KEY, {
    auth: { persistSession: false },
  });

  // Com sessão (tela de aceite após o login, ou cadastro sem confirmação de e-mail) a identidade
  // vem da sessão. Sem sessão (cadastro que exige confirmar o e-mail) vem do corpo, validada abaixo.
  const sessionClient = await createServerClient();
  const {
    data: { user: sessionUser },
  } = await sessionClient.auth.getUser();

  let user = sessionUser;
  const email = clip(body?.email, 320)?.toLowerCase();
  if (!user) {
    const userId = clip(body?.userId, 64);
    if (!userId || !email) return NextResponse.json({ error: "invalid_body" }, { status: 400 });

    // A conta precisa existir, ter esse e-mail e ter sido criada agora: impede registrar aceite
    // em nome de outra pessoa ou de uma conta antiga.
    const { data: found, error: userError } = await admin.auth.admin.getUserById(userId);
    user = found?.user;
    if (userError || !user || (user.email || "").toLowerCase() !== email) {
      return NextResponse.json({ error: "user_not_found" }, { status: 404 });
    }
    if (Date.now() - new Date(user.created_at).getTime() > MAX_AGE_MS) {
      return NextResponse.json({ error: "expired" }, { status: 403 });
    }
  }

  const headers = request.headers;
  const { ip, chain } = clientIp(headers);
  const row = {
    user_id: user.id,
    email: (user.email || email || "").toLowerCase(),
    user_name: clip(user.user_metadata?.name, 120),
    terms_version: LEGAL_VERSION,
    terms_hash: sha256(TERMS),
    privacy_hash: sha256(PRIVACY),
    consent_text: ACCEPT_LABEL,
    source: body?.context === "signup" ? "signup" : "gate",
    ip_address: ip,
    ip_chain: chain,
    user_agent: clip(headers.get("user-agent"), 500),
    accept_language: clip(headers.get("accept-language"), 200),
    origin: clip(headers.get("origin") || headers.get("referer"), 300),
    client_timezone: clip(body?.timezone, 80),
    client_language: clip(body?.language, 40),
    client_platform: clip(body?.platform, 80),
    client_screen: clip(body?.screen, 40),
    display_mode: clip(body?.displayMode, 30),
  };

  const { error } = await admin.from("terms_acceptances").insert(row);
  if (error) {
    // 23505 = já registrado para essa conta e versão: tratamos como sucesso.
    if (error.code === "23505") return NextResponse.json({ ok: true, duplicate: true });
    console.error("[aceite] falha ao gravar", error.message);
    return NextResponse.json({ error: "insert_failed" }, { status: 500 });
  }
  return NextResponse.json({ ok: true });
}
