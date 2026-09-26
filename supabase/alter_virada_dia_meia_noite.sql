-- Muda a virada do "dia" da missão diária de 18h de Brasília para meia-noite
-- de Brasília (Brasília = UTC-3, então meia-noite local = 3h UTC).
-- Rode este arquivo uma vez no SQL Editor do seu projeto Supabase.

create or replace function public.app_date(p_ts timestamptz)
returns date
language sql
stable
as $$
  select (p_ts - interval '3 hours')::date;
$$;
