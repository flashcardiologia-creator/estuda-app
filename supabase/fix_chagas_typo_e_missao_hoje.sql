-- 1) Corrige typo de conteúdo em um flashcard de Chagas ("GRVAE" -> "GRAVE").
update public.flashcards
set resposta = 'VETORIAL (MAIS COMUM - 85%)
ORAL - RESTOS VETOR (INFESTAÇÃO MACIÇA E GRAVE)
VERTICAL (MATERNO FETAL)
ACIDENTAL (TRANSFUSÃO E TRANSPLANTE)'
where id = '7751aae5-242f-47f1-9a8f-54ef69ca6387';

-- 2) Remove o sorteio de hoje da missão diária da conta de teste: foi gerado
-- antes da reimportação dos flashcards de cardiologia, então referenciava
-- flashcards que já não existem (os 5 flashcards da missão de hoje sumiam,
-- deixando a missão com 5 itens em vez de 10). Ao apagar, a missão é
-- sorteada de novo, corretamente, na próxima vez que a conta abrir.
delete from public.daily_mission_picks
where mission_date = '2026-09-28'
  and user_id = 'f33f5466-3385-4c3b-8fb1-5ed6eb79aaa8';
