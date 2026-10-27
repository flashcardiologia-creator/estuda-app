-- Painel de dados: quantas pessoas já experimentaram o tema escuro, o claro e os dois (aba Usuários, "Tema do app").
-- Esta é a mesma função de painel_dados_extra.sql com 3 números a mais em "temas", mais a coluna profiles.themes_used e
-- o gatilho que a mantém. Rode UMA vez no SQL Editor do Supabase. Pode rodar de novo. Não apaga nem altera dados de
-- ninguém além de preencher themes_used com o tema atual de cada conta.
-- Os números contam a partir do momento em que este SQL roda (mais o tema atual de cada conta): quem já tinha
-- trocado de tema antes disso só aparece com o tema que usa hoje.
--
-- Painel de dados, parte 2 (só para a conta administradora flashcardiologia@gmail.com).
-- Cria a função public.admin_extra_stats(), que o painel chama para mostrar:
--   * os e-mails dos 5 últimos usuários cadastrados (aba Usuários);
--   * as 10 questões com mais erros e as 10 com mais acertos (aba Questões);
--   * quantos usuários usam fundo escuro, fundo claro, ou ainda não têm tema registrado (aba Usuários);
--   * os 10 usuários que mais lançaram e os 10 que mais ganharam desafios (aba Desafios);
--   * os 10 com maior sequência atual e os 10 com maior sequência de todos os tempos (aba Missão diária);
--   * quantas pessoas têm o lembrete por notificação ligado e quantas não (aba Missão diária);
--   * quem usou o app nas últimas 24 h (aba Usuários) e os usuários com mais questões hoje, top 10 (aba Questões).
-- Rode uma vez no SQL Editor do Supabase. Pode rodar de novo (só recria a função). Só consulta: não altera
-- nenhum dado. Não mexe na função admin_stats() do painel_dados_admin.sql.
--
-- Contagem de erros e acertos = respostas avulsas (user_question_attempts) + respostas dentro de desafios
-- (challenge_answers), de todos os usuários, desde sempre. "Mais erros" e "mais acertos" são os números
-- absolutos, então questões muito respondidas aparecem mais; a lista mostra também o total e a porcentagem.
--
-- Segurança: igual à admin_stats(): confere o e-mail de quem chamou; qualquer outra conta recebe "forbidden".

-- Tema (fundo escuro ou claro) escolhido pela pessoa, guardado no perfil para seguir a conta entre aparelhos.
-- O app grava quando a pessoa abre o app (o tema que ela usa) e a cada troca no botão de sol/lua. Vazio = ainda não
-- registrado (quem nunca abriu o app depois da atualização; o padrão do app é o escuro).
alter table public.profiles add column if not exists theme text;
alter table public.profiles drop constraint if exists profiles_theme_check;
alter table public.profiles add constraint profiles_theme_check check (theme is null or theme in ('dark', 'light'));

-- Temas que a conta já usou (para saber quem experimentou o escuro E o claro). O banco só guardava o tema atual;
-- agora, toda vez que profiles.theme muda, o gatilho abaixo soma o novo tema à lista themes_used. O gatilho decide
-- a lista sozinho: o valor enviado pelo app é ignorado. Quem trocou de tema antes de hoje só aparece com o tema atual.
alter table public.profiles add column if not exists themes_used text[] not null default '{}';

create or replace function public.profiles_track_themes()
returns trigger
language plpgsql
as $fn$
begin
  if tg_op = 'INSERT' then
    new.themes_used := case when new.theme is null then '{}'::text[] else array[new.theme] end;
  else
    new.themes_used := coalesce(old.themes_used, '{}'::text[]);
    if new.theme is not null and not (new.theme = any (new.themes_used)) then
      new.themes_used := array_append(new.themes_used, new.theme);
    end if;
  end if;
  return new;
end;
$fn$;

drop trigger if exists profiles_track_themes on public.profiles;
create trigger profiles_track_themes
  before insert or update on public.profiles
  for each row execute function public.profiles_track_themes();

