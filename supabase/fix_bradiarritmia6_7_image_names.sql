-- Corrige os nomes dos arquivos de imagem das questões 6 e 7 de Bradiarritmia:
-- de bradiarritmia-6.png / bradiarritmia-7.png para
-- bradiarritmia-66.png / bradiarritmia-77.png.
--
-- Renomeie os arquivos no bucket question-images antes de rodar este SQL.

update public.questions
set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/bradiarritmia-66.png'
where id = '3d941793-5ed4-457c-bf9d-144cdc294295';

update public.questions
set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/bradiarritmia-77.png'
where id = '17c9d7af-2edb-4fc1-9241-76700ba1fe2b';
