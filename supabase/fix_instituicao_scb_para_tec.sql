-- Corrige a instituição de todas as questões marcadas como "SBC" para "TEC".
-- Rode este arquivo uma vez no SQL Editor do seu projeto Supabase.

update public.questions set instituicao = 'TEC' where instituicao = 'SBC';
