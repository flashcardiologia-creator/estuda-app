-- Quiz de boas-vindas: quem abre o site responde 3 questões fáceis e ganha dias grátis, SEM cupom.
--   acertou 0 -> 3 dias | 1 -> 5 dias | 2 -> 7 dias | 3 -> 10 dias
-- A tentativa fica gravada pelo IP de quem respondeu: atualizar a página não dá outra chance (a pessoa vê o
-- mesmo resultado). Os dias entram sozinhos quando ela cria a conta, sem cupom.
-- Rode UMA vez no SQL Editor do Supabase (depois de assinaturas.sql e cupom_10diasgratis.sql). Pode rodar de novo.
--
-- Como funciona:
--   * public.quiz_boas_vindas: quais são as 3 questões (slot 1 = ausculta INCOR R+, slot 2 = insuficiência
--     cardíaca DANTE, slot 3 = coronária TEC). Para trocar uma: update public.quiz_boas_vindas set question_id = '...' where slot = 1;
--   * public.quiz_tentativas: uma linha por IP com as respostas, os acertos e os dias. O IP vem do servidor do app
--     (rota /auth/quiz), nunca do navegador; só o servidor (service_role) mexe nesta tabela.
--   * quiz_boas_vindas_questoes(): as questões SEM o gabarito.
--   * quiz_boas_vindas_tentativa(ip): devolve a tentativa já gravada desse IP (resultado completo), se houver.
--   * quiz_boas_vindas_registrar(ip, respostas): grava a primeira tentativa do IP e corrige no banco; se o IP já tem
--     tentativa, ignora as respostas novas e devolve a antiga.
--   * quiz_boas_vindas_resgatar(): chamada pelo app depois do login; o cadastro da conta leva o número da tentativa
--     (quiz_id), o banco confere, e libera os dias pela mesma função dos pagamentos (grant_access). Cada tentativa
--     e cada e-mail resgatam uma única vez, só contas criadas há até 7 dias e só até o fim do cupom (02/12/2026).
--     Quem resgata o quiz não pode somar o cupom #10DIASGRATIS depois.
--   * A janela antiga "Você ganhou um cupom!" é desligada (o quiz toma o lugar dela).

create table if not exists public.quiz_boas_vindas (
  slot        integer primary key check (slot between 1 and 3),
  question_id uuid not null references public.questions (id) on delete cascade
);
alter table public.quiz_boas_vindas enable row level security;     -- sem policies: só as funções abaixo leem
revoke all on public.quiz_boas_vindas from anon, authenticated;

create table if not exists public.quiz_tentativas (
  id            uuid primary key default gen_random_uuid(),
  ip            text,
  respostas     jsonb not null,
  acertos       integer not null,
  dias          integer not null,
  criado_em     timestamptz not null default now(),
  resgatado_por uuid references auth.users (id) on delete set null,
  resgatado_em  timestamptz
);
create unique index if not exists quiz_tentativas_um_por_ip on public.quiz_tentativas (ip) where ip is not null;
alter table public.quiz_tentativas enable row level security;
revoke all on public.quiz_tentativas from anon, authenticated;

create table if not exists public.quiz_resgates (
  id          uuid primary key default gen_random_uuid(),
  user_id     uuid references auth.users (id) on delete set null,
  email       text not null,
  acertos     integer not null,
  dias        integer not null,
  resgatado_em timestamptz not null default now()
);
create unique index if not exists quiz_resgates_um_por_email on public.quiz_resgates (lower(email));
alter table public.quiz_resgates enable row level security;
revoke all on public.quiz_resgates from anon, authenticated;

-- As 3 questões (achadas pelo começo do enunciado; se a questão não existir, o espaço fica vazio e o app não mostra o quiz).
insert into public.quiz_boas_vindas (slot, question_id)
select 1, q.id from public.questions q
 where q.tema = 'Ausculta' and q.instituicao like 'INCOR R+%'
   and q.enunciado like 'Em pacientes com estenose valvar aórtica, pode-se ter como achado%'
 order by q.id limit 1
