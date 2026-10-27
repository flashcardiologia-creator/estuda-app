import { NextResponse } from "next/server";
import { createClient } from "@supabase/supabase-js";
import { clientIp } from "@/lib/clientIp";

// Quiz de boas-vindas da tela de entrada (supabase/quiz_boas_vindas.sql). A tentativa fica gravada pelo IP de quem
// respondeu: atualizar a página não dá outra chance, a pessoa vê o mesmo resultado.
// Fica em /auth/* porque o proxy só libera rotas sem login sob /auth e /login.
// O IP vem dos cabeçalhos da requisição (nunca do navegador), então cada visitante só mexe na tentativa do próprio IP.
// Qualquer falha (variável ausente, SQL ainda não rodado, banco fora do ar) responde { erro: true } e o quiz não aparece.

const NO_STORE = { "Cache-Control": "no-store" };
const FAIL = () => NextResponse.json({ erro: true }, { headers: NO_STORE });

function adminClient() {
  if (!process.env.SUPABASE_SERVICE_ROLE_KEY || !process.env.NEXT_PUBLIC_SUPABASE_URL) return null;
  return createClient(process.env.NEXT_PUBLIC_SUPABASE_URL, process.env.SUPABASE_SERVICE_ROLE_KEY, { auth: { persistSession: false } });
}

// { feito: false, quiz } quando este IP ainda não respondeu; { feito: true, id, resultado, quiz } quando já respondeu.
export async function GET(request) {
  const admin = adminClient();
  if (!admin) return FAIL();
  try {
    const ip = clientIp(request.headers);
    const quizRes = await admin.rpc("quiz_boas_vindas_questoes");
    if (quizRes.error || !quizRes.data?.questoes?.length) return FAIL();
    const quiz = quizRes.data;
    const tryRes = await admin.rpc("quiz_boas_vindas_tentativa", { p_ip: ip });
    if (tryRes.error) return FAIL();
    if (tryRes.data?.id) return NextResponse.json({ feito: true, id: tryRes.data.id, resultado: tryRes.data.resultado, quiz }, { headers: NO_STORE });
    return NextResponse.json({ feito: false, quiz }, { headers: NO_STORE });
  } catch {
    return FAIL();
  }
}

// Corpo: { respostas: { "1": "A", "2": "C", "3": "B" } }. Devolve { id, jaTinha, resultado }; se o IP já tinha
// tentativa, as respostas novas são ignoradas e volta a antiga.
export async function POST(request) {
  const admin = adminClient();
  if (!admin) return FAIL();
  try {
    const body = await request.json().catch(() => null);
    const respostas = body?.respostas && typeof body.respostas === "object" ? body.respostas : {};
    const ip = clientIp(request.headers);
    const { data, error } = await admin.rpc("quiz_boas_vindas_registrar", { p_ip: ip, p_respostas: respostas });
    if (error || !data?.id) return FAIL();
    return NextResponse.json({ id: data.id, jaTinha: !!data.ja_tinha, resultado: data.resultado }, { headers: NO_STORE });
  } catch {
    return FAIL();
  }
}
