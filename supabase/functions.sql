-- estuda+ — funções SQL (security definer) para regras sensíveis.
-- Rode este arquivo uma vez no SQL Editor do seu projeto Supabase.
-- Não recria tabelas nem políticas de RLS já existentes.

-- ============================================================
-- -1) Realtime para a tela de Desafios: liga a replicação dessas duas
--     tabelas para que o app receba updates ao vivo (WebSocket) quando o
--     amigo responde uma questão do desafio ou quando ele é concluído,
--     sem precisar recarregar a página.
-- ============================================================
alter publication supabase_realtime add table public.challenges;
alter publication supabase_realtime add table public.challenge_answers;

-- ============================================================
-- 0) "Dia" da missão vira às 18h de Brasília (21h UTC), não à meia-noite
--    UTC — por isso soma 3h antes de extrair a data. Toda lógica baseada
--    em "hoje" usa essas duas funções em vez de current_date/::date direto,
--    para manter a mesma definição de dia em todo lugar.
-- ============================================================
create or replace function public.app_date(p_ts timestamptz)
returns date
language sql
stable
as $$
  select (p_ts + interval '3 hours')::date;
$$;

create or replace function public.app_today()
returns date
language sql
stable
as $$
  select public.app_date(now());
$$;

-- ============================================================
-- 1) Registrar resposta de questão (banco de erradas + streak)
-- ============================================================
create or replace function public.record_answer(
  p_question_id uuid,
  p_selected_option text,
  p_is_daily boolean default false
)
returns table(correct boolean, correct_option text, comentario text)
language plpgsql
security definer
set search_path = public
as $$
declare
  v_user_id uuid := auth.uid();
  v_correct_option text;
  v_comentario text;
  v_correct boolean;
  v_wb record;
begin
  if v_user_id is null then
    raise exception 'not_authenticated';
  end if;

  select qo.letra into v_correct_option from public.question_options qo
    where qo.question_id = p_question_id and qo.correta = true limit 1;
  select q.comentario into v_comentario from public.questions q where q.id = p_question_id;

  if v_correct_option is null then
    raise exception 'question_not_found';
  end if;

  v_correct := (p_selected_option = v_correct_option);

  insert into public.user_question_attempts
    (user_id, question_id, selected_option, correct, is_daily_mission, answered_at)
  values (v_user_id, p_question_id, p_selected_option, v_correct, p_is_daily, now());

  select * into v_wb from public.user_wrong_bank
    where user_id = v_user_id and question_id = p_question_id;

  -- Nada a gravar: acerto fora do banco de erradas, sem histórico e fora da missão diária.
  if v_correct and v_wb.user_id is null and not p_is_daily then
    return query select v_correct, v_correct_option, v_comentario;
    return;
  end if;

  declare
    v_new_in_bank boolean;
    v_new_streak integer;
    v_new_dormant date;
  begin
    if not v_correct then
      v_new_in_bank := true;
      v_new_streak := 0;
    elsif v_wb.user_id is not null and v_wb.in_bank then
      v_new_streak := v_wb.correct_streak + 1;
      v_new_in_bank := v_new_streak < 3;
      if not v_new_in_bank then v_new_streak := 0; end if;
    else
      v_new_in_bank := coalesce(v_wb.in_bank, false);
      v_new_streak := coalesce(v_wb.correct_streak, 0);
    end if;

    v_new_dormant := case when p_is_daily then public.app_today() + 14 else v_wb.dormant_until end;

    if v_wb.user_id is not null then
      update public.user_wrong_bank
        set in_bank = v_new_in_bank, correct_streak = v_new_streak, dormant_until = v_new_dormant
        where user_id = v_user_id and question_id = p_question_id;
    else
      insert into public.user_wrong_bank (user_id, question_id, in_bank, correct_streak, dormant_until)
        values (v_user_id, p_question_id, v_new_in_bank, v_new_streak, v_new_dormant);
    end if;
  end;

  return query select v_correct, v_correct_option, v_comentario;
