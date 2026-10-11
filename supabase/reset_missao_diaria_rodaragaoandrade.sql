-- Reset da missão diária de HOJE para rodaragaoandrade@gmail.com:
-- apaga o sorteio de hoje (daily_mission_picks), apaga as respostas da missão de hoje
-- (user_question_attempts com is_daily_mission = true de hoje) e, se a missão de hoje já estava
-- concluída, volta a sequência (streak) ao que era antes de hoje: a concluir somou 1 dia, então
-- tira 1 e a última missão passa a ser ontem (se a sequência era só de hoje, zera).
--
-- Na próxima vez que abrir a missão, sai um sorteio novo (no formato escolhido pela pessoa).
-- RLS bloqueia isso pelo app: rode no SQL Editor do Supabase. Pode rodar mais de uma vez.

do $$
declare
  v_user_id uuid;
  v_today date := public.app_today();
begin
  select id into v_user_id from auth.users where email = 'rodaragaoandrade@gmail.com';
  if v_user_id is null then
    raise exception 'usuario nao encontrado: rodaragaoandrade@gmail.com';
  end if;

  delete from public.user_question_attempts
  where user_id = v_user_id
    and is_daily_mission = true
    and public.app_date(answered_at) = v_today;

  delete from public.daily_mission_picks
  where user_id = v_user_id
    and mission_date = v_today;

  update public.profiles
  set streak = greatest(streak - 1, 0),
      last_mission_date = case when streak > 1 then v_today - 1 else null end
  where id = v_user_id and last_mission_date = v_today;
end $$;

select p.name, p.streak, p.last_mission_date,
       (select count(*) from public.daily_mission_picks d where d.user_id = p.id and d.mission_date = public.app_today()) as sorteio_de_hoje
from public.profiles p
join auth.users u on u.id = p.id
where u.email = 'rodaragaoandrade@gmail.com';
