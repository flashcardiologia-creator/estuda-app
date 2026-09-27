-- Adiciona a questão 14 de Dislipidemia (xantomas tendíneos), que tinha
-- ficado de fora do seed_dislipidemia.sql. Imagem enviada pelo usuário
-- (xantoma no tendão de Aquiles) — subir como "dislipidemia-14.png" no
-- bucket question-images.
--
-- Rode este arquivo depois do seed_dislipidemia.sql, e depois de subir a
-- imagem no bucket.

insert into public.questions (id, tema, ano, instituicao, enunciado, comentario, comentario_completo, imagem_url) values
('4f5cd7dd-91b0-4229-8e8c-8af7adff1948', 'Dislipidemia', 2015, 'TEC', 'Qual a etiologia mais provável para os achados do exame físico apresentado nas imagens?', 'Xantomas tendíneos — depósitos de colesterol nos tendões, principalmente no tendão de Aquiles e nos extensores dos dedos — são o achado clássico da hipercolesterolemia familiar.', 'Os xantomas tendíneos resultam do acúmulo de colesterol (derivado do LDL) dentro dos tendões ao longo de anos, por causa dos níveis de LDL extremamente elevados e presentes desde a infância na hipercolesterolemia familiar (defeito genético no receptor de LDL ou em genes relacionados). O tendão de Aquiles e os tendões extensores dos dedos são os locais mais característicos desse achado — como o mostrado na imagem, com aumento de volume visível na região do tendão de Aquiles.

Por que as outras alternativas estão incorretas:
• A) Lúpus eritematoso sistêmico com endocardite de Libman-Sacks: causa vegetações endocárdicas verrucosas (Libman-Sacks) e outras manifestações sistêmicas do LES, mas não xantomas tendíneos.
• B) Febre reumática: causa poliartrite migratória, cardite/valvulite, coreia de Sydenham e eritema marginado — não xantomas tendíneos.
• D) Endocardite infecciosa: causa nódulos de Osler, lesões de Janeway e hemorragias em estilhaço nas unhas — achados cutâneos completamente diferentes dos xantomas tendíneos.
• E) Amiloidose: pode causar púrpura periorbital e macroglossia como achados característicos, não sendo os xantomas tendíneos sua manifestação clássica.', 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/dislipidemia-14.png')

on conflict (id) do nothing;

insert into public.question_options (id, question_id, letra, texto, correta) values
(gen_random_uuid(), '4f5cd7dd-91b0-4229-8e8c-8af7adff1948', 'a', 'Lúpus eritematoso sistêmico com endocardite de Libman-Sacks.', false),
(gen_random_uuid(), '4f5cd7dd-91b0-4229-8e8c-8af7adff1948', 'b', 'Febre reumática.', false),
(gen_random_uuid(), '4f5cd7dd-91b0-4229-8e8c-8af7adff1948', 'c', 'Hipercolesterolemia familiar.', true),
(gen_random_uuid(), '4f5cd7dd-91b0-4229-8e8c-8af7adff1948', 'd', 'Endocardite infecciosa.', false),
(gen_random_uuid(), '4f5cd7dd-91b0-4229-8e8c-8af7adff1948', 'e', 'Amiloidose.', false);
