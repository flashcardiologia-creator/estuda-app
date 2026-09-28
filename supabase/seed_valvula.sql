-- Novo tema: "Válvula" (valvopatias, endocardite infecciosa, febre reumática),
-- banca TEC — 80 questões distintas (81 questões numeradas na fonte, mas as
-- Questões 61 e 62 são idênticas em enunciado e alternativas; a fonte traz
-- gabaritos conflitantes entre elas [61: A / 62: B] — mantivemos apenas a
-- Questão 61, cujo gabarito (A) é o correto pelos critérios de Duke
-- modificados (hemocultura/sorologia positiva para Coxiella burnetii é
-- critério MAIOR; fenômenos imunológicos são critério MENOR).
--
-- ENUNCIADO E ALTERNATIVAS são cópia literal do documento fonte, exceto por
-- correções de erros de digitação/OCR evidentes do próprio documento (sem
-- alterar conteúdo/sentido): "dipneia"->"dispneia" (Q8); "completa­ mente"
-- (hífen invisível de quebra de linha) ->"completamente" (Q14);
-- "coexistence"->"coexistência" (Q21-D); "hemodínâmico"->"hemodinâmico"
-- (Q30-C); "martelo d' água"->"martelo d'água" (Q33-B); "Eletrocardiograma
-- transtorácico"->"Ecocardiograma transtorácico" no enunciado da Q57 (o
-- restante da frase descreve claramente parâmetros ecocardiográficos —
-- átrio esquerdo, septo, fração de ejeção, valva aórtica —, não
-- eletrocardiográficos); "insulina NPH 10 Ul"->"insulina NPH 10 UI" (Q57);
-- espaços/caracteres invisíveis (​) removidos das Questões 3, 5, 6, 16, 21,
-- 22, 34, 39 e 40, que não alteram o texto visível. Na Questão 77, a linha
-- de anotação de transcrição "Aqui está o texto da questão presente na
-- imagem:" foi removida do enunciado por não fazer parte do texto da
-- própria questão. Na Questão 57, a frase "Eletrocardiograma a seguir." foi
-- restaurada no enunciado (estava ausente da exportação em texto porque, no
-- documento original, essa parte do caso vinha embutida como imagem/print,
-- junto com o próprio ECG referenciado).
--
-- IMPORTANTE — as imagens de 9 questões já foram extraídas do documento
-- fonte (.docx) e serão linkadas em um arquivo separado (add_valvula_images.sql):
-- Questões 1, 12, 18, 35, 44, 56, 57, 65 e 68. Os comentários já descrevem em
-- texto os achados relevantes apresentados no enunciado, então as questões
-- continuam respondíveis e didáticas mesmo antes de a imagem ser linkada.
--
-- Rode este arquivo uma vez no SQL Editor do seu projeto Supabase.

insert into public.questions (id, tema, ano, instituicao, enunciado, comentario, comentario_completo) values

('679117b8-aaa0-470a-a5f3-2e2cc3a879ed', 'Válvula', 2020, 'TEC', 'Jovem com queixa de fadiga e dispneia. Ao exame, apresenta bom estado geral e pulsos normais. Ausculta: primeira bulha hiperfonética, sopro diastólico em ruflar em foco mitral com reforço pré-sistólico.
Com relação a esta valvopatia, assinale a correta:', 'O quadro descreve estenose mitral (B1 hiperfonética, ruflar diastólico com reforço pré-sistólico). A valvuloplastia mitral por cateter-balão é o tratamento de escolha quando há escore ecocardiográfico favorável (baixo Wilkins-Block) e ausência de trombo em átrio esquerdo — alternativa E.', 'O achado de B1 hiperfonética associada a sopro diastólico em ruflar com reforço pré-sistólico é clássico de estenose mitral (reumática, na grande maioria dos casos) em ritmo sinusal. Para estenose mitral sintomática (ou mesmo assintomática grave com fatores de risco), a valvuloplastia mitral por cateter-balão é o tratamento de escolha, desde que a anatomia valvar seja favorável (escore ecocardiográfico de Wilkins-Block baixo) e não haja trombo em átrio esquerdo ao ecocardiograma transesofágico — corresponde à alternativa E.

Por que as outras alternativas estão incorretas:
• A) Os estágios de classificação das valvopatias vão de A (risco) a D (sintomático grave); o caso descrito, com sintomas (fadiga/dispneia), corresponde a um estágio sintomático (D), não C (assintomático grave).
• B) A área valvar > 1,5 cm² com gradiente médio baixo caracteriza estenose mitral LEVE/discreta, não moderada.
• C) Os anticoagulantes orais diretos (DOACs) NÃO são indicados na estenose mitral reumática com fibrilação atrial — nesse cenário, a varfarina continua sendo o anticoagulante de escolha.
• D) Betabloqueadores e bloqueadores de canais de cálcio (não di-hidropiridínicos) são úteis na estenose mitral, pois reduzem a frequência cardíaca e aumentam o tempo de enchimento diastólico — não são contraindicados.'),

('5fe10bec-0ab3-49e6-810e-546c2026ec55', 'Válvula', 2020, 'TEC', 'Em relação à insuficiência mitral (IM), qual a alternativa INCORRETA?', 'É INCORRETO afirmar que a fibrilação atrial na IM primária "não é considerada indicação para intervenção cirúrgica" — pelo contrário, FA de início recente é um dos fatores complicadores que motivam a indicação cirúrgica (alternativa A).', 'A fibrilação atrial de início recente (< 1 ano) é reconhecida como um fator complicador na insuficiência mitral primária, devendo motivar discussão sobre intervenção — portanto a afirmativa A, que diz que o desenvolvimento de FA "não é considerado indicação para intervenção cirúrgica", está INCORRETA e é o gabarito da questão.

Por que as outras alternativas estão corretas (não são o gabarito):
• B) FEVE ≤ 60%, DSVE ≥ 40 mm, PSAP ≥ 50 mmHg e FA de início recente são, de fato, os fatores complicadores clássicos da IM primária.
• C) O MitraClip® é uma opção transcateter para pacientes sintomáticos (CF > III) com alto risco cirúrgico ou contraindicação à cirurgia.
• D) Cirurgia é recomendada em pacientes assintomáticos com IM primária grave e disfunção sistólica do VE (FE 30-60%) com DSVE ≥ 40 mm.
• E) Sintomas ou deterioração progressiva da função/dimensões do VE são indicação clássica de tratamento cirúrgico na IM primária.'),

('f7f1e4b6-794e-4f23-8c84-e57084a7f603', 'Válvula', 2021, 'TEC', 'Mulher, 39 anos, referindo dispneia progressiva há 15 dias, associada a ortopneia, dispneia paroxística noturna e edema em membros inferiores. Portadora de cardiopatia reumática desde os 17 anos de idade, faz uso regular de penicilina benzatina. Ao exame: Ictus cordis desviado para a esquerda e para baixo. Ritmo cardíaco regular. Sopro holossistólico em foco mitral com irradiação para a axila esquerda e região dorsal. Eletrocardiograma com ritmo sinusal e sobrecarga atrial esquerda. Ecocardiograma mostra: Diâmetro sistólico final do ventrículo esquerdo = 42 mm. Fração de ejeção = 57%. Átrio esquerdo com volume aumentado (50 mL/m²). Valva mitral com aspecto reumático e abertura preservada. Fração regurgitante = 60%. Volume regurgitante = 68 mL/batimento. Orifício efetivo regurgitante = 0,45 cm². Pressão sistólica na artéria pulmonar = 60 mmHg. Sobre este caso, considere as assertivas:
I. Trata-se de uma insuficiência mitral grave com indicação de cirurgia.
II. O uso de inibidores da enzima conversora da angiotensina retardará a necessidade de cirurgia.
III. Seu prognóstico será melhor se submetida à cirurgia quando o diâmetro sistólico final do ventrículo esquerdo for maior de 45 mm.
IV. São considerados fatores complicadores a fração de ejeção do ventrículo esquerdo ≤ 60%, diâmetro sistólico do ventrículo esquerdo (DSVE ≥ 40 mm), pressão sistólica pulmonar ≥ 50 mmHg ou ≥ 60 mmHg ao exercício.
Assinale a alternativa correta:', 'A fração/volume regurgitante e o orifício efetivo regurgitante indicam IM grave (assertiva I correta) e há fatores complicadores presentes — FE 57% (≤60%), DSVE 42mm (≥40mm) e PSAP 60mmHg (≥50mmHg) — que reforçam a indicação cirúrgica (assertiva IV correta) → alternativa C.', 'Os critérios ecocardiográficos de gravidade da IM (fração regurgitante 60%, volume regurgitante 68 mL, orifício efetivo regurgitante 0,45 cm²) confirmam insuficiência mitral GRAVE (assertiva I correta). Além disso, a paciente já apresenta fatores complicadores — FEVE 57% (≤60%), DSVE 42 mm (≥40mm) e PSAP 60 mmHg (≥50mmHg) —, exatamente os critérios listados na assertiva IV (correta). Assim, a alternativa correta é a C (I e IV).

Por que as outras assertivas estão incorretas:
• II) Não há evidência de que IECA retarde a necessidade de cirurgia na insuficiência mitral primária/orgânica (diferente da IM funcional/secundária, onde otimização clínica tem papel maior).
• III) O prognóstico pós-operatório é PIOR, não melhor, quando a cirurgia é realizada com DSVE já acima de 45 mm — a indicação deve ocorrer antes que esse limiar seja atingido.'),

('12cd189c-909a-4678-802a-616e2b872209', 'Válvula', 2020, 'TEC', 'Homem, 66 anos, assintomático. Exame físico: sopro mesossistólico e estalido também sistólico. Eletrocardiograma: ritmo sinusal e sobrecarga atrial esquerda. Ecocardiografia: deslocamento do cúspide posterior da valva mitral em mais de 2 mm acima do plano do anel no eixo longitudinal, fração de ejeção do ventrículo esquerdo de 61% (Simpson), fração regurgitante ≥ 50%, vena contracta ≥ 0,7 cm, área efetiva do orifício regurgitante ≥ 0,40 cm2, diâmetro sistólico do ventrículo esquerdo de 38 mm, pressão sistólica de artéria pulmonar de 45 mmHg. Assinale a alternativa correta:', 'Trata-se de prolapso de valva mitral (deslocamento >2mm do folheto posterior) com insuficiência mitral grave por critérios ecocardiográficos (fração regurgitante ≥50%, vena contracta ≥0,7cm, OER ≥0,40cm²) e anatomia favorável a plastia (prolapso isolado de folheto) — indicação de plastia cirúrgica se anatomia favorável (alternativa C).', 'O caso descreve um prolapso da cúspide posterior da valva mitral (deslocamento sistólico >2 mm acima do plano do anel) com critérios ecocardiográficos de insuficiência mitral GRAVE (fração regurgitante ≥50%, vena contracta ≥0,7 cm, área efetiva do orifício regurgitante ≥0,40 cm²). Mesmo assintomático, a presença de doença valvar grave em paciente com anatomia favorável à reparação (prolapso posterior isolado, tipicamente P2) indica a plastia mitral cirúrgica como conduta mais adequada, preferencialmente à troca valvar — alternativa C.

Por que as outras alternativas estão incorretas:
• A) A duração e as características do sopro TÊM, sim, relação com a gravidade da IM; além disso, a conduta preferencial na anatomia favorável é a plastia, não a troca valvar.
• B) O risco de morte súbita no prolapso valvar mitral está mais associado a arritmias VENTRICULARES (não supraventriculares) em subgrupos de risco.
• D) Não há dados no caso que caracterizem IM funcional (secundária a disfunção/dilatação do VE); trata-se de IM primária por prolapso, com anatomia favorável à plastia — a troca valvar imediata não é a conduta preferencial.
• E) A gravidade descrita já configura IM importante/grave com indicação de intervenção, não uma conduta apenas expectante com AAS.'),

('cf28fa6f-0665-4744-84c3-56ff64a9780e', 'Válvula', 2021, 'TEC', 'Analise as situações clínicas abaixo e identifique aquelas que correspondem a indicações apropriadas para realização de valvoplastia mitral percutânea com cateter balão na estenose mitral:
* I. Paciente de 70 anos com estenose mitral degenerativa, Classe Funcional da New York Heart Association (CF-NYHA) III, área valvar de 1,0 cm², fibrilação atrial (FA) de início recente e pressão sistólica da artéria pulmonar (PSAP) = 70 mmHg.
* II. Paciente gestante, CF-NYHA III, área valvar de 0,8 cm², escore de Wilkins de 9 (calcificação = 1 e subvalvar = 2) e PSAP = 60 mmHg em repouso.
* III. Paciente de 40 anos, com estenose mitral reumática, FA de início recente, CF-NYHA I, área valvar de 1,0 cm², escore de Wilkins de 8, PSAP = 40 mmHg no repouso e 70 mmHg durante exercício.
* IV. Paciente de 70 anos com estenose mitral reumática, CF-NYHA III, área valvar de 1,2 cm², escore de Wilkins de 8, PSAP = 50 mmHg em repouso, além de estenose aórtica, com gradiente máximo de 30 mmHg e médio de 15 mmHg.
* V. Paciente de 35 anos, com estenose mitral reumática, CF-NYHA II, área valvar de 0,9 cm², escore de Wilkins de 7, PSAP = 50 mmHg no repouso. Acidente vascular cerebral há 30 dias, com trombo no apêndice atrial esquerdo ao ecocardiograma transesofágico.
Assinale a alternativa correta:', 'A valvuloplastia por balão exige etiologia REUMÁTICA (não degenerativa — exclui I), anatomia favorável e ausência de trombo (exclui V, que tem trombo em AE); é indicada em sintomáticos com anatomia favorável (II, III) e mesmo em assintomáticos com PSAP elevada ao exercício (III) ou outra valvopatia leve concomitante que não requeira cirurgia (IV) → alternativa D (II, III e IV).', 'A valvuloplastia mitral por cateter-balão (VMCB) é indicada na estenose mitral REUMÁTICA com anatomia valvar favorável (escore de Wilkins baixo), na ausência de trombo em átrio esquerdo e de insuficiência mitral associada relevante:
- II) Gestante sintomática (CF III), com anatomia aceitável (Wilkins 9) — a VMCB é a opção preferencial na gestação para evitar cirurgia com circulação extracorpórea.
- III) Mesmo assintomática (CF I), a PSAP que sobe a 70 mmHg ao exercício é um fator complicador que justifica intervenção percutânea com boa anatomia.
- IV) Paciente sintomático com anatomia favorável; a estenose aórtica associada é leve (gradientes baixos), não contraindicando o procedimento mitral.
Portanto, II, III e IV são apropriadas — alternativa D.

Por que I e V estão incorretas:
• I) A etiologia é DEGENERATIVA (calcificação), não reumática — a VMCB não é eficaz nem indicada nesse contexto, pois o mecanismo de estenose não é a fusão comissural.
• V) A presença de trombo no apêndice atrial esquerdo é contraindicação formal à VMCB (risco de embolização durante o procedimento).'),

('63333bb0-8a32-4ad7-a6aa-d68ed2248072', 'Válvula', 2022, 'TEC', 'Qual alternativa NÃO apresenta complicador da insuficiência mitral primária?', 'Episódios de taquicardia supraventricular paroxística NÃO fazem parte da lista clássica de fatores complicadores da IM primária (que inclui FEVE, DSVE, PSAP, volume de AE e FA de início recente) — alternativa D.', 'Os fatores complicadores classicamente reconhecidos na insuficiência mitral primária são: queda/baixa FEVE (≤60%), remodelamento do VE (DSVE ≥40mm), hipertensão pulmonar (PSAP ≥50mmHg em repouso ou ≥60mmHg ao esforço), dilatação atrial esquerda (volume ≥60mL/m²) e fibrilação atrial de início recente. Taquicardia supraventricular paroxística não consta nesses critérios — alternativa D é a resposta (a que NÃO é complicador).

Por que as outras alternativas são, de fato, complicadores (não são o gabarito):
• A) Queda da FEVE é um complicador clássico.
• B) Remodelamento com DSVE ≥40mm é complicador clássico.
• C) PSAP ≥50mmHg (repouso) ou ≥60mmHg (esforço) é complicador clássico.
• E) Volume de AE ≥60mL/m² é complicador clássico.'),

('ea3a361e-e050-442c-8cd9-178b986257a6', 'Válvula', 2019, 'TEC', 'Homem, 37 anos, comparece à consulta ambulatorial devido a quadro de palpitações taquicárdicas esporádicas, de curta duração (10 min), cerca de 6-7 vezes ao dia, há nove dias. Negava dispneia, síncope e outros sintomas. Em uso de sertralina 25 mg, devido à ansiedade. Ao exame: frequência cardíaca (FC) = 76 bpm, pressão arterial (PA) 120 x 70 mmHg, Sat 02 99%, tempo de enchimento capilar 2 seg. Ausculta cardíaca revelava sopro mesotelessistólico regurgitativo, mais audível em foco mitral, com irradiação para linha axilar média e para focos da base, com primeira bulha normofonética. Sem alterações no restante do exame físico. Realizou eletrocardiograma, com ritmo sinusal e radiografia de tórax sem alterações. Ecocardiograma transtorácico evidenciava átrio esquerdo 56 mm, diâmetro sistólico de ventrículo esquerdo 35 mm, fração de ejeção 62%, pressão sistólica da artéria pulmonar 43 mmHg, válvula mitral com prolapso de P2 e rotura de cordas tendíneas, com presença de insuficiência mitral importante, sem outras alterações. Holter 24h com 2% de extrassístoles ventriculares e três episódios de fibrilação atrial paroxística, maior com 6 min de duração. Em relação ao caso descrito, assinale a alternativa correta:', 'Apesar de "assintomático" para dispneia/síncope, o paciente tem FA paroxística de início recente (fator complicador) e átrio esquerdo muito dilatado (56mm), configurando IM importante com indicação de intervenção valvar — alternativa D.', 'A fibrilação atrial paroxística de início recente, mesmo quando o paciente refere apenas palpitações (sem dispneia franca), é reconhecida como um fator complicador na insuficiência mitral primária importante e, por si só, já indica discussão de intervenção valvar no Heart Team — alternativa D.

Por que as outras alternativas estão incorretas:
• A) A propedêutica é perfeitamente condizente com o achado ecocardiográfico (prolapso com rotura de cordoalha causando IM importante); não é necessário outro exame para "validar" o achado.
• B) A rotura de cordas tendíneas NÃO contraindica a plástica mitral — pelo contrário, é um achado frequentemente tratável com bons resultados cirúrgicos (uso de neocordas, ressecção quadrangular etc.).
• C) A fração de ejeção pode, sim, estar relativamente preservada/mascarada em IM primária (não superestimada às custas de disfunção oculta) — mas o ponto central da indicação aqui é a própria FA de início recente, não uma reinterpretação da FE.
• E) A conduta expectante é inadequada diante de fator complicador presente (FA de início recente) associado a IM já classificada como importante.'),

('08b6f911-a194-4875-8a29-1948934889bf', 'Válvula', 2022, 'TEC', 'Paciente de 45 anos de idade, com quadro de palpitação e dispneia aos esforços há 6 meses, atualmente em Classe Funcional II da New York Heart Association (CF-NYHA). Exame físico: click mesossistólico seguido de sopro mesotelessistólico em foco mitral, com irradiação para axila. Ecocardiograma: Ventrículo Esquerdo (VE) com fração de ejeção de 55% (método Simpson), diâmetros diastólico e sistólico finais de 58 mm e 42 mm, respectivamente. Volume atrial esquerdo = 51 mL/m². Valva mitral com sinais de degeneração mixomatosa e prolapso do segmento P2 do folheto posterior, com refluxo importante. Pressão da artéria pulmonar estimada em 38 mmHg em repouso. Risco cirúrgico da Society of Thoracic Surgeons (STS-score) = 2,7% para mortalidade.
Diante desses dados, assinale a alternativa correta.', 'IM primária grave (refluxo importante por prolapso mixomatoso de P2) associada a sintomas (dispneia/palpitação, CF II) já é, por si só, indicação de reparo cirúrgico, independente de outros complicadores — alternativa A.', 'A presença de sintomas (dispneia e palpitações em CF-NYHA II) em um paciente com insuficiência mitral primária grave (degeneração mixomatosa com prolapso de P2 e refluxo importante) já constitui indicação de intervenção cirúrgica por si só — o reparo valvar (plastia) é a opção preferencial nesse cenário de prolapso posterior isolado, com baixo risco cirúrgico (STS 2,7%) e boa anatomia — alternativa A.

Por que as outras alternativas estão incorretas:
• B) A FEVE de 55% ainda está dentro da faixa normal-limítrofe (não é o único complicador relevante); o ponto central da indicação aqui são os SINTOMAS associados à IM grave, não apenas a queda de FE.
• C) Não há indicação de teste ergométrico como pré-requisito — o paciente já é sintomático e tem IM grave, com indicação cirúrgica já estabelecida.
• D) O ecocardiograma de estresse é reservado a pacientes ASSINTOMÁTICOS para avaliar reserva/PSAP ao esforço; aqui o paciente já é sintomático.
• E) A intervenção transcateter com clipagem (MitraClip) é reservada a pacientes de alto risco cirúrgico ou contraindicação à cirurgia — não é o caso aqui (STS baixo, anatomia favorável à plastia cirúrgica).'),

('3a4b0f8b-5201-4f36-b669-01efb82ff674', 'Válvula', 2022, 'TEC', 'Paciente do sexo feminino, de 53 anos de idade, em Classe Funcional II da New York Heart Association (CF-NYHA), sem queixas no momento. Exame físico: pressão arterial = 126x70 mmHg; FC = 64 bpm; ausculta pulmonar sem alterações; ausculta cardíaca com ritmo cardíaco regular, B1 hiperfonética, sopro regurgitativo mitral 2+/6+, ruflar diastólico 2+/6+, com estalido de abertura e reforço pré-sistólico. Ecocardiograma transtorácico: seio aórtico = 29 mm; átrio esquerdo = 58 mm; septo interventricular = 9 mm; parede posterior do VE = 9 mm; diâmetro diastólico do VE = 51 mm, diâmetro sistólico do VE = 31 mm; fração de ejeção = 69%. Valva mitral apresenta fusão comissural, espessamento de cúspides e redução da abertura valvar, gradiente diastólico máximo átrio esquerdo-ventrículo esquerdo (AE-VE) estimado em 14 mmHg e médio em 7 mmHg. Área valvar estimada em 1,1 cm², pela planimetria e PHT. O estudo Doppler e mapeamento com fluxo em cores demonstraram insuficiência de grau discreto, escore ecocardiográfico de Wilkins-Block: 8 (espessamento: 3, calcificação: 2, mobilidade: 2, aparelho subvalvar: 1). Pressão sistólica em artéria pulmonar estimada em 33 mmHg.
Qual é a melhor conduta nesse momento para o caso descrito?', 'Estenose mitral reumática (fusão comissural), área valvar 1,1cm² (importante), sintomática (CF II), com anatomia favorável (Wilkins 8), sem trombo, insuficiência mitral apenas discreta associada — indicação de valvoplastia mitral por cateter-balão — alternativa A.', 'A paciente apresenta estenose mitral reumática (fusão comissural típica) com área valvar de 1,1 cm² (estenose importante), sintomática (CF-NYHA II), com escore de Wilkins-Block favorável (8) e insuficiência mitral associada apenas discreta (não é contraindicação). Diante desse perfil, a valvuloplastia mitral por cateter-balão é a conduta de escolha — alternativa A.

Por que as outras alternativas estão incorretas:
• B e C) A cirurgia (plastia ou troca) é reservada para quando a VMCB não é possível (anatomia desfavorável, trombo em AE, IM associada relevante) — não é o caso aqui.
• D e E) A paciente já é sintomática (CF II) com estenose importante e anatomia favorável — o tratamento clínico isolado (com ou sem anticoagulação) não trata a causa mecânica da obstrução e adia desnecessariamente uma intervenção já indicada.'),

('a02b9037-c897-4cf7-be57-fbd0f5e83e15', 'Válvula', 2019, 'TEC', 'Sobre o tratamento da estenose mitral, assinale a alternativa correta:', 'A valvuloplastia mitral por cateter-balão é o tratamento de escolha na etiologia reumática quando há sintomas e escore ecocardiográfico (Wilkins e Block) favorável, isto é, ≤ 8 — alternativa A.', 'Na estenose mitral de etiologia reumática, sintomática, com escore ecocardiográfico de Wilkins e Block ≤ 8 (anatomia favorável), a valvuloplastia mitral por cateter-balão é o tratamento de escolha — alternativa A.

Por que as outras alternativas estão incorretas:
• B) A insuficiência mitral moderada associada é, sim, um fator relevante que pode contraindicar (ou ao menos reduzir a eficácia) do tratamento percutâneo, ao contrário do afirmado.
• C) Na estenose mitral DEGENERATIVA calcificada, a valvuloplastia por balão NÃO é indicada — o mecanismo obstrutivo não é fusão comissural, e o resultado do balão é ruim/ineficaz.
• D) A hipertensão arterial pulmonar não é uma contraindicação; é, na verdade, um fator que reforça a indicação de intervenção (seja percutânea, seja cirúrgica).
• E) Betabloqueadores NÃO são contraindicados na estenose mitral — pelo contrário, são úteis por reduzirem a FC e aumentarem o tempo de enchimento diastólico transmitral.'),

('06df03d7-e596-453e-838c-f60cbd4bc75a', 'Válvula', 2022, 'TEC', 'No exame físico de pacientes com estenose mitral importante, pode(m) ser encontrado(s), EXCETO:', 'Na estenose mitral importante, B1 e B2 são tipicamente HIPERFONÉTICAS (não hipofonéticas), refletindo o fechamento valvar mitral abrupto e a hipertensão pulmonar associada — alternativa B é o achado que NÃO ocorre.', 'Na estenose mitral, a B1 costuma estar hiperfonética (fechamento súbito de folhetos ainda móveis, sob pressão elevada do AE) e a B2 pode se tornar hiperfonética por hipertensão pulmonar associada — portanto, "B1 e B2 hipofonéticas" NÃO é um achado esperado, sendo a resposta desta questão (o achado que não ocorre) — alternativa B.

Por que as outras alternativas são achados esperados (não são o gabarito):
• A) O estalido de abertura precoce reflete abertura ainda relativamente móvel dos folhetos, sob alta pressão atrial esquerda.
• C) O sopro diastólico em ruflar com reforço pré-sistólico (em ritmo sinusal) é o achado clássico da estenose mitral.
• D) Sinais de congestão pulmonar (dispneia, estertores) ocorrem pela hipertensão venocapilar pulmonar.
• E) Sinais de insuficiência cardíaca direita ocorrem em fases avançadas, por hipertensão pulmonar e sobrecarga de VD.'),

('1694f4a3-6348-4d75-a07e-45432646f8ab', 'Válvula', 2023, 'TEC', 'Mulher de 22 anos, com história de febre reumática na infância, está em acompanhamento devido à fadiga e dispneia progressiva aos esforços. Ao exame físico em uma primeira avaliação, realizada há 1 mês, a paciente encontrava-se em ritmo cardíaco regular, com B1 hiperfonética, estalido de abertura da valva mitral e ruflar diastólico +2/+4, com reforço pré-sistólico e turgência jugular patológica. Na consulta atual, a paciente queixa-se de palpitações e piora da dispneia. Eletrocardiograma abaixo. Diante da instalação da arritmia atual e dos sintomas, qual achado deve ter desaparecido do exame físico?', 'O reforço pré-sistólico do sopro da estenose mitral depende da contração atrial (onda "a" do enchimento ventricular) — com a instalação de fibrilação atrial (perda da sístole atrial efetiva), esse reforço desaparece — alternativa A.', 'O reforço pré-sistólico do ruflar diastólico da estenose mitral é gerado pelo fluxo transmitral impulsionado pela contração atrial (sístole atrial). Diante de palpitações e piora clínica sugerindo instalação de fibrilação atrial (perda da contração atrial coordenada), esse componente pré-sistólico do sopro desaparece — alternativa A.

Por que as outras alternativas estão incorretas:
• B) O estalido de abertura persiste na FA, pois depende da mobilidade dos folhetos mitrais fusionados, não do ritmo atrial.
• C) O ruflar diastólico (componente de enchimento passivo) permanece presente na FA, apenas perde o reforço pré-sistólico.
• D) A hiperfonese de B1 depende da posição/mobilidade dos folhetos no momento do fechamento, não é dependente da contração atrial em si.
• E) A turgência jugular reflete a hipertensão venosa sistêmica/pulmonar associada e não desaparece com a FA.'),

('d53bdf84-af08-4c9e-ad56-7da761d90789', 'Válvula', 2021, 'TEC', 'Mulher, 42 anos, apresenta-se com quadro de dispneia aos esforços há 2 anos, atualmente limitada para esforços habituais, apesar do uso de furosemida 40 mg/dia. Antecedentes de hipertensão arterial e tabagismo. Pressão arterial = 108 x 64 mmHg. Frequência cardíaca = 84 bpm. Ritmo irregular. Sopro diastólico em ruflar ++/6+ em foco mitral. Ausculta pulmonar sem anormalidades. Discreto edema bilateral e simétrico de membros inferiores. Ecocardiograma: Valva mitral com fusão comissural. Área valvar mitral = 0,9 cm2. Gradiente médio AE-VE = 12 mmHg. Insuficiência mitral moderada. Pressão sistólica da artéria pulmonar = 54 mmHg. Qual a melhor conduta?', 'Estenose mitral importante (área 0,9cm²) sintomática, mas com insuficiência mitral MODERADA associada — a IM moderada contraindica a valvuloplastia por balão, restando o tratamento cirúrgico da valvopatia mitral — alternativa D.', 'A paciente apresenta estenose mitral importante (área valvar 0,9 cm²), sintomática e com fator complicador (PSAP 54 mmHg), o que indicaria intervenção. Entretanto, há insuficiência mitral MODERADA associada — a presença de IM mais que discreta é contraindicação à valvuloplastia mitral por cateter-balão (o procedimento tende a piorar a regurgitação). Assim, a conduta correta é o tratamento cirúrgico da valvopatia mitral — alternativa D.

Por que as outras alternativas estão incorretas:
• A) O escore de Wilkins-Block já não seria suficiente para mudar a conduta, pois a IM moderada associada já contraindica a via percutânea, independentemente da anatomia da estenose.
• B) A valvoplastia por cateter-balão é CONTRAINDICADA na presença de insuficiência mitral moderada (ou mais) associada.
• C) Manter apenas tratamento clínico é inadequado diante de estenose importante sintomática e limitante, já refratária ao diurético.
• E) O ecocardiograma transesofágico para pesquisa de trombo é indicado antes de intervenção percutânea; como esta já está contraindicada pela IM moderada, não é o próximo passo mais relevante.'),

