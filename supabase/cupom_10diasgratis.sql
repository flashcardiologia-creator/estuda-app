-- Cupom "#10DIASGRATIS" (vale também sem o #): na tela Assinatura, a pessoa digita o cupom (maiúsculas ou minúsculas) e ganha
-- 10 dias de acesso de cortesia, contados do momento em que usou. Cada conta usa uma única vez, e o
-- cupom só vale até 01/12/2026 (inclusive, horário de Brasília).
-- Rode uma vez no SQL Editor do Supabase (depois do assinaturas.sql). Pode rodar de novo.
--
-- Como funciona:
--   * public.coupons: os cupons (código sempre em maiúsculas, dias, prazo, ligado/desligado).
--   * public.coupon_redemptions: quem já usou cada cupom. A trava é pelo e-mail da conta, então apagar
--     a conta e criar de novo com o mesmo e-mail não libera um segundo uso.
--   * public.redeem_coupon(código): chamada pelo app. Confere, registra e libera o acesso pela mesma
--     função dos pagamentos (grant_access). Se a pessoa já tem assinatura ativa, os 10 dias entram
--     depois do fim dela. Não envia e-mail de compra (é cortesia).
-- Para criar outro cupom no futuro, é só inserir uma linha em public.coupons (exemplo no fim).

create table if not exists public.coupons (
  code        text primary key check (code = upper(code)),
  days        integer not null check (days > 0),
  valid_until timestamptz not null,           -- a partir daqui o cupom não vale mais
  active      boolean not null default true,
  created_at  timestamptz not null default now()
);

create table if not exists public.coupon_redemptions (
  id          uuid primary key default gen_random_uuid(),
  user_id     uuid references auth.users (id) on delete set null,
  email       text not null,
  code        text not null references public.coupons (code),
  redeemed_at timestamptz not null default now()
);

create unique index if not exists coupon_redemptions_once
  on public.coupon_redemptions (code, lower(email));

alter table public.coupons enable row level security;               -- sem policies: só o servidor mexe
alter table public.coupon_redemptions enable row level security;
revoke all on public.coupons from anon, authenticated;
revoke all on public.coupon_redemptions from anon, authenticated;

-- O cupom pedido: 10 dias, válido durante todo o dia 01/12/2026 (até 00:00 de 02/12, Brasília).
insert into public.coupons (code, days, valid_until)
values ('#10DIASGRATIS', 10, '2026-12-02 00:00:00-03')
on conflict (code) do update set days = excluded.days, valid_until = excluded.valid_until, active = true;

-- Troca do código sem o # (caso o SQL antigo tenha sido rodado antes): desliga esse.
update public.coupons set active = false where code = '10DIASGRATIS';

create or replace function public.redeem_coupon(p_code text)
returns table(out_status text, out_expires_at timestamptz, out_days integer)
language plpgsql
security definer
set search_path = public, auth
as $$
#variable_conflict use_column
declare
  v_user  uuid := auth.uid();
  v_email text;
  v_code  text;
  c       public.coupons;
  v_exp   timestamptz;
begin
  if v_user is null then
    raise exception 'not_authenticated';
  end if;

  -- Maiúsculas ou minúsculas, com ou sem o # na frente: "10diasgratis" e "#10DIASGRATIS" valem igual.
  v_code := ltrim(upper(regexp_replace(coalesce(p_code, ''), '\s', '', 'g')), '#');

  select * into c from public.coupons where ltrim(code, '#') = v_code and active limit 1;
  if not found then
    return query select 'invalido'::text, null::timestamptz, null::integer;
    return;
  end if;

  if now() >= c.valid_until then
    return query select 'expirado'::text, null::timestamptz, null::integer;
    return;
  end if;

  select u.email into v_email from auth.users u where u.id = v_user;

  begin
    insert into public.coupon_redemptions (user_id, email, code) values (v_user, lower(v_email), c.code);
  exception when unique_violation then
    return query select 'ja_usado'::text, null::timestamptz, null::integer;
    return;
  end;

  select g.out_expires_at into v_exp
    from public.grant_access(v_email, 'cortesia', now(), null, 'cortesia',
                             'cupom-' || c.code || '-' || v_user, c.days, 'Cupom ' || c.code) g;

  return query select 'ok'::text, v_exp, c.days;
end;
$$;

revoke all on function public.redeem_coupon(text) from public, anon;
grant execute on function public.redeem_coupon(text) to authenticated;

-- ============================================================
-- Depois, para consultar ou criar outro cupom:
--
--   -- Quem já usou:
--   select code, email, redeemed_at from public.coupon_redemptions order by redeemed_at desc;
--
--   -- Encerrar um cupom antes do prazo:
--   update public.coupons set active = false where code = '#10DIASGRATIS';
--
--   -- Criar outro (código sempre em MAIÚSCULAS; vale até 00:00 da data informada, Brasília):
--   insert into public.coupons (code, days, valid_until) values ('BEMVINDO7', 7, '2027-01-01 00:00:00-03');
--
--   -- Dar mais dias a uma pessoa que já usou o cupom (cortesia manual):
--   select * from public.grant_access('pessoa@email.com', 'cortesia', now(), null, 'cortesia', null, 10, 'cortesia manual');
-- ============================================================
