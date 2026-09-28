-- Linka as 9 imagens extraídas do documento fonte às respectivas questões do
-- tema "Válvula" (numeração conforme aparece no documento fonte original):
-- valvula-1.png  -> Q1  (ecocardiograma com planimetria da valva mitral, MVA 0,9 cm²)
-- valvula-12.png -> Q12 (eletrocardiograma referenciado no caso)
-- valvula-18.png -> Q18 (tabela de pressões do cateterismo direito e esquerdo)
-- valvula-35.png -> Q35 (eletrocardiograma referenciado no caso)
-- valvula-44.png -> Q44 (ecocardiograma com Doppler, vena contracta e PHT)
-- valvula-56.png -> Q56 (ecocardiograma com Doppler colorido em 4 câmaras)
-- valvula-57.png -> Q57 (eletrocardiograma referenciado no caso)
-- valvula-65.png -> Q65 (ecocardiograma transesofágico com massa em átrio esquerdo)
-- valvula-68.png -> Q68 (tomografia de abdome + ecocardiograma + fotos de achados cutâneos)
--
-- Suba os 9 arquivos no bucket question-images com os nomes exatos acima
-- antes de rodar este SQL. Rode depois de já ter rodado seed_valvula.sql.
--
-- Nota: outras 4 imagens extraídas do documento (screenshots de texto que
-- duplicam dados já transcritos no enunciado das Q35/Q57, uma imagem de ECG
-- + raio-x sem correspondência clara de questão, e uma imagem ilustrativa de
-- vegetação próxima às Q61/Q62, que eram duplicadas e cujo texto não faz
-- referência a nenhuma imagem) foram deliberadamente omitidas por não
-- agregarem informação nova ou não terem associação inequívoca a uma questão.

update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/valvula-1.png' where id = '679117b8-aaa0-470a-a5f3-2e2cc3a879ed';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/valvula-12.png' where id = '1694f4a3-6348-4d75-a07e-45432646f8ab';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/valvula-18.png' where id = '8066a3fa-0369-4357-9692-e2799a7d88bb';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/valvula-35.png' where id = '9588947b-aaa6-443b-843d-aab5b2765735';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/valvula-44.png' where id = '57ce3cc7-7fb9-4917-9c5c-c3a0439a4d20';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/valvula-56.png' where id = '2ae1b140-d866-4df2-9108-4717caeda8d3';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/valvula-57.png' where id = 'b7c56d39-2332-40ce-9f2f-7102376f8c1a';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/valvula-65.png' where id = '09ce0ecc-ac14-47a6-afc7-9bb22c2a9dcf';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/valvula-68.png' where id = 'e3e04272-cac8-49b8-9351-0b75e1fc767e';
