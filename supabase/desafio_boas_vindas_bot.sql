-- Desafio de boas-vindas contra o Bot Braunwald.
-- Quem entra no app e ainda não tem nenhum desafio ganha um: tema Coronária Crônica, 5 questões,
-- e o bot já respondeu tudo, acertando 4 de 5. O desafio conclui quando a pessoa termina as 5.
-- Rode uma vez no SQL Editor do Supabase (depois do desafio_gratuito_5_questoes.sql). Pode rodar de novo.
--
-- O que este arquivo faz:
--   1) Cria o "usuário" Bot Braunwald (sem senha, não consegue entrar) e esconde ele do ranking.
--   2) A regra de desafio do plano gratuito passa a ignorar o bot (ele não é cliente).
--   3) Cria ensure_welcome_challenge(): o app chama quando a lista de desafios vem vazia.
--
-- Para o app o bot é uma conta comum: aparece como "Bot Braunwald te desafiou". Ele conta como 1 usuário a
-- mais nos totais do painel de dados. Para ele não aparecer no ranking (nem como "Anônimo"), rode também
-- o ranking_sem_bot.sql.

-- ============================================================
-- 1) O bot
-- ============================================================
create or replace function public.bot_braunwald_id()
returns uuid
language sql
immutable
as $$
  select 'b0b0b0b0-b0b0-4b0b-8b0b-b0b0b0b0b0b0'::uuid;
$$;

do $$
declare
  v_bot uuid := public.bot_braunwald_id();
begin
  if not exists (select 1 from auth.users where id = v_bot) then
    insert into auth.users (
      instance_id, id, aud, role, email, encrypted_password, email_confirmed_at,
      raw_app_meta_data, raw_user_meta_data, created_at, updated_at,
      confirmation_token, recovery_token, email_change_token_new, email_change
    ) values (
      '00000000-0000-0000-0000-000000000000', v_bot, 'authenticated', 'authenticated',
      'bot.braunwald@flashcardio.invalid', '', now(),
      '{"provider":"email","providers":["email"]}', '{"name":"Bot Braunwald"}', now(), now(),
      '', '', '', ''
    );
  end if;

  -- O cadastro do perfil normalmente nasce sozinho junto com o usuário; se não nasceu, cria aqui.
  update public.profiles set name = 'Bot Braunwald', ranking_visible = false where id = v_bot;
  if not found then
    insert into public.profiles (id, name, ranking_visible) values (v_bot, 'Bot Braunwald', false);
  end if;
end
$$;

-- ============================================================
-- 2) Regras do plano gratuito não valem para o bot (mesma função de antes, com a exceção do bot)
-- ============================================================
create or replace function public.challenges_free_limit()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  if new.from_user = public.bot_braunwald_id() then
    return new;
  end if;
  if not public._has_access(new.from_user) then
    if new.tema is distinct from public.free_challenge_tema(new.from_user) then
      raise exception 'tema_gratuito_fixo';
    end if;
    if new.qtd > 5 then
      raise exception 'limite_gratuito_questoes';
    end if;
    if (select count(*) from public.challenges c
         where c.from_user = new.from_user
           and public.app_date(c.created_at) = public.app_today()) >= 1 then
      raise exception 'limite_gratuito_desafio';
    end if;
  end if;
  return new;
end;
$$;

-- ============================================================
-- 3) Cria o desafio de boas-vindas (só para quem não tem nenhum desafio)
-- ============================================================
create or replace function public.ensure_welcome_challenge()
returns uuid
language plpgsql
security definer
set search_path = public
as $$
declare
  v_user uuid := auth.uid();
  v_bot uuid := public.bot_braunwald_id();
  v_tema text;
  v_id uuid;
  v_ordem integer := 0;
  v_errada integer := 2;   -- o bot erra a 3ª questão: 4 acertos em 5
  v_letra text;
  r record;
begin
  if v_user is null or v_user = v_bot then
    return null;
  end if;
  if not exists (select 1 from public.profiles where id = v_bot) then
    return null;
  end if;

  -- Evita criar dois se o app abrir em duas abas ao mesmo tempo.
  perform pg_advisory_xact_lock(hashtext('welcome_challenge:' || v_user::text));

  if exists (select 1 from public.challenge_participants where user_id = v_user)
     or exists (select 1 from public.challenges where from_user = v_user or to_user = v_user) then
    return null;
  end if;

  -- Tema "Coronária Crônica" como está gravado nas questões (o mais comum entre as grafias parecidas).
  select q.tema::text into v_tema
    from public.questions q
   where q.tema::text ilike '%coron%' and q.tema::text ilike '%cr_nica%'
   group by q.tema::text
   order by count(*) desc
   limit 1;
  if v_tema is null then
    return null;
  end if;

  insert into public.challenges (from_user, to_user, tema, qtd, status, created_at, expires_at)
    values (v_bot, v_user, v_tema, 5, 'pending', now(), now() + interval '48 hours')
    returning id into v_id;

  insert into public.challenge_participants (challenge_id, user_id) values (v_id, v_bot), (v_id, v_user);

  for r in
    select q.id
      from public.questions q
     where q.tema::text = v_tema
       and exists (select 1 from public.question_options o where o.question_id = q.id and o.correta is true)
       and exists (select 1 from public.question_options o where o.question_id = q.id and o.correta is not true)
     order by random()
     limit 5
  loop
    insert into public.challenge_questions (challenge_id, question_id, ordem) values (v_id, r.id, v_ordem);

    if v_ordem = v_errada then
      select o.letra into v_letra from public.question_options o
        where o.question_id = r.id and o.correta is not true order by random() limit 1;
    else
      select o.letra into v_letra from public.question_options o
        where o.question_id = r.id and o.correta is true order by o.letra limit 1;
    end if;

    insert into public.challenge_answers (challenge_id, question_id, user_id, selected_option, correct, answered_at)
      values (v_id, r.id, v_bot, v_letra, v_ordem <> v_errada, now());

    v_ordem := v_ordem + 1;
  end loop;

  if v_ordem = 0 then
    raise exception 'sem_questoes_no_tema';
  end if;
  if v_ordem < 5 then
    update public.challenges set qtd = v_ordem where id = v_id;
  end if;

  return v_id;
end;
$$;

revoke all on function public.ensure_welcome_challenge() from public, anon;
grant execute on function public.ensure_welcome_challenge() to authenticated;

-- Conferência: o bot existe, está fora do ranking, e o tema foi encontrado.
select p.id, p.name, p.ranking_visible,
       (select q.tema::text from public.questions q
         where q.tema::text ilike '%coron%' and q.tema::text ilike '%cr_nica%'
         group by q.tema::text order by count(*) desc limit 1) as tema_encontrado
  from public.profiles p
 where p.id = public.bot_braunwald_id();
