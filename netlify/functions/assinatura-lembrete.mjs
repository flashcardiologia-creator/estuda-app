// Função agendada do Netlify: lembretes de vencimento da assinatura, todo dia às 9h de Brasília (12:00 UTC;
// o Brasil não tem horário de verão). Nos dias 7, 3, 1 e 0 antes de a assinatura acabar:
//   1) o banco envia o e-mail (send_expiry_reminders, supabase/lembrete_vencimento.sql) e devolve quem foi avisado;
//   2) esta função manda a notificação no celular só para essas pessoas, se elas ativaram os lembretes.
// Precisa das variáveis do Netlify: VAPID_PRIVATE_KEY, SUPABASE_SERVICE_ROLE_KEY e NEXT_PUBLIC_SUPABASE_URL.
import { createClient } from "@supabase/supabase-js";
import { configurePush, sendPush } from "../../lib/pushServer.js";

const PARALLEL = 20;

function payloadFor(days) {
  const title = days === 0 ? "Sua assinatura vence hoje" : days === 1 ? "Sua assinatura vence amanhã" : `Sua assinatura vence em ${days} dias`;
  return {
    title,
    body: "Toque para prolongar e não perder nenhum dia.",
    tag: "assinatura-vencimento",
    url: "/?prolongar=1",
  };
}

export default async () => {
  const supabase = createClient(process.env.NEXT_PUBLIC_SUPABASE_URL, process.env.SUPABASE_SERVICE_ROLE_KEY, {
    auth: { persistSession: false },
  });

  const { data: due, error } = await supabase.rpc("send_expiry_reminders");
  if (error) throw error;
  if (!due || !due.length) {
    console.log("assinatura-lembrete: ninguém para avisar hoje");
    return new Response(JSON.stringify({ avisados: 0, enviados: 0 }), { headers: { "content-type": "application/json" } });
  }

  let sent = 0;
  const gone = [];
  try {
    configurePush();
    const daysByUser = new Map(due.map((d) => [d.user_id, d.days_before]));
    const { data: subs, error: subsError } = await supabase
      .from("push_subscriptions")
      .select("id, user_id, endpoint, p256dh, auth")
      .in("user_id", [...daysByUser.keys()]);
    if (subsError) throw subsError;

    for (let i = 0; i < subs.length; i += PARALLEL) {
      const batch = subs.slice(i, i + PARALLEL);
      const results = await Promise.all(batch.map((s) => sendPush(s, payloadFor(daysByUser.get(s.user_id)))));
      results.forEach((r, j) => {
        if (r === "ok") sent++;
        else if (r === "gone") gone.push(batch[j].id);
      });
    }
    if (gone.length) await supabase.from("push_subscriptions").delete().in("id", gone);
  } catch (err) {
    // O e-mail já saiu; falha no aviso do celular não deve derrubar a função.
    console.error("assinatura-lembrete: falha no push:", err.message);
  }

  console.log(`assinatura-lembrete: avisados ${due.length}, notificações enviadas ${sent}, removidas ${gone.length}`);
  return new Response(JSON.stringify({ avisados: due.length, enviados: sent, removidos: gone.length }), {
    headers: { "content-type": "application/json" },
  });
};

export const config = { schedule: "0 12 * * *" };
