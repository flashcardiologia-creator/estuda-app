-- 1) create_challenge: agora só permite desafiar quem já é amigo confirmado (status='accepted')
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
    where from_user = v_user_id and created_at::date = current_date;
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

-- 2) get_friend_stats: mesma coisa, exige status='accepted' (assinatura não mudou, sem precisar dropar de novo)
create or replace function public.get_friend_stats(p_friend_id uuid)
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

-- 3) remove_friend: agora remove nos dois sentidos (funciona mesmo se o pedido tiver sido enviado pelo outro lado)
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

-- 4) get_friends_mission_status: idem, só amigos confirmados
create or replace function public.get_friends_mission_status(p_friend_ids uuid[])
returns table(id uuid, name text, streak integer, done_today boolean)
language sql
security definer
set search_path = public
stable
as $$
  select p.id, p.name, p.streak, (p.last_mission_date = current_date) as done_today
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
-- 5) NOVO: fluxo de pedido/aceite de amizade
-- ============================================================

-- Migra amizades já existentes (criadas antes desse fluxo) para 'accepted'
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

-- Aceita ou recusa um pedido recebido. Recusar apaga a linha.
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

-- Lista de amigos confirmados (status='accepted'), nas duas direções
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

-- Pedidos de amizade recebidos, ainda não respondidos
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
