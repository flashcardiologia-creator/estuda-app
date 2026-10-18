-- Duas etapas, numa rodada só:
--   1) Marca todas as contas atuais (menos as administradoras) como quem já usou o cupom #10DIASGRATIS.
--   2) Reduz o acesso de CORTESIA de todos para no máximo 12 dias, contados do momento em que você rodar.
-- Rode UMA vez no SQL Editor do Supabase. O resultado lista cada acesso alterado (antes e depois).
--
-- Regras da redução (etapa 2):
--   * Só mexe em acessos do plano 'cortesia' (inclui os 30 dias dados a todos e os cupons).
--   * Só REDUZ: quem tem menos de 12 dias de cortesia sobrando continua como está (ninguém ganha dia).
--   * Não mexe nas contas administradoras (flashcardiologia@gmail.com e rodaragaoandrade@gmail.com).
--   * Não mexe em quem tem plano mensal/anual pago ainda valendo (para não abrir buraco entre a
--     cortesia e o plano pago).
--   * Cortesia que ainda nem começou e que só começaria depois dos 12 dias é cancelada.
--   * Nada é apagado: o vencimento antigo fica anotado em "notes" do pagamento.
-- Para ver antes o que será alterado, rode primeiro a consulta de prévia que está no fim deste arquivo.

-- Passo 1: todas as contas que existem hoje (menos as administradoras) passam a constar como quem
-- JÁ USOU o cupom #10DIASGRATIS. Não dá dias a ninguém: só registra o uso, então elas veem
-- "Você já usou este cupom nesta conta". Quem criar conta depois de rodar este SQL ainda pode usar.
-- (Precisa do SQL do cupom já rodado.)
insert into public.coupon_redemptions (user_id, email, code)
select u.id, lower(u.email), c.code
  from auth.users u
 cross join public.coupons c
 where ltrim(c.code, '#') = '10DIASGRATIS'
   and u.email is not null
   and lower(u.email) not in ('flashcardiologia@gmail.com', 'rodaragaoandrade@gmail.com')
on conflict (code, lower(email)) do nothing;

-- Passo 2: reduz as cortesias (o resultado mostrado no fim é o desta etapa).
with alvo as (
  select p.id, p.starts_at, p.expires_at as antes
    from public.payments p
    join auth.users u on u.id = p.user_id
   where p.plan = 'cortesia'
     and p.status = 'approved'
     and p.expires_at > now() + interval '12 days'
     and lower(u.email) not in ('flashcardiologia@gmail.com', 'rodaragaoandrade@gmail.com')
     and not exists (
       select 1 from public.payments q
        where q.user_id = p.user_id
          and q.status = 'approved'
          and q.plan in ('mensal', 'anual')
          and q.expires_at > now()
     )
)
update public.payments p
   set expires_at = case when a.starts_at >= now() + interval '12 days' then p.expires_at else now() + interval '12 days' end,
       status     = case when a.starts_at >= now() + interval '12 days' then 'cancelled' else p.status end,
       notes      = concat_ws(' | ', p.notes,
                    'Cortesia reduzida em ' || to_char(now() at time zone 'America/Sao_Paulo', 'DD/MM/YYYY')
                    || ' (vencia em ' || to_char(a.antes at time zone 'America/Sao_Paulo', 'DD/MM/YYYY') || ')')
  from alvo a
 where p.id = a.id
returning p.email,
          p.status,
          to_char(a.antes at time zone 'America/Sao_Paulo', 'DD/MM/YYYY') as vencia_em,
          to_char(p.expires_at at time zone 'America/Sao_Paulo', 'DD/MM/YYYY') as passa_a_vencer_em;

-- ============================================================
-- PRÉVIA (não altera nada): quem será afetado. Rode só esta consulta antes, se quiser conferir.
--
--   select p.email, p.plan, to_char(p.expires_at at time zone 'America/Sao_Paulo', 'DD/MM/YYYY') as vence_em
--     from public.payments p join auth.users u on u.id = p.user_id
--    where p.plan = 'cortesia' and p.status = 'approved' and p.expires_at > now() + interval '12 days'
--      and lower(u.email) not in ('flashcardiologia@gmail.com', 'rodaragaoandrade@gmail.com')
--      and not exists (select 1 from public.payments q where q.user_id = p.user_id and q.status = 'approved'
--                       and q.plan in ('mensal', 'anual') and q.expires_at > now())
--    order by p.expires_at desc;
--
-- Quem ficou de fora por ter plano pago ainda valendo:
--
--   select distinct p.email from public.payments p
--    where p.plan = 'cortesia' and p.status = 'approved' and p.expires_at > now() + interval '12 days'
--      and exists (select 1 from public.payments q where q.user_id = p.user_id and q.status = 'approved'
--                   and q.plan in ('mensal', 'anual') and q.expires_at > now());
--
-- Para desfazer em UMA pessoa (devolve o vencimento antigo): o antigo está em "notes"; use
--   select * from public.grant_access('pessoa@email.com', 'cortesia', now(), null, 'cortesia', null, <dias>, 'restaurado');
-- ============================================================
