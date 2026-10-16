-- Assinaturas, fase 2: trava de verdade no banco.
-- Rode DEPOIS de assinaturas.sql e DEPOIS de publicar a versão do app que usa estas funções.
-- Pode rodar de novo sem problema.
--
-- O que muda:
--   * Questões, alternativas e flashcards só podem ser lidos direto das tabelas por quem tem
--     assinatura ativa (ou se a trava estiver desligada).
--   * Quem não tem assinatura recebe, por funções do banco, só o que faz parte da missão de hoje
--     e dos desafios de que participa. O sorteio da missão dessas pessoas passa a ser feito aqui.
--   * Sem assinatura, não dá mais para: gravar um sorteio da missão por conta própria, responder
--     questões fora da missão, nem responder desafio com questão que não é do desafio.
--   * Desafios criados sem assinatura: no máximo 10 questões (e continua 1 por dia).
--
-- Para voltar ao estado anterior (leitura aberta para todos), rode o bloco ROLLBACK no fim.

do $$
begin
  if to_regprocedure('public._has_access(uuid)') is null then
    raise exception 'Rode primeiro o SQL assinaturas.sql (falta a função _has_access).';
  end if;
end $$;

-- ============================================================
-- 1) O que cada pessoa pode ver mesmo sem assinatura
-- ============================================================
-- Questões da missão de hoje (e de ontem, para a missão que atravessa a meia-noite) e dos
-- desafios de que participa.
create or replace function public._visible_question_ids(p_user uuid)
returns setof uuid
language sql
stable
security definer
set search_path = public
as $$
  select unnest(p.question_ids)
    from public.daily_mission_picks p
   where p.user_id = p_user and p.mission_date >= public.app_today() - 1
  union
  select cq.question_id
    from public.challenge_questions cq
   where exists (select 1 from public.challenge_participants cp
                  where cp.challenge_id = cq.challenge_id and cp.user_id = p_user)
      or exists (select 1 from public.challenges c
                  where c.id = cq.challenge_id and p_user in (c.from_user, c.to_user));
$$;

create or replace function public._visible_flashcard_ids(p_user uuid)
returns setof uuid
language sql
stable
security definer
set search_path = public
as $$
  select unnest(p.flashcard_ids)
    from public.daily_mission_picks p
   where p.user_id = p_user and p.mission_date >= public.app_today() - 1;
$$;

revoke all on function public._visible_question_ids(uuid) from public, anon, authenticated;
revoke all on function public._visible_flashcard_ids(uuid) from public, anon, authenticated;

-- "Eu tenho acesso?" Só responde sobre quem está logado. As regras de acesso (RLS) abaixo usam
-- esta função, porque rodam com a permissão de quem consulta (a _has_access é interna).
create or replace function public.has_active_access()
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select public._has_access(auth.uid());
$$;

revoke all on function public.has_active_access() from public, anon;
grant execute on function public.has_active_access() to authenticated;

-- ============================================================
-- 2) Funções de leitura usadas pelo app de quem não tem assinatura
-- ============================================================
-- Só a lista leve (id, tema, ano, instituição, imagem): filtros, estatísticas e temas dos desafios.
create or replace function public.list_question_meta()
returns table(id uuid, tema text, ano integer, instituicao text, imagem_url text)
language plpgsql
stable
security definer
set search_path = public
as $$
#variable_conflict use_column
begin
  if auth.uid() is null then raise exception 'not_authenticated'; end if;
  return query
    select q.id, q.tema::text, q.ano::integer, q.instituicao::text, q.imagem_url::text
      from public.questions q
     order by q.id;
end;
$$;

create or replace function public.list_flashcard_meta()
returns table(id uuid, tema text)
language plpgsql
stable
security definer
set search_path = public
as $$
#variable_conflict use_column
begin
  if auth.uid() is null then raise exception 'not_authenticated'; end if;
  return query select f.id, f.tema::text from public.flashcards f order by f.id;
end;
$$;

