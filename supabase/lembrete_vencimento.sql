-- Lembretes de vencimento da assinatura: e-mail nos dias 7, 3, 1 e 0 antes de acabar.
-- Rode uma vez no SQL Editor do Supabase (depois do assinaturas.sql). Pode rodar de novo.
--
-- Quem dispara: a função agendada do Netlify (netlify/functions/assinatura-lembrete.mjs), todo dia às
-- 9h de Brasília. Ela chama send_expiry_reminders(), que:
--   * acha quem tem assinatura ativa cujo fim cai daqui a 7, 3, 1 ou 0 dias (dias de calendário de
--     Brasília); o fim considera todos os períodos pagos, então quem já prolongou não recebe;
--   * envia o e-mail pelo Resend (mesma chave do Vault dos outros e-mails, resend_api_key);
--   * anota o envio em expiry_reminders, para nunca mandar o mesmo aviso duas vezes no mesmo dia;
--   * devolve quem foi avisado, para a função mandar também a notificação no celular.
-- Se a chave do Resend não existir, nada é enviado nem anotado (tenta de novo no dia seguinte).

create extension if not exists pg_net with schema extensions;

create table if not exists public.expiry_reminders (
  user_id     uuid not null references auth.users (id) on delete cascade,
  expires_on  date not null,        -- data de vencimento (Brasília)
  days_before integer not null,     -- 7, 3, 1 ou 0
  sent_at     timestamptz not null default now(),
  primary key (user_id, expires_on, days_before)
);

alter table public.expiry_reminders enable row level security;   -- sem policies: só o servidor mexe
revoke all on public.expiry_reminders from anon, authenticated;

create or replace function public.send_expiry_reminders()
returns table(user_id uuid, days_before integer, plan text, expires_at timestamptz)
language plpgsql
security definer
set search_path = ''
as $$
#variable_conflict use_column
declare
  v_key     text;
  r         record;
  v_name    text;
  v_plano   text;
  v_data    text;
  v_titulo  text;
  v_assunto text;
  v_texto   text;
  v_cor     text;
  v_restam  text;
  v_html    text;
