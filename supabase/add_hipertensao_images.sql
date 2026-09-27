-- Linka a imagem do diagrama do sistema renina-angiotensina-aldosterona à
-- questão 27 de Hipertensão (locais de ação de alisquireno/enalapril/losartana).
--
-- Suba o arquivo no bucket question-images com o nome exato abaixo antes
-- de rodar este SQL. Rode depois de já ter rodado seed_hipertensao.sql.

update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/hipertensao-27.png' where id = '4cb1ca0c-8691-4e52-aef8-97afb674dbbc';
