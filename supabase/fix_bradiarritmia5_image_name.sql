-- Corrige o nome do arquivo da imagem da questão 5 de Bradiarritmia:
-- de bradiarritmia-5.png para bradiarritmia-55.png.
--
-- Renomeie o arquivo no bucket question-images antes de rodar este SQL.

update public.questions
set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/bradiarritmia-55.png'
where id = 'ad0e5096-5abc-4dfa-9ceb-430d33b7a1d2';
