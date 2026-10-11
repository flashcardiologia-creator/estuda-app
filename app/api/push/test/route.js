import { NextResponse } from "next/server";
import { createClient } from "@/lib/supabase/server";
import { configurePush, sendPush } from "@/lib/pushServer";

// Notificação de confirmação, só para os aparelhos de quem acabou de ativar os lembretes.
export async function POST() {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) return NextResponse.json({ error: "unauthorized" }, { status: 401 });

  try {
    configurePush();
  } catch {
    return NextResponse.json({ error: "push não configurado" }, { status: 503 });
  }

  const { data: subs } = await supabase.from("push_subscriptions").select("endpoint, p256dh, auth").eq("user_id", user.id);
  const payload = {
    title: "Lembretes ativados",
    body: "Você vai receber um aviso às 10h e às 22h se ainda não tiver feito a missão diária.",
    tag: "lembretes-ativados",
    url: "/",
  };
  const results = await Promise.all((subs || []).map((s) => sendPush(s, payload)));
  return NextResponse.json({ sent: results.filter((r) => r === "ok").length });
}
