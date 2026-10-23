-- Troca o tema de 4 questões de TEC 2015 que tinham sido importadas como "Outros Temas" para temas que já existem.
-- Só mexe em questões TEC 2015 que ainda estão com o tema "Outros Temas". Se alguma não for encontrada (ou já tiver outro tema), avisa e não altera nada.
--   Q42 drogas ilícitas -> Sd. Coronariana Aguda | Q57 viagens aéreas -> Pré-operatório | Q76 interações de fármacos -> Taquiarritmia | Q96 nefropatia por contraste -> Coronária Crônica
begin;

do $$
declare
  r record;
  v_n int;
begin
  for r in
    select * from (values
  ('Sd. Coronariana Aguda', $Q$Sobre os efeitos cardiovasculares das drogas ilícitas, é COR$Q$, 42),
  ('Pré-operatório', $Q$De acordo com a Diretriz dos Aspectos Médicos em Viagens Aér$Q$, 57),
  ('Taquiarritmia', $Q$Das afirmações a seguir, assinale a ERRADA.$Q$, 76),
  ('Coronária Crônica', $Q$Em relação à nefropatia induzida por contraste (NIC): I. A d$Q$, 96)
    ) as t(tema_novo, inicio, numero)
  loop
    update public.questions
    set tema = r.tema_novo
    where instituicao = 'TEC' and ano = 2015 and tema = 'Outros Temas'
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = r.inicio;
    get diagnostics v_n = row_count;
    if v_n <> 1 then
      raise exception 'Questão % de TEC 2015: esperava atualizar 1 linha e atualizou %. Nada foi alterado.', r.numero, v_n;
    end if;
  end loop;
end
$$;

-- conferência: não deve sobrar nenhuma questão de TEC 2015 em "Outros Temas" vinda deste import
select tema, count(*) as qtd
from public.questions
where instituicao = 'TEC' and ano = 2015
group by tema order by qtd desc;

commit;
