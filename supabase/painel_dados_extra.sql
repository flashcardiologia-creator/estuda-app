-- Painel de dados, parte 2 (só para a conta administradora flashcardiologia@gmail.com).
-- Cria a função public.admin_extra_stats(), que o painel chama para mostrar:
--   * os e-mails dos 5 últimos usuários cadastrados (aba Usuários);
--   * as 10 questões com mais erros e as 10 com mais acertos (aba Questões);
--   * os 10 usuários que mais lançaram e os 10 que mais ganharam desafios (aba Desafios);
--   * os 10 com maior sequência atual e os 10 com maior sequência de todos os tempos (aba Missão diária).
-- Rode uma vez no SQL Editor do Supabase. Pode rodar de novo (só recria a função). Só consulta: não altera
-- nenhum dado. Não mexe na função admin_stats() do painel_dados_admin.sql.
--
-- Contagem de erros e acertos = respostas avulsas (user_question_attempts) + respostas dentro de desafios
-- (challenge_answers), de todos os usuários, desde sempre. "Mais erros" e "mais acertos" são os números
-- absolutos, então questões muito respondidas aparecem mais; a lista mostra também o total e a porcentagem.
--
-- Segurança: igual à admin_stats(): confere o e-mail de quem chamou; qualquer outra conta recebe "forbidden".

create or replace function public.admin_extra_stats()
returns jsonb
language plpgsql
stable
security definer
set search_path = public, auth
as $$
declare
  v_email  text;
  v_today  date := public.app_today();
  v_result jsonb;
begin
  select lower(u.email) into v_email from auth.users u where u.id = auth.uid();
  if v_email is null or not (v_email = any (array['flashcardiologia@gmail.com'])) then
    raise exception 'forbidden';
  end if;

  with
  att as (
    select a.question_id, a.correct from public.user_question_attempts a
    union all
    select c.question_id, c.correct from public.challenge_answers c
  ),
  qs as (
    select question_id,
           count(*)                              as total,
           count(*) filter (where correct)       as acertos,
           count(*) filter (where not correct)   as erros
      from att
     where question_id is not null
     group by question_id
  ),
  info as (
    select qs.question_id, qs.total, qs.acertos, qs.erros,
           q.tema::text as tema, q.ano, q.instituicao::text as instituicao,
           left(regexp_replace(coalesce(q.enunciado, ''), '\s+', ' ', 'g'), 160) as enunciado
      from qs
      join public.questions q on q.id = qs.question_id
  ),
  -- Vitória em desafio = desafio concluído em que a pessoa fez estritamente mais acertos que todos os
  -- outros (mesma regra do ranking). O Bot Braunwald (e-mail @flashcardio.invalid) fica fora das listas.
  scores as (
    select cp.challenge_id, cp.user_id,
           coalesce(sum(case when ca.correct then 1 else 0 end), 0)::integer as correct
      from public.challenge_participants cp
      join public.challenges c on c.id = cp.challenge_id and c.status = 'completed'
      left join public.challenge_answers ca on ca.challenge_id = cp.challenge_id and ca.user_id = cp.user_id
     group by cp.challenge_id, cp.user_id
  ),
  ranked as (
    select s.*,
           max(s.correct) over (partition by s.challenge_id) as top_score,
           count(*) over (partition by s.challenge_id, s.correct) as same_score
      from scores s
  ),
  vitorias as (
    select r.user_id, count(*) as n
      from ranked r
     where r.correct = r.top_score and r.same_score = 1
     group by r.user_id
  ),
  lancados as (
    select c.from_user as user_id, count(*) as n
      from public.challenges c
     group by c.from_user
  ),
  pessoas as (
    select p.id, p.name, u.email, p.streak, p.best_streak, p.last_mission_date
      from public.profiles p
      join auth.users u on u.id = p.id
     where coalesce(u.email, '') not like '%@flashcardio.invalid'
  )
  select jsonb_build_object(
    'ultimos_usuarios', (
      select coalesce(jsonb_agg(jsonb_build_object('email', u.email, 'criado_em', u.created_at) order by u.created_at desc), '[]'::jsonb)
        from (select email, created_at from auth.users order by created_at desc limit 5) u
    ),
    'mais_erradas', (
      select coalesce(jsonb_agg(jsonb_build_object(
               'id', i.question_id, 'tema', i.tema, 'ano', i.ano, 'instituicao', i.instituicao,
               'enunciado', i.enunciado, 'total', i.total, 'acertos', i.acertos, 'erros', i.erros
             ) order by i.erros desc, i.total desc), '[]'::jsonb)
        from (select * from info where erros > 0 order by erros desc, total desc limit 10) i
    ),
    'mais_acertadas', (
      select coalesce(jsonb_agg(jsonb_build_object(
               'id', i.question_id, 'tema', i.tema, 'ano', i.ano, 'instituicao', i.instituicao,
               'enunciado', i.enunciado, 'total', i.total, 'acertos', i.acertos, 'erros', i.erros
             ) order by i.acertos desc, i.total desc), '[]'::jsonb)
        from (select * from info where acertos > 0 order by acertos desc, total desc limit 10) i
    ),
    'desafios_lancados', (
      select coalesce(jsonb_agg(jsonb_build_object('nome', x.name, 'email', x.email, 'n', x.n) order by x.n desc, x.name), '[]'::jsonb)
        from (select pe.name, pe.email, l.n from lancados l join pessoas pe on pe.id = l.user_id order by l.n desc, pe.name limit 10) x
    ),
    'desafios_ganhos', (
      select coalesce(jsonb_agg(jsonb_build_object('nome', x.name, 'email', x.email, 'n', x.n) order by x.n desc, x.name), '[]'::jsonb)
        from (select pe.name, pe.email, v.n from vitorias v join pessoas pe on pe.id = v.user_id order by v.n desc, pe.name limit 10) x
    ),
    -- Sequência atual = concluiu a missão hoje ou ontem (ainda não quebrou), como no painel.
    'sequencias_atuais', (
      select coalesce(jsonb_agg(jsonb_build_object('nome', x.name, 'email', x.email, 'n', x.streak) order by x.streak desc, x.name), '[]'::jsonb)
        from (select name, email, streak from pessoas where streak > 0 and last_mission_date >= v_today - 1 order by streak desc, name limit 10) x
    ),
    'sequencias_gerais', (
      select coalesce(jsonb_agg(jsonb_build_object('nome', x.name, 'email', x.email, 'n', x.best_streak, 'atual', x.atual) order by x.best_streak desc, x.name), '[]'::jsonb)
        from (select name, email, best_streak,
                     case when last_mission_date >= v_today - 1 then streak else 0 end as atual
                from pessoas where best_streak > 0 order by best_streak desc, name limit 10) x
    )
  ) into v_result;

  return v_result;
end;
$$;

revoke all on function public.admin_extra_stats() from public, anon;
grant execute on function public.admin_extra_stats() to authenticated;
