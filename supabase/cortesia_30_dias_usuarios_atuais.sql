-- Dá 30 dias de acesso (cortesia) a todos os usuários que já têm conta, a partir de agora.
-- Rode DEPOIS de assinaturas.sql e logo antes de publicar a trava, porque os 30 dias contam
-- a partir do momento em que você roda.
--
-- Pula quem já tem acesso ativo (por exemplo, as contas administradoras). Pode rodar de novo sem
-- problema: ninguém ganha duas vezes. Quem criar conta depois não entra aqui.

select count(*) as usuarios_beneficiados
from (
  select public.grant_access(
           u.email,
           'cortesia',
           now(),
           null,
           'cortesia',
           'cortesia-30d-lancamento-' || u.id::text,
           30,
           'Cortesia de 30 dias para usuários existentes no lançamento da assinatura'
         )
  from auth.users u
  where u.email is not null
    and not exists (
      select 1 from public.payments p
       where p.user_id = u.id
         and p.status = 'approved'
         and p.starts_at <= now()
         and p.expires_at > now()
    )
) t;

-- Conferência: quantos têm acesso ativo agora, por plano.
select plan, count(*) as pessoas, min(expires_at) as vence_primeiro, max(expires_at) as vence_ultimo
from public.payments
where status = 'approved' and starts_at <= now() and expires_at > now()
group by plan
order by plan;
