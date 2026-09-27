-- Correção de fidelidade textual: "Síncope e Anticoagulação" (cardiologia, banca TEC)
--
-- Objetivo: restaurar o texto LITERAL do documento-fonte
-- ("SINCOPE E ANTICOAGULAÇÃO.txt") nos campos "enunciado" (public.questions)
-- e "texto" das alternativas (public.question_options), onde o processo de
-- extração anterior parafraseou, resumiu ou (em alguns casos) reescreveu a
-- alternativa como uma negação/comentário em vez de manter a afirmação
-- original do documento.
--
-- NÃO altera: comentario, comentario_completo, tema, ano, instituicao,
-- imagem_url, correta. Apenas enunciado e texto de alternativas.
--
-- Casos que merecem atenção manual do usuário (não são apenas "typo"):
--  * Questões 16 e 18 (ids 8b7806f9-... e 0f0fd8da-...): o processo anterior
--    havia inserido no enunciado uma DESCRIÇÃO dos achados do ECG (Brugada
--    tipo 1 na Q16; BAV de alto grau na Q18) para compensar a ausência da
--    imagem do documento original (que só existe como figura, não como
--    texto). Isso não é uma cópia literal do enunciado do documento — o
--    enunciado original apenas referencia "o eletrocardiograma abaixo" sem
--    descrevê-lo em palavras. Este arquivo restaura o texto literal (sem a
--    descrição do ECG). Se preferir manter a versão didática compensando a
--    falta de imagem, não rode os dois UPDATEs de enunciado correspondentes
--    a essas duas questões (claramente identificados abaixo) — ou, melhor
--    ainda, adicione a imagem do ECG via campo imagem_url.
--  * Questão 11, alternativa A (id fc30afc1-...): o documento-fonte usa a
--    palavra "acessado" ("O risco de sangramento deve ser acessado pelo
--    escore HAS-BLED"), que é um erro de português evidente (queria dizer
--    "avaliado"). Corrigido aqui para "avaliado", sem alterar o sentido.
--
-- Rode este arquivo uma vez no SQL Editor do seu projeto Supabase, depois
-- de já ter rodado o seed_sincope_anticoagulacao.sql original.

-- ============================================================
-- ENUNCIADOS
-- ============================================================

-- Questão 4 (TEC 2021) — faltavam as expansões "(Razão Normatizada
-- Internacional)", "(inibidores diretos da trombina e fator anti-Xa)" e
-- "(DOACS)" presentes no documento, além da quebra em itens I/II/III.
update public.questions set enunciado = $q$Com relação ao uso de anticoagulantes e valvopatia, considere as seguintes assertivas:
I. Em pacientes portadores de prótese mitral mecânica associada à fibrilação atrial, a RNI (Razão Normatizada Internacional) deve ser mantida na faixa de 2,5 e 3,5.
II. Nos portadores de próteses mecânicas, o uso de anticoagulantes orais diretos (inibidores diretos da trombina e fator anti-Xa) pode ser tão seguro e eficaz quanto a varfarina.
III. Os anticoagulantes orais diretos (DOACS) podem ser usados como alternativa para pacientes portadores de estenose mitral grave e fibrilação atrial.
Quais as assertivas estão corretas?$q$
where id = '66c65188-cd32-4682-b604-3982b3716696';

-- Questão 5 (TEC 2015) — vinheta clínica resumida: faltavam as frases "Nega
-- uso regular de medicações." e "Ausculta pulmonar sem alteração
-- significativa.", e a frase do ECG havia sido reescrita.
update public.questions set enunciado = $q$MOS, 36 anos, masculino, passa em consulta ambulatorial queixando-se de palpitações taquicárdicas intermitentes há cerca de dez meses, associadas a leve desconforto torácico. Antecedentes pessoais reumatismo e sopro na infância. Nega uso regular de medicações. Ao exame físico ritmo cardíaco irregular, FC = 108 bpm, PA 118 × 72 mmHg, ausculta cardíaca com sopro diastólico em ruflar e estalido de abertura em foco mitral. Ausculta pulmonar sem alteração significativa. Realizado eletrocardiograma, o qual evidenciou ritmo de fibrilação atrial, com elevada resposta ventricular. Qual é a melhor estratégia antitrombótica para esse paciente?$q$
where id = '9291881c-b44c-46e9-b600-009a44c98e18';

-- Questão 7 (TEC 2014) — faltava "para tratamento de insuficiência
-- coronariana" após "revascularização miocárdica".
update public.questions set enunciado = $q$Paciente do sexo masculino, 67 anos, hipertenso e diabético. Submetido a cirurgia de revascularização miocárdica para tratamento de insuficiência coronariana, apresentou fibrilação atrial no pós-operatório imediato. Apesar das tentativas de reversão ao ritmo sinusal, a arritmia persistiu por mais de 48 horas. Neste caso, pode-se afirmar que a anticoagulação:$q$
where id = 'd0df1095-98e9-4217-9d84-0f2bfb2a9259';

