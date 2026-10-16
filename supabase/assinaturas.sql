-- Assinaturas e trava de acesso.
-- Rode uma vez no SQL Editor do Supabase. Pode rodar de novo sem problema.
--
-- Regras:
--   * Quem não tem assinatura ativa fica sem Questões e sem Flashcards no app.
--   * Missão diária, ranking, estatísticas e conta ficam livres.
--   * Desafios: sem assinatura ativa, só 1 desafio criado por dia (com assinatura, até 5).
--   * Plano mensal = 30 dias; plano anual = 365 dias, contados a partir do dia do pagamento.
--     Pagou antes de vencer: os dias novos entram depois do fim do período atual.
--   * "cortesia" = acesso liberado por você, com o número de dias que quiser (testes, administradores).
--   * Trial (período de teste) não existe por enquanto: quem não pagou fica travado.
--
-- Quem grava pagamentos é só você (SQL Editor) ou, no futuro, o servidor do Mercado Pago.
-- O app (anon/authenticated) só consegue LER o próprio pagamento.

-- ============================================================
-- 1) Configuração: interruptor geral da trava
-- ============================================================
create table if not exists public.app_settings (
  key        text primary key,
  value      text not null,
  updated_at timestamptz not null default now()
);

-- Sem policies de propósito: só as funções abaixo (security definer) leem esta tabela.
alter table public.app_settings enable row level security;

insert into public.app_settings (key, value) values ('paywall_enabled', 'true')
on conflict (key) do nothing;

-- Para desligar a trava de todo mundo (emergência), rode:
--   update public.app_settings set value = 'false', updated_at = now() where key = 'paywall_enabled';
-- Para ligar de novo:
--   update public.app_settings set value = 'true', updated_at = now() where key = 'paywall_enabled';

create or replace function public.paywall_enabled()
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select coalesce((select value = 'true' from public.app_settings where key = 'paywall_enabled'), true);
$$;

-- ============================================================
-- 2) Pagamentos (histórico) — quem pagou, quando e até quando
-- ============================================================
create table if not exists public.payments (
  id            uuid primary key default gen_random_uuid(),
  -- on delete set null: o registro financeiro sobrevive à exclusão da conta (e-mail fica guardado).
  user_id       uuid references auth.users (id) on delete set null,
  email         text not null,
  plan          text not null check (plan in ('mensal', 'anual', 'cortesia')),
  days          integer not null check (days > 0),
  amount_cents  integer,                       -- valor pago, em centavos (ex.: R$ 29,90 = 2990)
  method        text not null default 'transferencia'
                check (method in ('transferencia', 'mercado_pago', 'cortesia', 'outro')),
  external_ref  text,                          -- id do pagamento no Mercado Pago (evita lançar duas vezes)
  status        text not null default 'approved'
                check (status in ('approved', 'pending', 'refunded', 'cancelled')),
  paid_at       timestamptz not null default now(),   -- dia do pagamento
  starts_at     timestamptz not null,                 -- começo do período liberado
  expires_at    timestamptz not null,                 -- fim do período liberado
  notes         text,
  created_at    timestamptz not null default now()
);

create unique index if not exists payments_external_ref_key
  on public.payments (external_ref) where external_ref is not null;
create index if not exists payments_user_idx on public.payments (user_id, expires_at desc);
create index if not exists payments_email_idx on public.payments (lower(email));

alter table public.payments enable row level security;

drop policy if exists "payments_select_own" on public.payments;
create policy "payments_select_own"
  on public.payments for select
  to authenticated
  using (user_id = auth.uid());

revoke insert, update, delete on public.payments from anon, authenticated;

-- ============================================================
-- 3) Quem tem acesso agora?
-- ============================================================
-- Uso interno (triggers e funções). Não fica exposta ao app.
create or replace function public._has_access(p_user uuid)
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select not public.paywall_enabled()
      or exists (
        select 1 from public.payments p
        where p.user_id = p_user
          and p.status = 'approved'
          and p.starts_at <= now()
          and p.expires_at > now()
      );
$$;

revoke all on function public._has_access(uuid) from public, anon, authenticated;

-- Situação de quem está logado: o app usa para liberar ou travar Questões e Flashcards.
create or replace function public.my_access()
returns table(
  active          boolean,
  plan            text,
  expires_at      timestamptz,
  days_left       integer,
  paywall_enabled boolean,
  last_expired_at timestamptz
)
language plpgsql
stable
security definer
set search_path = public
as $$
#variable_conflict use_column
declare
  v_user uuid := auth.uid();
  v_plan text;
  v_exp timestamptz;
  v_last timestamptz;
