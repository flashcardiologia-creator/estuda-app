-- Remove todas as questões (e dados relacionados) dos temas antigos que não
-- são mais usados no app: Biologia, História, Matemática, Português.
-- Mantém apenas Pulsos e Ausculta.
--
-- Apaga primeiro nas tabelas que referenciam questions.id, para não bater
-- em restrição de chave estrangeira, e só depois apaga as próprias questões.

begin;

delete from public.challenge_answers
where question_id in (
  select id from public.questions where tema in ('Biologia', 'História', 'Matemática', 'Português')
);

delete from public.challenge_questions
where question_id in (
  select id from public.questions where tema in ('Biologia', 'História', 'Matemática', 'Português')
);

delete from public.user_question_attempts
where question_id in (
  select id from public.questions where tema in ('Biologia', 'História', 'Matemática', 'Português')
);

delete from public.user_wrong_bank
where question_id in (
  select id from public.questions where tema in ('Biologia', 'História', 'Matemática', 'Português')
);

delete from public.user_favorites
where question_id in (
  select id from public.questions where tema in ('Biologia', 'História', 'Matemática', 'Português')
);

delete from public.question_options
where question_id in (
  select id from public.questions where tema in ('Biologia', 'História', 'Matemática', 'Português')
);

delete from public.questions
where tema in ('Biologia', 'História', 'Matemática', 'Português');

commit;
