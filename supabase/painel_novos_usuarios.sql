-- Painel de dados: "Novos usuários por dia" com período de 14, 30 ou 365 dias (Usuários > gráfico, seletor de período).
-- Cria a função public.admin_novos_usuarios(p_dias), que devolve quantos usuários criaram a conta em cada um dos últimos
-- p_dias dias (de 1 a 730; o app pede 365 de uma vez e recorta os 30 dias dela; o gráfico de 365 dias agrupa por mês).
-- Rode UMA vez no SQL Editor do Supabase, DEPOIS do painel_dados_admin.sql. Pode rodar de novo (só recria a função).
-- Só consulta: não altera nenhum dado. Sem este SQL o gráfico continua mostrando os 14 dias; os botões 30 e 365 dias
-- avisam que falta rodá-lo.
--
-- Segurança: igual à admin_stats. Só a conta administradora (flashcardiologia@gmail.com) consegue chamar; qualquer outra
-- conta, mesmo logada, recebe o erro "forbidden". Para liberar outra, adicione o e-mail na lista abaixo (e em
-- lib/access.js, ADMIN_DASHBOARD_EMAILS, que só controla se o botão do painel aparece).
--
-- Dia = dia de Brasília (vira à meia-noite), o mesmo do restante do painel. O dia de hoje conta como o último.

create or replace function public.admin_novos_usuarios(p_dias integer default 365)
returns jsonb
language plpgsql
stable
security definer
set search_path = public, auth
as $$
#variable_conflict use_column
declare
  v_email  text;
  v_today  date := public.app_today();
  v_dias   integer := least(greatest(coalesce(p_dias, 365), 1), 730);
  v_t0     timestamptz := ((public.app_today() - (least(greatest(coalesce(p_dias, 365), 1), 730) - 1))::timestamp at time zone 'America/Sao_Paulo');
  v_result jsonb;
begin
  select lower(u.email) into v_email from auth.users u where u.id = auth.uid();
  if v_email is null or not (v_email = any (array['flashcardiologia@gmail.com'])) then
    raise exception 'forbidden';
  end if;

  with
  dias as (
    select (v_today - g.n) as dia from generate_series(0, v_dias - 1) as g(n)
  ),
  cont as (
    select public.app_date(u.created_at) as dia, count(*)::integer as n
      from auth.users u
     where u.created_at >= v_t0
     group by 1
  )
  select jsonb_build_object(
           'dias',  v_dias,
           'total', coalesce((select sum(c.n) from cont c), 0),
           'serie', (select jsonb_agg(jsonb_build_object('d', to_char(d.dia, 'YYYY-MM-DD'), 'n', coalesce(c.n, 0)) order by d.dia)
                       from dias d left join cont c on c.dia = d.dia)
         )
    into v_result;

  return v_result;
end;
$$;

revoke all on function public.admin_novos_usuarios(integer) from public, anon;
grant execute on function public.admin_novos_usuarios(integer) to authenticated;

-- Para conferir depois (logado como a conta administradora no app, o painel mostra os números; no SQL Editor a função
-- responde "forbidden" porque lá não há usuário logado):
--   select public.admin_novos_usuarios(30);
