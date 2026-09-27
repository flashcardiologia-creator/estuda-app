-- Novo tema: "Dislipidemia" (cardiologia), banca TEC.
-- Fonte: documento enviado pelo usuário (Google Docs), sem explicações prontas
-- no material original — os comentários (resumido e completo) foram escritos
-- com base no gabarito e nas diretrizes de dislipidemia/prevenção cardiovascular.
--
-- IMPORTANTE — questão omitida por depender de imagem:
--   Questão 14 (xantomas tendíneos) — será adicionada depois, junto com a imagem.
--
-- Rode este arquivo uma vez no SQL Editor do seu projeto Supabase.

insert into public.questions (id, tema, ano, instituicao, enunciado, comentario, comentario_completo) values

('a0260569-4174-4133-8cd1-a9eeea02e64b', 'Dislipidemia', 2022, 'TEC', 'Em relação ao escore de cálcio coronariano obtido pela tomografia computadorizada, assinale a alternativa INCORRETA:', 'O escore de cálcio é útil sim para reclassificar o risco cardiovascular — para cima ou para baixo —, especialmente em pacientes de risco intermediário; por isso essa afirmação está incorreta.', 'O escore de cálcio coronariano (Agatston) é uma ferramenta de reclassificação de risco: em indivíduos assintomáticos, principalmente os de risco intermediário pelo Escore de Risco Global, um valor alto reclassifica o paciente para um risco maior (justificando estatina), e um valor zero pode reclassificar para um risco menor (permitindo postergar o hipolipemiante).

Por que as outras alternativas estão corretas (não são a incorreta pedida):
• A) Aterosclerose subclínica detectada por imagem, sobretudo pelo escore de cálcio, de fato prediz desfechos cardiovasculares e ajuda a decidir a conduta terapêutica.
• B) Em adultos, o escore de cálcio de fato agrega valor prognóstico importante, particularmente para quem está classificado como risco intermediário.
• C) Escore zero, sem tabagismo, diabetes ou história familiar de doença coronariana precoce, de fato sugere bom prognóstico e permite postergar a estatina.
• E) Escore entre 1-99 Agatston e/ou percentil ≥75 de fato justifica considerar estatina, principalmente acima de 55 anos.'),

('52845c10-1422-4fcf-9b7f-4bf8c52aabfe', 'Dislipidemia', 2018, 'TEC', 'Os eventos coronarianos agudos são precipitados por alterações na placa de ateroma, seja por rotura ou erosão de placas vulneráveis. Algumas características fazem parte da composição histopatológica da placa vulnerável. Observe as características a seguir: I) Núcleo lipídico grande. II) Capa fibrosa fina. III) Diminuição da neovascularização. IV) Conteúdo de colágeno reduzido. V) Densidade das células musculares lisas aumentada. Dentre as características enumeradas de I a V, quais fazem parte da composição histopatológica da placa vulnerável?', 'A placa vulnerável tem núcleo lipídico grande, capa fibrosa fina e conteúdo de colágeno reduzido (I, II e IV) — ao contrário do que se poderia imaginar, ela tem MAIS neovascularização e MENOS células musculares lisas, não o oposto.', 'A placa aterosclerótica vulnerável (com maior risco de ruptura) é caracterizada por um núcleo lipídico necrótico grande (I), uma capa fibrosa fina que se rompe com facilidade (II) e um conteúdo de colágeno reduzido, que torna essa capa ainda mais frágil (IV) — por isso a combinação I, II e IV está correta.

Por que as outras características estão incorretas:
• III) Diminuição da neovascularização: na verdade ocorre o OPOSTO — a placa vulnerável tem AUMENTO da neovascularização (vasos frágeis que nutrem a placa em crescimento e podem sangrar, contribuindo para sua instabilidade).
• V) Densidade das células musculares lisas aumentada: também é o oposto — a placa vulnerável tem REDUÇÃO da densidade de células musculares lisas, que são justamente as responsáveis por produzir colágeno e manter a capa fibrosa espessa e estável.'),

('7be75487-6240-4ef4-9b31-cfca480643d3', 'Dislipidemia', 2018, 'TEC', 'Em relação à farmacologia dos hipolipemiantes orais, assinale a alternativa CORRETA:', 'Pacientes assintomáticos, estáveis e em uso crônico de estatina em dose estável não precisam de monitorização rotineira de CPK e transaminases na ausência de sintomas.', 'Não há necessidade de dosar rotineiramente CPK (creatinoquinase) ou transaminases em pacientes assintomáticos já em uso estável de estatina por longo prazo — esses exames são solicitados diante de sintomas (dor muscular, icterícia) ou antes de ajustes de dose, não como rotina periódica sem motivo clínico.

Por que as outras alternativas estão incorretas:
• A) Quem aumenta o risco de miopatia com estatinas são os medicamentos INIBIDORES do citocromo 3A4 (que elevam o nível sérico da estatina), e não os indutores (que na verdade reduziriam esse nível) — a alternativa troca indutor por inibidor.
• B) Macrolídeos e diltiazem SÃO inibidores do CYP3A4 e têm interação medicamentosa significativa com estatinas metabolizadas por essa via (como sinvastatina e atorvastatina), aumentando o risco de miopatia — o oposto do afirmado.
• D) O uso concomitante de outros hipolipemiantes (especialmente fibratos, sobretudo a genfibrozila) aumenta sim o risco de miopatia quando associados a estatinas — essa interação é clinicamente relevante e bem documentada.
• E) Existem evidências consistentes (incluindo estudos como o JUPITER) de um pequeno aumento do risco de diabetes mellito associado ao uso de estatinas, especialmente em doses mais altas.'),