-- Enunciado e comentários, só das questões que a pessoa pode ver.
create or replace function public.get_questions_content(p_ids uuid[])
returns table(
  id uuid, tema text, ano integer, instituicao text,
  enunciado text, comentario text, comentario_completo text, imagem_url text
)
language plpgsql
stable
security definer
set search_path = public
as $$
#variable_conflict use_column
declare
  v_user uuid := auth.uid();
begin
  if v_user is null then raise exception 'not_authenticated'; end if;
  if cardinality(p_ids) > 500 then raise exception 'ids_demais'; end if;
  return query
    select q.id, q.tema::text, q.ano::integer, q.instituicao::text,
           q.enunciado::text, q.comentario::text, q.comentario_completo::text, q.imagem_url::text
      from public.questions q
     where q.id = any(p_ids)
       and (public._has_access(v_user) or q.id in (select public._visible_question_ids(v_user)));
end;
$$;

-- Alternativas. O gabarito (correta) só vai se pedido E se a pessoa já respondeu a questão.
create or replace function public.get_options_content(p_ids uuid[], p_with_key boolean default false)
returns table(id text, question_id uuid, letra text, texto text, correta boolean)
language plpgsql
stable
security definer
set search_path = public
as $$
#variable_conflict use_column
declare
  v_user uuid := auth.uid();
  v_full boolean;
begin
  if v_user is null then raise exception 'not_authenticated'; end if;
  if cardinality(p_ids) > 500 then raise exception 'ids_demais'; end if;
  v_full := public._has_access(v_user);
  return query
    select qo.id::text, qo.question_id, qo.letra::text, qo.texto::text,
           case
             when p_with_key and (
                  v_full
               or exists (select 1 from public.challenge_answers ca
                           where ca.user_id = v_user and ca.question_id = qo.question_id)
               or exists (select 1 from public.user_question_attempts a
                           where a.user_id = v_user and a.question_id = qo.question_id)
             ) then qo.correta
             else null
           end
      from public.question_options qo
     where qo.question_id = any(p_ids)
       and (v_full or qo.question_id in (select public._visible_question_ids(v_user)));
end;
$$;

create or replace function public.get_flashcards_content(p_ids uuid[])
returns setof public.flashcards
language plpgsql
stable
security definer
set search_path = public
as $$
declare
  v_user uuid := auth.uid();
begin
  if v_user is null then raise exception 'not_authenticated'; end if;
  if cardinality(p_ids) > 500 then raise exception 'ids_demais'; end if;
  return query
    select f.* from public.flashcards f
     where f.id = any(p_ids)
       and (public._has_access(v_user) or f.id in (select public._visible_flashcard_ids(v_user)));
end;
$$;

-- ============================================================
-- 3) Sorteio da missão diária feito no banco (para quem não tem assinatura)
--    Mesmas regras do app: questões erradas primeiro (fora do descanso), depois novas, e
--    flashcards dos mesmos temas das questões (sem os que a pessoa mandou para a lixeira).
--    p_mode: 'mix' = 5 questões + 5 flashcards; 'questions' = 10 questões.
-- ============================================================
create or replace function public.pick_daily_mission(p_mode text default 'mix')
returns table(question_ids uuid[], flashcard_ids uuid[])
language plpgsql
security definer
set search_path = public
as $$
#variable_conflict use_column
declare
  v_user  uuid := auth.uid();
  v_today date := public.app_today();
  v_qn    integer := case when p_mode = 'questions' then 10 else 5 end;
  v_fn    integer := case when p_mode = 'questions' then 0 else 5 end;
  v_q     uuid[];
  v_f     uuid[] := '{}';
  v_temas text[];
  v_need  integer;
