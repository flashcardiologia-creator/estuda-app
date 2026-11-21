-- Quiz de boas-vindas: quem cria a conta SEM responder o quiz também ganha os dias mínimos (os mesmos de quem acerta 0 questões: 3 dias).
-- Rode UMA vez no SQL Editor do Supabase, DEPOIS do quiz_boas_vindas.sql. Pode rodar de novo sem problema.
--
-- O que muda (só a função public.quiz_boas_vindas_resgatar, que o app chama depois do login):
--   * Conta criada com o quiz respondido: nada muda (3, 5, 7 ou 10 dias conforme os acertos).
--   * Conta criada SEM o quiz (sem quiz_id no cadastro, ou com um quiz que não existe mais ou que outra conta já resgatou):
--     ganha quiz_boas_vindas_dias(0) = 3 dias de cortesia, sozinhos, como se tivesse errado as 3 questões.
--     Para mudar o mínimo, edite a faixa de 0 acertos em quiz_boas_vindas_dias.
--
-- Regras do mínimo (as mesmas do quiz, mais uma):
--   * Cada e-mail ganha uma única vez (também vale se o e-mail já resgatou o quiz antes).
--   * Só conta criada há até 7 dias e só até o fim do cupom (02/12/2026), como no quiz.
--   * Só para quem ainda NÃO recebeu nenhum acesso (nenhum pagamento aprovado, nem cortesia nem cupom): quem já tem plano
--     ou já usou o cupom #10DIASGRATIS não ganha os 3 dias por cima.
--   * Não mexe no cupom #10DIASGRATIS: quem ganhou o mínimo ainda pode digitar o cupom em Assinatura (então pode somar).
--     Para impedir essa soma, como no quiz, é só liberar a linha marcada "OPCIONAL" abaixo.
--
-- Novo retorno do app: out_status = 'ok_sem_quiz' (dias liberados sem quiz). Os demais continuam: ok, sem_quiz, ja_usado,
-- conta_antiga, expirado. Se o app antigo ainda estiver no ar, os dias entram do mesmo jeito (só não aparece o aviso).
-- Quem ganhou sem quiz fica marcado em public.quiz_resgates.sem_quiz = true (para você conferir).

alter table public.quiz_resgates add column if not exists sem_quiz boolean not null default false;

create or replace function public.quiz_boas_vindas_resgatar()
returns table(out_status text, out_acertos integer, out_dias integer, out_expires_at timestamptz)
language plpgsql
security definer
set search_path = public, auth
as $$
#variable_conflict use_column
declare
  v_user    uuid := auth.uid();
  v_email   text;
  v_created timestamptz;
  v_meta    text;
  v_id      uuid;
  v_ate     timestamptz;
  v_dias    integer;
  v_quiz_ok boolean := false;
  t         public.quiz_tentativas;
  v_exp     timestamptz;
begin
  if v_user is null then
    raise exception 'not_authenticated';
  end if;

  select u.email, u.created_at, u.raw_user_meta_data ->> 'quiz_id'
    into v_email, v_created, v_meta
    from auth.users u where u.id = v_user;

  begin
    v_id := v_meta::uuid;
  exception when others then
    v_id := null;
  end;

  select c.valid_until into v_ate from public.coupons c where c.code = '#10DIASGRATIS';
  if v_ate is not null and now() >= v_ate then
    return query select 'expirado'::text, null::integer, null::integer, null::timestamptz;
    return;
  end if;

  if v_created < now() - interval '7 days' then
    return query select 'conta_antiga'::text, null::integer, null::integer, null::timestamptz;
    return;
  end if;

  -- ----------------------------------------------------------------
  -- Há um quiz para resgatar? (cadastro com quiz_id, tentativa existente e ainda não resgatada)
  -- ----------------------------------------------------------------
  if v_id is not null then
    select * into t from public.quiz_tentativas where id = v_id for update;
    v_quiz_ok := found and t.resgatado_por is null;
  end if;

  -- ----------------------------------------------------------------
  -- SEM quiz: os dias mínimos (os de 0 acertos), uma vez por e-mail, só para quem ainda não recebeu acesso nenhum.
  -- ----------------------------------------------------------------
  if not v_quiz_ok then
    if exists (select 1 from public.payments p where p.user_id = v_user and p.status = 'approved') then
      return query select 'sem_quiz'::text, null::integer, null::integer, null::timestamptz;
      return;
    end if;

    v_dias := public.quiz_boas_vindas_dias(0);

    begin
      insert into public.quiz_resgates (user_id, email, acertos, dias, sem_quiz) values (v_user, lower(v_email), 0, v_dias, true);
    exception when unique_violation then
      return query select 'ja_usado'::text, null::integer, null::integer, null::timestamptz;
      return;
    end;

    select g.out_expires_at into v_exp
      from public.grant_access(v_email, 'cortesia', now(), null, 'cortesia',
                               'quiz-sem-' || v_user, v_dias, 'Boas-vindas sem quiz: ' || v_dias || ' dias (mínimo do quiz)') g;

    -- OPCIONAL: para que quem ganhou o mínimo NÃO possa somar o cupom #10DIASGRATIS depois (igual a quem resgata o quiz),
    -- tire os dois "--" do começo das linhas abaixo e rode de novo este arquivo.
    -- insert into public.coupon_redemptions (user_id, email, code)
    -- select v_user, lower(v_email), c.code from public.coupons c where c.code = '#10DIASGRATIS'
    -- on conflict do nothing;

    return query select 'ok_sem_quiz'::text, 0, v_dias, v_exp;
    return;
  end if;

  -- ----------------------------------------------------------------
  -- COM quiz: igual ao que já era.
  -- ----------------------------------------------------------------
  begin
    insert into public.quiz_resgates (user_id, email, acertos, dias) values (v_user, lower(v_email), t.acertos, t.dias);
  exception when unique_violation then
    return query select 'ja_usado'::text, null::integer, null::integer, null::timestamptz;
    return;
  end;

  update public.quiz_tentativas set resgatado_por = v_user, resgatado_em = now() where id = t.id;

  select g.out_expires_at into v_exp
    from public.grant_access(v_email, 'cortesia', now(), null, 'cortesia',
                             'quiz-' || v_user, t.dias, 'Quiz de boas-vindas: ' || t.acertos || ' acerto(s)') g;

  -- Quem ganhou pelo quiz não soma o cupom #10DIASGRATIS depois.
  insert into public.coupon_redemptions (user_id, email, code)
  select v_user, lower(v_email), c.code from public.coupons c where c.code = '#10DIASGRATIS'
  on conflict do nothing;

  return query select 'ok'::text, t.acertos, t.dias, v_exp;
end;
$$;

revoke all on function public.quiz_boas_vindas_resgatar() from public, anon;
grant execute on function public.quiz_boas_vindas_resgatar() to authenticated;

-- ============================================================
-- Para conferir depois:
--   -- quem ganhou os dias mínimos sem fazer o quiz:
--   select email, dias, resgatado_em from public.quiz_resgates where sem_quiz order by resgatado_em desc;
--   -- todos os resgates (com e sem quiz):
--   select email, acertos, dias, sem_quiz, resgatado_em from public.quiz_resgates order by resgatado_em desc;
-- ============================================================
