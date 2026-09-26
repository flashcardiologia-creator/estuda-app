-- Nova função: se a pessoa está no meio da missão diária e o dia vira
-- (meia-noite de Brasília) sem ela ter concluído, o app chama esta função
-- pra fechar a missão e zerar a streak — perder o prazo quebra a sequência.
--
-- Rode este arquivo uma vez no SQL Editor do seu projeto Supabase.

create or replace function public.expire_daily_mission()
returns table(streak integer)
language plpgsql
security definer
set search_path = public
as $$
declare
  v_user_id uuid := auth.uid();
begin
  if v_user_id is null then
    raise exception 'not_authenticated';
  end if;

  update public.profiles set streak = 0 where id = v_user_id;

  return query select 0;
end;
$$;

grant execute on function public.expire_daily_mission() to authenticated;
