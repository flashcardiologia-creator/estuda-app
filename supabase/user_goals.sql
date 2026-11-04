-- Cadastro: qual prova a pessoa vai prestar (TEC, R+ ou Ambos), a especialidade do R+ e a instituição.
-- O formulário manda as respostas junto com o cadastro (metadata do signUp: prova, especialidade, instituicao,
-- instituicao_da_lista). Um gatilho em auth.users grava tudo em public.user_goals, mesmo quando a pessoa ainda precisa
-- confirmar o e-mail (nesse caso ainda não há sessão para gravar pelo app).
-- Seguro para rodar de novo. Rode no SQL Editor do Supabase. Não mexe em contas existentes: quem já tinha conta fica sem linha.

create table if not exists public.user_goals (
  user_id            uuid primary key references auth.users (id) on delete cascade,
  exam               text not null check (exam in ('TEC', 'R+', 'AMBOS')),
  specialty          text check (specialty in (
                       'eletrofisiologia', 'hemodinamica', 'ecocardiografia', 'transplante', 'cardioesporte',
                       'cardio_oncologia', 'cardiointensiva', 'cardiogeriatria', 'outra')),
  institution        text check (char_length(institution) between 1 and 120),
  institution_listed boolean not null default false,
  created_at         timestamptz not null default now(),
  updated_at         timestamptz not null default now(),
  -- A especialidade só existe para quem prestará o R+ (R+ ou Ambos).
  constraint user_goals_specialty_only_rplus check (specialty is null or exam in ('R+', 'AMBOS'))
);

alter table public.user_goals enable row level security;

drop policy if exists "user_goals_select_own" on public.user_goals;
create policy "user_goals_select_own" on public.user_goals for select using (auth.uid() = user_id);
drop policy if exists "user_goals_insert_own" on public.user_goals;
create policy "user_goals_insert_own" on public.user_goals for insert with check (auth.uid() = user_id);
drop policy if exists "user_goals_update_own" on public.user_goals;
create policy "user_goals_update_own" on public.user_goals for update using (auth.uid() = user_id) with check (auth.uid() = user_id);

-- Lê as respostas do metadata do cadastro. Valor inválido vira vazio; NUNCA deixa o cadastro falhar (qualquer erro é engolido).
create or replace function public._user_goals_from_signup()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
declare
  v_meta  jsonb := coalesce(new.raw_user_meta_data, '{}'::jsonb);
  v_exam  text  := upper(btrim(coalesce(v_meta ->> 'prova', '')));
  v_spec  text  := lower(btrim(coalesce(v_meta ->> 'especialidade', '')));
  v_inst  text  := left(btrim(coalesce(v_meta ->> 'instituicao', '')), 120);
  v_listed boolean := coalesce(v_meta ->> 'instituicao_da_lista', '') = 'true';
begin
  if v_exam not in ('TEC', 'R+', 'AMBOS') then
    return new; -- cadastro antigo, convite, bot...: sem resposta, sem linha
  end if;
  if v_exam = 'TEC' or v_spec not in (
       'eletrofisiologia', 'hemodinamica', 'ecocardiografia', 'transplante', 'cardioesporte',
       'cardio_oncologia', 'cardiointensiva', 'cardiogeriatria', 'outra') then
    v_spec := null;
  end if;
  if v_inst = '' then
    v_inst := null;
    v_listed := false;
  end if;

  insert into public.user_goals (user_id, exam, specialty, institution, institution_listed)
  values (new.id, v_exam, v_spec, v_inst, v_listed)
  on conflict (user_id) do nothing;
  return new;
exception when others then
  return new;
end
$$;

drop trigger if exists user_goals_from_signup on auth.users;
create trigger user_goals_from_signup
  after insert on auth.users
  for each row execute function public._user_goals_from_signup();

-- Conferência: quantas respostas por prova e especialidade (nasce vazia; enche conforme as pessoas se cadastram).
select exam as prova, coalesce(specialty, '—') as especialidade, count(*) as pessoas
  from public.user_goals
 group by 1, 2
 order by 3 desc;
