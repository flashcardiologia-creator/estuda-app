-- Bandagem da sequência: quem acerta TODAS as questões da missão diária tem 50% de chance de ganhar uma bandagem.
-- A bandagem protege a sequência quando a pessoa passa UM dia sem fazer a missão: no dia em que ela volta e conclui a
-- missão, a sequência continua (sem contar o dia perdido) e a bandagem é gasta. Só se pode ter uma bandagem por vez:
-- com uma guardada, não há sorteio. Só assinantes ganham e usam (sem assinatura a sequência já fica congelada).
-- Rode UMA vez no SQL Editor do Supabase. Pode rodar de novo. Não altera nenhuma sequência já existente.
--
-- Regras, com datas da missão (dia M é o dia da missão que está sendo concluída):
--   * última missão em M-1 (ontem)          -> sequência +1, nada de bandagem gasta;
--   * última missão em M-2 e há bandagem    -> sequência +1 e a bandagem é gasta (o dia perdido foi coberto);
--   * última missão em M-2 sem bandagem, ou em M-3 ou antes (2 dias ou mais sem missão) -> a sequência volta a 1
--     (a bandagem cobre só UM dia, então nesse caso ela NÃO é gasta e continua guardada);
--   * sorteio (50%): só na primeira conclusão do dia, só se acertou todas as questões da missão (primeira tentativa de
--     cada uma), só com assinatura ativa e só se não houver bandagem guardada (uma que acabou de ser gasta conta como livre).
-- A bandagem só muda por estas funções: edição direta do perfil pelo app é ignorada (gatilho de proteção).
--
--   * profiles.bandages: 0 ou 1.
--   * complete_daily_mission(): devolve também bandages (quantas tem agora), bandage_earned e bandage_used.
--   * expire_daily_mission(): se o dia virou no meio da missão, a sequência NÃO zera quando há uma bandagem que ainda pode cobrir esse dia.
--   * get_friends_streaks(ids): sequência atual de cada amigo (painel do foguinho e tela "Missão concluída"). A sequência
--     é visível entre amigos independente da opção "Comparem estatísticas com você" (essa opção cobre só as demais estatísticas).

alter table public.profiles add column if not exists bandages integer not null default 0;
alter table public.profiles drop constraint if exists profiles_bandages_check;
alter table public.profiles add constraint profiles_bandages_check check (bandages between 0 and 1);

-- Proteção: só as funções abaixo (que ligam a marca fc.bandage_ok durante a transação) mudam a bandagem.
create or replace function public.profiles_guard_bandages()
returns trigger
language plpgsql
as $$
begin
  if coalesce(current_setting('fc.bandage_ok', true), '') <> '1' then
    if tg_op = 'INSERT' then
      new.bandages := 0;
    elsif new.bandages is distinct from old.bandages then
      new.bandages := old.bandages;
    end if;
  end if;
  return new;
end;
$$;

drop trigger if exists profiles_guard_bandages on public.profiles;
create trigger profiles_guard_bandages
  before insert or update on public.profiles
  for each row execute function public.profiles_guard_bandages();

-- ============================================================
-- Concluir a missão diária (acrescenta a bandagem às regras de sempre)
-- ============================================================
drop function if exists public.complete_daily_mission();

create or replace function public.complete_daily_mission()
returns table(streak integer, last_mission_date date, bandages integer, bandage_earned boolean, bandage_used boolean)
language plpgsql
security definer
set search_path = public
as $$
#variable_conflict use_column
declare
  v_user_id  uuid := auth.uid();
  v_pick     record;
  v_total    integer;
  v_answered integer;
  v_correct  integer;
  v_profile  record;
  v_access   boolean;
  v_new      integer;
  v_band     integer;
  v_earned   boolean := false;
  v_used     boolean := false;
