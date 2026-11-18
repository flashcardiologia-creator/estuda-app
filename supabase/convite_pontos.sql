-- Convite de amigos por PONTOS (substitui os dias de acesso de quem convida).
-- Rode DEPOIS do convite_amigos.sql. Seguro para rodar de novo. Não mexe em contas, convites nem pagamentos já existentes.
--
-- Regras:
--  * Quem CONVIDA ganha pontos quando o amigo fecha o primeiro plano pago: 10 pontos no mensal, 100 no anual. 1 ponto = R$ 1,00.
--  * Os pontos de cada amigo ficam "aguardando" por 7 dias (prazo de estorno). Passados os 7 dias sem estorno, são liberados para saque.
--    Se o plano do amigo for estornado ou cancelado, os pontos dele deixam de existir.
--  * Saque a partir de 250 pontos liberados. O pedido é feito pela aba Contato (assunto "Comissão"); depois de pagar (PIX), quem administra
--    registra o saque com public.admin_registrar_saque(...) (exemplo no fim). O saque aparece em vermelho (-250) na lista da pessoa.
--  * O AMIGO CONVIDADO continua ganhando dias de acesso: 7 dias, no mensal ou no anual (cortesia, depois do plano dele). Estorno desfaz.
--  * Convites que já tinham sido premiados com dias (antes deste SQL) ficam como estão: não viram pontos.

-- ------------------------------------------------------------
-- 1) Colunas novas no convite: pontos do prêmio e quando eles são liberados.
-- ------------------------------------------------------------
alter table public.referrals add column if not exists reward_points integer;
alter table public.referrals add column if not exists release_at timestamptz;

-- Pontos por plano (mude aqui se quiser outro valor; vale para os convites novos). Os mesmos valores estão em lib/data/referral.js.
create or replace function public._referral_points(p_plan text)
returns integer
language sql
immutable
as $$
  select case p_plan when 'mensal' then 10 when 'anual' then 100 else 0 end;
$$;

-- Dias de acesso do AMIGO CONVIDADO ao fechar o primeiro plano (7 dias, mensal ou anual).
create or replace function public._referral_days(p_plan text)
returns integer
language sql
immutable
as $$
  select case p_plan when 'mensal' then 7 when 'anual' then 7 else 0 end;
$$;

-- ------------------------------------------------------------
-- 2) Saques já pagos (cada linha é um saque; os pontos saem do saldo liberado).
-- ------------------------------------------------------------
create table if not exists public.referral_withdrawals (
  id         uuid primary key default gen_random_uuid(),
  user_id    uuid not null references auth.users (id) on delete cascade,
  points     integer not null check (points > 0),
  created_at timestamptz not null default now(),
  note       text
);
create index if not exists referral_withdrawals_user_idx on public.referral_withdrawals (user_id, created_at desc);

alter table public.referral_withdrawals enable row level security;
revoke all on public.referral_withdrawals from anon, authenticated;   -- só as funções abaixo (e o service role) leem e gravam

-- ------------------------------------------------------------
-- 3) Primeiro plano pago do convidado: ele ganha 7 dias e quem convidou ganha pontos (liberados em 7 dias).
--    Nunca impede o registro do pagamento.
-- ------------------------------------------------------------
create or replace function public._referral_reward()
returns trigger
language plpgsql
security definer
set search_path = public, auth
as $$
declare
  r        public.referrals%rowtype;
  v_days   integer;
  v_points integer;
begin
  if new.status <> 'approved' or new.plan not in ('mensal', 'anual') or new.method = 'cortesia' or new.user_id is null then
    return new;
  end if;

  select * into r from public.referrals where invitee_id = new.user_id and status = 'pendente' for update;
  if not found then
    return new;
  end if;

  v_days := public._referral_days(new.plan);
  v_points := public._referral_points(new.plan);
  if v_days <= 0 or v_points <= 0 then
    return new;
  end if;

  perform public.grant_access(new.email, 'cortesia', now(), null, 'cortesia',
    'convite-' || r.invitee_id || '-convidado', v_days, 'Convite de amigo: plano ' || new.plan || ' fechado (convidado)');

  update public.referrals
     set status = 'premiado', reward_plan = new.plan, reward_days = v_days, reward_points = v_points,
         reward_payment_id = new.id, rewarded_at = now(), release_at = now() + interval '7 days'
   where invitee_id = r.invitee_id;
  return new;
exception when others then
  return new;   -- o pagamento nunca fica de fora por causa do convite
end
$$;

-- (O gatilho referral_reward e a reversão por estorno, _referral_revert, do convite_amigos.sql continuam valendo: o estorno põe o convite em
--  'revertido', e só convites 'premiado' contam pontos.)

