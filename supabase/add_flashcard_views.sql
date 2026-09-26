-- Tabela para registrar cada vez que o usuário vira um flashcard e vê a
-- resposta — necessária para a tela de estatísticas completas mostrar
-- "visualizações por flashcard" (isso não era salvo em lugar nenhum antes,
-- só existia como estado local da sessão, perdido ao sair da tela).
--
-- Rode este arquivo uma vez no SQL Editor do seu projeto Supabase.

create table if not exists public.user_flashcard_views (
  id bigint generated always as identity primary key,
  user_id uuid not null references auth.users(id) on delete cascade,
  flashcard_id uuid not null references public.flashcards(id) on delete cascade,
  viewed_at timestamptz not null default now()
);

create index if not exists user_flashcard_views_user_id_idx on public.user_flashcard_views (user_id);

alter table public.user_flashcard_views enable row level security;

drop policy if exists "select own flashcard views" on public.user_flashcard_views;
create policy "select own flashcard views" on public.user_flashcard_views
  for select using (auth.uid() = user_id);

drop policy if exists "insert own flashcard views" on public.user_flashcard_views;
create policy "insert own flashcard views" on public.user_flashcard_views
  for insert with check (auth.uid() = user_id);
