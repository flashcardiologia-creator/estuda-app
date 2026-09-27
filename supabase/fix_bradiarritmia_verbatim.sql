-- Auditoria de fidelidade ao documento fonte — tema "Bradiarritmia".
--
-- Este script corrige casos em que o processo de extração anterior
-- parafraseou/resumiu o "enunciado" de uma questão em vez de copiá-lo
-- literalmente do documento fonte (BRADIARRITMIA.txt). Em alguns casos o
-- enunciado chegou a omitir trechos de história clínica/medicações, a
-- reescrever a referência ao traçado de ECG/Holter ("...é apresentado a
-- seguir" virou uma descrição do achado, ou pior, revelou o diagnóstico
-- que deveria ser lido na imagem), ou a incorporar o texto de uma
-- alternativa dentro do próprio enunciado.
--
-- Comparação minuciosa das 20 questões (enunciado + todas as alternativas)
-- mostrou que, neste tema específico, as alternativas de question_options
-- já batem palavra por palavra com o documento fonte — nenhuma delas foi
-- reescrita como negação/comentário. Por isso este script só contém
-- updates em public.questions (coluna enunciado). Nenhum update em
-- question_options foi necessário.
--
-- NÃO mexe em comentario, comentario_completo, tema, ano, instituicao,
-- imagem_url ou correta.
--
-- Rode este arquivo uma vez no SQL Editor do seu projeto Supabase, após o
-- seed_bradiarritmia.sql já ter sido aplicado.

-- Questão 1 (2021, TEC) — faltava "abaixo" (referência ao traçado de Holter).
update public.questions set enunciado = $q$Mulher, 78 anos, portadora de marcapasso definitivo de longa data, procurou atendimento médico por episódios de síncope de repetição. O traçado de Holter 24 horas abaixo permite afirmar qual diagnóstico?$q$ where id = 'd32573c2-25f1-4019-9dd1-bf1f71134c6c';

