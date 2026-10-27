import { NextResponse } from "next/server";
import { createClient } from "@supabase/supabase-js";
import { clientIp } from "@/lib/clientIp";

// Diz se o anúncio do cupom (tela de login) deve aparecer para quem abriu o site: não aparece quando o IP
// de quem acessa já tem conta, ou seja, já aceitou os Termos de Uso no cadastro (tabela terms_acceptances).
// Fica em /auth/* porque o proxy só libera rotas sem login sob /auth e /login.
// O IP vem dos cabeçalhos da requisição (nunca do navegador), então só dá para consultar o do próprio visitante.
// Qualquer falha (variável ausente, banco fora do ar, IP desconhecido) mostra o anúncio: o pior caso é um anúncio a mais.

export async function GET(request) {
  const headers = { "Cache-Control": "no-store" };
  const ip = clientIp(request.headers);
  if (!ip || !process.env.SUPABASE_SERVICE_ROLE_KEY || !process.env.NEXT_PUBLIC_SUPABASE_URL) {
    return NextResponse.json({ mostrar: true }, { headers });
  }
  try {
    const admin = createClient(process.env.NEXT_PUBLIC_SUPABASE_URL, process.env.SUPABASE_SERVICE_ROLE_KEY, { auth: { persistSession: false } });
    // Cadastros antigos guardaram um IP de servidor em ip_address; o IP real do visitante é o primeiro item de ip_chain.
    const [byIp, byChain] = await Promise.all([
      admin.from("terms_acceptances").select("id").eq("ip_address", ip).limit(1),
      admin.from("terms_acceptances").select("id").like("ip_chain", `${ip},%`).limit(1),
    ]);
    if (byIp.error || byChain.error) return NextResponse.json({ mostrar: true }, { headers });
    return NextResponse.json({ mostrar: !(byIp.data?.length || byChain.data?.length) }, { headers });
  } catch {
    return NextResponse.json({ mostrar: true }, { headers });
  }
}