end;
$$;

grant execute on function public.record_answer(uuid, text, boolean) to authenticated;

-- ============================================================
-- 2) Concluir a missão diária (valida progresso e atualiza streak)
-- ============================================================
create or replace function public.complete_daily_mission()
returns table(streak integer, last_mission_date date)
language plpgsql
security definer
set search_path = public
as $$
declare
  v_user_id uuid := auth.uid();
  v_today date := public.app_today();
  v_answered_today integer;
  v_profile record;
  v_new_streak integer;
begin
  if v_user_id is null then
    raise exception 'not_authenticated';
  end if;

  select count(*) into v_answered_today from public.user_question_attempts
    where user_id = v_user_id and is_daily_mission = true and public.app_date(answered_at) = v_today;

  if v_answered_today < 5 then
    raise exception 'missao_incompleta';
  end if;

  select p.streak, p.last_mission_date into v_profile
    from public.profiles p where p.id = v_user_id;

  if v_profile.last_mission_date = v_today then
    v_new_streak := v_profile.streak;
  elsif v_profile.last_mission_date = v_today - 1 then
    v_new_streak := v_profile.streak + 1;
  else
    v_new_streak := 1;
  end if;

  update public.profiles set streak = v_new_streak, last_mission_date = v_today
    where id = v_user_id;

  return query select v_new_streak, v_today;
end;
$$;

grant execute on function public.complete_daily_mission() to authenticated;

-- ============================================================
-- 3) Criar desafio (limite de 5/dia + seleção aleatória de questões)
-- ============================================================
create or replace function public.create_challenge(
  p_friend_id uuid,
  p_tema text,
  p_qtd integer
)
returns uuid
language plpgsql
security definer
set search_path = public
as $$
declare
  v_user_id uuid := auth.uid();
  v_count_today integer;
  v_is_friend boolean;
  v_challenge_id uuid;
  v_qtd integer;
  v_ordem integer := 0;
  r record;
begin
  if v_user_id is null then
    raise exception 'not_authenticated';
  end if;

  select count(*) into v_count_today from public.challenges
    where from_user = v_user_id and public.app_date(created_at) = public.app_today();
  if v_count_today >= 5 then
    raise exception 'limite_diario_atingido';
  end if;

  select exists(
    select 1 from public.friendships
      where ((user_id = v_user_id and friend_id = p_friend_id)
          or (user_id = p_friend_id and friend_id = v_user_id))
        and status = 'accepted'
  ) into v_is_friend;
  if not v_is_friend then
    raise exception 'nao_e_amigo';
  end if;

  select least(p_qtd, count(*)) into v_qtd from public.questions where tema = p_tema;
  if v_qtd is null or v_qtd = 0 then
    raise exception 'sem_questoes_no_tema';
  end if;

  insert into public.challenges (from_user, to_user, tema, qtd, status, created_at, expires_at)
    values (v_user_id, p_friend_id, p_tema, v_qtd, 'pending', now(), now() + interval '48 hours')
    returning id into v_challenge_id;

  for r in
    select id from public.questions where tema = p_tema order by random() limit v_qtd
  loop
    insert into public.challenge_questions (challenge_id, question_id, ordem)
      values (v_challenge_id, r.id, v_ordem);
    v_ordem := v_ordem + 1;
  end loop;

  return v_challenge_id;
end;
$$;

grant execute on function public.create_challenge(uuid, text, integer) to authenticated;

-- ============================================================
-- 4) Registrar resposta de desafio (grava, impede refazer, fecha ao concluir)
-- ============================================================
create or replace function public.record_challenge_answer(
  p_challenge_id uuid,
  p_question_id uuid,
  p_selected_option text
)
returns table(correct boolean, correct_option text, comentario text)
language plpgsql
security definer
set search_path = public
as $$
declare
  v_user_id uuid := auth.uid();
  v_challenge record;
  v_correct_option text;
  v_comentario text;
  v_correct boolean;
  v_from_done boolean;
  v_to_done boolean;