('67306ef0-b573-446f-a0fd-0c78a5066b96', 'Dislipidemia', 2018, 'TEC', 'De acordo com Atualização da Diretriz de Prevenção Cardiovascular da Sociedade Brasileira de Cardiologia, qual das alternativas NÃO configura uma situação de alto risco cardiovascular?', 'Um escore de cálcio coronariano de apenas 50 U Agatston, isoladamente, não configura alto risco cardiovascular — o corte que costuma sinalizar risco mais alto é bem maior (geralmente acima de 100); as demais alternativas descrevem critérios já reconhecidos como de alto risco.', 'Um escore de cálcio de 50 U Agatston situa-se numa faixa baixa a intermediária, insuficiente isoladamente para classificar o paciente como alto risco cardiovascular — esse nível pode, no máximo, contribuir para uma reclassificação mais discreta, mas não define alto risco por si só.

Por que as outras alternativas configuram, sim, alto risco (não são a resposta pedida):
• A) Escore de risco global (ERG) maior que 10% em mulheres é critério reconhecido de alto risco.
• B) A presença de aneurisma de aorta abdominal já representa doença aterosclerótica estabelecida, o que classifica o paciente automaticamente como alto risco.
• C) Taxa de filtração glomerular menor que 60 mL/min (doença renal crônica) é critério consagrado de alto risco cardiovascular.
• E) LDL-colesterol igual ou maior que 190 mg/dL (compatível com hipercolesterolemia grave/familiar) já classifica o paciente como alto risco, independentemente de outros escores.'),

('12638d77-a371-406b-a495-20f9ae553b0a', 'Dislipidemia', 2014, 'TEC', 'Em relação ao escore de cálcio, assinale a alternativa ERRADA:', 'Um escore de cálcio zero NÃO afasta doença coronariana obstrutiva em pacientes SINTOMÁTICOS com dor torácica suspeita de origem isquêmica (pode haver placa não calcificada causando a obstrução) — por isso essa é a alternativa errada.', 'O escore de cálcio zero tem excelente valor preditivo negativo para eventos cardiovasculares em pacientes ASSINTOMÁTICOS, mas essa mesma lógica não se aplica da mesma forma a pacientes SINTOMÁTICOS com dor torácica suspeita de isquemia: nesse cenário, uma placa aterosclerótica ainda não calcificada (mais jovem, rica em lipídios) pode causar estenose significativa mesmo com escore de cálcio igual a zero — por isso a afirmação de que o escore zero "exclui" estenose significativa nesses pacientes está errada.

Por que as outras alternativas estão corretas (não são a errada pedida):
• A) O escore de cálcio de fato tem seu maior benefício na reclassificação de risco em pacientes assintomáticos de risco intermediário.
• B) Pacientes assintomáticos com escore de cálcio zero de fato têm baixo risco de eventos cardiovasculares no prazo intermediário.
• C) O cálcio coronariano de fato costuma se correlacionar diretamente com a carga aterosclerótica total do paciente.
• E) Sendo D a alternativa errada, "todas as alternativas estão corretas" também é necessariamente falsa — mas a resposta pedida e reconhecida pela banca é especificamente a D, que descreve o conceito de forma diretamente incorreta.'),

('79933397-e609-4299-a692-2d694974dd40', 'Dislipidemia', 2019, 'TEC', 'Dentre os diversos algoritmos existentes, a Sociedade Brasileira de Cardiologia, na última versão da Atualização da Diretriz Brasileira de Dislipidemias e Prevenção da Aterosclerose (2017), recomenda a utilização do Escore de Risco Global (ERG) para a estratificação de risco. Ele deve ser utilizado para avaliação inicial ou mesmo para pacientes em uso de estatinas previamente. Assinale a alternativa correta acerca do exposto.', 'Em prevenção primária, a presença de aterosclerose subclínica documentada (placa em carótidas, índice tornozelo-braquial menor que 0,9, escore de cálcio maior que 100 ou placas na angiotomografia de coronárias) já classifica o paciente como alto risco cardiovascular, independentemente do resultado do escore de risco global calculado.', 'A diretriz reconhece que a demonstração objetiva de aterosclerose subclínica — por ultrassonografia de carótidas com placa, índice tornozelo-braquial (ITB) menor que 0,9, escore de cálcio coronariano maior que 100 ou presença de placas na angiotomografia de coronárias — já é suficiente, por si só, para classificar o paciente em prevenção primária como de alto risco cardiovascular, elevando as metas terapêuticas de LDL.

Por que as outras alternativas estão incorretas:
• A) Indivíduos com doença aterosclerótica clínica estabelecida (coronária, cerebrovascular, vascular periférica ou obstrução ≥50% em qualquer território) já são classificados como MUITO alto risco pela simples presença da doença, e não apenas quando há evento clínico prévio documentado — a exigência de "eventos prévios documentados" torna a afirmação restritiva demais e incorreta.
• B) Para pacientes de muito alto risco, a meta de LDL-c é abaixo de 70 mg/dL, mas a redução percentual recomendada é de pelo menos 50% (não 30%) em relação ao valor basal.
• D) Para indivíduos de alto risco cardiovascular, as metas são LDL-c menor que 70 mg/dL e não-HDL-c menor que 100 mg/dL — os valores de <100 e <80 mg/dL citados na alternativa correspondem a outra categoria de risco, não à de alto risco.
• E) Os escores clínicos tradicionais (como Framingham) NÃO devem ser usados para estratificar pacientes com hipercolesterolemia familiar ou outras dislipidemias de base genética grave — esses pacientes já são considerados de alto/muito alto risco por definição, independentemente do escore calculado.'),

