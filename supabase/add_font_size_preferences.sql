-- Persiste o tamanho de letra escolhido pelo usuário para Questões e Flashcards,
-- para sobreviver a logout/login. Também é reaproveitado em Desafios e Missão Diária.
alter table public.profiles
  add column if not exists question_font_size text not null default 'md';

alter table public.profiles
  add column if not exists flashcard_font_size text not null default 'md';
