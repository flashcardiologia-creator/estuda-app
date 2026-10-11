-- Sessões antigas de questões: guarda as últimas 10 sessões de cada pessoa
-- (filtros usados, questões sorteadas, respostas e andamento) para continuar
-- depois, em qualquer aparelho.
--
-- Só as 10 sessões mais recentes ficam guardadas: ao criar uma nova, a mais
-- antiga além de 10 é apagada automaticamente.
--
-- Rode este arquivo no SQL Editor. Pode rodar de novo sem problema (quem já
-- rodou a versão de 50 sessões roda de novo para voltar o limite para 10).

create table if not exists public.question_sessions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  filters jsonb not null default '{}'::jsonb,
  question_ids jsonb not null default '[]'::jsonb,
  progress jsonb not null default '{}'::jsonb,
  total integer not null default 0,
  answered integer not null default 0,
  finished boolean not null default false
);

create index if not exists question_sessions_user_updated_idx
  on public.question_sessions (user_id, updated_at desc);

alter table public.question_sessions enable row level security;

drop policy if exists "select own question sessions" on public.question_sessions;
create policy "select own question sessions" on public.question_sessions
  for select to authenticated using (user_id = auth.uid());

drop policy if exists "insert own question sessions" on public.question_sessions;
create policy "insert own question sessions" on public.question_sessions
  for insert to authenticated with check (user_id = auth.uid());

drop policy if exists "update own question sessions" on public.question_sessions;
create policy "update own question sessions" on public.question_sessions
  for update to authenticated using (user_id = auth.uid()) with check (user_id = auth.uid());

drop policy if exists "delete own question sessions" on public.question_sessions;
create policy "delete own question sessions" on public.question_sessions
  for delete to authenticated using (user_id = auth.uid());

-- Atualiza updated_at a cada alteração.
create or replace function public.touch_question_session()
returns trigger
language plpgsql
as $$
begin
  new.updated_at := now();
  return new;
end;
$$;

drop trigger if exists question_sessions_touch on public.question_sessions;
create trigger question_sessions_touch
  before update on public.question_sessions
  for each row execute function public.touch_question_session();

-- Mantém no máximo 10 sessões por pessoa (apaga as mais antigas).
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

drop trigger if exists question_sessions_trim on public.question_sessions;
create trigger question_sessions_trim
  after insert on public.question_sessions
  for each row execute function public.trim_question_sessions();

select count(*) as sessoes_guardadas from public.question_sessions;
