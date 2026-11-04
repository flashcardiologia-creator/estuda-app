-- Quem respondeu o quê no cadastro (prova, especialidade e instituição). Só leitura; rode no SQL Editor do Supabase.
-- "da_lista = false" são instituições digitadas à mão: as que mais se repetem valem entrar na lista (lib/data/cardioFormacao.js).
select coalesce(g.institution, '(não informou)') as instituicao,
       g.institution_listed                      as da_lista,
       count(*)                                  as pessoas,
       count(*) filter (where g.exam = 'TEC')    as tec,
       count(*) filter (where g.exam = 'R+')     as r_mais,
       count(*) filter (where g.exam = 'AMBOS')  as ambos
  from public.user_goals g
 group by 1, 2
 order by pessoas desc, instituicao
 limit 100;