('5aac0efa-10e9-4790-bf9b-6d6e1b64fc43', 'Dislipidemia', 2015, 'TEC', 'Com relação aos efeitos das estatinas, assinale a alternativa CORRETA:', 'As estatinas têm efeitos pleiotrópicos: além de inibir a síntese de colesterol, também inibem a prenilação (translocação) de pequenas proteínas intracelulares envolvidas em vias inflamatórias e trombóticas.', 'Além do efeito hipolipemiante clássico (inibição da HMG-CoA redutase), as estatinas bloqueiam a via do mevalonato em uma etapa que também produz compostos necessários para a prenilação (uma modificação que ancora certas proteínas à membrana celular, permitindo sua "translocação"/ativação) de pequenas GTPases como Rho e Ras — proteínas centrais em vias de sinalização inflamatória e pró-trombótica. É esse mecanismo que explica boa parte dos chamados "efeitos pleiotrópicos" das estatinas, além da redução do LDL.

Por que as outras alternativas estão incorretas:
• A) As estatinas reduzem desfechos coronarianos e cerebrovasculares E também a mortalidade total, inclusive em estudos de prevenção primária — não é verdade que poupem apenas os desfechos e não a mortalidade.
• B) Não há evidência consistente de aumento da mortalidade por câncer associado ao uso de estatinas; ao contrário, o benefício cardiovascular líquido é claramente positivo.
• D) As estatinas reduzem o tromboembolismo tanto arterial quanto venoso (redução do risco de TEV foi demonstrada, por exemplo, no estudo JUPITER) — não é correto dizer que poupam apenas o venoso.
• E) Existe sim uma relação dose-resposta entre a magnitude da redução do LDL-C e o benefício clínico observado — quanto maior a redução de LDL, maior a redução de eventos, contrariando a ideia de que só os efeitos pleiotrópicos importariam.'),

('102de5b4-9825-46aa-afcf-38eed9d10cca', 'Dislipidemia', 2015, 'TEC', 'Em qual situação clinica a seguir o emprego do escore de cálcio está mais bem indicado?', 'O escore de cálcio tem seu melhor uso justamente para reclassificar pacientes ASSINTOMÁTICOS de risco intermediário, ajudando a decidir se devem ou não iniciar estatina.', 'A principal indicação do escore de cálcio coronariano é a reclassificação de risco em pacientes assintomáticos classificados inicialmente como risco intermediário pelos escores clínicos tradicionais — nesse grupo, o resultado (alto ou baixo/zero) muda de fato a conduta terapêutica quanto ao uso de estatina.

Por que as outras alternativas estão incorretas:
• A) e E) Pacientes com dor precordial ATÍPICA (sintomáticos) não são o cenário-alvo do escore de cálcio como ferramenta de estratificação de risco cardiovascular primário — a investigação de dor torácica sintomática segue outra linha de raciocínio diagnóstico (testes funcionais/anatômicos direcionados a isquemia).
• C) Pacientes assintomáticos já classificados como ALTO risco pelo Framingham já têm indicação de estatina independentemente do resultado do escore de cálcio — o exame agregaria pouco valor prático nessa situação, pois não mudaria a conduta.
• D) Pacientes com angina instável (um quadro agudo, mesmo que de baixo risco) não são candidatos ao escore de cálcio, que é uma ferramenta de estratificação em prevenção primária/crônica, não de investigação de síndrome coronariana aguda.'),

('94c225de-5eca-4347-8fe4-53ec0f0e1afd', 'Dislipidemia', 2015, 'TEC', 'Homem, 70 anos, vem ao seu consultório para um retorno de check-up. É diabético, assintomático do ponto de vista cardiovascular e não possui alterações ao exame físico. Traz entre os exames solicitados na primeira consulta os seguintes: HDL 45 mg/dL, LDL 108 mg/dL, triglicerideos 330 mg/dL, colesterol total 219 mg/dL, hemoglobina glicada 6,6%, glicemia de jejum 120 mg/dL. Com relação ao tratamento da dislipidemia, é CORRETO afirmar:', 'Paciente diabético com dislipidemia (LDL, triglicérides e colesterol total elevados) já tem indicação de associar estatina ao tratamento, além de manter as medidas de estilo de vida.', 'Diabetes mellito já classifica o paciente, por definição, em uma categoria de risco cardiovascular elevado (alto ou muito alto risco, a depender de outros fatores associados). Diante disso, mesmo com um LDL "apenas" moderadamente elevado (108 mg/dL), a indicação de iniciar estatina — associada à manutenção das medidas de estilo de vida — é a conduta correta neste momento, visando reduzir o risco cardiovascular a longo prazo.

Por que as outras alternativas estão incorretas:
• A) A associação de genfibrozila com sinvastatina é uma das combinações de MAIOR risco de miopatia/rabdomiólise entre hipolipemiantes, sendo evitada sempre que possível; caso seja necessário associar um fibrato à estatina, o fenofibrato é a opção mais segura.
• B) Idosos diabéticos com dislipidemia não devem ser tratados apenas com mudança de estilo de vida — a idade isolada não é motivo para reduzir a intensidade do tratamento hipolipemiante nesse contexto de alto risco.
• D) A niacina não é mais recomendada rotineiramente no tratamento da dislipidemia, por falta de benefício consistente em desfechos cardiovasculares nos grandes estudos e por seus efeitos adversos.
• E) Não há indicação de substituir a estatina pela ezetimiba como primeira linha nessa faixa etária — a estatina continua sendo o tratamento de escolha, com a ezetimiba reservada como terapia adicional quando a meta não é atingida.'),

