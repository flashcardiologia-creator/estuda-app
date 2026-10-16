// Trava por assinatura. A situação vem do banco (função my_access, ver supabase/assinaturas.sql).
// Sem assinatura ativa: Questões e Flashcards ficam travados; Missão diária, ranking, estatísticas
// e conta continuam livres; Desafios têm limite menor de criação por dia.

export const FREE_CHALLENGES_PER_DAY = 1;
export const PAID_CHALLENGES_PER_DAY = 5;
// Questões por desafio: sem assinatura só 5 (a opção de 10 fica travada); com assinatura, 5 ou 10.
export const FREE_CHALLENGE_QUESTIONS = 5;
export const PAID_CHALLENGE_QUESTIONS = 10;

// Telas que exigem assinatura ativa.
export const LOCKED_SCREENS = [
  "questions-filters",
  "questions-session",
  "questions-results",
  "flashcards-select",
  "flashcards-session",
];

// Usado quando não foi possível consultar o banco (por exemplo, o SQL ainda não foi rodado):
// não travamos ninguém por causa de uma falha nossa.
export const OPEN_ACCESS = { active: true, enforced: false, plan: null, expiresAt: null, daysLeft: null, lastExpiredAt: null };

export function parseAccess(row) {
  if (!row) return OPEN_ACCESS;
  return {
    active: !!row.active,
    enforced: !!row.paywall_enabled,
    plan: row.plan || null,
    expiresAt: row.expires_at || null,
    daysLeft: row.days_left ?? null,
    lastExpiredAt: row.last_expired_at || null,
  };
}

export const PLAN_LABEL = { mensal: "Mensal", anual: "Anual", cortesia: "Cortesia" };
