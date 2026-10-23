-- Questão de Dislipidemia do TEC 2024 (#11): "A respeito das medicações utilizadas para controle do LDL-C,
-- assinale alternativa INCORRETA" (gabarito D).
-- 1) Corrige a alternativa D: no original ela diz "níveis ELEVADOS de creatinina quinase na maioria dos
--    usuários"; a importação tinha escrito "normais", o que deixava as cinco alternativas corretas e tornava
--    a questão a de mais erros do banco.
-- 2) Troca o comentário curto e o completo por um texto simples que explica por que a D é a incorreta.
-- Enunciado e gabarito não mudam. Rode no SQL Editor do Supabase; cada comando deve afetar exatamente 1 linha.

update question_options set
  texto = replace(texto, $Q$pode vir acompanhada de níveis normais de creatinina quinase na maioria dos usuários.$Q$, $Q$pode vir acompanhada de níveis elevados de creatinina quinase na maioria dos usuários.$Q$)
where letra = 'D'
  and starts_with(texto, 'As estatinas inibem a enzima HMG-CoA redutase')
  and question_id in (
    select id from questions
     where instituicao = 'TEC' and ano = 2024
       and starts_with(enunciado, 'A respeito das medicações utilizadas para controle do LDL-C')
  )
returning question_id, right(texto, 90) as final_da_alternativa_d;

update questions set
  comentario = $Q$A incorreta é a D. As estatinas realmente inibem a HMG-CoA redutase e bloqueiam a formação de mevalonato, mas o item erra no efeito colateral: a mialgia costuma vir com CK normal. A CK elevada (miopatia) é rara e a rabdomiólise é muito rara, então não acontecem "na maioria dos usuários". Ezetimiba (NPC1L1), inclisirana, inibidores da PCSK9 e colestiramina estão descritos corretamente — alternativa D.$Q$,
  comentario_completo = $Q$Por que a D é a incorreta: a primeira frase está certa, pois as estatinas inibem a HMG-CoA redutase, enzima que forma o mevalonato, etapa limitante da síntese hepática de colesterol. O erro está na segunda. A mialgia é o efeito adverso mais comum das estatinas, mas na maior parte das vezes a CK está normal. A elevação de CK (miopatia) é rara e a rabdomiólise é muito rara, de modo que a mialgia não vem "com CK elevada na maioria dos usuários" — alternativa D.

Por que as demais alternativas estão corretas (e não são a resposta):
• A) Ezetimiba: inibe a proteína NPC1L1 no enterócito, reduzindo a absorção intestinal de colesterol e de esteróis; reduz o LDL-C em cerca de 15% a 20% e soma-se ao efeito da estatina.
• B) Inclisirana: siRNA que bloqueia a tradução da PCSK9; reduz muito o LDL-C e tem efeito mais prolongado que os anticorpos anti-PCSK9 (aplicação a cada 6 meses depois das doses iniciais).
• C) Inibidores da PCSK9: indicados em risco cardiovascular elevado que, com estatina na maior dose tolerada, associada ou não à ezetimiba, não atingiu as metas de LDL-C ou de não HDL-C.
• E) Colestiramina: resina que se liga aos sais biliares no intestino e não é absorvida; por isso é considerada segura na gestação e na infância.$Q$
where instituicao = 'TEC' and ano = 2024
  and starts_with(enunciado, 'A respeito das medicações utilizadas para controle do LDL-C')
  and exists (select 1 from question_options o where o.question_id = questions.id and o.letra = 'D' and starts_with(o.texto, 'As estatinas inibem a enzima HMG-CoA redutase'))
returning id, left(enunciado, 70) as enunciado;
