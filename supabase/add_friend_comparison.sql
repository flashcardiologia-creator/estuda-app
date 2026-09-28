-- Comparação completa entre você e um amigo, em uma única chamada.
-- Amplia o que a modal de amigo mostra (antes só sequência/respondidas/
-- acerto do amigo) para incluir também flashcards vistos e vitórias em
-- desafios — as mesmas 5 métricas usadas no Ranking — e já retorna suas
-- próprias estatísticas junto, para montar a comparação lado a lado sem
-- precisar de uma segunda consulta.
--
-- Rode este arquivo uma vez no SQL Editor do seu projeto Supabase, depois
-- de functions.sql (usa a mesma tabela profiles/friendships/challenges).

create or replace function public.get_friend_comparison(p_friend_id uuid)
returns table(
  my_name text,
  my_streak integer,
  my_answered integer,
  my_accuracy integer,
  my_flashcards_viewed integer,
  my_challenge_wins integer,
  friend_name text,
  friend_streak integer,
  friend_answered integer,
  friend_accuracy integer,
  friend_flashcards_viewed integer,
  friend_challenge_wins integer,
  friend_authorized boolean
)
language plpgsql
security definer
set search_path = public
stable
as $$
declare
  v_user_id uuid := auth.uid();
  v_is_friend boolean;
  v_friend_visible boolean;
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

  select p.stats_visible_to_friends into v_friend_visible
    from public.profiles p where p.id = p_friend_id;

  return query
  with target_ids as (
    select v_user_id as uid
    union all
    select p_friend_id
  ),
  qa as (
    select user_id, count(*)::integer as answered, sum(case when correct then 1 else 0 end)::integer as correct
    from public.user_question_attempts
    where user_id in (select uid from target_ids)
    group by user_id
  ),
  fv as (
    select user_id, count(*)::integer as viewed
    from public.user_flashcard_views
    where user_id in (select uid from target_ids)
    group by user_id
  ),
  sides as (
    select ca.challenge_id, ca.user_id, sum(case when ca.correct then 1 else 0 end)::integer as correct
    from public.challenge_answers ca
    join public.challenges c on c.id = ca.challenge_id
    where c.status = 'completed'
    group by ca.challenge_id, ca.user_id
  ),
  pairs as (
    select c.id as challenge_id, c.from_user, c.to_user
    from public.challenges c
    where c.status = 'completed'
  ),
  win_rows as (
    select p.from_user as uid
    from pairs p
    join sides sf on sf.challenge_id = p.challenge_id and sf.user_id = p.from_user
    join sides st on st.challenge_id = p.challenge_id and st.user_id = p.to_user
    where sf.correct > st.correct
    union all
    select p.to_user as uid
    from pairs p
    join sides sf on sf.challenge_id = p.challenge_id and sf.user_id = p.from_user
    join sides st on st.challenge_id = p.challenge_id and st.user_id = p.to_user
    where st.correct > sf.correct
  ),
  wins as (
    select uid, count(*)::integer as wins
    from win_rows
    where uid in (select uid from target_ids)
    group by uid
  ),
  agg as (
    select
      t.uid,
      p.name,
      p.streak,
      coalesce(qa.answered, 0) as answered,
      case when coalesce(qa.answered, 0) > 0
        then round((qa.correct::numeric / qa.answered) * 100)::integer
        else 0 end as accuracy,
      coalesce(fv.viewed, 0) as flashcards_viewed,
      coalesce(w.wins, 0) as challenge_wins
    from target_ids t
    join public.profiles p on p.id = t.uid
    left join qa on qa.user_id = t.uid
    left join fv on fv.user_id = t.uid
    left join wins w on w.uid = t.uid
  )
  select
    me.name, me.streak, me.answered, me.accuracy, me.flashcards_viewed, me.challenge_wins,
    fr.name,
    case when v_friend_visible then fr.streak end,
    case when v_friend_visible then fr.answered end,
    case when v_friend_visible then fr.accuracy end,
    case when v_friend_visible then fr.flashcards_viewed end,
    case when v_friend_visible then fr.challenge_wins end,
    coalesce(v_friend_visible, false)
  from agg me, agg fr
  where me.uid = v_user_id and fr.uid = p_friend_id;
end;
$$;

grant execute on function public.get_friend_comparison(uuid) to authenticated;
