-- Auditoria de fidelidade textual — tema "Dislipidemia" (cardiologia, banca TEC).
--
-- Objetivo: restaurar o texto LITERAL do documento-fonte (DISLIPIDEMIA.txt) nos
-- campos "enunciado" (public.questions) e "texto" (public.question_options),
-- onde o processo de extração original introduziu pequenos desvios em relação
-- ao documento. Os campos comentario/comentario_completo NÃO são tocados.
--
-- Resultado da auditoria completa das 16 questões do tema:
--   - Nenhuma alternativa foi encontrada reescrita como negação/comentário
--     (o problema mais grave visto em outros temas) — todas as alternativas
--     já eram cópias literais das opções do documento.
--   - Nenhum enunciado estava parafraseado/resumido — todos os desvios
--     encontrados foram erros de digitação/OCR do próprio documento fonte
--     que o processo anterior corrigiu de forma inconsistente (corrigiu em
--     alguns lugares, mas não em outros). Este arquivo completa essas
--     correções de forma consistente, sem alterar o conteúdo/sentido:
--     "clinica" -> "clínica"; "triglicerideos" -> "triglicerídeos";
--     "niveis" -> "níveis"; "lipoproteina" -> "lipoproteína";
--     "superficie" -> "superfície"; "proteina" -> "proteína";
--     "NPCl-Ll" (OCR de "NPC1-L1") -> "NPC1-L1";
--     "de baixa intensidade (LDL)" -> "de baixa densidade (LDL)" (o termo
--       correto/universal para LDL é "lipoproteína de baixa densidade";
--       "intensidade" é um erro de digitação evidente do documento fonte,
--       sem relação com a alternativa estar certa ou errada);
--   - Uma diferença de pontuação: a alternativa E da questão 14 (xantomas)
--     não tem ponto final no documento fonte ("Amiloidose"), mas o seed
--     tinha adicionado um ponto ("Amiloidose."); revertido para bater
--     literalmente com o documento.
--
-- Rode este arquivo depois de seed_dislipidemia.sql e seed_dislipidemia_q14.sql.

-- Questão 8 (uuid 102de5b4...) — TEC 2015, situação clínica p/ escore de cálcio
update public.questions set enunciado = $q$Em qual situação clínica a seguir o emprego do escore de cálcio está mais bem indicado?$q$
where id = '102de5b4-9825-46aa-afcf-38eed9d10cca';

-- Questão 9 (uuid 94c225de...) — TEC 2015, homem 70 anos diabético
update public.questions set enunciado = $q$Homem, 70 anos, vem ao seu consultório para um retorno de check-up. É diabético, assintomático do ponto de vista cardiovascular e não possui alterações ao exame físico. Traz entre os exames solicitados na primeira consulta os seguintes: HDL 45 mg/dL, LDL 108 mg/dL, triglicerídeos 330 mg/dL, colesterol total 219 mg/dL, hemoglobina glicada 6,6%, glicemia de jejum 120 mg/dL. Com relação ao tratamento da dislipidemia, é CORRETO afirmar:$q$
where id = '94c225de-5eca-4347-8fe4-53ec0f0e1afd';

update public.question_options set texto = $q$A associação de genfibrozila e sinvastatina é indicada em razão dos níveis altos de triglicerídeos e LDL.$q$
where question_id = '94c225de-5eca-4347-8fe4-53ec0f0e1afd' and letra = 'a';

update public.question_options set texto = $q$O tratamento desse paciente deve incluir estatina e niacina, visando à melhora dos níveis de LDL e HDL.$q$
where question_id = '94c225de-5eca-4347-8fe4-53ec0f0e1afd' and letra = 'd';

-- Questão 11 (uuid a8dcb430...) — TEC 2015, farmacologia dos hipolipemiantes
update public.question_options set texto = $q$As estatinas inibem a enzima HMG-CoA-redutase, levando com isso à redução na quantidade de receptores de lipoproteína de baixa densidade (LDL) na superfície dos hepatócitos.$q$
where question_id = 'a8dcb430-44ec-404e-8a9a-35203e3e9853' and letra = 'a';

update public.question_options set texto = $q$O ezetimibe age aumentando a excreção biliar de colesterol, levando ao aumento dos níveis de lipoproteína de alta densidade (HDL) como principal efeito terapêutico.$q$
where question_id = 'a8dcb430-44ec-404e-8a9a-35203e3e9853' and letra = 'e';

-- Questão 13 (uuid b1bb8d0e...) — TEC 2019, mecanismo de ação dos hipolipemiantes
update public.questions set enunciado = $q$O tratamento da dislipidemia é fundamental para o manejo do paciente com aterosclerose. Sobre o mecanismo de ação dos fármacos hipolipemiantes, considere as assertivas I a III e assinale a alternativa correta. I. As estatinas são inibidores competitivos da 3-hidroxi-3-metilglutaril coenzima A redutase, etapa limitante na biossíntese do colesterol. Além disso, essa classe de fármacos aumenta a síntese e a expressão do receptor de LDL na membrana celular. II. A ezetimiba atua especificamente sobre os receptores NPC1-L1 presentes na membrana apical do intestino delgado, inibindo a absorção intestinal de colesterol. III. Os inibidores da PCSK9 aumentam a densidade de receptores de LDL na membrana dos hepatócitos.$q$
where id = 'b1bb8d0e-0e70-4737-a8b7-dbb33d671815';

-- Questão 14 (uuid 4f5cd7dd...) — xantomas tendíneos (imagem)
update public.question_options set texto = $q$Amiloidose$q$
where question_id = '4f5cd7dd-91b0-4229-8e8c-8af7adff1948' and letra = 'e';

-- Questão 16 (uuid a6134d8c...) — sinais físicos da hipercolesterolemia familiar
update public.question_options set texto = $q$Xantomas tuberosos, lipemia retinalis e defeito da pró-proteína convertase subtilisina/kexina tipo 9.$q$
where question_id = 'a6134d8c-1815-42f5-96a1-58e050cc550d' and letra = 'c';

update public.question_options set texto = $q$Xantomas eruptivos e defeito da proteína adaptadora do receptor da LDL.$q$
where question_id = 'a6134d8c-1815-42f5-96a1-58e050cc550d' and letra = 'e';
