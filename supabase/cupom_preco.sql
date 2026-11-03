-- Cupom de PREÇO: troca o valor de um ou mais planos por preços fixos, de uso único por conta.
-- Primeiro cupom: BLACK50. Plano mensal de R$ 99,00 por R$ 59,00 e plano anual de R$ 468,00 por R$ 358,80 (R$ 29,90 por mês), com os
-- mesmos dias de acesso de cada plano. O mensal começou em R$ 49,00 e passou a R$ 59,00; o anual entrou depois.
-- O preço de cada plano fica em price_coupon_prices (um cupom pode ter um preço por plano).
-- Rode UMA vez no SQL Editor do Supabase (depois do assinaturas.sql). Pode rodar de novo: não apaga nem duplica nada, e rodar de novo
-- também atualiza o preço do BLACK50 se você mudar os números lá embaixo.
--
-- Como funciona:
--   * A pessoa digita o cupom na tela Assinatura. O app pergunta ao banco (check_price_coupon); se vale, o plano mostra
--     o preço novo. Quem não é cupom de preço continua indo para o cupom de dias (#10DIASGRATIS e similares).
--   * Ao tocar em Assinar, o SERVIDOR confere o cupom de novo e RESERVA um uso por 2 horas (reserve_price_coupon). O preço
--     cobrado sai daqui, nunca do navegador. Cobrança abandonada não queima o cupom: a reserva expira.
--   * Quando o Mercado Pago confirma o pagamento, o servidor consome o cupom (consume_price_coupon): confere que o valor
--     pago é pelo menos o do cupom, marca como usado e libera os dias do plano. Uso único = uma vez por conta, em UM dos planos
--     (pelo e-mail da conta; apagar e recriar a conta com o mesmo e-mail não libera outro uso).
--   * Um segundo pagamento com o mesmo cupom (por exemplo, dois checkouts abertos ao mesmo tempo) NÃO é liberado: o
--     servidor registra no log para você conferir e devolver o dinheiro no Mercado Pago.
--   * max_uses (opcional) limita quantas pessoas, no total, podem usar o cupom; vazio = sem limite.
--     valid_until (opcional) é o último momento em que o cupom pode ser aplicado; vazio = sem prazo.
--
-- Só as funções abaixo mexem nas tabelas (sem policies). reserve/consume só o servidor (service_role) chama.

create table if not exists public.price_coupons (
  code        text primary key check (code = upper(code) and code !~ '[#[:space:]]'),
  plan        text not null check (plan in ('mensal', 'anual')),
  price_cents integer not null check (price_cents > 0),
  max_uses    integer check (max_uses is null or max_uses > 0),
  valid_until timestamptz,
  active      boolean not null default true,
  created_at  timestamptz not null default now()
);

create table if not exists public.price_coupon_uses (
  id             uuid primary key default gen_random_uuid(),
  code           text not null references public.price_coupons (code),
  user_id        uuid references auth.users (id) on delete set null,
  email          text not null,
  plan           text not null,
  price_cents    integer not null,                 -- preço combinado na reserva (vale mesmo que o cupom mude depois)
  status         text not null default 'reserved' check (status in ('reserved', 'used', 'released')),
  reserved_until timestamptz not null,
  payment_ref    text,                             -- mp-<número do pagamento> quando usado
  created_at     timestamptz not null default now(),
  used_at        timestamptz
);

-- Uma reserva ou uso por cupom e e-mail: é o que garante o uso único mesmo com dois pedidos ao mesmo tempo.
create unique index if not exists price_coupon_uses_once
  on public.price_coupon_uses (code, lower(email)) where status in ('reserved', 'used');

-- Preço de cada plano do cupom. As colunas plan e price_cents de price_coupons ficam só como o primeiro preço (e para quem cria
-- o cupom no formato antigo, ver o gatilho abaixo); quem manda é esta tabela.
create table if not exists public.price_coupon_prices (
  code        text not null references public.price_coupons (code),
  plan        text not null check (plan in ('mensal', 'anual')),
  price_cents integer not null check (price_cents > 0),
  primary key (code, plan)
);

alter table public.price_coupons enable row level security;
alter table public.price_coupon_uses enable row level security;
alter table public.price_coupon_prices enable row level security;
revoke all on public.price_coupons from anon, authenticated;
revoke all on public.price_coupon_uses from anon, authenticated;
revoke all on public.price_coupon_prices from anon, authenticated;

-- Cupom criado no formato antigo (insert em price_coupons com plan e price_cents) ganha o preço correspondente aqui.
create or replace function public._price_coupon_first_price()
returns trigger
language plpgsql
as $$
begin
  insert into public.price_coupon_prices (code, plan, price_cents) values (new.code, new.plan, new.price_cents)
  on conflict (code, plan) do nothing;
  return new;
end;
$$;
drop trigger if exists price_coupons_first_price on public.price_coupons;
create trigger price_coupons_first_price after insert on public.price_coupons
  for each row execute function public._price_coupon_first_price();

insert into public.price_coupons (code, plan, price_cents)
values ('BLACK50', 'mensal', 5900)
on conflict (code) do nothing;

-- Cupons que já existiam (antes desta tabela) ganham o preço do plano que já tinham.
insert into public.price_coupon_prices (code, plan, price_cents)
select code, plan, price_cents from public.price_coupons
on conflict (code, plan) do nothing;

-- BLACK50: mensal R$ 59,00 e anual R$ 358,80 (R$ 29,90 por mês x 12). Rodar de novo atualiza os dois preços.
insert into public.price_coupon_prices (code, plan, price_cents)
values ('BLACK50', 'mensal', 5900), ('BLACK50', 'anual', 35880)
on conflict (code, plan) do update set price_cents = excluded.price_cents;

-- Se uma versão anterior deste SQL criou o cupom MENSAL49, ele é desligado (não apaga ninguém que já usou).
update public.price_coupons set active = false where code = 'MENSAL49';

-- "#black50", " BLACK50 " e "BLACK50" valem igual.
create or replace function public._price_coupon_code(p_code text)
returns text
language sql
immutable
as $$
  select ltrim(upper(regexp_replace(coalesce(p_code, ''), '\s', '', 'g')), '#');
$$;

-- Situação do cupom para esta conta, sem reservar nada. O app usa para mostrar o preço novo.
-- out_status: ok | invalido | expirado | ja_usado | esgotado
-- Quando está ok, devolve UMA LINHA POR PLANO com preço (mensal primeiro): out_plan e out_price_cents de cada um.
create or replace function public.check_price_coupon(p_code text)
returns table(out_status text, out_code text, out_plan text, out_price_cents integer)
language plpgsql
stable
security definer
set search_path = public, auth
as $$
declare
  v_user  uuid := auth.uid();
  v_email text;
  c       public.price_coupons;
  v_n     integer;
begin
  if v_user is null then
    raise exception 'not_authenticated';
  end if;
  select lower(u.email) into v_email from auth.users u where u.id = v_user;

  select * into c from public.price_coupons where code = public._price_coupon_code(p_code) and active;
  if not found then
    return query select 'invalido'::text, null::text, null::text, null::integer;
    return;
  end if;
  if c.valid_until is not null and now() >= c.valid_until then
    return query select 'expirado'::text, null::text, null::text, null::integer;
    return;
  end if;
  if exists (select 1 from public.price_coupon_uses x where x.code = c.code and lower(x.email) = v_email and x.status = 'used') then
    return query select 'ja_usado'::text, null::text, null::text, null::integer;
    return;
  end if;
  if c.max_uses is not null
     and not exists (select 1 from public.price_coupon_uses x where x.code = c.code and lower(x.email) = v_email
                        and x.status = 'reserved' and x.reserved_until > now()) then
    select count(*) into v_n from public.price_coupon_uses x
     where x.code = c.code and (x.status = 'used' or (x.status = 'reserved' and x.reserved_until > now()));
    if v_n >= c.max_uses then
      return query select 'esgotado'::text, null::text, null::text, null::integer;
      return;
    end if;
  end if;
  return query select 'ok'::text, c.code, pp.plan, pp.price_cents
                 from public.price_coupon_prices pp where pp.code = c.code order by pp.plan desc;
end;
$$;

-- Reserva um uso por 2 horas para esta conta. Só o servidor chama (ao criar a cobrança).
-- out_status: ok | invalido | expirado | ja_usado | esgotado | plano_incorreto
create or replace function public.reserve_price_coupon(p_user_id uuid, p_code text, p_plan text)
returns table(out_status text, out_reservation uuid, out_price_cents integer)
language plpgsql
security definer
set search_path = public, auth
as $$
declare
  v_email text;
  c       public.price_coupons;
  r       public.price_coupon_uses;
  v_n     integer;
  v_price integer;
begin
  select lower(u.email) into v_email from auth.users u where u.id = p_user_id;
  if v_email is null then
    return query select 'invalido'::text, null::uuid, null::integer;
    return;
  end if;

  select * into c from public.price_coupons where code = public._price_coupon_code(p_code) and active;
  if not found then
    return query select 'invalido'::text, null::uuid, null::integer;
    return;
  end if;
  -- Um cupom por vez: dois pedidos ao mesmo tempo para o mesmo cupom esperam um ao outro.
  perform pg_advisory_xact_lock(hashtext('price_coupon:' || c.code));

  if c.valid_until is not null and now() >= c.valid_until then
    return query select 'expirado'::text, null::uuid, null::integer;
    return;
  end if;
  select pp.price_cents into v_price from public.price_coupon_prices pp where pp.code = c.code and pp.plan = p_plan;
  if v_price is null then
    return query select 'plano_incorreto'::text, null::uuid, null::integer;
    return;
  end if;
  if exists (select 1 from public.price_coupon_uses x where x.code = c.code and lower(x.email) = v_email and x.status = 'used') then
    return query select 'ja_usado'::text, null::uuid, null::integer;
    return;
  end if;

  -- Reserva vencida desta conta libera a vaga; reserva ainda válida é reaproveitada (a pessoa pode tentar de novo).
  update public.price_coupon_uses x set status = 'released'
   where x.code = c.code and lower(x.email) = v_email and x.status = 'reserved' and x.reserved_until <= now();
  select * into r from public.price_coupon_uses x
   where x.code = c.code and lower(x.email) = v_email and x.status = 'reserved';
  if found then
    -- A pessoa pode trocar de plano com a reserva aberta: a mesma reserva passa para o plano e o preço novos.
    update public.price_coupon_uses set reserved_until = now() + interval '2 hours', plan = p_plan, price_cents = v_price where id = r.id;
    return query select 'ok'::text, r.id, v_price;
    return;
  end if;

  if c.max_uses is not null then
    select count(*) into v_n from public.price_coupon_uses x
     where x.code = c.code and (x.status = 'used' or (x.status = 'reserved' and x.reserved_until > now()));
    if v_n >= c.max_uses then
      return query select 'esgotado'::text, null::uuid, null::integer;
      return;
    end if;
  end if;

  insert into public.price_coupon_uses (code, user_id, email, plan, price_cents, reserved_until)
  values (c.code, p_user_id, v_email, p_plan, v_price, now() + interval '2 hours')
  returning * into r;
  return query select 'ok'::text, r.id, r.price_cents;
end;
$$;

-- Consome a reserva quando o pagamento foi aprovado. Só o servidor chama (no aviso do Mercado Pago).
-- Confere o valor pago ANTES de gastar o cupom. Chamar de novo com o mesmo pagamento devolve ok (reenvio do aviso).
-- out_status: ok | invalido | valor_menor | ja_usado
create or replace function public.consume_price_coupon(p_reservation uuid, p_user_id uuid, p_plan text, p_payment_ref text, p_paid_cents integer)
returns table(out_status text)
language plpgsql
security definer
set search_path = public, auth
as $$
declare
  r public.price_coupon_uses;
begin
  select * into r from public.price_coupon_uses x where x.id = p_reservation and x.user_id = p_user_id for update;
  if not found or r.plan <> p_plan then
    return query select 'invalido'::text;
    return;
  end if;
  if r.status = 'used' then
    return query select case when r.payment_ref = p_payment_ref then 'ok' else 'ja_usado' end::text;
    return;
  end if;
  if p_paid_cents is null or p_paid_cents < r.price_cents then
    return query select 'valor_menor'::text;
    return;
  end if;
  begin
    -- O dinheiro entrou, então este pagamento vale mesmo que a reserva dele tenha vencido. Se a pessoa tocou em Assinar de novo
    -- depois do vencimento e ficou com outra reserva em aberto, essa outra é liberada (ela pagou este código, não aquele).
    -- Só um uso JÁ GASTO por outro pagamento recusa: o índice único barra e fica como ja_usado (o servidor avisa no log).
    update public.price_coupon_uses x set status = 'released'
     where x.code = r.code and lower(x.email) = lower(r.email) and x.status = 'reserved' and x.id <> r.id;
    update public.price_coupon_uses set status = 'used', payment_ref = p_payment_ref, used_at = now() where id = r.id;
  exception when unique_violation then
    return query select 'ja_usado'::text;
    return;
  end;
  return query select 'ok'::text;
end;
$$;

revoke all on function public._price_coupon_first_price() from public, anon, authenticated;
revoke all on function public._price_coupon_code(text) from public, anon;
revoke all on function public.check_price_coupon(text) from public, anon;
revoke all on function public.reserve_price_coupon(uuid, text, text) from public, anon, authenticated;
revoke all on function public.consume_price_coupon(uuid, uuid, text, text, integer) from public, anon, authenticated;
grant execute on function public._price_coupon_code(text) to authenticated, service_role;
grant execute on function public.check_price_coupon(text) to authenticated;
grant execute on function public.reserve_price_coupon(uuid, text, text) to service_role;
grant execute on function public.consume_price_coupon(uuid, uuid, text, text, integer) to service_role;

-- ============================================================
-- Depois, para consultar ou mexer (rode uma consulta por vez):
--
--   -- Quem usou ou reservou:
--   select code, email, status, price_cents, payment_ref, created_at, used_at from public.price_coupon_uses order by created_at desc;
--
--   -- Encerrar o cupom:
--   update public.price_coupons set active = false where code = 'BLACK50';
--
--   -- Limitar a 50 pessoas e dar prazo até 00:00 de 01/12/2026 (Brasília):
--   update public.price_coupons set max_uses = 50, valid_until = '2026-12-01 00:00:00-03' where code = 'BLACK50';
--
--   -- Criar outro (código sempre em MAIÚSCULAS, sem # e sem espaço; preço em centavos). O primeiro preço vai junto;
--   -- para outro plano do mesmo cupom, acrescente em price_coupon_prices:
--   insert into public.price_coupons (code, plan, price_cents) values ('ANUAL390', 'anual', 39000);
--   insert into public.price_coupon_prices (code, plan, price_cents) values ('ANUAL390', 'mensal', 7900);
--
--   -- Mudar o preço de um plano do cupom:
--   update public.price_coupon_prices set price_cents = 34900 where code = 'BLACK50' and plan = 'anual';
--
--   -- Liberar de novo uma pessoa que já usou (apaga o uso dela):
--   delete from public.price_coupon_uses where code = 'BLACK50' and lower(email) = 'pessoa@email.com';
-- ============================================================
