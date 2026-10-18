-- Painel de dados (só para a conta administradora flashcardiologia@gmail.com).
-- Cria a função public.admin_stats(), que o app chama na tela "Painel de dados" (Minha Conta, abaixo de
-- "Sair da conta"). Devolve, de uma vez, os números e as séries dos gráficos dos últimos 14 dias.
-- Rode uma vez no SQL Editor do Supabase. Pode rodar de novo (só recria a função). Só consulta: não
-- altera nenhum dado.
--
-- Segurança: a função confere o e-mail de quem chamou. Qualquer outra conta, mesmo logada, recebe
-- o erro "forbidden". Para liberar outra conta administradora, troque/adicione o e-mail na lista
-- dentro da função (e em lib/access.js, ADMIN_DASHBOARD_EMAILS, que só controla se o botão aparece).
--
-- Definições:
--   * Dia = dia de Brasília (vira à meia-noite). "Hoje" começa às 00:00 de Brasília.
--   * Usuário ATIVO = fez alguma coisa no período: respondeu questão (inclusive em desafio), viu
--     flashcard, abriu a missão diária ou criou desafio.
--   * Questões respondidas = respostas avulsas + respostas dentro de desafios.
--   * Assinantes = quem tem plano mensal, anual ou cortesia valendo agora (as contas administradoras
--     não entram na conta).

create or replace function public.admin_stats()
returns jsonb
language plpgsql
stable
security definer
set search_path = public, auth
as $$
#variable_conflict use_column
declare
  v_email  text;
  v_now    timestamptz := now();
  v_today  date := public.app_today();
  v_t0     timestamptz := (public.app_today()::timestamp at time zone 'America/Sao_Paulo');
  v_result jsonb;
