-- Boas-vindas com cupom: quem criar a conta A PARTIR DE AGORA vê, ao abrir o app, uma janela perguntando
-- se quer ativar o cupom #10DIASGRATIS (10 dias de acesso). "Sim" ativa; depois de ativado, a conta não
-- pode usar o cupom de novo. "Agora não" fecha a janela para sempre (ela não volta), mas a pessoa ainda
-- pode digitar o cupom em Assinatura enquanto ele valer.
-- Rode UMA vez no SQL Editor do Supabase, depois do SQL do cupom (cupom_10diasgratis.sql). Rodar de novo
-- é seguro e NÃO muda a data de corte.
--
-- Como funciona:
--   * coupons.offer_from: a janela só aparece para contas criadas a partir desse momento. Aqui ele é
--     marcado com a hora em que você roda este SQL; contas mais antigas nunca veem a janela.
--   * public.coupon_offer_dismissed: quem respondeu "Agora não".
--   * public.my_coupon_offer(): diz ao app se esta conta deve ver a janela (cupom ligado, no prazo,
--     conta nova, ainda não usou e não dispensou).
--   * public.dismiss_coupon_offer(código): registra o "Agora não".
-- A ativação em si é a mesma função do cupom digitado (redeem_coupon).

alter table public.coupons add column if not exists offer_from timestamptz;

update public.coupons
   set offer_from = now()
 where ltrim(code, '#') = '10DIASGRATIS' and offer_from is null;

create table if not exists public.coupon_offer_dismissed (
  user_id      uuid not null references auth.users (id) on delete cascade,
  code         text not null references public.coupons (code),
  dismissed_at timestamptz not null default now(),
  primary key (user_id, code)
);

alter table public.coupon_offer_dismissed enable row level security;   -- sem policies: só o servidor mexe
revoke all on public.coupon_offer_dismissed from anon, authenticated;

create or replace function public.my_coupon_offer()
returns table(out_code text, out_days integer, out_valid_until timestamptz)
language plpgsql
stable
security definer
set search_path = public, auth
as $$
#variable_conflict use_column
declare
  v_user  uuid := auth.uid();
  v_email text;
  v_created timestamptz;
begin
  if v_user is null then
    raise exception 'not_authenticated';
  end if;

  select lower(u.email), u.created_at into v_email, v_created from auth.users u where u.id = v_user;

  return query
    select c.code, c.days, c.valid_until
      from public.coupons c
     where c.active
       and c.offer_from is not null
       and now() < c.valid_until
       and v_created >= c.offer_from
       and not exists (select 1 from public.coupon_redemptions r where r.code = c.code and lower(r.email) = v_email)
       and not exists (select 1 from public.coupon_offer_dismissed d where d.code = c.code and d.user_id = v_user)
     order by c.offer_from desc
     limit 1;
end;
$$;

revoke all on function public.my_coupon_offer() from public, anon;
grant execute on function public.my_coupon_offer() to authenticated;

create or replace function public.dismiss_coupon_offer(p_code text)
returns void
language plpgsql
security definer
set search_path = public, auth
as $$
begin
  if auth.uid() is null then
    raise exception 'not_authenticated';
  end if;
  insert into public.coupon_offer_dismissed (user_id, code)
  select auth.uid(), c.code from public.coupons c where c.code = upper(trim(p_code))
  on conflict do nothing;
end;
$$;

revoke all on function public.dismiss_coupon_offer(text) from public, anon;
grant execute on function public.dismiss_coupon_offer(text) to authenticated;

-- Para ver quem recebeu/dispensou depois:
--   select u.email, d.dismissed_at from public.coupon_offer_dismissed d join auth.users u on u.id = d.user_id order by d.dismissed_at desc;
--   select email, redeemed_at from public.coupon_redemptions where ltrim(code, '#') = '10DIASGRATIS' order by redeemed_at desc;
-- Para desligar a janela de boas-vindas (o cupom digitado continua valendo):
--   update public.coupons set offer_from = null where ltrim(code, '#') = '10DIASGRATIS';
