-- Aba Acessos > "De onde vêm" > "Links de convite": quantas visitas e quantas contas cada pessoa trouxe pelo seu link de convite
-- (flashcardiologia.com/?ref=<código de amigo>). Rode UMA vez no SQL Editor do Supabase, DEPOIS do acessos_visitantes.sql (e do
-- convite_amigos.sql). Pode rodar de novo. Não apaga nem altera nenhuma contagem que já existe.
--
-- O que muda:
--   1) public.visit_events ganha a coluna "convite": o código de amigo de QUEM CONVIDOU, guardado só no evento "tela" (a abertura da
--      tela de entrada) das visitas que chegam por um link com ?ref=. É o código de quem convida, que já está no próprio link:
--      nenhum dado da pessoa que visita é guardado (continua sem IP, e-mail ou outro dado pessoal).
--   2) public.track_visit_event(...) passa a aceitar p_convite (opcional). O app só manda esse campo quando o link tem ?ref=; sem ele,
--      tudo funciona como antes. A função de 5 parâmetros é substituída pela de 6 (com o último opcional), para não haver duas versões
--      concorrendo. Se algum dia você rodar de novo o acessos_visitantes.sql, rode este arquivo depois.
--   3) public.admin_acessos_convites(p_dias): a lista da aba Acessos, por pessoa que convidou, nos últimos 1, 7, 30 ou 90 dias:
--        * visitas: visitas que abriram o link dela (só contam a partir de quando este SQL e o app novo estiverem no ar);
--        * contas: contas criadas de fato pelo link dela no período (vêm do cadastro, public.referrals, e valem desde o começo dos
--          convites, mesmo quem liga o "Não rastrear" ou criou a conta numa visita posterior).
--      Também devolve o total de visitas do período, para mostrar quanto do acesso vem de convites.
--
-- Segurança: igual à admin_acessos. Só a conta administradora (flashcardiologia@gmail.com) consegue chamar; qualquer outra conta,
-- mesmo logada, recebe o erro "forbidden". Dias no horário de Brasília.

alter table public.visit_events add column if not exists convite text;

drop function if exists public.track_visit_event(uuid, text, integer, text, text);

create or replace function public.track_visit_event(
  p_visit    uuid,
  p_evento   text,
  p_passo    integer default null,
  p_origem   text default null,
  p_aparelho text default null,
  p_convite  text default null
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
  insert into public.visit_events (visit, evento, passo, origem, aparelho, convite)
  values (
    p_visit,
    p_evento,
    case when p_passo between 0 and 9 then p_passo::smallint else null end,
    case when p_evento = 'tela' then nullif(left(lower(trim(coalesce(p_origem, ''))), 60), '') else null end,
    case when p_evento = 'tela' and p_aparelho in ('celular', 'computador') then p_aparelho else null end,
    case when p_evento = 'tela' and p_convite ~ '^[0-9]{9}$' then p_convite else null end   -- só o código de amigo (9 dígitos)
  );
end;
$$;
revoke all on function public.track_visit_event(uuid, text, integer, text, text, text) from public;
grant execute on function public.track_visit_event(uuid, text, integer, text, text, text) to anon, authenticated;

create or replace function public.admin_acessos_convites(p_dias integer default 30)
returns jsonb
language plpgsql
stable
security definer
set search_path = public, auth
as $$
#variable_conflict use_column
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

  -- Começo do primeiro dia do período, meia-noite de Brasília (igual à admin_acessos).
  v_ini := (date_trunc('day', now() at time zone 'America/Sao_Paulo') - make_interval(days => v_dias - 1)) at time zone 'America/Sao_Paulo';

  with
  tela as (
    select distinct on (e.visit) e.visit, e.convite
      from public.visit_events e
     where e.criado_em >= v_ini and e.evento = 'tela'
     order by e.visit, e.criado_em
  ),
  vis as (
    select t.convite, count(*)::integer as visitas from tela t where t.convite is not null group by t.convite
  ),
  ctas as (
    select p.friend_code as convite, count(*)::integer as contas
      from public.referrals r
      join public.profiles p on p.id = r.inviter_id
     where r.created_at >= v_ini and p.friend_code is not null
     group by p.friend_code
  ),
  cod as (
    select convite from vis union select convite from ctas
  ),
  lista as (
    select c.convite as codigo,
           coalesce(nullif(btrim(pr.name), ''), '(sem nome)') as nome,
           u.email,
           coalesce(v.visitas, 0) as visitas,
           coalesce(k.contas, 0) as contas
      from cod c
      left join vis v on v.convite = c.convite
      left join ctas k on k.convite = c.convite
      left join public.profiles pr on pr.friend_code = c.convite
      left join auth.users u on u.id = pr.id
     order by coalesce(v.visitas, 0) desc, coalesce(k.contas, 0) desc, 2
     limit 50
  )
  select jsonb_build_object(
    'dias', v_dias,
    'visitas_total',   (select count(*) from tela),
    'visitas_convite', (select coalesce(sum(visitas), 0) from vis),
    'contas_convite',  (select coalesce(sum(contas), 0) from ctas),
    'lista', (select coalesce(jsonb_agg(jsonb_build_object('codigo', l.codigo, 'nome', l.nome, 'email', l.email, 'visitas', l.visitas, 'contas', l.contas)
                                        order by l.visitas desc, l.contas desc, l.nome), '[]'::jsonb) from lista l)
  ) into v_out;

  return v_out;
end;
$$;
revoke all on function public.admin_acessos_convites(integer) from public, anon;
grant execute on function public.admin_acessos_convites(integer) to authenticated;