on conflict (slot) do update set question_id = excluded.question_id;

insert into public.quiz_boas_vindas (slot, question_id)
select 2, q.id from public.questions q
 where q.tema = 'Insuficiência Cardíaca' and q.instituicao like 'DANTE%'
   and q.enunciado like 'Homem, de 60 anos de idade, portador de doença de Chagas, apresentou declínio funcional%'
 order by q.id limit 1
on conflict (slot) do update set question_id = excluded.question_id;

insert into public.quiz_boas_vindas (slot, question_id)
select 3, q.id from public.questions q
 where q.tema = 'Sd. Coronariana Aguda' and q.instituicao = 'TEC'
   and q.enunciado like 'Qual o principal fator determinante da sobrevida em curto e longo prazos%'
 order by q.id limit 1
on conflict (slot) do update set question_id = excluded.question_id;

-- Funções da versão anterior (liberavam a correção para qualquer visitante, o que permitia tentar de novo).
drop function if exists public.quiz_boas_vindas_corrigir(jsonb);

-- Dias por número de acertos: 0 -> 3, 1 -> 5, 2 -> 7, 3 -> 10.
create or replace function public.quiz_boas_vindas_dias(p_acertos integer)
returns integer
language sql
immutable
as $$
  select case when p_acertos <= 0 then 3 when p_acertos = 1 then 5 when p_acertos = 2 then 7 else 10 end;
$$;

-- Correção (uso interno): respostas = {"1":"A","2":"C","3":"B"}, chave = slot, valor = letra.
create or replace function public.quiz_boas_vindas_corrigir_interno(p_respostas jsonb)
returns jsonb
language plpgsql
stable
security definer
set search_path = public
as $$
declare
  v_itens   jsonb;
  v_acertos integer;
begin
  select coalesce(jsonb_agg(item order by slot), '[]'::jsonb)
    into v_itens
    from (
      select b.slot,
             jsonb_build_object(
               'slot', b.slot,
               'escolhida', upper(coalesce(p_respostas ->> b.slot::text, '')),
               'correta', c.letra,
               'acertou', upper(coalesce(p_respostas ->> b.slot::text, '')) = c.letra,
               'tema', q.tema,
               'instituicao', q.instituicao,
               'comentario', q.comentario,
               'comentario_completo', q.comentario_completo
             ) as item
        from public.quiz_boas_vindas b
        join public.questions q on q.id = b.question_id
        join lateral (
          select upper(o.letra) as letra from public.question_options o
           where o.question_id = q.id and o.correta limit 1
        ) c on true
    ) t;

  select count(*) into v_acertos from jsonb_array_elements(v_itens) e where (e ->> 'acertou')::boolean;

  return jsonb_build_object(
    'acertos', v_acertos,
    'total', jsonb_array_length(v_itens),
    'dias', public.quiz_boas_vindas_dias(v_acertos),
    'tabela', jsonb_build_array(public.quiz_boas_vindas_dias(0), public.quiz_boas_vindas_dias(1), public.quiz_boas_vindas_dias(2), public.quiz_boas_vindas_dias(3)),
    'questoes', v_itens
  );
end;
$$;
revoke all on function public.quiz_boas_vindas_corrigir_interno(jsonb) from public, anon, authenticated;

