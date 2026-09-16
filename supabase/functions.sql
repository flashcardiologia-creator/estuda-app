-- estuda+ — funções SQL (security definer) para regras sensíveis.
-- Rode este arquivo uma vez no SQL Editor do seu projeto Supabase.
-- Não recria tabelas nem políticas de RLS já existentes.

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

    v_new_dormant := case when p_is_daily then current_date + 14 else v_wb.dormant_until end;

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
  v_today date := current_date;
  v_answered_today integer;
  v_profile record;
  v_new_streak integer;
begin
  if v_user_id is null then
    raise exception 'not_authenticated';
  end if;

  select count(*) into v_answered_today from public.user_question_attempts
    where user_id = v_user_id and is_daily_mission = true and answered_at::date = v_today;

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
    where from_user = v_user_id and created_at::date = current_date;
  if v_count_today >= 5 then
    raise exception 'limite_diario_atingido';
  end if;

  select exists(
    select 1 from public.friendships
      where (user_id = v_user_id and friend_id = p_friend_id)
         or (user_id = p_friend_id and friend_id = v_user_id)
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