('07c103f3-28c0-4c35-841d-7abf42e833ec', 'Dislipidemia', 2017, 'TEC', 'Nas afirmações abaixo a que NÃO devemos considerar no uso clínico do escore de cálcio (EC) é:', 'O escore de cálcio é indicado para pacientes ASSINTOMÁTICOS (não sintomáticos) como ferramenta de estratificação de risco — não é indicado para investigar dor torácica sintomática, nem usado rotineiramente para acompanhar a progressão da aterosclerose ao longo do tempo.', 'O uso clínico validado do escore de cálcio é a estratificação de risco em indivíduos ASSINTOMÁTICOS, tipicamente de risco intermediário — e não a avaliação de pacientes sintomáticos (que seguem outra investigação, voltada para isquemia) nem o acompanhamento seriado da progressão da aterosclerose, que não é uma indicação estabelecida do método.

Por que as outras alternativas estão corretas (não são a resposta pedida):
• B) Um escore de cálcio alto (maior que 100, ou percentil ≥75 para idade e sexo) é de fato um fator agravante para doença arterial coronariana e indica risco alto de eventos em dois a cinco anos.
• C) Um escore de cálcio igual a zero (CAC=0) de fato indica baixa probabilidade de doença arterial coronariana e de eventos cardiovasculares futuros.
• D) A quantificação do CAC pode, de fato, alterar a conduta clínica, principalmente em assintomáticos de risco intermediário e em alguns de baixo risco com forte história familiar.
• E) O CAC é, de fato, um preditor independente de eventos e agrega valor prognóstico além dos fatores de risco tradicionais, da PCR e da espessura médio-intimal carotídea.'),

('a8dcb430-44ec-404e-8a9a-35203e3e9853', 'Dislipidemia', 2015, 'TEC', 'Em relação à farmacologia dos hipolipemiantes, assinale a alternativa CORRETA:', 'Os óleos de peixe (ácidos graxos ômega-3) reduzem a síntese hepática de VLDL e a quantidade de ApoB associada a essa lipoproteína, sendo especialmente úteis no controle da hipertrigliceridemia.', 'Os ácidos graxos ômega-3 (óleos de peixe) atuam reduzindo a síntese hepática de VLDL (a lipoproteína rica em triglicérides) e, consequentemente, também reduzem a quantidade de Apo B carreada por essas partículas — esse é o principal mecanismo pelo qual essa classe de fármacos é útil no tratamento da hipertrigliceridemia.

Por que as outras alternativas estão incorretas:
• A) As estatinas inibem a HMG-CoA redutase, o que reduz o colesterol intracelular hepático e, como resposta compensatória, AUMENTA (e não reduz) a expressão de receptores de LDL na superfície dos hepatócitos, para captar mais LDL circulante.
• B) As estatinas REDUZEM os níveis de triglicérides (em menor magnitude do que reduzem o LDL), e não os aumentam.
• C) Uma elevação isolada de CK, sem sintomas musculares, não é por si só contraindicação absoluta para iniciar ou manter estatina — a conduta deve ser individualizada, considerando a magnitude da elevação e reavaliação clínica.
• E) O ezetimibe age inibindo a ABSORÇÃO intestinal de colesterol (via receptores NPC1-L1), não aumentando sua excreção biliar; e seu principal efeito terapêutico é a redução do LDL, não o aumento do HDL.'),

('c3d5c27e-ec1e-490d-a36c-18c8f9f265f0', 'Dislipidemia', 2014, 'TEC', 'Com relação ao tratamento não farmacológico das dislipidemias, assinale a alternativa CORRETA:', 'O tratamento não farmacológico da dislipidemia inclui reduzir o consumo de gorduras trans e saturadas, praticar exercícios físicos regularmente e preferir o consumo de gorduras mono e poli-insaturadas.', 'As medidas não farmacológicas centrais no manejo da dislipidemia são: reduzir o consumo de gorduras trans e saturadas (que elevam o LDL), manter atividade física regular e substituir parte da gordura da dieta por fontes mono e poli-insaturadas (azeite, oleaginosas, peixes), que têm efeito mais favorável sobre o perfil lipídico.

Por que as outras alternativas estão incorretas:
• B) O consumo regular de álcool — mesmo vinho tinto — não deve ser recomendado como medida terapêutica, especialmente na hipertrigliceridemia, condição que o álcool tende a PIORAR, não melhorar.
• C) A gordura trans deve ser REDUZIDA, nunca aumentada — a alternativa mistura uma medida correta (parar de fumar) com uma incorreta (aumentar gordura trans).
• D) O consumo de carboidratos simples deve ser REDUZIDO (não aumentado), especialmente por elevar triglicérides; apenas o aumento de fibras e gorduras boas está correto nessa alternativa.
• E) A gordura trans deve ser eliminada/reduzida, e não aumentada junto com o ômega-3 — a alternativa mistura uma recomendação certa (ômega-3, parar de fumar, exercícios) com uma claramente errada (mais gordura trans).'),

('b1bb8d0e-0e70-4737-a8b7-dbb33d671815', 'Dislipidemia', 2019, 'TEC', 'O tratamento da dislipidemia é fundamental para o manejo do paciente com aterosclerose. Sobre o mecanismo de ação dos fármacos hipolipemiantes, considere as assertivas I a III e assinale a alternativa correta. I. As estatinas são inibidores competitivos da 3-hidroxi-3-metilglutaril coenzima A redutase, etapa limitante na biossíntese do colesterol. Além disso, essa classe de fármacos aumenta a síntese e a expressão do receptor de LDL na membrana celular. II. A ezetimiba atua especificamente sobre os receptores NPCl-Ll presentes na membrana apical do intestino delgado, inibindo a absorção intestinal de colesterol. III. Os inibidores da PCSK9 aumentam a densidade de receptores de LDL na membrana dos hepatócitos.', 'As três afirmações estão corretas: as estatinas inibem a HMG-CoA redutase e aumentam os receptores de LDL; a ezetimiba bloqueia a absorção intestinal de colesterol via NPC1-L1; e os inibidores de PCSK9 aumentam a densidade de receptores de LDL nos hepatócitos ao impedir sua degradação.', 'I) Correta: as estatinas inibem competitivamente a HMG-CoA redutase (enzima limitante da síntese de colesterol) e, ao reduzir o colesterol intracelular, desencadeiam o aumento da síntese e expressão de receptores de LDL na membrana dos hepatócitos, elevando a captação de LDL circulante.
II) Correta: a ezetimiba atua especificamente sobre os transportadores NPC1-L1 na borda em escova (membrana apical) do intestino delgado, bloqueando a absorção de colesterol da dieta e biliar.
III) Correta: a proteína PCSK9 normalmente se liga ao receptor de LDL e promove sua degradação intracelular; ao inibir a PCSK9, esses fármacos impedem essa degradação, aumentando a densidade de receptores de LDL disponíveis na membrana dos hepatócitos e, assim, reduzindo o LDL circulante.

