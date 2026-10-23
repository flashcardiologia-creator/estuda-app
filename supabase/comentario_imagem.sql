-- Imagem no comentário completo das questões.
-- 1) Coluna nova questions.comentario_imagem_url (endereço da imagem; pode ficar vazia).
-- 2) get_questions_content passa a devolver a coluna (a função precisa ser recriada porque o formato do retorno muda).
-- O app mostra a imagem no comentário completo (botão "Resposta completa"), com o mesmo zoom das outras imagens.
-- Antes deste SQL o app continua funcionando normalmente, só não mostra imagem no comentário.
begin;

alter table public.questions add column if not exists comentario_imagem_url text;

drop function if exists public.get_questions_content(uuid[]);

create function public.get_questions_content(p_ids uuid[])
returns table(
  id uuid, tema text, ano integer, instituicao text,
  enunciado text, comentario text, comentario_completo text, imagem_url text, comentario_imagem_url text
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
           q.enunciado::text, q.comentario::text, q.comentario_completo::text, q.imagem_url::text, q.comentario_imagem_url::text
      from public.questions q
     where q.id = any(p_ids)
       and (public._has_access(v_user) or q.id in (select public._visible_question_ids(v_user)));
end;
$$;

revoke all on function public.get_questions_content(uuid[]) from public, anon;
grant execute on function public.get_questions_content(uuid[]) to authenticated;

-- conferência: a coluna existe e a função devolve 9 colunas
select
  (select count(*) from information_schema.columns where table_schema = 'public' and table_name = 'questions' and column_name = 'comentario_imagem_url') as coluna_esperado_1,
  (select count(*) from pg_proc p join pg_namespace n on n.oid = p.pronamespace
    where n.nspname = 'public' and p.proname = 'get_questions_content' and pg_get_function_result(p.oid) like '%comentario_imagem_url%') as funcao_esperado_1;

commit;
