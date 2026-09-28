-- Separa a antiga permissão única "Permitir que vejam suas estatísticas"
-- (profiles.stats_visible_to_friends) em duas permissões independentes:
--
-- 1) stats_visible_to_friends (já existe) — amigos poderem comparar/ver suas
--    estatísticas individualmente (usado por get_friend_stats). Continua
--    vindo DESATIVADO por padrão (default já era false).
-- 2) ranking_visible (nova) — aparecer no ranking global (usado por
--    get_leaderboard). Vem ATIVADO por padrão.
--
-- Rode este arquivo uma vez no SQL Editor do seu projeto Supabase, depois de
-- functions.sql e add_leaderboard.sql.

alter table public.profiles add column if not exists ranking_visible boolean not null default true;

-- Redefine get_leaderboard para usar ranking_visible em vez de
-- stats_visible_to_friends como critério de elegibilidade.
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
    where p.ranking_visible = true or p.id = v_user_id
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
