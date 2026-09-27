-- Linka as 4 imagens de ECG de "Fibrilação e Flutter" às respectivas questões:
-- fibrilacao-4.png  -> Q4  (TEC 2018, 70 anos, FA de início súbito, ECG do caso)
-- fibrilacao-25.png -> Q25 (2025 SBC, valvoplastia mitral prévia, flutter atrial típico)
-- fibrilacao-27.png -> Q27 (2019 SBC, síncope + baixo débito, FA com via acessória)
-- fibrilacao-41.png -> Q41 (2015 SBC, 69 anos, taquiarritmia pós-IAM)
--
-- Suba os 4 arquivos no bucket question-images com os nomes exatos abaixo antes
-- de rodar este SQL. Rode depois de já ter rodado seed_fibrilacao_flutter.sql.

update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/fibrilacao-4.png' where id = '0e92749c-62c5-484f-9f10-332dc2fdcf7b';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/fibrilacao-25.png' where id = '8a73aa14-db87-4ce5-8a4a-fabd379a6a6f';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/fibrilacao-27.png' where id = '8bacc543-4fb7-4af7-8bdd-ec7d05bff98c';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/fibrilacao-41.png' where id = '191de5c4-a11a-468a-9caa-9037b6f3244f';
