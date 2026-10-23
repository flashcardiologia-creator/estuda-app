-- TEC 2015 questão 37 (FA paroxística sintomática — indicação de ablação, EXCETO): o gabarito oficial pós-recurso da SBC é A.
-- O banco (seed_fibrilacao_flutter.sql) marcava a alternativa C. Este script corrige a alternativa certa e reescreve o comentário.
begin;

update public.question_options
set correta = (lower(letra) = 'a')
where question_id = 'b6bb5826-2fa3-4e95-a8ef-959a0062f91b';

update public.questions
set comentario = $Q$A contraindicação ao uso crônico de anticoagulante não é indicação de ablação da FA, pois o procedimento não dispensa a anticoagulação definida pelo risco embólico — alternativa A.$Q$,
    comentario_completo = $Q$Indicações de ablação por cateter (isolamento das veias pulmonares) na FA paroxística sintomática:
• Refratariedade ou intolerância a pelo menos um antiarrítmico (classe I de indicação).
• Primeira opção de controle do ritmo em pacientes selecionados, sem doença estrutural ou com átrio esquerdo pouco aumentado (remodelamento ausente ou discreto) e em centros experientes.
• Preferência do paciente, após discussão dos riscos e benefícios.

A decisão de manter ou suspender anticoagulação depende do CHA2DS2-VASc e não do sucesso do procedimento. Por isso, a contraindicação ao anticoagulante não é motivo para ablação: a ablação exige anticoagulação antes e depois do procedimento.

Atualização: as diretrizes mais recentes tornaram a ablação uma opção de primeira linha em FA paroxística sintomática e reconhecem benefício também em pacientes com insuficiência cardíaca.

Por que as outras alternativas estão incorretas:
• B) Indicação clássica: refratariedade ou intolerância a antiarrítmico.
• C) Pode ser a primeira opção em pacientes selecionados com FA paroxística e coração estruturalmente normal.
• D) A preferência do paciente é aceita após discussão dos riscos e dos benefícios.
• E) Átrio esquerdo pouco remodelado é fator de bom prognóstico do procedimento e favorece a indicação.$Q$
where id = 'b6bb5826-2fa3-4e95-a8ef-959a0062f91b';

select letra, correta from public.question_options where question_id = 'b6bb5826-2fa3-4e95-a8ef-959a0062f91b' order by letra;

commit;
