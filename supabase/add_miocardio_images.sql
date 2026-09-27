-- Linka as 2 imagens de Miocárdio às respectivas questões:
-- miocardio-2.png  -> Q2  (strain longitudinal global "apical sparing" + cintilografia com pirofosfato, imagem combinada — Figura 1 e Figura 2 do documento)
-- miocardio-30.png -> Q30 (ecocardiograma com Doppler colorido mostrando regurgitação mitral)
--
-- Suba os 2 arquivos no bucket question-images com os nomes exatos abaixo
-- antes de rodar este SQL. Rode depois de já ter rodado seed_miocardio.sql.

update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/miocardio-2.png' where id = '2864e426-efd9-4f25-8baf-96c0f40d24ca';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/miocardio-30.png' where id = '48cd5330-df7e-45b0-9794-08d96d9ffb1f';