('e3109c8d-6251-41fb-8b62-5e0c6d3c2f5f', 'Válvula', 2021, 'TEC', 'Paciente do sexo feminino, com 33 anos, vem à consulta devido a achado de sopro. Refere ser completamente assintomática e nega comorbidades e uso de medicações. Ao exame, apresenta-se em bom estado geral, frequência cardíaca (FC) = 83 bpm; pressão arterial (PA) = 112 x 58 mmHg, com ausculta de ritmo cardíaco regular e sopro regurgitativo +++ em foco mitral, mesotelessistólico, com irradiação para linha axilar média, sem outros achados ao exame clínico. Traz eletrocardiograma em ritmo sinusal e ecocardiograma transtorácico: átrio esquerdo de 36 mm, ventrículo esquerdo = 48 x 31 mm, fração de ejeção de 65%, insuficiência mitral importante com prolapso de cúspide anterior, segmento A2 e A3, pressão sistólica da artéria pulmonar (PSAP) = 33 mmHg. Assinale a conduta CORRETA para a paciente descrita:', 'IM primária importante, porém ASSINTOMÁTICA e sem nenhum fator complicador (FE 65%, DSVE 31mm normal, AE 36mm normal, PSAP 33mmHg normal) — conduta é acompanhamento clínico/ecocardiográfico seriado, orientando retorno se surgirem sintomas — alternativa D.', 'Apesar de a insuficiência mitral ser classificada como importante ao ecocardiograma (prolapso com refluxo relevante), a paciente é assintomática e NÃO apresenta nenhum dos fatores complicadores reconhecidos (FEVE preservada em 65%, DSVE normal em 31mm, AE não muito dilatado em 36mm, PSAP normal em 33mmHg). Nesse cenário, a conduta correta é o acompanhamento clínico e ecocardiográfico periódico (a cada 6 meses), orientando a paciente a retornar antes se surgirem sintomas — alternativa D.

Por que as outras alternativas estão incorretas:
• A e C) Não há indicação de intervenção precoce (plastia ou troca) em paciente assintomática sem fatores complicadores — a intervenção precoce é reservada a casos com alta probabilidade de reparo durável associados a fatores de risco, o que não está presente aqui.
• B) Não há sinais de congestão/sintomas que justifiquem tratamento medicamentoso com diuréticos/vasodilatadores neste momento.
• E) O MitraClip é reservado a pacientes sintomáticos de alto risco cirúrgico — não se aplica a esta paciente assintomática e de baixo risco.'),

('99ae81ee-3a7a-4f11-b35b-c0a1de9791d2', 'Válvula', 2022, 'TEC', 'São achados do exame físico de pacientes com insuficiência mitral primária importante:', 'Sinais clínicos de insuficiência cardíaca DIREITA (turgência jugular, hepatomegalia, edema) podem ocorrer na IM importante avançada, por hipertensão pulmonar secundária — alternativa C.', 'Na insuficiência mitral primária importante, com a evolução da hipertensão pulmonar secundária à sobrecarga volumétrica crônica do átrio esquerdo, podem surgir sinais de insuficiência cardíaca direita (turgência jugular, hepatomegalia, edema de membros inferiores) — alternativa C.

Por que as outras alternativas estão incorretas:
• A) O ictus costuma estar desviado para BAIXO E PARA A ESQUERDA (não no 4º espaço intercostal na hemiclavicular, posição normal), refletindo a dilatação do VE.
• B) O sopro sistólico regurgitativo na IM importante costuma ser INTENSO (geralmente +++/6+ ou mais), não de baixa intensidade.
• D) A B1 tende a estar HIPOFONÉTICA (não hiperfonética) na IM importante, pela interposição do jato regurgitante no fechamento valvar.
• E) A B2 pode estar HIPERFONÉTICA (não hipofonética) por hipertensão pulmonar associada.'),

('c08e3114-7fcb-49d7-b83e-cf72fae4c4a2', 'Válvula', 2021, 'TEC', 'Na insuficiência mitral primária crônica, a presença de irradiação do sopro para o esterno e o foco aórtico deve ser interpretada como um sinal de:', 'A irradiação do sopro para o esterno/foco aórtico na IM primária sugere jato regurgitante excêntrico direcionado anteriormente, característico de rotura/prolapso da cúspide POSTERIOR (o jato se dirige para a parede anterior do átrio, refletindo-se e irradiando anteriormente) — alternativa A.', 'Na insuficiência mitral primária, a direção de irradiação do sopro reflete a direção do jato regurgitante excêntrico: quando há rotura de cordoalha ou prolapso da cúspide POSTERIOR, o jato se dirige anteriormente (em direção à parede anterior do átrio esquerdo/aorta), podendo irradiar para o esterno e o foco aórtico — alternativa A.

Por que as outras alternativas estão incorretas:
• B) O aumento atrial esquerdo isolado não determina uma irradiação específica do sopro para a base; é consequência da sobrecarga volumétrica crônica, não do padrão de irradiação.
• C) A dilatação do ventrículo esquerdo também é consequência da sobrecarga crônica, não determina esse padrão específico de irradiação anterior.
• D) A disfunção de VD não é o mecanismo que explica a irradiação do sopro mitral para a base.
• E) A hipertensão pulmonar altera a intensidade de B2, não o padrão de irradiação do sopro mitral.'),

('15d1c8ea-3487-48bf-8ee8-bd874a92e757', 'Válvula', 2020, 'TEC', 'Mulher, 55 anos, apresenta ao exame clínico pressão arterial = 140 x 70 mmHg, ictus do ventrículo esquerdo desviado e propulsivo, terceira bulha e sopro sistólico contínuo e suave (+4/+6) no bordo esternal esquerdo (4º/5º espaços intercostais) e ponta com irradiação para axila. O sopro não se altera com o ciclo respiratório e na manobra de Handgrip aumenta sua intensidade. Neste caso, o diagnóstico mais provável é:', 'Sopro sistólico com irradiação para axila, que aumenta com Handgrip (aumenta pós-carga/resistência periférica, aumentando o refluxo mitral) e não varia com a respiração (não é lado direito) — achados típicos de insuficiência mitral — alternativa E.', 'O sopro sistólico com irradiação para a axila que se intensifica com a manobra de Handgrip (aumento da pós-carga sistêmica, que acentua o refluxo através da valva mitral incompetente) e que não varia com a respiração (afastando origem em câmaras direitas) é característico de insuficiência mitral — alternativa E.

Por que as outras alternativas estão incorretas:
• A) A estenose aórtica tem sopro sistólico EJETIVO (não holossistólico/contínuo), com irradiação para carótidas, e tipicamente DIMINUI (não aumenta) com Handgrip, pois a manobra reduz o gradiente transvalvar.
• B) A insuficiência aórtica cursa com sopro DIASTÓLICO aspirativo, não sistólico.
• C) A insuficiência tricúspide tem sopro que AUMENTA com a inspiração (sinal de Rivero-Carvallo), diferente do descrito (sem variação respiratória).
• D) A cardiomiopatia hipertrófica obstrutiva tem sopro que DIMINUI com Handgrip (aumento da pós-carga reduz o gradiente dinâmico na via de saída do VE) — o oposto do que ocorre neste caso.'),

('8066a3fa-0369-4357-9692-e2799a7d88bb', 'Válvula', 2022, 'TEC', 'Paciente do sexo feminino, 33 anos de idade, traz o seguinte exame em consulta médica. Cineangiocoronariografia + cateterismo direito e esquerdo:
Assinale a alternativa que melhor descreve a condição hemodinâmica da paciente:', 'A tabela de pressões do cateterismo mostra estenose mitral importante com hipertensão pulmonar de padrão combinado (pré e pós-capilar): pressão capilar pulmonar média de 30 mmHg (pós-capilar elevada) e pressão média em tronco pulmonar de 36 mmHg, com gradiente transpulmonar de cerca de 6 mmHg (componente pré-capilar reativo adicional) — alternativa B.', 'A tabela de pressões do cateterismo direito e esquerdo mostra: átrio direito com pressão média de 3 mmHg (normal); ventrículo direito 60/0-3 mmHg; tronco pulmonar 60/25 mmHg (média de 36 mmHg); pressão capilar pulmonar média de 30 mmHg; aorta ascendente 130/90 mmHg (média 103); e ventrículo esquerdo 130/3-10 mmHg. A pressão capilar pulmonar bastante elevada (30 mmHg) já confirma o componente PÓS-capilar (secundário à estenose mitral crônica represando pressão retrógrada). Como a pressão média do tronco pulmonar (36 mmHg) supera a pressão capilar em cerca de 6 mmHg (gradiente transpulmonar elevado, > 12-15 mmHg seria o corte mais clássico, mas já há elevação desproporcional sugerindo componente reativo), caracteriza-se hipertensão pulmonar do tipo COMBINADO (pré e pós-capilar) associada à estenose mitral importante — alternativa B.

Por que as outras alternativas estão incorretas:
• A) Hipertensão pulmonar apenas pré-capilar não é compatível com a pressão capilar pulmonar tão elevada (30 mmHg) observada na tabela, que reflete diretamente a obstrução mitral (componente pós-capilar).
• C) Os dados da tabela (pressões elevadas em VD/tronco pulmonar e capilar pulmonar) são compatíveis com estenose mitral IMPORTANTE, não moderada.
• D) A elevação da pressão em tronco pulmonar acima da pressão capilar indica também um componente PRÉ-capilar reativo, não uma hipertensão pulmonar pós-capilar isolada.
• E) A gravidade hemodinâmica descrita pela tabela (pressões pulmonares muito elevadas) é compatível com estenose importante, não moderada.'),

('ed8f9995-2088-4e94-aa81-2ec72cf8a535', 'Válvula', 2018, 'TEC', 'Sobre o diagnóstico de prolapso de valva mitral, assinale a alternativa INCORRETA:', 'O prolapso de valva mitral NÃO é a principal causa de valvopatia no Brasil — a doença reumática ainda ocupa essa posição no nosso meio — alternativa B (incorreta) é o gabarito.', 'No Brasil, a doença reumática ainda é a principal causa de valvopatia (diferente de países desenvolvidos, onde etiologias degenerativas/mixomatosas predominam), tornando incorreta a afirmação de que o prolapso mitral já seria a principal causa — alternativa B é o gabarito (afirmativa incorreta).

Por que as outras alternativas estão corretas (não são o gabarito):
• A) Essa é, de fato, a definição ecocardiográfica de prolapso valvar mitral (deslocamento sistólico ≥2 mm acima do plano do anel).
• C) O PVM é mais prevalente em adultos de meia-idade/idosos do que em crianças, sendo correto.
• D) A plástica valvar é, de fato, o tratamento cirúrgico preferencial quando a anatomia é favorável.
• E) O prolapso isolado de P2 é o subtipo com melhores resultados cirúrgicos de reparo (plastia), sendo uma afirmação correta.'),

('4cf6eef9-5ded-4320-93dd-4c8b47390545', 'Válvula', 2019, 'TEC', 'Assinale a alternativa que representa uma afirmação correta sobre o prolapso da valva mitral (PVM):', 'O risco de morte súbita em pacientes com insuficiência mitral GRAVE por PVM é aproximadamente o dobro em relação à população geral, atribuído a maior incidência de arritmias ventriculares nesse subgrupo — alternativa A.', 'Em pacientes com prolapso de valva mitral e insuficiência mitral GRAVE associada, há evidência de risco aumentado (cerca do dobro) de morte súbita em comparação a indivíduos sem a valvopatia, atribuído principalmente a arritmias ventriculares (fibrose no músculo papilar/miocárdio adjacente, entre outros mecanismos) — alternativa A.

Por que as outras alternativas estão incorretas:
• B) A profilaxia antibiótica para procedimentos odontológicos NÃO é mais recomendada rotineiramente para pacientes com PVM (apenas em situações de altíssimo risco de endocardite, o que não é a regra no PVM isolado).
• C) Manobras que REDUZEM o volume do VE (como Valsalva, ortostase) ANTECIPAM (não atrasam) o click e o sopro, aproximando-os da primeira bulha.
• D) Os melhores resultados de plastia são obtidos com ressecção do folheto POSTERIOR (não anterior), tipicamente do segmento P2.
• E) O critério ecocardiográfico clássico é deslocamento ≥ 2 mm (não 5 mm) para o átrio esquerdo durante a sístole.');

insert into public.question_options (id, question_id, letra, texto, correta) values

(gen_random_uuid(), '679117b8-aaa0-470a-a5f3-2e2cc3a879ed', 'a', 'Segundo os estágios de classificação das valvopatias, trata-se de um estágio C', false),
(gen_random_uuid(), '679117b8-aaa0-470a-a5f3-2e2cc3a879ed', 'b', 'Com base no ecocardiograma, a valvopatia tem critérios de valvopatia moderada, com área valvar acima de 1,5 cm² e gradiente médio baixo', false),
(gen_random_uuid(), '679117b8-aaa0-470a-a5f3-2e2cc3a879ed', 'c', 'A terapia com novos anticoagulantes orais é de escolha para esta valvopatia, principalmente para pacientes que apresentam fibrilação atrial e átrio esquerdo aumentado', false),
(gen_random_uuid(), '679117b8-aaa0-470a-a5f3-2e2cc3a879ed', 'd', 'Nesta valvopatia é contraindicado o uso de betabloqueadores e bloqueadores dos canais de cálcio', false),
(gen_random_uuid(), '679117b8-aaa0-470a-a5f3-2e2cc3a879ed', 'e', 'Recomenda-se a valvuloplastia por balão para este paciente se houver escore ecocardiográfico favorável e ausência de trombo', true),

(gen_random_uuid(), '5fe10bec-0ab3-49e6-810e-546c2026ec55', 'a', 'o desenvolvimento de fibrilação atrial é comum em pacientes com IM primária e não é considerado indicação para intervenção cirúrgica', true),
(gen_random_uuid(), '5fe10bec-0ab3-49e6-810e-546c2026ec55', 'b', 'são considerados fatores agravantes na IM primária a fração de ejeção ≤ 60%, o diâmetro sistólico do ventrículo esquerdo ≥ 40 mm, a pressão sistólica da artéria pulmonar ≥ 50 mmHg e a presença de fibrilação atrial de início recente (< 1 ano)', false),
(gen_random_uuid(), '5fe10bec-0ab3-49e6-810e-546c2026ec55', 'c', 'o implante de MitraClip® pode ser indicado para pacientes em classe funcional > III da New York Heart Association com alto risco cirúrgico ou contraindicação para a cirurgia', false),
(gen_random_uuid(), '5fe10bec-0ab3-49e6-810e-546c2026ec55', 'd', 'a cirurgia é recomendada para pacientes assintomáticos com IM primária grave, disfunção sistólica do ventrículo esquerdo (fração de ejeção entre 30-60%) e diâmetro sistólico final do VE ≥ 40 mm', false),
(gen_random_uuid(), '5fe10bec-0ab3-49e6-810e-546c2026ec55', 'e', 'o tratamento cirúrgico deve ser considerado para pacientes portadores de IM primária que cursem com sintomas ou que apresentem deterioração progressiva da função ventricular esquerda ou aumento progressivo das dimensões ventriculares esquerdas', false),

(gen_random_uuid(), 'f7f1e4b6-794e-4f23-8c84-e57084a7f603', 'a', 'Estão corretas as assertivas I, II e III.', false),
(gen_random_uuid(), 'f7f1e4b6-794e-4f23-8c84-e57084a7f603', 'b', 'Estão corretas as assertivas III e IV.', false),
(gen_random_uuid(), 'f7f1e4b6-794e-4f23-8c84-e57084a7f603', 'c', 'Estão corretas as assertivas I e IV.', true),
(gen_random_uuid(), 'f7f1e4b6-794e-4f23-8c84-e57084a7f603', 'd', 'Estão corretas as assertivas II e IV.', false),
(gen_random_uuid(), 'f7f1e4b6-794e-4f23-8c84-e57084a7f603', 'e', 'Todas as alternativas estão corretas.', false),

(gen_random_uuid(), '12cd189c-909a-4678-802a-616e2b872209', 'a', 'prolapso de valva mitral; a duração do sopro não está relacionada à intensidade da insuficiência mitral e deve ser indicada a troca valvar cirúrgica', false),
(gen_random_uuid(), '12cd189c-909a-4678-802a-616e2b872209', 'b', 'prolapso de valva mitral; o risco de morte súbita é duas vezes maior nesses pacientes devido a arritmias atriais e evolução para taquiarritmias supraventriculares', false),
(gen_random_uuid(), '12cd189c-909a-4678-802a-616e2b872209', 'c', 'prolapso de valva mitral; a conduta mais adequada neste momento é a indicação de plastia cirúrgica de valva mitral, se anatomia favorável', true),
(gen_random_uuid(), '12cd189c-909a-4678-802a-616e2b872209', 'd', 'insuficiência mitral funcional, sendo indicada troca valvar imediata, mesmo com anatomia favorável à plastia', false),
(gen_random_uuid(), '12cd189c-909a-4678-802a-616e2b872209', 'e', 'Insuficiência mitral grave; a maioria dos pacientes com essa valvopatia permanece assintomática até a idade senil, requerendo monitorização e periodicidade nas revisões. O tratamento clínico incluindo o uso de ácido acetilsalicílico é a melhor opção neste momento.', false),

(gen_random_uuid(), 'cf28fa6f-0665-4744-84c3-56ff64a9780e', 'a', 'I, II e IV.', false),
(gen_random_uuid(), 'cf28fa6f-0665-4744-84c3-56ff64a9780e', 'b', 'I, III e V.', false),
(gen_random_uuid(), 'cf28fa6f-0665-4744-84c3-56ff64a9780e', 'c', 'I, IV e V.', false),
(gen_random_uuid(), 'cf28fa6f-0665-4744-84c3-56ff64a9780e', 'd', 'II, III e IV.', true),
(gen_random_uuid(), 'cf28fa6f-0665-4744-84c3-56ff64a9780e', 'e', 'II, IV e V.', false),

(gen_random_uuid(), '63333bb0-8a32-4ad7-a6aa-d68ed2248072', 'a', 'Fração de ejeção do ventrículo esquerdo (FEVE) ≤ 60% ou queda da FEVE durante a evolução.', false),
(gen_random_uuid(), '63333bb0-8a32-4ad7-a6aa-d68ed2248072', 'b', 'Remodelamento progressivo (diâmetro sistólico ≥ 40 mm ).', false),
(gen_random_uuid(), '63333bb0-8a32-4ad7-a6aa-d68ed2248072', 'c', 'Pressão sistólica da artéria pulmonar ≥ 50 mmHg ou ≥ 60 mmHg ao exercício.', false),
(gen_random_uuid(), '63333bb0-8a32-4ad7-a6aa-d68ed2248072', 'd', 'Episódios de taquicardia supraventricular paroxística.', true),
(gen_random_uuid(), '63333bb0-8a32-4ad7-a6aa-d68ed2248072', 'e', 'Volume de átrio esquerdo ≥ 60 mL/m2.', false),

(gen_random_uuid(), 'ea3a361e-e050-442c-8cd9-178b986257a6', 'a', 'A propedêutica cardiovascular descrita não é condizente com o achado ecocardiográfico, sendo imperativa a realização de outro exame para melhor avaliação.', false),
(gen_random_uuid(), 'ea3a361e-e050-442c-8cd9-178b986257a6', 'b', 'A presença de rotura de cordas tendíneas contraindica a realização de plástica valvar mitral.', false),
(gen_random_uuid(), 'ea3a361e-e050-442c-8cd9-178b986257a6', 'c', 'Neste caso, a fração de ejeção de ventrículo esquerdo pode estar superestimada pela regurgitação mitral; sendo assim, os achados ecocardiográficos são indicativos de intervenção valvar.', false),
(gen_random_uuid(), 'ea3a361e-e050-442c-8cd9-178b986257a6', 'd', 'A presença de fibrilação atrial, mesmo paroxística, é considerada um complicador e é indicativa de intervenção valvar.', true),
(gen_random_uuid(), 'ea3a361e-e050-442c-8cd9-178b986257a6', 'e', 'Neste caso, a melhor conduta a ser indicada neste momento seria a conduta expectante.', false),

(gen_random_uuid(), '08b6f911-a194-4875-8a29-1948934889bf', 'a', 'A indicação é de reparo valvar cirúrgico, pois apresenta valvopatia mitral primária do tipo regurgitação e presença de sintomas.', true),
(gen_random_uuid(), '08b6f911-a194-4875-8a29-1948934889bf', 'b', 'O ecocardiograma nos apresenta apenas a queda da fração de ejeção do VE como um complicador que indique intervenção.', false),
(gen_random_uuid(), '08b6f911-a194-4875-8a29-1948934889bf', 'c', 'A indicação é de teste ergométrico para avaliar a pressão da artéria pulmonar antes de indicar qualquer intervenção', false),
(gen_random_uuid(), '08b6f911-a194-4875-8a29-1948934889bf', 'd', 'A indicação é de ecocardiograma com estresse físico para avaliar se a pressão da artéria pulmonar preenche o critério de complicador.', false),
(gen_random_uuid(), '08b6f911-a194-4875-8a29-1948934889bf', 'e', 'A indicação é de intervenção transcateter com dispositivo de clipagem.', false),

(gen_random_uuid(), '3a4b0f8b-5201-4f36-b669-01efb82ff674', 'a', 'Valvoplastia mitral por cateter balão.', true),
(gen_random_uuid(), '3a4b0f8b-5201-4f36-b669-01efb82ff674', 'b', 'Cirurgia de plastia mitral.', false),
(gen_random_uuid(), '3a4b0f8b-5201-4f36-b669-01efb82ff674', 'c', 'Cirurgia de troca valvar mitral.', false),
(gen_random_uuid(), '3a4b0f8b-5201-4f36-b669-01efb82ff674', 'd', 'Manutenção do tratamento clínico medicamentoso e anticoagulação com varfarina.', false),
(gen_random_uuid(), '3a4b0f8b-5201-4f36-b669-01efb82ff674', 'e', 'Manutenção do tratamento clínico medicamentoso e anticoagulação com anticoagulantes orais diretos (DOAC).', false),

(gen_random_uuid(), 'a02b9037-c897-4cf7-be57-fbd0f5e83e15', 'a', 'O tratamento de escolha na etiologia reumática é a valvuloplastia mitral por cateter-balão quando há sintomas e escore ecocardiográfico (Wilkins e Block) ≤ 8.', true),
(gen_random_uuid(), 'a02b9037-c897-4cf7-be57-fbd0f5e83e15', 'b', 'Insuficiência mitral moderada não contraindica tratamento percutâneo.', false),
(gen_random_uuid(), 'a02b9037-c897-4cf7-be57-fbd0f5e83e15', 'c', 'Na estenose mitral degenerativa calcificada, há clara indicação de valvuloplastia mitral por cateter-balão.', false),
(gen_random_uuid(), 'a02b9037-c897-4cf7-be57-fbd0f5e83e15', 'd', 'A hipertensão arterial pulmonar é um fator complicador que contraindica a intervenção na estenose mitral reumática.', false),
(gen_random_uuid(), 'a02b9037-c897-4cf7-be57-fbd0f5e83e15', 'e', 'Os betabloqueadores estão contraindicados na estenose mitral.', false),

(gen_random_uuid(), '06df03d7-e596-453e-838c-f60cbd4bc75a', 'a', 'Estalido de abertura precoce.', false),
(gen_random_uuid(), '06df03d7-e596-453e-838c-f60cbd4bc75a', 'b', 'B1 e B2 hipofonéticas.', true),
(gen_random_uuid(), '06df03d7-e596-453e-838c-f60cbd4bc75a', 'c', 'Sopro diastólico em ruflar com reforço pressistólico em ritmo sinusal.', false),
(gen_random_uuid(), '06df03d7-e596-453e-838c-f60cbd4bc75a', 'd', 'Sinais de congestão pulmonar.', false),
(gen_random_uuid(), '06df03d7-e596-453e-838c-f60cbd4bc75a', 'e', 'Sinais de insuficiência cardíaca direita.', false),

(gen_random_uuid(), '1694f4a3-6348-4d75-a07e-45432646f8ab', 'a', 'Reforço pré-sistólico.', true),
(gen_random_uuid(), '1694f4a3-6348-4d75-a07e-45432646f8ab', 'b', 'Estalido de abertura.', false),
(gen_random_uuid(), '1694f4a3-6348-4d75-a07e-45432646f8ab', 'c', 'Ruflar diastólico.', false),
(gen_random_uuid(), '1694f4a3-6348-4d75-a07e-45432646f8ab', 'd', 'Hiperfonese de primeira bulha.', false),
(gen_random_uuid(), '1694f4a3-6348-4d75-a07e-45432646f8ab', 'e', 'Turgência jugular.', false),

(gen_random_uuid(), 'd53bdf84-af08-4c9e-ad56-7da761d90789', 'a', 'Solicitar novo ecocardiograma para avaliar escore de Wilkins-Block.', false),
(gen_random_uuid(), 'd53bdf84-af08-4c9e-ad56-7da761d90789', 'b', 'Indicar valvoplastia mitral por cateter-balão.', false),
(gen_random_uuid(), 'd53bdf84-af08-4c9e-ad56-7da761d90789', 'c', 'Manter tratamento clínico com diurético.', false),
(gen_random_uuid(), 'd53bdf84-af08-4c9e-ad56-7da761d90789', 'd', 'Indicar tratamento cirúrgico da valvopatia mitral.', true),
(gen_random_uuid(), 'd53bdf84-af08-4c9e-ad56-7da761d90789', 'e', 'Solicitar ecocardiograma transesofágico para descartar trombo antes da cirurgia.', false),

(gen_random_uuid(), 'e3109c8d-6251-41fb-8b62-5e0c6d3c2f5f', 'a', 'Intervenção valvar mitral precoce com indicação de plástica mitral.', false),
(gen_random_uuid(), 'e3109c8d-6251-41fb-8b62-5e0c6d3c2f5f', 'b', 'Tratamento clínico/medicamentoso com diuréticos e vasodilatadores (preferência por IECA ou BRA).', false),
(gen_random_uuid(), 'e3109c8d-6251-41fb-8b62-5e0c6d3c2f5f', 'c', 'Intervenção valvar mitral precoce com indicação de troca valvar mitral por bioprótese.', false),
(gen_random_uuid(), 'e3109c8d-6251-41fb-8b62-5e0c6d3c2f5f', 'd', 'Acompanhamento clínico e ecocardiográfico a cada 6 meses, orientando a paciente retornar ao consultório em caso de surgimento de sintomas.', true),
(gen_random_uuid(), 'e3109c8d-6251-41fb-8b62-5e0c6d3c2f5f', 'e', 'Intervenção valvar mitral precoce com indicação de MitraClip', false),

(gen_random_uuid(), '99ae81ee-3a7a-4f11-b35b-c0a1de9791d2', 'a', 'Ictus cordis no quarto espaço intercostal na linha hemiclavicular esquerda.', false),
(gen_random_uuid(), '99ae81ee-3a7a-4f11-b35b-c0a1de9791d2', 'b', 'Sopro sistólico regurgitativo <+++/6+.', false),
(gen_random_uuid(), '99ae81ee-3a7a-4f11-b35b-c0a1de9791d2', 'c', 'Sinais clínicos de insuficiência cardíaca direita.', true),
(gen_random_uuid(), '99ae81ee-3a7a-4f11-b35b-c0a1de9791d2', 'd', 'B1 hiperfonética.', false),
(gen_random_uuid(), '99ae81ee-3a7a-4f11-b35b-c0a1de9791d2', 'e', 'B2 hipofonética.', false),

(gen_random_uuid(), 'c08e3114-7fcb-49d7-b83e-cf72fae4c4a2', 'a', 'Rotura de cordas da cúspide posterior.', true),
(gen_random_uuid(), 'c08e3114-7fcb-49d7-b83e-cf72fae4c4a2', 'b', 'Aumento atrial esquerdo.', false),
(gen_random_uuid(), 'c08e3114-7fcb-49d7-b83e-cf72fae4c4a2', 'c', 'Dilatação do ventrículo esquerdo.', false),
(gen_random_uuid(), 'c08e3114-7fcb-49d7-b83e-cf72fae4c4a2', 'd', 'Disfunção ventricular direita.', false),
(gen_random_uuid(), 'c08e3114-7fcb-49d7-b83e-cf72fae4c4a2', 'e', 'Hipertensão pulmonar.', false),

(gen_random_uuid(), '15d1c8ea-3487-48bf-8ee8-bd874a92e757', 'a', 'estenose aórtica', false),
(gen_random_uuid(), '15d1c8ea-3487-48bf-8ee8-bd874a92e757', 'b', 'insuficiência aórtica', false),
(gen_random_uuid(), '15d1c8ea-3487-48bf-8ee8-bd874a92e757', 'c', 'insuficiência tricúspide', false),
(gen_random_uuid(), '15d1c8ea-3487-48bf-8ee8-bd874a92e757', 'd', 'cardiomiopatia hipertrófica', false),
(gen_random_uuid(), '15d1c8ea-3487-48bf-8ee8-bd874a92e757', 'e', 'insuficiência mitral', true),

(gen_random_uuid(), '8066a3fa-0369-4357-9692-e2799a7d88bb', 'a', 'Estenose mitral importante e hipertensão pulmonar pré-capilar.', false),
(gen_random_uuid(), '8066a3fa-0369-4357-9692-e2799a7d88bb', 'b', 'Estenose mitral importante e hipertensão pulmonar combinada pré e pós-capilar.', true),
(gen_random_uuid(), '8066a3fa-0369-4357-9692-e2799a7d88bb', 'c', 'Estenose mitral moderada e hipertensão pulmonar grupo 2.', false),
(gen_random_uuid(), '8066a3fa-0369-4357-9692-e2799a7d88bb', 'd', 'Estenose mitral importante e hipertensão pulmonar pós-capilar isolada.', false),
(gen_random_uuid(), '8066a3fa-0369-4357-9692-e2799a7d88bb', 'e', 'Estenose mitral moderada.', false),

(gen_random_uuid(), 'ed8f9995-2088-4e94-aa81-2ec72cf8a535', 'a', 'Deslocamento sistólico posterior, de toda ou de parte, de uma ou de ambas as cúspides da valva mitral, em direção ao átrio esquerdo maior ou igual a 2 mm do plano do anel valvar.', false),
(gen_random_uuid(), 'ed8f9995-2088-4e94-aa81-2ec72cf8a535', 'b', 'Já é a principal causa de valvopatia no Brasil.', true),
(gen_random_uuid(), 'ed8f9995-2088-4e94-aa81-2ec72cf8a535', 'c', 'É mais comum em idosos e indivíduos de meia idade.', false),
(gen_random_uuid(), 'ed8f9995-2088-4e94-aa81-2ec72cf8a535', 'd', 'A plástica valvar mitral é o tratamento cirúrgico preferencial nos casos com anatomia favorável.', false),
(gen_random_uuid(), 'ed8f9995-2088-4e94-aa81-2ec72cf8a535', 'e', 'Prolapso valvar mitral de cúspide posterior (P2 isolado) é o que apresenta os melhores resultados na cirurgia conservadora.', false),

(gen_random_uuid(), '4cf6eef9-5ded-4320-93dd-4c8b47390545', 'a', 'O risco de morte súbita nos pacientes com insuficiência mitral grave é aproximadamente o dobro em relação a indivíduos normais, provavelmente por um risco aumentado de arritmias ventriculares.', true),
(gen_random_uuid(), '4cf6eef9-5ded-4320-93dd-4c8b47390545', 'b', 'Nos pacientes com PVM, ao realizarem procedimentos odontológicos, é preconizada a antibioticoterapia para prevenção da endocardite infecciosa.', false),
(gen_random_uuid(), '4cf6eef9-5ded-4320-93dd-4c8b47390545', 'c', 'Na ausculta dinâmica do paciente com PVM, as manobras que reduzem o volume do ventrículo esquerdo atrasam o click e o sopro sistólico, que se deslocam em direção à segunda bulha.', false),
(gen_random_uuid(), '4cf6eef9-5ded-4320-93dd-4c8b47390545', 'd', 'No tratamento cirúrgico do PVM é preferida a plastia da valva mitral, e os melhores resultados são obtidos quando é feita ressecção do folheto anterior mitral.', false),
(gen_random_uuid(), '4cf6eef9-5ded-4320-93dd-4c8b47390545', 'e', 'Para estabelecer o diagnóstico ecocardiográfico do PVM, o ecocardiograma bidimensional deve mostrar que um ou ambos os folhetos mitrais se deslocam acima de 5 mm para o átrio esquerdo durante a sístole na vista longitudinal paraesternal.', false);