-- Questões do quiz, sem o gabarito (o servidor do app chama).
create or replace function public.quiz_boas_vindas_questoes()
returns jsonb
language sql
stable
security definer
set search_path = public
as $$
  select jsonb_build_object(
    'tabela', jsonb_build_array(public.quiz_boas_vindas_dias(0), public.quiz_boas_vindas_dias(1), public.quiz_boas_vindas_dias(2), public.quiz_boas_vindas_dias(3)),
    'questoes', coalesce((
      select jsonb_agg(
               jsonb_build_object(
                 'slot', b.slot,
                 'tema', q.tema,
                 'ano', q.ano,
                 'instituicao', q.instituicao,
                 'enunciado', q.enunciado,
                 'alternativas', (
                   select jsonb_agg(jsonb_build_object('letra', upper(o.letra), 'texto', o.texto) order by upper(o.letra))
                     from public.question_options o where o.question_id = q.id
                 )
               ) order by b.slot)
        from public.quiz_boas_vindas b
        join public.questions q on q.id = b.question_id
    ), '[]'::jsonb)
  );
$$;
revoke all on function public.quiz_boas_vindas_questoes() from public, anon, authenticated;
grant execute on function public.quiz_boas_vindas_questoes() to service_role;

-- Tentativa já gravada para este IP: { id, resultado } ou null.
create or replace function public.quiz_boas_vindas_tentativa(p_ip text)
returns jsonb
language plpgsql
stable
security definer
set search_path = public
as $$
declare
  t public.quiz_tentativas;
begin
  if p_ip is null or p_ip = '' then
    return null;
  end if;
  select * into t from public.quiz_tentativas where ip = p_ip;
  if not found then
    return null;
  end if;
  return jsonb_build_object('id', t.id, 'resultado', public.quiz_boas_vindas_corrigir_interno(t.respostas));
end;
$$;
revoke all on function public.quiz_boas_vindas_tentativa(text) from public, anon, authenticated;
grant execute on function public.quiz_boas_vindas_tentativa(text) to service_role;

-- Grava a primeira tentativa do IP. Se o IP já tem tentativa, ignora as respostas novas e devolve a antiga.
-- Devolve { id, ja_tinha, resultado }.
create or replace function public.quiz_boas_vindas_registrar(p_ip text, p_respostas jsonb)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  t        public.quiz_tentativas;
  v_resp   jsonb;
  v_res    jsonb;
begin
  if p_ip is not null and p_ip <> '' then
    select * into t from public.quiz_tentativas where ip = p_ip;
    if found then
      return jsonb_build_object('id', t.id, 'ja_tinha', true, 'resultado', public.quiz_boas_vindas_corrigir_interno(t.respostas));
    end if;
  end if;

  -- Só guarda a letra de cada slot (A a E).
  select coalesce(jsonb_object_agg(b.slot::text, upper(left(coalesce(p_respostas ->> b.slot::text, ''), 1))), '{}'::jsonb)
    into v_resp from public.quiz_boas_vindas b;
  v_res := public.quiz_boas_vindas_corrigir_interno(v_resp);

  begin
    insert into public.quiz_tentativas (ip, respostas, acertos, dias)
    values (nullif(p_ip, ''), v_resp, (v_res ->> 'acertos')::integer, (v_res ->> 'dias')::integer)
    returning * into t;
  exception when unique_violation then
    select * into t from public.quiz_tentativas where ip = p_ip;
    return jsonb_build_object('id', t.id, 'ja_tinha', true, 'resultado', public.quiz_boas_vindas_corrigir_interno(t.respostas));
  end;

  return jsonb_build_object('id', t.id, 'ja_tinha', false, 'resultado', v_res);
end;
$$;
revoke all on function public.quiz_boas_vindas_registrar(text, jsonb) from public, anon, authenticated;
grant execute on function public.quiz_boas_vindas_registrar(text, jsonb) to service_role;

-- Resgate depois do login: o cadastro da conta leva o número da tentativa (quiz_id).
drop function if exists public.quiz_boas_vindas_resgatar();
create or replace function public.quiz_boas_vindas_resgatar()
returns table(out_status text, out_acertos integer, out_dias integer, out_expires_at timestamptz)
language plpgsql
security definer
set search_path = public, auth
as $$
#variable_conflict use_column
declare
  v_user    uuid := auth.uid();
  v_email   text;
  v_created timestamptz;
  v_meta    text;
  v_id      uuid;
  v_ate     timestamptz;
  t         public.quiz_tentativas;
  v_exp     timestamptz;
