-- E-mail de compra confirmada: para quem pagou e para o administrador.
-- Rode uma vez no SQL Editor do Supabase. Pode rodar de novo sem problema.
--
-- Sempre que um pagamento aprovado é registrado na tabela payments (pelo Mercado Pago ou por
-- grant_access), o banco envia, pelo Resend:
--   1) para quem pagou: "Compra confirmada" com plano, valor e data até a qual o acesso vale;
--   2) para flashcardiologia@gmail.com: "Compra realizada: R$ 99,00 — Plano Mensal — e-mail",
--      com o valor no assunto, e os detalhes da compra no corpo.
-- Não envia para acessos de cortesia, nem quando o pagamento é repetido (o registro duplicado não
-- é gravado, então o e-mail também não sai duas vezes).
--
-- Usa a mesma chave do Resend que já está no Vault (resend_api_key), a mesma dos e-mails de
-- reporte e de contato, e o domínio flashcardiologia.com já verificado. Se a chave não existir,
-- ou se o envio falhar, o pagamento continua sendo gravado normalmente (o erro é ignorado).

create extension if not exists pg_net with schema extensions;

create or replace function public.notify_payment_confirmed()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_key     text;
  v_name    text;
  v_plan    text;
  v_valor   text;
  v_ate     text;
  v_pago    text;
  v_metodo  text;
  v_html_cliente text;
  v_html_admin   text;
begin
  if new.status <> 'approved' or new.method = 'cortesia' then
    return new;
  end if;

  select decrypted_secret into v_key
  from vault.decrypted_secrets
  where name = 'resend_api_key'
  limit 1;

  if v_key is null then
    return new;
  end if;

  select p.name into v_name from public.profiles p where p.id = new.user_id;

  v_plan := case new.plan when 'mensal' then 'Mensal' when 'anual' then 'Anual' else initcap(new.plan) end;
  v_valor := case
    when new.amount_cents is null then null
    else 'R$ ' || replace(to_char(new.amount_cents / 100.0, 'FM9999990.00'), '.', ',')
  end;
  v_ate := to_char(new.expires_at at time zone 'America/Sao_Paulo', 'DD/MM/YYYY');
  v_pago := to_char(new.paid_at at time zone 'America/Sao_Paulo', 'DD/MM/YYYY HH24:MI');
  v_metodo := case new.method
    when 'mercado_pago' then 'Mercado Pago'
    when 'transferencia' then 'Transferência bancária'
    else 'Outro'
  end;

  -- E-mail para quem pagou
  v_html_cliente := format(
    '<div style="font-family:Arial,Helvetica,sans-serif;max-width:520px;margin:0 auto;color:#1b1830;line-height:1.55">'
    '<h2 style="margin:0 0 14px">Compra confirmada!</h2>'
    '<p>Olá%s, recebemos o seu pagamento e o seu acesso ao FlashCardio já está liberado.</p>'
    '<table style="border-collapse:collapse;margin:16px 0;width:100%%">'
    '<tr><td style="padding:8px 0;color:#666">Plano</td><td style="padding:8px 0"><b>%s</b></td></tr>'
    '<tr><td style="padding:8px 0;color:#666">Valor</td><td style="padding:8px 0"><b>%s</b></td></tr>'
    '<tr><td style="padding:8px 0;color:#666">Acesso até</td><td style="padding:8px 0"><b>%s</b></td></tr>'
    '</table>'
    '<p><a href="https://www.flashcardiologia.com" style="display:inline-block;background:#7C5CFC;color:#fff;text-decoration:none;padding:12px 22px;border-radius:10px;font-weight:bold">Abrir o FlashCardio</a></p>'
    '<p style="color:#666;font-size:13px">Dúvidas, ou quer desistir em até 7 dias? É só responder este e-mail.</p>'
    '</div>',
    coalesce(' ' || replace(replace(replace(v_name, '&', '&amp;'), '<', '&lt;'), '>', '&gt;'), ''),
    v_plan,
    coalesce(v_valor, '—'),
    v_ate
  );

  perform net.http_post(
    url := 'https://api.resend.com/emails',
    headers := jsonb_build_object(
      'Authorization', 'Bearer ' || v_key,
      'Content-Type', 'application/json'
    ),
    body := jsonb_build_object(
      'from', 'FlashCardio <contato@flashcardiologia.com>',
      'to', jsonb_build_array(new.email),
      'reply_to', 'flashcardiologia@gmail.com',
      'subject', 'Compra confirmada — FlashCardio Plano ' || v_plan,
      'html', v_html_cliente
    )
  );

  -- E-mail para o administrador (valor no assunto)
  v_html_admin := format(
    '<div style="font-family:Arial,Helvetica,sans-serif;max-width:520px;color:#1b1830;line-height:1.55">'
    '<h3 style="margin:0 0 12px">Nova compra no FlashCardio</h3>'
    '<p><b>Valor:</b> %s<br>'
    '<b>Plano:</b> %s (%s dias)<br>'
    '<b>Cliente:</b> %s%s<br>'
    '<b>Forma de pagamento:</b> %s<br>'
    '<b>Pago em:</b> %s<br>'
    '<b>Acesso até:</b> %s<br>'
    '<b>Referência:</b> %s</p>'
    '</div>',
    coalesce(v_valor, 'não informado'),
    v_plan,
    new.days,
    replace(replace(replace(coalesce(v_name, '(sem nome)'), '&', '&amp;'), '<', '&lt;'), '>', '&gt;'),
    ' — ' || replace(replace(new.email, '&', '&amp;'), '<', '&lt;'),
    v_metodo,
    v_pago,
    v_ate,
    replace(replace(coalesce(new.external_ref, new.id::text), '&', '&amp;'), '<', '&lt;')
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
      'reply_to', new.email,
      'subject', 'Compra realizada: ' || coalesce(v_valor, 'valor não informado') || ' — Plano ' || v_plan || ' — ' || new.email,
      'html', v_html_admin
    )
  );

  return new;
exception when others then
  -- nunca bloquear o registro do pagamento por falha no e-mail
  return new;
end;
$$;

drop trigger if exists payments_notify_confirmed on public.payments;
create trigger payments_notify_confirmed
  after insert on public.payments
  for each row execute function public.notify_payment_confirmed();

-- Para testar (gera uma compra de verdade na sua conta; depois estorne):
--   select * from public.grant_access('seu@email.com', 'mensal', now(), 9900, 'transferencia', 'teste-email-1');
--   update public.payments set status = 'refunded' where external_ref = 'teste-email-1';
