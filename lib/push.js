// Lembretes por notificação (push) da missão diária — lado do app (navegador).
// A chave pública identifica o nosso servidor de envio (a privada fica só no Netlify).
const VAPID_PUBLIC_KEY = "BP217-wbxysghlALpA9njPvJPbxh9Q6qbdj751E52il_tqigXppQUWherowgW07rH5Mu1nvCUPVifdWX8DnJBig";

function urlBase64ToUint8Array(base64) {
  const padding = "=".repeat((4 - (base64.length % 4)) % 4);
  const raw = atob((base64 + padding).replace(/-/g, "+").replace(/_/g, "/"));
  return Uint8Array.from(raw, (c) => c.charCodeAt(0));
}

// "ok" | "ios-install" (iPhone com o app fora da tela inicial) | "unsupported"
export function pushSupport() {
  if (typeof window === "undefined") return "unsupported";
  const ua = navigator.userAgent || "";
  const isIos = /iPhone|iPad|iPod/i.test(ua) || (/Macintosh/i.test(ua) && navigator.maxTouchPoints > 1);
  const standalone = window.matchMedia?.("(display-mode: standalone)").matches || navigator.standalone === true;
  if (isIos && !standalone) return "ios-install";
  if (!("serviceWorker" in navigator) || !("PushManager" in window) || !("Notification" in window)) return "unsupported";
  return "ok";
}

export async function isPushSubscribed() {
  if (pushSupport() !== "ok" || Notification.permission !== "granted") return false;
  const reg = await navigator.serviceWorker.getRegistration("/sw.js");
  if (!reg) return false;
  return !!(await reg.pushManager.getSubscription());
}

export async function enablePush(supabase, userId) {
  const permission = await Notification.requestPermission();
  if (permission !== "granted") throw new Error("denied");
  const reg = await navigator.serviceWorker.register("/sw.js");
  await navigator.serviceWorker.ready;
  const sub =
    (await reg.pushManager.getSubscription()) ||
    (await reg.pushManager.subscribe({ userVisibleOnly: true, applicationServerKey: urlBase64ToUint8Array(VAPID_PUBLIC_KEY) }));
  const json = sub.toJSON();
  const { error } = await supabase
    .from("push_subscriptions")
    .upsert({ user_id: userId, endpoint: json.endpoint, p256dh: json.keys.p256dh, auth: json.keys.auth }, { onConflict: "endpoint" });
  if (error) {
    await sub.unsubscribe().catch(() => {});
    throw new Error("save");
  }
  // Notificação de confirmação: mostra na hora que os lembretes funcionam neste aparelho.
  fetch("/api/push/test", { method: "POST" }).catch(() => {});
}

// Manda agora o lembrete real da missão para os aparelhos desta conta (teste de ponta a ponta).
export async function sendTestReminder() {
  const res = await fetch("/api/push/test?modo=lembrete", { method: "POST" });
  const body = await res.json().catch(() => ({}));
  if (!res.ok) throw new Error(body.error || "Falha no envio");
  return body;
}

export async function disablePush(supabase, userId) {
  const reg = await navigator.serviceWorker.getRegistration("/sw.js");
  const sub = reg ? await reg.pushManager.getSubscription() : null;
  if (sub) {
    await supabase.from("push_subscriptions").delete().eq("user_id", userId).eq("endpoint", sub.endpoint);
    await sub.unsubscribe().catch(() => {});
  }
}
