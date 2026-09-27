-- Linka as 26 imagens de ECG de Taquiarritmia às respectivas questões
-- (numeração conforme aparece no documento fonte original).
--
-- Suba os 26 arquivos no bucket question-images com os nomes exatos abaixo
-- antes de rodar este SQL. Rode depois de já ter rodado seed_taquiarritmia.sql.
--
-- Nota: a questão sobre extrassístoles ventriculares idiopáticas (que também
-- fazia referência a uma imagem no documento) foi omitida do seed por não ter
-- alternativas completas no texto fonte — por isso não há uma linha de UPDATE
-- correspondente a ela aqui.

update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/taquiarritmia-3.png' where id = '41304e7d-35e4-4acc-9cb0-3bc81cb044df';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/taquiarritmia-4.png' where id = '2ba43467-2567-4cda-add5-8a6e5da887e0';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/taquiarritmia-5.png' where id = '7b766a6a-a647-425a-9c33-ff7a72f9cf68';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/taquiarritmia-12.png' where id = 'b6c8ffc6-078d-4419-8fff-5dfc1a89ee04';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/taquiarritmia-18.png' where id = '5abeef5b-ae95-45f1-b9d0-deff2d8baacf';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/taquiarritmia-19.png' where id = 'efe552b9-d384-4317-b970-1688cab672c5';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/taquiarritmia-20.png' where id = 'cc0aa165-f5e9-4936-9a78-0fd90afcc867';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/taquiarritmia-23.png' where id = '84b74e49-dfd9-4a33-b365-35b8473f3b3b';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/taquiarritmia-25.png' where id = '0db6fb3a-593f-4d62-8c7c-861883a6eb5b';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/taquiarritmia-26.png' where id = '135c3853-8f89-424d-98a0-d55ccc883f90';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/taquiarritmia-27.png' where id = '58ad1ce9-087f-4e43-967a-b7f78541c2a5';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/taquiarritmia-29.png' where id = '0771f98c-abf3-4912-9f54-d3b00935b99d';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/taquiarritmia-30.png' where id = '51beae04-abb7-4da0-bd10-893acda90a64';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/taquiarritmia-37.png' where id = '2d9c92c2-2f61-4f70-82e9-a9e26da19e84';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/taquiarritmia-38.png' where id = '4098bf4a-b620-412d-a0a5-a7742ed531f1';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/taquiarritmia-40.png' where id = 'e01ada26-76a1-4a58-938b-01e11cfb5e54';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/taquiarritmia-42.png' where id = 'a39138c4-a56a-4fb0-a121-fc604341bd76';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/taquiarritmia-43.png' where id = 'fab09740-8def-4910-b55f-620a00ccb631';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/taquiarritmia-46.png' where id = '5ae2029a-c0f7-4a8f-8cde-18d952d61d66';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/taquiarritmia-49.png' where id = '1e78551e-902d-4f7d-94ee-ef337ad1ba0e';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/taquiarritmia-50.png' where id = 'a77a382c-901c-48bc-8daf-df901dcc7046';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/taquiarritmia-51.png' where id = '8e5b0f4c-1108-42b6-be50-f50b03b61fc4';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/taquiarritmia-56.png' where id = '85f05fdb-852e-450a-9513-b20d2a500f34';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/taquiarritmia-59.png' where id = '9bbc58b3-a2ff-4054-9285-a27f727ca4bd';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/taquiarritmia-60.png' where id = 'd4e074c0-14e3-40df-9baa-8dedea41f7e4';
update public.questions set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/taquiarritmia-62.png' where id = '147da0f8-1518-444b-acb6-923759eac2a3';
