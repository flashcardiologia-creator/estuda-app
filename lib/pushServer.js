// Lembretes por notificação (push) — lado do servidor (rota de teste e função agendada do Netlify).
import webpush from "web-push";

const PUBLIC_KEY = "BP217-wbxysghlALpA9njPvJPbxh9Q6qbdj751E52il_tqigXppQUWherowgW07rH5Mu1nvCUPVifdWX8DnJBig";
const BRASILIA_OFFSET_MS = 3 * 60 * 60 * 1000;

export function configurePush() {
  const privateKey = process.env.VAPID_PRIVATE_KEY;
  if (!privateKey) throw new Error("VAPID_PRIVATE_KEY não configurada");
  webpush.setVapidDetails("mailto:contato@flashcardiologia.com", PUBLIC_KEY, privateKey);
}

// Mesmo dia do app: vira à meia-noite de Brasília.
export const appToday = (now = new Date()) => new Date(now.getTime() - BRASILIA_OFFSET_MS).toISOString().slice(0, 10);

export function msUntilMidnightBrasilia(now = new Date()) {
  const next = new Date(Date.UTC(now.getUTCFullYear(), now.getUTCMonth(), now.getUTCDate(), 3, 0, 0, 0));
  if (next.getTime() <= now.getTime()) next.setUTCDate(next.getUTCDate() + 1);
  return next.getTime() - now.getTime();
}

function formatRemaining(ms) {
  const totalMin = Math.max(0, Math.floor(ms / 60000));
  const h = Math.floor(totalMin / 60);
  const m = totalMin % 60;
  if (h === 0) return `${m} min`;
  return m === 0 ? `${h}h` : `${h}h${String(m).padStart(2, "0")}`;
}

// Texto do lembrete: o tempo que falta é o do contador da missão diária, calculado no momento do envio.
export function reminderPayload(now = new Date()) {
  return {
    title: "Sua missão diária está esperando",
    body: `Faltam ${formatRemaining(msUntilMidnightBrasilia(now))} para ela expirar. Toque para fazer agora.`,
    tag: "missao-diaria",
    url: "/",
  };
}

// Envia para um aparelho. Devolve "ok", "gone" (aparelho não existe mais: apagar) ou "error".
export async function sendPush(sub, payload) {
  try {
    await webpush.sendNotification(
      { endpoint: sub.endpoint, keys: { p256dh: sub.p256dh, auth: sub.auth } },
      JSON.stringify(payload),
      { TTL: 60 * 60 * 3, urgency: "normal" }
    );
    return "ok";
  } catch (err) {
    return err && (err.statusCode === 404 || err.statusCode === 410) ? "gone" : "error";
  }
}
