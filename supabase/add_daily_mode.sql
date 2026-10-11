-- Formato da missão diária escolhido por cada pessoa (na tela de conclusão da missão):
--   'mix'       = 5 questões + 5 flashcards (padrão, como sempre foi)
--   'questions' = 10 questões
-- A escolha vale a partir do sorteio do dia seguinte e continua até a pessoa trocar.
-- Pode rodar mais de uma vez.

alter table public.profiles add column if not exists daily_mode text not null default 'mix';

do $$
begin
  if not exists (select 1 from pg_constraint where conname = 'profiles_daily_mode_check') then
    alter table public.profiles add constraint profiles_daily_mode_check check (daily_mode in ('mix', 'questions'));
  end if;
end
$$;

select daily_mode, count(*) as pessoas from public.profiles group by daily_mode order by daily_mode;