insert into public.questions (id, tema, ano, instituicao, enunciado, comentario, comentario_completo) values

('6a89c8e0-450b-4dd6-9285-8200ca27bb3d', 'Válvula', 2019, 'TEC', 'Mulher, 28 anos, procura pelo ambulatório com queixa de dispneia aos esforços associada a intensas palpitações. Ao exame físico, chamam a atenção pressão venosa de jugular, exibindo onda "a" proeminente, primeira bulha palpável, ritmo cardíaco regular, primeira bulha hiperfonética (B1), estalido de abertura e ruflar diastólico melhor audível com o paciente em decúbito lateral esquerdo. Pressão arterial (PA) = 100 x 70 mmHg. O eletrocardiograma mostra eixo desviado para a direita, sobrecarga atrial direita e sobrecarga ventricular direita. A radiografia de tórax mostra presença de duplo contorno e de quarto arco. O ecocardiograma demonstra ventrículo esquerdo (VE) de dimensões e função sistólica normais, aumento do volume dos átrios e do ventrículo direito (VD). Valva mitral com sinais de espessamento e de calcificação dos folhetos com abertura em "domo", gradiente transvalvar mitral médio = 11 mmHg. Refluxo tricúspide moderado estimando pressão sistólica da artéria pulmonar (PSAP) em 55 mmHg. Com relação a esta valvopatia, qual das afirmativas é correta:', 'A valvuloplastia mitral por cateter-balão é indicada para pacientes com estenose mitral em situações de gravidade moderada a importante, sintomáticos (CF II-IV), com anatomia valvar favorável — alternativa C.', 'O caso descreve estenose mitral reumática com repercussão em câmaras direitas (sobrecarga de AD/VD, duplo contorno e 4º arco na radiografia, hipertensão pulmonar). A valvuloplastia mitral por cateter-balão é indicada para pacientes sintomáticos (CF II-IV) com estenose de gravidade moderada a importante e anatomia valvar favorável — alternativa C.

Por que as outras alternativas estão incorretas:
• A) Os pacientes ideais para VMCB são aqueles com escore de Wilkins e Block BAIXO (favorável, tipicamente ≤ 8), não ≥ 11 — escores altos indicam anatomia desfavorável.
• B) O controle da frequência cardíaca É, sim, um objetivo importante do tratamento (reduz sintomas e o risco de descompensação), e as taquicardias NÃO são bem toleradas na estenose mitral (reduzem o tempo de enchimento diastólico transmitral).
• D) As contraindicações clássicas à VMCB envolvem insuficiência mitral MODERADA a importante associada (não leve) e escore de Wilkins e Block desfavorável — a descrição com "IM leve" como contraindicação está incorreta.
• E) A VMCB é indicada em assintomáticos justamente quando HÁ fatores complicadores (como PSAP ≥ 50 mmHg em repouso ou ao esforço, ou FA de início recente) — a alternativa inverte esse conceito ao dizer "sem fatores complicadores".'),

('dfa2280d-3345-4743-a26c-3bc6ec083641', 'Válvula', 2021, 'TEC', 'Em relação à insuficiência mitral primária crônica, são considerados fatores complicadores, que devem motivar a discussão no Heart Team para possível indicação de tratamento intervencionista (cirúrgico ou percutâneo), EXCETO:', 'O diâmetro DIASTÓLICO final do VE ≥ 60 mm não é o critério clássico de complicador na IM primária — o parâmetro validado é o diâmetro SISTÓLICO final (DSVE ≥ 40 mm), não o diastólico — alternativa C.', 'Os fatores complicadores classicamente reconhecidos na insuficiência mitral primária crônica envolvem o diâmetro SISTÓLICO final do VE (DSVE ≥ 40 mm), a FEVE ≤ 60%, o volume de átrio esquerdo ≥ 60 mL/m² e a PSAP ≥ 50 mmHg (repouso) ou ≥ 60 mmHg (esforço). O diâmetro DIASTÓLICO final ≥ 60 mm não faz parte desses critérios validados — alternativa C é a exceção (não é complicador reconhecido).

Por que as outras alternativas são, de fato, complicadores (não são o gabarito):
• A) DSVE ≥ 40 mm é o parâmetro clássico de remodelamento ventricular relevante.
• B) FEVE ≤ 60% já reflete disfunção subclínica na IM (a fração de ejeção "normal" costuma estar superestimada pela regurgitação).
• D) Volume de AE ≥ 60 mL/m² reflete sobrecarga crônica significativa.
• E) PSAP ≥ 60 mmHg ao esforço é complicador reconhecido mesmo com PSAP de repouso normal.'),

('c108219c-627b-4d41-bf8d-7c07bf8a1456', 'Válvula', 2018, 'TEC', 'Apesar dos avanços técnicos no campo da cirurgia valvar, a valvuloplastia mitral por cateter-balão (VMCB) continua como tratamento de escolha para pacientes com estenose mitral moderada e importante em alguns subgrupos de pacientes. Dentre os casos a seguir, assinale a alternativa que contém paciente com indicação para VMCB:', 'Entre as opções, a combinação de estenose mitral reumática com escore de Wilkins de 9 (componentes com mobilidade e subvalvar mais baixos) e apenas insuficiência mitral discreta associada representa o melhor perfil para VMCB — alternativa C.', 'A VMCB exige etiologia reumática, anatomia relativamente favorável (escore de Wilkins e Block não muito elevado, sobretudo nos componentes de mobilidade e aparelho subvalvar) e ausência de insuficiência mitral relevante associada. Na alternativa C (escore de Wilkins 9: subvalvar 2, calcificação 2, espessamento 3, mobilidade 2), a anatomia permanece favorável nos componentes mais determinantes do sucesso do procedimento (mobilidade e subvalvar baixos), e a insuficiência mitral associada é apenas discreta — o melhor cenário entre as opções para VMCB.

Por que as outras alternativas estão incorretas:
• A) A presença de insuficiência mitral MODERADA associada contraindica a VMCB, independentemente do escore de Wilkins.
• B) O escore de Wilkins de 11, com componentes de calcificação e subvalvar elevados (3 cada), indica anatomia mais desfavorável, com menor probabilidade de sucesso e maior risco de complicações.
• D) O escore de Wilkins de 12 (com todos os componentes em grau 3) representa anatomia muito desfavorável, além de insuficiência mitral moderada associada — dupla contraindicação.
• E) A etiologia DEGENERATIVA (calcificação do aparato valvar) não responde à VMCB, cujo mecanismo de ação depende da fusão comissural reumática.'),

('de290ebf-6718-4b90-939e-1d0917bacbe9', 'Válvula', 2019, 'TEC', 'Mulher, 26 anos, apresenta quadro de dispneia ao esforço. No exame físico, apresenta-se taquicárdica (frequência cardíaca [FC] = 113 bpm), ritmo cardíaco irregular, sopro diastólico em foco mitral e crepitações bibasais. Assinale a alternativa correta:', 'A área valvar mitral é o parâmetro mais adequado para avaliar a gravidade da obstrução, pois, diferente do gradiente transvalvar (que depende do fluxo/débito cardíaco), é relativamente independente das condições hemodinâmicas do momento — alternativa E.', 'Na estenose mitral, a área valvar é considerada o descritor mais robusto de gravidade da obstrução, pois o gradiente transvalvar é dependente do fluxo (débito cardíaco e frequência cardíaca) — em situações de taquicardia ou fibrilação atrial (como no caso desta paciente), o gradiente pode estar artificialmente alterado, tornando a área valvar a medida mais confiável — alternativa E.

Por que as outras alternativas estão incorretas:
• A) O gradiente diastólico é dependente das condições de fluxo (FC, débito), sendo menos preciso que a área valvar para classificar gravidade.
• B) O reforço pré-sistólico depende da contração atrial coordenada; na fibrilação atrial (independentemente da faixa de FC ventricular) esse componente NÃO está presente, pois não há sístole atrial efetiva.
• C) A profilaxia para endocardite infecciosa não é mais recomendada rotineiramente para todos os casos de estenose mitral reumática isolada, apenas em situações específicas de alto risco.
• D) Betabloqueadores NÃO são contraindicados na estenose mitral — são úteis por reduzir a FC e aumentar o tempo de enchimento diastólico.'),

('557bc933-5c38-4591-b74e-6857dc628349', 'Válvula', 2020, 'TEC', 'Mulher, 39 anos, com quadro de dispneia progressiva há nove meses. Ao exame físico, nota-se sopro diastólico tipo ruflar em foco mitral, e a radiografia de tórax mostra elevação do brônquio-fonte esquerdo (sinal da bailarina). Considerando-se este caso clínico, quais são as opções corretas?
I- A provável valvopatia é insuficiência mitral.
II- A principal etiologia dessa valvopatia do caso clínico é reumática.
III- O tratamento preconizado é implante de prótese transcateter.
IV- A valvoplastia percutânea com balão é a primeira opção na ausência de contraindicação.', 'O sopro em ruflar diastólico e o sinal da bailarina (átrio esquerdo aumentado comprimindo o brônquio-fonte esquerdo) são clássicos de ESTENOSE mitral (não insuficiência), de etiologia reumática, cujo tratamento de escolha é a valvoplastia percutânea por balão — apenas II e IV corretas — alternativa A.', 'O ruflar diastólico em foco mitral associado ao "sinal da bailarina" (elevação/compressão do brônquio-fonte esquerdo pelo átrio esquerdo dilatado) é achado clássico de ESTENOSE mitral, não de insuficiência mitral — tornando a assertiva I incorreta. A etiologia reumática é a mais provável nesse perfil (mulher jovem, assertiva II correta). O tratamento de escolha para estenose mitral reumática sintomática com anatomia favorável é a valvoplastia percutânea por balão (assertiva IV correta), não o implante de prótese transcateter (assertiva III incorreta, que não é opção estabelecida para estenose mitral). Portanto, apenas II e IV estão corretas — alternativa A.'),

('cd6de338-6739-479e-af87-c6bdb23a415d', 'Válvula', 2020, 'TEC', 'Em relação à estenose aórtica, qual é a alternativa INCORRETA?', 'O teste ergométrico é CONTRAINDICADO (não indicado) em pacientes SINTOMÁTICOS com estenose aórtica grave, pelo risco de síncope/morte durante o esforço; ele é utilizado, isso sim, para desmascarar sintomas em pacientes aparentemente ASSINTOMÁTICOS — alternativa A é a incorreta.', 'O teste ergométrico tem papel bem estabelecido na estenose aórtica grave APARENTEMENTE assintomática, para desmascarar sintomas ocultos e estratificar risco — mas é CONTRAINDICADO em pacientes já SINTOMÁTICOS, pelo risco de eventos graves (síncope, arritmias, morte) durante o esforço. A alternativa A inverte esse conceito, sendo a afirmação INCORRETA (gabarito).

Por que as outras alternativas estão corretas (não são o gabarito):
• B) A ecocardiografia de estresse com dobutamina é, de fato, indicada no cenário de baixo fluxo/baixo gradiente com FE reduzida (gradiente médio <40 mmHg, AVA <1,0 cm², FE <50%).
• C) Escores de cálcio acima de 1.650 UA (aproximadamente) reforçam a probabilidade de estenose aórtica grave, sendo uma ferramenta complementar reconhecida.
• D) A valvuloplastia por balão isolada é, de fato, indicada como ponte terapêutica em pacientes instáveis sem condições momentâneas de TAVI/cirurgia definitiva.
• E) Essa é a definição clássica de estenose aórtica grave "paradoxal" (baixo fluxo, baixo gradiente, FE preservada).'),

('b70f4aef-c571-49f4-bf39-8ad4ea08ce28', 'Válvula', 2021, 'TEC', 'Um paciente de 80 anos, com queixa de tonturas e dor torácica, apresentava ao exame físico um sopro sistólico ejetivo, com pico telessistólico, mais bem audível na borda esternal direita alta e região cervical. Eletrocardiograma revelava sinais de sobrecarga ventricular esquerda (VE). Ecocardiograma = VE com hipertrofia concêntrica, fração de ejeção do VE = 65% e disfunção diastólica grau 3. Obteve-se gradiente sistólico máximo entre o VE e a aorta de 50 mmHg, médio de 25 mmHg e área valvar aórtica de 0,9 cm², além de calcificação do anel mitral, com refluxo mitral moderado, com orifício de refluxo estimado em 0,2 cm² e volume regurgitante de 35 mL. Diante desses dados, o melhor exame a ser solicitado na sequência, para prosseguir com a investigação, seria:', 'Há discordância entre a área valvar (0,9 cm², sugerindo estenose importante) e o gradiente médio (25 mmHg, sugerindo apenas moderada), com FE preservada — situação clássica em que o escore de cálcio da valva aórtica por tomografia ajuda a resolver a discordância e confirmar (ou não) a gravidade — alternativa B.', 'Este caso ilustra uma discordância clássica entre os parâmetros ecocardiográficos: a área valvar aórtica (0,9 cm²) sugere estenose importante, mas o gradiente médio (25 mmHg) é de magnitude apenas moderada, com fração de ejeção preservada (65%). Nessas situações de discordância com fluxo preservado, o escore de cálcio da valva aórtica pela tomografia computadorizada é a ferramenta recomendada para confirmar (ou afastar) a gravidade anatômica da estenose — alternativa B.

Por que as outras alternativas estão incorretas:
• A) O ecocardiograma de estresse com exercício físico é reservado principalmente para pacientes com baixo fluxo/baixo gradiente e FE REDUZIDA, ou para desmascarar sintomas em assintomáticos — não é a ferramenta de escolha para essa discordância com FE preservada.
• C) A ressonância cardíaca não é o método padrão para essa dúvida específica (gravidade da estenose aórtica); a insuficiência mitral moderada descrita não é o foco da investigação neste momento.
• D) A discordância entre área e gradiente exige, sim, investigação adicional antes de definir a conduta — não há dados suficientes ainda.
• E) O teste cardiopulmonar avalia capacidade funcional/sintomas, não esclarece a discordância anatômica entre área valvar e gradiente.'),

('f2320d11-6e57-4eef-9035-277724b04b82', 'Válvula', 2019, 'TEC', 'Durante anos, o acometimento da valva tricúspide foi negligenciado e não chamava a atenção dos cardiologistas e cirurgiões cardíacos. Recentemente a avaliação e a conduta sobre essa valvopatia vêm mudando. Assinale a alternativa correta:', 'A insuficiência tricúspide pode, de fato, ser encontrada na síndrome carcinoide, que causa deposição de tecido fibroso nas valvas do coração direito — alternativa A.', 'A síndrome carcinoide (tumores neuroendócrinos secretores de serotonina) provoca deposição de tecido fibroso no endocárdio das cúspides valvares e câmaras cardíacas direitas, resultando tipicamente em insuficiência (e por vezes estenose) tricúspide e/ou pulmonar — alternativa A.

Por que as outras alternativas estão incorretas:
• B) O acometimento reumático da valva tricúspide é uma causa PRIMÁRIA (orgânica) de doença tricúspide, não secundária/funcional.
• C) A recomendação atual é abordar a insuficiência tricúspide importante concomitantemente à cirurgia valvar esquerda quando indicada, não deixá-la sem tratamento no mesmo tempo cirúrgico.
• D) Na insuficiência tricúspide funcional, prefere-se o REPARO (anuloplastia), não a troca por prótese, sempre que a anatomia permitir.
• E) No sinal de Rivero-Carvallo, o sopro tricúspide AUMENTA (não diminui) durante a inspiração profunda.'),

('f828c565-5f7a-46e6-8a67-fc0b0d5f9afa', 'Válvula', 2018, 'TEC', 'Paciente do sexo feminino, com 32 anos e gestação tópica de 12 semanas, com antecedente de valvuloplastia mitral por cateter-balão realizada há cerca de 2 anos com sucesso. Vem com quadro de cansaço e fadiga há 1 mês. Nega antecedentes. Em uso de penicilina benzatina, furosemida 20 mg e atenolol 25 mg. Ao exame, apresenta-se em bom estado geral, frequência cardíaca (FC) = 58bpm; pressão arterial (PA) = 122 x 78 mmHg; eupneica; com ausculta cardíaca revelando sopro em ruflar, com estalido de abertura e B1 hiperfonética, e aumento da intensidade do sopro à manobra de Rivero-Carvallo. Apresenta também estase jugular, edema de membros inferiores ++ e hepatomegalia. Ausculta pulmonar sem alterações. Assinale a alternativa CORRETA:', 'O aumento do sopro com Rivero-Carvallo (manobra específica para sopros do coração DIREITO) associado a sinais de insuficiência cardíaca direita (estase jugular, hepatomegalia, edema) aponta para estenose TRICÚSPIDE, não recidiva mitral — alternativa C.', 'A manobra de Rivero-Carvallo (aumento do sopro com a inspiração profunda) é específica para sopros de origem no coração DIREITO — nesta paciente, o sopro em ruflar com estalido de abertura que aumenta com essa manobra, associado a sinais floridos de insuficiência cardíaca direita (estase jugular, hepatomegalia, edema), aponta para estenose TRICÚSPIDE (possivelmente reumática, dado o contexto), e não para reestenose mitral — devendo ser avaliada para valvuloplastia tricúspide por cateter-balão — alternativa C.

Por que as outras alternativas estão incorretas:
• A, B e D) Assumem reestenose mitral, mas os achados descritos (Rivero-Carvallo positivo, sinais de congestão sistêmica exuberante sem congestão pulmonar) apontam para a valva TRICÚSPIDE, não a mitral.
• E) Embora aponte corretamente para a valva tricúspide, sugere troca cirúrgica em vez do tratamento percutâneo (valvuloplastia por balão), que é a opção preferencial quando aplicável, especialmente em uma gestante.'),

('ce270827-454c-4b34-a81c-7aa1c134710e', 'Válvula', 2018, 'TEC', 'Paciente do sexo masculino, com 71 anos e quadro de cansaço ao subir ladeira há 3 meses. Negava outros sintomas. Antecedente pessoal: dislipidemia, em uso de atorvastatina 20 mg por dia; negava tabagismo, etilismo e outros antecedentes. Ao exame: bom estado geral; frequência cardíaca (FC) = 62 bpm; pressão arterial (PA) = 122 x 66 mmHg; eupneico; ausculta de ritmo cardíaco regular; com B1 hipofonética e sopro sistólico ejetivo +++ em foco aórtico, com pico telessistólico e irradiação para pescoço. Não apresentava outras alterações ao exame clínico. Radiografia de tórax demonstrava silhueta cardíaca normal e eletrocardiograma com bloqueio de ramo esquerdo. Ecocardiograma transtorácico: septo = 11 mm, parede posterior = 11 mm, ventrículo esquerdo de 59 x 40 mm, fração de ejeção = 29%, área valvar aórtica = 0,9 cm², gradiente médio VE-AO = 30 mmHg; pressão sistólica da artéria pulmonar (PSAP) = 48 mmHg. Qual exame deve ser solicitado complementarmente para definição da gravidade anatômica da valvopatia e definição terapêutica?', 'Trata-se de estenose aórtica com baixo fluxo/baixo gradiente e FE reduzida (29%) — o ecocardiograma com estresse com dobutamina é o exame indicado para diferenciar estenose verdadeiramente grave de pseudoestenose e avaliar reserva contrátil — alternativa A.', 'O quadro é de estenose aórtica de baixo fluxo/baixo gradiente com fração de ejeção reduzida (FE 29%, AVA 0,9 cm², gradiente médio 30 mmHg — abaixo de 40 mmHg). Nesse cenário clássico, o ecocardiograma com estresse com baixas doses de dobutamina é o exame indicado para diferenciar estenose verdadeiramente grave (área permanece pequena mesmo com aumento do fluxo) de pseudoestenose (área aumenta significativamente com o fluxo), além de avaliar a reserva contrátil miocárdica — alternativa A.

Por que as outras alternativas estão incorretas:
• B) O ecocardiograma transesofágico não é o exame indicado para essa dúvida específica de baixo fluxo/baixo gradiente.
• C) O cateterismo cardíaco é reservado para quando o ecocardiograma de estresse é inconclusivo ou há discordância adicional, não como primeiro exame complementar.
• D) O teste ergométrico é contraindicado em pacientes já sintomáticos com estenose aórtica grave (ou suspeita).
• E) Os dados ecocardiográficos são discordantes (baixo gradiente com área sugerindo importante) e a FE está reduzida — são insuficientes para definir gravidade/conduta sem o teste de reserva contrátil.'),

('7e23ceaf-13cb-4187-8d90-f1d74160bfe9', 'Válvula', 2019, 'TEC', 'Homem, 62 anos, com quadro de dispneia New York Heart Association (NYHA) classe funcional (CF) III há 6 meses. Hipertenso e dislipidêmico, em uso de losartana 50 mg/dia, hidroclorotiazida 25 mg/dia e sinvastatina 20 mg/dia. Frequência cardíaca (FC) = 68 bpm; pressão arterial (PA) = 120 x 76 mmHg; tempo de enchimento capilar 2,5 seg; ausculta cardíaca com ritmo regular, hipofonese de B1 e B2, sopro sistólico ejetivo com pico telessistólico; ausculta pulmonar normal; pulso arterial sem alterações; radiografia de tórax com discreto aumento da silhueta cardíaca e eletrocardiograma com sinais de sobrecarga de câmaras esquerdas. Ecocardiograma transtorácico: fração de ejeção 35%, volume ejetado (stroke volume) 34 mL/m2, área valvar aórtica 0,9 cm2, gradiente transaórtico médio 30 mmHg, calcificação aórtica importante, sem alterações de mobilidade segmentar do ventrículo esquerdo e sem alterações nas outras válvulas. Realizada infusão de dobutamina durante o exame e, na dose de 15 mcg/kg/min, os achados foram: fração de ejeção 40%, volume ejetado 44 mL/m2, área valvar aórtica 1,0 cm2, gradiente transaórtico médio 41 mmHg, sem alterações de mobilidade segmentar do ventrículo esquerdo. Em relação ao caso clínico, assinale a alternativa correta:', 'O teste com dobutamina mostrou reserva contrátil (aumento >20% do volume ejetado) com elevação do gradiente médio para 41 mmHg (≥40) mantendo a área ao redor de 1,0 cm² — padrão compatível com estenose aórtica verdadeiramente grave com reserva contrátil presente, indicando intervenção valvar aórtica — alternativa D.', 'O teste de estresse com dobutamina demonstrou reserva contrátil miocárdica presente (aumento do volume ejetado de 34 para 44 mL/m², um incremento de aproximadamente 29%, acima do limiar de 20% que define "reserva contrátil"). Com o aumento do fluxo, o gradiente médio subiu para 41 mmHg (atingindo o limiar de gravidade ≥40 mmHg) enquanto a área valvar permaneceu ao redor de 1,0 cm², sem grande incremento proporcional ao fluxo — esse padrão confirma estenose aórtica VERDADEIRAMENTE grave (não pseudoestenose) com reserva contrátil, indicando intervenção valvar aórtica — alternativa D.

Por que as outras alternativas estão incorretas:
• A) A reserva contrátil está PRESENTE neste caso (aumento >20% do volume ejetado); mesmo quando ausente, a ausência de reserva não contraindica formalmente a cirurgia, apenas eleva o risco.
• B) O teste avalia a valva aórtica e a reserva miocárdica, não tem como objetivo diagnosticar isquemia coronariana.
• C) A dose de 15 mcg/kg/min já é suficiente para uma resposta interpretável quando a frequência cardíaca-alvo ou os critérios de gravidade já foram atingidos, não sendo necessário atingir a dose máxima para considerar o teste válido.
• E) Como a estenose já se confirmou grave com reserva contrátil presente pelo eco de estresse, não há necessidade adicional do escore de cálcio para definir a gravidade.'),

('067e08b7-6d35-4d34-a4a7-573877ac7699', 'Válvula', 2022, 'TEC', 'Paciente do sexo masculino, de 50 anos de idade, assintomático, com diagnóstico de insuficiência aórtica importante. Seu ecocardiograma apresenta: fração de ejeção do VE = 58%; diâmetros do VE = 65 mm (diastólico final) e 42 mm (sistólico final); diâmetro sistólico final indexado para a superfície corporal = 23 mm/m². A etiologia da valvopatia foi definida como reumática. Diante desses dados, assinale a alternativa mais adequada:', 'Nenhum critério de indicação cirúrgica foi atingido (FE 58% preservada, DSVE 42 mm <50 mm, DSVEi 23 mm/m² <25 mm/m²) — a conduta é seguimento clínico e ecocardiográfico semestral — alternativa D.', 'Apesar da etiologia reumática e da classificação como "importante", nenhum dos critérios validados de indicação cirúrgica na insuficiência aórtica assintomática foi atingido neste paciente: a FEVE está preservada (58%, acima do limiar de 50-55%), o DSVE está em 42 mm (abaixo de 50 mm) e o DSVE indexado está em 23 mm/m² (abaixo de 25 mm/m²). Assim, a conduta apropriada é o acompanhamento clínico e ecocardiográfico com reavaliações semestrais — alternativa D.

Por que as outras alternativas estão incorretas:
• A) A FEVE de 58% está preservada (acima do limiar de disfunção), e a etiologia reumática isoladamente não é indicação cirúrgica na ausência de outros complicadores.
• B) Não há complicadores presentes na ecocardiografia (todos os parâmetros estão dentro da faixa segura) que justifiquem intervenção independentemente da etiologia.
• C) O TAVI não é a modalidade indicada para insuficiência aórtica isolada nesta faixa etária/perfil, e tampouco há indicação de intervenção neste momento.
• E) O teste de esforço para avaliar classe funcional NÃO é contraindicado — pelo contrário, pode ser útil em pacientes assintomáticos para desmascarar limitação funcional, e o DSVEi atual não atingiu o limiar de indicação cirúrgica.'),

('48653ae6-2fab-435e-a0f7-0cf70d8adc7e', 'Válvula', 2019, 'TEC', 'Homem, 42 anos, história de febre reumática na infância, tem no exame físico um sopro diastólico aspirativo em decrescendo no foco aórtico com primeira bulha hipofonética. Pressão arterial (PA) medida no membro superior esquerdo de 140 x 30 mmHg. Assinale a alternativa correta:', 'A pressão arterial divergente (140x30 mmHg) confirma insuficiência aórtica importante; esses pacientes podem apresentar angina noturna e diaforese, relacionadas à queda da pressão diastólica e à redução da perfusão coronariana durante o sono (quando a frequência cardíaca cai ainda mais) — alternativa A.', 'A pressão arterial marcadamente divergente (140x30 mmHg, pressão de pulso muito ampla) confirma insuficiência aórtica importante. Nesse contexto, é clássica a queixa de angina noturna e diaforese, decorrente da queda ainda maior da pressão arterial diastólica (e, portanto, da pressão de perfusão coronariana) durante o sono, quando a frequência cardíaca reduz e o tempo de diástole se prolonga — alternativa A.

Por que as outras alternativas estão incorretas:
• B) O pulso em martelo d''água (pulso de Corrigan, de ascensão rápida e colapso rápido) é chamado de Sinal de CORRIGAN, não Sinal de Musset (que se refere ao balanço da cabeça a cada batimento cardíaco).
• C) A insuficiência aórtica crônica evolui classicamente com hipertrofia ventricular EXCÊNTRICA (sobrecarga de volume), não concêntrica (que é típica da sobrecarga de pressão, como na estenose aórtica).
• D) Diante de sintomas como dispneia ao esforço, o tratamento cirúrgico JÁ está indicado, independentemente de otimização clínica prévia — sintomas por si só já são critério de intervenção na IAo importante.
• E) A queda da FEVE é indicação de cirurgia com limiar de FE < 50% (não apenas abaixo de 40%) na insuficiência aórtica importante.'),

('1dfc8cf0-7695-4aa6-a26e-69305e182ccd', 'Válvula', 2021, 'TEC', 'Em relação à insuficiência aórtica (IAo) importante de etiologia reumática no indivíduo assintomático, qual fator complicador pode indicar necessidade de intervenção cirúrgica?', 'O diâmetro diastólico final do ventrículo esquerdo > 75 mm é reconhecido como fator complicador que reforça a indicação cirúrgica mesmo em pacientes assintomáticos com IAo importante — alternativa D.', 'Na insuficiência aórtica importante assintomática, além dos critérios "padrão" de indicação cirúrgica (FEVE ≤ 50-55%, DSVE ≥ 50 mm ou DDVE ≥ 70 mm), o diâmetro diastólico final do VE > 75 mm é considerado um fator complicador adicional que reforça fortemente a indicação de intervenção, mesmo sem sintomas — alternativa D.

Por que as outras alternativas estão incorretas:
• A) FEVE > 50% é, na verdade, um parâmetro de NORMALIDADE (ausência de disfunção), não um complicador.
• B) DSVE < 55 mm está, na verdade, dentro (ou próximo) da faixa aceitável, não configurando complicador (o limiar de risco é DSVE ≥ 50 mm, ou seja, um valor MAIOR, não menor, que preocupa).
• C) DDVE > 70 mm já é o limiar "padrão" de indicação cirúrgica, mas a alternativa correta busca o valor mais específico apontado no gabarito (> 75 mm) como fator complicador adicional.
• E) DSVE > 50 mm já é limiar padrão de indicação isolada, mas a resposta correta desta questão está no critério do diâmetro diastólico > 75 mm.'),

('9588947b-aaa6-443b-843d-aab5b2765735', 'Válvula', 2022, 'TEC', 'Paciente do sexo masculino, de 63 anos de idade, hipertenso, assintomático, em uso de atual de losartana 50 mg, 2x/dia, e hidroclorotiazida 25 mg/dia. Ao exame físico: frequência cardíaca = 70 bpm, pressão arterial = 120x70 mmHg, ausculta cardíaca com ritmo cardíaco regular, B1 hipofonética, sopro sistólico ejetivo com pico telessistólico, com irradiação para carótidas. Ausculta pulmonar e restante do exame físico sem alterações. Eletrocardiograma a seguir:
Ecocardiograma transtorácico: Seio aórtico = 29 mm; átrio esquerdo = 47 mm; diâmetro diastólico do ventrículo esquerdo (VE) = 57 mm; diâmetro sistólico do VE = 46 mm; fração de ejeção do VE = 36%; índice de massa do VE = 143 g/m²; VE apresenta hipertrofia excêntrica e função diastólica diminuída às custas de hipocinesia difusa; valva mitral: espessamento importante de suas cúspides com tracionamento apical destas e insuficiência de grau moderado; valva aórtica: apresenta sinais de fibrocalcificação importante com redução da mobilidade de seus folhetos. Área valvar estimada pela equação de continuidade em 0,9 cm². Gradiente sistólico máximo VE — ao estimado em 46 mmHg e médio em 30 mmHg.
Qual o diagnóstico do paciente?', 'FE reduzida (36%), AVA 0,9 cm² (importante) com gradiente médio baixo (30 mmHg) — padrão de baixo fluxo/baixo gradiente com FE reduzida (estágio D2), exigindo eco de estresse com dobutamina para confirmar a gravidade — alternativa A.', 'O paciente apresenta estenose aórtica com fração de ejeção reduzida (36%) e padrão de baixo fluxo/baixo gradiente (área 0,9 cm², gradiente médio 30 mmHg, abaixo de 40 mmHg) — configurando o estágio D2 da estenose aórtica grave (baixo fluxo, baixo gradiente, FE reduzida). Nesse cenário, o ecocardiograma de estresse com dobutamina é indicado para diferenciar estenose verdadeiramente grave de pseudoestenose e avaliar reserva contrátil — alternativa A.

Por que as outras alternativas estão incorretas:
• B) O estágio D3 corresponde ao padrão paradoxal com FE PRESERVADA (não reduzida como neste caso), e o ecocardiograma transesofágico não é o método indicado para essa dúvida.
• C) O estágio D1 corresponde ao padrão clássico de alto gradiente (≥40 mmHg); este caso tem gradiente médio de 30 mmHg (baixo), sendo compatível com D2, não D1.
• D) O escore de cálcio é útil principalmente quando a FE está preservada e há discordância de parâmetros; aqui, com FE reduzida, o eco de estresse com dobutamina é o exame mais apropriado.
• E) A descrição do estágio D3 (paradoxal) não se aplica, pois a FE está reduzida (36%), não preservada.'),