begin
  if v_user is null then
    raise exception 'not_authenticated';
  end if;

  select u.email, u.created_at, u.raw_user_meta_data ->> 'quiz_id'
    into v_email, v_created, v_meta
    from auth.users u where u.id = v_user;

  begin
    v_id := v_meta::uuid;
  exception when others then
    v_id := null;
  end;
  if v_id is null then
    return query select 'sem_quiz'::text, null::integer, null::integer, null::timestamptz;
    return;
  end if;

  select c.valid_until into v_ate from public.coupons c where c.code = '#10DIASGRATIS';
  if v_ate is not null and now() >= v_ate then
    return query select 'expirado'::text, null::integer, null::integer, null::timestamptz;
    return;
  end if;

  if v_created < now() - interval '7 days' then
    return query select 'conta_antiga'::text, null::integer, null::integer, null::timestamptz;
    return;
  end if;

  select * into t from public.quiz_tentativas where id = v_id for update;
  if not found then
    return query select 'sem_quiz'::text, null::integer, null::integer, null::timestamptz;
    return;
  end if;
  if t.resgatado_por is not null then
    return query select 'ja_usado'::text, null::integer, null::integer, null::timestamptz;
    return;
  end if;

  begin
    insert into public.quiz_resgates (user_id, email, acertos, dias) values (v_user, lower(v_email), t.acertos, t.dias);
  exception when unique_violation then
    return query select 'ja_usado'::text, null::integer, null::integer, null::timestamptz;
    return;
  end;

  update public.quiz_tentativas set resgatado_por = v_user, resgatado_em = now() where id = t.id;

  select g.out_expires_at into v_exp
    from public.grant_access(v_email, 'cortesia', now(), null, 'cortesia',
                             'quiz-' || v_user, t.dias, 'Quiz de boas-vindas: ' || t.acertos || ' acerto(s)') g;

  -- Quem ganhou pelo quiz não soma o cupom #10DIASGRATIS depois.
  insert into public.coupon_redemptions (user_id, email, code)
  select v_user, lower(v_email), c.code from public.coupons c where c.code = '#10DIASGRATIS'
  on conflict do nothing;

  return query select 'ok'::text, t.acertos, t.dias, v_exp;
end;
$$;
revoke all on function public.quiz_boas_vindas_resgatar() from public, anon;
grant execute on function public.quiz_boas_vindas_resgatar() to authenticated;

-- A janela "Você ganhou um cupom!" de contas novas sai de cena (o quiz substitui). O cupom digitado em Assinatura continua valendo.
update public.coupons set offer_from = null where ltrim(code, '#') = '10DIASGRATIS';

-- ============================================================
-- Conferir se as 3 questões foram achadas (deve listar 3 linhas, slots 1, 2 e 3):
select b.slot, q.instituicao, q.tema, q.ano, left(q.enunciado, 70) as enunciado,
       (select count(*) from public.question_options o where o.question_id = q.id) as alternativas
  from public.quiz_boas_vindas b join public.questions q on q.id = b.question_id order by b.slot;
-- ============================================================
-- Depois, para consultar:
--   select ip, acertos, dias, criado_em, resgatado_por is not null as resgatado from public.quiz_tentativas order by criado_em desc;
--   select email, acertos, dias, resgatado_em from public.quiz_resgates order by resgatado_em desc;
-- Liberar uma nova tentativa para um IP (ex.: pessoa que errou sem querer):
--   delete from public.quiz_tentativas where ip = '123.45.67.89' and resgatado_por is null;
-- Trocar uma questão do quiz (slot 1, 2 ou 3):
--   update public.quiz_boas_vindas set question_id = '<id da questão>' where slot = 1;
-- Mudar os dias de cada faixa: edite a função quiz_boas_vindas_dias (e rode de novo).
-- ============================================================
