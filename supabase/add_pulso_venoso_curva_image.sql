-- Adiciona a imagem da curva do pulso venoso (a-c-x-v-y) na questão que já
-- existia só com texto ("Em relação ao pulso venoso, assinale a alternativa
-- correta", Pulsos, resposta E).
--
-- Rode DEPOIS de subir o arquivo pulsos-4.png no bucket question-images
-- (o antigo pulsos-4.png precisa ser renomeado para ausculta-23.png antes).

update public.questions
set imagem_url = 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/pulsos-4.png'
where id = 'd1e3f1e1-09b2-4683-8f63-699f3694b6b2';
