-- profiles.streak só é recalculado quando a pessoa conclui uma missão (ou
-- zerado ativamente se ela estava no meio de uma quando o dia virou) — se
-- ela sumir por alguns dias sem abrir o app, o valor fica congelado no
-- banco, mostrando uma sequência que não é mais real.
--
-- get_friend_comparison agora calcula a sequência "efetiva" (0 se a última
-- missão não foi hoje nem ontem) em vez de usar profiles.streak cru — igual
-- ao que o app já faz no cliente ao carregar o próprio perfil.
--
-- Precisa dropar antes de recriar porque a lista de colunas não muda, mas
-- o corpo muda — CREATE OR REPLACE já cobre isso sem precisar de DROP.
--
-- Rode este arquivo uma vez no SQL Editor do seu projeto Supabase, depois
-- de add_challenge_pct_comparison.sql.

create or replace function public.get_friend_comparison(p_friend_id uuid)
returns table(
  my_name text,
  my_streak integer,
  my_best_streak integer,
  my_answered integer,
  my_accuracy integer,
  my_flashcards_viewed integer,
  my_challenge_total integer,
  my_challenge_win_pct integer,
  friend_name text,
  friend_streak integer,
  friend_best_streak integer,
  friend_answered integer,
  friend_accuracy integer,
  friend_flashcards_viewed integer,
  friend_challenge_total integer,
  friend_challenge_win_pct integer,
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
  participations as (
    select from_user as uid, challenge_id from pairs
    union all
    select to_user as uid, challenge_id from pairs
  ),
  totals as (
    select uid, count(*)::integer as total
    from participations
    where uid in (select uid from target_ids)
    group by uid
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
      case when p.last_mission_date in (public.app_today(), public.app_today() - 1) then p.streak else 0 end as streak,
      p.best_streak,
      coalesce(qa.answered, 0) as answered,
      case when coalesce(qa.answered, 0) > 0
        then round((qa.correct::numeric / qa.answered) * 100)::integer
        else 0 end as accuracy,
      coalesce(fv.viewed, 0) as flashcards_viewed,
      coalesce(tot.total, 0) as challenge_total,
      case when coalesce(tot.total, 0) > 0
        then round((coalesce(w.wins, 0)::numeric / tot.total) * 100)::integer
        else 0 end as challenge_win_pct
    from target_ids t
    join public.profiles p on p.id = t.uid
    left join qa on qa.user_id = t.uid
    left join fv on fv.user_id = t.uid
    left join totals tot on tot.uid = t.uid
    left join wins w on w.uid = t.uid
  )
  select
    me.name, me.streak, me.best_streak, me.answered, me.accuracy, me.flashcards_viewed, me.challenge_total, me.challenge_win_pct,
    fr.name,
    case when v_friend_visible then fr.streak end,
    case when v_friend_visible then fr.best_streak end,
    case when v_friend_visible then fr.answered end,
    case when v_friend_visible then fr.accuracy end,
    case when v_friend_visible then fr.flashcards_viewed end,
    case when v_friend_visible then fr.challenge_total end,
    case when v_friend_visible then fr.challenge_win_pct end,
    coalesce(v_friend_visible, false)
  from agg me, agg fr
  where me.uid = v_user_id and fr.uid = p_friend_id;
end;
$$;

grant execute on function public.get_friend_comparison(uuid) to authenticated;
