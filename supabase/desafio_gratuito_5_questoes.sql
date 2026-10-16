-- Desafios do plano gratuito: 1 por dia, no máximo 5 questões e tema sorteado do dia.
-- Rode uma vez no SQL Editor do Supabase (depois do assinaturas_fase2.sql). Pode rodar de novo.
--
-- Quem tem assinatura ativa continua escolhendo o tema, com 5 ou 10 questões, até 5 por dia.
-- Sem assinatura: o tema é um só por dia (muda à meia-noite de Brasília) e não dá para trocar.

-- ============================================================
-- 1) Tema do dia para quem não tem assinatura
--    Sorteio estável: a mesma pessoa vê o mesmo tema o dia todo; muda de um dia para o outro.
-- ============================================================
create or replace function public.free_challenge_tema(p_user uuid)
returns text
language sql
stable
security definer
set search_path = public
as $$
  select x.tema
  from (
    select d.tema,
           row_number() over (order by d.tema) as rn,
           count(*) over () as n
    from (select distinct q.tema::text as tema from public.questions q where q.tema is not null) d
  ) x
  where x.rn = ((hashtext(public.app_today()::text || p_user::text)::bigint & 2147483647) % x.n) + 1;
$$;

revoke all on function public.free_challenge_tema(uuid) from public, anon, authenticated;

-- O app pergunta o tema do dia de quem está logado.
create or replace function public.my_free_challenge_tema()
returns text
language sql
stable
security definer
set search_path = public
as $$
  select public.free_challenge_tema(auth.uid());
$$;

revoke all on function public.my_free_challenge_tema() from public, anon;
grant execute on function public.my_free_challenge_tema() to authenticated;

-- ============================================================
-- 2) Regras de criação de desafio sem assinatura
-- ============================================================
create or replace function public.challenges_free_limit()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  if not public._has_access(new.from_user) then
    if new.tema is distinct from public.free_challenge_tema(new.from_user) then
      raise exception 'tema_gratuito_fixo';
    end if;
    if new.qtd > 5 then
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
