-- Acessos: contagem própria e anônima de quem abre a tela de entrada e passa pelo quiz (funil, tempo, origem).
-- Rode UMA vez no SQL Editor do Supabase. Pode rodar de novo. Não mexe em nenhum dado existente.
--
-- O que é guardado (public.visit_events, uma linha por evento):
--   * visit: um código aleatório criado no navegador para aquela visita (some quando a aba fecha). NÃO é o IP, o e-mail
--     nem nenhum dado pessoal; o IP não é lido nem guardado.
--   * evento: tela, quiz_visto, quiz_inicio, resposta (passo 1 a 3), quiz_fim, quiz_fechado (passo = onde estava),
--     criar_clique, cadastro_envio, cadastro_ok, cadastro_erro, login_ok, saida.
--   * origem (só no evento "tela"): de onde veio, por exemplo "instagram.com" (site de origem ou utm_source). Vazio = direto.
--   * aparelho (só no evento "tela"): celular ou computador.
--   * criado_em: horário do evento.
-- Quem liga o "Não rastrear" do navegador não é contado. A tabela só é lida pela função admin_acessos (painel de dados,
-- aba Acessos), que confere o e-mail da administradora; qualquer outra conta recebe "forbidden".
--
--   * public.track_visit_event(...): chamada pelo app (anônima); só aceita eventos da lista, no máximo 60 por visita.
--   * public.admin_acessos(dias): números da aba Acessos (7, 30 ou 90 dias, dias no horário de Brasília).

create table if not exists public.visit_events (
  id        bigint generated always as identity primary key,
  visit     uuid not null,
  evento    text not null,
  passo     smallint,
  origem    text,
  aparelho  text,
  criado_em timestamptz not null default now()
);
create index if not exists visit_events_criado_em on public.visit_events (criado_em);
create index if not exists visit_events_visit on public.visit_events (visit, criado_em);
alter table public.visit_events enable row level security;       -- sem policies: só as funções abaixo mexem
revoke all on public.visit_events from anon, authenticated;

create or replace function public.track_visit_event(
  p_visit    uuid,
  p_evento   text,
  p_passo    integer default null,
  p_origem   text default null,
  p_aparelho text default null
)
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  if p_visit is null
     or p_evento is null
     or p_evento <> all (array['tela','quiz_visto','quiz_inicio','resposta','quiz_fim','quiz_fechado',
                               'criar_clique','cadastro_envio','cadastro_ok','cadastro_erro','login_ok','saida']) then
    return;
  end if;
  -- Trava contra abuso: no máximo 60 eventos por visita.
  if (select count(*) from public.visit_events where visit = p_visit) >= 60 then
    return;
  end if;
  insert into public.visit_events (visit, evento, passo, origem, aparelho)
  values (
    p_visit,
    p_evento,
    case when p_passo between 0 and 9 then p_passo::smallint else null end,
    case when p_evento = 'tela' then nullif(left(lower(trim(coalesce(p_origem, ''))), 60), '') else null end,
    case when p_evento = 'tela' and p_aparelho in ('celular', 'computador') then p_aparelho else null end
  );
end;
$$;
revoke all on function public.track_visit_event(uuid, text, integer, text, text) from public;
grant execute on function public.track_visit_event(uuid, text, integer, text, text) to anon, authenticated;

create or replace function public.admin_acessos(p_dias integer default 30)
returns jsonb
language plpgsql
stable
security definer
set search_path = public, auth
as $$
declare
  v_email text;
  v_dias  integer := least(greatest(coalesce(p_dias, 30), 1), 90);
  v_ini   timestamptz;
  v_out   jsonb;