-- Questão 9 (TEC 2020) — "em três segmentos coronarianos" era um resumo; o
-- documento lista os três segmentos especificamente.
update public.questions set enunciado = $q$Mulher, 67 anos, portadora de fibrilação atrial (FA) permanente, hipertensão arterial sistêmica e diabetes mellitus tipo 2, apresenta episódio de angina instável. Foi submetida à angioplastia coronária com implante de stent farmacológico em segmento médio da artéria coronária descendente anterior, segmento proximal da artéria coronária direita e segmento proximal da artéria circunflexa. Qual das alternativas configura a terapia antitrombótica mais adequada para esta paciente após os primeiros 30 dias?$q$
where id = 'd517afac-6bde-4293-9220-7d0c77292c90';

-- Questão 14 (TEC 2016) — vinheta resumida: faltavam "há 10 anos e que
-- ocorre", "ela" e "geralmente" (antes de "associado").
update public.questions set enunciado = $q$Paciente feminina, 23 anos, vai à consulta para avaliação de síncopes de repetição. Refere que o quadro se iniciou há 10 anos e que ocorre geralmente quando ela fica em pé por período prolongado em local quente, geralmente associado a mal-estar e náuseas; sem palpitações. Qual é a orientação MELHOR indicada para este caso?$q$
where id = '74762f5a-1126-46e8-aba7-67d0f9654781';

-- Questão 16 (TEC 2023) — o enunciado do documento apenas referencia a
-- imagem do ECG ("Abaixo está o eletrocardiograma..."), sem descrevê-la em
-- texto. O processo anterior havia inserido uma descrição dos achados
-- (Brugada tipo 1) que não está no enunciado original (está apenas na
-- explicação). Ver nota no cabeçalho deste arquivo antes de rodar.
update public.questions set enunciado = $q$Homem, 25 anos, com quadro de síncope em repouso, sem pródromos e com traumatismo craniano leve. Abaixo está o eletrocardiograma realizado após evento. Qual a conduta adequada?$q$
where id = '8b7806f9-1b48-472f-bca0-84d8d0e70972';

-- Questão 18 (TEC 2022) — faltava a frase sobre o uso de iECA e
-- atorvastatina, e a descrição do ECG (BAV de alto grau) havia sido
-- inserida no lugar da frase original, que só menciona que o ECG foi
-- obtido a 25 mm/s (achados descritos apenas na explicação). Ver nota no
-- cabeçalho deste arquivo antes de rodar.
update public.questions set enunciado = $q$Paciente do sexo masculino, de 70 anos de idade, hipertenso, dislipidêmico, com queixa de tontura e um evento de perda de consciência sem liberação de esfíncter ou convulsão há uma semana, em tratamento com inibidores da enzima conversora da angiotensina (iECA) e atorvastatina.
Ao exame: consciente, dispneico, sem alteração neurológica ou hemodinâmica. Eletrocardiograma de 12 derivações foi obtido com o papel na velocidade de 25 mm/seg. Qual a orientação mais adequada?$q$
where id = '0f0fd8da-2883-407f-8384-f670c1110a43';

-- Questão 21 (TEC 2019) — faltava todo o parágrafo introdutório sobre
-- interações medicamentosas antes da pergunta específica.
update public.questions set enunciado = $q$O uso concomitante de dois ou mais medicamentos pode acarretar potencialização do efeito terapêutico ou redução da eficácia, bem como causar reações adversas com distintos graus de gravidade. Torna-se, portanto, imperativo o conhecimento das interações farmacodinâmicas e farmacocinéticas entre os medicamentos prescritos. A respeito das interações entre medicamentos utilizados para o tratamento das doenças cardiovasculares, é INCORRETO afirmar:$q$
where id = '1a56c94b-f97a-47af-b428-43bfe65c448e';

-- ============================================================
-- ALTERNATIVAS
-- ============================================================

-- Questão 2 (TEC 2024) — faltava "(pausa sinusal e/ou bloqueio
-- atrioventricular)" nas alternativas A, B e C.
update public.question_options set texto = $q$Síncope recorrente, > 40 anos de idade e pausa sintomática > 3s (pausa sinusal e/ou bloqueio atrioventricular) induzida no teste de inclinação e o marcapasso deve ser unicameral em ambas as situações.$q$
where question_id = '90bc2bcb-bbbb-4a3d-a111-a62173ba4df3' and letra = 'a';

update public.question_options set texto = $q$Queda única, inexplicada, sem pródromos, > 40 anos de idade e manobra de massagem do seio carotídeo com resposta cardioinibidora (pausa > 3s, pausa sinusal e/ou bloqueio atrioventricular).$q$
where question_id = '90bc2bcb-bbbb-4a3d-a111-a62173ba4df3' and letra = 'b';