Como as três assertivas (I, II e III) estão corretas, a alternativa que afirma isso é a resposta certa — não havendo, portanto, alternativas incorretas a serem descartadas neste caso, já que a questão testa o conhecimento cumulativo dos três mecanismos.'),

('c9b52000-227f-4d20-bcc8-4da05115e47e', 'Dislipidemia', 2020, 'TEC', 'Assinale a alternativa correta em relação à ezetimiba:', 'A ezetimiba age inibindo a absorção intestinal de colesterol ao bloquear os receptores NPC1-L1 na borda em escova do intestino delgado, reduzindo assim o aporte de colesterol proveniente da dieta e da bile ao fígado.', 'A ezetimiba atua especificamente sobre o transportador NPC1-L1 (Niemann-Pick C1-Like 1), presente na membrana apical (borda em escova) dos enterócitos do intestino delgado, bloqueando a absorção do colesterol dietético e biliar — esse é seu mecanismo de ação central, reduzindo o LDL ao diminuir o aporte de colesterol para o fígado (o que secundariamente também aumenta a expressão de receptores hepáticos de LDL).

Por que as outras alternativas estão incorretas:
• A) A ezetimiba de fato interfere na expressão dos receptores de LDL — de forma indireta, ao reduzir o aporte intestinal de colesterol, ela estimula um aumento (não ausência de interferência) na expressão desses receptores no fígado.
• B) O uso de ezetimiba associada à estatina foi estudado especificamente em pacientes com estenose aórtica degenerativa (estudo SEAS) e trouxe redução de eventos cardiovasculares, ainda que sem impacto relevante na progressão da própria estenose valvar — não é correto dizer simplesmente que "não traz benefício".
• C) A posologia recomendada da ezetimiba é de 10 mg uma vez ao dia (dose única diária), não duas vezes ao dia.
• E) A ezetimiba não piora a esteatose hepática não alcoólica; ao contrário, há evidências de possível benefício sobre o fígado gorduroso ao reduzir o aporte de colesterol e triglicérides.'),

('a6134d8c-1815-42f5-96a1-58e050cc550d', 'Dislipidemia', 2013, 'TEC', 'Assinale a alternativa CORRETA em relação aos sinais físicos e defeitos que possam estar associados com a hipercolesterolemia familiar, uma das formas genéticas mais frequentes e graves das dislipidemias de base genética.', 'A hipercolesterolemia familiar clássica cursa com xantomas tendinosos (especialmente no tendão de Aquiles), xantelasmas palpebrais, arco corneal precoce e um defeito primário no receptor de LDL (ou em genes relacionados à sua via).', 'A hipercolesterolemia familiar (mais comumente por mutações no gene do receptor de LDL, mas também em ApoB ou PCSK9) se manifesta classicamente com xantomas TENDINOSOS — depósitos de colesterol nos tendões, com predileção pelo tendão de Aquiles e extensores dos dedos —, xantelasmas nas pálpebras e arco corneal em pacientes jovens; esses achados, somados a LDL muito elevado desde a infância/juventude, são fortemente sugestivos do diagnóstico.

Por que as outras alternativas estão incorretas:
• B) Xantomas ERUPTIVOS (não tendinosos) são o achado clássico da hipertrigliceridemia grave, não da hipercolesterolemia familiar isolada; e o defeito de Apo B mencionado (defeito familiar de Apo B-100) é uma causa possível de HF, mas a combinação de achados descrita na alternativa não corresponde ao quadro típico pedido.
• C) Xantomas TUBEROSOS e lipemia retinalis são achados mais associados a outras dislipidemias (como a disbetalipoproteinemia e a hipertrigliceridemia grave), não ao quadro clássico de HF por defeito do receptor de LDL.
• D) Xantoma planar, amígdalas proeminentes e alaranjadas e opacidade de córnea descrevem a doença de Tangier (deficiência de HDL por mutação no ABCA1), uma condição totalmente diferente da hipercolesterolemia familiar.
• E) Xantomas eruptivos e defeito da proteína adaptadora do receptor de LDL (LDLRAP1) descrevem a hipercolesterolemia autossômica recessiva, uma forma rara e distinta — os xantomas eruptivos, novamente, remetem à hipertrigliceridemia, não ao quadro mais típico e prevalente de HF descrito na questão.');

