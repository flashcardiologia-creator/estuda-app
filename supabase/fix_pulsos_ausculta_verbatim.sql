-- Correções de auditoria "verbatim" para seed_pulsos_ausculta.sql
-- (temas "Pulsos" e "Ausculta", banca TEC).
--
-- Contexto: seed_pulsos_ausculta.sql já foi rodado no banco. Uma auditoria
-- comparou cada "enunciado" e cada alternativa (question_options.texto)
-- contra os documentos-fonte originais:
--   - C:\Users\Dell\Downloads\EXERCICIOS AUSCULTA.txt
--   - C:\Users\Dell\Downloads\PULSOS.txt
-- Em alguns casos o enunciado clínico foi parafraseado/resumido, e em
-- algumas alternativas o texto foi truncado (cortando a frase no meio) ou
-- teve palavras trocadas. Este arquivo restaura o texto literal do
-- documento-fonte nesses casos (com correção apenas de erros óbvios de
-- digitação/truncamento, sem alterar sentido).
--
-- NÃO toca em: comentario, tema, ano, instituicao, correta.
-- Rode este arquivo uma vez no SQL Editor do Supabase, depois do seed
-- original.

-- ============================================================
-- Tema: Pulsos
-- ============================================================

-- Questão "mastectomia / tamponamento cardíaco": o enunciado tinha cortado
-- a referência ao ECG ("Foi solicitado o eletrocardiograma mostrado a
-- seguir"), e as alternativas A, B e E de multipla escolha estavam
-- truncadas (cortadas no meio da frase) em relação ao documento.
update public.questions set enunciado = $q$Paciente do sexo feminino, 55 anos de idade, submetida à mastectomia esquerda há 2 anos por neoplasia maligna, seguida de radioterapia e quimioterapia, com boa evolução. Há 15 dias, começou a ter dispneia rapidamente progressiva, chegando à dispneia de repouso há 2 dias, além de palpitações e mal-estar indefinido, motivo pelo qual procurou serviço médico de urgência. Negava dores torácicas e edema de membros inferiores. Ao exame físico: taquipneica; pressão arterial (PA) = 100 x 80 mmHg (durante inspiração profunda 80 x 60 mmHg); frequência cardíaca (FC) = 100 bpm, rítmico; pescoço: estase jugular 3+/4+ a 45°; ausculta cardíaca: bulhas rítmicas hipofonéticas sem sopros; pulmões livres; abdômen e membros inferiores sem alterações ao exame físico. Foi solicitado o eletrocardiograma mostrado a seguir. Assinale a alternativa CORRETA em relação à investigação diagnóstica e à abordagem clínica.$q$ where id = '41319994-aef5-47ef-9846-8040b0c3e4fa';

update public.question_options set texto = $q$A paciente apresenta quadro clínico de tamponamento cardíaco, que pode ser comprovado pelo ecocardiograma, mostrando espaço pericárdico maior que 20 mm e compressão de átrio e ventrículo direitos. Deve ser tratada com diurético de alça, oxigênio e repouso absoluto, com programação de abordagem cirúrgica pela rotina para esvaziamento do derrame pericárdico e dosagem de adenosina deaminase para comprovar ou afastar comprometimento pericárdico por tuberculose, que é provável por se tratar de paciente com tratamento recente de doença neoplásica maligna.$q$ where question_id = '41319994-aef5-47ef-9846-8040b0c3e4fa' and letra = 'a';

update public.question_options set texto = $q$A paciente apresenta quadro clínico de tamponamento cardíaco, com pulso paradoxal ao exame físico e alternância elétrica ao eletrocardiograma. Deve ser submetida a ecocardiograma para comprovação da presença de derrame pericárdico importante e, em seguida, drenagem cirúrgica preferencialmente com videopericardioscopia para realização de biópsia pericárdica guiada.$q$ where question_id = '41319994-aef5-47ef-9846-8040b0c3e4fa' and letra = 'b';

update public.question_options set texto = $q$Após o eletrocardiograma, o exame de escolha seria a radiografia de tórax, que, nesse caso, mostraria aumento global da área cardíaca com ampliação de hilos pulmonares e cefalização da trama vascular pulmonar, por congestão importante.$q$ where question_id = '41319994-aef5-47ef-9846-8040b0c3e4fa' and letra = 'e';

-- Questão "pericardite crônica constritiva": alternativa D estava
-- truncada (faltava a parte final sobre o enchimento ventricular).
update public.question_options set texto = $q$Knock pericárdico é um achado físico comum, caracterizado por ruído agudo, telediastólico e determinado pela contração atrial, incrementando o enchimento ventricular contra o ventrículo restrito.$q$ where question_id = 'dde4d085-dd5d-421e-aadf-b0d691aa0b9f' and letra = 'd';

-- ============================================================
-- Tema: Ausculta
-- ============================================================

-- Questão "cardiopatia reumática": o enunciado original é uma lista de
-- achados de exame físico (formato com marcadores "-"), mas havia sido
-- reescrito como um único parágrafo corrido. Restaurado no formato de
-- lista do documento-fonte.
update public.questions set enunciado = $q$Paciente portador de cardiopatia reumática apresenta, ao exame físico:
- Pulso arterial: forma normal, com amplitude diminuída.
- Pulso venoso: onda "v" mais ampla que a onda "a" e colapso "y" profundo.
- Impulsão do ventrículo esquerdo no quarto espaço intercostal esquerdo de difícil palpação.
- Impulsão do ventrículo direito palpável e hiperdinâmico.
- B1 hiperfonética.
- P2 mais intensa que A2.
- Estalido de abertura amplo, muito próximo de B2, introduzindo sopro mesodiastólico, que se intensifica com expiração.
- B3 ampla com manobra inspiratória.
- Sopro sistólico 2+/4+ no quarto espaço intercostal da região paraesternal esquerda que se intensifica com a inspiração.
Qual é o diagnóstico?$q$ where id = '3c7b69d5-9f09-46ea-84b1-d578c9521df1';

-- Questão "ventrículo direito palpável / desdobramento fixo de B2": o
-- documento-fonte diz apenas "em classe funcional," (sem numeral); o seed
-- havia inventado "classe funcional I", que não está no documento.
update public.questions set enunciado = $q$Paciente do sexo feminino, 55 anos, em classe funcional, apresenta, ao exame físico, um ventrículo direito palpável, estando a segunda bulha com desdobramento fixo e com o componente pulmonar aumentado. Um sopro sistólico de intensidade 2/6+ é auscultado em foco pulmonar. Diante deste quadro clínico, o diagnóstico deve ser:$q$ where id = '6e45d53f-8514-45cb-8de1-55f6b452d9cd';

-- Questão "Chagas / dispneia há 6 meses": o enunciado havia sido
-- fortemente reescrito/resumido (mudou conectivos, expandiu abreviações,
-- e omitiu o dado "6°/7º EIC" da localização do ictus). Restaurado o texto
-- literal do documento, corrigindo apenas truncamentos óbvios
-- ("positiv" -> "positiva", "ápic" -> "ápice").
update public.questions set enunciado = $q$Paciente do sexo masculino, 47 anos, relata dispneia há 6 meses, pior há 7 dias. Dispneia, fadiga e edema de MMIIs, sorologia para Chagas positiva. Ao exame físico, bom estado geral, hipocorado +/4+, hidratado, taquipneico, estase jugular onda V proeminente, hepatomegalia dolorosa, edema de MMII, pulmões com raros estertores em base, extremidades frias, pulso fino, regular e com variação de amplitude, FC = 112 bpm, PA = 92 x 78 mmHg. Ictus desviado para a esquerda e para baixo, 6°/7º EIC, B1 hipo, B2 normo. Sopro holossistólico, platô 2+/6+ BEE- que aumenta à inspiração profunda e mitral, que aumenta em decúbito lateral esquerdo, B3 em ápice. Pode-se AFIRMAR a presença de:$q$ where id = 'e71c6f35-e94f-4388-b732-45252d9dbba1';

-- Questão "sopro sistólico borda esternal esquerda / onda v e y": a
-- alternativa E trocou "tendinosa" (termo do documento) por "tendínea".
update public.question_options set texto = $q$Ruptura de cordoalha tendinosa do folheto posterior da valva mitral.$q$ where question_id = 'a190eb39-c32b-4a5f-9f4c-7de0d7ce0534' and letra = 'e';

-- Questão "insuficiência aórtica grave / INCORRETA": a alternativa B
-- trocou o conectivo "e se inicia" por ", que se inicia".
update public.question_options set texto = $q$A característica é de sopro diastólico, aspirativo e se inicia imediatamente após a segunda bulha.$q$ where question_id = '5ab93625-48c8-41e5-951c-57f6fd763592' and letra = 'b';

-- Questão "insuficiência aórtica grave / CORRETA": a alternativa C
-- (ruído de pistola / sinal de Traube) trocou "amplos, curtos" por
-- "amplos e curtos".
update public.question_options set texto = $q$Ruído de pistola (ou sinal de Traube) são batimentos intensos, amplos, curtos, melhor palpáveis comprimindo-se com uma mão o antebraço do paciente.$q$ where question_id = 'a6a79759-eabd-4087-a399-a4dfca61f11e' and letra = 'c';
