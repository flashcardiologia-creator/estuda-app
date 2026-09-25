// O "dia" da missão vira às 18h de Brasília (21h UTC), não à meia-noite UTC —
// por isso soma 3h antes de extrair a data, igual à função app_today() no banco.
const DAY_BOUNDARY_OFFSET_MS = 3 * 60 * 60 * 1000;

export const todayStr = () => dateStrAt(new Date());

export const dateStrAt = (date) => new Date(date.getTime() + DAY_BOUNDARY_OFFSET_MS).toISOString().slice(0, 10);

export const msUntilNextDayBoundary = () => {
  const now = new Date();
  const next = new Date(Date.UTC(now.getUTCFullYear(), now.getUTCMonth(), now.getUTCDate(), 21, 0, 0, 0));
  if (next.getTime() <= now.getTime()) next.setUTCDate(next.getUTCDate() + 1);
  return next.getTime() - now.getTime();
};

export const formatCountdownClock = (ms) => {
  const totalSeconds = Math.max(0, Math.floor(ms / 1000));
  const h = Math.floor(totalSeconds / 3600);
  const m = Math.floor((totalSeconds % 3600) / 60);
  const s = totalSeconds % 60;
  return `${h}:${String(m).padStart(2, "0")}:${String(s).padStart(2, "0")}`;
};

export const addDays = (dateStr, n) => {
  const d = new Date(dateStr + "T00:00:00");
  d.setDate(d.getDate() + n);
  return d.toISOString().slice(0, 10);
};

export const shuffle = (arr) => {
  const a = [...arr];
  for (let i = a.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [a[i], a[j]] = [a[j], a[i]];
  }
  return a;
};

export const MAX_NAME_LEN = 30;
// Sem trim aqui de propósito — isso roda a cada tecla digitada (onChange),
// e aparar espaços a cada tecla impede digitar um espaço no meio do nome
// (ex: "Ana Teste"). Corte as pontas só na hora de enviar, com .trim().
export const sanitizeName = (raw) => raw.replace(/[<>]/g, "").slice(0, MAX_NAME_LEN);
