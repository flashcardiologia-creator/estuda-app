-- Ranking: quem não quer aparecer com o nome continua no ranking, como "Anônimo".
--
-- Antes, quem desligava "Aparecer no ranking" sumia da lista. Agora todo mundo entra no ranking
-- com as suas estatísticas; quem desligou aparece como "Anônimo" para os outros (você sempre vê
-- o seu próprio nome). Para as outras pessoas não dá para descobrir quem é o anônimo: o código
-- da pessoa (id) também não é enviado.
--
-- Também cria a "frase" do ranking: ao tocar no próprio nome, a pessoa escolhe uma frase de
-- comemoração (BORA!, VEMNIMIM, PEGA EU, CONFIA...) que aparece ao lado do nome para todos.
-- Só valem as frases da lista abaixo (não é texto livre).
--
-- Pode rodar mais de uma vez.

alter table public.profiles add column if not exists ranking_phrase text;

alter table public.profiles drop constraint if exists profiles_ranking_phrase_check;
alter table public.profiles add constraint profiles_ranking_phrase_check check (
  ranking_phrase is null or ranking_phrase in (
    'BORA!', 'VEMNIMIM', 'PEGA EU', 'CONFIA', 'TÔ ON', 'FOCO', 'SEGURA', 'NÃO TEM PRA NINGUÉM', 'SÓ VAI', 'AMANHÃ TEM MAIS'
  )
);

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
begin
  if v_user_id is null then
    raise exception 'not_authenticated';
  end if;

  return query
  with eligible as (
    select p.id as uid,
           case when p.id = v_user_id or p.ranking_visible then p.name else 'Anônimo' end as shown_name,
           (p.id = v_user_id) as is_me,
           (not p.ranking_visible) as is_anon,
           p.ranking_phrase as phrase
    from public.profiles p
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

select count(*) as pessoas_no_ranking,
       count(*) filter (where not ranking_visible) as vao_aparecer_como_anonimo
from public.profiles;
