-- Corrige o last_mission_date da conta de teste, que ficou um dia à frente
-- (2026-09-27 em vez de 2026-09-26) porque a conclusão gravou usando a
-- regra antiga de virada (18h) — o servidor ainda não tinha os SQLs de
-- virada de meia-noite aplicados quando a missão foi concluída.
--
-- Rode isso DEPOIS de já ter rodado alter_virada_dia_meia_noite.sql e
-- fix_conclusao_apos_virada.sql.

update public.profiles
set last_mission_date = '2026-09-26'
where id = 'f33f5466-3385-4c3b-8fb1-5ed6eb79aaa8';
