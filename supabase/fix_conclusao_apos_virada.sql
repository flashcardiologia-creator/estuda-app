-- Corrige um caso real: se a pessoa está respondendo a missão diária e o
-- dia vira (meia-noite de Brasília) antes de ela clicar em "Concluir
-- Missão", a função antiga recontava "hoje" na hora de concluir e podia
-- descartar respostas dadas minutos antes da virada — travando com o erro
-- "missao_incompleta" mesmo com as 5 questões respondidas.
--
-- Agora a conclusão é amarrada ao sorteio da missão (daily_mission_picks)
-- em vez do relógio: conta as respostas das questões daquele sorteio
-- específico, não importa em que dia (calendário) elas foram dadas.
--
-- Rode este arquivo uma vez no SQL Editor do seu projeto Supabase.

create or replace function public.complete_daily_mission()
returns table(streak integer, last_mission_date date)
language plpgsql
security definer
set search_path = public
as $$
declare
  v_user_id uuid := auth.uid();
  v_pick record;
  v_answered_count integer;
  v_profile record;
  v_new_streak integer;
begin
  if v_user_id is null then
    raise exception 'not_authenticated';
  end if;

  select * into v_pick from public.daily_mission_picks
    where user_id = v_user_id
    order by mission_date desc
    limit 1;

  if v_pick.mission_date is null then
    raise exception 'missao_nao_encontrada';
  end if;

  select count(*) into v_answered_count from public.user_question_attempts
    where user_id = v_user_id
      and is_daily_mission = true
      and question_id = any(v_pick.question_ids)
      and answered_at >= v_pick.created_at;

  if v_answered_count < array_length(v_pick.question_ids, 1) then
    raise exception 'missao_incompleta';
  end if;

  select p.streak, p.last_mission_date into v_profile
    from public.profiles p where p.id = v_user_id;

  if v_profile.last_mission_date = v_pick.mission_date then
    v_new_streak := v_profile.streak;
  elsif v_profile.last_mission_date = v_pick.mission_date - 1 then
    v_new_streak := v_profile.streak + 1;
  else
    v_new_streak := 1;
  end if;

  update public.profiles set streak = v_new_streak, last_mission_date = v_pick.mission_date
    where id = v_user_id;

  return query select v_new_streak, v_pick.mission_date;
end;
$$;

grant execute on function public.complete_daily_mission() to authenticated;