insert into public.question_options (id, question_id, letra, texto, correta) values
(gen_random_uuid(), 'a0260569-4174-4133-8cd1-a9eeea02e64b', 'a', 'Aterosclerose subclínica detectada por métodos de imagem, especialmente escore de cálcio coronário, prediz desfechos cardiovasculares e auxilia na decisão terapêutica.', false),
(gen_random_uuid(), 'a0260569-4174-4133-8cd1-a9eeea02e64b', 'b', 'Em adultos, a tomografia com escore de cálcio coronário pode adicionar importante valor prognóstico, particularmente para indivíduos considerados em risco intermediário.', false),
(gen_random_uuid(), 'a0260569-4174-4133-8cd1-a9eeea02e64b', 'c', 'Escore de cálcio zero e ausência de tabagismo, diabetes ou antecedentes familiares de doença coronariana prematura sugerem boa evolução livre de desfechos ateroscleróticos, permitindo postergar a prescrição de hipolipemiantes.', false),
(gen_random_uuid(), 'a0260569-4174-4133-8cd1-a9eeea02e64b', 'd', 'Em indivíduos sem sintomas, o escore de cálcio não é útil para reclassificar, para cima ou para baixo, a chance de eventos coronarianos.', true),
(gen_random_uuid(), 'a0260569-4174-4133-8cd1-a9eeea02e64b', 'e', 'Em caso de escore de cálcio 1-99 U Agatston e/ou percentil 75 ou superior, deve-se considerar uso de estatina, especialmente se idade maior que 55 anos.', false),

(gen_random_uuid(), '52845c10-1422-4fcf-9b7f-4bf8c52aabfe', 'a', 'I, II e III são verdadeiras.', false),
(gen_random_uuid(), '52845c10-1422-4fcf-9b7f-4bf8c52aabfe', 'b', 'I, II e IV são verdadeiras.', true),
(gen_random_uuid(), '52845c10-1422-4fcf-9b7f-4bf8c52aabfe', 'c', 'II, III e V são verdadeiras.', false),
(gen_random_uuid(), '52845c10-1422-4fcf-9b7f-4bf8c52aabfe', 'd', 'I, IV e V são verdadeiras.', false),
(gen_random_uuid(), '52845c10-1422-4fcf-9b7f-4bf8c52aabfe', 'e', 'III, IV e V são verdadeiras.', false),

(gen_random_uuid(), '7be75487-6240-4ef4-9b31-cfca480643d3', 'a', 'Medicamentos indutores do citocromo 3A4, quando usados em associação com as estatinas, aumentam o risco de miopatia.', false),
(gen_random_uuid(), '7be75487-6240-4ef4-9b31-cfca480643d3', 'b', 'Antibióticos macrolídeos e diltiazem não apresentam interação medicamentosa significativa com as estatinas.', false),
(gen_random_uuid(), '7be75487-6240-4ef4-9b31-cfca480643d3', 'c', 'Não há necessidade de dosagem rotineira de CPK e transaminases para pacientes assintomáticos já em uso de estatina por longo tempo e em doses estáveis.', true),
(gen_random_uuid(), '7be75487-6240-4ef4-9b31-cfca480643d3', 'd', 'O uso concomitante de outros medicamentos hipolipemiantes não influencia o risco de miopatia pela estatina.', false),
(gen_random_uuid(), '7be75487-6240-4ef4-9b31-cfca480643d3', 'e', 'Até o momento, não existem evidências que sustentem o risco aumentado de diabetes melito pelo uso de estatina.', false),

(gen_random_uuid(), '67306ef0-b573-446f-a0fd-0c78a5066b96', 'a', 'mulheres com escore de risco global > 10%', false),
(gen_random_uuid(), '67306ef0-b573-446f-a0fd-0c78a5066b96', 'b', 'presença de aneurisma da aorta abdominal', false),
(gen_random_uuid(), '67306ef0-b573-446f-a0fd-0c78a5066b96', 'c', 'pacientes com taxa de filtração glomerular menor do que 60 mL/min', false),
(gen_random_uuid(), '67306ef0-b573-446f-a0fd-0c78a5066b96', 'd', 'pacientes com escore de cálcio coronariano de 50 U Agatston', true),
(gen_random_uuid(), '67306ef0-b573-446f-a0fd-0c78a5066b96', 'e', 'pacientes com LDL colesterol igual ou maior do que 190 mg/dL', false),

(gen_random_uuid(), '12638d77-a371-406b-a495-20f9ae553b0a', 'a', 'O escore de cálcio tem maior benefício na reclassificação de risco em pacientes assintomáticos com risco intermediário de eventos cardiovasculares.', false),
(gen_random_uuid(), '12638d77-a371-406b-a495-20f9ae553b0a', 'b', 'Pacientes assintomáticos com escore de cálcio zero possuem baixo risco de eventos cardiovasculares em prazo intermediário.', false),
(gen_random_uuid(), '12638d77-a371-406b-a495-20f9ae553b0a', 'c', 'O cálcio na artéria coronariana está tipicamente presente em proporção direta à carga aterosclerótica total.', false),
(gen_random_uuid(), '12638d77-a371-406b-a495-20f9ae553b0a', 'd', 'O escore de cálcio zero exclui estenose coronariana significativa em pacientes sintomáticos com suspeita de dor torácica de etiologia isquêmica.', true),
(gen_random_uuid(), '12638d77-a371-406b-a495-20f9ae553b0a', 'e', 'Todas as alternativas estão corretas.', false),

