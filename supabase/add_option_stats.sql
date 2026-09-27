-- Percentual de usuários que escolheram cada alternativa de uma questão
-- (ex.: "42% escolheram esta"), agregado entre todos os usuários — sem
-- expor quem respondeu o quê, só a contagem por alternativa. Junta
-- respostas de questões avulsas/missão diária e de desafios.
--
-- Rode este arquivo uma vez no SQL Editor do seu projeto Supabase.

create or replace function public.get_option_stats(p_question_id uuid)
returns table(letra text, pct integer, total integer)
language sql
security definer
set search_path = public
stable
as $$
  with all_answers as (
    select selected_option from public.user_question_attempts where question_id = p_question_id
    union all
    select selected_option from public.challenge_answers where question_id = p_question_id
  )
  select
    selected_option as letra,
    round(count(*)::numeric / sum(count(*)) over () * 100)::integer as pct,
    count(*)::integer as total
  from all_answers
  group by selected_option;
$$;

grant execute on function public.get_option_stats(uuid) to authenticated;
