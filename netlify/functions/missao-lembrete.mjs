// Função agendada do Netlify: lembrete da missão diária por notificação (push), às 10h e às 22h
// de Brasília (13:00 e 01:00 UTC; o Brasil não tem horário de verão). Avisa só quem ativou os
// lembretes e ainda não fez a missão de hoje. Precisa das variáveis de ambiente do Netlify:
// VAPID_PRIVATE_KEY, SUPABASE_SERVICE_ROLE_KEY e NEXT_PUBLIC_SUPABASE_URL.
import { createClient } from "@supabase/supabase-js";
import { appToday, configurePush, reminderPayload, sendPush } from "../../lib/pushServer.js";

const PAGE = 1000;
const CHUNK = 200;
const PARALLEL = 20;

async function fetchAll(build) {
  let out = [];
  for (let from = 0; ; from += PAGE) {
    const { data, error } = await build().range(from, from + PAGE - 1);
    if (error) throw error;
    out = out.concat(data);
    if (data.length < PAGE) break;
  }
  return out;
}

export default async () => {
  configurePush();
  const supabase = createClient(process.env.NEXT_PUBLIC_SUPABASE_URL, process.env.SUPABASE_SERVICE_ROLE_KEY, {
    auth: { persistSession: false },
  });

  const subs = await fetchAll(() => supabase.from("push_subscriptions").select("id, user_id, endpoint, p256dh, auth").order("id"));
  const userIds = [...new Set(subs.map((s) => s.user_id))];

  const doneToday = new Set();
  const today = appToday();
  for (let i = 0; i < userIds.length; i += CHUNK) {
    const { data, error } = await supabase.from("profiles").select("id, last_mission_date").in("id", userIds.slice(i, i + CHUNK));
    if (error) throw error;
    for (const p of data) if (p.last_mission_date === today) doneToday.add(p.id);
  }

  const pending = subs.filter((s) => !doneToday.has(s.user_id));
  const payload = reminderPayload();
  const gone = [];
  let sent = 0;
  for (let i = 0; i < pending.length; i += PARALLEL) {
    const batch = pending.slice(i, i + PARALLEL);
    const results = await Promise.all(batch.map((s) => sendPush(s, payload)));
    results.forEach((r, j) => {
      if (r === "ok") sent++;
      else if (r === "gone") gone.push(batch[j].id);
    });
  }
  if (gone.length) await supabase.from("push_subscriptions").delete().in("id", gone);

  console.log(`missao-lembrete: aparelhos ${subs.length}, já fizeram ${subs.length - pending.length}, enviados ${sent}, removidos ${gone.length}`);
  return new Response(JSON.stringify({ aparelhos: subs.length, enviados: sent, removidos: gone.length }), {
    headers: { "content-type": "application/json" },
  });
};

export const config = { schedule: "0 13,1 * * *" };
