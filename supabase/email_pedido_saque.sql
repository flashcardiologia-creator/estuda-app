-- E-mail de pedido de saque (comissão do Convidar amigos): avisa flashcardiologia@gmail.com na hora.
-- Rode uma vez no SQL Editor do Supabase. Pode rodar de novo sem problema.
--
-- Quando alguém pede o saque pela aba Contato (assunto "Comissão"), o app grava uma mensagem em contact_messages que começa com
-- SOLICITAÇÃO DE COMISSÃO. Este gatilho vê essa mensagem e envia, pelo Resend, um e-mail para flashcardiologia@gmail.com:
--   * assunto com o valor: "Pedido de saque: R$ 300,00 — Nome — e-mail";
--   * no corpo: nome, e-mail e código da pessoa, saldo liberado, aguardando os 7 dias e o que já foi sacado, a mensagem dela
--     (com a chave PIX) e o comando pronto para registrar o pagamento:  select public.admin_registrar_saque('e-mail', valor);
--   * "Responder" no e-mail vai direto para a pessoa.
-- Se o saldo liberado estiver abaixo de 250 pontos, o e-mail sai igual, com um aviso em vermelho (o pedido não deve ser pago).
-- Mensagens comuns do Contato (dúvida, sugestão...) não disparam este e-mail.
--
-- Usa a mesma chave do Resend que já está no Vault (resend_api_key) e o domínio flashcardiologia.com já verificado, como o e-mail
-- de compra confirmada. Se a chave não existir, ou se o envio falhar, a mensagem de Contato continua sendo gravada (o erro é ignorado).
-- Precisa do convite_pontos.sql rodado (de onde vêm os pontos); sem ele o e-mail sai mesmo assim, só que sem os números do saldo.

create extension if not exists pg_net with schema extensions;

create or replace function public.notify_withdrawal_request()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_key       text;
  v_name      text;
  v_email     text;
  v_code      text;
  v_released  integer;
  v_pending   integer;
  v_withdrawn integer;
  v_saldo     integer;
  v_has_bal   boolean := false;
  v_valor     text;
  v_aviso     text := '';
  v_saldo_txt text;
  v_html      text;
  v_msg       text;
