-- Linka as 10 imagens de ECG/Holter às questões de Bradiarritmia que
-- dependem delas. Suba os 10 arquivos no bucket question-images com os
-- nomes exatos abaixo (bradiarritmia-1.png, bradiarritmia-2.png, ...)
-- antes de rodar este SQL.
--
-- Rode depois de já ter rodado seed_bradiarritmia.sql.

update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/bradiarritmia-1.png' where id = 'd32573c2-25f1-4019-9dd1-bf1f71134c6c';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/bradiarritmia-2.png' where id = '6ca5766b-5efc-41c2-8879-c855d86e4b56';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/bradiarritmia-3.png' where id = '97163364-1910-4e79-87da-d8acfa65c544';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/bradiarritmia-5.png' where id = 'ad0e5096-5abc-4dfa-9ceb-430d33b7a1d2';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/bradiarritmia-6.png' where id = '3d941793-5ed4-457c-bf9d-144cdc294295';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/bradiarritmia-7.png' where id = '17c9d7af-2edb-4fc1-9241-76700ba1fe2b';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/bradiarritmia-8.png' where id = '0e516885-ee23-467d-bf0e-e039355a0f6d';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/bradiarritmia-12.png' where id = 'a649b4c4-b85e-4113-b299-f4d5672b1da7';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/bradiarritmia-14.png' where id = '19396bda-af5f-40e2-b96d-1ae8cb103a7e';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/bradiarritmia-15.png' where id = '866e9c66-9354-459b-b713-015423d14259';
