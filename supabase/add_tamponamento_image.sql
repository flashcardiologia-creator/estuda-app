-- Adiciona a imagem do ECG na questão de tamponamento cardíaco (Pulsos, TEC 2018),
-- que já tinha sido inserida antes só com texto.
-- Rode depois de já ter rodado add_question_images.sql e de subir os arquivos
-- no bucket question-images (incluindo o novo pulsos-3.png).

update public.questions
set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/pulsos-3.png'
where id = '41319994-aef5-47ef-9846-8040b0c3e4fa';