(gen_random_uuid(), '79933397-e609-4299-a692-2d694974dd40', 'a', 'Indivíduos que apresentem doença aterosclerótica significativa (coronária, cerebrovascular, vascular periférica ou obstrução ≥ 50% em qualquer território arterial) são considerados de risco intermediário apenas na presença de eventos clínicos prévios documentados, como infarto do miocárdio.', false),
(gen_random_uuid(), '79933397-e609-4299-a692-2d694974dd40', 'b', 'Metas terapêuticas absolutas e redução porcentual do colesterol da lipoproteína de baixa densidade para pacientes de muito alto risco devem ser respectivamente: (1) meta terapêutica absoluta: < 70 mg/dL e (2) com redução percentual de 30%.', false),
(gen_random_uuid(), '79933397-e609-4299-a692-2d694974dd40', 'c', 'Em pacientes em prevenção primária, os portadores de aterosclerose na forma subclínica documentada por metodologia diagnóstica: (1) ultrassonografia de carótidas com presença de placa; (2) índice tornozelo-braquial (ITB) < 0,9; (3) escore de cálcio arterial coronariano (CAC) > 100 ou a presença de placas ateroscleróticas na angiotomografia (angio-CT) de coronárias são classificados como alto risco.', true),
(gen_random_uuid(), '79933397-e609-4299-a692-2d694974dd40', 'd', 'No caso de indivíduos classificados como alto risco cardiovascular, o LDL-c deve ser reduzido para < 100 mg/dL e o não HDL-c < 80 mg/dL.', false),
(gen_random_uuid(), '79933397-e609-4299-a692-2d694974dd40', 'e', 'Podem ser utilizados os escores clínicos de risco tradicionais (Framingham, dentre outros) para estratificação de risco dos pacientes portadores de hipercolesterolemia familiar ou de base genética.', false),

(gen_random_uuid(), '5aac0efa-10e9-4790-bf9b-6d6e1b64fc43', 'a', 'As estatinas reduzem desfechos coronarianos e cerebrovasculares, mas não a mortalidade total na prevenção primária.', false),
(gen_random_uuid(), '5aac0efa-10e9-4790-bf9b-6d6e1b64fc43', 'b', 'As estatinas reduzem desfechos cardiovasculares, mas aumentam a mortalidade por câncer.', false),
(gen_random_uuid(), '5aac0efa-10e9-4790-bf9b-6d6e1b64fc43', 'c', 'As estatinas inibem a síntese de colesterol, mas durante esse processo inibem a translocação de pequenas proteínas envolvidas na transcrição de genes relacionados com síntese de proteínas envolvidas na inflamação e na trombose.', true),
(gen_random_uuid(), '5aac0efa-10e9-4790-bf9b-6d6e1b64fc43', 'd', 'As estatinas diminuem o tromboembolismo arterial, mas não o venoso.', false),
(gen_random_uuid(), '5aac0efa-10e9-4790-bf9b-6d6e1b64fc43', 'e', 'As estatinas diminuem desfechos cardiovasculares e mortalidade, mas a magnitude da redução de LDL-C não influencia os resultados devido aos seus efeitos pleiotrópicos.', false),

(gen_random_uuid(), '102de5b4-9825-46aa-afcf-38eed9d10cca', 'a', 'Paciente do sexo feminino com dor precordial atípica.', false),
(gen_random_uuid(), '102de5b4-9825-46aa-afcf-38eed9d10cca', 'b', 'Paciente assintomático com risco intermediário (Framingham).', true),
(gen_random_uuid(), '102de5b4-9825-46aa-afcf-38eed9d10cca', 'c', 'Paciente assintomático com risco alto (Framingham).', false),
(gen_random_uuid(), '102de5b4-9825-46aa-afcf-38eed9d10cca', 'd', 'Paciente com angina instável de baixo risco.', false),
(gen_random_uuid(), '102de5b4-9825-46aa-afcf-38eed9d10cca', 'e', 'Paciente do sexo masculino com dor precordial atípica.', false),

(gen_random_uuid(), '94c225de-5eca-4347-8fe4-53ec0f0e1afd', 'a', 'A associação de genfibrozila e sinvastatina é indicada em razão dos níveis altos de triglicerideos e LDL.', false),
(gen_random_uuid(), '94c225de-5eca-4347-8fe4-53ec0f0e1afd', 'b', 'O tratamento da dislipidemia em idosos deve ter metas menos estritas, uma vez que essa população tem menor benefício no controle lipídico para a prevenção de doença cardiovascular. Assim, pode-se orientar apenas modificações do estilo de vida, além de ajustar o esquema hipoglicemiante.', false),
(gen_random_uuid(), '94c225de-5eca-4347-8fe4-53ec0f0e1afd', 'c', 'Faz-se necessária a adição de estatina para o controle da dislipidemia neste momento, além de modificação no estilo de vida.', true),
(gen_random_uuid(), '94c225de-5eca-4347-8fe4-53ec0f0e1afd', 'd', 'O tratamento desse paciente deve incluir estatina e niacina, visando à melhora dos niveis de LDL e HDL.', false),
(gen_random_uuid(), '94c225de-5eca-4347-8fe4-53ec0f0e1afd', 'e', 'A ezetimiba pode ser empregada neste paciente em vez da estatina, visto que este grupo de fármacos provoca mais efeitos adversos nesta faixa etária.', false),

(gen_random_uuid(), '07c103f3-28c0-4c35-841d-7abf42e833ec', 'a', 'A utilização do EC é recomendada em indivíduos sintomáticos ou para avaliação da progressão de aterosclerose.', true),
(gen_random_uuid(), '07c103f3-28c0-4c35-841d-7abf42e833ec', 'b', 'Valor de EC alto (> 100 ou > percentil 75 para a idade e sexo) significa fator agravante para DAC e risco alto de eventos clínicos em dois a cinco anos.', false),
(gen_random_uuid(), '07c103f3-28c0-4c35-841d-7abf42e833ec', 'c', 'EC negativo - Calcificação de Artérias Coronárias (CAC) = 0 - indica baixa probabilidade de Doença Arterial Coronária (DAC) e de eventos cardiovasculares futuros.', false),
(gen_random_uuid(), '07c103f3-28c0-4c35-841d-7abf42e833ec', 'd', 'A quantificação da CAC pode alterar a conduta clínica, principalmente em pacientes assintomáticos de risco intermediário e naqueles de baixo risco com antecedente familiar de DAC precoce.', false),
(gen_random_uuid(), '07c103f3-28c0-4c35-841d-7abf42e833ec', 'e', 'Medida da CAC é preditora independente de eventos e acrescenta valor prognóstico em relação aos fatores de risco tradicionais de Framingham e à Proteína C Reativa (PCR) e a espessura médio intimal.', false),

