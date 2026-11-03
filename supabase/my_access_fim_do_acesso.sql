-- my_access(): a Minha Conta e a tela de Assinatura passam a mostrar o FIM do acesso, contando os períodos que ainda vão começar.
-- Antes, quem tinha cortesia (por exemplo, os 10 dias do cupom) e pagava um plano antes de ela acabar via só o fim da cortesia, e o
-- plano pago parecia "não contado". Quem já assinava e prolongava também não via o novo vencimento. Os dias já estavam gravados
-- certos; só a exibição mudava. Não altera nenhum pagamento nem o acesso de ninguém.
-- Rode UMA vez no SQL Editor do Supabase. Pode rodar de novo. Não precisa publicar o app: ele já lê esta função.

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

  -- Com acesso agora, mostra até onde o acesso vai de verdade: conta também os períodos que ainda vão começar. Quem paga
  -- antes de a cortesia ou o plano acabar tem os dias novos somados ao fim (grant_access), e a tela precisa mostrar isso.
  -- plan = o plano do período que termina por último (o da compra mais recente).
  if exists (select 1 from public.payments a
              where a.user_id = v_user and a.status = 'approved' and a.starts_at <= now() and a.expires_at > now()) then
    select p.plan, p.expires_at into v_plan, v_exp
      from public.payments p
      where p.user_id = v_user and p.status = 'approved' and p.expires_at > now()
      order by p.expires_at desc
      limit 1;
  end if;

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