update public.question_options set texto = $q$Síncope recorrente, > 40 anos de idade e documentação de pausa sintomática espontânea > 3s (pausa sinusal e/ou bloqueio atrioventricular) ou pausa > 6s assintomática.$q$
where question_id = '90bc2bcb-bbbb-4a3d-a111-a62173ba4df3' and letra = 'c';

-- Questão 3 (TEC 2019) — faltava a expansão "(Razão Normatizada
-- Internacional)" nas alternativas C e D, e D estava resumida.
update public.question_options set texto = $q$O uso dos novos anticoagulantes orais por portadores de próteses mecânicas pode ser considerado em caso de dificuldade de controle da INR (Razão Normatizada Internacional) com o uso da varfarina.$q$
where question_id = 'e56a116c-43eb-4ef0-8a6c-83013af3b94c' and letra = 'c';

update public.question_options set texto = $q$A faixa de resultado que se deve manter a INR (Razão Normatizada Internacional) de paciente portador de prótese mecânica em posição mitral é entre 2,0-3,0.$q$
where question_id = 'e56a116c-43eb-4ef0-8a6c-83013af3b94c' and letra = 'd';

-- Questão 7 (TEC 2014) — alternativa A resumida ("risco de AVE" em vez de
-- "risco de acidente vascular encefálico (AVE)").
update public.question_options set texto = $q$Não deve ser iniciada, pois o risco de complicações hemorrágicas, nestes casos, é maior do que o risco de acidente vascular encefálico (AVE).$q$
where question_id = 'd0df1095-98e9-4217-9d84-0f2bfb2a9259' and letra = 'a';

-- Questão 9 (TEC 2020) — as 5 alternativas haviam sido capitalizadas e
-- ganho ponto final; no documento elas começam em minúscula e sem ponto
-- final (formato "A - ..." específico desta questão).
update public.question_options set texto = $q$anticoagulante oral direto + prasugrel$q$
where question_id = 'd517afac-6bde-4293-9220-7d0c77292c90' and letra = 'a';

update public.question_options set texto = $q$ácido acetilsalicílico (AAS) + ticagrelor$q$
where question_id = 'd517afac-6bde-4293-9220-7d0c77292c90' and letra = 'b';

update public.question_options set texto = $q$anticoagulante oral direto + clopidogrel$q$
where question_id = 'd517afac-6bde-4293-9220-7d0c77292c90' and letra = 'c';

update public.question_options set texto = $q$varfarina + AAS + clopidogrel$q$
where question_id = 'd517afac-6bde-4293-9220-7d0c77292c90' and letra = 'd';

update public.question_options set texto = $q$anticoagulante oral direto + AAS + clopidogrel$q$
where question_id = 'd517afac-6bde-4293-9220-7d0c77292c90' and letra = 'e';

-- Questão 11 (TEC 2022) — alternativa D estava resumida (faltava
-- "(reduzindo assim o risco hemorrágico)"); alternativa A tinha o erro de
-- português "acessado" no documento-fonte, corrigido aqui para "avaliado"
-- (ver nota no cabeçalho).
update public.question_options set texto = $q$Em fibrilação atrial, o escore CHA2DS2VASC deve ser utilizado. Em pacientes com eventos tromboembólicos sistêmicos ou próteses valvares mecânicas, a anticoagulação deve ser mantida independentemente de qualquer avaliação. O risco de sangramento deve ser avaliado pelo escore HAS-BLED.$q$
where question_id = 'fc30afc1-09eb-43d7-b60f-2eaf16360d8e' and letra = 'a';

update public.question_options set texto = $q$Flutter atrial. Pelo menor risco embólico, pode ser tratado com INR em faixa terapêutica de 1,5 a 2,0 (reduzindo assim o risco hemorrágico).$q$
where question_id = 'fc30afc1-09eb-43d7-b60f-2eaf16360d8e' and letra = 'd';

-- Questão 22 (TEC 2024) — alternativa E resumida (faltava "(não
-- inferior)").
update public.question_options set texto = $q$Em pacientes que têm indicação de anticoagulação e apresentam sangramento com uso de anticoagulantes orais, uma opção segura e igualmente eficaz (não inferior) é o uso de ácido acetilsalicílico.$q$
where question_id = 'cd10fb63-5b24-4c5c-8ffa-ef4ac596bc15' and letra = 'e';

-- Questão 24 (TEC 2023) — alternativa E usava a abreviação "TFG" em vez de
-- "taxa de filtração glomerular" por extenso, como no documento.
update public.question_options set texto = $q$Em paciente com disfunção renal grave (taxa de filtração glomerular < 15 mL/kg/min), não dialíticos, deve-se dar preferência a varfarina, em relação aos novos anticoagulantes orais.$q$
where question_id = '320b9972-74d5-4756-9adf-6aadac4b66e2' and letra = 'e';
