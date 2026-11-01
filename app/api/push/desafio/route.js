import { NextResponse } from "next/server";
import { createClient as createAdmin } from "@supabase/supabase-js";
import { createClient } from "@/lib/supabase/server";
import { challengePayload, configurePush, sendPush } from "@/lib/pushServer";

// Aviso "Você foi desafiado por NOME" para quem foi chamado num desafio novo. O app chama esta rota logo depois de
// criar o desafio. Só vale para quem criou o desafio e só nos primeiros minutos depois de criado; os convidados saem
// do banco (nunca do navegador). Quem não ativou as notificações não recebe nada, e qualquer falha só devolve sent: 0.
const FRESH_MS = 2 * 60 * 1000;
const DAY_S = 60 * 60 * 24;

export async function POST(request) {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) return NextResponse.json({ error: "unauthorized" }, { status: 401 });

  let challengeId = null;
  try {
    challengeId = (await request.json())?.challengeId;
  } catch {
    challengeId = null;
  }
  if (!challengeId || typeof challengeId !== "string") return NextResponse.json({ error: "bad request" }, { status: 400 });

  if (!process.env.SUPABASE_SERVICE_ROLE_KEY || !process.env.NEXT_PUBLIC_SUPABASE_URL) {
    return NextResponse.json({ error: "não configurado" }, { status: 503 });
  }
  try {
    configurePush();
  } catch {
    return NextResponse.json({ error: "push não configurado" }, { status: 503 });
  }

  // Lido com o login de quem chamou: só enxerga o desafio quem participa dele.
  const { data: challenge } = await supabase
    .from("challenges")
    .select("id, from_user, to_user, tema, qtd, created_at")
    .eq("id", challengeId)
    .maybeSingle();
  if (!challenge || challenge.from_user !== user.id) return NextResponse.json({ sent: 0 });
  if (Date.now() - new Date(challenge.created_at).getTime() > FRESH_MS) return NextResponse.json({ sent: 0 });

  const admin = createAdmin(process.env.NEXT_PUBLIC_SUPABASE_URL, process.env.SUPABASE_SERVICE_ROLE_KEY, { auth: { persistSession: false } });

  // Convidados: participantes do desafio menos quem criou. Sem a tabela de grupos (modelo antigo), só o to_user.
  let guestIds = [];
  const parts = await admin.from("challenge_participants").select("user_id").eq("challenge_id", challenge.id);
  if (!parts.error) guestIds = parts.data.map((r) => r.user_id);
  else if (challenge.to_user) guestIds = [challenge.to_user];
  guestIds = [...new Set(guestIds)].filter((id) => id && id !== user.id);
  if (!guestIds.length) return NextResponse.json({ sent: 0 });

  const { data: me } = await supabase.from("profiles").select("name").eq("id", user.id).maybeSingle();
  const payload = challengePayload({ id: challenge.id, fromName: me?.name, tema: challenge.tema, qtd: challenge.qtd });

  const { data: subs } = await admin.from("push_subscriptions").select("id, endpoint, p256dh, auth").in("user_id", guestIds);
  const results = await Promise.all((subs || []).map((s) => sendPush(s, payload, DAY_S)));
  const gone = (subs || []).filter((_, i) => results[i] === "gone").map((s) => s.id);
  if (gone.length) await admin.from("push_subscriptions").delete().in("id", gone);

  return NextResponse.json({ sent: results.filter((r) => r === "ok").length });
}