('35f75420-e245-4fa2-835d-88e29904f266', 'Válvula', 2022, 'TEC', 'Paciente do sexo masculino, de 45 anos de idade, assintomático, traz ecocardiograma transtorácico demonstrando valva aórtica bicúspide, área valvar aórtica de 1,3 cm² e gradiente médio do ventrículo esquerdo/aorta de 34 mmHg. Fração de ejeção de ventrículo esquerdo de 55%. Eletrocardiograma com ritmo sinusal. Qual é a classificação e o manejo corretos?', 'Trata-se de estenose aórtica MODERADA (área 1,3 cm², gradiente médio 34 mmHg); nesse grau, a intervenção cirúrgica só é indicada se o paciente for submetido a outra cirurgia cardiovascular concomitante — alternativa C.', 'Com área valvar de 1,3 cm² e gradiente médio de 34 mmHg, o paciente apresenta estenose aórtica de grau MODERADO (não discreta nem grave). Na estenose aórtica moderada, assintomática e isolada, a conduta habitual é o acompanhamento clínico; a intervenção cirúrgica valvar aórtica só é considerada quando o paciente for submetido a outro procedimento cardiovascular concomitante (por exemplo, revascularização miocárdica ou cirurgia de aorta/outra valva) — alternativa C.

Por que as outras alternativas estão incorretas:
• A) A gravidade descrita é MODERADA, não discreta; além disso, a reavaliação a cada 3 anos é mais compatível com estenose aórtica discreta/leve, não moderada (que exige seguimento mais próximo, geralmente anual).
• B e E) A classificação de "discreta" não corresponde aos valores apresentados (área 1,3 cm² e gradiente 34 mmHg são compatíveis com grau moderado, não discreto).
• D) Não há "fator complicador" descrito que justifique intervenção isolada nesta estenose aórtica moderada; a indicação isolada de troca valvar não se aplica a este grau de gravidade.'),

('b105a3ef-5c57-429a-aad3-d2b836546cc7', 'Válvula', 2022, 'TEC', 'Paciente do sexo masculino, de 52 anos de idade, hipertenso e tabagista, admitido com quadro de dispneia aos pequenos esforços e dor torácica. Ao exame físico, observam-se sinais de insuficiência aórtica grave. Com relação a esse caso, assinale a alternativa INCORRETA:', 'Na insuficiência aórtica grave, o pulso arterial é tipicamente AMPLO (e não de amplitude reduzida), de ascensão e colapso rápidos ("martelo d''água") — a afirmação de amplitude reduzida está incorreta e é o gabarito — alternativa A.', 'Na insuficiência aórtica grave, o pulso arterial é classicamente amplo (pulso em martelo d''água, de Corrigan), com ascensão rápida e colapso rápido, e não de amplitude reduzida — a alternativa A descreve o oposto do achado esperado, sendo a afirmação INCORRETA (gabarito desta questão).

Por que as outras alternativas estão corretas (não são o gabarito):
• B) O sopro diastólico aspirativo, iniciando-se imediatamente após B2, é a característica clássica da IAo.
• C) O sopro de Austin-Flint decorre do impacto do jato regurgitante aórtico sobre o folheto anterior da valva mitral, criando um componente de estenose mitral funcional.
• D) Valva aórtica bicúspide, Síndrome de Marfan e espondilite anquilosante são etiologias reconhecidas de insuficiência aórtica.
• E) O sinal de Quincke (pulsação do leito ungueal) e o sinal de Müller (pulsação sistólica da úvula) são sinais periféricos clássicos da IAo importante.'),

('25edc204-4f50-4992-8df4-947c54f52fe9', 'Válvula', 2021, 'TEC', 'Em relação a pacientes portadores de insuficiência aórtica (IAo), considere as assertivas a seguir: I. Pacientes com IAo importante assintomáticos e função sistólica do ventrículo esquerdo preservada têm indicação de usar vasodilatadores. II. Pode ocorrer angina que, em geral, é noturna, decorrente da redução da pressão arterial, com consequente piora da perfusão na circulação coronariana. III. Os sinais periféricos na IAo aguda são mais comuns que na IAo crônica. IV. A cirurgia está indicada para pacientes assintomáticos que cursam com disfunção sistólica do ventrículo esquerdo (FE < 50%). Assinale a alternativa correta:', 'Angina noturna por hipoperfusão coronariana (assertiva II) e indicação cirúrgica em assintomáticos com disfunção sistólica FE<50% (assertiva IV) estão corretas; vasodilatadores de rotina não são indicados em assintomáticos com função preservada, e os sinais periféricos são mais exuberantes na forma CRÔNICA (compensada) — alternativa A (II e IV).', 'As assertivas II e IV estão corretas: a angina noturna na IAo decorre da queda ainda maior da pressão diastólica (e da perfusão coronariana) durante o sono; e a disfunção sistólica do VE (FE < 50%), mesmo assintomática, já é indicação cirúrgica estabelecida — alternativa A.

Por que as outras assertivas estão incorretas:
• I) Não há indicação rotineira de vasodilatadores em pacientes assintomáticos com IAo importante e função sistólica preservada (apenas se houver hipertensão associada a ser tratada).
• III) Os sinais periféricos clássicos (pulso em martelo d''água, dança das artérias, sinais de Quincke/Müller/Corrigan) são mais evidentes na IAo CRÔNICA compensada (com grande volume de ejeção e pressão de pulso ampla), sendo frequentemente ausentes ou discretos na IAo AGUDA (sem tempo de adaptação/dilatação compensatória do VE).'),

('c329bc0e-7902-4d56-aa86-1e8eebae14c3', 'Válvula', 2021, 'TEC', 'Mulher, 38 anos, portadora de valvopatia reumática, queixava-se de dispneia progressiva aos esforços, atualmente limitada para esforços habituais. Exame físico: Pressão arterial = 128 x 72 mmHg. Frequência cardíaca = 90 bpm. Sopro sistólico regurgitativo +++/6+ e diastólico em ruflar ++/6+, ambos em foco mitral. Ausculta pulmonar limpa. Edema +/4+ bilateral e simétrico de membros inferiores. Ecocardiograma: Valva mitral com fusão comissural. Área valvar mitral = 1,2 cm2. Gradiente médio AE-VE = 14 mmHg. Insuficiência mitral moderada. Insuficiência tricúspide importante. Pressão sistólica da artéria pulmonar = 42 mmHg. Qual a melhor conduta?', 'Dupla lesão mitral sintomática (estenose importante + insuficiência moderada, que contraindica VMCB) associada a insuficiência tricúspide importante — a conduta é cirurgia da valva mitral associada à abordagem (plastia) da valva tricúspide no mesmo tempo cirúrgico — alternativa E.', 'A paciente apresenta dupla lesão mitral sintomática (estenose importante pela área/gradiente, associada a insuficiência mitral MODERADA, que já contraindica a via percutânea) e insuficiência tricúspide IMPORTANTE associada. Diante de valvopatia mitral com indicação cirúrgica e insuficiência tricúspide relevante, a recomendação é tratar a valva mitral cirurgicamente e abordar (preferencialmente com plastia) a valva tricúspide no mesmo tempo cirúrgico — alternativa E.

Por que as outras alternativas estão incorretas:
• A) A insuficiência mitral moderada associada contraindica a valvoplastia por cateter-balão.
• B) A troca valvar tricúspide por prótese mecânica não é a primeira escolha; prefere-se a plastia (anuloplastia) quando a anatomia permite, reservando a troca para casos não reparáveis.
• C) O seguimento clínico é inadequado diante de sintomas limitantes e dupla valvopatia significativa já estabelecida.
• D) O tratamento cirúrgico apenas da valva mitral, sem abordar a insuficiência tricúspide importante concomitante, deixaria uma valvopatia relevante sem tratamento, contrariando a recomendação atual de abordagem combinada.'),

('e3e8ef24-e8e6-42d2-af3d-26dcac61ad3f', 'Válvula', 2021, 'TEC', 'Sobre pacientes portadores de estenose da valva aórtica anatomicamente importante com fração de ejeção do ventrículo esquerdo preservada, é correto afirmar:', 'Como o volume de ejeção fica relativamente fixo pela obstrução valvar, o aumento do débito cardíaco durante o exercício depende primariamente do aumento da frequência cardíaca (resposta cronotrópica), não do volume sistólico — alternativa A.', 'Na estenose aórtica importante com FE preservada, a obstrução fixa na via de saída do VE limita a capacidade de aumentar significativamente o volume sistólico durante o esforço. Assim, o principal mecanismo para aumentar o débito cardíaco durante o exercício é o aumento da frequência cardíaca (resposta cronotrópica), não do volume ejetado — alternativa A.

Por que as outras alternativas estão incorretas:
• B) Mesmo pacientes considerados assintomáticos frequentemente já apresentam redução sutil da tolerância ao exercício, detectável em testes formais.
• C) O volume de ejeção e a taxa de fluxo transvalvar PODEM se alterar discretamente durante o esforço, embora de forma limitada pela obstrução fixa.
• D) O débito cardíaco de repouso costuma estar preservado em pacientes compensados, não "sempre reduzido".
• E) Não há evidência de que a área valvar aórtica diminua durante o exercício em assintomáticos; a área anatômica é relativamente fixa.');

insert into public.question_options (id, question_id, letra, texto, correta) values

(gen_random_uuid(), '6a89c8e0-450b-4dd6-9285-8200ca27bb3d', 'a', 'A avaliação dos critérios de Wilkins e Block é a melhor maneira de definir a morfologia do aparelho valvar para esta valvopatia. Os pacientes ideais para valvuloplastia mitral por cateter-balão são aqueles que possuem escore ≥ 11.', false),
(gen_random_uuid(), '6a89c8e0-450b-4dd6-9285-8200ca27bb3d', 'b', 'O controle da frequência cardíaca não é o principal objetivo do tratamento, pois as taquicardias geralmente são bem toleradas.', false),
(gen_random_uuid(), '6a89c8e0-450b-4dd6-9285-8200ca27bb3d', 'c', 'A valvuloplastia por balão é indicada para pacientes com esta doença em situações de gravidade moderada à importante que estejam sintomáticos (classe funcional [CF] II-IV), com anatomia valvar favorável.', true),
(gen_random_uuid(), '6a89c8e0-450b-4dd6-9285-8200ca27bb3d', 'd', 'As principais contraindicações à valvuloplastia mitral por cateter balão são a coexistência de insuficiência mitral leve associada, trombo atrial esquerdo, escore ecocardiográfico de Wilkins e Block acima de 11 pontos, outras valvopatias concomitantes que requeiram tratamento cirúrgico.', false),
(gen_random_uuid(), '6a89c8e0-450b-4dd6-9285-8200ca27bb3d', 'e', 'A valvuloplastia mitral por cateter-balão está indicada para pacientes assintomáticos, sem fatores complicadores, como pressão sistólica da artéria pulmonar ≥ 50 mmHg em repouso ou pressão sistólica da artéria pulmonar ≥ 50 mmHg ao esforço, ritmo de fibrilação atrial de início recente, na ausência de contraindicações ao procedimento.', false),

(gen_random_uuid(), 'dfa2280d-3345-4743-a26c-3bc6ec083641', 'a', 'Diâmetro sistólico final do ventrículo esquerdo ≥ 40 mm.', false),
(gen_random_uuid(), 'dfa2280d-3345-4743-a26c-3bc6ec083641', 'b', 'Fração de ejeção do ventrículo esquerdo ≤ 60%.', false),
(gen_random_uuid(), 'dfa2280d-3345-4743-a26c-3bc6ec083641', 'c', 'Diâmetro diastólico final do ventrículo esquerdo ≥ 60 mm.', true),
(gen_random_uuid(), 'dfa2280d-3345-4743-a26c-3bc6ec083641', 'd', 'Volume do átrio esquerdo ≥ 60mL/m2.', false),
(gen_random_uuid(), 'dfa2280d-3345-4743-a26c-3bc6ec083641', 'e', 'Pressão sistólica pulmonar ≥ 60 mmHg ao esforço.', false),

(gen_random_uuid(), 'c108219c-627b-4d41-bf8d-7c07bf8a1456', 'a', 'Estenose mitral importante de etiologia reumática com escore de Wilkins de 8 (aparelho subvalvar 2, calcificação 2, espessamento 2, mobilidade 2) e insuficiência mitral moderada.', false),
(gen_random_uuid(), 'c108219c-627b-4d41-bf8d-7c07bf8a1456', 'b', 'Estenose mitral importante de etiologia reumática com escore de Wilkins de 11 (aparelho subvalvar 3, calcificação 3, espessamento 3, mobilidade 2) e insuficiência mitral discreta.', false),
(gen_random_uuid(), 'c108219c-627b-4d41-bf8d-7c07bf8a1456', 'c', 'Estenose mitral importante de etiologia reumática com escore de Wilkins de 9 (aparelho subvalvar 2, calcificação 2, espessamento 3, mobilidade 2) e insuficiência mitral discreta.', true),
(gen_random_uuid(), 'c108219c-627b-4d41-bf8d-7c07bf8a1456', 'd', 'Estenose mitral importante de etiologia reumática com escore de Wilkins de 12 (aparelho subvalvar 3, calcificação 3, espessamento 3, mobilidade 3) e insuficiência mitral moderada.', false),
(gen_random_uuid(), 'c108219c-627b-4d41-bf8d-7c07bf8a1456', 'e', 'Estenose mitral importante de etiologia degenerativa (calcificação do aparato valvar).', false),

(gen_random_uuid(), 'de290ebf-6718-4b90-939e-1d0917bacbe9', 'a', 'O gradiente diastólico gerado é o parâmetro mais adequado para classificar a gravidade e indicar o tipo de tratamento.', false),
(gen_random_uuid(), 'de290ebf-6718-4b90-939e-1d0917bacbe9', 'b', 'Pacientes com fibrilação atrial de alta resposta não apresentam ausculta de reforço pré-sistólico, mas se a frequência estiver entre 60-70 bpm pode-se ouvir esse reforço.', false),
(gen_random_uuid(), 'de290ebf-6718-4b90-939e-1d0917bacbe9', 'c', 'A profilaxia para endocardite infecciosa é indicada para todos os casos de estenose mitral de etiologia reumática.', false),
(gen_random_uuid(), 'de290ebf-6718-4b90-939e-1d0917bacbe9', 'd', 'Os betabloqueadores estão contraindicados na estenose mitral.', false),
(gen_random_uuid(), 'de290ebf-6718-4b90-939e-1d0917bacbe9', 'e', 'O descritor mais útil da gravidade da obstrução da valva mitral é a área de orifício valvar.', true),

(gen_random_uuid(), '557bc933-5c38-4591-b74e-6857dc628349', 'a', 'apenas II e IV', true),
(gen_random_uuid(), '557bc933-5c38-4591-b74e-6857dc628349', 'b', 'apenas I, II e IV', false),
(gen_random_uuid(), '557bc933-5c38-4591-b74e-6857dc628349', 'c', 'apenas I e III', false),
(gen_random_uuid(), '557bc933-5c38-4591-b74e-6857dc628349', 'd', 'apenas II, III, IV', false),
(gen_random_uuid(), '557bc933-5c38-4591-b74e-6857dc628349', 'e', 'apenas I, II, III', false),

(gen_random_uuid(), 'cd6de338-6739-479e-af87-c6bdb23a415d', 'a', 'o teste ergométrico é indicado para pacientes sintomáticos para avaliar a capacidade funcional', true),
(gen_random_uuid(), 'cd6de338-6739-479e-af87-c6bdb23a415d', 'b', 'a ecocardiografia de estresse está indicada para pacientes que apresentam gradiente sistólico médio VE/Ao menor que 40 mmHg, área valvar aórtica menor que 1,0 cm² e fração de ejeção do ventrículo esquerdo menor que 50%', false),
(gen_random_uuid(), 'cd6de338-6739-479e-af87-c6bdb23a415d', 'c', 'a tomografia para avaliar o escore de cálcio valvar aórtico tem sido uma ferramenta útil, e valores acima de 1.650 UA reforçam a possibilidade de estenose valvar aórtica de grau importante', false),
(gen_random_uuid(), 'cd6de338-6739-479e-af87-c6bdb23a415d', 'd', 'a valvuloplastia por balão é indicada para pacientes sintomáticos com instabilidade hemodinâmica e impossibilidade momentânea de intervenção definitiva (TAVI ou cirurgia convencional)', false),
(gen_random_uuid(), 'cd6de338-6739-479e-af87-c6bdb23a415d', 'e', 'a estenose valvar aórtica grave com baixo fluxo/baixo gradiente paradoxal é definida por volume ejetado do ventrículo esquerdo indexado menor que 35 mL/m², gradiente médio VE/Ao menor que 40 mmHg, área valvar aórtica indexada menor que 0,6 cm²/m² e fração de ejeção do ventrículo esquerdo maior 50%', false),

(gen_random_uuid(), 'b70f4aef-c571-49f4-bf39-8ad4ea08ce28', 'a', 'Ecocardiograma de estresse com exercício físico, para avaliar se realmente a estenose aórtica é grave.', false),
(gen_random_uuid(), 'b70f4aef-c571-49f4-bf39-8ad4ea08ce28', 'b', 'Cálculo do escore de cálcio da valva aórtica, por meio da tomografia, para confirmar a gravidade da estenose aórtica.', true),
(gen_random_uuid(), 'b70f4aef-c571-49f4-bf39-8ad4ea08ce28', 'c', 'Ressonância magnética do coração, para definir melhor a gravidade da insuficiência mitral.', false),
(gen_random_uuid(), 'b70f4aef-c571-49f4-bf39-8ad4ea08ce28', 'd', 'Não há necessidade de mais exames complementares pois o diagnóstico e a conduta já estão definidos.', false),
(gen_random_uuid(), 'b70f4aef-c571-49f4-bf39-8ad4ea08ce28', 'e', 'Teste cardiopulmonar para avaliar o VO2 e a presença de sintomas ao exercício.', false),

(gen_random_uuid(), 'f2320d11-6e57-4eef-9035-277724b04b82', 'a', 'A insuficiência tricúspide pode ser encontrada na síndrome carcinoide.', true),
(gen_random_uuid(), 'f2320d11-6e57-4eef-9035-277724b04b82', 'b', 'O acometimento reumático dos folhetos da valva tricúspide pode causar insuficiência tricúspide secundária ou funcional.', false),
(gen_random_uuid(), 'f2320d11-6e57-4eef-9035-277724b04b82', 'c', 'Pacientes com insuficiência tricúspide importante e que serão submetidos à cirurgia valvar do lado esquerdo do coração não devem ter as duas valvopatias abordadas no mesmo tempo cirúrgico.', false),
(gen_random_uuid(), 'f2320d11-6e57-4eef-9035-277724b04b82', 'd', 'Diante de uma insuficiência tricúspide funcional, o tratamento de escolha é a troca valvar por prótese mecânica.', false),
(gen_random_uuid(), 'f2320d11-6e57-4eef-9035-277724b04b82', 'e', 'Na insuficiência tricúspide, durante a inspiração profunda, o sopro tende a diminuir, sendo esse fenômeno chamado de Rivero Carvallo.', false),

(gen_random_uuid(), 'f828c565-5f7a-46e6-8a67-fc0b0d5f9afa', 'a', 'A paciente apresenta reestenose mitral precoce, devendo ser avaliada para nova valvuloplastia mitral por cateter-balão.', false),
(gen_random_uuid(), 'f828c565-5f7a-46e6-8a67-fc0b0d5f9afa', 'b', 'A paciente apresenta reestenose mitral precoce, devendo ser avaliada para cirurgia de troca valvar por bioprótese.', false),
(gen_random_uuid(), 'f828c565-5f7a-46e6-8a67-fc0b0d5f9afa', 'c', 'A paciente apresenta estenose tricúspide, devendo ser avaliada para valvuloplastia tricúspide por cateter-balão.', true),
(gen_random_uuid(), 'f828c565-5f7a-46e6-8a67-fc0b0d5f9afa', 'd', 'A paciente apresenta reestenose mitral precoce, devendo ser avaliada para cirúrgica de troca valvar por prótese mecânica.', false),
(gen_random_uuid(), 'f828c565-5f7a-46e6-8a67-fc0b0d5f9afa', 'e', 'A paciente apresenta estenose tricúspide, devendo ser avaliada para cirurgia de troca valvar por bioprótese.', false),

(gen_random_uuid(), 'ce270827-454c-4b34-a81c-7aa1c134710e', 'a', 'Ecocardiograma com estresse com dobutamina.', true),
(gen_random_uuid(), 'ce270827-454c-4b34-a81c-7aa1c134710e', 'b', 'Ecocardiograma transesofágico.', false),
(gen_random_uuid(), 'ce270827-454c-4b34-a81c-7aa1c134710e', 'c', 'Estudo hemodinâmico (cateterismo cardíaco).', false),
(gen_random_uuid(), 'ce270827-454c-4b34-a81c-7aa1c134710e', 'd', 'Teste ergométrico.', false),
(gen_random_uuid(), 'ce270827-454c-4b34-a81c-7aa1c134710e', 'e', 'Não há necessidade de novos testes, pois os dados ecocardiográficos apresentados são suficientes.', false),

(gen_random_uuid(), '7e23ceaf-13cb-4187-8d90-f1d74160bfe9', 'a', 'A ausência de reserva contrátil apresentada contraindica a intervenção valvar cirúrgica convencional.', false),
(gen_random_uuid(), '7e23ceaf-13cb-4187-8d90-f1d74160bfe9', 'b', 'Ecocardiograma com estresse com dobutamina foi positivo para isquemia miocárdica.', false),
(gen_random_uuid(), '7e23ceaf-13cb-4187-8d90-f1d74160bfe9', 'c', 'O teste de estresse com dobutamina foi ineficaz, pois não atingiu a dose máxima de infusão do medicamento (20 mcg /kg/min).', false),
(gen_random_uuid(), '7e23ceaf-13cb-4187-8d90-f1d74160bfe9', 'd', 'Paciente apresenta indicação de intervenção valvar aórtica.', true),
(gen_random_uuid(), '7e23ceaf-13cb-4187-8d90-f1d74160bfe9', 'e', 'Tomografia com escore de cálcio valvar deve ser realizada para definição da gravidade anatômica.', false),

(gen_random_uuid(), '067e08b7-6d35-4d34-a4a7-573877ac7699', 'a', 'Esse paciente apresenta indicação de intervenção cirúrgica pela queda na fração de ejeção abaixo de 60% e por ser de etiologia reumática.', false),
(gen_random_uuid(), '067e08b7-6d35-4d34-a4a7-573877ac7699', 'b', 'Independentemente da etiologia da valvopatia, há indicação de intervenção cirúrgica pela presença dos complicadores descritos na ecocardiografia.', false),
(gen_random_uuid(), '067e08b7-6d35-4d34-a4a7-573877ac7699', 'c', 'Diante do quadro e dados ecocardiográficos, paciente apresenta indicação de realização de implante transcateter de bioprótese aórtica (TAVI)', false),
(gen_random_uuid(), '067e08b7-6d35-4d34-a4a7-573877ac7699', 'd', 'Esse paciente pode ser conduzido clinicamente com reavaliações semestrais com consulta clínica e ecocardiografia.', true),
(gen_random_uuid(), '067e08b7-6d35-4d34-a4a7-573877ac7699', 'e', 'A solicitação de teste de esforço para avaliar classe funcional é contraindicada, pois paciente já apresenta indicação de intervenção pela medida ecocardiográfica do diâmetro sistólico final indexado.', false),

(gen_random_uuid(), '48653ae6-2fab-435e-a0f7-0cf70d8adc7e', 'a', 'Paciente pode se queixar de angina noturna e diaforese diante do quadro descrito.', true),
(gen_random_uuid(), '48653ae6-2fab-435e-a0f7-0cf70d8adc7e', 'b', 'A presença de pulso em martelo d''água é chamado Sinal de Musset.', false),
(gen_random_uuid(), '48653ae6-2fab-435e-a0f7-0cf70d8adc7e', 'c', 'De forma geral, esse paciente evolui com hipertrofia ventricular concêntrica.', false),
(gen_random_uuid(), '48653ae6-2fab-435e-a0f7-0cf70d8adc7e', 'd', 'Mesmo diante de sintomas como dispneia ao esforço, o tratamento cirúrgico não está indicado até o tratamento clínico ser otimizado.', false),
(gen_random_uuid(), '48653ae6-2fab-435e-a0f7-0cf70d8adc7e', 'e', 'A presença de queda da fração de ejeção do ventrículo esquerdo é indicação de cirurgia, mas apenas abaixo de 40%.', false),

(gen_random_uuid(), '1dfc8cf0-7695-4aa6-a26e-69305e182ccd', 'a', 'Fração de ejeção do ventrículo esquerdo > 50%.', false),
(gen_random_uuid(), '1dfc8cf0-7695-4aa6-a26e-69305e182ccd', 'b', 'Diâmetro sistólico do ventrículo esquerdo < 55 mm.', false),
(gen_random_uuid(), '1dfc8cf0-7695-4aa6-a26e-69305e182ccd', 'c', 'Diâmetro diastólico do ventrículo esquerdo > 70 mm.', false),
(gen_random_uuid(), '1dfc8cf0-7695-4aa6-a26e-69305e182ccd', 'd', 'Diâmetro diastólico do ventrículo esquerdo > 75 mm.', true),
(gen_random_uuid(), '1dfc8cf0-7695-4aa6-a26e-69305e182ccd', 'e', 'Diâmetro sistólico do ventrículo esquerdo > 50 mm.', false),

(gen_random_uuid(), '9588947b-aaa6-443b-843d-aab5b2765735', 'a', 'Trata-se de estenose aórtica estágio D2 e deve ser solicitado ecocardiograma de estresse com dobutamina para elucidação da gravidade anatômica da valvopatia.', true),
(gen_random_uuid(), '9588947b-aaa6-443b-843d-aab5b2765735', 'b', 'Trata-se de estenose aórtica estágio D3 com disfunção ventricular e o ecocardiograma transesofágico é o melhor método para diagnóstico.', false),
(gen_random_uuid(), '9588947b-aaa6-443b-843d-aab5b2765735', 'c', 'É uma estenose aórtica estágio D1 com baixo gradiente menor que 40 mmHg e disfunção ventricular.', false),
(gen_random_uuid(), '9588947b-aaa6-443b-843d-aab5b2765735', 'd', 'Escore de cálcio é o melhor método para confirmar o diagnóstico.', false),
(gen_random_uuid(), '9588947b-aaa6-443b-843d-aab5b2765735', 'e', 'É uma EAo "paradoxal" de baixo fluxo e baixo gradiente (estágio D3, AVA ≤ 1cm² com velocidade do jato aórtico < 4m/s ou gradiente médio < 40mmHg e fração de ejeção do ventrículo esquerdo menor que 50%).', false),

(gen_random_uuid(), '35f75420-e245-4fa2-835d-88e29904f266', 'a', 'Esse paciente apresenta estenose aórtica moderada. Indicaria reavaliação clínica e ecocardiográfica a cada 3 anos.', false),
(gen_random_uuid(), '35f75420-e245-4fa2-835d-88e29904f266', 'b', 'Esse paciente apresenta estenose aórtica discreta. Caso o paciente apresentasse uma ectasia da aorta torácica ascendente de 4,5 cm, seria indicada aneurismectomia de aorta ascendente isolada nesse momento.', false),
(gen_random_uuid(), '35f75420-e245-4fa2-835d-88e29904f266', 'c', 'Esse paciente apresenta estenose aórtica moderada. Indicaria intervenção cirúrgica valvar aórtica apenas se submetido a outros procedimentos cardiovasculares invasivos (revascularização coronária, aorta ascendente ou outra valva).', true),
(gen_random_uuid(), '35f75420-e245-4fa2-835d-88e29904f266', 'd', 'Esse paciente apresenta estenose aórtica moderada com fator complicador. Indicaria troca valvar aórtica isolada nesse momento.', false),
(gen_random_uuid(), '35f75420-e245-4fa2-835d-88e29904f266', 'e', 'Esse paciente apresenta estenose aórtica discreta. Indicaria reavaliação clínica e ecocardiográfica a cada 3 anos.', false),

(gen_random_uuid(), 'b105a3ef-5c57-429a-aad3-d2b836546cc7', 'a', 'Em alguns casos, encontramos uma pressão arterial divergente e o pulso com amplitude reduzida e duração prolongada.', true),
(gen_random_uuid(), 'b105a3ef-5c57-429a-aad3-d2b836546cc7', 'b', 'A característica é de sopro diastólico, aspirativo e se inicia imediatamente após a segunda bulha.', false),
(gen_random_uuid(), 'b105a3ef-5c57-429a-aad3-d2b836546cc7', 'c', 'Podemos encontrar o sopro de austin-flint, que corresponde ao impacto do jato regurgitante da insuficiência aórtica sobre o folheto anterior da valva mitral.', false),
(gen_random_uuid(), 'b105a3ef-5c57-429a-aad3-d2b836546cc7', 'd', 'Dentre as etiologias de insuficiência aórtica, encontramos valva aórtica bicúspide, Síndrome de Marfan e espondilite anquilosante.', false),
(gen_random_uuid(), 'b105a3ef-5c57-429a-aad3-d2b836546cc7', 'e', 'O sinal de Quincke representa a pulsação visível no leito ungueal, enquanto o sinal de Muller consiste em pulsações sistólicas da úvula.', false),

(gen_random_uuid(), '25edc204-4f50-4992-8df4-947c54f52fe9', 'a', 'As assertivas II e IV estão corretas.', true),
(gen_random_uuid(), '25edc204-4f50-4992-8df4-947c54f52fe9', 'b', 'As assertivas I e IV estão corretas.', false),
(gen_random_uuid(), '25edc204-4f50-4992-8df4-947c54f52fe9', 'c', 'As assertivas II, III e IV estão corretas.', false),
(gen_random_uuid(), '25edc204-4f50-4992-8df4-947c54f52fe9', 'd', 'As assertivas III e IV estão corretas.', false),
(gen_random_uuid(), '25edc204-4f50-4992-8df4-947c54f52fe9', 'e', 'Todas estão corretas.', false),

(gen_random_uuid(), 'c329bc0e-7902-4d56-aa86-1e8eebae14c3', 'a', 'Valvoplastia mitral por cateter-balão.', false),
(gen_random_uuid(), 'c329bc0e-7902-4d56-aa86-1e8eebae14c3', 'b', 'Troca valvar mitral e troca valvar tricúspide por prótese mecânica.', false),
(gen_random_uuid(), 'c329bc0e-7902-4d56-aa86-1e8eebae14c3', 'c', 'Seguimento clínico e ecocardiográfico semestral.', false),
(gen_random_uuid(), 'c329bc0e-7902-4d56-aa86-1e8eebae14c3', 'd', 'Tratamento cirúrgico da valva mitral.', false),
(gen_random_uuid(), 'c329bc0e-7902-4d56-aa86-1e8eebae14c3', 'e', 'Tratamento cirúrgico da valva mitral + plastia da tricúspide.', true),

