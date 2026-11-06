-- Convite de amigos por link.
-- O link leva o código de amigo de quem convida (profiles.friend_code): flashcardiologia.com/?ref=<código>. O cadastro guarda esse código
-- no metadata do signUp (campo "ref") e um gatilho em auth.users registra o convite em public.referrals.
-- Quando o convidado fecha o PRIMEIRO plano pago (mensal ou anual, pagamento aprovado, Mercado Pago ou transferência), os DOIS ganham
-- dias de cortesia: mensal = 3 dias, anual = 14 dias. Os dias entram depois do fim do plano de cada um (ou na hora, se estava sem plano).
-- Estorno ou cancelamento do plano do convidado desfaz os dias dos dois.
-- Seguro para rodar de novo. Rode no SQL Editor do Supabase (depois do assinaturas.sql). Não mexe em contas existentes.

-- Quantos dias cada plano rende (mude aqui se quiser outro valor; vale para os convites novos).
create or replace function public._referral_days(p_plan text)
returns integer
language sql
immutable
as $$
  select case p_plan when 'mensal' then 3 when 'anual' then 14 else 0 end;
$$;

create table if not exists public.referrals (
  invitee_id        uuid primary key references auth.users (id) on delete cascade,   -- quem foi convidado (um convite por conta)
  inviter_id        uuid not null references auth.users (id) on delete cascade,      -- quem convidou
  code              text not null,
  status            text not null default 'pendente' check (status in ('pendente', 'premiado', 'revertido')),
  reward_plan       text,
  reward_days       integer,
  reward_payment_id uuid,                                                              -- pagamento do convidado que gerou o prêmio
  created_at        timestamptz not null default now(),
  rewarded_at       timestamptz,
  constraint referrals_not_self check (inviter_id <> invitee_id)
);
create index if not exists referrals_inviter_idx on public.referrals (inviter_id, created_at desc);

alter table public.referrals enable row level security;
revoke all on public.referrals from anon, authenticated;   -- só as funções abaixo (e o service role) leem e gravam

-- ============================================================
-- 1) Cadastro: registra quem convidou. Nunca impede o cadastro.
-- ============================================================
create or replace function public._referral_from_signup()
returns trigger
language plpgsql
security definer
set search_path = public, auth
as $$
declare
  v_code    text := regexp_replace(coalesce(new.raw_user_meta_data ->> 'ref', ''), '\D', '', 'g');
  v_inviter uuid;
begin
  if v_code = '' or length(v_code) > 12 then
    return new;
  end if;
  select p.id into v_inviter from public.profiles p where p.friend_code = v_code;
  if v_inviter is null or v_inviter = new.id then
    return new;
  end if;
  insert into public.referrals (invitee_id, inviter_id, code) values (new.id, v_inviter, v_code)
  on conflict (invitee_id) do nothing;
  return new;
exception when others then
  return new;
end
$$;

drop trigger if exists referral_from_signup on auth.users;
create trigger referral_from_signup
  after insert on auth.users
  for each row execute function public._referral_from_signup();

-- ============================================================
-- 2) Primeiro plano pago do convidado: os dois ganham dias. Nunca impede o registro do pagamento.
-- ============================================================
create or replace function public._referral_reward()
returns trigger
language plpgsql
security definer
set search_path = public, auth
as $$
declare
  r         public.referrals%rowtype;
  v_days    integer;
  v_inviter text;
