import { NextResponse } from "next/server";
import { createClient as createAdminClient } from "@supabase/supabase-js";
import { createClient } from "@/lib/supabase/server";
import { configurePush, reminderPayload, sendPush } from "@/lib/pushServer";

// Teste de notificação, só para os aparelhos de quem está logado.
//  - sem parâmetro: notificação de confirmação ao ativar os lembretes;
//  - ?modo=lembrete: o lembrete real da missão, lendo os aparelhos com a chave de serviço
//    (o mesmo caminho da função agendada), para conferir a configuração do Netlify.
export async function POST(request) {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) return NextResponse.json({ error: "unauthorized" }, { status: 401 });

  try {
    configurePush();
  } catch {
    return NextResponse.json({ error: "VAPID_PRIVATE_KEY não está configurada no Netlify" }, { status: 503 });
  }

  const real = new URL(request.url).searchParams.get("modo") === "lembrete";
  let reader = supabase;
  if (real) {
    if (!process.env.SUPABASE_SERVICE_ROLE_KEY) {
      return NextResponse.json({ error: "SUPABASE_SERVICE_ROLE_KEY não está configurada no Netlify" }, { status: 503 });
    }
    reader = createAdminClient(process.env.NEXT_PUBLIC_SUPABASE_URL, process.env.SUPABASE_SERVICE_ROLE_KEY, { auth: { persistSession: false } });
  }

  const { data: subs, error } = await reader.from("push_subscriptions").select("endpoint, p256dh, auth").eq("user_id", user.id);
  if (error) return NextResponse.json({ error: "Não consegui ler os aparelhos (a chave de serviço está certa e o SQL foi rodado?)" }, { status: 500 });
  if (!subs?.length) return NextResponse.json({ error: "Nenhum aparelho com lembrete ativado nesta conta" }, { status: 404 });

  const payload = real
    ? reminderPayload()
    : {
        title: "Lembretes ativados",
        body: "Você vai receber um aviso às 10h e às 22h se ainda não tiver feito a missão diária.",
        tag: "lembretes-ativados",
        url: "/",
      };
  const results = await Promise.all(subs.map((s) => sendPush(s, payload)));
  const sent = results.filter((r) => r === "ok").length;
  return NextResponse.json({ sent, aparelhos: subs.length }, { status: sent ? 200 : 502 });
}
