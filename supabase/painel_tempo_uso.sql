-- Painel de dados, aba "Tempo de uso": média diária de uso por usuário (hoje, no mês e no ano, com gráfico mensal) e os usuários com
-- mais uso (hoje e no mês). Cria a função public.admin_tempo_uso(), que o app chama nessa aba.
-- Rode UMA vez no SQL Editor do Supabase, DEPOIS do painel_dados_admin.sql. Pode rodar de novo (só recria a função).
-- Só consulta: não altera nenhum dado, e o app dos usuários não muda em nada.
--
-- IMPORTANTE: o app NÃO mede o tempo em que a tela fica aberta. O tempo aqui é ESTIMADO a partir das ações que a pessoa já registra
-- (as mesmas que definem "usuário ativo" no painel): questão respondida, flashcard visto, resposta em desafio, revisão diária aberta
-- e desafio criado. Para cada pessoa e cada dia (de Brasília), as ações são colocadas em ordem e:
--   * entre duas ações seguidas com até 5 minutos de intervalo, o intervalo conta como tempo de uso;
--   * se a pausa for maior que 5 minutos, o intervalo não conta (a pessoa saiu), e a ação que recomeça vale 30 segundos;
--   * uma ação sozinha vale 30 segundos.
-- Esses dois números (5 min e 30 s) ficam em v_pausa e v_isolada abaixo e podem ser ajustados. Ler um comentário longo sem tocar em nada
-- por mais de 5 minutos, ou deixar o app aberto parado, não aparece; por isso é uma estimativa do tempo de estudo ATIVO, não um cronômetro.
--
-- Definições:
--   * Média diária de uso = tempo estimado ÷ número de usuários que usaram naquele dia (quem não usou o app não entra na conta). No mês
--     e no ano, é o total de minutos ÷ o número de pares (usuário, dia) com uso.
--   * Não entram na conta: as contas administradoras e os bots (e-mail terminado em @flashcardio.invalid).
--   * O gráfico mensal mostra janeiro até o mês atual do ano corrente (dias de Brasília).
--   * Usuário com mais uso no mês: o de maior total no mês corrente. A média diária dele aparece de duas formas: pelos dias do mês até
--     hoje e só pelos dias em que ele usou.
--
-- Segurança: igual à admin_stats. Só a conta administradora (flashcardiologia@gmail.com) consegue chamar; qualquer outra conta,
-- mesmo logada, recebe o erro "forbidden". Para liberar outra, adicione o e-mail nas duas listas abaixo (e em lib/access.js,
-- ADMIN_DASHBOARD_EMAILS, que só controla se o botão do painel aparece).

create or replace function public.admin_tempo_uso()
returns jsonb
language plpgsql
stable
security definer
set search_path = public, auth
as $$
#variable_conflict use_column
declare
  v_email   text;
  v_now     timestamptz := now();
  v_today   date := public.app_today();
  v_mes0    date := date_trunc('month', public.app_today())::date;
  v_ano0    date := date_trunc('year', public.app_today())::date;
  v_t0      timestamptz := (date_trunc('year', public.app_today())::date::timestamp at time zone 'America/Sao_Paulo');
  v_pausa   interval := interval '5 minutes';  -- pausa maior que isso não conta como uso
  v_isolada numeric := 30;                      -- segundos creditados a uma ação sem outra por perto
  v_result  jsonb;