begin
  if v_user_id is null then
    raise exception 'not_authenticated';
  end if;

  select * into v_challenge from public.challenges where id = p_challenge_id;
  if v_challenge.id is null then
    raise exception 'desafio_nao_encontrado';
  end if;
  if v_user_id not in (v_challenge.from_user, v_challenge.to_user) then
    raise exception 'sem_permissao';
  end if;
  if v_challenge.status = 'expired' or v_challenge.expires_at < now() then
    raise exception 'desafio_expirado';
  end if;

  if exists(
    select 1 from public.challenge_answers
      where challenge_id = p_challenge_id and question_id = p_question_id and user_id = v_user_id
  ) then
    raise exception 'questao_ja_respondida';
  end if;

  select qo.letra into v_correct_option from public.question_options qo
    where qo.question_id = p_question_id and qo.correta = true limit 1;
  select q.comentario into v_comentario from public.questions q where q.id = p_question_id;
  v_correct := (p_selected_option = v_correct_option);

  insert into public.challenge_answers
    (challenge_id, question_id, user_id, selected_option, correct, answered_at)
  values (p_challenge_id, p_question_id, v_user_id, p_selected_option, v_correct, now());

  select count(*) >= v_challenge.qtd into v_from_done from public.challenge_answers
    where challenge_id = p_challenge_id and user_id = v_challenge.from_user;
  select count(*) >= v_challenge.qtd into v_to_done from public.challenge_answers
    where challenge_id = p_challenge_id and user_id = v_challenge.to_user;

  if v_from_done and v_to_done then
    update public.challenges set status = 'completed' where id = p_challenge_id;
  end if;

  return query select v_correct, v_correct_option, v_comentario;
end;
$$;

grant execute on function public.record_challenge_answer(uuid, uuid, text) to authenticated;

-- ============================================================
-- 5) Buscar perfis por nome / por id (só id + name — nunca streak ou
--    outros dados sensíveis de outro usuário). Necessário porque a RLS
--    de `profiles` restringe leitura à própria linha.
-- ============================================================
create or replace function public.search_profile_by_name(p_name text)
returns table(id uuid, name text)
language sql
security definer
set search_path = public
stable
as $$
  select p.id, p.name from public.profiles p
    where p.name ilike p_name and p.id <> auth.uid();
$$;

grant execute on function public.search_profile_by_name(text) to authenticated;

create or replace function public.get_profile_names(p_ids uuid[])
returns table(id uuid, name text)
language sql
security definer
set search_path = public
stable
as $$
  select p.id, p.name from public.profiles p where p.id = any(p_ids);
$$;

grant execute on function public.get_profile_names(uuid[]) to authenticated;

-- ============================================================
-- 6) Marcar desafios pendentes expirados (chamar ao listar Desafios)
-- ============================================================
create or replace function public.expire_my_challenges()
returns void
language sql
security definer
set search_path = public
as $$
  update public.challenges
    set status = 'expired'
    where status = 'pending'
      and expires_at < now()
      and (from_user = auth.uid() or to_user = auth.uid());
$$;

grant execute on function public.expire_my_challenges() to authenticated;

-- ============================================================
-- 7) Código de amigo — identificador de 9 dígitos, único, gerado
--    automaticamente para cada perfil (novo ou já existente), para
--    permitir adicionar amigos sem depender só do nome de exibição.
-- ============================================================
create or replace function public.generate_unique_friend_code()
returns text
language plpgsql
as $$
declare
  v_code text;
  v_exists boolean;
begin
  loop
    v_code := lpad(floor(random() * 1000000000)::bigint::text, 9, '0');
    select exists(select 1 from public.profiles where friend_code = v_code) into v_exists;
    exit when not v_exists;
  end loop;
  return v_code;
end;
$$;