(gen_random_uuid(), 'a8dcb430-44ec-404e-8a9a-35203e3e9853', 'a', 'As estatinas inibem a enzima HMG-CoA-redutase, levando com isso à redução na quantidade de receptores de lipoproteina de baixa intensidade (LDL) na superficie dos hepatócitos.', false),
(gen_random_uuid(), 'a8dcb430-44ec-404e-8a9a-35203e3e9853', 'b', 'Ao mesmo tempo que reduzem o LDL as estatinas aumentam os níveis de triglicérides.', false),
(gen_random_uuid(), 'a8dcb430-44ec-404e-8a9a-35203e3e9853', 'c', 'A elevação de creatinoquinase (CK), mesmo sem queixas musculares, constitui contraindicação para o início da estatina.', false),
(gen_random_uuid(), 'a8dcb430-44ec-404e-8a9a-35203e3e9853', 'd', 'Os óleos de peixe diminuem a síntese de VLDL e reduzem a ApoB da VLDL.', true),
(gen_random_uuid(), 'a8dcb430-44ec-404e-8a9a-35203e3e9853', 'e', 'O ezetimibe age aumentando a excreção biliar de colesterol, levando ao aumento dos níveis de lipoproteina de alta densidade (HDL) como principal efeito terapêutico.', false),

(gen_random_uuid(), 'c3d5c27e-ec1e-490d-a36c-18c8f9f265f0', 'a', 'Redução do consumo de gorduras trans e saturadas, exercícios físicos regulares, e consumo preferencial de ácidos graxos mono e poli-insaturados.', true),
(gen_random_uuid(), 'c3d5c27e-ec1e-490d-a36c-18c8f9f265f0', 'b', 'Exercícios físicos regulares, consumo de fibras, redução de carboidratos simples e consumo regular de álcool, particularmente vinhos tintos (ricos em antioxidantes) no caso de hipertrigliceridemias.', false),
(gen_random_uuid(), 'c3d5c27e-ec1e-490d-a36c-18c8f9f265f0', 'c', 'Interrupção do tabagismo, aumento do consumo de gorduras monoinsaturada e de gorduras trans, redução do consumo de álcool.', false),
(gen_random_uuid(), 'c3d5c27e-ec1e-490d-a36c-18c8f9f265f0', 'd', 'Aumento de consumo de fibras e de gorduras poli-insaturadas e monoinsaturadas, e de carboidratos simples.', false),
(gen_random_uuid(), 'c3d5c27e-ec1e-490d-a36c-18c8f9f265f0', 'e', 'Aumento do consumo de ácidos graxos ômega-3 e de gordura trans, além da interrupção do fumo e exercícios regulares.', false),

(gen_random_uuid(), 'b1bb8d0e-0e70-4737-a8b7-dbb33d671815', 'a', 'I e III são corretas.', false),
(gen_random_uuid(), 'b1bb8d0e-0e70-4737-a8b7-dbb33d671815', 'b', 'II e III são corretas.', false),
(gen_random_uuid(), 'b1bb8d0e-0e70-4737-a8b7-dbb33d671815', 'c', 'Apenas II está correta.', false),
(gen_random_uuid(), 'b1bb8d0e-0e70-4737-a8b7-dbb33d671815', 'd', 'Apenas III está correta.', false),
(gen_random_uuid(), 'b1bb8d0e-0e70-4737-a8b7-dbb33d671815', 'e', 'I, II e III são corretas.', true),

(gen_random_uuid(), 'c9b52000-227f-4d20-bcc8-4da05115e47e', 'a', 'Não interfere na expressão dos receptores de LDL.', false),
(gen_random_uuid(), 'c9b52000-227f-4d20-bcc8-4da05115e47e', 'b', 'Não traz benefício para pacientes com estenose aórtica degenerativa.', false),
(gen_random_uuid(), 'c9b52000-227f-4d20-bcc8-4da05115e47e', 'c', 'Sua posologia recomendada é de um comprimido de 10 mg duas vezes ao dia.', false),
(gen_random_uuid(), 'c9b52000-227f-4d20-bcc8-4da05115e47e', 'd', 'Inibe a absorção de colesterol no intestino delgado, atuando nos receptores NPC1-L1 (Niemann-Pick C1-Like 1).', true),
(gen_random_uuid(), 'c9b52000-227f-4d20-bcc8-4da05115e47e', 'e', 'Pode piorar a esteatose hepática não alcoólica.', false),

(gen_random_uuid(), 'a6134d8c-1815-42f5-96a1-58e050cc550d', 'a', 'Xantomas tendinosos, xantelasmas, arco corneal e defeito do receptor de LDL.', true),
(gen_random_uuid(), 'a6134d8c-1815-42f5-96a1-58e050cc550d', 'b', 'Xantomas eruptivos, xantelasmas e defeito da Apo B.', false),
(gen_random_uuid(), 'a6134d8c-1815-42f5-96a1-58e050cc550d', 'c', 'Xantomas tuberosos, lipemia retinalis e defeito da pró-proteina convertase subtilisina/kexina tipo 9.', false),
(gen_random_uuid(), 'a6134d8c-1815-42f5-96a1-58e050cc550d', 'd', 'Xantoma planar, amígdalas proeminentes e alaranjadas e opacidade de córnea.', false),
(gen_random_uuid(), 'a6134d8c-1815-42f5-96a1-58e050cc550d', 'e', 'Xantomas eruptivos e defeito da proteina adaptadora do receptor da LDL.', false);
