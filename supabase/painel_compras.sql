-- Painel de dados, aba "Assinantes": números de COMPRAS e de RECEITA no topo (24 h, 72 h, 30 dias, 365 dias e totais).
-- Cria a função public.admin_compras_resumo(), que o app chama nessa aba.
-- Rode UMA vez no SQL Editor do Supabase, DEPOIS do painel_dados_admin.sql. Pode rodar de novo (só recria a função).
-- Só consulta: não altera nenhum dado. Sem este SQL a aba continua mostrando os quatro números de antes (48 h, 7 dias, 30 dias e
-- receita de 30 dias) e avisa que falta rodá-lo.
--
-- Definições (as mesmas do painel_dados_admin.sql):
--   * Compra = pagamento APROVADO de verdade (mensal ou anual). Cortesia não conta, e pagamento estornado ou não aprovado também não.
--   * Receita = soma dos valores dessas compras, em centavos. Cada janela é contada pela data do pagamento (paid_at):
--     "24 h" = nas últimas 24 horas corridas, "72 h" = nas últimas 72 horas, "30 dias" e "365 dias" = 30 e 365 vezes 24 horas até agora.
--   * Totais = desde o começo.
--
-- Segurança: igual à admin_stats. Só a conta administradora (flashcardiologia@gmail.com) consegue chamar; qualquer outra conta,
-- mesmo logada, recebe o erro "forbidden". Para liberar outra, adicione o e-mail na lista abaixo (e em lib/access.js,
-- ADMIN_DASHBOARD_EMAILS, que só controla se o botão do painel aparece).

create or replace function public.admin_compras_resumo()
returns jsonb
language plpgsql
stable
security definer
set search_path = public, auth
as $$
#variable_conflict use_column
declare
  v_email  text;
  v_now    timestamptz := now();
  v_result jsonb;
begin
  select lower(u.email) into v_email from auth.users u where u.id = auth.uid();
  if v_email is null or not (v_email = any (array['flashcardiologia@gmail.com'])) then
    raise exception 'forbidden';
  end if;

  select jsonb_build_object(
           'gerado_em', v_now,
           'compras', jsonb_build_object(
             'h24',   count(*) filter (where p.paid_at >= v_now - interval '24 hours'),
             'h72',   count(*) filter (where p.paid_at >= v_now - interval '72 hours'),
             'd30',   count(*) filter (where p.paid_at >= v_now - interval '30 days'),
             'd365',  count(*) filter (where p.paid_at >= v_now - interval '365 days'),
             'total', count(*)
           ),
           'receita_centavos', jsonb_build_object(
             'h24',   coalesce(sum(p.amount_cents) filter (where p.paid_at >= v_now - interval '24 hours'), 0),
             'd30',   coalesce(sum(p.amount_cents) filter (where p.paid_at >= v_now - interval '30 days'), 0),
             'd365',  coalesce(sum(p.amount_cents) filter (where p.paid_at >= v_now - interval '365 days'), 0),
             'total', coalesce(sum(p.amount_cents), 0)
           )
         )
    into v_result
    from public.payments p
   where p.status = 'approved' and p.method <> 'cortesia';

  return v_result;
end;
$$;

revoke all on function public.admin_compras_resumo() from public, anon;
grant execute on function public.admin_compras_resumo() to authenticated;