begin
  select decrypted_secret into v_key
  from vault.decrypted_secrets
  where name = 'resend_api_key'
  limit 1;

  if v_key is null then
    return new;
  end if;

  select p.name, p.friend_code into v_name, v_code from public.profiles p where p.id = new.user_id;
  select u.email into v_email from auth.users u where u.id = new.user_id;

  -- Saldo da pessoa agora (pontos liberados menos os já sacados). Se o convite_pontos.sql não foi rodado, segue sem os números.
  begin
    select coalesce(sum(r.reward_points) filter (where r.status = 'premiado' and r.release_at <= now()), 0),
           coalesce(sum(r.reward_points) filter (where r.status = 'premiado' and r.release_at > now()), 0)
      into v_released, v_pending
      from public.referrals r where r.inviter_id = new.user_id;
    select coalesce(sum(w.points), 0) into v_withdrawn from public.referral_withdrawals w where w.user_id = new.user_id;
    v_saldo := greatest(0, v_released - v_withdrawn);
    v_has_bal := true;
  exception when others then
    v_has_bal := false;
  end;

  v_valor := case when v_has_bal then 'R$ ' || replace(to_char(v_saldo, 'FM9999990.00'), '.', ',') else 'valor não calculado' end;

  if v_has_bal and v_saldo < 250 then
    v_aviso := '<p style="background:#fdecec;border:1px solid #e5484d;color:#a32226;padding:10px 12px;border-radius:8px"><b>Atenção:</b> o saldo liberado desta pessoa é menor que 250 pontos. Não pague este pedido sem conferir.</p>';
  end if;

  v_saldo_txt := case
    when v_has_bal then format(
      '<tr><td style="padding:6px 0;color:#666">Liberado para saque</td><td style="padding:6px 0"><b>%s</b> (%s pontos)</td></tr>'
      '<tr><td style="padding:6px 0;color:#666">Aguardando 7 dias</td><td style="padding:6px 0">%s pontos</td></tr>'
      '<tr><td style="padding:6px 0;color:#666">Já sacado</td><td style="padding:6px 0">%s pontos</td></tr>',
      v_valor, v_saldo, v_pending, v_withdrawn)
    else '' end;

  v_msg := replace(replace(replace(replace(coalesce(new.mensagem, ''), '&', '&amp;'), '<', '&lt;'), '>', '&gt;'), E'\n', '<br>');

  v_html := format(
    '<div style="font-family:Arial,Helvetica,sans-serif;max-width:560px;color:#1b1830;line-height:1.55">'
    '<h3 style="margin:0 0 12px">Pedido de saque no FlashCardio</h3>'
    '%s'
    '<table style="border-collapse:collapse;margin:8px 0 14px;width:100%%">'
    '<tr><td style="padding:6px 0;color:#666;width:42%%">Pessoa</td><td style="padding:6px 0"><b>%s</b></td></tr>'
    '<tr><td style="padding:6px 0;color:#666">E-mail</td><td style="padding:6px 0">%s</td></tr>'
    '<tr><td style="padding:6px 0;color:#666">Código de amigo</td><td style="padding:6px 0">%s</td></tr>'
    '%s'
    '</table>'
    '<p style="margin:0 0 6px;color:#666">Mensagem da pessoa (com a chave PIX):</p>'
    '<div style="border:1px solid #ddd;border-radius:8px;padding:10px 12px;background:#f7f5ff">%s</div>'
    '<p style="margin:16px 0 6px;color:#666">Depois de pagar o PIX, registre o saque no SQL Editor do Supabase:</p>'
    '<pre style="background:#f3f3f3;border-radius:8px;padding:10px 12px;white-space:pre-wrap;word-break:break-all;font-size:13px">select public.admin_registrar_saque(''%s'', %s);</pre>'
    '<p style="color:#666;font-size:13px">1 ponto = R$ 1,00. Para ver todos os pedidos e os saldos: Painel de dados, aba Comissão.</p>'
    '</div>',
    v_aviso,
    replace(replace(replace(coalesce(nullif(btrim(v_name), ''), '(sem nome)'), '&', '&amp;'), '<', '&lt;'), '>', '&gt;'),
    replace(replace(replace(coalesce(v_email, '(sem e-mail)'), '&', '&amp;'), '<', '&lt;'), '>', '&gt;'),
    coalesce(v_code, '—'),
    v_saldo_txt,
    v_msg,
    replace(replace(replace(replace(coalesce(v_email, ''), '&', '&amp;'), '<', '&lt;'), '>', '&gt;'), '''', ''''''),
    case when v_has_bal then v_saldo::text else '250' end
  );

  perform net.http_post(
    url := 'https://api.resend.com/emails',
    headers := jsonb_build_object(
      'Authorization', 'Bearer ' || v_key,
      'Content-Type', 'application/json'
    ),
    body := jsonb_build_object(
      'from', 'FlashCardio <contato@flashcardiologia.com>',
      'to', jsonb_build_array('flashcardiologia@gmail.com'),
      'reply_to', coalesce(v_email, 'flashcardiologia@gmail.com'),
      'subject', 'Pedido de saque: ' || v_valor || ' — ' || coalesce(nullif(btrim(v_name), ''), '(sem nome)') || coalesce(' — ' || v_email, ''),
      'html', v_html
    )
  );

  return new;
exception when others then
  -- nunca bloquear a mensagem de Contato por falha no e-mail
  return new;
end;
$$;

drop trigger if exists notify_withdrawal_request on public.contact_messages;
create trigger notify_withdrawal_request
  after insert on public.contact_messages
  for each row
  when (new.mensagem ilike 'SOLICITAÇÃO DE COMISSÃO%')
  execute function public.notify_withdrawal_request();