begin
  select decrypted_secret into v_key
  from vault.decrypted_secrets
  where name = 'resend_api_key'
  limit 1;

  if v_key is null then
    return;
  end if;

  for r in
    with fins as (
      select p.user_id as uid, max(p.expires_at) as fim
        from public.payments p
       where p.status = 'approved' and p.user_id is not null
       group by p.user_id
      having max(p.expires_at) > now()
    )
    select f.uid,
           f.fim,
           (f.fim at time zone 'America/Sao_Paulo')::date - public.app_today() as dias,
           (select p2.plan from public.payments p2
             where p2.user_id = f.uid and p2.status = 'approved'
             order by p2.expires_at desc limit 1) as plano,
           u.email as email
      from fins f
      join auth.users u on u.id = f.uid
     where (f.fim at time zone 'America/Sao_Paulo')::date - public.app_today() in (7, 3, 1, 0)
  loop
    insert into public.expiry_reminders (user_id, expires_on, days_before)
    values (r.uid, (r.fim at time zone 'America/Sao_Paulo')::date, r.dias)
    on conflict do nothing;

    if not found then
      continue;  -- esse aviso já foi enviado
    end if;

    begin
      select p.name into v_name from public.profiles p where p.id = r.uid;
      v_plano := case r.plano when 'mensal' then 'Mensal' when 'anual' then 'Anual' else initcap(r.plano) end;
      v_data := to_char(r.fim at time zone 'America/Sao_Paulo', 'DD/MM/YYYY');

      if r.dias = 0 then
        v_titulo := 'Sua assinatura vence hoje';
        v_assunto := 'Sua assinatura do FlashCardio vence hoje';
        v_restam := 'hoje';
        v_cor := '#B91C1C';
        v_texto := 'Hoje é o último dia da sua assinatura do FlashCardio. Prolongue agora para continuar com Questões e Flashcards amanhã.';
      else
        v_titulo := case when r.dias = 1 then 'Sua assinatura vence amanhã' else 'Sua assinatura vence em ' || r.dias || ' dias' end;
        v_assunto := case when r.dias = 1 then 'Sua assinatura do FlashCardio vence amanhã' else 'Sua assinatura do FlashCardio vence em ' || r.dias || ' dias' end;
        v_restam := case when r.dias = 1 then '1 dia' else r.dias || ' dias' end;
        v_cor := '#B45309';
        v_texto := 'Sua assinatura do FlashCardio termina em ' || v_data || '. Depois disso, Questões e Flashcards ficam bloqueados (a Missão diária e os Desafios continuam livres).';
      end if;

      v_html := format(
        '<div style="background:#EEF0F6;padding:14px;font-family:Arial,Helvetica,sans-serif">'
        '<div style="max-width:520px;margin:0 auto;background:#fff;border-radius:16px;overflow:hidden;color:#1b1830;line-height:1.55">'
        '<div style="background:#050B1E;padding:18px 22px;color:#fff;font-weight:bold;font-size:18px">🔥 FlashCardio</div>'
        '<div style="padding:22px">'
        '<h2 style="margin:0 0 10px;font-size:21px">%s</h2>'
        '<p style="margin:0;font-size:14.5px;color:#3a3750">Olá%s! %s</p>'
        '<table style="border-collapse:collapse;margin:16px 0;width:100%%;border:1px solid #E6E3F2">'
        '<tr><td style="padding:11px 14px;color:#777">Plano atual</td><td style="padding:11px 14px;text-align:right"><b style="color:%s">%s</b></td></tr>'
        '<tr><td style="padding:11px 14px;color:#777;border-top:1px solid #EFEDF7">Vence em</td><td style="padding:11px 14px;text-align:right;border-top:1px solid #EFEDF7"><b style="color:%s">%s</b></td></tr>'
        '<tr><td style="padding:11px 14px;color:#777;border-top:1px solid #EFEDF7">Restam</td><td style="padding:11px 14px;text-align:right;border-top:1px solid #EFEDF7"><b style="color:%s">%s</b></td></tr>'
        '</table>'
        '<p style="margin:0;font-size:14.5px;color:#3a3750">Prolongue agora: os dias novos são somados ao fim do plano atual, então você não perde nenhum dia.</p>'
        '<p style="margin:18px 0 6px"><a href="https://www.flashcardiologia.com/?prolongar=1" style="display:block;text-align:center;background:#7C5CFC;color:#fff;text-decoration:none;font-weight:bold;font-size:15px;padding:14px;border-radius:12px">Prolongar minha assinatura</a></p>'
        '<p style="margin:14px 0 0;font-size:12.5px;color:#777">Você recebe este aviso nos dias 7, 3, 1 e 0 antes do vencimento. Depois de prolongar, os avisos param. Dúvidas? É só responder este e-mail.</p>'
        '</div></div></div>',
        v_titulo,
        coalesce(' ' || replace(replace(replace(v_name, '&', '&amp;'), '<', '&lt;'), '>', '&gt;'), ''),
        v_texto,
        v_cor, v_plano,
        v_cor, v_data,
        v_cor, v_restam
      );

      perform net.http_post(
        url := 'https://api.resend.com/emails',
        headers := jsonb_build_object(
          'Authorization', 'Bearer ' || v_key,
          'Content-Type', 'application/json'
        ),
        body := jsonb_build_object(
          'from', 'FlashCardio <contato@flashcardiologia.com>',
          'to', jsonb_build_array(r.email),
          'reply_to', 'flashcardiologia@gmail.com',
          'subject', v_assunto,
          'html', v_html
        )
      );
    exception when others then
      null;  -- falha no e-mail de uma pessoa não impede as outras nem o aviso no celular
    end;

    user_id := r.uid;
    days_before := r.dias;
    plan := r.plano;
    expires_at := r.fim;
    return next;
  end loop;
end;
$$;

revoke all on function public.send_expiry_reminders() from public, anon, authenticated;
grant execute on function public.send_expiry_reminders() to service_role;

-- Para testar agora (manda e-mail de verdade a quem vence daqui a 7, 3, 1 ou 0 dias):
--   select * from public.send_expiry_reminders();
-- Para criar um caso de teste na sua conta (acesso de cortesia que vence em 7 dias):
--   select * from public.grant_access('seu@email.com', 'cortesia', now(), null, 'cortesia', 'teste-vencimento', 7, 'teste');
-- Depois do teste, apague o caso e o registro de envio:
--   update public.payments set status = 'cancelled' where external_ref = 'teste-vencimento';
--   delete from public.expiry_reminders where user_id = (select id from auth.users where email = 'seu@email.com');