begin
  select lower(u.email) into v_email from auth.users u where u.id = auth.uid();
  if v_email is null or not (v_email = any (array['flashcardiologia@gmail.com'])) then
    raise exception 'forbidden';
  end if;

  with
  ev as (
    select a.user_id, a.answered_at as ts from public.user_question_attempts a where a.answered_at >= v_t0
    union all
    select f.user_id, f.viewed_at from public.user_flashcard_views f where f.viewed_at >= v_t0
    union all
    select c.user_id, c.answered_at from public.challenge_answers c where c.answered_at >= v_t0
    union all
    select m.user_id, m.created_at from public.daily_mission_picks m where m.created_at >= v_t0
    union all
    select h.from_user, h.created_at from public.challenges h where h.created_at >= v_t0
  ),
  ev2 as (
    select e.user_id, e.ts, public.app_date(e.ts) as dia
      from ev e
      join auth.users u on u.id = e.user_id
     where coalesce(lower(u.email), '') <> all (array['flashcardiologia@gmail.com'])
       and coalesce(u.email, '') not like '%@flashcardio.invalid'
  ),
  seq as (
    select e.user_id, e.dia, e.ts, lag(e.ts) over (partition by e.user_id, e.dia order by e.ts) as prev from ev2 e
  ),
  cred as (
    select s.user_id, s.dia,
           case when s.prev is not null and s.ts - s.prev <= v_pausa then extract(epoch from (s.ts - s.prev)) else v_isolada end as seg
      from seq s
  ),
  uso as (
    select c.user_id, c.dia, sum(c.seg) as seg from cred c group by c.user_id, c.dia
  ),
  meses as (
    select g::date as mes from generate_series(v_ano0::timestamp, v_mes0::timestamp, interval '1 month') as g
  ),
  por_mes as (
    select date_trunc('month', u.dia)::date as mes, count(*) as pares, count(distinct u.user_id) as usuarios, sum(u.seg) as seg
      from uso u group by 1
  ),
  usuario_mes as (
    select u.user_id, sum(u.seg) as seg, count(*) as dias from uso u where u.dia >= v_mes0 group by u.user_id
  )
  select jsonb_build_object(
    'gerado_em', v_now,
    'regras', jsonb_build_object('pausa_min', extract(epoch from v_pausa) / 60, 'acao_isolada_seg', v_isolada),
    'hoje', (select jsonb_build_object('usuarios', count(*), 'minutos', round(coalesce(sum(u.seg), 0) / 60, 1),
                                       'media_min', case when count(*) > 0 then round(sum(u.seg) / 60 / count(*), 1) end)
               from uso u where u.dia = v_today),
    'mes',  (select jsonb_build_object('usuarios', count(distinct u.user_id), 'dias_usuario', count(*), 'minutos', round(coalesce(sum(u.seg), 0) / 60, 1),
                                       'media_min', case when count(*) > 0 then round(sum(u.seg) / 60 / count(*), 1) end)
               from uso u where u.dia >= v_mes0),
    'ano',  (select jsonb_build_object('usuarios', count(distinct u.user_id), 'dias_usuario', count(*), 'minutos', round(coalesce(sum(u.seg), 0) / 60, 1),
                                       'media_min', case when count(*) > 0 then round(sum(u.seg) / 60 / count(*), 1) end)
               from uso u),
    'meses', (select jsonb_agg(jsonb_build_object('m', to_char(m.mes, 'YYYY-MM'), 'usuarios', coalesce(p.usuarios, 0),
                                                  'media_min', case when coalesce(p.pares, 0) > 0 then round(p.seg / 60 / p.pares, 1) else 0 end)
                               order by m.mes)
                from meses m left join por_mes p on p.mes = m.mes),
    'top_hoje', (select jsonb_build_object('email', uu.email, 'minutos', round(u.seg / 60, 1))
                   from uso u join auth.users uu on uu.id = u.user_id
                  where u.dia = v_today order by u.seg desc limit 1),
    'top_mes',  (select jsonb_build_object('email', uu.email, 'minutos', round(m.seg / 60, 1), 'dias_ativos', m.dias,
                                           'dias_decorridos', extract(day from v_today)::int,
                                           'media_dia_mes_min', round(m.seg / 60 / extract(day from v_today), 1),
                                           'media_dia_ativo_min', round(m.seg / 60 / m.dias, 1))
                   from usuario_mes m join auth.users uu on uu.id = m.user_id
                  order by m.seg desc limit 1)
  ) into v_result;

  return v_result;
end;
$$;

revoke all on function public.admin_tempo_uso() from public, anon;
grant execute on function public.admin_tempo_uso() to authenticated;