begin
  if v_user_id is null then
    raise exception 'not_authenticated';
  end if;

  select * into v_pick from public.daily_mission_picks
    where user_id = v_user_id
    order by mission_date desc
    limit 1;

  if v_pick.mission_date is null then
    raise exception 'missao_nao_encontrada';
  end if;

  v_total := array_length(v_pick.question_ids, 1);

  select count(*) into v_answered from public.user_question_attempts a
    where a.user_id = v_user_id
      and a.is_daily_mission = true
      and a.question_id = any(v_pick.question_ids)
      and a.answered_at >= v_pick.created_at;

  if v_answered < v_total then
    raise exception 'missao_incompleta';
  end if;

  select p.streak, p.last_mission_date, p.bandages into v_profile
    from public.profiles p where p.id = v_user_id;

  v_access := public._has_access(v_user_id);
  v_band := coalesce(v_profile.bandages, 0);

  if v_profile.last_mission_date = v_pick.mission_date then
    -- Missão de hoje já concluída antes: nada muda e não há novo sorteio.
    v_new := v_profile.streak;
  else
    if v_profile.last_mission_date = v_pick.mission_date - 1 then
      v_new := v_profile.streak + 1;
    elsif v_profile.last_mission_date = v_pick.mission_date - 2
          and v_band > 0 and v_access and coalesce(v_profile.streak, 0) > 0 then
      -- Passou um dia sem missão e há bandagem: a sequência continua e a bandagem é gasta.
      v_new := v_profile.streak + 1;
      v_band := v_band - 1;
      v_used := true;
    else
      v_new := 1;
    end if;

    -- Sorteio de 50% para quem acertou todas as questões (primeira tentativa de cada uma) e não tem bandagem guardada.
    if v_access and v_band < 1 then
      select count(*) into v_correct from (
        select distinct on (a.question_id) a.question_id, a.correct
          from public.user_question_attempts a
         where a.user_id = v_user_id
           and a.is_daily_mission = true
           and a.question_id = any(v_pick.question_ids)
           and a.answered_at >= v_pick.created_at
         order by a.question_id, a.answered_at
      ) x where x.correct;
      if v_correct = v_total and random() < 0.5 then
        v_band := 1;
        v_earned := true;
      end if;
    end if;
  end if;

  perform set_config('fc.bandage_ok', '1', true);
  update public.profiles
    set streak = v_new,
        last_mission_date = v_pick.mission_date,
        best_streak = greatest(best_streak, v_new),
        bandages = v_band
    where id = v_user_id;

  return query select v_new, v_pick.mission_date, v_band, v_earned, v_used;
end;
$$;

grant execute on function public.complete_daily_mission() to authenticated;

-- ============================================================
-- Dia virou no meio da missão: com bandagem que ainda cobre esse dia, a sequência fica
-- ============================================================
create or replace function public.expire_daily_mission()
returns table(streak integer)
language plpgsql
security definer
set search_path = public
as $$
#variable_conflict use_column
declare
  v_user_id uuid := auth.uid();
  v_profile record;
begin
  if v_user_id is null then
    raise exception 'not_authenticated';
  end if;

  select p.streak, p.last_mission_date, p.bandages into v_profile
    from public.profiles p where p.id = v_user_id;

  -- A última missão foi anteontem (só o dia de ontem ficou sem missão) e há bandagem: a sequência fica de pé.
  -- A bandagem só é gasta quando a pessoa conclui a próxima missão (complete_daily_mission).
  if coalesce(v_profile.bandages, 0) > 0
     and v_profile.last_mission_date = public.app_today() - 2
     and public._has_access(v_user_id) then
    return query select v_profile.streak;
    return;
  end if;

  update public.profiles set streak = 0 where id = v_user_id;
  return query select 0;
end;
$$;

grant execute on function public.expire_daily_mission() to authenticated;

-- ============================================================
-- Sequência dos amigos (painel do foguinho)
-- ============================================================
create or replace function public.get_friends_streaks(p_friend_ids uuid[])
returns table(id uuid, name text, streak integer, best_streak integer, done_today boolean, visible boolean)
language sql
stable
security definer
set search_path = public
as $$
  select p.id,
         p.name,
         case when p.last_mission_date >= public.app_today() - 1 then p.streak
              when p.last_mission_date = public.app_today() - 2 and coalesce(p.bandages, 0) > 0 then p.streak
              else 0 end as streak,
         p.best_streak,
         coalesce(p.last_mission_date = public.app_today(), false) as done_today,
         coalesce(p.stats_visible_to_friends, false) as visible
    from public.profiles p
   where p.id = any(p_friend_ids)
     and exists (
       select 1 from public.friendships f
        where ((f.user_id = auth.uid() and f.friend_id = p.id)
            or (f.user_id = p.id and f.friend_id = auth.uid()))
          and f.status = 'accepted'
     );
$$;

grant execute on function public.get_friends_streaks(uuid[]) to authenticated;

-- ============================================================
-- Depois, para consultar:
--   select count(*) filter (where bandages = 1) as com_bandagem, count(*) as total from public.profiles;
-- Dar uma bandagem a alguém (cortesia manual):
--   select set_config('fc.bandage_ok', '1', false);
--   update public.profiles set bandages = 1 where id = (select id from auth.users where email = 'pessoa@email.com');
-- ============================================================