(gen_random_uuid(), 'e3e8ef24-e8e6-42d2-af3d-26dcac61ad3f', 'a', 'O aumento no débito cardíaco durante o exercício físico é mediado primariamente pelo aumento da frequência cardíaca.', true),
(gen_random_uuid(), 'e3e8ef24-e8e6-42d2-af3d-26dcac61ad3f', 'b', 'Apenas pacientes sintomáticos desenvolvem redução da tolerância ao exercício físico.', false),
(gen_random_uuid(), 'e3e8ef24-e8e6-42d2-af3d-26dcac61ad3f', 'c', 'O volume de ejeção e a taxa de fluxo transvalvar não se alteram durante o esforço físico.', false),
(gen_random_uuid(), 'e3e8ef24-e8e6-42d2-af3d-26dcac61ad3f', 'd', 'Mesmo em repouso, o débito cardíaco encontra-se sempre reduzido.', false),
(gen_random_uuid(), 'e3e8ef24-e8e6-42d2-af3d-26dcac61ad3f', 'e', 'A área valvar aórtica diminui durante o exercício, mesmo em pacientes assintomáticos.', false);

insert into public.questions (id, tema, ano, instituicao, enunciado, comentario, comentario_completo) values

('eb19d3ff-5790-4b12-bcac-5d5dfa2a0bcf', 'Válvula', 2018, 'TEC', 'Paciente do sexo masculino, com 36 anos, comparece à consulta referindo dispneia aos moderados esforços (NYHA CF II). Nega antecedentes e uso de medicações. Ao exame clínico, apresenta pulso amplo, ritmo cardíaco regular, sopro holodiastólico aspirativo +++/6+, melhor audível em foco aórtico acessório e apresenta em foco mitral, B1 hipofonética, ruflar diastólico ++/6+ em foco mitral, ausência de reforço pré-sistólico e ausência de clique de abertura de válvula mitral. Qual o diagnóstico anatômico valvar?', 'A ausência de reforço pré-sistólico e de clique de abertura mitral indica que o ruflar diastólico em foco mitral é o sopro de Austin-Flint (funcional, por impacto do jato de regurgitação aórtica sobre o folheto mitral anterior), não uma estenose mitral orgânica — trata-se de insuficiência aórtica importante isolada — alternativa B.', 'O pulso amplo, o sopro holodiastólico aspirativo em foco aórtico e a B1 hipofonética já sugerem insuficiência aórtica importante. O ruflar diastólico em foco mitral poderia sugerir estenose mitral associada, mas a AUSÊNCIA de reforço pré-sistólico (que depende de contração atrial contra uma valva mitral verdadeiramente estenótica) e a AUSÊNCIA de clique de abertura (que ocorre no achado de fusão comissural reumática) indicam que esse ruflar é, na verdade, o sopro de Austin-Flint — um sopro FUNCIONAL causado pelo impacto do jato regurgitante aórtico sobre o folheto anterior da valva mitral, que mimetiza uma estenose mitral sem que ela exista organicamente. Portanto, o diagnóstico anatômico valvar é insuficiência aórtica importante ISOLADA — alternativa B.

Por que as outras alternativas estão incorretas:
• A) Não há sinais de estenose mitral orgânica (ausência de estalido de abertura e de reforço pré-sistólico).
• C) O quadro predominante é de insuficiência AÓRTICA (pulso amplo, sopro diastólico aspirativo aórtico, B1 hipofonética), não mitral.
• D) Não há evidência de estenose mitral verdadeira associada — o achado mitral é o sopro de Austin-Flint, funcional.
• E) Não há dupla lesão mitral descrita; os achados mitrais são explicados pelo Austin-Flint da insuficiência aórtica isolada.'),

('7567743f-b006-4b5a-8290-797f85fe0cac', 'Válvula', 2019, 'TEC', 'Mulher, 70 anos, apresentou quadro de dispneia progressiva nos últimos seis meses, que evoluiu durante este período para pequenos esforços. Nos últimos dois meses, teve dois episódios de síncope. Ao exame físico, chamava a atenção na ausculta cardíaca um sopro sistólico ejetivo em foco aórtico. O ecocardiograma demonstrou os seguintes parâmetros: ventrículo esquerdo (VE) com dimensões normais, hipertrofia concêntrica importante das suas paredes, fração de ejeção (FE) = 71%, valva aórtica com sinais de calcificação e mobilidade reduzida; velocidade máxima de fluxo aórtico = 5,34 m/s; gradiente médio = 63 mmHg; e área valvular aórtica (AVA) = 0,52 cm². Com relação ao diagnóstico e tratamento de estenose aórtica, qual das alternativas está INCORRETA?', 'O escore de cálcio da valva aórtica é útil justamente para dirimir dúvidas em casos de discordância (por exemplo, baixo fluxo/baixo gradiente); neste caso a gravidade já está claramente estabelecida pelo gradiente médio elevado (63 mmHg) e AVA muito reduzida (0,52 cm²), não sendo necessário indicá-lo "para todos os casos" — alternativa D é a incorreta.', 'Este caso já apresenta critérios inequívocos de estenose aórtica grave por via ecocardiográfica direta: gradiente médio de 63 mmHg (bem acima de 40 mmHg) e área valvar de 0,52 cm² (bem abaixo de 1,0 cm²), com FE preservada — não havendo qualquer discordância a ser resolvida. A tomografia com escore de cálcio é uma ferramenta reservada para dirimir dúvidas em casos discordantes (como baixo fluxo/baixo gradiente), não sendo necessária "para todos os casos", como afirma a alternativa D — que é, portanto, a afirmação INCORRETA (gabarito).

Por que as outras alternativas estão corretas (não são o gabarito):
• A) Esses são, de fato, os fatores complicadores clássicos da estenose aórtica (FE<50%, velocidade>5,0 m/s, gradiente médio>60mmHg, AVA<0,7cm² e hipotensão ao esforço).
• B) A cirurgia é, de fato, indicada em assintomáticos com FE<50% que serão submetidos a outra cirurgia cardiovascular.
• C) A troca cirúrgica é, de fato, a primeira escolha em pacientes de baixo risco (STS<8%).
• E) O TAVI é, de fato, indicado para risco intermediário (STS 4-8%) e é a primeira escolha em risco cirúrgico proibitivo/alto (STS>8% ou EuroSCORE logístico>20%).'),

('97cedf0a-aff9-4a97-ab30-bfc33d1a3b1c', 'Válvula', 2022, 'TEC', 'Para pacientes com estenose aórtica importante sintomática, qual o melhor método terapêutico indicado?', 'Em pacientes de baixo risco cirúrgico e idade avançada (>70 anos), as evidências atuais (estudos de TAVI em baixo risco) mostram equivalência de recomendação entre cirurgia convencional e TAVI — alternativa A.', 'Estudos recentes de TAVI em pacientes de baixo risco cirúrgico (como PARTNER 3 e Evolut Low Risk), conduzidos predominantemente em pacientes mais idosos (geralmente acima de 70 anos), demonstraram resultados não inferiores (e em alguns desfechos até superiores em curto prazo) ao tratamento cirúrgico convencional, estabelecendo grau de recomendação semelhante entre as duas modalidades nesse perfil específico — alternativa A.

Por que as outras alternativas estão incorretas:
• B) No risco cirúrgico intermediário, apesar de o TAVI ser bem estabelecido, a ênfase de equivalência plena entre as modalidades (sem qualificação por idade) não é o conceito mais preciso comparado à alternativa A.
• C) A valvuloplastia por balão isolada NÃO deve ser usada como estratégia para "postergar" a intervenção definitiva com tratamento clínico — é apenas uma ponte temporária em cenários de instabilidade.
• D) Em instabilidade hemodinâmica importante, a ponte terapêutica preferencial é a valvuloplastia por cateter-balão, não o TAVI em caráter de urgência (que exige planejamento pré-procedimento).
• E) O TAVI não é indicado como estratégia puramente paliativa; sua indicação pressupõe expectativa razoável de benefício e sobrevida.'),

('57ce3cc7-7fb9-4917-9c5c-c3a0439a4d20', 'Válvula', 2020, 'TEC', 'Adolescente, 17 anos, portador de febre reumática, relata dispneia aos grandes esforços associada a fortes palpitações. Bom estado geral, eupneico, corado, pressão venosa jugular normal, pulsos bisferiens, pressão arterial = 160 x 40 mmHg. Exame cardiovascular: ictus cordis a nível do sexto espaço intercostal esquerdo, propulsivo e para fora da linha hemiclavicular esquerda. Ritmo cardíaco regular, sopro sistólico e holodiastólico em foco aórtico. O eletrocardiograma mostra ritmo sinusal e sobrecarga ventricular esquerda com alteração de repolarização. Ecocardiograma abaixo. Com relação a este caso, é correto afirmar:', 'O tratamento cirúrgico da insuficiência aórtica reumática importante está indicado quando o DDVE ultrapassa 75 mm OU o DSVE ultrapassa 55 mm com FEVE < 50% — critérios clássicos de indicação em pacientes reumáticos — alternativa D.', 'Nos pacientes com insuficiência aórtica reumática importante, os critérios de indicação cirúrgica incluem o diâmetro diastólico final do VE maior que 75 mm OU o diâmetro sistólico final maior que 55 mm associado à FEVE menor que 50% — alternativa D.

Por que as outras alternativas estão incorretas:
• A) O tratamento cirúrgico NÃO é indicado indiscriminadamente durante a fase AGUDA da doença reumática — idealmente busca-se controlar a atividade inflamatória antes da intervenção definitiva, exceto em cenários de real emergência hemodinâmica.
• B) O implante percutâneo de bioprótese não é a primeira opção de intervenção para um paciente jovem com valvopatia reumática — a abordagem cirúrgica convencional é preferida nesse perfil.
• C) A descrição do quadro clínico (pulsos bisferiens, PA muito divergente, dupla lesão aórtica ao exame) não é compatível com valvopatia de grau leve — não há dados que sustentem essa afirmação de "ausência de sinais importantes".
• E) Vasodilatadores e diuréticos não têm comprovação de retardar a progressão da doença valvar reumática; não substituem a indicação cirúrgica quando os critérios são atingidos.'),

('a84d62d9-874a-465b-b0d4-0c2e8e34291d', 'Válvula', 2021, 'TEC', 'A insuficiência aórtica pode ser classificada como importante pela presença dos seguintes sinais, EXCETO:', 'A piora do sopro com a manobra de Handgrip ocorre em qualquer grau de insuficiência aórtica (pois a manobra aumenta a resistência periférica e, portanto, o refluxo, independentemente da gravidade basal) — não é, por si só, um sinal ESPECÍFICO de gravidade importante, ao contrário dos demais achados listados — alternativa A.', 'A manobra de Handgrip (exercício isométrico) aumenta a resistência vascular periférica e, com isso, acentua a intensidade de qualquer sopro de insuficiência aórtica, independentemente do seu grau de gravidade — não sendo, portanto, um marcador específico de IAo IMPORTANTE (apenas uma manobra de acentuação auscultatória geral). Já os demais achados são especificamente associados à IAo importante — alternativa A é a exceção (gabarito).

Por que as outras alternativas são, de fato, sinais associados à IAo importante (não são o gabarito):
• B) O sopro holodiastólico aspirativo decrescente com B2 hipofonética é achado clássico de IAo importante.
• C) O sopro mesossistólico suave de baixa intensidade (fluxo relativo pelo alto volume ejetado) é comum na IAo importante, mimetizando um componente de "estenose".
• D) O sopro de Austin-Flint (ruflar diastólico mitral funcional) ocorre na IAo importante.
• E) O pulso em martelo d''água é sinal periférico clássico de IAo importante.'),

('53511a15-604a-478a-9da9-c54f8613ecae', 'Válvula', 2019, 'TEC', 'Homem, 82 anos, está sendo examinado no ambulatório de cardiologia com diagnóstico de estenose aórtica. Durante a ausculta cardíaca, apresenta uma extrassístole. Sobre o sopro no batimento seguinte à extrassístole, é correto afirmar:', 'O batimento pós-extrassistólico tem maior enchimento ventricular e maior volume ejetado (potenciação pós-extrassistólica), aumentando o fluxo através da valva aórtica estenótica e, portanto, a intensidade do sopro — alternativa E.', 'Após uma extrassístole, a pausa compensatória permite maior enchimento diastólico do ventrículo esquerdo, resultando em maior volume sistólico no batimento seguinte (potenciação pós-extrassistólica). Como a estenose aórtica é uma obstrução fixa, esse maior volume de fluxo transvalvar aumenta a intensidade do sopro sistólico ejetivo no batimento pós-extrassistólico — alternativa E.

Por que as outras alternativas estão incorretas:
• A) O sopro NÃO se mantém inalterado — ele se intensifica pelo maior volume de fluxo no batimento seguinte.
• B e C) O sopro não reduz nem desaparece; pelo contrário, se intensifica.
• D) O sopro continua sendo sistólico ejetivo (a fisiologia da obstrução não muda o tempo do sopro para diastólico).'),

('9f6c2774-b766-49f2-8b81-37fa81c95ef2', 'Válvula', 2019, 'TEC', 'Homem, 55 anos, refere quadro de cansaço para atividades habituais há três meses. Hipertenso, em uso de hidroclorotiazida 25 mg/dia, captopril 25 mg, três vezes ao dia, e propranolol 20 mg, três vezes ao dia. Ao exame, frequência cardíaca (FC) = 60 bpm, pressão arterial (PA) = 140 x 40 mmHg, tempo de enchimento capilar menor que 3 seg. Pulsos com ascenso rápido e amplitude aumentada. Na ausculta, havia segunda bulha hipofonética, sopro sistólico ejetivo suave de pico sistólico precoce e sopro holodiastólico aspirativo. Ausculta pulmonar com estertores crepitantes esparsos em bases. Angiotomografia de aorta, realizada há 6 meses, evidenciava diâmetro de aorta ascendente de 48 mm. Em relação ao caso descrito, assinale a alternativa INCORRETA:', 'O sopro sistólico ejetivo descrito é suave, de pico precoce — perfil de sopro de FLUXO relativo (pelo alto volume ejetado da insuficiência aórtica), não de uma verdadeira estenose aórtica associada; portanto, afirmar "dupla lesão aórtica com estenose e insuficiência importantes" está incorreto — alternativa A.', 'O sopro sistólico ejetivo descrito (suave, de pico sistólico PRECOCE) tem características de sopro de fluxo relativo, decorrente do alto volume ejetado pela insuficiência aórtica importante — e não de uma verdadeira estenose aórtica associada, que teria pico mais tardio (telessistólico) e maior intensidade. Assim, a afirmação de que há "dupla lesão aórtica com estenose e insuficiência importantes" está INCORRETA (gabarito).

Por que as outras alternativas estão corretas (não são o gabarito):
• B) O propranolol, ao reduzir a FC, prolonga o tempo de diástole e pode, de fato, piorar a sintomatologia na IAo importante (mais tempo para o refluxo).
• C) A angiotomografia mostra a dilatação aórtica, mas não define a etiologia da valvopatia — o ecocardiograma é necessário para essa definição.
• D) A propedêutica clínica (pulso amplo, PA divergente, sopro diastólico aspirativo) já é bastante sugestiva de gravidade, sendo suficiente neste contexto.
• E) Com aorta ascendente de 48 mm e indicação de intervenção valvar, a abordagem concomitante da aorta ascendente é recomendada.'),

('ba4d08be-011f-4924-a7ee-1c1a9ed96cec', 'Válvula', 2018, 'TEC', 'Um paciente de 20 anos, portador de Síndrome de Marfan, tem aneurisma de aorta ascendente com 5,2 cm de diâmetro e insuficiência aórtica moderada. Está assintomático e, pelo ecocardiograma, os diâmetros ventriculares estão discretamente aumentados, estando a função ventricular esquerda preservada. Qual conduta seguir?', 'Na Síndrome de Marfan, o limiar cirúrgico para aneurisma de aorta ascendente é mais baixo (geralmente ≥ 5,0 cm); associado à valva aórtica já doente (IAo moderada), a conduta é a substituição da raiz da aorta por tubo valvado (cirurgia de Bentall) — alternativa E.', 'Na Síndrome de Marfan, o risco de dissecção aórtica é maior para um mesmo diâmetro em comparação à população geral, reduzindo o limiar cirúrgico do aneurisma de aorta ascendente para cerca de 5,0 cm (versus 5,5 cm na população geral). Com aneurisma de 5,2 cm já acima desse limiar e valva aórtica comprometida (IAo moderada), a conduta indicada é a substituição da raiz da aorta por tubo valvado (procedimento de Bentall), tratando simultaneamente o aneurisma e a valvopatia — alternativa E.

Por que as outras alternativas estão incorretas:
• A) Aguardar sintomas é inadequado na Síndrome de Marfan, dado o alto risco de dissecção mesmo em pacientes assintomáticos acima do limiar cirúrgico.
• B) Betabloqueador e reavaliação em 6 meses são condutas de vigilância para aneurismas ABAIXO do limiar cirúrgico, não quando este já foi ultrapassado.
• C) Ressecar apenas a aorta ascendente, sem tratar a raiz/valva doente, deixaria a insuficiência aórtica e a raiz comprometida sem tratamento definitivo.
• D) Endoprótese (tratamento endovascular) não é indicada para aneurisma de raiz/aorta ascendente, especialmente na Síndrome de Marfan, exigindo abordagem cirúrgica aberta.'),

('8f775f34-acb0-425f-ad5e-ac86b6287d61', 'Válvula', 2018, 'TEC', 'Paciente de 80 anos, funcionalmente independente e com cognição normal, tabagista, com enfisema pulmonar, relato de dispneia aos esforços e com dispneia paroxística noturna. Realizou um ecocardiograma que mostrou fração de ejeção do ventrículo esquerdo (FEVE) de 20%, gradiente transvalvar aórtico médio de 18 mmHg e área valvar de 1,0 cm². Realizado ecocardiograma de estresse com dobutamina mostrando aumento de 20% do volume sistólico e com manutenção da área valvar. Foi realizada a estimativa do risco cirúrgico, e o escore STS foi calculado em 14%. Qual das alternativas a seguir é CORRETA?', 'A área valvar permaneceu praticamente fixa mesmo com aumento do fluxo (confirmando estenose verdadeiramente grave, não pseudoestenose); dado o alto risco cirúrgico (STS 14%, idade, enfisema), a melhor opção é o TAVI, que mostra ganho de sobrevida em relação ao tratamento clínico isolado nesse perfil — alternativa A.', 'O ecocardiograma de estresse com dobutamina confirmou estenose aórtica verdadeiramente grave (a área valvar permaneceu praticamente fixa em torno de 1,0 cm² mesmo com o aumento do fluxo, afastando pseudoestenose). Diante do alto risco cirúrgico (STS 14%, idade avançada, enfisema pulmonar), o TAVI é a opção terapêutica que demonstrou benefício de sobrevida em relação ao tratamento clínico isolado nesse perfil de pacientes inoperáveis ou de alto risco — alternativa A.

Por que as outras alternativas estão incorretas:
• B) Ainda que a reserva contrátil esteja no limite (aumento de 20% do volume sistólico), a cirurgia CONVENCIONAL não é a melhor opção dado o alto risco cirúrgico — o TAVI é preferível nesse perfil.
• C) Um STS de 14% é alto, mas não necessariamente proibitivo a ponto de indicar apenas paliação — o TAVI ainda oferece benefício de sobrevida comprovado nesse contexto.
• D) A cirurgia convencional não é a única forma de melhorar o prognóstico; o TAVI é uma alternativa com menor risco e benefício demonstrado em pacientes de alto risco cirúrgico.
• E) A ausência de gradiente elevado (baixo fluxo/baixo gradiente) NÃO descarta a indicação de intervenção — pelo contrário, a confirmação pelo eco de estresse de que a área permanece fixa confirma a gravidade e a indicação.'),

('38d92159-0d88-477c-ae1c-c459fd2c0f03', 'Válvula', 2019, 'TEC', 'As mudanças fisiopatológicas induzidas pela insuficiência aórtica determinam ampla gama de manifestações clínicas e peculiar comportamento evolutivo no curso de anos. Assinale a alternativa correta:', 'A tríade auscultatória clássica da IAo isolada importante inclui o sopro diastólico aspirativo decrescente, um sopro sistólico mesossistólico de fluxo (relativo ao alto volume ejetado) e o sopro de Austin-Flint (ruflar diastólico mitral funcional) — alternativa D.', 'Na insuficiência aórtica isolada importante, a tríade auscultatória clássica inclui: o sopro diastólico aspirativo decrescente (próprio da regurgitação), um sopro sistólico mesossistólico suave de fluxo relativo (pelo grande volume ejetado pelo VE) e o sopro de Austin-Flint — um ruflar diastólico em foco mitral, funcional, causado pelo impacto do jato regurgitante sobre o folheto mitral anterior — alternativa D.

Por que as outras alternativas estão incorretas:
• A) Na IAo importante, a pressão diastólica CAI (não se eleva), sendo essa queda, junto à elevação da sistólica, o que gera a pressão de pulso ampla e o pulso em martelo d''água.
• B) O critério ecocardiográfico de gravidade pela largura do jato ao Doppler colorido é, na maioria das diretrizes, ≥ 65% da via de saída do VE (não apenas > 45%, valor mais compatível com grau moderado).
• C) A fração regurgitante de gravidade é definida como ≥ 50% (não obrigatoriamente > 70%).
• E) Os complicadores clássicos são FEVE ≤ 50-55% (não "abaixo de 60% em VE hiperdinâmico") e DDVE > 70 mm (não 60 mm).'),

('cfb52e2e-6c13-4e70-b1f2-2d1243f610ca', 'Válvula', 2021, 'TEC', 'Homem, 68 anos, apresenta-se com quadro de dor torácica aos esforços e lipotimia. À avaliação: Pressão arterial = 136 x 48 mmHg. Frequência cardíaca = 82 bpm. Sopro sistólico ejetivo +++/6+ e sopro diastólico aspirativo, ambos em foco aórtico ++/6+. Pulmões limpos, sem edema periférico. Ecocardiograma: Fração de ejeção do ventrículo esquerdo = 64%. Valva aórtica bicúspide calcificada. Área valvar aórtica = 0,9 cm². Gradiente médio VE-Ao = 46 mmHg. Insuficiência aórtica moderada. Raiz da aorta = 49 mm. Qual a melhor conduta?', 'Dupla lesão aórtica importante (estenose grave por gradiente médio 46 mmHg + insuficiência moderada), sintomática (angina, lipotimia), com raiz da aorta dilatada (49 mm, valva bicúspide) — indicação de tratamento cirúrgico da valvopatia associado ao tratamento da aorta ascendente — alternativa D.', 'Este paciente apresenta dupla lesão aórtica verdadeira e sintomática (gradiente médio de 46 mmHg confirma estenose grave, associada a insuficiência aórtica moderada), com valva bicúspide e dilatação da raiz da aorta (49 mm) — aortopatia típica da valva bicúspide. Diante da indicação cirúrgica da valvopatia associada à dilatação relevante da raiz aórtica, a conduta correta é o tratamento cirúrgico combinado (valva + aorta ascendente) — alternativa D.

Por que as outras alternativas estão incorretas:
• A) O TAVI não trata a dilatação da raiz da aorta concomitante, sendo insuficiente isoladamente neste caso.
• B) O tratamento cirúrgico apenas da valva, sem abordar a raiz dilatada (49 mm) em uma valva bicúspide, deixaria um risco aórtico relevante sem tratamento.
• C) O paciente já é sintomático (angina, lipotimia) com estenose grave — não há indicação de apenas seguir clinicamente.
• E) O paciente já é sintomático com estenose grave estabelecida; o teste ergométrico é contraindicado nesse cenário.'),

('73e9ec30-0a45-42dd-b63a-efe376c92f34', 'Válvula', 2018, 'TEC', 'Paciente de 35 anos, assintomático. Comparece para consulta de rotina e, ao exame físico, foi notada movimentação da cabeça aos batimentos cardíacos, "dança" das artérias e sopro diastólico aspirativo em foco aórtico. Qual dos achados a seguir levaria à indicação de cirurgia neste paciente?', 'A queda da FEVE abaixo de 50% é um dos critérios clássicos e objetivos de indicação cirúrgica na insuficiência aórtica importante assintomática — alternativa B.', 'Mesmo em pacientes assintomáticos com insuficiência aórtica importante (aqui sugerida pelos sinais periféricos clássicos: sinal de Musset, dança das artérias, sopro diastólico aspirativo), a queda da fração de ejeção do ventrículo esquerdo para valores abaixo de 50% é um critério objetivo e bem estabelecido de indicação cirúrgica — alternativa B.

Por que as outras alternativas estão incorretas:
• A) Sobrecarga de VE ao ECG é um achado esperado na IAo importante, mas não é, isoladamente, critério formal de indicação cirúrgica.
• C) DDVE MENOR que 60 mm está dentro da faixa considerada aceitável, não sendo critério de indicação (o critério é quando o diâmetro está AUMENTADO, acima de 70 mm).
• D) Cardiomegalia na radiografia é um achado inespecífico, não um critério quantitativo formal de indicação cirúrgica.
• E) DSVE MENOR que 50 mm está dentro da faixa aceitável, não sendo critério de indicação (o critério é quando está aumentado, ≥ 50 mm).'),

('c23f8f16-3d32-4595-b7ed-f302ac906006', 'Válvula', 2019, 'TEC', 'Homem, 80 anos, refere ter sopro cardíaco diagnosticado em exame de rotina há 5 anos. Na época, não tinha sintomas cardiológicos significativos. Há dois anos, passou a ter restrição física por dispneia e desconforto precordial aos esforços, e recentemente teve "ameaça de desmaio" ao caminhar em ladeira. Exame físico: sopro sistólico ejetivo na área aórtica e pulso carotídeo parvos et tardus. Eletrocardiograma (ECG): sobrecarga ventricular esquerda e alteração da repolarização ventricular com padrão strain. Ecocardiograma: Ventrículo esquerdo hipertrofiado, com cavidade pequena e fração de ejeção = 60%; disfunção diastólica com padrão restritivo. Valva aórtica calcificada com área valvar estimada em 0,8 cm² e área valvar aórtica indexada (AVAi) = 0,5 cm²/m²; gradiente transvalvar médio = 32 mmHg; volume ejetado indexado = 30 mL/m². Escore de cálcio valvar aórtico = 1.700 UA. Com estes dados clínicos e exames complementares, qual seu diagnóstico?', 'FE preservada (60%) com baixo fluxo (volume ejetado indexado 30 mL/m², abaixo de 35) e baixo gradiente (32 mmHg, abaixo de 40), área valvar reduzida e escore de cálcio muito elevado (1.700 UA) — padrão de estenose aórtica grave "paradoxal" (baixo fluxo/baixo gradiente com FE preservada) — alternativa B.', 'Este é o padrão clássico de estenose aórtica grave "paradoxal": fração de ejeção preservada (60%), mas com baixo fluxo (volume ejetado indexado de 30 mL/m², abaixo do limiar de 35 mL/m²) e baixo gradiente (32 mmHg, abaixo de 40 mmHg) — um cenário em que o ventrículo pequeno e hipertrofiado, com padrão diastólico restritivo, não consegue gerar grande volume de ejeção apesar da função sistólica preservada. O escore de cálcio muito elevado (1.700 UA) confirma a gravidade anatômica da estenose — alternativa B.

Por que as outras alternativas estão incorretas:
• A) A FE está PRESERVADA (60%), não reduzida — portanto não se trata do padrão de baixo fluxo/baixo gradiente com FE reduzida.
• C) O gradiente é BAIXO (32 mmHg), não alto — não é o padrão clássico de alto gradiente.
• D) Os dados (área 0,8 cm², AVAi 0,5 cm²/m², escore de cálcio 1.700 UA) indicam gravidade IMPORTANTE, não moderada.
• E) Não há dados de obstrução dinâmica subaórtica (hipertrófica); a valva aórtica está calcificada com redução de área, caracterizando estenose valvar, não subvalvar.'),

('085236ab-f679-428e-87b1-08cb30b8ecf9', 'Válvula', 2018, 'TEC', 'Paciente de 35 anos, sexo masculino, com diagnóstico de insuficiência aórtica (IAo) importante, está assintomático. Ao ecocardiograma, apresenta diâmetro diastólico final do ventrículo esquerdo (DDVE) = 72 mm e fração de ejeção (FE) = 55%. Qual é a conduta recomendada?', 'O DDVE de 72 mm ultrapassa o limiar clássico de indicação cirúrgica (> 70 mm) na IAo importante assintomática, mesmo com FE ainda preservada (55%) — indicação cirúrgica pelo critério do diâmetro diastólico — alternativa A.', 'Mesmo assintomático e com FEVE ainda preservada (55%, acima do limiar de disfunção), este paciente já ultrapassou o limiar de dilatação ventricular considerado indicação cirúrgica na insuficiência aórtica importante: DDVE > 70 mm (aqui, 72 mm). A indicação, portanto, decorre do critério de diâmetro, não da função — alternativa A.

Por que as outras alternativas estão incorretas:
• B) A FE está preservada (55%), acima do limiar de disfunção (< 50-55%) — não é o critério que motiva a indicação neste caso.
• C) O tratamento medicamentoso isolado não substitui a indicação cirúrgica já estabelecida pelo critério de diâmetro.
• D) O seguimento clínico semestral seria adequado apenas se os critérios de indicação ainda não tivessem sido atingidos — o que não é o caso aqui.
• E) O aparecimento de um sopro em ruflar (Austin-Flint) não é, por si, um critério formal de indicação cirúrgica.'),

('0ffb721d-7e26-4181-b645-a2aa7fcdb1bd', 'Válvula', 2019, 'TEC', 'Em relação à valva aórtica bicúspide, é correto afirmar que:', 'A valva aórtica bicúspide está associada a uma aortopatia própria, com risco aumentado de dilatação da aorta ascendente e de dissecção em comparação à população geral — alternativa D.', 'A valva aórtica bicúspide não é apenas uma anomalia valvar isolada — associa-se a uma verdadeira aortopatia, com alterações estruturais da parede aórtica que predispõem à dilatação progressiva da aorta ascendente e a um risco de dissecção maior do que na população geral com valva tricúspide — alternativa D.

Por que as outras alternativas estão incorretas:
• A) Há, sim, padrão de herança familiar reconhecido em subgrupos de portadores de valva bicúspide (padrão autossômico dominante com penetrância variável em algumas famílias).
• B) O padrão de fusão mais comum é entre as cúspides CORONARIANA DIREITA e CORONARIANA ESQUERDA (não coronariana esquerda e não coronariana).
• C) É uma doença relativamente COMUM (cerca de 1-2% da população) e mais frequente em HOMENS, não rara nem predominante em mulheres.
• E) A troca valvar isolada, sem tratar a aorta ascendente dilatada (≥ 45-50 mm), NÃO é recomendada — a dilatação não regride de forma confiável após a troca valvar isolada.'),