-- Questão 2 (2021, TEC) — faltava a lista de medicações em uso e a frase
-- original de referência ao traçado ("diversos episódios similares ao
-- observado abaixo"), que havia sido substituída por uma descrição.
update public.questions set enunciado = $q$Mulher, 84 anos, hipertensa e coronariopata crônica, com história de palpitação nos últimos meses, pré-síncope de repetição e episódio de síncope sem pródromos. O ecocardiograma demonstrou fração de ejeção do ventrículo esquerdo preservada. Vinha em uso de valsartana, hidroclorotiazida, ácido acetilsalicílico e sinvastatina. Ao Holter 24h, pôde-se observar frequência cardíaca média de 52 bpm, além de diversos episódios similares ao observado abaixo. Qual diagnóstico e conduta adequados?$q$ where id = '6ca5766b-5efc-41c2-8879-c855d86e4b56';

-- Questão 3 (2020, TEC) — o enunciado original é curto ("Qual a conduta
-- correta frente aos achados identificados neste registro
-- eletrocardiográfico?"); o processo anterior havia inserido no enunciado
-- uma descrição do achado (alternância de BRD/BRE + BAV 1º grau) e um
-- dado clínico (síncope prévia) que só aparecem no comentário/explicação,
-- não no enunciado do documento.
update public.questions set enunciado = $q$Qual a conduta correta frente aos achados identificados neste registro eletrocardiográfico?$q$ where id = '97163364-1910-4e79-87da-d8acfa65c544';

-- Questão 5 (2014, TEC) — faltavam as frases "Hipertenso e diabético." e
-- "Vinha em uso regular de losartana, hidroclorotiazida e metformina.",
-- além da frase original de referência ao ECG ("é apresentado a seguir"),
-- que havia sido reescrita como uma descrição do achado.
update public.questions set enunciado = $q$Paciente masculino, 77 anos, com queixa de palpitação e pré-síncope de repetição nos últimos 3 meses. Hipertenso e diabético. Vinha em uso regular de losartana, hidroclorotiazida e metformina. Ecocardiograma com função sistólica preservada. O ECG realizado durante exacerbação dos sintomas é apresentado a seguir. Quais são o diagnóstico e a conduta terapêutica adequada?$q$ where id = 'ad0e5096-5abc-4dfa-9ceb-430d33b7a1d2';

-- Questão 6 (2012, TEC) — enunciado resumido: faltava "em consulta
-- ambulatorial", as doses completas de atenolol e sinvastatina, e a frase
-- original "Eletrocardiograma realizado durante a consulta evidenciou
-- bradiarritmia (traçado)." havia sido abreviada para "ECG evidenciou
-- bradiarritmia."
update public.questions set enunciado = $q$Paciente do sexo feminino, 68 anos, em consulta ambulatorial, apresentou queixa de dispneia aos esforços habituais, palpitações e escurecimento visual esporadicamente há 4 meses. Faz uso de atenolol, 50 mg, duas vezes por dia, e sinvastatina, 20 mg por dia, para tratamento de HAS e dislipidemia. Eletrocardiograma realizado durante a consulta evidenciou bradiarritmia (traçado). Quanto à indicação de implante de marca-passo definitivo, escolha a afirmativa correta:$q$ where id = '3d941793-5ed4-457c-bf9d-144cdc294295';

-- Questão 7 (2012, TEC) — enunciado resumido: faltava a frase "Fazia uso
-- regular de hidroclorotiazida e losartana.", os detalhes de ecocardiograma
-- e exames laboratoriais foram condensados, e as duas perguntas finais do
-- documento ("Qual o diagnóstico eletrocardiográfico? Qual a conduta
-- clínica a ser adotada?") haviam sido fundidas em uma só.
update public.questions set enunciado = $q$Paciente do sexo feminino, 84 anos, hipertensa de longa data, deu entrada no setor de emergência após episódio sincopal com lesão corporal. Fazia uso regular de hidroclorotiazida e losartana. Não apresentava cardiopatia estrutural. Ecocardiograma com a função sistólica preservada, exames laboratoriais normais, incluindo os marcadores de necrose miocárdica. Na admissão, apresentava-se torporosa, com palidez cutaneomucosa e PA = 70 X 40 mmHg. Qual o diagnóstico eletrocardiográfico? Qual a conduta clínica a ser adotada?$q$ where id = '17c9d7af-2edb-4fc1-9241-76700ba1fe2b';

-- Questão 8 (2019, TEC) — o enunciado original é apenas "Em relação ao
-- traçado de Holter, qual afirmação está correta:"; o processo anterior
-- havia colado o texto da alternativa A dentro do próprio enunciado (e
-- ainda acrescentou "(Wenckebach)", que não está na alternativa A do
-- documento), transformando a pergunta em algo que já entrega a resposta.
update public.questions set enunciado = $q$Em relação ao traçado de Holter, qual afirmação está correta:$q$ where id = '0e516885-ee23-467d-bf0e-e039355a0f6d';

-- Questão 9 (2014, TEC) — enunciado parafraseado: "Não houve
-- intercorrências durante o procedimento e o paciente evoluiu assintomático
-- após o implante." foi condensado, e "Com relação à atividade profissional
-- do paciente" foi encurtado para "Quanto à atividade profissional".
update public.questions set enunciado = $q$Motorista profissional teve marca-passo convencional implantado após diagnóstico de bradiarritmia sintomática sem cardiopatia estrutural. Não houve intercorrências durante o procedimento e o paciente evoluiu assintomático após o implante. Com relação à atividade profissional do paciente, o médico assistente pode liberá-lo a retornar ao trabalho:$q$ where id = '51f2bbf7-b3ea-4bdf-b66f-d0f6f990331c';

-- Questão 12 (2019, TEC) — enunciado fortemente resumido: faltavam as
-- doses das medicações prévias, o detalhe da curva de marcadores e, mais
-- grave, a frase original "O eletrocardiograma (ECG) da admissão está
-- apresentado nesta imagem." havia sido substituída por uma frase que
-- entrega o diagnóstico ("O ECG mostra um bloqueio atrioventricular com
-- padrão 2:1"), o que deveria ser lido na imagem, não afirmado no enunciado.
update public.questions set enunciado = $q$Mulher, 82 anos, hipertensa e diabética, admitida no setor de emergência com queixa de cansaço progressivo aos esforços há aproximadamente um mês e episódio de síncope sem pródromos uma hora antes do atendimento. Fazia uso prévio de enalapril 20 mg/dia, hidroclorotiazida 25 mg/dia, metformina 850 mg/dia. Curva de marcadores (CK massa e Troponina I) normal. O ecocardiograma evidenciava hipertrofia concêntrica do ventrículo esquerdo sugestivo com cardiopatia hipertensiva. O eletrocardiograma (ECG) da admissão está apresentado nesta imagem. Qual o diagnóstico eletrocardiográfico e a conduta médica indicada neste caso?$q$ where id = 'a649b4c4-b85e-4113-b299-f4d5672b1da7';

-- Questão 13 (2024, TEC) — enunciado drasticamente resumido: faltavam "em
-- uso regular de anlodipino e rosuvastatina", "comparece para avaliação de
-- rotina", e toda a lista detalhada de exames complementares (intervalo PR,
-- duração do QRS, cintilografia, fármaco injetado, laboratório) foi
-- condensada em uma única frase.
update public.questions set enunciado = $q$Paciente do sexo masculino, 82 anos, assintomático, hipertenso e dislipidêmico, em uso regular de anlodipino e rosuvastatina, comparece para avaliação de rotina. Faz Pilates 3 vezes/semana, sem queixas. Traz os exames complementares descritos abaixo.
-Eletrocardiograma: bradicardia sinusal; frequência cardíaca (FC) = 44 bpm; intervalo PR 150 ms e QRS com duração de 80 ms.
-Ecocardiograma: sem alterações significativas.
-Cintilografia do miocárdio com teste ergométrico: negativa para isquemia.
-Fármaco injetado com 87% da FC máxima.
-Holter: sem arritmias significativas. FC média 48 bpm.
-Laboratório: sem alterações significativas.
Sobre esse paciente, é correto afirmar:$q$ where id = '52780979-b792-4eb6-8df4-e02292ccab55';

-- Questão 14 (2014, TEC) — enunciado parafraseado: "com antecedentes de
-- hipertensão arterial" virou "com hipertensão arterial", "deu entrada no
-- pronto-socorro com queixa de" virou "deu entrada com", e "Durante a
-- realização do ECG a seguir" virou "Durante o ECG" (perdendo a referência
-- original à imagem).
update public.questions set enunciado = $q$Mulher, 46 anos com antecedentes de hipertensão arterial, deu entrada no pronto-socorro com queixa de cansaço, tontura e lipotimia há 1 mês. História familiar de doença de Chagas. Durante a realização do ECG a seguir, apresentou pré-síncope. Quanto à abordagem terapêutica, qual é a alternativa CORRETA?$q$ where id = '19396bda-af5f-40e2-b96d-1ae8cb103a7e';

-- Questão 15 (2014, TEC) — enunciado resumido em vários pontos: "classe
-- funcional I-NYHA" virou "CF I-NYHA", a referência original ao ECG
-- "(eletrocardiograma a seguir)" foi removida, "vários surtos" virou
-- "surtos", e as frases sobre FC máxima e ecocardiograma foram encurtadas.
update public.questions set enunciado = $q$Paciente feminina, 21 anos, assintomática (classe funcional I-NYHA), com o diagnóstico de bloqueio atrioventricular (BAV) total congênito (eletrocardiograma a seguir). Ao Holter de 24 horas, observou-se intensa atividade ectópica ventricular polimórfica com vários surtos de taquicardia ventricular não sustentada. A FC máxima atingida durante o teste ergométrico foi de 69 bpm. O ecocardiograma excluiu a presença de qualquer cardiopatia com função sistólica biventricular preservada. Qual é a conduta clínica a ser adotada?$q$ where id = '866e9c66-9354-459b-b713-015423d14259';

-- Questão 16 (2016, TEC) — "A pressão arterial de admissão foi 100x60
-- mmHg." havia sido abreviada para "PA de admissão 100x60 mmHg."
update public.questions set enunciado = $q$Paciente com 58 anos refere tontura e apresenta diagnóstico de IAM parede inferior e frequência cardíaca de 32 bpm, com ritmo de bloqueio atrioventricular total e escape de QRS largo. A pressão arterial de admissão foi 100x60 mmHg. A MELHOR conduta inicial é:$q$ where id = '64fd416c-5e1e-4301-8a8a-54b17b63c435';
