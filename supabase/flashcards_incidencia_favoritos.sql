-- Flashcards: incidência em prova (barra de 3 níveis no card) e favoritos de cada pessoa.
--
--   flashcards.incidencia          : 1 (cai pouco), 2 (cai medianamente) ou 3 (cai muito) em questões de prova
--   user_flashcard_favorites       : flashcards que cada pessoa marcou com a estrela (só ela enxerga os seus)
--
-- A mecânica de "dificuldade" foi retirada do app; a coluna antiga (dificuldade) continua no banco, sem uso.
-- Rode ANTES de flashcards_incidencia_valores*.sql e de publicar o app. Pode rodar mais de uma vez.

alter table public.flashcards add column if not exists incidencia smallint;

do $$
begin
  if not exists (select 1 from pg_constraint where conname = 'flashcards_incidencia_check') then
    alter table public.flashcards add constraint flashcards_incidencia_check check (incidencia between 1 and 3);
  end if;
end
$$;

create table if not exists public.user_flashcard_favorites (
  user_id uuid not null references auth.users(id) on delete cascade,
  flashcard_id uuid not null,
  created_at timestamptz not null default now(),
  primary key (user_id, flashcard_id)
);

alter table public.user_flashcard_favorites enable row level security;

drop policy if exists "select own flashcard favorites" on public.user_flashcard_favorites;
create policy "select own flashcard favorites" on public.user_flashcard_favorites
  for select to authenticated using (user_id = auth.uid());

drop policy if exists "insert own flashcard favorites" on public.user_flashcard_favorites;
create policy "insert own flashcard favorites" on public.user_flashcard_favorites
  for insert to authenticated with check (user_id = auth.uid());

drop policy if exists "delete own flashcard favorites" on public.user_flashcard_favorites;
create policy "delete own flashcard favorites" on public.user_flashcard_favorites
  for delete to authenticated using (user_id = auth.uid());

select (select count(*) from public.user_flashcard_favorites) as favoritos,
       (select count(*) from public.flashcards where incidencia is not null) as cards_com_incidencia;