-- Preenchimento inicial: o tema que cada conta tem hoje.
update public.profiles
   set themes_used = array[theme]
 where theme is not null and not (theme = any (themes_used));

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
  v_t0     timestamptz := (public.app_today()::timestamp at time zone 'America/Sao_Paulo');  -- começo de hoje (Brasília)
  v_now    timestamptz := now();
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
    select p.id, p.name, u.email, p.streak, p.best_streak, p.last_mission_date, p.theme, p.themes_used
      from public.profiles p
      join auth.users u on u.id = p.id
     where coalesce(u.email, '') not like '%@flashcardio.invalid'
  ),
  -- Atividade das últimas 24 h (mesma definição de "ativo" do painel: respondeu questão, viu flashcard,
  -- abriu a missão diária ou criou desafio). Quem abre o app recebe a missão do dia, então "entrou" cai aqui.
  ev24 as (
    select a.user_id, a.answered_at as ts from public.user_question_attempts a where a.answered_at >= v_now - interval '24 hours'
    union all
    select c.user_id, c.answered_at from public.challenge_answers c where c.answered_at >= v_now - interval '24 hours'
    union all
    select f.user_id, f.viewed_at from public.user_flashcard_views f where f.viewed_at >= v_now - interval '24 hours'
    union all
    select m.user_id, m.created_at from public.daily_mission_picks m where m.created_at >= v_now - interval '24 hours'
    union all
    select h.from_user, h.created_at from public.challenges h where h.created_at >= v_now - interval '24 hours'
  ),
  -- Respostas de hoje (do começo do dia em Brasília até agora), avulsas + dentro de desafios.
  qhoje as (
    select a.user_id from public.user_question_attempts a where a.answered_at >= v_t0
    union all
    select c.user_id from public.challenge_answers c where c.answered_at >= v_t0
  ),
  -- Lembretes por notificação: um registro por aparelho que ligou o lembrete (Minha Conta > Permissões).
  subs as (
    select s.user_id, count(*) as aparelhos, min(s.created_at) as primeiro
      from public.push_subscriptions s
     group by s.user_id
  )
  select jsonb_build_object(
    'temas', (
      select jsonb_build_object(
               'escuro',       count(*) filter (where theme = 'dark'),
               'claro',        count(*) filter (where theme = 'light'),
               'sem_registro', count(*) filter (where theme is null),
               'ja_usaram_escuro', count(*) filter (where 'dark' = any (themes_used)),
               'ja_usaram_claro',  count(*) filter (where 'light' = any (themes_used)),
               'os_dois',          count(*) filter (where 'dark' = any (themes_used) and 'light' = any (themes_used))
             )
        from pessoas
    ),
    -- Quantas pessoas têm o lembrete por notificação ligado (em pelo menos 1 aparelho) e quantas não.
    'notificacoes', (
      select jsonb_build_object(
               'ativadas',    count(*) filter (where su.user_id is not null),
               'desativadas', count(*) filter (where su.user_id is null),
               'aparelhos',   coalesce(sum(su.aparelhos), 0),
               'novas_7d',    count(*) filter (where su.primeiro >= v_now - interval '7 days')
             )
        from pessoas pe
        left join subs su on su.user_id = pe.id
    ),
    'ultimos_usuarios', (
      select coalesce(jsonb_agg(jsonb_build_object('email', u.email, 'criado_em', u.created_at) order by u.created_at desc), '[]'::jsonb)
        from (select email, created_at from auth.users order by created_at desc limit 5) u
    ),
    -- Quem usou o app nas últimas 24 h, do mais recente para o mais antigo (até 100) e o total de pessoas.
    'ativos_24h', (
      select coalesce(jsonb_agg(jsonb_build_object('nome', x.name, 'email', x.email, 'ultimo', x.ultimo) order by x.ultimo desc), '[]'::jsonb)
        from (
          select pe.name, pe.email, max(e.ts) as ultimo
            from ev24 e join pessoas pe on pe.id = e.user_id
           group by pe.id, pe.name, pe.email
           order by max(e.ts) desc
           limit 100
        ) x
    ),
    'ativos_24h_total', (select count(distinct e.user_id) from ev24 e join pessoas pe on pe.id = e.user_id),
    -- Os 10 usuários que mais responderam questões hoje (avulsas + dentro de desafios).
    'top_questoes_hoje', (
      select coalesce(jsonb_agg(jsonb_build_object('nome', x.name, 'email', x.email, 'n', x.n) order by x.n desc, x.name), '[]'::jsonb)
        from (
          select pe.name, pe.email, count(*) as n
            from qhoje q join pessoas pe on pe.id = q.user_id
           group by pe.id, pe.name, pe.email
           order by count(*) desc, pe.name
           limit 10
        ) x
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