-- ------------------------------------------------------------
-- 4) Para a tela "Convidar amigos": código, totais, saldo de pontos, últimos convidados e saques.
--    points = pontos liberados menos os já sacados (o que dá para sacar agora). pending_points = ainda nos 7 dias.
--    Se um estorno chegar depois de um saque, o saldo mostra 0 (nunca negativo) e o ajuste é manual.
-- ------------------------------------------------------------
create or replace function public.my_referral()
returns jsonb
language plpgsql
stable
security definer
set search_path = public
as $$
declare
  v_user      uuid := auth.uid();
  v_released  integer;
  v_pending   integer;
  v_withdrawn integer;
begin
  if v_user is null then
    raise exception 'not_authenticated';
  end if;

  select coalesce(sum(reward_points) filter (where status = 'premiado' and release_at <= now()), 0),
         coalesce(sum(reward_points) filter (where status = 'premiado' and release_at > now()), 0)
    into v_released, v_pending
    from public.referrals where inviter_id = v_user;
  select coalesce(sum(points), 0) into v_withdrawn from public.referral_withdrawals where user_id = v_user;

  return jsonb_build_object(
    'code', (select p.friend_code from public.profiles p where p.id = v_user),
    'invited', (select count(*) from public.referrals where inviter_id = v_user),
    'rewarded', (select count(*) from public.referrals where inviter_id = v_user and status = 'premiado'),
    'points', greatest(0, v_released - v_withdrawn),
    'pending_points', v_pending,
    'withdrawn_points', v_withdrawn,
    'list', coalesce((
      select jsonb_agg(jsonb_build_object(
               'name', coalesce(nullif(btrim(pr.name), ''), 'Amigo'),
               'status', x.status,
               'plan', x.reward_plan,
               'points', x.reward_points,
               'released', (x.status = 'premiado' and coalesce(x.release_at <= now(), true)),
               'release_at', x.release_at,
               'at', coalesce(x.rewarded_at, x.created_at)
             ) order by x.created_at desc)
        from (select * from public.referrals where inviter_id = v_user order by created_at desc limit 20) x
        left join public.profiles pr on pr.id = x.invitee_id
    ), '[]'::jsonb),
    'withdrawals', coalesce((
      select jsonb_agg(jsonb_build_object('points', w.points, 'at', w.created_at) order by w.created_at desc)
        from (select * from public.referral_withdrawals where user_id = v_user order by created_at desc limit 10) w
    ), '[]'::jsonb)
  );
end
$$;

revoke all on function public.my_referral() from public, anon;
grant execute on function public.my_referral() to authenticated;

-- ------------------------------------------------------------
-- 5) Para quem administra: registra um saque PAGO. Só o SQL Editor / service role pode chamar (a pessoa logada não pode).
--    Sem o segundo argumento, saca todo o saldo liberado. Mínimo de 250 pontos; não passa do saldo liberado.
-- ------------------------------------------------------------
create or replace function public.admin_registrar_saque(p_email text, p_points integer default null)
returns jsonb
language plpgsql
security definer
set search_path = public, auth
as $$
declare
  v_user      uuid;
  v_released  integer;
  v_withdrawn integer;
  v_avail     integer;
  v_take      integer;
begin
  select u.id into v_user from auth.users u where lower(u.email) = lower(btrim(p_email));
  if v_user is null then
    raise exception 'usuario nao encontrado: %', p_email;
  end if;

  select coalesce(sum(reward_points) filter (where status = 'premiado' and release_at <= now()), 0) into v_released
    from public.referrals where inviter_id = v_user;
  select coalesce(sum(points), 0) into v_withdrawn from public.referral_withdrawals where user_id = v_user;
  v_avail := v_released - v_withdrawn;
  v_take := coalesce(p_points, v_avail);

  if v_take < 250 then
    raise exception 'saque minimo: 250 pontos (pedido: %, saldo liberado: %)', v_take, v_avail;
  end if;
  if v_take > v_avail then
    raise exception 'saldo liberado insuficiente: % pontos (pedido: %)', v_avail, v_take;
  end if;

  insert into public.referral_withdrawals (user_id, points) values (v_user, v_take);
  return jsonb_build_object('email', p_email, 'pontos_sacados', v_take, 'reais_pagos', v_take, 'saldo_liberado_restante', v_avail - v_take);
end
$$;

revoke all on function public.admin_registrar_saque(text, integer) from public, anon, authenticated;

-- ------------------------------------------------------------
-- Conferência (última consulta): convites por situação, quantos já têm pontos e quantos saques foram registrados.
-- ------------------------------------------------------------
select
  (select count(*) from public.referrals) as convites,
  (select count(*) from public.referrals where status = 'premiado') as premiados,
  (select count(*) from public.referrals where reward_points is not null) as com_pontos,
  (select count(*) from public.referral_withdrawals) as saques;

-- COMO REGISTRAR UM SAQUE PAGO (rode quando pagar o PIX; troque o e-mail):
--   select public.admin_registrar_saque('pessoa@email.com');        -- saca todo o saldo liberado (mínimo 250)
--   select public.admin_registrar_saque('pessoa@email.com', 250);   -- saca só 250 pontos