begin
  select lower(u.email) into v_email from auth.users u where u.id = auth.uid();
  if v_email is null or not (v_email = any (array['flashcardiologia@gmail.com'])) then
    raise exception 'forbidden';
  end if;

  with
  dias as (
    select (v_today - n) as dia from generate_series(0, 13) n
  ),
  usr as (
    select u.id, u.created_at from auth.users u
  ),
  ev as (
    select a.user_id, a.answered_at as ts from public.user_question_attempts a where a.answered_at >= v_now - interval '30 days'
    union all
    select f.user_id, f.viewed_at from public.user_flashcard_views f where f.viewed_at >= v_now - interval '30 days'
    union all
    select c.user_id, c.answered_at from public.challenge_answers c where c.answered_at >= v_now - interval '30 days'
    union all
    select m.user_id, m.created_at from public.daily_mission_picks m where m.created_at >= v_now - interval '30 days'
    union all
    select h.from_user, h.created_at from public.challenges h where h.created_at >= v_now - interval '30 days'
  ),
  qa as (
    select a.answered_at as ts, a.correct, coalesce(a.is_daily_mission, false) as diaria
      from public.user_question_attempts a where a.answered_at >= v_t0 - interval '13 days'
    union all
    select c.answered_at, c.correct, false
      from public.challenge_answers c where c.answered_at >= v_t0 - interval '13 days'
  ),
  fv as (
    select f.viewed_at as ts from public.user_flashcard_views f where f.viewed_at >= v_t0 - interval '13 days'
  ),
  ch as (
    select h.created_at as ts from public.challenges h where h.created_at >= v_t0 - interval '13 days'
  ),
  act as (
    select distinct on (p.user_id) p.user_id, p.plan
      from public.payments p
     where p.status = 'approved' and p.user_id is not null
       and p.starts_at <= v_now and p.expires_at > v_now
       and coalesce(p.notes, '') <> 'Conta administradora'
     order by p.user_id, p.expires_at desc
  )
  select jsonb_build_object(
    'gerado_em', v_now,
    'usuarios', jsonb_build_object(
      'total',               (select count(*) from usr),
      'novos_hoje',          (select count(*) from usr where created_at >= v_t0),
      'novos_24h',           (select count(*) from usr where created_at >= v_now - interval '24 hours'),
      'novos_48h',           (select count(*) from usr where created_at >= v_now - interval '48 hours'),
      'novos_7d',            (select count(*) from usr where created_at >= v_now - interval '7 days'),
      'novos_7d_anteriores', (select count(*) from usr where created_at >= v_now - interval '14 days' and created_at < v_now - interval '7 days')
    ),
    'ativos', jsonb_build_object(
      'hoje', (select count(distinct user_id) from ev where ts >= v_t0),
      'h24',  (select count(distinct user_id) from ev where ts >= v_now - interval '24 hours'),
      'd7',   (select count(distinct user_id) from ev where ts >= v_now - interval '7 days'),
      'd30',  (select count(distinct user_id) from ev where ts >= v_now - interval '30 days')
    ),
    'assinaturas', jsonb_build_object(
      'ativos',   (select count(*) from act),
      'mensal',   (select count(*) from act where plan = 'mensal'),
      'anual',    (select count(*) from act where plan = 'anual'),
      'cortesia', (select count(*) from act where plan = 'cortesia'),
      'compras_7d',  (select count(*) from public.payments where status = 'approved' and method <> 'cortesia' and paid_at >= v_now - interval '7 days'),
      'compras_30d', (select count(*) from public.payments where status = 'approved' and method <> 'cortesia' and paid_at >= v_now - interval '30 days'),
      'receita_30d_centavos',   (select coalesce(sum(amount_cents), 0) from public.payments where status = 'approved' and method <> 'cortesia' and paid_at >= v_now - interval '30 days'),
      'receita_total_centavos', (select coalesce(sum(amount_cents), 0) from public.payments where status = 'approved' and method <> 'cortesia')
    ),
    'questoes', jsonb_build_object(
      'hoje',        (select count(*) from qa where ts >= v_t0),
      'd7',          (select count(*) from qa where ts >= v_t0 - interval '6 days'),
      'acertos_d7',  (select count(*) from qa where ts >= v_t0 - interval '6 days' and correct),
      'diarias_hoje', (select count(*) from qa where ts >= v_t0 and diaria),
      'missoes_concluidas_hoje', (select count(*) from public.profiles where last_mission_date = v_today)
    ),
    'flashcards', jsonb_build_object(
      'hoje', (select count(*) from fv where ts >= v_t0),
      'd7',   (select count(*) from fv where ts >= v_t0 - interval '6 days')
    ),
    'desafios', jsonb_build_object(
      'hoje',  (select count(*) from ch where ts >= v_t0),
      'd7',    (select count(*) from ch where ts >= v_t0 - interval '6 days'),
      'total', (select count(*) from public.challenges)
    ),
    'conteudo', jsonb_build_object(
      'questoes',   (select count(*) from public.questions),
      'flashcards', (select count(*) from public.flashcards)
    ),
    'series', jsonb_build_object(
      'novos', (select jsonb_agg(jsonb_build_object('d', to_char(d.dia, 'YYYY-MM-DD'),
                  'n', (select count(*) from usr where public.app_date(usr.created_at) = d.dia)) order by d.dia) from dias d),
      'ativos', (select jsonb_agg(jsonb_build_object('d', to_char(d.dia, 'YYYY-MM-DD'),
                  'n', (select count(distinct ev.user_id) from ev where public.app_date(ev.ts) = d.dia)) order by d.dia) from dias d),
      'questoes', (select jsonb_agg(jsonb_build_object('d', to_char(d.dia, 'YYYY-MM-DD'),
                  'n', (select count(*) from qa where public.app_date(qa.ts) = d.dia)) order by d.dia) from dias d),
      'flashcards', (select jsonb_agg(jsonb_build_object('d', to_char(d.dia, 'YYYY-MM-DD'),
                  'n', (select count(*) from fv where public.app_date(fv.ts) = d.dia)) order by d.dia) from dias d),
      'desafios', (select jsonb_agg(jsonb_build_object('d', to_char(d.dia, 'YYYY-MM-DD'),
                  'n', (select count(*) from ch where public.app_date(ch.ts) = d.dia)) order by d.dia) from dias d)
    )
  ) into v_result;

  return v_result;
end;
$$;

revoke all on function public.admin_stats() from public, anon;
grant execute on function public.admin_stats() to authenticated;

-- Para conferir o resultado direto no SQL Editor (lá você não está "logado" no app, então vai dar
-- "forbidden": é esperado e prova que a trava funciona). O teste de verdade é abrir o painel no app.
