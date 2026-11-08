-- Revisão diária: quais questões entram, em ordem de prioridade (para quem tem assinatura ativa).
--   1) as que você ERROU e estão no banco de erradas, prontas para rever (fora do descanso de 14 dias);
--   2) as que você ACERTOU, mas de temas em que você erra muito OU que os outros usuários erraram muito;
--   3) as demais que você acertou;
--   4) as que você ainda NÃO FEZ;
--   5) (só para completar, se ainda faltar) as que estão no descanso de 14 dias.
-- Dentro de cada grupo o sorteio é aleatório; no grupo 2, as mais "difíceis" (maior taxa de erro) vêm primeiro.
-- "Erra muito" (pode mudar nas 4 constantes abaixo):
--   * tema seu: pelo menos 5 respostas suas no tema e 40% ou mais de erro;
--   * questão dos outros: pelo menos 10 respostas no total (missão, questões e desafios) e 50% ou mais de erro.
-- Rode uma vez no SQL Editor do Supabase. Pode rodar de novo. Enquanto não rodar, o app usa a regra de antes
-- (erradas primeiro, depois questões novas).

create or replace function public.pick_review_questions(p_count integer)
returns uuid[]
language plpgsql
security definer
set search_path = public
as $$
declare
  v_user  uuid := auth.uid();
  v_today date := public.app_today();
  c_tema_min_respostas  constant integer := 5;
  c_tema_min_erro       constant numeric := 0.40;
  c_geral_min_respostas constant integer := 10;
  c_geral_min_erro      constant numeric := 0.50;
begin
  if v_user is null then
    raise exception 'not_authenticated';
  end if;
  if p_count is null or p_count < 1 then
    return '{}'::uuid[];
  end if;

  return array(
    with
    wb as (
      select w.question_id, w.in_bank, (w.dormant_until is not null and w.dormant_until > v_today) as dormente
        from public.user_wrong_bank w
       where w.user_id = v_user
    ),
    feitas as (
      select a.question_id from public.user_question_attempts a where a.user_id = v_user group by a.question_id
    ),
    tema_user as (
      select q.tema, count(*) as n, count(*) filter (where not a.correct) as erros
        from public.user_question_attempts a
        join public.questions q on q.id = a.question_id
       where a.user_id = v_user
       group by q.tema
    ),
    geral as (
      select r.question_id, count(*) as n, count(*) filter (where not r.correct) as erros
        from (
          select a.question_id, a.correct from public.user_question_attempts a
          union all
          select c.question_id, c.correct from public.challenge_answers c
        ) r
       group by r.question_id
    ),
    base as (
      select q.id,
             coalesce(w.in_bank, false) as no_banco,
             coalesce(w.dormente, false) as dormente,
             (f.question_id is not null) as ja_fez,
             case when tu.n >= c_tema_min_respostas and tu.erros::numeric / tu.n >= c_tema_min_erro
                  then tu.erros::numeric / tu.n end as taxa_tema,
             case when g.n >= c_geral_min_respostas and g.erros::numeric / g.n >= c_geral_min_erro
                  then g.erros::numeric / g.n end as taxa_geral
        from public.questions q
        left join wb w on w.question_id = q.id
        left join feitas f on f.question_id = q.id
        left join tema_user tu on tu.tema = q.tema
        left join geral g on g.question_id = q.id
    ),
    ordenadas as (
      select b.id,
             case
               when b.no_banco and not b.dormente then 1
               when b.dormente then 5
               when b.ja_fez and (b.taxa_tema is not null or b.taxa_geral is not null) then 2
               when b.ja_fez then 3
               else 4
             end as nivel,
             greatest(coalesce(b.taxa_tema, 0), coalesce(b.taxa_geral, 0)) as peso
        from base b
    )
    select o.id from ordenadas o order by o.nivel, o.peso desc, random() limit p_count
  );
end
$$;

revoke all on function public.pick_review_questions(integer) from public, anon;
grant execute on function public.pick_review_questions(integer) to authenticated;

-- Conferência rápida (devolve os ids das 10 primeiras da sua revisão, na ordem de prioridade) só funciona logado no app;
-- no SQL Editor não há usuário logado, então este comando só confirma que a função existe:
select proname as funcao, pg_get_function_arguments(oid) as argumentos
  from pg_proc where proname = 'pick_review_questions' and pronamespace = 'public'::regnamespace;
