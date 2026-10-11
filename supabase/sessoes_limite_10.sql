-- Sessões antigas de questões: volta o limite para as 10 últimas sessões de cada pessoa.
-- Atualiza a regra automática e já apaga o que passa de 10 hoje (as mais antigas de cada pessoa).
-- Pode rodar mais de uma vez.

create or replace function public.trim_question_sessions()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  delete from public.question_sessions
  where user_id = new.user_id
    and id in (
      select id from public.question_sessions
      where user_id = new.user_id
      order by updated_at desc, created_at desc
      offset 10
    );
  return null;
end;
$$;

delete from public.question_sessions
where id in (
  select id from (
    select id, row_number() over (partition by user_id order by updated_at desc, created_at desc) as rn
    from public.question_sessions
  ) s
  where rn > 10
);

select count(*) as sessoes_guardadas from public.question_sessions;
