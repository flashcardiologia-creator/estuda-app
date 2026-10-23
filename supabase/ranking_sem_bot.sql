-- Tira o Bot Braunwald do ranking.
--
-- Por que ele aparecia: desde o ranking_anonimo.sql, quem não quer aparecer com o nome continua na lista
-- como "Anônimo". O bot está marcado como "fora do ranking" (ranking_visible = false), então caía
-- justamente nessa regra e aparecia como "Anônimo". Aqui a função get_leaderboard() passa a ignorar as
-- contas de bot (e-mail terminado em @flashcardio.invalid, como o bot.braunwald@flashcardio.invalid).
--
-- É a mesma função do ranking_anonimo.sql, só com esse filtro a mais. Rode uma vez no SQL Editor do
-- Supabase. Pode rodar de novo.

drop function if exists public.get_leaderboard();

create function public.get_leaderboard()
returns table(
  id uuid,
  name text,
  is_me boolean,
  is_anonymous boolean,
  phrase text,
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
  v_is_admin boolean := false;
begin
  if v_user_id is null then
    raise exception 'not_authenticated';
  end if;

  -- Conta administradora: vê o nome de quem está como "Anônimo", entre parênteses.
  select coalesce(u.email = 'flashcardiologia@gmail.com', false) into v_is_admin
  from auth.users u where u.id = v_user_id;

  return query
  with eligible as (
    select p.id as uid,
           case when p.id = v_user_id or p.ranking_visible then p.name
                when v_is_admin then 'Anônimo (' || p.name || ')'
                else 'Anônimo' end as shown_name,
           (p.id = v_user_id) as is_me,
           (not p.ranking_visible) as is_anon,
           p.ranking_phrase as phrase
    from public.profiles p
    -- contas de bot não entram no ranking
    where not exists (
      select 1 from auth.users bu
       where bu.id = p.id and coalesce(bu.email, '') like '%@flashcardio.invalid'
    )
  ),
  qa as (
    select user_id, count(*)::integer as answered, sum(case when correct then 1 else 0 end)::integer as correct
    from public.user_question_attempts
    group by user_id
  ),
  fv as (
    select user_id, count(*)::integer as viewed
    from public.user_flashcard_views
    group by user_id
  ),
  scores as (
    select cp.challenge_id, cp.user_id,
           coalesce(sum(case when ca.correct then 1 else 0 end), 0)::integer as correct
    from public.challenge_participants cp
    join public.challenges c on c.id = cp.challenge_id and c.status = 'completed'
    left join public.challenge_answers ca on ca.challenge_id = cp.challenge_id and ca.user_id = cp.user_id
    group by cp.challenge_id, cp.user_id
  ),
  ranked as (
    select s.*,
           max(s.correct) over (partition by s.challenge_id) as top_score,
           count(*) over (partition by s.challenge_id, s.correct) as same_score
    from scores s
  ),
  wins as (
    select r.user_id as uid, count(*)::integer as wins
    from ranked r
    where r.correct = r.top_score and r.same_score = 1
    group by r.user_id
  )
  select
    case when e.is_me or not e.is_anon then e.uid else null end,
    e.shown_name,
    e.is_me,
    e.is_anon,
    e.phrase,
    case when coalesce(qa.answered, 0) > 0
      then round((qa.correct::numeric / qa.answered) * 100)::integer
      else 0 end,
    coalesce(qa.answered, 0),
    coalesce(fv.viewed, 0),
    coalesce(w.wins, 0)
  from eligible e
  left join qa on qa.user_id = e.uid
  left join fv on fv.user_id = e.uid
  left join wins w on w.uid = e.uid
  order by e.shown_name;
end;
$$;

grant execute on function public.get_leaderboard() to authenticated;

-- Conferência: quantas contas de bot existem e quantas pessoas ficam no ranking.
select (select count(*) from auth.users where coalesce(email, '') like '%@flashcardio.invalid') as contas_de_bot,
       (select count(*) from public.profiles p
         where not exists (select 1 from auth.users bu where bu.id = p.id and coalesce(bu.email, '') like '%@flashcardio.invalid')) as pessoas_no_ranking;