alter table public.profiles add column if not exists friend_code text unique;
alter table public.profiles alter column friend_code set default public.generate_unique_friend_code();
update public.profiles set friend_code = public.generate_unique_friend_code() where friend_code is null;
alter table public.profiles alter column friend_code set not null;

create or replace function public.search_profile_by_code(p_code text)
returns table(id uuid, name text)
language sql
security definer
set search_path = public
stable
as $$
  select p.id, p.name from public.profiles p
    where p.friend_code = p_code and p.id <> auth.uid();
$$;

grant execute on function public.search_profile_by_code(text) to authenticated;

-- ============================================================
-- 8) Estatísticas públicas de um amigo (só nome, streak, respondidas
--    e % de acerto — nunca e-mail ou outros dados). Exige que quem
--    chama já seja amigo (em qualquer direção) do perfil consultado.
-- ============================================================
alter table public.profiles add column if not exists stats_visible_to_friends boolean not null default false;

-- A assinatura de retorno mudou (ganhou a coluna `authorized`), e o Postgres
-- não deixa trocar o tipo de retorno com CREATE OR REPLACE — precisa dropar.
drop function if exists public.get_friend_stats(uuid);

create function public.get_friend_stats(p_friend_id uuid)
returns table(name text, streak integer, answered integer, accuracy integer, authorized boolean)
language plpgsql
security definer
set search_path = public
stable
as $$
declare
  v_user_id uuid := auth.uid();
  v_is_friend boolean;
  v_name text;
  v_visible boolean;
  v_streak integer;
  v_answered integer;
  v_correct integer;
begin
  if v_user_id is null then
    raise exception 'not_authenticated';
  end if;

  select exists(
    select 1 from public.friendships
      where ((user_id = v_user_id and friend_id = p_friend_id)
          or (user_id = p_friend_id and friend_id = v_user_id))
        and status = 'accepted'
  ) into v_is_friend;
  if not v_is_friend then
    raise exception 'nao_e_amigo';
  end if;

  select p.name, p.stats_visible_to_friends, p.streak
    into v_name, v_visible, v_streak
    from public.profiles p where p.id = p_friend_id;

  if not v_visible then
    return query select v_name, null::integer, null::integer, null::integer, false;
    return;
  end if;

  select count(*) into v_answered from public.user_question_attempts where user_id = p_friend_id;
  select count(*) into v_correct from public.user_question_attempts
    where user_id = p_friend_id and correct = true;

  return query
    select
      v_name,
      v_streak,
      v_answered,
      case when v_answered > 0 then round((v_correct::numeric / v_answered) * 100)::integer else 0 end,
      true;
end;
$$;

grant execute on function public.get_friend_stats(uuid) to authenticated;

-- ============================================================
-- 9) Remover amigo. Existe como função porque a RLS de `friendships`
--    não libera DELETE direto do cliente (apenas SELECT/INSERT), então
--    um delete via client falha silenciosamente (0 linhas afetadas).
-- ============================================================
create or replace function public.remove_friend(p_friend_id uuid)
returns void
language sql
security definer
set search_path = public
as $$
  delete from public.friendships
    where (user_id = auth.uid() and friend_id = p_friend_id)
       or (user_id = p_friend_id and friend_id = auth.uid());
$$;

grant execute on function public.remove_friend(uuid) to authenticated;

-- ============================================================
-- 10) Status da missão diária dos amigos (nome, streak e se já fez
--     hoje — nunca outros dados). Só retorna quem realmente é amigo
--     de quem chama, mesmo que o array recebido seja adulterado no
--     cliente.
-- ============================================================
create or replace function public.get_friends_mission_status(p_friend_ids uuid[])
returns table(id uuid, name text, streak integer, done_today boolean)
language sql
security definer
set search_path = public
stable
as $$
  select p.id, p.name, p.streak, (p.last_mission_date = public.app_today()) as done_today
  from public.profiles p
  where p.id = any(p_friend_ids)
    and exists (
      select 1 from public.friendships f
        where ((f.user_id = auth.uid() and f.friend_id = p.id)
            or (f.user_id = p.id and f.friend_id = auth.uid()))
          and f.status = 'accepted'
    );