begin
  if new.status <> 'approved' or new.plan not in ('mensal', 'anual') or new.method = 'cortesia' or new.user_id is null then
    return new;
  end if;

  select * into r from public.referrals where invitee_id = new.user_id and status = 'pendente' for update;
  if not found then
    return new;
  end if;

  v_days := public._referral_days(new.plan);
  select u.email into v_inviter from auth.users u where u.id = r.inviter_id;
  if v_days <= 0 or v_inviter is null then
    return new;
  end if;

  perform public.grant_access(new.email, 'cortesia', now(), null, 'cortesia',
    'convite-' || r.invitee_id || '-convidado', v_days, 'Convite de amigo: plano ' || new.plan || ' fechado (convidado)');
  perform public.grant_access(v_inviter, 'cortesia', now(), null, 'cortesia',
    'convite-' || r.invitee_id || '-anfitriao', v_days, 'Convite de amigo: plano ' || new.plan || ' fechado pelo convidado');

  update public.referrals
     set status = 'premiado', reward_plan = new.plan, reward_days = v_days, reward_payment_id = new.id, rewarded_at = now()
   where invitee_id = r.invitee_id;
  return new;
exception when others then
  return new;   -- o pagamento nunca fica de fora por causa do convite
end
$$;

drop trigger if exists referral_reward on public.payments;
create trigger referral_reward
  after insert on public.payments
  for each row execute function public._referral_reward();

-- ============================================================
-- 3) Estorno ou cancelamento do plano que gerou o prêmio: tira os dias dos dois.
--    Os períodos que vinham depois andam para trás, para não sobrar buraco sem acesso.
-- ============================================================
create or replace function public._referral_revert()
returns trigger
language plpgsql
security definer
set search_path = public, auth
as $$
declare
  r public.referrals%rowtype;
  b public.payments%rowtype;
begin
  select * into r from public.referrals where reward_payment_id = new.id and status = 'premiado' for update;
  if not found then
    return new;
  end if;

  for b in
    select * from public.payments
     where external_ref in ('convite-' || r.invitee_id || '-convidado', 'convite-' || r.invitee_id || '-anfitriao')
       and status = 'approved'
  loop
    update public.payments
       set starts_at = starts_at - make_interval(days => b.days), expires_at = expires_at - make_interval(days => b.days)
     where user_id = b.user_id and status = 'approved' and id <> b.id and starts_at >= b.expires_at;
    update public.payments
       set status = 'cancelled', notes = coalesce(notes || ' | ', '') || 'desfeito: plano do convidado foi estornado'
     where id = b.id;
  end loop;

  update public.referrals set status = 'revertido' where invitee_id = r.invitee_id;
  return new;
exception when others then
  return new;
end
$$;

drop trigger if exists referral_revert on public.payments;
create trigger referral_revert
  after update of status on public.payments
  for each row
  when (old.status = 'approved' and new.status in ('refunded', 'cancelled'))
  execute function public._referral_revert();

-- ============================================================
-- 4) Para a tela "Convidar amigos": o código de quem está logado, os totais e os últimos convidados.
-- ============================================================
create or replace function public.my_referral()
returns jsonb
language plpgsql
stable
security definer
set search_path = public
as $$
declare
  v_user uuid := auth.uid();
begin
  if v_user is null then
    raise exception 'not_authenticated';
  end if;
  return (
    select jsonb_build_object(
      'code', (select p.friend_code from public.profiles p where p.id = v_user),
      'invited', count(*),
      'rewarded', count(*) filter (where r.status = 'premiado'),
      'days', coalesce(sum(r.reward_days) filter (where r.status = 'premiado'), 0),
      'list', coalesce((
        select jsonb_agg(jsonb_build_object('name', coalesce(nullif(btrim(pr.name), ''), 'Amigo'), 'status', x.status, 'plan', x.reward_plan, 'days', x.reward_days) order by x.created_at desc)
          from (select * from public.referrals where inviter_id = v_user order by created_at desc limit 20) x
          left join public.profiles pr on pr.id = x.invitee_id
      ), '[]'::jsonb)
    )
    from public.referrals r where r.inviter_id = v_user
  );
end
$$;

revoke all on function public.my_referral() from public, anon;
grant execute on function public.my_referral() to authenticated;

-- Conferência: quantos convites existem e quantos já deram prêmio (nasce zerado).
select status, count(*) as convites from public.referrals group by status
union all select 'total', count(*) from public.referrals;
