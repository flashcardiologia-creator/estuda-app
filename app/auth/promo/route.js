import { NextResponse } from "next/server";
import { createClient } from "@supabase/supabase-js";

// Diz se o anúncio do cupom (tela de login) deve aparecer para quem abriu o site: não aparece quando o IP
// de quem acessa já tem conta, ou seja, já aceitou os Termos de Uso no cadastro (tabela terms_acceptances).
// Fica em /auth/* porque o proxy só libera rotas sem login sob /auth e /login.
// O IP vem dos cabeçalhos da requisição (nunca do navegador), então só dá para consultar o do próprio visitante.
// Qualquer falha (variável ausente, banco fora do ar, IP desconhecido) mostra o anúncio: o pior caso é um anúncio a mais.

function clientIp(headers) {
  const direct = headers.get("x-nf-client-connection-ip") || headers.get("x-real-ip");
  const chain = headers.get("x-forwarded-for");
  const first = chain ? chain.split(",")[0].trim() : null;
  const ip = (direct || first || "").trim().slice(0, 64);
  return ip || null;
}

export async function GET(request) {
  const headers = { "Cache-Control": "no-store" };
  const ip = clientIp(request.headers);
  if (!ip || !process.env.SUPABASE_SERVICE_ROLE_KEY || !process.env.NEXT_PUBLIC_SUPABASE_URL) {
    return NextResponse.json({ mostrar: true }, { headers });
  }
  try {
    const admin = createClient(process.env.NEXT_PUBLIC_SUPABASE_URL, process.env.SUPABASE_SERVICE_ROLE_KEY, { auth: { persistSession: false } });
    const { data, error } = await admin.from("terms_acceptances").select("id").eq("ip_address", ip).limit(1);
    if (error) return NextResponse.json({ mostrar: true }, { headers });
    return NextResponse.json({ mostrar: !(data && data.length) }, { headers });
  } catch {
    return NextResponse.json({ mostrar: true }, { headers });
  }
}