$$;

grant execute on function public.get_friends_mission_status(uuid[]) to authenticated;

-- ============================================================
-- 11) Fluxo de pedido/aceite de amizade — agora usar a coluna
--     `status` da tabela `friendships` ('pending' | 'accepted').
--     Migra as amizades já existentes (criadas antes desse fluxo)
--     para 'accepted', sem quebrar nada que já estava funcionando.
-- ============================================================
update public.friendships set status = 'accepted' where status is distinct from 'pending';

-- Envia um pedido de amizade. Se a outra pessoa já tiver te enviado um
-- pedido antes, aceita automaticamente em vez de duplicar a linha.
create or replace function public.send_friend_request(p_target_id uuid)
returns text
language plpgsql
security definer
set search_path = public
as $$
declare
  v_user_id uuid := auth.uid();
  v_existing record;
begin
  if v_user_id is null then
    raise exception 'not_authenticated';
  end if;
  if v_user_id = p_target_id then
    raise exception 'nao_pode_adicionar_a_si_mesmo';
  end if;

  select * into v_existing from public.friendships
    where (user_id = v_user_id and friend_id = p_target_id)
       or (user_id = p_target_id and friend_id = v_user_id)
    limit 1;

  if v_existing.user_id is not null then
    if v_existing.status = 'accepted' then
      raise exception 'ja_sao_amigos';
    elsif v_existing.user_id = p_target_id then
      update public.friendships set status = 'accepted'
        where user_id = p_target_id and friend_id = v_user_id;
      return 'accepted';
    else
      raise exception 'pedido_ja_enviado';
    end if;
  end if;

  insert into public.friendships (user_id, friend_id, status) values (v_user_id, p_target_id, 'pending');
  return 'requested';
end;
$$;

grant execute on function public.send_friend_request(uuid) to authenticated;

-- Aceita ou recusa um pedido recebido. Recusar apaga a linha (a pessoa
-- pode pedir de novo depois, sem ficar um resquício bloqueando).
create or replace function public.respond_friend_request(p_requester_id uuid, p_accept boolean)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_user_id uuid := auth.uid();
begin
  if v_user_id is null then
    raise exception 'not_authenticated';
  end if;

  if p_accept then
    update public.friendships set status = 'accepted'
      where user_id = p_requester_id and friend_id = v_user_id and status = 'pending';
    if not found then
      raise exception 'pedido_nao_encontrado';
    end if;
  else
    delete from public.friendships
      where user_id = p_requester_id and friend_id = v_user_id and status = 'pending';
  end if;
end;
$$;

grant execute on function public.respond_friend_request(uuid, boolean) to authenticated;

-- Lista de amigos confirmados (status = 'accepted'), nas duas direções.
create or replace function public.get_my_friends()
returns table(id uuid, name text)
language sql
security definer
set search_path = public
stable
as $$
  select p.id, p.name
  from public.profiles p
  where p.id in (
    select case when f.user_id = auth.uid() then f.friend_id else f.user_id end
    from public.friendships f
    where (f.user_id = auth.uid() or f.friend_id = auth.uid())
      and f.status = 'accepted'
  );
$$;

grant execute on function public.get_my_friends() to authenticated;

-- Pedidos de amizade recebidos, ainda não respondidos.
create or replace function public.get_incoming_friend_requests()
returns table(id uuid, name text, created_at timestamptz)
language sql
security definer
set search_path = public
stable
as $$
  select p.id, p.name, f.created_at
  from public.friendships f
  join public.profiles p on p.id = f.user_id
  where f.friend_id = auth.uid() and f.status = 'pending'
  order by f.created_at desc;
$$;

grant execute on function public.get_incoming_friend_requests() to authenticated;
