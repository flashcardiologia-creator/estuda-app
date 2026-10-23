-- A questão "Qual a etiologia mais provável para os achados do exame físico apresentado nas imagens?"
-- (xantomas tendíneos) está no banco como TEC 2015 (id 4f5cd7dd-91b0-4229-8e8c-8af7adff1948, vinda do seed_dislipidemia_q14.sql),
-- mas é a questão 92 da prova TEC 2021 (import_tec_parte2_2020_2021_2022.sql, gabarito C).
-- Este script corrige o ano. Se o import do TEC 2021 já tiver sido rodado (duplicata), apaga a cópia marcada como 2015.
begin;

do $$
declare
  v_id constant uuid := '4f5cd7dd-91b0-4229-8e8c-8af7adff1948';
  v_dup uuid;
begin
  if not exists (select 1 from public.questions where id = v_id and ano = 2015) then
    raise notice 'Questão já não está como 2015. Nada alterado.';
    return;
  end if;

  select q2.id into v_dup
  from public.questions q2
  where q2.instituicao = 'TEC' and q2.ano = 2021 and q2.id <> v_id
    and left(regexp_replace(q2.enunciado, '\s+', ' ', 'g'), 60) = 'Qual a etiologia mais provável para os achados do exame físi'
  limit 1;

  if v_dup is not null then
    -- já existe a versão oficial de 2021: remove a cópia errada de 2015
    delete from public.question_options where question_id = v_id;
    delete from public.questions where id = v_id;
    raise notice 'Duplicata encontrada (%). Cópia de 2015 apagada.', v_dup;
  else
    update public.questions set ano = 2021 where id = v_id;
    raise notice 'Ano corrigido para 2021.';
  end if;
end
$$;

commit;
