-- Corrige a missão diária que ficou "presa" porque o sorteio de hoje incluía
-- questões de temas que acabaram de ser apagados (Biologia/História/Matemática/
-- Português). Limpa o sorteio fixado para forçar um novo, já só com os temas
-- que restaram (Pulsos/Ausculta).

delete from public.daily_mission_picks
where mission_date = public.app_today();
