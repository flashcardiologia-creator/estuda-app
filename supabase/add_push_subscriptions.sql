-- Lembretes por notificação (push) da missão diária, às 10h e às 22h (horário de Brasília).
-- Guarda os aparelhos de cada pessoa que ativou os lembretes em Minha Conta > Permissões.
-- Cada pessoa só enxerga e mexe nos seus próprios aparelhos; o envio roda no servidor (Netlify)
-- com a chave de serviço, que ignora essas regras.
-- Pode rodar mais de uma vez.

create table if not exists public.push_subscriptions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  endpoint text not null unique,
  p256dh text not null,
  auth text not null,
  created_at timestamptz not null default now()
);

create index if not exists push_subscriptions_user_idx on public.push_subscriptions (user_id);

alter table public.push_subscriptions enable row level security;

drop policy if exists "select own push subscriptions" on public.push_subscriptions;
create policy "select own push subscriptions" on public.push_subscriptions
  for select to authenticated using (user_id = auth.uid());

drop policy if exists "insert own push subscriptions" on public.push_subscriptions;
create policy "insert own push subscriptions" on public.push_subscriptions
  for insert to authenticated with check (user_id = auth.uid());

drop policy if exists "update own push subscriptions" on public.push_subscriptions;
create policy "update own push subscriptions" on public.push_subscriptions
  for update to authenticated using (user_id = auth.uid()) with check (user_id = auth.uid());

drop policy if exists "delete own push subscriptions" on public.push_subscriptions;
create policy "delete own push subscriptions" on public.push_subscriptions
  for delete to authenticated using (user_id = auth.uid());

select count(*) as aparelhos_com_lembrete from public.push_subscriptions;
