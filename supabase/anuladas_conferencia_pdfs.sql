-- Questões ANULADAS pela banca nos PDFs das provas e que no banco estão com um gabarito normal.
-- Marca todas as alternativas como corretas (é assim que o app trata anuladas: qualquer resposta vale e as quatro/cinco
-- alternativas aparecem em verde, com a faixa "QUESTÃO ANULADA").
-- Rode no SQL Editor do Supabase. Pode rodar de novo. Cada comando deve afetar exatamente as alternativas de 1 questão
-- (5 linhas; 4 nas questões de 4 alternativas); o resultado mostra quais.
--
-- Fontes:
--  * TEC 2007 a 2011: os próprios cadernos do TEC trazem "Questão anulada" nas questões (e a nota "a questão de nº 18 foi
--    anulada" em 2007).
--  * ENARE 2024/2025, área de atuação em Cardiologia (Ecocardiografia/Eletrofisiologia/Hemodinâmica, TIPO 1): gabarito
--    definitivo marca com asterisco (questão anulada) as questões 31 e 45.

-- ENARE 2025 Q31 (hipertensão resistente)
update question_options set correta = true
 where question_id in (
   select id from questions
    where instituicao = 'ENARE' and ano = 2025
      and starts_with(regexp_replace(enunciado, '\s+', ' ', 'g'), 'Um paciente de 83 anos, assintomático, hipertenso e diabético, em uso de diur')
 )
returning question_id, letra, correta;

-- ENARE 2025 Q45 (pericardite crônica)
update question_options set correta = true
 where question_id in (
   select id from questions
    where instituicao = 'ENARE' and ano = 2025
      and starts_with(regexp_replace(enunciado, '\s+', ' ', 'g'), 'Um paciente de 43 anos, portador de episódios repetitivos de pericardite aguda')
 )
returning question_id, letra, correta;

-- TEC 2007 #17 (endocardite — Q18 do caderno (cirurgia cardíaca na endocardite))
update question_options set correta = true
 where question_id in (
   select id from questions
    where instituicao = 'TEC' and ano = 2007
      and starts_with(regexp_replace(enunciado, '\s+', ' ', 'g'), 'Quais são as duas complicações que levariam à indicação absoluta de ci')
 )
returning question_id, letra, correta;

-- TEC 2009 #113 (angina vasoespástica)
update question_options set correta = true
 where question_id in (
   select id from questions
    where instituicao = 'TEC' and ano = 2009
      and starts_with(regexp_replace(enunciado, '\s+', ' ', 'g'), 'Com relação ao tratamento da angina variante, pode-se afirmar que I. O')
 )
returning question_id, letra, correta;

-- TEC 2010 #14 (atorvastatina/CYP3A4)
update question_options set correta = true
 where question_id in (
   select id from questions
    where instituicao = 'TEC' and ano = 2010
      and starts_with(regexp_replace(enunciado, '\s+', ' ', 'g'), 'Atorvastatina é o substrato maior de CYP3A4. Logo, inibidores potentes')
 )
returning question_id, letra, correta;

-- TEC 2010 #36 (reperfusão (Killip 2))
update question_options set correta = true
 where question_id in (
   select id from questions
    where instituicao = 'TEC' and ano = 2010
      and starts_with(regexp_replace(enunciado, '\s+', ' ', 'g'), 'Homem de 62 anos procurou a emergência com quadro de dor torácica com ')
 )
returning question_id, letra, correta;

-- TEC 2010 #42 (DAC estável, testes não invasivos)
update question_options set correta = true
 where question_id in (
   select id from questions
    where instituicao = 'TEC' and ano = 2010
      and starts_with(regexp_replace(enunciado, '\s+', ' ', 'g'), 'Sobre diagnóstico de doença arterial coronariana baseado em dados da h')
 )
returning question_id, letra, correta;

-- TEC 2010 #46 (inibidores IIb/IIIa)
update question_options set correta = true
 where question_id in (
   select id from questions
    where instituicao = 'TEC' and ano = 2010
      and starts_with(regexp_replace(enunciado, '\s+', ' ', 'g'), 'Em relação à terapia antiagregante plaquetária no manejo da síndrome c')
 )
returning question_id, letra, correta;

-- TEC 2010 #107 (amiloidose)
update question_options set correta = true
 where question_id in (
   select id from questions
    where instituicao = 'TEC' and ano = 2010
      and starts_with(regexp_replace(enunciado, '\s+', ' ', 'g'), 'O envolvimento cardiovascular pela amiloidose resulta em quatro síndro')
 )
returning question_id, letra, correta;

-- TEC 2011 #116 (edema perimaleolar (anlodipino))
update question_options set correta = true
 where question_id in (
   select id from questions
    where instituicao = 'TEC' and ano = 2011
      and starts_with(regexp_replace(enunciado, '\s+', ' ', 'g'), 'Paciente feminina, 55 anos, portadora de angina estável, em uso de asp')
 )
returning question_id, letra, correta;

-- TEC 2011 #112 (hirsutismo/hipopotassemia)
update question_options set correta = true
 where question_id in (
   select id from questions
    where instituicao = 'TEC' and ano = 2011
      and starts_with(regexp_replace(enunciado, '\s+', ' ', 'g'), 'Os achados clínicos que sugerem hipertensão arterial secundária à sínd')
 )
returning question_id, letra, correta;

