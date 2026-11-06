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
  `Estou estudando cardiologia no FlashCardio (questões comentadas, flashcards e missão diária). Entre pelo meu link: ${url}\nQuando você fechar um plano, nós dois ganhamos dias grátis!`;

// Código, totais e últimos convidados de quem está logado. null quando o SQL ainda não foi rodado (a caixa não aparece).
export async function fetchMyReferral(supabase) {
  const { data, error } = await supabase.rpc("my_referral");
  if (error || !data || !data.code) return null;
  return data;
}