('2ae1b140-d866-4df2-9108-4717caeda8d3', 'Válvula', 2020, 'TEC', 'Mulher, 45 anos, apresenta sintomas inespecíficos, incluindo fadiga. Exame físico: sinais de distensão venosa jugular, presença de B3, sopro pansistólico mais audível no quarto espaço intercostal na região paraesternal. O vídeo abaixo demonstra o exame ecocardiográfico bidimensional em quatro câmaras. Assinale a afirmativa correta:', 'O quadro (distensão jugular, B3, sopro pansistólico paraesternal) é de insuficiência tricúspide grave com dilatação de átrio e ventrículo direitos; a causa mais comum de IT relevante é a forma SECUNDÁRIA (funcional), por dilatação do VD e do anel tricúspide — alternativa B.', 'O quadro clínico descrito (distensão venosa jugular, B3, sopro pansistólico mais audível na área tricúspide) associado ao achado ecocardiográfico de dilatação de átrio e ventrículo direitos é compatível com insuficiência tricúspide grave. Na prática clínica, a causa mais frequente de insuficiência tricúspide relevante é a forma SECUNDÁRIA (funcional), decorrente da dilatação do ventrículo direito e do anel valvar tricúspide (geralmente por hipertensão pulmonar ou doença do coração esquerdo), e não uma doença orgânica primária da valva — alternativa B.

Por que as outras alternativas estão incorretas:
• A) Pelo sinal de Rivero-Carvallo, o sopro tricúspide AUMENTA (não se reduz) durante a inspiração — o oposto do afirmado.
• C) A síndrome carcinoide, apesar de rara, tipicamente acomete MÚLTIPLAS valvas do coração direito simultaneamente (tricúspide e pulmonar), não sendo incomum essa combinação.
• D) Embora a lista de etiologias esteja parcialmente correta, a inclusão de "infarto extenso de ventrículo esquerdo" como causa direta de valvopatia tricúspide é um mecanismo indireto e pouco característico, tornando a afirmação imprecisa em comparação à opção B.
• E) Quando indicada cirurgia na posição tricúspide, prefere-se a BIOPRÓTESE (não a prótese mecânica), devido ao alto risco de trombose de válvula mecânica no sistema de baixa pressão/baixo fluxo do coração direito.'),

('b7c56d39-2332-40ce-9f2f-7102376f8c1a', 'Válvula', 2022, 'TEC', 'Paciente do sexo masculino, de 80 anos de idade, diabético tipo 2, Classe Funcional III da New York Heart Association (CF-NYHA) há 8 meses. Antecedentes: acidente vascular encefálico isquêmico (AVEi) há 5 anos, com sequela motora em membro inferior direito. Em uso de atorvastatina 20 mg/dia; ácido acetilsalicílico (AAS) 100 mg/dia; e insulina NPH 10 UI à noite. Exame físico: pressão arterial 140x80 mmHg; frequência cardíaca = 80 bpm; sem sinais de congestão. Ausculta cardíaca: ritmo regular, sopro sistólico ejetivo melhor audível em foco aórtico 3+/6+, pico telessistólico, com irradiação para foco mitral e fúrcula. Restante do exame físico sem alterações. Eletrocardiograma a seguir. Ecocardiograma transtorácico: átrio esquerdo = 45 mm; septo = 12 mm/parede posterior do ventículo esquerdo = 11 mm; diâmetro sistólico VE = 47 mm; fração de ejeção = 66%; VE: função sistólica preservada e remodelamento concêntrico, sem alterações na contratilidade segmentar da parede; valva aórtica: fibrocalcificação e redução da mobilidade e seus folhetos; gradiente sistólico máximo VE: ao estimado em 75 mmHg e médio em 52 mmHg; área valvar estimada em 0,8 cm2; cineangiocoronariografia: estenose de 70% em terço médio de artéria descendente anterior; EuroSCORE II = 9%.
Com relação a esse caso, assinale a alternativa correta:', 'Estenose aórtica importante sintomática (CF III), com FE preservada e alto gradiente (52 mmHg, não é baixo fluxo/baixo gradiente), em paciente idoso de alto risco cirúrgico (EuroSCORE II 9%, AVE prévio) — a melhor indicação é o implante transcateter de bioprótese aórtica (TAVI) — alternativa D.', 'Este paciente apresenta estenose aórtica importante clássica (gradiente médio 52 mmHg, alto — não se trata de baixo fluxo/baixo gradiente — com FE preservada em 66%), sintomática (CF III), em idade avançada e com risco cirúrgico elevado (EuroSCORE II = 9%, além de sequela neurológica prévia). Nesse perfil, a melhor indicação terapêutica é o implante transcateter de bioprótese aórtica (TAVI), que pode ser associado a angioplastia coronária percutânea para a lesão de descendente anterior — alternativa D.

Por que as outras alternativas estão incorretas:
• A) A cirurgia de troca valvar aberta com revascularização cirúrgica não é a melhor opção dado o alto risco cirúrgico (EuroSCORE II 9%) e a idade avançada — o TAVI (associado a angioplastia percutânea, se necessário) é preferível.
• B) Não há descrição de instabilidade hemodinâmica aguda que justifique valvoplastia como ponte terapêutica; o paciente está estável (sem sinais de congestão).
• C) O escore de cálcio por tomografia não é necessário aqui, pois o gradiente já é elevado (52 mmHg) e a área já é claramente reduzida (0,8 cm²), sem discordância a esclarecer.
• E) O padrão NÃO é de baixo fluxo/baixo gradiente "paradoxal" — o gradiente médio está claramente elevado (52 mmHg, acima de 40 mmHg).'),

('32bebdc1-f262-4c4b-827d-edc97a6e15fa', 'Válvula', 2021, 'TEC', 'Com relação ao uso de anticoagulantes e valvopatia, considere as seguintes assertivas:
I. Em pacientes portadores de prótese mitral mecânica associada à fibrilação atrial, a RNI (Razão Normatizada Internacional) deve ser mantida na faixa de 2,5 e 3,5.
II. Nos portadores de próteses mecânicas, o uso de anticoagulantes orais diretos (inibidores diretos da trombina e fator anti-Xa) pode ser tão seguro e eficaz quanto a varfarina.
III. Os anticoagulantes orais diretos (DOACS) podem ser usados como alternativa para pacientes portadores de estenose mitral grave e fibrilação atrial.
Quais as assertivas estão corretas?', 'Apenas a assertiva I está correta: prótese mitral mecânica + FA exige RNI-alvo mais alto (2,5-3,5). Os DOACs são formalmente CONTRAINDICADOS tanto em próteses mecânicas (maior risco trombótico e hemorrágico comprovado) quanto na estenose mitral reumática com FA — alternativa B.', 'A assertiva I está correta: pacientes com prótese mitral mecânica e fibrilação atrial associada (fator de risco adicional) devem manter RNI na faixa mais alta, entre 2,5 e 3,5. As assertivas II e III estão incorretas: os anticoagulantes orais diretos (DOACs) são formalmente CONTRAINDICADOS em portadores de próteses mecânicas (o estudo RE-ALIGN mostrou mais eventos trombóticos e hemorrágicos com dabigatrana comparado à varfarina nesse contexto) e também não são recomendados na estenose mitral reumática moderada a grave com fibrilação atrial, situação em que a varfarina permanece o anticoagulante de escolha — alternativa B (apenas I).'),

('5de41ae0-253f-44dc-89b9-2bf0c17f8b7d', 'Válvula', 2019, 'TEC', 'Na última década, surgiram diversos novos anticoagulantes, inibidores diretos da trombina ou antifator Xa. No entanto, o uso desse tipo de medicamento pelo paciente portador de valvopatia deve ser indicado com cuidado. Assinale a alternativa correta:', 'O escore CHA2DS2-VASc pode subestimar o risco tromboembólico em pacientes com doença valvar importante (sobretudo estenose mitral), sendo uma limitação reconhecida do escore quando aplicado a essa população — alternativa E.', 'Em portadores de doença valvar cardíaca importante (particularmente estenose mitral reumática), o escore CHA2DS2-VASc — desenvolvido e validado para fibrilação atrial não valvar — pode subestimar o risco tromboembólico real, já que a própria valvopatia constitui um fator de risco adicional não plenamente capturado pelo escore, especialmente nos pacientes com pontuação baixa (≤ 1) — alternativa E.

Por que as outras alternativas estão incorretas:
• A) Os DOACs NÃO estão autorizados na estenose mitral reumática importante — permanecem contraindicados nesse contexto.
• B) Os DOACs não são formalmente contraindicados na estenose aórtica com fibrilação atrial (quando não há prótese mecânica ou estenose mitral relevante associada) — essa combinação específica não configura contraindicação.
• C) Os DOACs NÃO podem ser considerados em portadores de próteses mecânicas mesmo diante de dificuldade de controle do INR — o risco comprovado de eventos trombóticos/hemorrágicos contraindica essa substituição.
• D) A faixa-alvo de INR para prótese mecânica mitral costuma ser mais alta, entre 2,5 e 3,5 (não 2,0-3,0), especialmente na presença de fatores de risco adicionais.'),

('750bc14e-d078-4de7-8589-889595dcd32e', 'Válvula', 2018, 'TEC', 'Assinale a alternativa CORRETA relacionada à microbiologia da endocardite infecciosa (EI):', 'Na EI adquirida na comunidade (valva nativa), os estreptococos do grupo viridans continuam entre os agentes mais comuns, seguidos de perto pelo Staphylococcus aureus — alternativa A.', 'Na endocardite infecciosa adquirida na comunidade em valva nativa, os estreptococos do grupo viridans permanecem entre os agentes etiológicos mais frequentes, seguidos de perto pelo Staphylococcus aureus (cuja importância relativa vem crescendo nas últimas décadas) — alternativa A.

Por que as outras alternativas estão incorretas:
• B) Em usuários de drogas injetáveis, o agente mais frequentemente envolvido é o Staphylococcus aureus, não fungos ou organismos HACEK (que são causas bem mais raras).
• C) A associação clássica com neoplasia de cólon é descrita para o Streptococcus gallolyticus (bovis), não para enterococos.
• D) A endocardite protética precoce é classicamente definida como aquela que ocorre nos primeiros 60 dias (dois meses) após a cirurgia, não apenas no primeiro mês — embora o S. aureus seja, de fato, um patógeno frequente nesse período.
• E) A causa mais comum de hemocultura negativa em EI é o uso PRÉVIO de antibióticos antes da coleta, não os microrganismos fastidiosos (Bartonella, Coxiella, fungos), que são causas bem mais raras.');

insert into public.question_options (id, question_id, letra, texto, correta) values

(gen_random_uuid(), 'eb19d3ff-5790-4b12-bcac-5d5dfa2a0bcf', 'a', 'Estenose mitral importante.', false),
(gen_random_uuid(), 'eb19d3ff-5790-4b12-bcac-5d5dfa2a0bcf', 'b', 'Insuficiência aórtica importante.', true),
(gen_random_uuid(), 'eb19d3ff-5790-4b12-bcac-5d5dfa2a0bcf', 'c', 'Insuficiência mitral importante.', false),
(gen_random_uuid(), 'eb19d3ff-5790-4b12-bcac-5d5dfa2a0bcf', 'd', 'Insuficiência aórtica e estenose mitral importantes.', false),
(gen_random_uuid(), 'eb19d3ff-5790-4b12-bcac-5d5dfa2a0bcf', 'e', 'Dupla lesão mitral com estenose importante e insuficiência moderada.', false),

(gen_random_uuid(), '7567743f-b006-4b5a-8290-797f85fe0cac', 'a', 'São considerados fatores complicadores disfunção do ventrículo esquerdo (VE) (fração de ejeção < 50%), velocidade máxima do fluxo aórtico > 5,0 m/s, gradiente médio > 60 mmHg, AVA < 0,7 cm² e hipotensão durante o esforço ao teste ergométrico.', false),
(gen_random_uuid(), '7567743f-b006-4b5a-8290-797f85fe0cac', 'b', 'A cirurgia é indicada para pacientes assintomáticos com fração de ejeção inferior a 50% que serão submetidos a outra cirurgia, como revascularização do miocárdio.', false),
(gen_random_uuid(), '7567743f-b006-4b5a-8290-797f85fe0cac', 'c', 'A cirurgia de troca valvar aórtica é a primeira escolha para pacientes de baixo risco (STS - escore de risco da Society of Thoracic Surgeons < 8%).', false),
(gen_random_uuid(), '7567743f-b006-4b5a-8290-797f85fe0cac', 'd', 'A tomografia computadorizada para avaliar o escore de cálcio da valva aórtica é uma ferramenta útil para auxiliar o diagnóstico de estenose aórtica e deve ser indicada para todos os casos, inclusive para o caso descrito.', true),
(gen_random_uuid(), '7567743f-b006-4b5a-8290-797f85fe0cac', 'e', 'A indicação de implante percutâneo de válvula aórtica (TAVI) foi ampliada para pacientes de risco intermediário (STS 4% a 8%) e é indicada para os pacientes de alto risco cirúrgico (STS > 8% ou EuroSCORE logístico > 20%), sendo a primeira escolha em risco cirúrgico proibitivo ou para casos de contraindicação à cirurgia convencional.', false),

(gen_random_uuid(), '97cedf0a-aff9-4a97-ab30-bfc33d1a3b1c', 'a', 'Paciente com baixo risco cirúrgico e idade acima de 70 anos tem o mesmo grau de recomendação entre cirurgia de troca valvar e implante transcateter de bioprótese aórtica (TAVI).', true),
(gen_random_uuid(), '97cedf0a-aff9-4a97-ab30-bfc33d1a3b1c', 'b', 'Paciente com risco cirúrgico intermediário apresenta o mesmo grau de recomendação entre cirurgia de troca valvar e implante transcateter de bioprótese aórtica (TAVI).', false),
(gen_random_uuid(), '97cedf0a-aff9-4a97-ab30-bfc33d1a3b1c', 'c', 'Valvoplastia aórtica por cateter balão é indicada nos casos sintomáticos para avaliar melhora sintomática e postergar intervenção com tratamento clínico.', false),
(gen_random_uuid(), '97cedf0a-aff9-4a97-ab30-bfc33d1a3b1c', 'd', 'Em casos de instabilidade hemodinâmica importante, a indicação é de implante transcateter de bioprótese aórtica (TAVI) em caráter de urgência.', false),
(gen_random_uuid(), '97cedf0a-aff9-4a97-ab30-bfc33d1a3b1c', 'e', 'Implante transcateter de bioprótese aórtica (TAVI) é uma boa alternativa em casos de tratamento paliativo.', false),

(gen_random_uuid(), '57ce3cc7-7fb9-4917-9c5c-c3a0439a4d20', 'a', 'O tratamento cirúrgico está indicado independentemente de o paciente estar em fase aguda da doença reumática.', false),
(gen_random_uuid(), '57ce3cc7-7fb9-4917-9c5c-c3a0439a4d20', 'b', 'O implante percutâneo de bioprótese é a primeira opção de intervenção neste caso.', false),
(gen_random_uuid(), '57ce3cc7-7fb9-4917-9c5c-c3a0439a4d20', 'c', 'O ecocardiograma deste paciente não demonstra sinais de valvopatia de grau importante (vena contracta estreita e pressure half-time[PHT] 135 ms).', false),
(gen_random_uuid(), '57ce3cc7-7fb9-4917-9c5c-c3a0439a4d20', 'd', 'O tratamento cirúrgico está indicado para pacientes reumáticos quando o diâmetro diastólico final do ventrículo esquerdo for maior que 75 mm OU o diâmetro sistólico do ventrículo esquerdo for maior que 55 mm e a fração de ejeção do ventrículo esquerdo (FEVE) menor que 50%.', true),
(gen_random_uuid(), '57ce3cc7-7fb9-4917-9c5c-c3a0439a4d20', 'e', 'O uso de vasodilatadores e diuréticos é indicado para evitar a progressão da doença.', false),

(gen_random_uuid(), 'a84d62d9-874a-465b-b0d4-0c2e8e34291d', 'a', 'Piora do sopro com a manobra de Handgrip.', true),
(gen_random_uuid(), 'a84d62d9-874a-465b-b0d4-0c2e8e34291d', 'b', 'Sopro holodiastólico, aspirativo, decrescente, com B2 hipofonética.', false),
(gen_random_uuid(), 'a84d62d9-874a-465b-b0d4-0c2e8e34291d', 'c', 'Sopro mesossistólico, pouco rude, de baixa intensidade.', false),
(gen_random_uuid(), 'a84d62d9-874a-465b-b0d4-0c2e8e34291d', 'd', 'Sopro diastólico em ruflar.', false),
(gen_random_uuid(), 'a84d62d9-874a-465b-b0d4-0c2e8e34291d', 'e', 'Pulso em martelo d''água.', false),

(gen_random_uuid(), '53511a15-604a-478a-9da9-c54f8613ecae', 'a', 'O sopro se mantém inalterado.', false),
(gen_random_uuid(), '53511a15-604a-478a-9da9-c54f8613ecae', 'b', 'O sopro reduz.', false),
(gen_random_uuid(), '53511a15-604a-478a-9da9-c54f8613ecae', 'c', 'Não há sopro.', false),
(gen_random_uuid(), '53511a15-604a-478a-9da9-c54f8613ecae', 'd', 'O sopro torna-se diastólico.', false),
(gen_random_uuid(), '53511a15-604a-478a-9da9-c54f8613ecae', 'e', 'O sopro aumenta.', true),

(gen_random_uuid(), '9f6c2774-b766-49f2-8b81-37fa81c95ef2', 'a', 'A ausculta cardíaca evidencia dupla lesão aórtica (estenose e insuficiência importantes).', true),
(gen_random_uuid(), '9f6c2774-b766-49f2-8b81-37fa81c95ef2', 'b', 'O uso de propranolol nesse caso poderia piorar a sintomatologia devido ao aumento do tempo de diástole.', false),
(gen_random_uuid(), '9f6c2774-b766-49f2-8b81-37fa81c95ef2', 'c', 'A alteração apresentada na angiotomografia não é suficiente para definição etiológica e, para esse fim, o ecocardiograma deve ser realizado.', false),
(gen_random_uuid(), '9f6c2774-b766-49f2-8b81-37fa81c95ef2', 'd', 'A propedêutica, nesse caso, traz sinais suficientes para definir a gravidade anatômica da valvopatia.', false),
(gen_random_uuid(), '9f6c2774-b766-49f2-8b81-37fa81c95ef2', 'e', 'No caso de indicação de intervenção, a abordagem da aorta ascendente também está recomendada.', false),

(gen_random_uuid(), 'ba4d08be-011f-4924-a7ee-1c1a9ed96cec', 'a', 'Somente intervir quando apresentar sintomas.', false),
(gen_random_uuid(), 'ba4d08be-011f-4924-a7ee-1c1a9ed96cec', 'b', 'Iniciar betabloqueador e reavaliar em 6 meses.', false),
(gen_random_uuid(), 'ba4d08be-011f-4924-a7ee-1c1a9ed96cec', 'c', 'Ressecar apenas a aorta ascendente.', false),
(gen_random_uuid(), 'ba4d08be-011f-4924-a7ee-1c1a9ed96cec', 'd', 'Colocar endoprótese em aorta ascendente.', false),
(gen_random_uuid(), 'ba4d08be-011f-4924-a7ee-1c1a9ed96cec', 'e', 'Substituir a raiz da aorta por tubo valvado.', true),

(gen_random_uuid(), '8f775f34-acb0-425f-ad5e-ac86b6287d61', 'a', 'Paciente deve ser avaliado para TAVI (implante de valva aórtica transcateter), pois, em relação ao tratamento clínico, há melhora de sobrevida.', true),
(gen_random_uuid(), '8f775f34-acb0-425f-ad5e-ac86b6287d61', 'b', 'Mesmo sem haver a reserva miocárdica, a cirurgia está indicada.', false),
(gen_random_uuid(), '8f775f34-acb0-425f-ad5e-ac86b6287d61', 'c', 'Paciente com escore STS muito alto; deve ser colocado em paliação.', false),
(gen_random_uuid(), '8f775f34-acb0-425f-ad5e-ac86b6287d61', 'd', 'Apesar de alta mortalidade, este paciente deve ser submetido à troca cirúrgica convencional, pois é a única forma de melhora de prognóstico.', false),
(gen_random_uuid(), '8f775f34-acb0-425f-ad5e-ac86b6287d61', 'e', 'Por não haver gradiente importante, está descartada a indicação cirúrgica.', false),

(gen_random_uuid(), '38d92159-0d88-477c-ae1c-c459fd2c0f03', 'a', 'Na insuficiência aórtica importante há elevação das pressões arteriais sistólica e diastólica, provocando o pulso em martelo d''água e a dança das artérias.', false),
(gen_random_uuid(), '38d92159-0d88-477c-ae1c-c459fd2c0f03', 'b', 'No ecocardiograma da insuficiência aórtica importante, a largura do jato regurgitante ao Color Doppler é > 45% da via de saída do ventrículo esquerdo.', false),
(gen_random_uuid(), '38d92159-0d88-477c-ae1c-c459fd2c0f03', 'c', 'No ecocardiograma da insuficiência aórtica importante, a fração regurgitante é obrigatoriamente superior a 70%.', false),
(gen_random_uuid(), '38d92159-0d88-477c-ae1c-c459fd2c0f03', 'd', 'A insuficiência aórtica isolada importante pode ter, ao exame físico, um sopro aórtico diastólico aspirativo decrescente, sopro aórtico mesossistólico e um sopro mitral diastólico em ruflar.', true),
(gen_random_uuid(), '38d92159-0d88-477c-ae1c-c459fd2c0f03', 'e', 'São considerados complicadores da evolução da insuficiência aórtica importante a redução da fração de ejeção (abaixo de 60% em ventrículo esquerdo hiperdinâmico) e a dilatação do ventrículo esquerdo (acima de 60 mm na diástole).', false),

(gen_random_uuid(), 'cfb52e2e-6c13-4e70-b1f2-2d1243f610ca', 'a', 'Tratamento transcateter da valvopatia aórtica (TAVI).', false),
(gen_random_uuid(), 'cfb52e2e-6c13-4e70-b1f2-2d1243f610ca', 'b', 'Tratamento cirúrgico isolado da valvopatia aórtica.', false),
(gen_random_uuid(), 'cfb52e2e-6c13-4e70-b1f2-2d1243f610ca', 'c', 'Manutenção de seguimento clínico.', false),
(gen_random_uuid(), 'cfb52e2e-6c13-4e70-b1f2-2d1243f610ca', 'd', 'Tratamento cirúrgico da valvopatia aórtica e da aorta ascendente.', true),
(gen_random_uuid(), 'cfb52e2e-6c13-4e70-b1f2-2d1243f610ca', 'e', 'Realização de teste ergométrico para avaliar repercussão da valvopatia.', false),

(gen_random_uuid(), '73e9ec30-0a45-42dd-b63a-efe376c92f34', 'a', 'Eletrocardiograma com sobrecarga de ventrículo esquerdo.', false),
(gen_random_uuid(), '73e9ec30-0a45-42dd-b63a-efe376c92f34', 'b', 'Fração de ejeção do ventrículo esquerdo abaixo de 50%.', true),
(gen_random_uuid(), '73e9ec30-0a45-42dd-b63a-efe376c92f34', 'c', 'Diâmetro diastólico final do ventrículo esquerdo menor que 60 mm.', false),
(gen_random_uuid(), '73e9ec30-0a45-42dd-b63a-efe376c92f34', 'd', 'Radiografia de tórax com cardiomegalia.', false),
(gen_random_uuid(), '73e9ec30-0a45-42dd-b63a-efe376c92f34', 'e', 'Diâmetro sistólico final do ventrículo esquerdo menor que 50 mm.', false),

(gen_random_uuid(), 'c23f8f16-3d32-4595-b7ed-f302ac906006', 'a', 'Estenose aórtica sintomática grave com baixo fluxo /baixo gradiente e fração de ejeção reduzida.', false),
(gen_random_uuid(), 'c23f8f16-3d32-4595-b7ed-f302ac906006', 'b', 'Estenose aórtica sintomática grave "paradoxal".', true),
(gen_random_uuid(), 'c23f8f16-3d32-4595-b7ed-f302ac906006', 'c', 'Estenose aórtica sintomática grave com alto gradiente.', false),
(gen_random_uuid(), 'c23f8f16-3d32-4595-b7ed-f302ac906006', 'd', 'Estenose aórtica valvar de grau moderado.', false),
(gen_random_uuid(), 'c23f8f16-3d32-4595-b7ed-f302ac906006', 'e', 'Estenose subaórtica hipertrófica.', false),

(gen_random_uuid(), '085236ab-f679-428e-87b1-08cb30b8ecf9', 'a', 'Indicação cirúrgica devido ao diâmetro diastólico.', true),
(gen_random_uuid(), '085236ab-f679-428e-87b1-08cb30b8ecf9', 'b', 'Indicação cirúrgica devido à fração de ejeção.', false),
(gen_random_uuid(), '085236ab-f679-428e-87b1-08cb30b8ecf9', 'c', 'Tratamento medicamentoso com betabloqueador e inibidor da ECA.', false),
(gen_random_uuid(), '085236ab-f679-428e-87b1-08cb30b8ecf9', 'd', 'Seguimento clínico semestral com ecocardiograma.', false),
(gen_random_uuid(), '085236ab-f679-428e-87b1-08cb30b8ecf9', 'e', 'Indicação cirúrgica se houver aparecimento de sopro diastólico em ruflar.', false),

(gen_random_uuid(), '0ffb721d-7e26-4181-b645-a2aa7fcdb1bd', 'a', 'Características de herança genética não foram observadas em nenhum subgrupo de portadores de valva aórtica bicúspide.', false),
(gen_random_uuid(), '0ffb721d-7e26-4181-b645-a2aa7fcdb1bd', 'b', 'Valva aórtica bicúspide com fusão das cúspides coronariana esquerda e não coronariana é forma anatômica mais comumente encontrada.', false),
(gen_random_uuid(), '0ffb721d-7e26-4181-b645-a2aa7fcdb1bd', 'c', 'É uma doença rara e mais frequentemente encontrada em mulheres.', false),
(gen_random_uuid(), '0ffb721d-7e26-4181-b645-a2aa7fcdb1bd', 'd', 'Pode evoluir com dilatação da aorta ascendente, devido à aortopatia, e apresenta risco maior de dissecção do que a população geral.', true),
(gen_random_uuid(), '0ffb721d-7e26-4181-b645-a2aa7fcdb1bd', 'e', 'Caso a troca da valva aórtica seja indicada por disfunção valvar, a troca simultânea da aorta ascendente não é necessária, mesmo quando esta for > 50 mm, já que a dilatação regride após a troca valvar.', false),

(gen_random_uuid(), '2ae1b140-d866-4df2-9108-4717caeda8d3', 'a', 'O sopro associado a esta valvopatia se reduz durante a respiração (manobra de Rivero-Carvallo) e essa manobra fornece uma ajuda considerável no estabelecimento do diagnóstico, principalmente na postura ereta.', false),
(gen_random_uuid(), '2ae1b140-d866-4df2-9108-4717caeda8d3', 'b', 'O ecocardiograma evidencia insuficiência tricúspide grave e aumento do átrio e ventrículo direitos, e a causa mais comum é que seja de origem secundária (funcional), por dilatação de ventrículo direito e do anel tricúspide.', true),
(gen_random_uuid(), '2ae1b140-d866-4df2-9108-4717caeda8d3', 'c', 'A combinação desta valvopatia com outras é incomum na síndrome carcinoide, cuja fisiopatologia é a deposição focal ou difusa de tecido fibroso no endocárdio das cúspides valvares, câmaras cardíacas e na íntima das grandes veias e do seio coronariano.', false),
(gen_random_uuid(), '2ae1b140-d866-4df2-9108-4717caeda8d3', 'd', 'Esta valvopatia pode ocorrer por múltiplas causas, como reumática, após infarto extenso ventricular esquerdo, pressão sistólica ventricular direita maior que 55 mmHg, doença cardíaca congênita e síndrome de Eisenmenger, cor pulmonale ou dilatação do anel por síndrome de Marfan.', false),
(gen_random_uuid(), '2ae1b140-d866-4df2-9108-4717caeda8d3', 'e', 'Em geral esse quadro clínico associado à valvopatia, mesmo com alteração importante, é bem tolerado na ausência de hipertensão pulmonar; caso indicada a cirurgia, deve-se optar por prótese mecânica devido às menores taxas de fluxo e de pressão no lado direito do coração.', false),

(gen_random_uuid(), 'b7c56d39-2332-40ce-9f2f-7102376f8c1a', 'a', 'É necessária cirurgia de troca valvar e revascularização coronária com enxerto arterial.', false),
(gen_random_uuid(), 'b7c56d39-2332-40ce-9f2f-7102376f8c1a', 'b', 'Devido à instabilidade hemodinâmica e aos sintomas avançados do paciente, há indicação de realização de valvoplastia aórtica por cateter-balão como "ponte terapêutica".', false),
(gen_random_uuid(), 'b7c56d39-2332-40ce-9f2f-7102376f8c1a', 'c', 'É imprescindível a realização de tomografia computadorizada de tórax multidetectora para avaliar o escore de cálcio valvar aórtico e determinar se a valvopatia é importante.', false),
(gen_random_uuid(), 'b7c56d39-2332-40ce-9f2f-7102376f8c1a', 'd', 'Paciente idoso com estenose aórtica importante, sintomático, alto risco cirúrgico. A melhor indicação de intervenção seria implante transcateter de bioprótese aórtica (TAVI).', true),
(gen_random_uuid(), 'b7c56d39-2332-40ce-9f2f-7102376f8c1a', 'e', 'Paciente é portador de estenose aórtica de baixo fluxo, baixo gradiente com fração de ejeção normal ("paradoxal") e deve realizar ecocardiograma de estresse com dobutamina para avaliação da reserva contrátil.', false),

(gen_random_uuid(), '32bebdc1-f262-4c4b-827d-edc97a6e15fa', 'a', 'As assertivas I e II.', false),
(gen_random_uuid(), '32bebdc1-f262-4c4b-827d-edc97a6e15fa', 'b', 'Apenas a assertiva I.', true),
(gen_random_uuid(), '32bebdc1-f262-4c4b-827d-edc97a6e15fa', 'c', 'As assertivas II e III.', false),
(gen_random_uuid(), '32bebdc1-f262-4c4b-827d-edc97a6e15fa', 'd', 'Apenas a assertiva III.', false),
(gen_random_uuid(), '32bebdc1-f262-4c4b-827d-edc97a6e15fa', 'e', 'Todas estão corretas.', false),

(gen_random_uuid(), '5de41ae0-253f-44dc-89b9-2bf0c17f8b7d', 'a', 'O uso dos novos anticoagulantes orais está autorizado em caso de estenose mitral reumática importante.', false),
(gen_random_uuid(), '5de41ae0-253f-44dc-89b9-2bf0c17f8b7d', 'b', 'O uso dos novos anticoagulantes na estenose aórtica e na presença de fibrilação atrial é contraindicado.', false),
(gen_random_uuid(), '5de41ae0-253f-44dc-89b9-2bf0c17f8b7d', 'c', 'O uso dos novos anticoagulantes orais por portadores de próteses mecânicas pode ser considerado em caso de dificuldade de controle da INR (Razão Normatizada Internacional) com o uso da varfarina.', false),
(gen_random_uuid(), '5de41ae0-253f-44dc-89b9-2bf0c17f8b7d', 'd', 'A faixa de resultado que se deve manter a INR (Razão Normatizada Internacional) de paciente portador de prótese mecânica em posição mitral é entre 2,0-3,0.', false),
(gen_random_uuid(), '5de41ae0-253f-44dc-89b9-2bf0c17f8b7d', 'e', 'Não se deve usar o escore CHA2DS2-VASc em portadores de doença valvar importante, pois há subestimação do risco em pacientes com escore ≤ 1.', true),

(gen_random_uuid(), '750bc14e-d078-4de7-8589-889595dcd32e', 'a', 'Na EI adquirida na comunidade, os agentes mais comuns continuam sendo os estreptococos do grupo viridans, seguidos de perto pelo Staphylococcus aureus.', true),
(gen_random_uuid(), '750bc14e-d078-4de7-8589-889595dcd32e', 'b', 'Na EI de usuários de drogas injetáveis, os microrganismos mais frequentemente envolvidos são fungos e organismos HACEK.', false),
(gen_random_uuid(), '750bc14e-d078-4de7-8589-889595dcd32e', 'c', 'Pacientes com EI por enterococos devem investigar o trato intestinal pela associação frequente com câncer de colo.', false),
(gen_random_uuid(), '750bc14e-d078-4de7-8589-889595dcd32e', 'd', 'A EI precoce em próteses valvares, assim definida por ocorrer no primeiro mês após a cirurgia, tem como seu principal patógeno o Staphylococcus aureus.', false),
(gen_random_uuid(), '750bc14e-d078-4de7-8589-889595dcd32e', 'e', 'A principal causa de hemoculturas negativas em casos de EI é a ocorrência de microrganismos com crescimento lento, tais como espécies Bartonella, C. burnetii ou fungos.', false);

