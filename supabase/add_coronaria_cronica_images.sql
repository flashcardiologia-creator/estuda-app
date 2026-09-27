-- Linka as 10 imagens de Coronária Crônica às respectivas questões:
-- coronaria-1.png  -> Q1  (ECG do caso de dor precordial atípica)
-- coronaria-4.png  -> Q4  (traçado do teste ergométrico, 2º estágio de Bruce)
-- coronaria-11.png -> Q11 (cintilografia com dipiridamol, homem 65 anos + BRE)
-- coronaria-12.png -> Q12 (cintilografia pré/pós-esforço, homem 44 anos diabético)
-- coronaria-15.png -> Q15 (cineangiocoronariografia, lesão em segmento médio da DA)
-- coronaria-17.png -> Q17 (Tabela de Diamond/Forrester)
-- coronaria-21.png -> Q21 (cintilografia, mulher 78 anos + BRE)
-- coronaria-26.png -> Q26 (colagem com as 5 imagens A-E de diferentes pacientes)
-- coronaria-29.png -> Q29 (coronariografia, ponte miocárdica)
-- coronaria-32.png -> Q32 (cintilografia, mulher 58 anos, angina microvascular)
--
-- Suba os 10 arquivos no bucket question-images com os nomes exatos abaixo
-- antes de rodar este SQL. Rode depois de já ter rodado seed_coronaria_cronica.sql.

update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/coronaria-1.png' where id = '4757ab76-85ff-4c5c-bd78-cf6b3625b1dd';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/coronaria-4.png' where id = 'f3ecdbde-c132-46d0-a781-753e4f6111a7';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/coronaria-11.png' where id = '274506fb-bde7-411d-b2b9-68c5910bc8a1';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/coronaria-12.png' where id = '9dc1b99f-daf5-4e77-9171-4ffa7a51ddcb';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/coronaria-15.png' where id = '4244989f-96c9-4205-bd51-959a533150fc';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/coronaria-17.png' where id = '310a148c-556b-4a4b-a3eb-a4340301863c';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/coronaria-21.png' where id = '4fe2c10c-0e18-4149-b36a-6fc9ae07d8fc';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/coronaria-26.png' where id = '0d201f5c-241a-46fa-aa1f-abb929e14340';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/coronaria-29.png' where id = '00b11b0f-677e-402d-be2b-8edf054f94ed';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/coronaria-32.png' where id = 'ea746dff-ddcb-4b71-a5f1-47a1d88aaf9e';
