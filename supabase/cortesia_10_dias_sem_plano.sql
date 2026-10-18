-- Dá 10 dias de acesso (cortesia) a todos os usuários que estão SEM plano agora, contados do momento
-- em que você rodar. Quem já tem plano valendo (mensal, anual ou cortesia) não é alterado.
-- Rode UMA vez no SQL Editor do Supabase (depois do SQL das assinaturas e do SQL do cupom).
--
-- Também marca essas pessoas como quem já usou o cupom #10DIASGRATIS, para não ganharem mais 10 dias
-- por ele. Quem criar conta depois ainda pode usar o cupom.
--
-- Rodar de novo é seguro: cada pessoa só recebe uma vez (referência 'cortesia10-<id>') e quem acabou
-- de ganhar já aparece com plano. Não envia e-mail de compra (é cortesia). Quem estava com a sequência
-- da missão congelada por plano vencido volta a contar de onde parou.
--
-- O resultado mostra quantas pessoas ganharam e até quando.
--
-- Prévia (não altera nada): quantos receberiam
--   select count(*) from auth.users u where u.email is not null and not exists (
--     select 1 from public.payments y where y.user_id = u.id and y.status = 'approved'
--       and y.starts_at <= now() and y.expires_at > now());

-- Passo 1: marcar como "já usou o cupom".
insert into public.coupon_redemptions (user_id, email, code)
select u.id, lower(u.email), c.code
  from auth.users u
 cross join public.coupons c
 where ltrim(c.code, '#') = '10DIASGRATIS'
   and u.email is not null
   and not exists (
     select 1 from public.payments y
      where y.user_id = u.id and y.status = 'approved'
        and y.starts_at <= now() and y.expires_at > now())
on conflict (code, lower(email)) do nothing;

-- Passo 2: dar os 10 dias.
with alvo as (
  select u.id, u.email
    from auth.users u
   where u.email is not null
     and not exists (
       select 1 from public.payments y
        where y.user_id = u.id and y.status = 'approved'
          and y.starts_at <= now() and y.expires_at > now())
),
dados as (
  select a.email, g.out_expires_at
    from alvo a
   cross join lateral public.grant_access(
     a.email, 'cortesia', now(), null, 'cortesia', 'cortesia10-' || a.id, 10,
     'Cortesia de 10 dias para quem estava sem plano') g
)
select count(*) as usuarios_beneficiados,
       to_char(min(out_expires_at) at time zone 'America/Sao_Paulo', 'DD/MM/YYYY HH24:MI') as acesso_ate
  from dados;
