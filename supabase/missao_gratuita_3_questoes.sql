-- Missão diária do plano gratuito: 3 questões, nenhum flashcard e sem contar dias seguidos (sequência congelada).
-- Rode uma vez no SQL Editor do Supabase (depois do assinaturas_fase2.sql). Pode rodar de novo.
--
-- Quem tem assinatura ativa continua com 5 questões + 5 flashcards, ou 10 questões, conforme o
-- formato escolhido. Quem não tem recebe só 3 questões, a partir do próximo sorteio: a missão já
-- sorteada hoje não muda.
-- Sem assinatura, concluir a missão também não conta dias seguidos: a sequência fica congelada, sem somar nem zerar (parte 2).

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
  -- Sem assinatura: missão reduzida, 3 questões e nenhum flashcard (qualquer que seja o formato escolhido).
  v_qn    integer := case when not public._has_access(auth.uid()) then 3 when p_mode = 'questions' then 10 else 5 end;
  v_fn    integer := case when not public._has_access(auth.uid()) then 0 when p_mode = 'questions' then 0 else 5 end;
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
-- 2) Sem assinatura, a sequência (dias seguidos) fica congelada: não soma e não zera
--    Funciona como gatilho no perfil, sem mexer na função que conclui a missão.
--    A missão ainda conta como feita no dia (last_mission_date), só não soma dias.
-- ============================================================
create or replace function public.profiles_free_no_streak()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  if (new.streak is distinct from old.streak or new.best_streak is distinct from old.best_streak)
     and not public._has_access(new.id) then
    new.streak := old.streak;
    new.best_streak := old.best_streak;
  end if;
  return new;
end;
$$;

drop trigger if exists profiles_free_no_streak on public.profiles;
create trigger profiles_free_no_streak
  before update on public.profiles
  for each row execute function public.profiles_free_no_streak();
