// Contagem própria e anônima da tela de entrada e do quiz (supabase/acessos_visitantes.sql e supabase/acessos_convites.sql, aba Acessos do painel de dados).
// Cada visita (aba aberta) recebe um código aleatório guardado só no sessionStorage: nada de IP, e-mail ou dado pessoal.
// Quem liga o "Não rastrear" do navegador não é contado, nem navegadores automatizados. Qualquer falha é silenciosa.

import { parseRef } from "@/lib/data/referral";

const VISIT_KEY = "fc-visita";
const ONCE_PREFIX = "fc-visita-1x-";

function visitId() {
  try {
    let id = window.sessionStorage.getItem(VISIT_KEY);
    if (!id) {
      id = window.crypto.randomUUID();
      window.sessionStorage.setItem(VISIT_KEY, id);
    }
    return id;
  } catch {
    return null;
  }
}

function optedOut() {
  return navigator.doNotTrack === "1" || window.doNotTrack === "1" || navigator.webdriver === true;
}

// De onde a pessoa veio: utm_source do link, ou o site de origem (sem o www). Vazio = acesso direto.
function origin() {
  try {
    const utm = new URLSearchParams(window.location.search).get("utm_source");
    if (utm) return utm;
    if (!document.referrer) return "";
    const host = new URL(document.referrer).hostname.replace(/^www\./, "");
    return host === window.location.hostname.replace(/^www\./, "") ? "" : host;
  } catch {
    return "";
  }
}

// Código de amigo de QUEM CONVIDOU, quando a visita chegou por um link de convite (/?ref=<código>). Vazio = não veio por convite.
// É o código que já está no link: nada sobre a pessoa que visita é guardado.
function inviteCode() {
  try {
    return parseRef(new URLSearchParams(window.location.search).get("ref"));
  } catch {
    return "";
  }
}

const device = () => (window.matchMedia?.("(pointer: coarse)").matches ? "celular" : "computador");

// Registra um evento da visita. passo: número de apoio (questão 1 a 3, ou onde o quiz foi fechado).
// once: só uma vez por visita (a atualização da página não conta de novo).
export function track(evento, passo = null, { once = false } = {}) {
  try {
    const base = process.env.NEXT_PUBLIC_SUPABASE_URL;
    const key = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;
    if (!base || !key || optedOut()) return;
    const visit = visitId();
    if (!visit) return;
    if (once) {
      const mark = ONCE_PREFIX + evento;
      if (window.sessionStorage.getItem(mark)) return;
      window.sessionStorage.setItem(mark, "1");
    }
    // p_convite só vai quando o link tem ?ref=: as demais visitas seguem mandando exatamente o que mandavam (e funcionam
    // mesmo se o SQL supabase/acessos_convites.sql ainda não tiver sido rodado).
    const convite = evento === "tela" ? inviteCode() : "";
    fetch(`${base}/rest/v1/rpc/track_visit_event`, {
      method: "POST",
      headers: { "Content-Type": "application/json", apikey: key, Authorization: `Bearer ${key}` },
      body: JSON.stringify({
        p_visit: visit,
        p_evento: evento,
        p_passo: passo,
        p_origem: evento === "tela" ? origin() : null,
        p_aparelho: evento === "tela" ? device() : null,
        ...(convite ? { p_convite: convite } : {}),
      }),
      keepalive: true, // também sai na hora em que a pessoa fecha a aba
    }).catch(() => {});
  } catch {
    // contagem é opcional
  }
}
