-- Assinatura vencida: nada se perde, e ao assinar de novo a sequência segue de onde parou.
-- Rode uma vez no SQL Editor do Supabase (depois do assinaturas.sql). Pode rodar de novo.
--
-- O que já é assim, sem precisar de SQL: ninguém apaga dados quando a assinatura vence. Respostas,
-- estatísticas, favoritos, flashcards próprios, sessões antigas e desafios continuam guardados.
--
-- O que este SQL ajusta:
--   1) Sem assinatura, a sequência (dias seguidos da missão) e a melhor sequência ficam CONGELADAS no
--      valor que tinham: não somam e não zeram. (Pessoas que nunca tiveram sequência ficam em 0.)
--      Isto substitui a versão do gatilho que zerava a sequência (missao_gratuita_3_questoes.sql).
--   2) Quando a pessoa assina de novo depois de ficar sem acesso, a sequência é reatada: a data da
--      última missão volta para "ontem", então a próxima missão concluída continua a contagem de
--      onde parou, como se não tivesse parado de assinar. Se ela já fez a missão de hoje, nada muda.

-- ============================================================
-- 1) Gatilho: sem assinatura, a sequência não muda
-- ============================================================
create or replace function public.profiles_free_no_streak()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  if (new.streak is distinct from old.streak or new.best_streak is distinct from old.best_streak)
     and not public._has_access(new.id) then
    new.streak := old.streak;
    new.best_streak := old.best_streak;
  end if;
  return new;
end;
$$;

drop trigger if exists profiles_free_no_streak on public.profiles;
create trigger profiles_free_no_streak
  before update on public.profiles
  for each row execute function public.profiles_free_no_streak();

-- ============================================================
-- 2) Liberar acesso: ao voltar depois de vencer, reata a sequência
--    (mesma função de assinaturas.sql, com o passo novo marcado)
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
  v_was_lapsed boolean;
begin
  select u.id into v_user from auth.users u where lower(u.email) = lower(trim(p_email));
  if v_user is null then
    raise exception 'usuario_nao_encontrado: %', p_email;
  end if;

  v_days := coalesce(p_days, case p_plan when 'mensal' then 30 when 'anual' then 365 else null end);
  if v_days is null then
    raise exception 'informe p_days para o plano %', p_plan;
  end if;

  -- NOVO: estava sem acesso imediatamente antes desta compra?
  select not exists (
    select 1 from public.payments p
     where p.user_id = v_user and p.status = 'approved'
       and p.starts_at <= p_paid_at and p.expires_at > p_paid_at
  ) into v_was_lapsed;

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

  -- NOVO: voltou depois de ficar sem acesso. A sequência ficou congelada; reata de onde parou
  -- (data da última missão = ontem), sem mexer em quem já fez a missão de hoje ou de ontem.
  if v_was_lapsed then
    update public.profiles p
       set last_mission_date = public.app_today() - 1
     where p.id = v_user
       and p.streak > 0
       and (p.last_mission_date is null or p.last_mission_date < public.app_today() - 1);
  end if;

  return query select lower(trim(p_email)), p_plan, v_start, v_end;
end;
$$;