insert into public.questions (id, tema, ano, instituicao, enunciado, comentario, comentario_completo) values

('370583dd-3152-4df3-b41d-2ee9710217f7', 'Válvula', 2018, 'TEC', 'Assinale a alternativa CORRETA em relação aos "Critérios modificados de Duke" para o diagnóstico de endocardite infecciosa (EI):', 'O achado de hemocultura positiva única ou sorologia claramente positiva para Coxiella burnetii é considerado critério MAIOR para o diagnóstico de EI, dada a dificuldade de cultivo convencional desse microrganismo — alternativa A.', 'Pelos critérios modificados de Duke, a hemocultura positiva única (ou sorologia com título de IgG antifase I > 1:800) para Coxiella burnetii é considerada critério MAIOR, uma exceção à regra geral que exige duas hemoculturas positivas separadas, justamente porque esse microrganismo é de cultivo muito difícil pelos métodos convencionais — alternativa A.

Por que as outras alternativas estão incorretas:
• B) Fenômenos imunológicos (nódulos de Osler, manchas de Roth, glomerulonefrite, fator reumatoide) são critérios MENORES, não maiores.
• C) A febre é um critério MENOR (não maior) nos critérios de Duke.
• D) O achado de vegetação ao ecocardiograma (evidência de envolvimento endocárdico) é critério MAIOR, não menor.
• E) O diagnóstico definitivo pelos critérios clínicos exige 2 critérios maiores, OU 1 maior + 3 menores, OU 5 critérios menores — três critérios menores isoladamente não são suficientes.'),

('d80ccdf9-a64a-4ecb-bff5-92ae2821d5bd', 'Válvula', 2020, 'TEC', 'Assinale a alternativa correta em relação ao diagnóstico da endocardite infecciosa (EI):', 'O achado de microrganismos típicos consistentes com EI em duas hemoculturas separadas é um dos critérios MAIORES clássicos dos critérios de Duke — alternativa D.', 'Um dos dois critérios maiores dos critérios de Duke é justamente o achado de microrganismos típicos de EI (como estreptococos viridans, Streptococcus gallolyticus, organismos do grupo HACEK, Staphylococcus aureus ou enterococos adquiridos na comunidade sem foco primário) em duas hemoculturas separadas — alternativa D.

Por que as outras alternativas estão incorretas:
• A) Os critérios maiores são apenas duas categorias — hemocultura positiva e evidência de envolvimento endocárdico (ecocardiograma ou nova regurgitação valvar) —, não três categorias incluindo "exame físico" isoladamente.
• B) A resolução do quadro clínico com um curso curto de antibioticoterapia (≤ 4 dias) É, sim, um dos elementos usados para AFASTAR o diagnóstico de EI nos critérios de Duke — portanto há, sim, como usar a duração da resposta para excluir o diagnóstico.
• C) As manchas de Roth são classificadas como fenômeno IMUNOLÓGICO, não vascular — os fenômenos vasculares incluem embolia arterial, infartos pulmonares sépticos, aneurisma micótico, hemorragia intracraniana, hemorragias conjuntivais e lesões de Janeway.
• E) As lesões de Janeway são classificadas como fenômeno VASCULAR, não imunológico — os fenômenos imunológicos incluem nódulos de Osler, manchas de Roth, glomerulonefrite e fator reumatoide.'),

('b27325d4-cbb6-4a2a-bd05-f5fced72c678', 'Válvula', 2021, 'TEC', 'Homem, 52 anos, portador de prótese biológica aórtica implantada há 7 anos, queixa-se de fadiga. Ao exame físico: Hipocorado. Pressão arterial = 116 x 70 mmHg. Frequência cardíaca = 98 bpm. Ausculta cardíaca com sopro sistólico ejetivo em foco aórtico +++/6+, sem sinais de congestão pulmonar ou sistêmica. Exames laboratoriais com evidências de anemia hemolítica. Ecocardiograma mostrando: Prótese biológica aórtica espessada e calcificada. Gradiente médio VE-Ao = 42 mmHg. Fração de ejeção do ventrículo esquerdo = 58%. Valva mitral sem alteração anatômica. Insuficiência mitral discreta. Qual a melhor conduta?', 'Degeneração estrutural da bioprótese aórtica (espessada, calcificada, gradiente médio elevado em 42 mmHg) associada a anemia hemolítica — indica reoperação com troca (retroca) da valva aórtica; a valva mitral está anatomicamente normal e não precisa ser abordada — alternativa E.', 'O quadro descreve degeneração estrutural de bioprótese aórtica após 7 anos de implante — espessamento, calcificação, gradiente médio elevado (42 mmHg, obstrutivo) e anemia hemolítica associada (turbulência através da prótese disfuncionante). A conduta indicada é a reoperação com troca (retroca) da valva aórtica; a valva mitral não apresenta alteração anatômica relevante (apenas insuficiência discreta, sem necessidade de intervenção) — alternativa E.

Por que as outras alternativas estão incorretas:
• A) Não há indicação de trocar também a valva mitral, que está anatomicamente normal.
• B) O seguimento clínico é inadequado diante de degeneração protética com obstrução significativa e hemólise.
• C) O tratamento transcateter valve-in-valve é uma alternativa possível em pacientes de alto risco cirúrgico, mas a conduta indicada pela fonte, neste perfil, é a reoperação cirúrgica convencional.
• D) A valvoplastia por balão não é utilizada para próteses biológicas degeneradas/calcificadas — não trata a causa estrutural da obstrução.'),

('09ce0ecc-ac14-47a6-afc7-9bb22c2a9dcf', 'Válvula', 2020, 'TEC', 'Paciente de 45 anos submetida à cirurgia de troca valvar mitral há seis meses, com quadro de dispneia progressiva, sem história de febre, má aderente ao tratamento e com quadro de fibrilação atrial paroxística em Holter recente. Ao exame, hipotensa e dispneica em repouso. Apresenta a seguinte imagem no ecocardiograma transesofágico. Assinale a alternativa correta:', 'Diante de trombose de prótese valvar com grave repercussão clínica (hipotensão, dispneia em repouso) e alto risco de sangramento, a recomendação é a troca cirúrgica da prótese, em vez de trombólise — alternativa E.', 'A paciente, não aderente à anticoagulação, com prótese valvar mitral recente e quadro de descompensação grave (hipotensão, dispneia em repouso), apresenta imagem compatível com trombose protética. Quando há grave repercussão clínica hemodinâmica associada a alto risco de sangramento (que contraindicaria trombólise), a recomendação é a troca cirúrgica da prótese — alternativa E.

Por que as outras alternativas estão incorretas:
• A) O caso não especifica que a prótese implantada seja necessariamente metálica — essa suposição não está estabelecida no enunciado.
• B) A trombose de prótese valvar é, na verdade, mais frequente na posição MITRAL do que na aórtica (maior estase pela menor pressão de fluxo), não o contrário.
• C) Os complicadores clássicos incluem massa MAIOR (não menor) que aproximadamente 10 mm e alta mobilidade, além de hipertensão pulmonar e fibrilação atrial — uma massa pequena (< 5 mm) tende a ser menos preocupante, não um complicador.
• D) O abafamento do click metálico só se aplicaria caso a prótese fosse mecânica, o que não está confirmado no caso, e não é o foco da conduta correta desta questão.'),

('9c90c2b7-76c9-4b77-94c6-e30d8c3472c9', 'Válvula', 2021, 'TEC', 'Paciente com prótese biológica mitral há 5 anos, fibrilação atrial crônica e Classe Funcional da New York Heart Association (CF-NYHA) II, realizou ecocardiograma transesofágico, que mostrou prótese com refluxo moderado central, com gradiente diastólico máximo de 15 mmHg, médio de 6 mmHg e área de 1,6 cm². O exame mostrou também trombo na prótese e na parede do átrio esquerdo, medindo 10 x 12 mm, com grande mobilidade. A pressão sistólica da artéria pulmonar (PSAP) foi estimada em 55 mmHg. Neste caso, a melhor conduta seria:', 'Trombo não obstrutivo (gradientes protéticos praticamente normais) em paciente pouco sintomático (CF II) — a conduta inicial é internação com anticoagulação plena por via intravenosa e reavaliação em cerca de uma semana com ecocardiograma transesofágico, reservando cirurgia para ausência de resposta — alternativa C.', 'Apesar do trombo de tamanho considerável (10 x 12 mm, móvel) e da hipertensão pulmonar associada (PSAP 55 mmHg), os gradientes protéticos estão praticamente normais (médio de apenas 6 mmHg, área de 1,6 cm²), indicando que o trombo NÃO está causando obstrução relevante do fluxo, e a paciente está apenas em CF II (pouco sintomática). Nesse cenário, a conduta inicial recomendada é a internação hospitalar para anticoagulação plena por via intravenosa, com reavaliação por ecocardiograma transesofágico em cerca de uma semana, reservando a cirurgia para os casos sem resolução do trombo — alternativa C.

Por que as outras alternativas estão incorretas:
• A) A anticoagulação oral ambulatorial, com reavaliação apenas em 30 dias, é conduta mais frouxa do que o recomendado diante de um trombo grande e móvel — o acompanhamento deve ser mais próximo (dias), com anticoagulação intravenosa inicialmente.
• B) A cirurgia imediata é conduta excessivamente agressiva como primeira linha em paciente pouco sintomática (CF II) com prótese não obstrutiva.
• D) A fibrinólise imediata não é a primeira escolha neste cenário (trombo não obstrutivo, paciente hemodinamicamente estável), sendo reservada a casos mais graves ou de alto risco cirúrgico.
• E) A dupla terapia antiplaquetária/anticoagulante oral não é a abordagem padrão inicial; o tratamento inicial recomendado é a anticoagulação plena intravenosa.'),

('a8b9ccdf-bfb3-454b-98af-cc46faf63c1a', 'Válvula', 2020, 'TEC', 'Assinale a alternativa correta em relação ao ecocardiograma para diagnóstico da endocardite infecciosa (EI):', 'O diagnóstico diferencial ecocardiográfico das lesões valvares na EI inclui degeneração mixomatosa, ruptura espontânea de corda tendínea, fibroelastoma papilar e excrescências de Lambl, condições que podem mimetizar vegetações — alternativa D.', 'Diversas condições podem mimetizar vegetações ao ecocardiograma e devem ser consideradas no diagnóstico diferencial de lesões valvares suspeitas de EI, incluindo degeneração mixomatosa da valva, ruptura espontânea de corda tendínea, fibroelastoma papilar (tumor valvar benigno) e excrescências de Lambl (pequenas formações filiformes por depósito de fibrina, geralmente sem significado patológico) — alternativa D.

Por que as outras alternativas estão incorretas:
• A) O ecocardiograma transesofágico tem maior acurácia que o transtorácico tanto em próteses valvares QUANTO em valvas nativas (a diferença é apenas mais acentuada nas próteses), não havendo "acurácia semelhante" nas valvas nativas.
• B) Um ecocardiograma transtorácico normal NÃO é suficiente para descartar EI em portadores de dispositivos intracavitários (marca-passo/CDI) — o ecocardiograma transesofágico é obrigatório nesse contexto.
• C) O critério de tamanho de vegetação relacionado à indicação cirúrgica isolada é, classicamente, > 10 mm associado a outros fatores de risco (não apenas > 5 mm isoladamente).
• E) Mesmo com achado diagnóstico ao ecocardiograma transtorácico, o ecocardiograma transesofágico não é dispensado em pacientes com risco de complicações (abscesso, extensão perivalvar).'),

('e3e04272-cac8-49b8-9351-0b75e1fc767e', 'Válvula', 2019, 'TEC', 'Homem, 36 anos de idade, portador de prótese biológica em posição aórtica implantada há 6 anos. Deu entrada no pronto-socorro com queixa de dispneia progressiva e febre há três meses. Referia perda de peso e astenia. Durante a internação, apresentou forte dor abdominal. Ao exame físico, apresentava-se febril, pálido, consciente, orientado. À ausculta cardíaca, sopros sistólico e diastólico em foco aórtico com irradiação para bordo esternal esquerdo baixo e terceira bulha (B3). Pressão arterial (PA) = 100 x 60 mmHg e frequência cardíaca (FC) = 110 bpm. O ecocardiograma apresentou imagem de massa aderida à prótese medindo 12 mm. Dor difusa à palpação abdominal. Hemograma evidencia anemia e acentuada leucocitose e duas hemoculturas positivas, com intervalo de 12 horas, para Staphylococcus aureus. Assinale a alternativa correta neste caso:', 'Endocardite protética por S. aureus, com vegetação de 12 mm (> 10 mm) e provável evento embólico (dor abdominal difusa sugerindo infarto esplênico) — indicação de iniciar antibioticoterapia e cirurgia de urgência para troca valvar — alternativa E.', 'Este caso configura endocardite infecciosa em prótese valvar por Staphylococcus aureus (organismo de alta virulência), com vegetação de 12 mm (acima do limiar de 10 mm associado a maior risco embólico) e provável evento embólico já em curso (dor abdominal difusa, sugestiva de infarto esplênico). Essa combinação de fatores de alto risco (prótese + S. aureus + vegetação grande + evento embólico) indica antibioticoterapia associada à cirurgia de URGÊNCIA para troca valvar — alternativa E.

Por que as outras alternativas estão incorretas:
• A) O tamanho da vegetação (> 10 mm) É, sim, um dos fatores que influenciam a indicação cirúrgica, especialmente quando associado a evento embólico.
• B) Ainda que alterações cutâneas (fenômenos vasculares/imunológicos) estivessem presentes, elas são critérios MENORES de Duke, não maiores.
• C) Antibioticoterapia isolada por 4 semanas é insuficiente diante de indicação cirúrgica já estabelecida (prótese + S. aureus + vegetação grande + embolia).
• D) A rifampicina É, sim, indicada como parte do esquema antibiótico combinado para endocardite protética por S. aureus (junto a betalactâmico/vancomicina e aminoglicosídeo).'),

('5df966fe-c6f9-4663-bb75-43b98aa4ba65', 'Válvula', 2018, 'TEC', 'Assinale a alternativa CORRETA em relação às condições cardíacas predisponentes à endocardite infecciosa (EI):', 'A valva aórtica bicúspide associa-se a maior incidência de complicações perianulares (abscesso, extensão perivalvar), sendo uma condição predisponente reconhecida com pior prognóstico local de infecção — alternativa A.', 'A valva aórtica bicúspide, além de ser uma condição predisponente reconhecida de EI, está associada a maior incidência de complicações perianulares (abscessos, extensão perivalvar da infecção), provavelmente por particularidades anatômicas do anel valvar — alternativa A.

Por que as outras alternativas estão incorretas:
• B) A calcificação do anel mitral associada à IM não é a condição predisponente mais frequente de EI; outras causas (valvopatia degenerativa, prolapso mitral, cardiopatias congênitas) têm papel mais proeminente.
• C) A insuficiência mitral FUNCIONAL (secundária, com valva histologicamente normal) tem risco de EI muito menor do que a doença valvar orgânica/primária — raramente se complica com EI.
• D) Entre as cardiopatias congênitas, a comunicação interatrial (CIA) isolada tem risco de EI muito BAIXO (é uma das poucas malformações congênitas consideradas de baixo risco); as lesões mais associadas à EI são CIV, persistência do canal arterial e tetralogia de Fallot.
• E) Lesões de INSUFICIÊNCIA (regurgitação) têm risco de EI MAIOR do que lesões puramente estenóticas, não risco semelhante.'),

('d7f43fe6-ebf6-4558-94a3-ae7c94733db1', 'Válvula', 2020, 'TEC', 'Assinale a alternativa correta em relação ao tratamento cirúrgico da endocardite infecciosa (EI):', 'A cirurgia deve ser considerada diante de insuficiência cardíaca, alto risco de embolia e infecção não controlada — os três pilares clássicos de indicação cirúrgica na EI — alternativa A.', 'As três indicações clássicas e mais bem estabelecidas para o tratamento cirúrgico da endocardite infecciosa são: presença de insuficiência cardíaca (geralmente a mais frequente), alto risco de embolização (vegetações grandes e/ou móveis) e infecção não controlada (persistência de febre/bacteriemia apesar de antibioticoterapia adequada, abscesso perivalvar) — alternativa A.

Por que as outras alternativas estão incorretas:
• B) Há, sim, evidências de melhora de desfechos com cirurgia precoce em cenários de alto risco embólico (vegetações grandes), contrariando a afirmação de ausência de evidências.
• C) A cirurgia NÃO elimina a necessidade de antibioticoterapia — esta deve ser mantida pelo tempo total recomendado, mesmo após a intervenção.
• D) Não há uma regra fixa de que a bioprótese seja sempre a "primeira opção" — a escolha da prótese depende de fatores individuais do paciente (idade, viabilidade de anticoagulação).
• E) A revascularização miocárdica associada, quando indicada, NÃO é contraindicada durante a cirurgia da EI.'),

('ea0421bd-88ca-4451-83c9-0aa31f554419', 'Válvula', 2019, 'TEC', 'Mulher, 35 anos, portadora de anomalia de Ebstein, submetida a uma sequência de três cirurgias cardíacas, sendo a última para troca da valva tricúspide por uma prótese mecânica. Nove meses após esta última cirurgia, foi admitida no pronto-socorro, referindo dispneia aos grandes esforços, iniciada 4 dias antes e que progredira até para em repouso. Na admissão, referia que não estava escutando o ruído da prótese e apresentava razão normatizada internacional (INR) com valor de 1,37. Submetida inicialmente a ecocardiograma transtorácico, que evidenciou fluxo diastólico turbulento por meio da prótese tricúspide, com gradientes máximo e médio estimados em 37 e 20 mmHg, respectivamente. Assinale a alternativa correta com relação ao tratamento inicial que pode ser ministrado para esta paciente:', 'Trombose de prótese mecânica em posição TRICÚSPIDE (câmaras direitas) — nesse cenário, a trombólise (rTPA ou estreptoquinase) é o tratamento de escolha, dado o baixo risco embólico sistêmico associado ao lado direito do coração — alternativa B.', 'A paciente apresenta trombose de prótese mecânica tricúspide (INR subterapêutico, ausência do click metálico, fluxo diastólico obstrutivo ao Doppler). Diferente da trombose em posição mitral ou aórtica (onde a cirurgia é geralmente preferida pelo risco de embolia sistêmica, incluindo AVC), a trombose de prótese em câmaras DIREITAS tem baixo risco embólico sistêmico (o êmbolo, se ocorrer, tende a ir para a circulação pulmonar, geralmente mais bem tolerado). Por isso, a trombólise (com rTPA ou estreptoquinase) é o tratamento de escolha para trombose de prótese tricúspide — alternativa B.

Por que as outras alternativas estão incorretas:
• A) A incidência de trombose em posição tricúspide não é necessariamente baixa por esse mecanismo; de qualquer forma, esta paciente já apresenta trombose estabelecida, o que contraria a premissa da alternativa.
• C) A cirurgia é reservada para falha da trombólise ou contraindicação a ela, não sendo a conduta inicial preferencial em câmaras direitas.
• D) Os anticoagulantes orais diretos (NOACs) NÃO têm eficácia comprovada em próteses mecânicas — não são o tratamento de escolha após heparinização.
• E) A trombólise não deve ficar restrita apenas a trombos pequenos ou a CF IV — é considerada a primeira escolha para trombose de prótese em câmaras direitas de forma mais ampla, dado o menor risco embólico sistêmico.'),

('d51bb0a3-17a7-48cc-8297-3e15a64f9fd3', 'Válvula', 2018, 'TEC', 'O tratamento da endocardite infecciosa (EI) é primariamente fundamentado na antibioticoterapia, mas a cirurgia é a base para o tratamento da EI complicada. A decisão sobre o momento cirúrgico para o paciente com EI, a despeito do avanço das técnicas cirúrgicas e dos novos antibióticos, permanece complexa. Dependendo do quadro clínico, a indicação para a intervenção cirúrgica na EI pode ser uma emergência (realizar em período < 24 horas), urgência (em 2 a 4 dias) ou eletiva (em semanas). Assinale a alternativa CORRETA sobre as indicações de tratamento cirúrgico na endocardite infecciosa:', 'A ruptura do seio de Valsalva para outra câmara/estrutura, causando insuficiência cardíaca aguda, é uma complicação mecânica catastrófica que exige cirurgia em caráter de EMERGÊNCIA (< 24 horas) — alternativa C.', 'A ruptura do seio de Valsalva em outra estrutura cardíaca, levando à insuficiência cardíaca aguda, representa uma complicação mecânica grave e catastrófica da endocardite infecciosa, exigindo intervenção cirúrgica em caráter de EMERGÊNCIA (realização em menos de 24 horas) — alternativa C.

Por que as outras alternativas estão incorretas:
• A) O abscesso perivalvar é, por si só, uma indicação de cirurgia (infecção não controlada/extensão perivalvar) — não exige antibioticoterapia prolongada como pré-requisito antes de definir a cirurgia.
• B) Vegetação > 10 mm associada a evento embólico é justamente uma das combinações que já INDICAM cirurgia (geralmente em caráter de urgência), não uma indicação para apenas otimizar antibiótico/anticoagulante antes de decidir.
• D) Apesar de a infecção não controlada ser uma indicação importante, a insuficiência cardíaca é classicamente apontada como a causa mais FREQUENTE de indicação cirúrgica na EI.
• E) O adiamento de cerca de 4 semanas após AVC embólico é uma recomendação mais específica para casos de AVC HEMORRÁGICO ou infarto extenso com risco de transformação hemorrágica — a decisão não é uma regra fixa "independente da condição neurológica", pois esta condição efetivamente influencia o momento cirúrgico.'),

('e0c80606-e3de-41e0-99c7-4454ff19a0f7', 'Válvula', 2018, 'TEC', 'Homem, 54 anos, sem comorbidades, ritmo sinusal, foi submetido à cirurgia de troca valvar aórtica com prótese metálica. Por conta disso, recebe alta em uso de varfarina ajustada pelo INR (índice de normatização internacional). Em relação às orientações quanto ao uso do anticoagulante para este paciente, assinale o item CORRETO:', 'Não é necessária a abstenção total da ingesta de folhas verdes e outros alimentos ricos em vitamina K — o mais importante é manter uma ingesta CONSISTENTE (regular), permitindo o ajuste estável da dose de varfarina, e não a eliminação completa desses alimentos — alternativa D.', 'A orientação correta quanto à dieta em pacientes anticoagulados com varfarina não é a abstenção total de alimentos ricos em vitamina K (folhas verdes), mas sim a manutenção de uma ingesta CONSISTENTE e regular desses alimentos, permitindo que a dose de varfarina seja ajustada de forma estável em torno desse padrão alimentar — alternativa D.

Por que as outras alternativas estão incorretas:
• A) Os anticoagulantes orais diretos são formalmente contraindicados em qualquer prótese mecânica, incluindo a posição aórtica — não são alternativa razoável à varfarina.
• B) Não há recomendação de evitar dipirona como analgésico nesse contexto; são os anti-inflamatórios não hormonais (AINEs) que exigem mais cautela por interferirem na função plaquetária e no risco de sangramento.
• C) Este paciente, sem fatores de risco adicionais (ritmo sinusal, prótese aórtica bileaflet sem outros fatores), tem como alvo de INR a faixa mais baixa, entre 2,0 e 3,0 — não entre 2,5 e 3,5 (faixa reservada a próteses mitrais ou fatores de risco adicionais).
• E) Suplementos de vitamina E podem potencializar o efeito anticoagulante e aumentar o risco de sangramento, não estando livremente liberados.'),

('77ac66bf-7806-454c-ade6-ae83cb8f8b52', 'Válvula', 2018, 'TEC', 'Em relação às próteses valvares, assinale a resposta CORRETA:', 'A incidência de trombose de prótese mecânica é maior na posição MITRAL do que na posição aórtica, devido à menor pressão e maior estase de fluxo nessa câmara — alternativa D.', 'A posição mitral, por apresentar menor pressão e maior estase de fluxo em comparação à posição aórtica, está associada a uma incidência maior de trombose de prótese mecânica — alternativa D.

Por que as outras alternativas estão incorretas:
• A) A maioria das próteses mecânicas modernas é condicionalmente compatível com ressonância magnética — não há proibição absoluta para "todos" os pacientes.
• B) A fibrinólise não é a primeira escolha para TODOS os casos de trombose protética — a preferência varia conforme a posição (esquerda versus direita) e o risco embólico/hemorrágico.
• C) A recomendação geral é o OPOSTO: próteses MECÂNICAS costumam ser preferidas em pacientes mais JOVENS (maior durabilidade, evitando reoperação), e as BIOLÓGICAS em pacientes mais IDOSOS (evitando anticoagulação prolongada).
• E) Os anticoagulantes orais diretos não têm eficácia comprovada como alternativa em casos de trombose de prótese mecânica, mesmo após falha aparente da varfarina.'),

('dfe6eb67-7657-4039-8a35-378a8f04b065', 'Válvula', 2020, 'TEC', 'De acordo com a Organização Mundial da Saúde, qual a alternativa correta sobre a duração da profilaxia secundária para a febre reumática (FR)?', 'Pacientes com cardiopatia reumática e doença valvar GRAVE devem realizar profilaxia secundária por TODA A VIDA — recomendação clássica da OMS para os casos mais graves — alternativa B.', 'Segundo as recomendações da Organização Mundial da Saúde, pacientes com cardiopatia reumática valvar de grau GRAVE devem manter a profilaxia secundária com penicilina benzatina por TODA A VIDA, dado o alto risco de recorrência e agravamento da lesão valvar — alternativa B.

Por que as outras alternativas estão incorretas:
• A) Mesmo pacientes sem cardite comprovada (apenas manifestações articulares/outras) ainda necessitam de profilaxia secundária por um período definido (geralmente 5 anos ou até os 21 anos, o que cobrir mais tempo) — não são dispensados.
• C) A profilaxia NÃO é dispensada após o tratamento cirúrgico da valvopatia — deve continuar por toda a vida, dado o risco de recorrência da febre reumática mesmo pós-cirúrgico.
• D) Para cardite com sequela de IM leve (ou resolução completa), a duração recomendada é de 10 anos após o último surto ou até os 25 anos de idade (o que cobrir maior período), não 5 anos/18 anos (critério usado para febre reumática sem cardite).
• E) Essa descrição refere-se à profilaxia para ENDOCARDITE INFECCIOSA em procedimentos, não à profilaxia secundária da febre reumática (que é feita de forma regular e programada, não vinculada a procedimentos).'),

('fc1da3c4-c351-46a7-8af2-1a350d69d01b', 'Válvula', 2021, 'TEC', 'Adolescente, 16 anos, com vários quadros de "gripe leve" com odinofagia, hiperemia de faringe, sendo o último há 3 semanas, com queda discreta do estado geral, autolimitado e de breve duração. Apresenta-se pálida. Temperatura = 39,2°C. Frequência cardíaca = 124 bpm. Frequência respiratória = 32 irpm. Linfadenomegalia cervical. Ausculta respiratória sem alterações. Sopro sistólico em foco mitral (3+/6+). Hemograma: leucocitose discreta com pequeno desvio à esquerda. Fator antinúcleo negativo. Anticorpo antiestreptolisina O (ASLO) de 500 UI/mL. Velocidade de hemossedimentação (VHS) = 73 mm/h e proteína C-reativa (PCR) = 44 mg/L. Eletrocardiograma: prolongamento do intervalo PR. Ecocardiograma: regurgitação mitral leve e isolada. Sobre o quadro clínico apresentado, assinale a afirmativa correta:', 'O quadro (faringite estreptocócica prévia, febre, taquicardia, sopro mitral novo, PR prolongado, ASLO e provas inflamatórias elevadas) é de cardite reumática aguda; se a regurgitação mitral persistir em avaliação posterior, o caso passa a ser classificado como cardiopatia reumática crônica — alternativa A.', 'Este quadro reúne os elementos clássicos de cardite reumática aguda: infecção estreptocócica de orofaringe recente, febre, taquicardia desproporcional (mesmo sem hipertermia extrema), sopro mitral novo, prolongamento do intervalo PR, ASLO elevado e provas inflamatórias (VHS/PCR) elevadas. Se, no acompanhamento ecocardiográfico posterior (após a fase aguda), a regurgitação mitral patológica persistir, o caso passa a ser classificado como cardiopatia reumática CRÔNICA — alternativa A.

Por que as outras alternativas estão incorretas:
• B) O quadro apresentado, com febre alta, taquicardia marcada e provas inflamatórias muito elevadas, não é caracterizado como "leve autolimitado"; além disso, o tratamento da cardite moderada/grave é feito com CORTICOSTEROIDES, não apenas sintomáticos/AAS.
• C) Não há elementos que sustentem endocardite infecciosa aguda (sem hemoculturas/vegetações descritas); o quadro é consistente com febre reumática aguda pós-estreptocócica.
• D) Nos casos de cardite moderada/grave, o tratamento anti-inflamatório de escolha é o CORTICOSTEROIDE (não AINEs em dose alta) — os AINEs (AAS) são reservados para artrite isolada ou cardite leve.
• E) A profilaxia secundária é obrigatória para TODOS os casos confirmados de febre reumática, independentemente da gravidade do episódio inicial.'),

('61436da1-347b-45d2-b295-dc24698aeaeb', 'Válvula', 2019, 'TEC', 'Homem, 16 anos, portador de febre reumática. Apresentou quadro inicial de cardite com insuficiência mitral leve, que regrediu posteriormente (ecocardiograma subsequente não demonstrou sequelas). Qual seria a melhor alternativa com relação à profilaxia secundária?', 'Para febre reumática com cardite prévia e resolução completa da lesão valvar (sem sequela), a profilaxia secundária deve durar até os 25 anos de idade OU 10 anos após o último surto, valendo o que cobrir maior período — alternativa A.', 'Nos casos de febre reumática com cardite prévia, seja com insuficiência mitral leve residual, seja com resolução completa da lesão valvar (como neste paciente), a duração recomendada da profilaxia secundária é até os 25 anos de idade ou 10 anos após o último surto, valendo o que cobrir o maior período — alternativa A.

Por que as outras alternativas estão incorretas:
• B) Não há evidência de interação entre lidocaína (com ou sem vasoconstritor) e a ação da penicilina benzatina — essa afirmação é fabricada/incorreta.
• C) O critério de 21 anos ou 5 anos após o último surto aplica-se à febre reumática SEM cardite (apenas manifestações articulares), não ao caso deste paciente, que teve cardite.
• D) Para lesão valvar residual moderada a grave, a recomendação é profilaxia POR TODA A VIDA (não uma escolha entre 21 anos OU vitalícia); além disso, este paciente não tem sequela valvar (resolução completa).
• E) O esquema padrão de penicilina G-benzatina é a cada 21 dias (3 semanas), de forma constante — não a cada 15 dias até os 18 anos e depois a cada 30 dias.'),