begin
  if v_user is null then raise exception 'not_authenticated'; end if;

  -- Já sorteada hoje: devolve a mesma.
  select p.question_ids, p.flashcard_ids into v_q, v_f
    from public.daily_mission_picks p
   where p.user_id = v_user and p.mission_date = v_today;
  if found then
    return query select v_q, v_f;
    return;
  end if;

  v_f := '{}';

  v_q := array(
    select w.question_id from public.user_wrong_bank w
     where w.user_id = v_user and w.in_bank
       and (w.dormant_until is null or w.dormant_until <= v_today)
     order by random() limit v_qn
  );

  v_need := v_qn - coalesce(cardinality(v_q), 0);
  if v_need > 0 then
    v_q := v_q || array(
      select q.id from public.questions q
       where q.id <> all (v_q)
         and q.id not in (select w.question_id from public.user_wrong_bank w
                           where w.user_id = v_user and w.dormant_until > v_today)
       order by random() limit v_need
    );
    v_need := v_qn - coalesce(cardinality(v_q), 0);
    if v_need > 0 then
      v_q := v_q || array(select q.id from public.questions q where q.id <> all (v_q) order by random() limit v_need);
    end if;
  end if;

  if v_fn > 0 then
    v_temas := array(select distinct q.tema::text from public.questions q where q.id = any (v_q) and q.tema is not null);
    v_f := array(
      select f.id from public.flashcards f
       where f.tema::text = any (v_temas)
         and not exists (select 1 from public.user_flashcard_trash t where t.user_id = v_user and t.flashcard_id = f.id)
       order by random() limit v_fn
    );
    v_need := v_fn - coalesce(cardinality(v_f), 0);
    if v_need > 0 then
      v_f := v_f || array(
        select f.id from public.flashcards f
         where f.id <> all (v_f)
           and not exists (select 1 from public.user_flashcard_trash t where t.user_id = v_user and t.flashcard_id = f.id)
         order by random() limit v_need
      );
    end if;
  end if;

  insert into public.daily_mission_picks (user_id, mission_date, question_ids, flashcard_ids)
  values (v_user, v_today, v_q, v_f)
  on conflict (user_id, mission_date) do nothing;

  -- Se outra aba gravou primeiro, vale a que ficou salva.
  return query
    select p.question_ids, p.flashcard_ids from public.daily_mission_picks p
     where p.user_id = v_user and p.mission_date = v_today;
end;
$$;

-- ============================================================
-- 4) Funções expostas ao app
-- ============================================================
revoke all on function public.list_question_meta() from public, anon;
revoke all on function public.list_flashcard_meta() from public, anon;
revoke all on function public.get_questions_content(uuid[]) from public, anon;
revoke all on function public.get_options_content(uuid[], boolean) from public, anon;
revoke all on function public.get_flashcards_content(uuid[]) from public, anon;
revoke all on function public.pick_daily_mission(text) from public, anon;
grant execute on function public.list_question_meta() to authenticated;
grant execute on function public.list_flashcard_meta() to authenticated;
grant execute on function public.get_questions_content(uuid[]) to authenticated;
grant execute on function public.get_options_content(uuid[], boolean) to authenticated;
grant execute on function public.get_flashcards_content(uuid[]) to authenticated;
grant execute on function public.pick_daily_mission(text) to authenticated;

-- ============================================================
-- 5) Gatilhos: fecham as brechas das funções de resposta (sem mexer no corpo delas)
-- ============================================================
-- Sem assinatura, só dá para registrar resposta de questão da missão (o gabarito vem junto
-- na resposta, então isso também impede "perguntar" gabarito de qualquer questão).
create or replace function public.attempts_require_access()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  if not public._has_access(new.user_id)
     and not exists (
       select 1 from public.daily_mission_picks p
        where p.user_id = new.user_id
          and p.mission_date >= public.app_today() - 1
          and new.question_id = any (p.question_ids)
     ) then
    raise exception 'sem_acesso_questoes';
  end if;
  return new;
end;
$$;

drop trigger if exists attempts_require_access on public.user_question_attempts;
create trigger attempts_require_access
  before insert on public.user_question_attempts
  for each row execute function public.attempts_require_access();

