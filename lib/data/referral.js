// Convite de amigos por link (supabase/convite_amigos.sql).
// O link leva o código de amigo de quem convida: <site>/?ref=<código de 9 dígitos>. Quem abre o link tem o código guardado neste
// navegador até criar a conta; o cadastro manda o código junto (campo "ref") e o banco registra o convite. Quando o convidado fecha o
// primeiro plano pago, os dois ganham dias.

// Os mesmos valores do banco (função _referral_days). Se mudar lá, mude aqui para o texto ficar certo.
export const REFERRAL_DAYS = { mensal: 3, anual: 14 };

const KEY = "fc-convite";

// Só o código de 9 dígitos (o mesmo formato do código de amigo); qualquer outra coisa vira "".
export const parseRef = (raw) => {
  const digits = String(raw || "").replace(/\D/g, "");
  return /^\d{9}$/.test(digits) ? digits : "";
};

export const loadRef = () => {
  try {
    return parseRef(window.localStorage.getItem(KEY));
  } catch {
    return "";
  }
};

export const saveRef = (code) => {
  try {
    window.localStorage.setItem(KEY, code);
  } catch {
    // sem armazenamento: o código vale só enquanto a página estiver aberta
  }
};

export const clearRef = () => {
  try {
    window.localStorage.removeItem(KEY);
  } catch {
    // nada a limpar
  }
};

export const inviteUrl = (origin, code) => `${origin}/?ref=${code}`;

export const inviteMessage = (url) =>
  `Estou estudando cardiologia no FlashCardio (questões comentadas, flashcards e revisão diária). Entre pelo meu link: ${url}\nQuando você fechar um plano, nós dois ganhamos dias grátis!`;

// Código, totais e últimos convidados de quem está logado. null quando o SQL ainda não foi rodado (a caixa não aparece).
// Falha de rede ou do servidor lança erro (quem chama mantém o que já tinha), para não confundir com "SQL não rodado".
export async function fetchMyReferral(supabase) {
  const { data, error, status } = await supabase.rpc("my_referral");
  if (error) {
    // PGRST202 / 42883 / 404: a função my_referral não existe (supabase/convite_amigos.sql ainda não foi rodado).
    if (error.code === "PGRST202" || error.code === "42883" || status === 404) return null;
    throw error;
  }
  if (!data || !data.code) return null;
  return data;
}

// Cache da caixa "Convidar amigos" (Minha Conta). Sem ele a caixa só aparecia depois de uma ida ao servidor, bem depois das outras.
// O app busca em segundo plano ao abrir (prefetchReferral) e guarda na memória; o essencial (código e totais, sem nomes) também
// fica neste navegador, para a caixa já abrir pronta na próxima visita e ser atualizada em seguida.
const CACHE_KEY = "fc-convite-cache";
const memory = new Map(); // userId -> dados completos (com a lista de convidados)
const inflight = new Map(); // userId -> busca em andamento (evita duas idas ao servidor ao mesmo tempo)

const readStored = (userId) => {
  try {
    const raw = JSON.parse(window.localStorage.getItem(CACHE_KEY) || "null");
    if (!raw || raw.userId !== userId || !parseRef(raw.code)) return null;
    return { code: raw.code, invited: Number(raw.invited) || 0, rewarded: Number(raw.rewarded) || 0, days: Number(raw.days) || 0, list: [] };
  } catch {
    return null;
  }
};

const writeStored = (userId, d) => {
  try {
    if (!d) window.localStorage.removeItem(CACHE_KEY);
    else window.localStorage.setItem(CACHE_KEY, JSON.stringify({ userId, code: d.code, invited: d.invited, rewarded: d.rewarded, days: d.days }));
  } catch {
    // sem armazenamento: só não guarda para a próxima visita
  }
};

// O que já se sabe sem ir ao servidor (memória ou navegador); null se nada.
export const cachedReferral = (userId) => memory.get(userId) || (typeof window !== "undefined" ? readStored(userId) : null);

// Busca no servidor e atualiza o cache. Resolve com os dados, ou null se o recurso não existe; falha de rede rejeita (o cache fica como está).
export function prefetchReferral(supabase, userId) {
  if (inflight.has(userId)) return inflight.get(userId);
  const p = fetchMyReferral(supabase)
    .then((d) => {
      if (d) memory.set(userId, d);
      else memory.delete(userId);
      writeStored(userId, d);
      return d;
    })
    .finally(() => inflight.delete(userId));
  inflight.set(userId, p);
  return p;
}
