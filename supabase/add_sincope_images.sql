-- Linka as imagens de ECG às questões 16 (padrão de Brugada) e 18 (BAV de
-- alto grau) de Síncope e Anticoagulação. Suba os 2 arquivos no bucket
-- question-images com os nomes exatos abaixo antes de rodar este SQL.
--
-- Rode depois de já ter rodado seed_sincope_anticoagulacao.sql.

update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/sincope-16.png' where id = '8b7806f9-1b48-472f-bca0-84d8d0e70972';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/sincope-18.png' where id = '0f0fd8da-2883-407f-8384-f670c1110a43';