-- Resposta de desafio só vale para questão que pertence ao desafio.
create or replace function public.challenge_answer_in_challenge()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  if not exists (
    select 1 from public.challenge_questions cq
     where cq.challenge_id = new.challenge_id and cq.question_id = new.question_id
  ) then
    raise exception 'questao_fora_do_desafio';
  end if;
  return new;
end;
$$;

drop trigger if exists challenge_answer_in_challenge on public.challenge_answers;
create trigger challenge_answer_in_challenge
  before insert on public.challenge_answers
  for each row execute function public.challenge_answer_in_challenge();

-- Desafio criado sem assinatura: 1 por dia (já era) e no máximo 10 questões.
create or replace function public.challenges_free_limit()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  if not public._has_access(new.from_user) then
    if new.qtd > 10 then
      raise exception 'limite_gratuito_questoes';
    end if;
    if (select count(*) from public.challenges c
         where c.from_user = new.from_user
           and public.app_date(c.created_at) = public.app_today()) >= 1 then
      raise exception 'limite_gratuito_desafio';
    end if;
  end if;
  return new;
end;
$$;

-- ============================================================
-- 6) Regras de acesso (RLS) das tabelas de conteúdo
-- ============================================================
alter table public.questions enable row level security;
alter table public.question_options enable row level security;
alter table public.flashcards enable row level security;

-- Remove as regras de leitura que existiam (os nomes não estão no repositório) e cria uma só.
do $$
declare
  r record;
begin
  for r in
    select schemaname, tablename, policyname
      from pg_policies
     where schemaname = 'public'
       and tablename in ('questions', 'question_options', 'flashcards')
       and cmd in ('SELECT', 'ALL')
  loop
    execute format('drop policy %I on %I.%I', r.policyname, r.schemaname, r.tablename);
  end loop;
end $$;

create policy "subscribers read questions" on public.questions
  for select to authenticated using ((select public.has_active_access()));
create policy "subscribers read question_options" on public.question_options
  for select to authenticated using ((select public.has_active_access()));
create policy "subscribers read flashcards" on public.flashcards
  for select to authenticated using ((select public.has_active_access()));

-- Sem assinatura, o sorteio da missão só pode ser gravado pela função pick_daily_mission.
drop policy if exists "insert own daily mission picks" on public.daily_mission_picks;
create policy "insert own daily mission picks" on public.daily_mission_picks
  for insert with check (auth.uid() = user_id and (select public.has_active_access()));

-- ============================================================
-- Conferência: devolve 4 linhas "ok" se tudo foi criado.
-- ============================================================
select 'funcoes' as item, count(*) as total
  from pg_proc p join pg_namespace n on n.oid = p.pronamespace
 where n.nspname = 'public'
   and p.proname in ('list_question_meta','list_flashcard_meta','get_questions_content','get_options_content','get_flashcards_content','pick_daily_mission')
union all
select 'policies de leitura', count(*) from pg_policies
 where schemaname = 'public' and tablename in ('questions','question_options','flashcards') and cmd = 'SELECT'
union all
select 'gatilhos', count(*) from pg_trigger
 where tgname in ('attempts_require_access','challenge_answer_in_challenge','challenges_free_limit') and not tgisinternal;

-- ============================================================
-- ROLLBACK (só se precisar): leitura aberta para todos os logados, como antes.
-- Copie e rode separadamente:
--
--   drop policy if exists "subscribers read questions" on public.questions;
--   drop policy if exists "subscribers read question_options" on public.question_options;
--   drop policy if exists "subscribers read flashcards" on public.flashcards;
--   create policy "read questions" on public.questions for select to authenticated using (true);
--   create policy "read question_options" on public.question_options for select to authenticated using (true);
--   create policy "read flashcards" on public.flashcards for select to authenticated using (true);
--   drop trigger if exists attempts_require_access on public.user_question_attempts;
--   drop policy if exists "insert own daily mission picks" on public.daily_mission_picks;
--   create policy "insert own daily mission picks" on public.daily_mission_picks
--     for insert with check (auth.uid() = user_id);
-- ============================================================
