-- TEC 2024, questão do forame oval patente (AVC e Doença Arterial Periférica, "Adulto jovem em investigação de quadro de AVC...").
-- 1) Troca a imagem da questão pela versão recortada, sem a linha de texto do enunciado que aparecia em cima.
-- 2) Coloca no comentário completo a mesma imagem com um círculo marcando o forame oval.
-- ANTES: rode o SQL "imagem no comentário" (cria a coluna comentario_imagem_url) e suba as 2 imagens no bucket question-images:
--   ete_limpa.png e ete_circulada.png
-- A questão é achada pelo texto do enunciado (com trechos curingas), sem depender do tema nem do ano. Se não achar exatamente 1,
-- o SQL para e mostra no erro quais questões parecidas existem no banco.
begin;

do $$
declare
  v_n int;
  v_info text;
begin
  update public.questions
  set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/ete_limpa.png',
      comentario_imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/ete_circulada.png',
      comentario_completo = case
        when comentario_completo like '%círculo vermelho%' then comentario_completo
        else comentario_completo || E'\n\nNa imagem abaixo, o círculo vermelho marca o forame oval patente no septo interatrial.'
      end
  where regexp_replace(enunciado, '\s+', ' ', 'g') ilike 'Adulto jovem em investiga%acidente vascular cerebral%ecocardiograma transesof%Qual a assertiva correta%';
  get diagnostics v_n = row_count;
  if v_n <> 1 then
    select string_agg(format('[%s | %s | %s | %s | %s]', q.id, q.instituicao, q.ano, q.tema, left(regexp_replace(q.enunciado, '\s+', ' ', 'g'), 70)), ' ; ')
      into v_info
    from public.questions q
    where q.enunciado ilike '%forame oval%' or q.enunciado ilike '%Adulto jovem em investiga%' or q.enunciado ilike '%ecocardiograma transesof%acidente vascular%';
    raise exception 'Esperava atualizar 1 questão e atualizou %. Nada foi alterado. Questões parecidas no banco: %', v_n, coalesce(v_info, 'nenhuma');
  end if;
end
$$;

-- conferência: uma linha, com as duas imagens preenchidas
select id, instituicao, ano, tema, left(enunciado, 60) as inicio, imagem_url, comentario_imagem_url
from public.questions
where comentario_imagem_url like '%ete_circulada.png';

commit;
