-- Suporte a imagem nas questões + as 3 questões que ficaram de fora antes
-- por dependerem de diagrama (Pulsos 1 e 2, Ausculta 23).
--
-- PASSO 1 — rode este SQL no SQL Editor do Supabase.
--
-- PASSO 2 — crie o bucket de imagens (uma vez só):
--   No painel do Supabase, vá em Storage → New bucket
--   Nome: question-images
--   Marque "Public bucket" (ativado)
--   Clique em Create bucket
--
-- PASSO 3 — suba cada imagem para esse bucket com o NOME EXATO abaixo
-- (tem que ser .png — se sua imagem for .jpg, converta antes de subir):
--   pulsos-1.png       → diagrama da questão 1 de Pulsos (bulhas/desdobramento)
--   pulsos-2.png       → onda de pulso venoso da questão 2 de Pulsos
--   ausculta-23.png    → diagrama do sopro (A2/P2) da questão 23 de Ausculta
--
-- Depois de subir as 3 imagens com esses nomes exatos, elas já aparecem
-- nas questões automaticamente — não precisa copiar link nenhum.

alter table public.questions add column if not exists imagem_url text;

-- ============================================================
-- Perguntas com imagem
-- ============================================================

insert into public.questions (id, tema, ano, instituicao, enunciado, comentario, imagem_url) values
('68b5cb1c-87a8-4e6c-90c0-5f8244a2ef96', 'Pulsos', 2021, 'TEC', 'Sobre a ausculta das bulhas cardíacas, tendo o diagrama "NORMAL" como referência, qual a condição clínica representada no diagrama abaixo?', 'O diagrama mostra um desdobramento amplo e fixo de B2, lembrando o padrão de bloqueio de ramo direito, mas decorrente de estimulação artificial do ventrículo direito (eletrodo de marca-passo na ponta do VD), que atrasa a ativação e a contração desse ventrículo de forma análoga a um BRD. Interpretação baseada no gabarito; confira a imagem original ao revisar.', 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/pulsos-1.png'),
('713674bb-f3f5-4a26-8ec0-7f85bea156c2', 'Pulsos', 2015, 'TEC', 'Sobre a onda de pulso venoso abaixo, responda qual é a situação representada:', 'A curva mostra ondas "a" em canhão, irregulares e dissociadas da atividade ventricular — achado característico do bloqueio atrioventricular de terceiro grau (dissociação atrioventricular completa), em que o átrio contrai de forma independente do ventrículo, por vezes contra uma valva tricúspide fechada. Interpretação baseada no gabarito; confira a imagem original ao revisar.', 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/pulsos-2.png'),
('ac3c563d-24c5-4a15-8d6f-860fba211e98', 'Ausculta', 2018, 'TEC', 'Observe o diagrama desse sopro cardíaco (A2: componente aórtico de B2; P2: componente pulmonar de B2). A qual anomalia está associada?', 'O diagrama mostra desdobramento amplo de B2 com P2 muito atrasado, compatível com estenose pulmonar significativa (aqui, de valva bicúspide), que atrasa a ejeção do ventrículo direito e retarda o componente pulmonar da segunda bulha. Interpretação baseada no gabarito; confira a imagem original ao revisar.', 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/ausculta-23.png');

insert into public.question_options (id, question_id, letra, texto, correta) values
(gen_random_uuid(), '68b5cb1c-87a8-4e6c-90c0-5f8244a2ef96', 'a', 'Comunicação interatrial.', false),
(gen_random_uuid(), '68b5cb1c-87a8-4e6c-90c0-5f8244a2ef96', 'b', 'Estimulação artificial apical do ventrículo direito.', true),
(gen_random_uuid(), '68b5cb1c-87a8-4e6c-90c0-5f8244a2ef96', 'c', 'Estenose pulmonar.', false),
(gen_random_uuid(), '68b5cb1c-87a8-4e6c-90c0-5f8244a2ef96', 'd', 'Bloqueio completo do ramo direito.', false),
(gen_random_uuid(), '68b5cb1c-87a8-4e6c-90c0-5f8244a2ef96', 'e', 'Estenose mitral.', false),

(gen_random_uuid(), '713674bb-f3f5-4a26-8ec0-7f85bea156c2', 'a', 'Fibrilação atrial.', false),
(gen_random_uuid(), '713674bb-f3f5-4a26-8ec0-7f85bea156c2', 'b', 'Flutter atrial.', false),
(gen_random_uuid(), '713674bb-f3f5-4a26-8ec0-7f85bea156c2', 'c', 'Bloqueio atrioventricular de terceiro grau.', true),
(gen_random_uuid(), '713674bb-f3f5-4a26-8ec0-7f85bea156c2', 'd', 'Estenose aórtica.', false),
(gen_random_uuid(), '713674bb-f3f5-4a26-8ec0-7f85bea156c2', 'e', 'Insuficiência tricúspide.', false),

(gen_random_uuid(), 'ac3c563d-24c5-4a15-8d6f-860fba211e98', 'a', 'Estenose pulmonar bicúspide.', true),
(gen_random_uuid(), 'ac3c563d-24c5-4a15-8d6f-860fba211e98', 'b', 'Estenose aórtica bicúspide.', false),
(gen_random_uuid(), 'ac3c563d-24c5-4a15-8d6f-860fba211e98', 'c', 'Insuficiência mitral crônica e grave.', false),
(gen_random_uuid(), 'ac3c563d-24c5-4a15-8d6f-860fba211e98', 'd', 'Insuficiência tricúspide crônica e grave.', false),
(gen_random_uuid(), 'ac3c563d-24c5-4a15-8d6f-860fba211e98', 'e', 'Comunicação intraventricular (CIV) sem hipertensão pulmonar grave.', false);
