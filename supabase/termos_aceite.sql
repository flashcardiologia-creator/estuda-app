-- Registro do aceite dos Termos de Uso e da Política de Privacidade no cadastro.
-- Rode uma vez no SQL Editor do Supabase.
--
-- Quem grava é o servidor do app (rota /auth/aceite, com a chave de serviço), porque o IP só
-- é confiável quando vem dos cabeçalhos da requisição. O app (anon/authenticated) não consegue
-- inserir nem alterar: só a própria pessoa lê o seu registro.

create table if not exists public.terms_acceptances (
  id               uuid primary key default gen_random_uuid(),
  -- on delete set null: o registro do aceite é prova e sobrevive à exclusão da conta.
  user_id          uuid references auth.users (id) on delete set null,
  email            text not null,
  user_name        text,
  terms_version    text not null,
  terms_hash       text not null,   -- sha256 do texto dos Termos que estava no ar
  privacy_hash     text not null,   -- sha256 do texto da Política que estava no ar
  consent_text     text not null,   -- frase exata exibida ao lado da caixa de aceite
  source           text not null default 'signup',
  accepted_at      timestamptz not null default now(),  -- hora do servidor do banco
  ip_address       text,            -- IP do aparelho que aceitou
  ip_chain         text,            -- cadeia completa x-forwarded-for, se houver proxies
  user_agent       text,
  accept_language  text,
  origin           text,
  client_timezone  text,
  client_language  text,
  client_platform  text,
  client_screen    text,
  display_mode     text             -- navegador ou app instalado (standalone)
);

create unique index if not exists terms_acceptances_user_version_key
  on public.terms_acceptances (user_id, terms_version, source)
  where user_id is not null;

create index if not exists terms_acceptances_email_idx
  on public.terms_acceptances (lower(email));

alter table public.terms_acceptances enable row level security;

drop policy if exists "terms_acceptances_select_own" on public.terms_acceptances;
create policy "terms_acceptances_select_own"
  on public.terms_acceptances for select
  to authenticated
  using (user_id = auth.uid());

-- Nenhuma policy de insert/update/delete: só a chave de serviço (servidor) escreve.
revoke insert, update, delete on public.terms_acceptances from anon, authenticated;