begin
  if v_user is null then
    raise exception 'not_authenticated';
  end if;

  select p.plan, p.expires_at into v_plan, v_exp
    from public.payments p
    where p.user_id = v_user and p.status = 'approved' and p.starts_at <= now() and p.expires_at > now()
    order by p.expires_at desc
    limit 1;

  select max(p.expires_at) into v_last
    from public.payments p
    where p.user_id = v_user and p.status = 'approved' and p.expires_at <= now();

  return query select
    public._has_access(v_user),
    v_plan,
    v_exp,
    case when v_exp is null then null else greatest(0, ceil(extract(epoch from (v_exp - now())) / 86400.0))::integer end,
    public.paywall_enabled(),
    v_last;
end;
$$;

revoke all on function public.my_access() from public, anon;
grant execute on function public.my_access() to authenticated;

-- ============================================================
-- 4) Liberar acesso (você, no SQL Editor; depois, o Mercado Pago)
-- ============================================================
create or replace function public.grant_access(
  p_email        text,
  p_plan         text,                          -- 'mensal' | 'anual' | 'cortesia'
  p_paid_at      timestamptz default now(),
  p_amount_cents integer default null,
  p_method       text default 'transferencia',
  p_external_ref text default null,
  p_days         integer default null,          -- obrigatório só na 'cortesia'
  p_notes        text default null
)
returns table(out_email text, out_plan text, out_starts_at timestamptz, out_expires_at timestamptz)
language plpgsql
security definer
set search_path = public, auth
as $$
declare
  v_user  uuid;
  v_days  integer;
  v_start timestamptz;
  v_end   timestamptz;
begin
  select u.id into v_user from auth.users u where lower(u.email) = lower(trim(p_email));
  if v_user is null then
    raise exception 'usuario_nao_encontrado: %', p_email;
  end if;

  v_days := coalesce(p_days, case p_plan when 'mensal' then 30 when 'anual' then 365 else null end);
  if v_days is null then
    raise exception 'informe p_days para o plano %', p_plan;
  end if;

  -- Pagou antes de vencer: os dias novos começam quando o período atual termina.
  select greatest(p_paid_at, max(p.expires_at)) into v_start
    from public.payments p
    where p.user_id = v_user and p.status = 'approved' and p.expires_at > p_paid_at;
  v_start := coalesce(v_start, p_paid_at);
  v_end := v_start + make_interval(days => v_days);

  insert into public.payments
    (user_id, email, plan, days, amount_cents, method, external_ref, status, paid_at, starts_at, expires_at, notes)
  values
    (v_user, lower(trim(p_email)), p_plan, v_days, p_amount_cents, p_method, p_external_ref, 'approved', p_paid_at, v_start, v_end, p_notes)
  on conflict (external_ref) where external_ref is not null do nothing;

  return query select lower(trim(p_email)), p_plan, v_start, v_end;
end;
$$;

revoke all on function public.grant_access(text, text, timestamptz, integer, text, text, integer, text) from public, anon, authenticated;
grant execute on function public.grant_access(text, text, timestamptz, integer, text, text, integer, text) to service_role;

-- ============================================================
-- 5) Desafios: sem assinatura ativa, 1 desafio criado por dia
-- ============================================================
create or replace function public.challenges_free_limit()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  if not public._has_access(new.from_user) then
    if (select count(*) from public.challenges c
         where c.from_user = new.from_user
           and public.app_date(c.created_at) = public.app_today()) >= 1 then
      raise exception 'limite_gratuito_desafio';
    end if;
  end if;
  return new;
end;
$$;

drop trigger if exists challenges_free_limit on public.challenges;
create trigger challenges_free_limit
  before insert on public.challenges
  for each row execute function public.challenges_free_limit();

-- ============================================================
-- 6) Contas administradoras: acesso de cortesia por 10 anos
-- ============================================================
select public.grant_access(u.email, 'cortesia', now(), null, 'cortesia', 'cortesia-admin-' || lower(u.email), 3650, 'Conta administradora')
from auth.users u
where lower(u.email) in ('flashcardiologia@gmail.com', 'rodaragaoandrade@gmail.com');

-- ============================================================
-- Como usar no dia a dia (copie, troque o e-mail e rode):
--
--   -- Pagamento mensal (30 dias), R$ 29,90 por transferência, hoje:
--   select * from public.grant_access('pessoa@email.com', 'mensal', now(), 2990, 'transferencia');
--
--   -- Pagamento anual (365 dias) feito em outra data:
--   select * from public.grant_access('pessoa@email.com', 'anual', '2026-10-20 14:30-03', 29900, 'transferencia');
--
--   -- Cortesia de 15 dias para teste:
--   select * from public.grant_access('pessoa@email.com', 'cortesia', now(), null, 'cortesia', null, 15, 'teste');
--
--   -- Quem está com acesso agora:
--   select email, plan, paid_at, expires_at from public.payments
--   where status = 'approved' and starts_at <= now() and expires_at > now() order by expires_at;
--
--   -- Estornar um pagamento (tira o acesso desse período):
--   update public.payments set status = 'refunded' where id = '<id do pagamento>';
-- ============================================================