('ac0b26b5-3f3e-4665-881b-353748f20c57', 'Válvula', 2019, 'TEC', 'Gestante, 21 anos, portadora de doença reumática diagnosticada quando tinha 5 anos de idade. Estava em uso regular da penicilina G-benzatina a cada 21 dias, pois tinha como sequela uma valvopatia mitral do tipo estenose mitral de grau leve. Durante o quarto mês de gestação, procurou pelo ambulatório de cardiologia muito preocupada, pois seu obstetra suspendera a administração profilática da penicilina G-benzatina. Com relação à profilaxia nesta situação, quais seriam as orientações adequadas para a paciente?', 'A profilaxia secundária com penicilina benzatina deve continuar durante toda a gestação, pois é considerada segura na gravidez e sua suspensão expõe a paciente a risco de recorrência da febre reumática — alternativa E.', 'A penicilina benzatina é segura durante a gestação e sua suspensão não se justifica — a profilaxia secundária deve continuar durante toda a gravidez para evitar o risco de recorrência da febre reumática, que poderia agravar ainda mais a valvopatia materna em um momento de sobrecarga hemodinâmica adicional (a própria gestação) — alternativa E. A conduta do obstetra, neste caso, deve ser revista.

Por que as outras alternativas estão incorretas:
• A) A sulfadiazina não é considerada isenta de riscos na gestação (risco de kernicterus/efeitos antifolato, especialmente no terceiro trimestre).
• B) A suspensão da profilaxia durante a gestação é exatamente a orientação INCORRETA que foi dada à paciente — não deve ser seguida.
• C) Diversos antibióticos (não apenas a eritromicina) exigem cautela ou são restringidos na gravidez (tetraciclinas, sulfonamidas no terceiro trimestre, aminoglicosídeos, fluoroquinolonas).
• D) Reações anafiláticas verdadeiras à penicilina são RARAS (não frequentes), com incidência bem abaixo de 0,1% relatada na maioria das séries.'),

('cfb8edea-30cf-4d8a-81f6-0b7210704d61', 'Válvula', 2018, 'TEC', 'Assinale a alternativa correta em relação à profilaxia secundária da febre reumática (FR):', 'Portadores de lesões valvares importantes pela cardiopatia reumática crônica que sejam submetidos à cirurgia valvar devem manter a profilaxia secundária da FR por TODA A VIDA, independentemente da correção cirúrgica — alternativa D.', 'Mesmo após a correção cirúrgica da valvopatia, portadores de lesões valvares importantes pela cardiopatia reumática crônica devem manter a profilaxia secundária com penicilina benzatina por TODA A VIDA, pois o risco de recorrência da febre reumática (e de novo dano valvar, inclusive à prótese) persiste — alternativa D.

Por que as outras alternativas estão incorretas:
• A) A dose de penicilina G benzatina é definida por faixas de peso diferentes das apresentadas (geralmente 600.000 UI para crianças de menor peso e 1.200.000 UI acima de aproximadamente 20-25 kg), não pelo corte de 50 kg citado.
• B) Para cardite com sequela de IM leve residual ou resolução da lesão valvar, a duração recomendada é de 10 anos após o último surto ou até os 25 anos (o que cobrir maior período), não até os 40 anos.
• C) A via ORAL (penicilina V) tem eficácia inferior à via intramuscular (penicilina G benzatina) para profilaxia secundária, principalmente pela menor adesão ao tratamento continuado.
• E) A sulfadiazina (ou sulfisoxazol) ainda é considerada uma alternativa válida para profilaxia secundária em pacientes alérgicos à penicilina, junto com os macrolídeos.'),

('a35e46d9-e2da-4d83-8ff3-948c329922ea', 'Válvula', 2019, 'TEC', 'Mulher, 15 anos, dá entrada no pronto-socorro com queixas de dispneia progressiva há cerca de três semanas, que evoluiu para os menores esforços, acompanhada de febre. A mãe relatava que a menor se queixava de dores em grandes articulações, migratória, e sofria de amigdalites frequentes. Ao exame físico, apresentava-se com taquicardia e presença de sopro sistólico em foco mitral. Em relação ao caso descrito, qual a alternativa correta?', 'Trata-se de febre reumática em atividade (poliartrite migratória de grandes articulações + cardite com sopro mitral novo, em contexto de amigdalites de repetição); a cardite é a manifestação mais grave da doença, podendo deixar sequelas e levar a óbito — alternativa C.', 'O quadro (poliartrite migratória de grandes articulações, febre, história de amigdalites de repetição e sopro mitral novo com taquicardia) é característico de febre reumática em atividade. A cardite é reconhecida como a manifestação mais grave da doença, por poder deixar sequelas valvares permanentes e, em casos extremos, levar a óbito — alternativa C.

Por que as outras alternativas estão incorretas:
• A) Na fase aguda, a lesão valvar mais frequente é a regurgitação MITRAL (não aórtica), seguida pela aórtica.
• B) As lesões que resultam em ESTENOSE valvar (fibrose/fusão comissural) ocorrem mais TARDIAMENTE (anos depois, após surtos repetidos), não precocemente — na fase aguda predomina a regurgitação.
• D) O prolongamento do intervalo PR é achado comum, mas não está SEMPRE presente mesmo na ausência de cardite — é um critério menor, não universal.
• E) Os nódulos subcutâneos são, na verdade, achados INCOMUNS (presentes em uma minoria bem menor de pacientes) e costumam se associar a cardite mais GRAVE, não sem relação com ela.'),

('4f21efcd-fe9c-4fcf-a155-8c468286433d', 'Válvula', 2018, 'TEC', 'A febre reumática (FR) é uma doença com múltiplas manifestações clínicas. O diagnóstico é auxiliado pelos critérios de Jones modificados (1992), que envolvem achados clínicos e laboratoriais, classificados como critérios maiores e menores. Em relação aos critérios maiores de Jones para o diagnóstico da febre reumática, escolha a alternativa CORRETA:', 'A artrite migratória (envolvimento sequencial de grandes articulações) é, de fato, mais frequente e mais proeminente em adolescentes e adultos jovens, enquanto a cardite tende a predominar e ser mais grave nas crianças mais novas — alternativa B.', 'Entre as manifestações maiores da febre reumática, há um padrão etário reconhecido: a poliartrite migratória (envolvimento sequencial das articulações) é mais frequente e proeminente em adolescentes e adultos jovens, enquanto a cardite tende a ser mais comum e mais grave nas crianças mais novas (especialmente abaixo de 6 anos) — alternativa B.

Por que as outras alternativas estão incorretas:
• A) A incidência/gravidade da cardite é, na verdade, MAIOR nas crianças mais novas (< 6 anos) do que nos adolescentes — o padrão descrito está invertido.
• C) A Coreia de Sydenham, apesar de ter latência mais longa (semanas a meses após a infecção estreptocócica), é mais frequente no sexo FEMININO, não masculino.
• D) Os nódulos subcutâneos costumam surgir mais TARDIAMENTE no curso da doença (associados a cardite mais grave) e são tipicamente transitórios (dias a poucas semanas), não persistindo por mais de um ano.
• E) O eritema marginatum acomete classicamente o TRONCO e a porção proximal dos membros (poupando a face), e está associado à presença de CARDITE, não a pacientes sem cardite.');

insert into public.question_options (id, question_id, letra, texto, correta) values

(gen_random_uuid(), '370583dd-3152-4df3-b41d-2ee9710217f7', 'a', 'O achado de hemocultura positiva única ou sorologia claramente positiva para Coxiella burnetii é considerado critério maior para o diagnóstico de EI.', true),
(gen_random_uuid(), '370583dd-3152-4df3-b41d-2ee9710217f7', 'b', 'Fenômenos imunológicos, como nódulos de Osler e aneurisma micótico, são critérios maiores para o diagnóstico de EI.', false),
(gen_random_uuid(), '370583dd-3152-4df3-b41d-2ee9710217f7', 'c', 'Febre persistente com temperaturas superiores a 38°, sem outra explicação alternativa, é a manifestação clínica mais frequente da EI, e é considerado critério maior para o diagnóstico de EI.', false),
(gen_random_uuid(), '370583dd-3152-4df3-b41d-2ee9710217f7', 'd', 'Achado de vegetação no ecocardiograma transtorácico é critério menor para o diagnóstico de EI.', false),
(gen_random_uuid(), '370583dd-3152-4df3-b41d-2ee9710217f7', 'e', 'O achado de três critérios menores permite o diagnóstico definitivo de EI.', false),

(gen_random_uuid(), 'd80ccdf9-a64a-4ecb-bff5-92ae2821d5bd', 'a', 'Os três critérios clínicos maiores abrangem achados de hemocultura, ecocardiograma e exame físico.', false),
(gen_random_uuid(), 'd80ccdf9-a64a-4ecb-bff5-92ae2821d5bd', 'b', 'Não há como excluir o diagnóstico de EI pela duração da resposta à antibioticoterapia.', false),
(gen_random_uuid(), 'd80ccdf9-a64a-4ecb-bff5-92ae2821d5bd', 'c', 'Entre os critérios clínicos menores, existem os fenômenos vasculares: embolia arterial, aneurisma micótico, infartos pulmonares sépticos e manchas de Roth.', false),
(gen_random_uuid(), 'd80ccdf9-a64a-4ecb-bff5-92ae2821d5bd', 'd', 'O achado de microrganismos típicos consistentes com EI em duas hemoculturas separadas é um critério maior para o diagnóstico.', true),
(gen_random_uuid(), 'd80ccdf9-a64a-4ecb-bff5-92ae2821d5bd', 'e', 'Entre os critérios clínicos menores existem os fenômenos imunológicos: lesões de Janeway, nódulos de Osler, glomerulonefrite e fator reumatoide.', false),

(gen_random_uuid(), 'b27325d4-cbb6-4a2a-bd05-f5fced72c678', 'a', 'Tratamento cirúrgico com retroca valvar aórtica e troca valvar mitral.', false),
(gen_random_uuid(), 'b27325d4-cbb6-4a2a-bd05-f5fced72c678', 'b', 'Manutenção de seguimento clínico.', false),
(gen_random_uuid(), 'b27325d4-cbb6-4a2a-bd05-f5fced72c678', 'c', 'Tratamento transcateter – valve-in-valve aórtico.', false),
(gen_random_uuid(), 'b27325d4-cbb6-4a2a-bd05-f5fced72c678', 'd', 'Valvoplastia aórtica por cateter-balão.', false),
(gen_random_uuid(), 'b27325d4-cbb6-4a2a-bd05-f5fced72c678', 'e', 'Tratamento cirúrgico com retroca da valva aórtica.', true),

(gen_random_uuid(), '09ce0ecc-ac14-47a6-afc7-9bb22c2a9dcf', 'a', 'A suspeita principal é de trombose em prótese metálica na posição mitral.', false),
(gen_random_uuid(), '09ce0ecc-ac14-47a6-afc7-9bb22c2a9dcf', 'b', 'A ocorrência deste fenômeno é mais frequente em posição aórtica.', false),
(gen_random_uuid(), '09ce0ecc-ac14-47a6-afc7-9bb22c2a9dcf', 'c', 'São considerados complicadores imagem de massa menor que 5 mm, hipertensão pulmonar (PSAP > 50 mmHg) e fibrilação atrial.', false),
(gen_random_uuid(), '09ce0ecc-ac14-47a6-afc7-9bb22c2a9dcf', 'd', 'Espera-se na ausculta o abafamento do click metálico.', false),
(gen_random_uuid(), '09ce0ecc-ac14-47a6-afc7-9bb22c2a9dcf', 'e', 'Na presença de grave repercussão clínica e alto risco de sangramento, recomenda-se a troca da prótese.', true),

(gen_random_uuid(), '9c90c2b7-76c9-4b77-94c6-e30d8c3472c9', 'a', 'Anticoagulação por via oral com cumarínicos, devendo-se reavaliar o paciente após 30 dias com ecocardiograma transtorácico, indicando-se internação se não houver melhora.', false),
(gen_random_uuid(), '9c90c2b7-76c9-4b77-94c6-e30d8c3472c9', 'b', 'Cirurgia imediata para retirada do trombo.', false),
(gen_random_uuid(), '9c90c2b7-76c9-4b77-94c6-e30d8c3472c9', 'c', 'Internação para realizar anticoagulação administrada via intravenosa por uma semana, com reavaliação posterior com ecocardiograma transesofágico, devendo-se considerar cirurgia caso não haja melhora.', true),
(gen_random_uuid(), '9c90c2b7-76c9-4b77-94c6-e30d8c3472c9', 'd', 'Fibrinólise imediata, com indicação cirúrgica posterior se não houver resolução do trombo.', false),
(gen_random_uuid(), '9c90c2b7-76c9-4b77-94c6-e30d8c3472c9', 'e', 'Internação, com administração de antiplaquetários e anticoagulantes por via oral (dupla terapia) por uma semana, quando deve ser realizada tomografia computadorizada e administração de anticoagulação intravenosa, caso não haja resolução do trombo.', false),

(gen_random_uuid(), 'a8b9ccdf-bfb3-454b-98af-cc46faf63c1a', 'a', 'Na investigação da EI, o ecocardiograma transesofágico tem maior acurácia diagnóstica do que o ecocardiograma transtorácico nas próteses valvares, mas acurácia semelhante nas valvas nativas.', false),
(gen_random_uuid(), 'a8b9ccdf-bfb3-454b-98af-cc46faf63c1a', 'b', 'Um ecocardiograma transtorácico normal é suficiente para descartar EI em pacientes portadores de dispositivos intracavitários.', false),
(gen_random_uuid(), 'a8b9ccdf-bfb3-454b-98af-cc46faf63c1a', 'c', 'O achado em paciente com EI de vegetações móveis no folheto anterior da valva mitral com mais de 5 mm² representa indicação de tratamento cirúrgico.', false),
(gen_random_uuid(), 'a8b9ccdf-bfb3-454b-98af-cc46faf63c1a', 'd', 'No diagnóstico diferencial ecocardiográfico das lesões valvares da EI, pode-se incluir degeneração mixomatosa, ruptura espontânea de corda tendínea, fibroelastoma papilar e excrescências de Lambl.', true),
(gen_random_uuid(), 'a8b9ccdf-bfb3-454b-98af-cc46faf63c1a', 'e', 'Achado diagnóstico de EI pelo ecocardiograma transtorácico dispensa a realização de ecocardiograma transesofágico em pacientes com risco de complicações da doença.', false),

(gen_random_uuid(), 'e3e04272-cac8-49b8-9351-0b75e1fc767e', 'a', 'O tamanho da vegetação encontrada não define conduta cirúrgica.', false),
(gen_random_uuid(), 'e3e04272-cac8-49b8-9351-0b75e1fc767e', 'b', 'As alterações cutâneas observadas nas figuras são consideradas critério maior (Duke) para o diagnóstico.', false),
(gen_random_uuid(), 'e3e04272-cac8-49b8-9351-0b75e1fc767e', 'c', 'Antibioticoterapia por quatro semanas e reavaliação ecocardiográfica posterior.', false),
(gen_random_uuid(), 'e3e04272-cac8-49b8-9351-0b75e1fc767e', 'd', 'A adição da rifampicina ao esquema antibiótico proposto não está indicada.', false),
(gen_random_uuid(), 'e3e04272-cac8-49b8-9351-0b75e1fc767e', 'e', 'Iniciar antibioticoterapia e indicar cirurgia de urgência de troca valvar.', true),

(gen_random_uuid(), '5df966fe-c6f9-4663-bb75-43b98aa4ba65', 'a', 'A EI na valva aórtica bicúspide associa-se à maior incidência de complicações perianulares, sendo preditora de extensão perivalvar da infecção.', true),
(gen_random_uuid(), '5df966fe-c6f9-4663-bb75-43b98aa4ba65', 'b', 'A insuficiência mitral associada à calcificação do anel valvar é a condição predisponente mais frequente de EI.', false),
(gen_random_uuid(), '5df966fe-c6f9-4663-bb75-43b98aa4ba65', 'c', 'A insuficiência mitral funcional associada ao remodelamento do ventrículo esquerdo é comumente complicada por EI.', false),
(gen_random_uuid(), '5df966fe-c6f9-4663-bb75-43b98aa4ba65', 'd', 'Entre as cardiopatias congênitas, as lesões obstrutivas do trato de saída ventricular e os defeitos do septo atrial são as lesões mais vezes associadas à EI.', false),
(gen_random_uuid(), '5df966fe-c6f9-4663-bb75-43b98aa4ba65', 'e', 'As valvas com lesões estenóticas têm suscetibilidade à infecção semelhante àquelas com lesões de insuficiência.', false),

(gen_random_uuid(), 'd7f43fe6-ebf6-4558-94a3-ae7c94733db1', 'a', 'Deve ser considerado na presença de insuficiência cardíaca, alto risco de embolia e infecção não controlada.', true),
(gen_random_uuid(), 'd7f43fe6-ebf6-4558-94a3-ae7c94733db1', 'b', 'Não existem evidências científicas que indiquem melhora da mortalidade da EI com o tratamento cirúrgico mais precoce.', false),
(gen_random_uuid(), 'd7f43fe6-ebf6-4558-94a3-ae7c94733db1', 'c', 'Evita a necessidade de antibioticoterapia após a intervenção.', false),
(gen_random_uuid(), 'd7f43fe6-ebf6-4558-94a3-ae7c94733db1', 'd', 'Na EI de valvas cardíacas, a primeira opção de tratamento cirúrgico é o implante de prótese valvar biológica.', false),
(gen_random_uuid(), 'd7f43fe6-ebf6-4558-94a3-ae7c94733db1', 'e', 'Contraindica-se a realização da cirurgia de revascularização miocárdica associada ao tratamento cirúrgico da EI.', false),

(gen_random_uuid(), 'ea0421bd-88ca-4451-83c9-0aa31f554419', 'a', 'A incidência de trombose em prótese mecânica em posição tricúspide é baixa em razão da maior pressão do fluxo de sangue sobre a superfície protética, reduzindo o depósito de fibrina.', false),
(gen_random_uuid(), 'ea0421bd-88ca-4451-83c9-0aa31f554419', 'b', 'Está indicado o uso de trombolítico em trombose de prótese valvar em posição tricúspide e pode ser usado rTPA ou estreptoquinase.', true),
(gen_random_uuid(), 'ea0421bd-88ca-4451-83c9-0aa31f554419', 'c', 'Em geral, procedimento cirúrgico é indicado em casos de trombose de prótese em câmaras direitas, com grave repercussão clínica e alto risco de sangramento.', false),
(gen_random_uuid(), 'ea0421bd-88ca-4451-83c9-0aa31f554419', 'd', 'O tratamento de escolha nestes casos é a heparinização plena, seguida do uso dos novos anticoagulantes orais (NOACs), já que estes têm comprovada eficácia nos pacientes portadores de prótese mecânica.', false),
(gen_random_uuid(), 'ea0421bd-88ca-4451-83c9-0aa31f554419', 'e', 'A trombólise não está indicada na presença de trombo pequeno (< 0,8 cm²), exceto em casos de classe funcional New York Heart Association (NYHA) IV.', false),

(gen_random_uuid(), 'd51bb0a3-17a7-48cc-8297-3e15a64f9fd3', 'a', 'Formação de abscesso perivalvar exige tratamento antibiótico prolongado antes da definição cirúrgica.', false),
(gen_random_uuid(), 'd51bb0a3-17a7-48cc-8297-3e15a64f9fd3', 'b', 'EI mitral ou aórtica com vegetação maior que 10 mm no ecocardiograma, apresentando evento embólico, tem indicação de tratamento antibiótico e anticoagulante antes da decisão cirúrgica.', false),
(gen_random_uuid(), 'd51bb0a3-17a7-48cc-8297-3e15a64f9fd3', 'c', 'Pacientes com ruptura do seio de Valsalva em outra estrutura, levando à insuficiência cardíaca, devem ser submetidos à cirurgia como emergência.', true),
(gen_random_uuid(), 'd51bb0a3-17a7-48cc-8297-3e15a64f9fd3', 'd', 'A infecção não controlada pelo tratamento antibiótico é a causa mais frequente de indicação de tratamento cirúrgico para a EI.', false),
(gen_random_uuid(), 'd51bb0a3-17a7-48cc-8297-3e15a64f9fd3', 'e', 'Após um acidente vascular cerebral embólico, complicando a EI, se houver indicação de cirurgia, esta deve ser adiada por 4 semanas, independentemente da condição neurológica do paciente.', false),

(gen_random_uuid(), 'e0c80606-e3de-41e0-99c7-4454ff19a0f7', 'a', 'Por se tratar de prótese aórtica, o uso de anticoagulantes orais diretos, como dabigatrana ou rivaroxabana, seria alternativa razoável à varfarina para este paciente.', false),
(gen_random_uuid(), 'e0c80606-e3de-41e0-99c7-4454ff19a0f7', 'b', 'O paciente deve ser orientado a evitar uso de dipirona como analgésico, dando preferência ao paracetamol ou anti-inflamatórios não hormonais.', false),
(gen_random_uuid(), 'e0c80606-e3de-41e0-99c7-4454ff19a0f7', 'c', 'Por se tratar de prótese metálica, o INR deve ser mantido na faixa entre 2,5 e 3,5.', false),
(gen_random_uuid(), 'e0c80606-e3de-41e0-99c7-4454ff19a0f7', 'd', 'Não é necessária a abstenção da ingesta de folhas verdes e outros alimentos ricos em vitamina K.', true),
(gen_random_uuid(), 'e0c80606-e3de-41e0-99c7-4454ff19a0f7', 'e', 'Suplementos vitamínicos à base de vitamina E estão liberados para este paciente.', false),

(gen_random_uuid(), '77ac66bf-7806-454c-ade6-ae83cb8f8b52', 'a', 'Todos os pacientes com próteses mecânicas são proibidos de realizar ressonância nuclear magnética.', false),
(gen_random_uuid(), '77ac66bf-7806-454c-ade6-ae83cb8f8b52', 'b', 'Fibrinólise está indicada como primeira escolha para todos os pacientes com trombose de prótese.', false),
(gen_random_uuid(), '77ac66bf-7806-454c-ade6-ae83cb8f8b52', 'c', 'As próteses biológicas são as preferidas por pacientes jovens, enquanto as mecânicas por pacientes mais idosos.', false),
(gen_random_uuid(), '77ac66bf-7806-454c-ade6-ae83cb8f8b52', 'd', 'A incidência de trombose é maior nas próteses mecânicas em posição mitral que na aórtica.', true),
(gen_random_uuid(), '77ac66bf-7806-454c-ade6-ae83cb8f8b52', 'e', 'O uso dos novos anticoagulantes serve como alternativa para pacientes que trombosaram uma prótese mecânica mitral em uso de varfarina.', false),

(gen_random_uuid(), 'dfe6eb67-7657-4039-8a35-378a8f04b065', 'a', 'pacientes com FR sem cardite comprovada dispensam a profilaxia secundária', false),
(gen_random_uuid(), 'dfe6eb67-7657-4039-8a35-378a8f04b065', 'b', 'pacientes com cardiopatia reumática apresentando doença valvar grave devem fazer profilaxia secundária por toda a vida', true),
(gen_random_uuid(), 'dfe6eb67-7657-4039-8a35-378a8f04b065', 'c', 'pacientes com cardiopatia valvar reumática grave dispensam a profilaxia secundária da FR após o tratamento cirúrgico da doença valvar', false),
(gen_random_uuid(), 'dfe6eb67-7657-4039-8a35-378a8f04b065', 'd', 'pacientes com cardite e sequela de insuficiência mitral leve devem fazer profilaxia secundária da FR por cinco anos após o último ataque ou até os 18 anos de idade', false),
(gen_random_uuid(), 'dfe6eb67-7657-4039-8a35-378a8f04b065', 'e', 'pacientes com cardiopatia valvar reumática ou com próteses valvares devem fazer a prevenção secundária da FR com antibióticos em altas doses uma hora antes de procedimentos dentários e geniturinários', false),

(gen_random_uuid(), 'fc1da3c4-c351-46a7-8af2-1a350d69d01b', 'a', 'Trata-se de uma cardite reumática aguda e, em acompanhamento ecocardiográfico posterior, o surgimento de regurgitação mitral patológica classifica o caso como cardiopatia reumática crônica.', true),
(gen_random_uuid(), 'fc1da3c4-c351-46a7-8af2-1a350d69d01b', 'b', 'Trata-se de um quadro de febre reumática aguda leve, em geral autolimitada, que deve ser tratada com sintomáticos, repouso no leito e anti-inflamatórios não esteroides (AINEs), particularmente o ácido acetilsalicílico (AAS).', false),
(gen_random_uuid(), 'fc1da3c4-c351-46a7-8af2-1a350d69d01b', 'c', 'Trata-se de um quadro de endocardite aguda infecciosa, sendo indicada internação hospitalar para antibioticoterapia de largo espectro.', false),
(gen_random_uuid(), 'fc1da3c4-c351-46a7-8af2-1a350d69d01b', 'd', 'Nos casos de cardites moderada ou grave, idealmente deve-se iniciar a dose alta de anti-inflamatórios não esteroides (AINEs) por 14-21 dias e, posteriormente, inicia-se a redução progressiva da dose.', false),
(gen_random_uuid(), 'fc1da3c4-c351-46a7-8af2-1a350d69d01b', 'e', 'Considerando tratar-se de um caso leve de febre reumática aguda, a profilaxia secundária não precisa ser instituída.', false),

(gen_random_uuid(), '61436da1-347b-45d2-b295-dc24698aeaeb', 'a', 'A profilaxia para a febre reumática com cardite prévia, insuficiência mitral leve residual ou resolução da lesão valvar deve permanecer até os 25 anos de idade ou até 10 anos após o último surto, valendo o que cobrir maior período.', true),
(gen_random_uuid(), '61436da1-347b-45d2-b295-dc24698aeaeb', 'b', 'Para portadores de valvopatia reumática, não é recomendado o uso de lidocaína sem vasoconstritor como medida para diminuir a dor durante a aplicação, pois interfere na ação da penicilina benzatina.', false),
(gen_random_uuid(), '61436da1-347b-45d2-b295-dc24698aeaeb', 'c', 'A duração da profilaxia para a febre reumática com cardite prévia deve ser até os 21 anos de idade ou até 5 anos após o último surto, valendo o que cobrir maior período.', false),
(gen_random_uuid(), '61436da1-347b-45d2-b295-dc24698aeaeb', 'd', 'Em casos de lesão valvar residual moderada a grave, a profilaxia deve permanecer até os 21 anos de idade ou por toda a vida.', false),
(gen_random_uuid(), '61436da1-347b-45d2-b295-dc24698aeaeb', 'e', 'A profilaxia com penicilina G-benzatina deve ser aplicada a cada 15 dias até os 18 anos de idade e, depois dos 18 anos, a cada 30 dias.', false),

(gen_random_uuid(), 'ac0b26b5-3f3e-4665-881b-353748f20c57', 'a', 'A sulfadiazina pode ser usada com segurança na gravidez, pois não traz riscos potenciais para o feto.', false),
(gen_random_uuid(), 'ac0b26b5-3f3e-4665-881b-353748f20c57', 'b', 'A profilaxia secundária deve ser suspensa durante a gestação, devido aos efeitos colaterais no feto.', false),
(gen_random_uuid(), 'ac0b26b5-3f3e-4665-881b-353748f20c57', 'c', 'O único antibiótico que deve ser restringido durante a gravidez é a eritromicina.', false),
(gen_random_uuid(), 'ac0b26b5-3f3e-4665-881b-353748f20c57', 'd', 'Reações anafiláticas verdadeiras à penicilina são frequentes durante a gestação, ocorrendo em cerca de 0,1% dos casos.', false),
(gen_random_uuid(), 'ac0b26b5-3f3e-4665-881b-353748f20c57', 'e', 'A profilaxia secundária deve continuar durante toda a vigência da gravidez para evitar a recorrência da febre reumática.', true),

(gen_random_uuid(), 'cfb8edea-30cf-4d8a-81f6-0b7210704d61', 'a', 'A penicilina G benzatina intramuscular é utilizada na dose de 600.000 UI para peso < 50 kg e na dose de 1.200.000 UI para peso ≥ 50 kg.', false),
(gen_random_uuid(), 'cfb8edea-30cf-4d8a-81f6-0b7210704d61', 'b', 'Portadores de FR com cardite prévia, insuficiência mitral leve residual ou resolução da lesão valvar devem realizar profilaxia secundária da FR até os 40 anos.', false),
(gen_random_uuid(), 'cfb8edea-30cf-4d8a-81f6-0b7210704d61', 'c', 'A prescrição de profilaxia secundária para a FR com drogas por via oral (penicilina V) tem eficácia preventiva igual à penicilina G benzatina intramuscular.', false),
(gen_random_uuid(), 'cfb8edea-30cf-4d8a-81f6-0b7210704d61', 'd', 'Portadores de lesões valvares importantes pela cardiopatia reumática crônica e que sejam submetidos à cirurgia valvar devem realizar profilaxia secundária da FR por toda a vida.', true),
(gen_random_uuid(), 'cfb8edea-30cf-4d8a-81f6-0b7210704d61', 'e', 'No passado, a sulfadiazina podia ser usada para a prevenção secundária da FR em pacientes alérgicos à penicilina, mas atualmente não é mais recomendada nesta situação, visto que drogas mais modernas são as preferidas.', false),

(gen_random_uuid(), 'a35e46d9-e2da-4d83-8ff3-948c329922ea', 'a', 'Na fase aguda, a lesão mais frequente é a regurgitação aórtica, seguida pela regurgitação mitral.', false),
(gen_random_uuid(), 'a35e46d9-e2da-4d83-8ff3-948c329922ea', 'b', 'As lesões que resultam em estenose valvar ocorrem mais precocemente.', false),
(gen_random_uuid(), 'a35e46d9-e2da-4d83-8ff3-948c329922ea', 'c', 'É um quadro de febre reumática em atividade e a cardite é a manifestação mais grave da doença, pois pode deixar sequelas e acarretar óbito.', true),
(gen_random_uuid(), 'a35e46d9-e2da-4d83-8ff3-948c329922ea', 'd', 'O intervalo PR no eletrocardiograma (ECG) sempre está aumentado em pacientes com febre reumática, mesmo na ausência de cardite.', false),
(gen_random_uuid(), 'a35e46d9-e2da-4d83-8ff3-948c329922ea', 'e', 'Os nódulos subcutâneos são frequentes, presentes em 20% dos pacientes, e não têm relação com cardite grave.', false),

(gen_random_uuid(), '4f21efcd-fe9c-4fcf-a155-8c468286433d', 'a', 'A cardite é a manifestação mais grave da FR, uma vez que pode levar à doença cardíaca reumática crônica. A incidência de cardite é maior nos adolescentes do que nas crianças com até 6 anos de idade.', false),
(gen_random_uuid(), '4f21efcd-fe9c-4fcf-a155-8c468286433d', 'b', 'A artrite é descrita como migratória, que se refere ao envolvimento sequencial das articulações, sendo mais frequente e grave em adultos jovens do que em adolescentes e crianças.', true),
(gen_random_uuid(), '4f21efcd-fe9c-4fcf-a155-8c468286433d', 'c', 'A Coreia de Sydenham tem período de latência mais longo, ocorrendo seis a oito semanas após episódio de faringite estreptocócica e sendo mais frequente no sexo masculino.', false),
(gen_random_uuid(), '4f21efcd-fe9c-4fcf-a155-8c468286433d', 'd', 'Podem ocorrer nódulos subcutâneos, semelhantes àqueles da artrite reumatoide. São geralmente vistos nos estágios precoces da FR e persistem por mais de um ano após o episódio agudo.', false),
(gen_random_uuid(), '4f21efcd-fe9c-4fcf-a155-8c468286433d', 'e', 'O eritema marginatum ocorre em membros superiores, tronco e face, com um rash rosado centrífugo e pele central normal, afetando principalmente os pacientes sem cardite.', false);