begin
  select lower(u.email) into v_email from auth.users u where u.id = auth.uid();
  if v_email is null or not (v_email = any (array['flashcardiologia@gmail.com'])) then
    raise exception 'forbidden';
  end if;

  -- Começo do primeiro dia do período, meia-noite de Brasília.
  v_ini := (date_trunc('day', now() at time zone 'America/Sao_Paulo') - make_interval(days => v_dias - 1)) at time zone 'America/Sao_Paulo';

  with ev as (
    select id, visit, evento, passo, origem, aparelho, criado_em
      from public.visit_events
     where criado_em >= v_ini
  ),
  v as (
    select visit,
           min(criado_em) as ini,
           max(criado_em) as fim,
           (array_agg(origem) filter (where evento = 'tela'))[1]   as origem,
           (array_agg(aparelho) filter (where evento = 'tela'))[1] as aparelho,
           bool_or(evento = 'quiz_visto')                          as quiz_visto,
           bool_or(evento = 'quiz_inicio')                         as quiz_inicio,
           bool_or(evento = 'resposta' and passo = 1)              as r1,
           bool_or(evento = 'resposta' and passo = 2)              as r2,
           bool_or(evento = 'resposta' and passo = 3)              as r3,
           bool_or(evento = 'quiz_fim')                            as quiz_fim,
           bool_or(evento = 'quiz_fechado')                        as fechou,
           bool_or(evento = 'criar_clique')                        as criar,
           bool_or(evento = 'cadastro_envio')                      as envio,
           bool_or(evento = 'cadastro_ok')                         as conta,
           bool_or(evento = 'login_ok')                            as login,
           min(criado_em) filter (where evento = 'quiz_inicio')    as t_quiz_ini,
           min(criado_em) filter (where evento = 'quiz_fim')       as t_quiz_fim,
           min(criado_em) filter (where evento = 'cadastro_ok')    as t_conta
      from ev
     group by visit
    having bool_or(evento = 'tela')
  ),
  ordem as (
    select evento, passo, criado_em,
           lag(evento) over w    as ant_ev,
           lag(criado_em) over w as ant_ts
      from ev
    window w as (partition by visit order by criado_em, id)
  )
  select jsonb_build_object(
    'dias', v_dias,
    'visitas', (select count(*) from v),
    'funil', (
      select jsonb_build_object(
        'tela', count(*),
        'quiz_visto', count(*) filter (where quiz_visto),
        'quiz_inicio', count(*) filter (where quiz_inicio),
        'r1', count(*) filter (where r1),
        'r2', count(*) filter (where r2),
        'r3', count(*) filter (where r3),
        'quiz_fim', count(*) filter (where quiz_fim),
        'criar', count(*) filter (where criar),
        'envio', count(*) filter (where envio),
        'conta', count(*) filter (where conta)
      ) from v
    ),
    'login', (select count(*) from v where login),
    'fecharam_quiz', (select count(*) from v where fechou and not conta),
    'pararam', (
      select coalesce(jsonb_object_agg(etapa, n), '{}'::jsonb)
        from (
          select etapa, count(*) as n
            from (
              select case
                       when envio then 'envio'
                       when criar then 'criar'
                       when quiz_fim or r3 then 'resultado'
                       when r2 then 'q3'
                       when r1 then 'q2'
                       when quiz_inicio then 'q1'
                       when quiz_visto then 'intro'
                       else 'tela'
                     end as etapa
                from v
               where not conta and not login
            ) x
           group by etapa
        ) y
    ),
    'tempo_tela', (
      select jsonb_build_object(
        'ate10', count(*) filter (where dur < 10),
        'de10a30', count(*) filter (where dur >= 10 and dur < 30),
        'de30a60', count(*) filter (where dur >= 30 and dur < 60),
        'de1a3min', count(*) filter (where dur >= 60 and dur < 180),
        'mais3min', count(*) filter (where dur >= 180),
        'mediana', percentile_cont(0.5) within group (order by dur)
      )
        from (select extract(epoch from (fim - ini))::float8 as dur from v) x
    ),
    'tempos', jsonb_build_object(
      'q1', (select percentile_cont(0.5) within group (order by extract(epoch from (criado_em - ant_ts))::float8)
               from ordem where evento = 'resposta' and passo = 1 and ant_ev = 'quiz_inicio'),
      'q2', (select percentile_cont(0.5) within group (order by extract(epoch from (criado_em - ant_ts))::float8)
               from ordem where evento = 'resposta' and passo = 2 and ant_ev = 'resposta'),
      'q3', (select percentile_cont(0.5) within group (order by extract(epoch from (criado_em - ant_ts))::float8)
               from ordem where evento = 'resposta' and passo = 3 and ant_ev = 'resposta'),
      'quiz', (select percentile_cont(0.5) within group (order by extract(epoch from (t_quiz_fim - t_quiz_ini))::float8)
                 from v where t_quiz_ini is not null and t_quiz_fim is not null),
      'ate_conta', (select percentile_cont(0.5) within group (order by extract(epoch from (t_conta - ini))::float8)
                      from v where t_conta is not null)
    ),
    'origens', (
      select coalesce(jsonb_agg(jsonb_build_object('origem', o, 'visitas', n, 'contas', c) order by n desc, o), '[]'::jsonb)
        from (
          select coalesce(nullif(origem, ''), 'direto') as o, count(*) as n, count(*) filter (where conta) as c
            from v group by 1 order by 2 desc, 1 limit 8
        ) z
    ),
    'aparelhos', (
      select coalesce(jsonb_agg(jsonb_build_object('aparelho', a, 'visitas', n, 'contas', c) order by n desc, a), '[]'::jsonb)
        from (
          select coalesce(aparelho, 'desconhecido') as a, count(*) as n, count(*) filter (where conta) as c
            from v group by 1
        ) z
    ),
    'por_dia', (
      select jsonb_agg(jsonb_build_object('d', to_char(dia, 'YYYY-MM-DD'), 'visitas', coalesce(c.visitas, 0), 'contas', coalesce(c.contas, 0)) order by dia)
        from (select ((v_ini at time zone 'America/Sao_Paulo')::date + i) as dia from generate_series(0, v_dias - 1) as i) g
        left join (
          select (ini at time zone 'America/Sao_Paulo')::date as d, count(*) as visitas, count(*) filter (where conta) as contas
            from v group by 1
        ) c on c.d = g.dia
    )
  ) into v_out;

  return v_out;
end;
$$;
revoke all on function public.admin_acessos(integer) from public, anon;
grant execute on function public.admin_acessos(integer) to authenticated;

-- ============================================================
-- Depois, para consultar direto no SQL Editor:
--   select evento, count(*) from public.visit_events group by evento order by 2 desc;
-- Apagar contagens antigas (por exemplo, mais de 180 dias):
--   delete from public.visit_events where criado_em < now() - interval '180 days';
-- ============================================================
