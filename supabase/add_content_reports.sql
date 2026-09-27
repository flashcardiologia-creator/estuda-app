-- Tabela para reportar erros em questões e flashcards específicos (botão
-- de interrogação na tela de Questões/Flashcards).
--
-- Rode este arquivo uma vez no SQL Editor do seu projeto Supabase.

create table if not exists public.content_reports (
  id bigint generated always as identity primary key,
  user_id uuid not null references auth.users(id) on delete cascade,
  item_type text not null check (item_type in ('question', 'flashcard')),
  item_id uuid not null,
  reason text not null,
  details text,
  created_at timestamptz not null default now()
);

create index if not exists content_reports_item_idx on public.content_reports (item_type, item_id);

alter table public.content_reports enable row level security;

drop policy if exists "insert own content reports" on public.content_reports;
create policy "insert own content reports" on public.content_reports
  for insert with check (auth.uid() = user_id);

drop policy if exists "select own content reports" on public.content_reports;
create policy "select own content reports" on public.content_reports
  for select using (auth.uid() = user_id);
