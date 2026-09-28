-- Ranking global entre TODOS os usuários do app (não só amigos).
--
-- Respeita o mesmo controle de privacidade "Permitir que vejam suas
-- estatísticas" (coluna profiles.stats_visible_to_friends) já usado por
-- get_friend_stats: só entram no ranking os perfis com essa opção ativada,
-- além de você mesmo (que sempre aparece na sua própria posição,
-- independentemente da sua escolha de privacidade).
--
-- Substitui a função get_friends_leaderboard (versão anterior, só entre
-- amigos) — a linha abaixo remove essa função antiga caso já tenha sido
-- criada; se você ainda não rodou add_friends_leaderboard.sql, não precisa
-- rodá-lo, use só este arquivo.

drop function if exists public.get_friends_leaderboard();

create or replace function public.get_leaderboard()
returns table(
  id uuid,
  name text,
  is_me boolean,
  accuracy integer,
  answered integer,
  flashcards_viewed integer,
  challenge_wins integer
)
language plpgsql
security definer
set search_path = public
stable
as $$
declare
  v_user_id uuid := auth.uid();
begin
  if v_user_id is null then
    raise exception 'not_authenticated';
  end if;

  return query
  with eligible as (
    select p.id as uid, p.name, (p.id = v_user_id) as is_me
    from public.profiles p
    where p.stats_visible_to_friends = true or p.id = v_user_id
  ),
  qa as (
    select user_id, count(*)::integer as answered, sum(case when correct then 1 else 0 end)::integer as correct
    from public.user_question_attempts
    where user_id in (select eligible.uid from eligible)
    group by user_id
  ),
  fv as (
    select user_id, count(*)::integer as viewed
    from public.user_flashcard_views
    where user_id in (select eligible.uid from eligible)
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
    where uid in (select eligible.uid from eligible)
    group by uid
  )
  select
    e.uid,
    e.name,
    e.is_me,
    case when coalesce(qa.answered, 0) > 0
      then round((qa.correct::numeric / qa.answered) * 100)::integer
      else 0 end as accuracy,
    coalesce(qa.answered, 0) as answered,
    coalesce(fv.viewed, 0) as flashcards_viewed,
    coalesce(w.wins, 0) as challenge_wins
  from eligible e
  left join qa on qa.user_id = e.uid
  left join fv on fv.user_id = e.uid
  left join wins w on w.uid = e.uid
  order by e.name;
end;
$$;

grant execute on function public.get_leaderboard() to authenticated;
