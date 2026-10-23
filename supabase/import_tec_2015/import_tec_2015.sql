-- IMPORT TEC 2015: 70 questões novas (instituição 'TEC', ano 2015), com tema, comentário curto e completo.
-- Gabarito: oficial pós-recurso da SBC (errata 2015). Questões 22, 61 e 62 foram ANULADAS: todas as alternativas ficam corretas.
-- ANTES de rodar: suba as 4 imagens da pasta imagens/ para o bucket "question-images" (Q20, Q68, Q118 e Q120 dependem delas).
-- Cada questão tem trava própria: se o enunciado já existir (TEC 2015), ela é pulada. Pode rodar mais de uma vez sem duplicar.
-- Roda numa única transação.

begin;

-- ===================== [TEC 2015 #1] Sd. Coronariana Aguda — Gabarito: E =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Sd. Coronariana Aguda$Q$, 2015, 'TEC', $Q$São achados epidemiológicos e variáveis fisiológicas que exibem variações circadianas e são determinantes durante o processo de ruptura da placa ateromatosa e da trombose coronária, EXCETO:$Q$, $Q$Pressão arterial, frequência cardíaca, viscosidade sanguínea e cortisol têm pico matinal e favorecem a ruptura da placa; o pico não ocorre no anoitecer — alternativa E.$Q$, $Q$O infarto e a morte súbita têm distribuição circadiana, com pico nas primeiras horas após acordar (aproximadamente entre 6h e 12h). Isso se explica por variações fisiológicas que se concentram nesse período e favorecem a ruptura da placa e a trombose:
• Elevação da pressão arterial sistólica e da frequência cardíaca, com aumento do estresse de cisalhamento sobre a placa.
• Pico de cortisol e de catecolaminas ao despertar.
• Aumento da viscosidade sanguínea, da agregabilidade plaquetária e queda da atividade fibrinolítica (PAI-1 elevado pela manhã).
• Vasoconstrição coronariana e aumento do tônus simpático.

Dica de prova: o enunciado pede o que NÃO varia/NÃO se relaciona, e o período de maior risco é o início da manhã, não o anoitecer.

Por que as outras alternativas estão incorretas:
• A) A PAS sobe de forma abrupta ao despertar (surge matinal) e participa do estresse mecânico sobre a placa.
• B) A frequência cardíaca aumenta pela manhã com a ativação simpática, elevando a demanda de oxigênio e o estresse sobre a placa.
• C) A viscosidade sanguínea é maior nas primeiras horas do dia, favorecendo a trombose.
• D) O cortisol tem pico logo ao acordar e contribui para a reatividade vascular e plaquetária no período de maior risco.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$São achados epidemiológicos e variáveis fisiológicas que exi$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Níveis da pressão arterial sistólica.$Q$, false),
    ('B', $Q$Frequência cardíaca.$Q$, false),
    ('C', $Q$Viscosidade sanguínea.$Q$, false),
    ('D', $Q$Níveis plasmáticos de cortisol.$Q$, false),
    ('E', $Q$Primeiras horas do anoitecer.$Q$, true)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #3] Coronária Crônica — Gabarito: A =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Coronária Crônica$Q$, 2015, 'TEC', $Q$Em pacientes portadores de doença coronária multiarterial, assinale a alternativa ERRADA.$Q$, $Q$Lesões de tronco de coronária esquerda nem sempre exigem cirurgia: as de óstio e corpo, com anatomia favorável e Syntax baixo, podem ser tratadas por angioplastia — alternativa A.$Q$, $Q$Questão do tipo ERRADA: a alternativa-resposta é a falsa.

Na doença coronária multiarterial, a escolha entre cirurgia (RM) e angioplastia (ICP) depende da anatomia, da complexidade, do diabetes e da experiência da equipe:
• Lesão de tronco isolada, de óstio ou corpo, com escore Syntax baixo (até 22), pode ser tratada com ICP com resultados comparáveis à cirurgia (estudos SYNTAX e EXCEL); a lesão distal, que envolve a bifurcação, é mais complexa e tende a favorecer a cirurgia. Portanto, dizer que todo tronco deve ir para a cirurgia, independentemente da localização, é falso.
• Doença extensa e anatomia complexa (Syntax intermediário e alto) favorecem a cirurgia.
• No SYNTAX, o escore discriminou o prognóstico da ICP, mas não o da RM.
• No FREEDOM (diabéticos multiarteriais), a cirurgia reduziu mortes e infartos em comparação com a ICP com stent farmacológico, mesmo nos biarteriais.
• A decisão deve ser compartilhada pelo heart team e considerar a experiência de cada serviço.

Dica de prova: absolutos como independentemente e sempre costumam indicar a alternativa falsa.

Por que as outras alternativas estão incorretas:
• B) Verdadeira: quanto maior a extensão e a complexidade anatômica (Syntax alto), maior o benefício da cirurgia.
• C) Verdadeira: o resultado local de cada equipe é um critério reconhecido pelas diretrizes na decisão do heart team.
• D) Verdadeira: no estudo SYNTAX, o escore previu eventos nos pacientes submetidos a ICP, mas não nos submetidos a RM.
• E) Verdadeira: o FREEDOM mostrou vantagem da cirurgia em diabéticos multiarteriais, incluindo os com doença em dois vasos.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$Em pacientes portadores de doença coronária multiarterial, a$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Lesões de tronco, independentemente da localização, devem ser tratadas cirurgicamente.$Q$, true),
    ('B', $Q$Maior extensão da doença e complexidade anatômica (escore Syntax) são preferencialmente cirúrgicos.$Q$, false),
    ('C', $Q$A experiência/resultados das equipes cirúrgica e hemodinâmica devem ser avaliados para estratégia terapêutica.$Q$, false),
    ('D', $Q$O escore angiográfico Syntax mostrou-se bom discriminador prognóstico para a intervenção coronária percutânea, mas não para a cirurgia de revascularização miocárdica.$Q$, false),
    ('E', $Q$Em relação ao diabetes, mesmo em biarteriais, o estudo FREEDOM demonstrou vantagem para a cirurgia.$Q$, false)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #4] Válvula — Gabarito: B =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Válvula$Q$, 2015, 'TEC', $Q$Mulher, 26 anos, na 34a semana de gestação, portadora de estenose mitral, previamente assintomática, procura serviço de emergência com queixa de dispneia progressiva até aos menores esforços que os habituais nas últimas duas semanas. Apresenta ortopneia e dispneia paroxística noturna. Ao exame físico: estado geral regular, pálida, sudorreica, taquidispneica (FR = 32 ipm), taquicárdica (FC = 138 bpm), bulhas rítmicas de difícil ausculta com B1 hiperfonética, PA = 116 x 68 mmHg. Ausculta respiratória com estertores crepitantes bilaterais até o terço médio, saturação de oxigênio de 85% (em ar ambiente).

Assinale a alternativa CORRETA acerca do tratamento neste momento.$Q$, $Q$Na estenose mitral com edema pulmonar na gestação, reduzir a frequência cardíaca com betabloqueador cardiosseletivo, como o metoprolol, prolonga a diástole e alivia a congestão — alternativa B.$Q$, $Q$Na estenose mitral, o gradiente transvalvar depende do tempo de enchimento diastólico. A gestação aumenta volume, débito e frequência cardíaca, o que eleva o gradiente e a pressão atrial esquerda e pode precipitar edema pulmonar, como neste caso (FC 138, estertores, saturação de 85%).
• Medida central: reduzir a FC para prolongar a diástole. Os betabloqueadores são o fármaco de escolha; os cardiosseletivos (metoprolol) são preferidos por menor interferência na vasodilatação uterina.
• Diuréticos de alça tratam a congestão pulmonar; oxigênio e posição sentada fazem parte do tratamento inicial.
• Se refratária, considerar valvoplastia mitral por cateter-balão, que é a opção segura em gestantes com anatomia favorável.
• Evitar fármacos que causam taquicardia reflexa ou teratogênicos (IECA, BRA, espironolactona).

Dica de prova: diante de estenose mitral, pense primeiro em controlar a frequência cardíaca.

Por que as outras alternativas estão incorretas:
• A) O nitroprussiato atravessa a placenta e pode causar toxicidade fetal por cianeto; é reservado para situações extremas e por curto período. Também não é a descrição correta de simpaticolítico.
• C) Verapamil e diltiazem são antagonistas de cálcio NÃO di-idropiridínicos; a alternativa erra a classificação ao chamá-los de di-idropiridínicos.
• D) A nitroglicerina é um vasodilatador, sobretudo venoso, e não um simpaticolítico; também não é correto afirmar que não atravessa a placenta como justificativa de segurança.
• E) A hidralazina é vasodilatador arterial e reduz a pós-carga, não a pré-carga; além disso, causa taquicardia reflexa, indesejada na estenose mitral.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$Mulher, 26 anos, na 34a semana de gestação, portadora de est$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$O nitroprussiato de sódio é um anti-hipertensivo simpaticolítico, vasodilatador arterial e venoso potente que pode ser utilizado com segurança por não atravessar a placenta.$Q$, false),
    ('B', $Q$O metoprolol é um betabloqueador sem atividade simpatomimética intrínseca e pode ser usado para controle de frequência cardíaca nessa paciente.$Q$, true),
    ('C', $Q$Os antagonistas dos canais de cálcio di-idropiridínicos, como o verapamil e o diltiazem, não são fármacos seguros para essa paciente.$Q$, false),
    ('D', $Q$A nitroglicerina é um anti-hipertensivo simpaticolítico, vasodilatador arterial e venoso potente, que pode ser utilizado com segurança por não atravessar a placenta.$Q$, false),
    ('E', $Q$A hidralazina é o fármaco de escolha para vasodilatação arterial, atuando na redução da pré-carga.$Q$, false)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #5] Saúde Cardiovascular da Mulher — Gabarito: D =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Saúde Cardiovascular da Mulher$Q$, 2015, 'TEC', $Q$Mulher, 26 anos, na 34a semana de gestação, portadora de estenose mitral, previamente assintomática, procura serviço de emergência com queixa de dispneia progressiva até aos menores esforços que os habituais nas últimas duas semanas. Apresenta ortopneia e dispneia paroxística noturna. Ao exame físico: estado geral regular, pálida, sudorreica, taquidispneica (FR = 32 ipm), taquicárdica (FC = 138 bpm), bulhas rítmicas de difícil ausculta com B1 hiperfonética, PA = 116 x 68 mmHg. Ausculta respiratória com estertores crepitantes bilaterais até o terço médio, saturação de oxigênio de 85% (em ar ambiente).

Após estabilização clínica inicial, assinale o tratamento medicamentoso para a doença cardíaca da gestante, com menor risco para o feto.$Q$, $Q$Em gestante normotensa com estenose mitral e edema pulmonar, o esquema mais simples e seguro é diurético de alça mais betabloqueador (furosemida e propranolol) — alternativa D.$Q$, $Q$Raciocínio da banca: a paciente tem estenose mitral descompensada (congestão pulmonar, taquicardia) e pressão arterial normal (116 x 68 mmHg). O tratamento é dirigido à fisiopatologia:
• Diurético de alça (furosemida): reduz a congestão pulmonar e a pressão atrial esquerda.
• Betabloqueador: reduz a frequência cardíaca, prolonga a diástole e diminui o gradiente transmitral; o propranolol é o betabloqueador clássico e de maior experiência em gestantes com estenose mitral.
• Não há indicação de anti-hipertensivo (metildopa ou hidralazina) em paciente normotensa, e fármacos desnecessários só acrescentam risco fetal.
• Devem ser evitados espironolactona (efeito antiandrogênico no feto masculino) e atenolol (associado a restrição de crescimento fetal).

Por isso, o esquema D (furosemida e propranolol) é o que trata a doença com o menor número de fármacos e sem os agentes mais criticados na gestação.

Dica de prova: gestante com estenose mitral e congestão: diurético e betabloqueador; evite atenolol, espironolactona, IECA e BRA.

Por que as outras alternativas estão incorretas:
• A) Contém espironolactona (antiandrogênica) e atenolol (restrição de crescimento fetal); metildopa não tem indicação em paciente normotensa.
• B) A metildopa é anti-hipertensivo e não tem indicação em paciente normotensa; o pindolol não é o betabloqueador de escolha para controle de frequência na estenose mitral.
• C) Contém hidralazina, que causa taquicardia reflexa (indesejada na estenose mitral) e não tem indicação em normotensa, além da espironolactona.
• E) A hidralazina é inadequada pela taquicardia reflexa e pela ausência de hipertensão; o atenolol deve ser evitado na gestação, e falta o diurético para a congestão.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$Mulher, 26 anos, na 34a semana de gestação, portadora de est$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Metildopa, espironolactona e atenolol.$Q$, false),
    ('B', $Q$Metildopa, furosemida e pindolol.$Q$, false),
    ('C', $Q$Hidralazina, espironolactona e pindolol.$Q$, false),
    ('D', $Q$Furosemida e propranolol.$Q$, true),
    ('E', $Q$Hidralazina e atenolol.$Q$, false)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #6] Fibrilação e Flutter — Gabarito: B =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Fibrilação e Flutter$Q$, 2015, 'TEC', $Q$Paciente feminina, 66 anos, hipertensa e diabética de longa data, não insulino-dependente com história de crises de palpitação de início recente. Não apresenta cardiopatia estrutural. História prévia de endarterectomia carotídea direita há dois anos. O clearance de creatinina estimado foi de 39 mL/min. Foi solicitado Holter de 24 horas, que documentou inúmeros episódios sustentados e não sustentados de fibrilação atrial, com reversão espontânea. Foi iniciado sotalol e a paciente manteve-se assintomática. Quais são a conduta recomendada para profilaxia de fenômeno tromboembólico nessa paciente e a respectiva justificativa pela estratificação de risco?$Q$, $Q$Paciente com CHADS2 de 2 e CHA2DS2-VASc de 5 (HAS, DM, idade 65-74, sexo feminino e doença vascular carotídea) deve receber anticoagulação; a varfarina com RNI 2-3 é a opção compatível com o clearance de 39 mL/min — alternativa B.$Q$, $Q$Cálculo do risco:
• CHADS2: hipertensão (1) + diabetes (1) = 2. Não há IC, AVC ou idade acima de 75 anos.
• CHA2DS2-VASc: hipertensão (1) + diabetes (1) + idade de 65 a 74 anos (1) + sexo feminino (1) + doença vascular, aqui a doença carotídea tratada com endarterectomia (1) = 5.
Com CHA2DS2-VASc de 5, há indicação clara de anticoagulação, independentemente de a FA ser paroxística ou persistente.

Escolha do fármaco: a depuração de creatinina é de 39 mL/min.
• Varfarina com RNI 2,0-3,0 é adequada e não exige ajuste pela função renal.
• Os novos anticoagulantes orais, em 2015, exigiam ajuste: rivaroxabana 15 mg/dia com clearance de 15 a 50 mL/min, apixabana 2,5 mg 2x/dia apenas se houver dois dos critérios (idade maior ou igual a 80 anos, peso até 60 kg, creatinina maior ou igual a 1,5 mg/dL).

Atualização: hoje se usa preferencialmente anticoagulante oral direto na FA não valvar, com a dose ajustada aos critérios de cada fármaco; a varfarina continua válida e é a opção em valvopatia mitral reumática e prótese mecânica.

Por que as outras alternativas estão incorretas:
• A) A rivaroxabana 20 mg é a dose para clearance acima de 50 mL/min; com 39 mL/min a dose seria 15 mg/dia. O CHA2DS2-VASc também não é 4 se contarmos a doença carotídea.
• C) CHADS2 igual a 3 está errado (não há IC, AVC ou idade acima de 75 anos); dabigatrana 110 mg 2x/dia não se aplica sem critério de redução e seu uso exige cautela com clearance reduzido.
• D) A apixabana 2,5 mg 2x/dia exige dois critérios de redução que a paciente não tem; CHA2DS2-VASc de 6 também está errado.
• E) A dabigatrana 75 mg não é dose do esquema brasileiro para essa situação; o escore informado também não considera a doença vascular.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$Paciente feminina, 66 anos, hipertensa e diabética de longa $Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Iniciar rivaroxabana, 20 mg/dia, por apresentar escore CHADS2: 2 e CHADSVASc: 4.$Q$, false),
    ('B', $Q$Iniciar varfarina (RNI: 2,0-3,0) por apresentar escore CHADS2: 2 e CHADSVASc: 5.$Q$, true),
    ('C', $Q$Iniciar dabigatrana (110 mg duas vezes/dia) por apresentar escore CHADS2: 3 e CHADSVASC: 5.$Q$, false),
    ('D', $Q$Iniciar apixabana (2,5 mg duas vezes/dia) por apresentar escore CHADS2: 2 e CHADSVASc: 6.$Q$, false),
    ('E', $Q$Iniciar dabigatrana (75 mg duas vezes/dia) por apresentar escore CHADS2: 2 e CHADSVASc: 4$Q$, false)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #7] Coronária Crônica — Gabarito: D =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Coronária Crônica$Q$, 2015, 'TEC', $Q$De acordo com a Diretriz de Doença Coronária Estável 2014, assinale a alternativa CORRETA:$Q$, $Q$A disfunção ventricular esquerda é o principal determinante prognóstico na doença coronária estável: o risco de morte é maior nesses pacientes, mesmo que a obstrução coronariana seja semelhante — alternativa D.$Q$, $Q$Raciocínio da banca, com base na Diretriz de Doença Coronária Estável (SBC, 2014):
• A função ventricular esquerda é o mais forte preditor de sobrevida na doença coronária crônica: pacientes com FEVE reduzida têm mortalidade maior, em relação aos de função preservada, mesmo com graus semelhantes de obstrução coronariana. Por isso a banca considerou verdadeira a assertiva D.
• Lesão do tronco da coronária esquerda deve ser discutida pelo heart team, mas o limiar de relevância é de obstrução igual ou maior que 50%, e não 30% como descrito na alternativa E, o que a torna incorreta.
• Em probabilidade pré-teste baixa, com ECG interpretável e boa capacidade física, o teste inicial é o ergométrico (e não a cintilografia).
• O escore de cálcio não se repete anualmente para acompanhar progressão.
• A trimetazidina inibe a oxidação de ácidos graxos e tem eficácia antianginosa inferior à dos betabloqueadores.

Dica de prova: preste atenção aos números nas alternativas (30% do tronco em vez de 50%).

Por que as outras alternativas estão incorretas:
• A) Com probabilidade pré-teste baixa, ECG interpretável e boa capacidade física, o teste inicial é o ergométrico; a cintilografia com estresse farmacológico fica para outros cenários.
• B) O escore de cálcio serve à estratificação inicial e não se repete anualmente para monitorar progressão.
• C) A trimetazidina inibe a oxidação de ácidos graxos (favorece a glicose) e tem eficácia antianginosa menor que a dos betabloqueadores.
• E) A recomendação de heart team é adequada para o tronco, mas o limiar usado na diretriz é de 50% de obstrução, e não 30%.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$De acordo com a Diretriz de Doença Coronária Estável 2014, a$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Por sua grande acurácia, a cintilografia de perfusão miocárdica com estresse farmacológico deve ser recomendada como teste inicial em pacientes com probabilidade pré-teste baixa de doença arterial coronariana (DAC), o eletrocardiograma (ECG) interpretável e boa capacidade física.$Q$, false),
    ('B', $Q$Por ser exame rápido, sem uso de contraste iodado, o escore de cálcio deve ser realizado anualmente para monitoração da progressão de aterosclerose em pacientes diabéticos assintomáticos.$Q$, false),
    ('C', $Q$A trimetazidina favorece a oxidação de ácidos graxos e tem eficácia antianginosa semelhante aos betabloqueadores.$Q$, false),
    ('D', $Q$Há maior risco de morte em pacientes com disfunção ventricular esquerda, independentemente do grau de obstrução coronariana.$Q$, true),
    ('E', $Q$Avaliação do heart team é recomendada para definição da melhor conduta intervencionista em paciente com lesão isolada do tronco de coronária esquerda (TCE) ≥ 30%.$Q$, false)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #9] Cardiologia do Esporte — Gabarito: E =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Cardiologia do Esporte$Q$, 2015, 'TEC', $Q$Assinale a alteração eletrocardiográfica relacionada ao treinamento que NÃO é comumente encontrada em atletas saudáveis de alto rendimento:$Q$, $Q$O infradesnivelamento do segmento ST não faz parte das alterações fisiológicas do coração do atleta e exige investigação — alternativa E.$Q$, $Q$O coração do atleta de alto rendimento apresenta alterações eletrocardiográficas fisiológicas, relacionadas ao tônus vagal aumentado e ao remodelamento:
• Bradicardia sinusal, arritmia sinusal e bloqueio atrioventricular de primeiro grau.
• Atraso final de condução pelo ramo direito (padrão rSr' em V1) e sinais de sobrecarga.
• Repolarização precoce (supradesnivelamento do ponto J com concavidade superior).
• Critérios de voltagem para hipertrofia ventricular esquerda isolados.

São achados anormais (que exigem investigação): infradesnivelamento do ST, inversão da onda T fora do padrão em V1-V3 de atletas jovens e o BAV de segundo grau Mobitz II ou de terceiro grau, entre outros.

Dica de prova: o infradesnivelamento do ST sugere isquemia ou cardiomiopatia e não é variante do treinamento.

Por que as outras alternativas estão incorretas:
• A) É comum e fisiológico, relacionado ao aumento do volume de câmaras direitas.
• B) A repolarização precoce é achado frequente e benigno no atleta.
• C) A bradicardia sinusal é efeito do aumento do tônus vagal e é esperada.
• D) O BAV de primeiro grau é comum e costuma desaparecer com o esforço.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$Assinale a alteração eletrocardiográfica relacionada ao trei$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Atraso final de condução pelo ramo direito.$Q$, false),
    ('B', $Q$Repolarização ventricular precoce.$Q$, false),
    ('C', $Q$Bradicardia sinusal.$Q$, false),
    ('D', $Q$Bloqueio atrioventricular de primeiro grau.$Q$, false),
    ('E', $Q$Infradesnivelamento do segmento ST.$Q$, true)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #11] Dislipidemia — Gabarito: A =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Dislipidemia$Q$, 2015, 'TEC', $Q$Assinale a alternativa CORRETA em relação aos sinais físicos e defeitos que possam estar associados com a hipercolesterolemia familiar, uma das formas genéticas mais frequentes e graves das dislipidemias de base genética.$Q$, $Q$A hipercolesterolemia familiar cursa com xantomas tendinosos, xantelasmas e arco corneal, por defeito do receptor de LDL — alternativa A.$Q$, $Q$A hipercolesterolemia familiar (HF) é causada, na maioria dos casos, por mutações do gene do receptor de LDL; outras causas são o defeito da apolipoproteína B-100 e o ganho de função do gene PCSK9 (pró-proteína convertase subtilisina kexina tipo 9). Resulta em LDL muito elevado desde o nascimento e doença coronária precoce.
• Sinais clínicos típicos: xantomas tendinosos (principalmente no tendão de Aquiles e nos extensores das mãos), xantelasmas, arco corneal em idade jovem.
• Xantomas eruptivos e lipemia retinalis ocorrem na hipertrigliceridemia grave (quilomicronemia).
• Xantoma planar e amígdalas alaranjadas lembram a doença de Tangier e outras condições; a opacidade de córnea ocorre em outras doenças raras.

Dica de prova: tendinoso é o xantoma da HF; eruptivo é o da hipertrigliceridemia.

Por que as outras alternativas estão incorretas:
• B) Xantomas eruptivos ocorrem na hipertrigliceridemia grave; a alternativa mistura xantomas eruptivos com defeito de ApoB.
• C) Xantomas tuberosos aparecem na disbetalipoproteinemia e a lipemia retinalis é da hipertrigliceridemia grave; o PCSK9 está relacionado à HF, mas a combinação de achados está errada.
• D) Amígdalas alaranjadas são típicas da doença de Tangier (deficiência de HDL), não da HF.
• E) Xantomas eruptivos não pertencem à HF, e o defeito da proteína adaptadora do receptor de LDL causa uma forma recessiva rara, não a mais frequente.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$Assinale a alternativa CORRETA em relação aos sinais físicos$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Xantomas tendinosos, xantelasmas, arco corneal e defeito do receptor de LDL.$Q$, true),
    ('B', $Q$Xantomas eruptivos, xantelasmas e defeito da Apo B.$Q$, false),
    ('C', $Q$Xantomas tuberosos, lipemia retinalis e defeito da pró-proteína convertase subtilisina kexina tipo 9.$Q$, false),
    ('D', $Q$Xantoma planar, amígdalas proeminentes e alaranjadas e opacidade de córnea.$Q$, false),
    ('E', $Q$Xantomas eruptivos e defeito da proteína adaptadora do receptor da LDL.$Q$, false)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #13] Cardio-oncologia — Gabarito: C =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Cardio-oncologia$Q$, 2015, 'TEC', $Q$Entre os agentes quimioterápicos para tratamento do câncer, qual agente está associado à maior incidência de cardiotoxicidade e evolução para insuficiência cardíaca?$Q$, $Q$A doxorrubicina, antraciclina, é o quimioterápico mais associado à cardiotoxicidade dose-dependente e à evolução para insuficiência cardíaca — alternativa C.$Q$, $Q$As antraciclinas (doxorrubicina, daunorrubicina, epirrubicina) causam cardiotoxicidade tipo I: lesão miocárdica irreversível por estresse oxidativo e dano ao DNA (topoisomerase 2-beta), dependente da dose cumulativa.
• Risco de insuficiência cardíaca aumenta de forma importante acima de 400 a 550 mg/m2 de doxorrubicina e é potencializado por radioterapia mediastinal, trastuzumabe, idade e fatores de risco.
• Outras drogas têm cardiotoxicidade, porém menos frequente ou reversível: trastuzumabe (tipo II, geralmente reversível), ciclofosfamida em altas doses, sunitinibe e bevacizumabe (hipertensão, disfunção ventricular) e paclitaxel (bradicardia, arritmias).

Dica de prova: antraciclina, dose cumulativa, lesão irreversível.

Por que as outras alternativas estão incorretas:
• A) O paclitaxel causa bradicardia e distúrbios de condução, mas raramente evolui para insuficiência cardíaca por si só.
• B) O sunitinibe causa hipertensão e disfunção ventricular em parte dos casos, porém em menor frequência que as antraciclinas.
• D) A ciclofosfamida pode causar miopericardite hemorrágica em altas doses, evento menos frequente.
• E) O bevacizumabe causa hipertensão e eventos tromboembólicos; a disfunção ventricular é menos comum.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$Entre os agentes quimioterápicos para tratamento do câncer, $Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Paclitaxel.$Q$, false),
    ('B', $Q$Sunitinibe.$Q$, false),
    ('C', $Q$Doxorrubicina.$Q$, true),
    ('D', $Q$Ciclofosfamida.$Q$, false),
    ('E', $Q$Bevacizumabe.$Q$, false)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #18] Miocárdio — Gabarito: A =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Miocárdio$Q$, 2015, 'TEC', $Q$Dentre os pacientes abaixo, qual é o que não teria indicação consensual para o tratamento etiológico da cardiopatia chagásica?$Q$, $Q$O tratamento etiológico com benznidazol não tem indicação consensual na cardiomiopatia chagásica dilatada crônica avançada com sintomas de insuficiência cardíaca — alternativa A.$Q$, $Q$O tratamento etiológico da doença de Chagas (benznidazol ou nifurtimox) tem indicação consensual em:
• Fase aguda, incluindo a transmissão oral (caldo de cana contaminado) e a acidental por material biológico (alternativas B e D).
• Reativação por imunossupressão, como na coinfecção pelo HIV (alternativa E).
• Crianças com doença crônica, em qualquer forma clínica (alternativa C).
• Forma crônica indeterminada em adultos, com indicação consensual na maioria dos casos.

Na cardiopatia chagásica crônica avançada, com dilatação, disfunção ventricular e insuficiência cardíaca, o benefício é incerto: o estudo BENEFIT mostrou que o benznidazol reduz a parasitemia, mas não reduz desfechos clínicos em pacientes com cardiomiopatia estabelecida. Nesses casos, o tratamento da insuficiência cardíaca é a prioridade.

Atualização: em 2015, o consenso excluía os casos de cardiopatia avançada; permanece como recomendação individualizada.

Por que as outras alternativas estão incorretas:
• B) Doença aguda por transmissão oral: tratamento indicado para reduzir a letalidade e obter cura.
• C) Crianças com Chagas crônica têm alta taxa de cura com o tratamento, e a indicação é consensual.
• D) Acidente com material perfurocortante: indica-se tratamento precoce por se tratar de infecção recém-adquirida.
• E) Reativação em imunossuprimido (HIV): tratamento indicado e urgente.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$Dentre os pacientes abaixo, qual é o que não teria indicação$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Paciente 60 anos, com diagnóstico de doença de Chagas há 10 anos, portador de cardiomiopatia dilatada, com piora dos sintomas congestivos nos últimos 6 meses.$Q$, true),
    ('B', $Q$Paciente 28 anos, com quadro de insuficiência cardíaca aguda, secundária à infestação por T. cruzi por ingesta de um caldo de cana.$Q$, false),
    ('C', $Q$Paciente 10 anos, com diagnóstico de doença de Chagas em sua forma arrítmica.$Q$, false),
    ('D', $Q$Técnico laboratorial 40 anos, contaminado com material perfurocortante com amostra contaminado com T. cruzi.$Q$, false),
    ('E', $Q$Paciente, 48 anos, portador crônico de doença de Chagas com reativação da doença após contaminação com HIV.$Q$, false)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #19] Endocardite Infecciosa — Gabarito: E =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Endocardite Infecciosa$Q$, 2015, 'TEC', $Q$Qual das situações abaixo é indicação para profilaxia da endocardite infecciosa, considerando pacientes de alto risco?$Q$, $Q$A profilaxia da endocardite em pacientes de alto risco está indicada em procedimentos odontológicos que manipulam o tecido gengival — alternativa E.$Q$, $Q$A profilaxia antibiótica da endocardite infecciosa é reservada a pacientes de maior risco (prótese valvar, endocardite prévia, cardiopatia congênita cianótica não corrigida ou com shunt/conduto paliativo, cardiopatia congênita reparada com material protético nos primeiros 6 meses ou com defeito residual, e transplantados cardíacos com valvopatia).
• Indicada em procedimentos odontológicos que manipulem a gengiva, a região periapical dos dentes ou perfurem a mucosa oral.
• Não indicada para procedimentos dos tratos respiratório, gastrointestinal e urinário sem infecção ativa e sem lesão de mucosa, nem para colocação ou ajuste de aparelho ortodôntico removível.

Dica de prova: dentário com manipulação gengival e paciente de alto risco, mesmo esquema: amoxicilina 2 g, 30 a 60 minutos antes.

Por que as outras alternativas estão incorretas:
• A) Procedimentos respiratórios sem incisão ou biópsia de mucosa não exigem profilaxia.
• B) Procedimentos do trato urinário sem infecção não exigem profilaxia.
• C) Procedimentos do trato gastrointestinal sem lesão de mucosa não exigem profilaxia.
• D) Colocação ou ajuste de aparelho removível não manipula a gengiva e não exige profilaxia.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$Qual das situações abaixo é indicação para profilaxia da end$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Intervenções no trato respiratório sem incisão ou biópsia.$Q$, false),
    ('B', $Q$Intervenções no trato urinário sem lesão de mucosa.$Q$, false),
    ('C', $Q$Intervenções no trato gastrointestinal sem lesão de mucosa.$Q$, false),
    ('D', $Q$Colocação ou ajuste de aparelho dentário removível.$Q$, false),
    ('E', $Q$Manipulação do tecido genvival.$Q$, true)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #20] Sd. Coronariana Aguda — Gabarito: B =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo, imagem_url)
  select $Q$Sd. Coronariana Aguda$Q$, 2015, 'TEC', $Q$Mulher, 77 anos, 80 kg, hipertensa, sem disfunção renal e com história de acidente vascular encefálico há quatro anos, comparece ao pronto-socorro com dor retroesternal de forte intensidade em aperto há 30 minutos, associada a náuseas. Na chegada, PA = 154 x 96 mmHg, FC = 116 bpm, afebril, saturação de oxigênio de 96% em ar ambiente e sem alterações cardiopulmonares no exame físico. O eletrocardiograma realizado na sala de emergência está a seguir. Devido à dor, foram administrados 2 mg de morfina, com melhora completa. Com relação ao tratamento desta paciente, neste momento, é CORRETO afirmar:$Q$, $Q$Em mulher de 77 anos com AVE prévio e SCA, prasugrel é contraindicado; o esquema com AAS, ticagrelor e enoxaparina, com internação monitorizada, é o adequado — alternativa B.$Q$, $Q$O ECG não está disponível; o raciocínio se apoia no contexto clínico e no esquema terapêutico de cada alternativa.
• Quadro: dor torácica típica prolongada, taquicardia, idade de 77 anos e hipertensão: síndrome coronariana aguda de risco elevado. A dor cedeu com morfina, e a conduta é internar com monitorização contínua e iniciar o tratamento antitrombótico, e não manter apenas observação com protocolo de dor torácica (alternativa D).
• AAS: ataque de 200 mg e manutenção de 100 mg ao dia.
• Antiagregante P2Y12: prasugrel é contraindicado por AVE ou AIT prévio e não se recomenda em idade igual ou superior a 75 anos (alternativa A). O ticagrelor (180 mg de ataque e 90 mg 12/12 h) é a escolha preferencial nas SCA de risco moderado e alto.
• Anticoagulação: enoxaparina 12/12 h. Na idade igual ou superior a 75 anos, a banca considerou a dose reduzida de cerca de 0,75 mg/kg, o que para 80 kg corresponde a 60 mg 12/12 h.
• Cineangiocoronariografia imediata (alternativa C) é reservada a instabilidade hemodinâmica, angina refratária, arritmia grave ou IAM com supra; com a paciente sem dor e estável, a estratégia é invasiva precoce (até 24 horas), e não imediata.
• Clopidogrel com ataque de 600 mg (alternativa E) não é a escolha preferencial; o padrão para SCA sem ICP imediata era de 300 mg.

Por que as outras alternativas estão incorretas:
• A) Prasugrel é contraindicado em paciente com AVE prévio e não é recomendado a partir dos 75 anos.
• C) A coronariografia imediata é reservada a instabilidade ou angina refratária; a paciente está sem dor e estável, e a dose de enoxaparina de 80 mg não considera a idade igual ou superior a 75 anos.
• D) Dor típica com ECG alterado e alto risco exige internação e tratamento antitrombótico, e não apenas observação com protocolo de dor torácica.
• E) O ticagrelor é preferido ao clopidogrel nas SCA de risco moderado e alto, e o ataque de 600 mg de clopidogrel não é a dose padrão para SCA sem ICP imediata.$Q$, 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/tec2015-q20.jpg'
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$Mulher, 77 anos, 80 kg, hipertensa, sem disfunção renal e co$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$A paciente deve ser internada com monitoração contínua e receber ácido acetilsalicílico 200 mg inicialmente, seguido por 100 mg nos demais dias; prasugrel 60 mg de ataque e 10 mg nos dias subsequentes e enoxaparina 60 mg, 12/12 horas.$Q$, false),
    ('B', $Q$A paciente deve ser internada com monitoração contínua e receber ácido acetilsalicílico 200 mg, seguido de 100 mg nos demais dias; ticagrelor 180 mg de ataque e depois 90 mg, 12/12 horas, e enoxaparina 60 mg, 12/12 horas.$Q$, true),
    ('C', $Q$A paciente deve receber ácido acetilsalicílico 200 mg, seguido de 100 mg nos demais dias; enoxaparina 80 mg, 12/12 horas, ticagrelor 180 mg de ataque e depois 90 mg 12/12 horas e ser encaminhada imediatamente para cineangiocoronariografia.$Q$, false),
    ('D', $Q$A paciente deve permanecer em observação e realizar o protocolo de dor torácica, com eletrocardiograma, dosagem de marcadores cardíacos e reavaliação clínica a cada três horas por 9 a 12 horas do início da dor.$Q$, false),
    ('E', $Q$A paciente deve ser internada com monitoração contínua e deve receber ácido acetilsalicílico 200 mg inicialmente, seguido de 100 mg ao dia, clopidogrel 600 mg de ataque e depois 75 mg ao dia e enoxaparina 80 mg 12/12 horas.$Q$, false)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #21] Sd. Coronariana Aguda — Gabarito: A =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Sd. Coronariana Aguda$Q$, 2015, 'TEC', $Q$Em relação à classificação clínica dos diferentes tipos de infarto do miocárdio, de acordo com a IV Diretriz do Tratamento do Infarto Agudo do Miocárdio com supradesnivelamento do segmento ST, é CORRETO afirmar que:$Q$, $Q$Na classificação universal do infarto, o tipo 3 corresponde à morte súbita cardíaca com sintomas sugestivos de isquemia, sem biomarcadores disponíveis — alternativa A.$Q$, $Q$Classificação universal do infarto do miocárdio (IV Diretriz do IAM com supra de ST, SBC):
• Tipo 1: espontâneo, por ruptura, erosão ou dissecção de placa com trombo.
• Tipo 2: secundário a desequilíbrio entre oferta e demanda de oxigênio (anemia, arritmias, espasmo, hipotensão, hipertensão grave).
• Tipo 3: morte súbita cardíaca com sintomas sugestivos de isquemia e, em geral, sem coleta de biomarcadores.
• Tipo 4a: relacionado à ICP; tipo 4b: trombose de stent; tipo 4c: reestenose.
• Tipo 5: relacionado à cirurgia de revascularização miocárdica.

Dica de prova: números 4 (ICP) e 5 (cirurgia) são os procedimentos; 3 é a morte súbita.

Por que as outras alternativas estão incorretas:
• B) O tipo 1 é o evento coronariano primário (espontâneo), não o secundário; o secundário é o tipo 2.
• C) A trombose de stent é o tipo 4b, não o tipo 1.
• D) O tipo 5 relaciona-se à cirurgia de revascularização, e não à intervenção percutânea (4a).
• E) O tipo 4a é relacionado à ICP; anemia e espasmo correspondem ao tipo 2.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$Em relação à classificação clínica dos diferentes tipos de i$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$O tipo 3 refere-se à morte súbita cardíaca.$Q$, true),
    ('B', $Q$O tipo 1 relaciona-se a evento coronariano secundário.$Q$, false),
    ('C', $Q$O tipo 1 geralmente associa-se à trombose de stent.$Q$, false),
    ('D', $Q$O tipo 5 encontra-se relacionado a um procedimento percutâneo.$Q$, false),
    ('E', $Q$O tipo 4a é secundário à anemia ou a um espasmo coronariano.$Q$, false)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #22] Doenças Sistêmicas e Coração — Gabarito: ANULADA =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Doenças Sistêmicas e Coração$Q$, 2015, 'TEC', $Q$Em relação às anormalidades cardiovasculares em indivíduos infectados pelo HIV, marque a alternativa ERRADA.$Q$, $Q$QUESTÃO ANULADA pela banca. Provável motivo: mais de uma alternativa discutível sobre as manifestações cardiovasculares do HIV, em especial a incidência de endocardite e a disfunção diastólica.$Q$, $Q$Conceito central: manifestações cardiovasculares do HIV.
• Era pré-TARV: miocardiopatia dilatada com disfunção sistólica do VE era comum nas fases avançadas.
• Hoje: com a terapia antirretroviral, predomina a disfunção diastólica subclínica e há maior risco de aterosclerose e doença coronária, por inflamação crônica e efeitos metabólicos de alguns antirretrovirais.
• Pericárdio: o derrame pericárdico é a manifestação pericárdica mais comum e se associa a doença avançada (CD4 baixo), tuberculose e linfoma.
• Endocardite infecciosa: a literatura não demonstra incidência maior pelo HIV isoladamente; o aumento ocorre nos usuários de drogas injetáveis, grupo em que o HIV é frequente.

Por que a questão foi anulada: o enunciado pede a alternativa ERRADA, mas há mais de uma afirmação sujeita a contestação. A alternativa A (maior incidência de endocardite em HIV-positivos) depende de se considerar ou não o uso de drogas injetáveis, e a C (disfunção diastólica ainda comum) depende da população e da definição adotadas. Sem um critério único, não é possível apontar uma única alternativa falsa de forma inequívoca.

Por que as outras alternativas estão incorretas:
• A) Discutível: o HIV isolado não eleva a incidência de endocardite; o risco aumenta nos usuários de drogas injetáveis, e a afirmação genérica admite interpretações diferentes.
• B) Em geral verdadeira: na era pré-TARV, a miocardiopatia dilatada com disfunção ventricular esquerda era achado frequente em doença avançada.
• C) Em parte discutível: a disfunção diastólica é descrita com frequência em pacientes tratados, mas a prevalência varia conforme o estudo e a definição.
• D) Verdadeira: o derrame pericárdico se correlaciona com imunossupressão grave e doença avançada.
• E) Verdadeira: pacientes em TARV têm maior incidência de aterosclerose e eventos coronarianos, por inflamação crônica e fatores metabólicos.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$Em relação às anormalidades cardiovasculares em indivíduos i$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$A incidência de endocardite infecciosa é maior em indivíduos HIV-positivos.$Q$, true),
    ('B', $Q$Na era pré-TARV (terapia antirretroviral altamente efetiva), era comum o achado de disfunção ventricular esquerda.$Q$, true),
    ('C', $Q$Ainda nos dias de hoje é comum a presença de disfunção diastólica.$Q$, true),
    ('D', $Q$O derrame pericárdico normalmente se correlaciona com doença avançada.$Q$, true),
    ('E', $Q$Os pacientes HIV-positivos em TARV têm maior incidência de doença aterosclerótica.$Q$, true)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #23] Hipertensão — Gabarito: D =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Hipertensão$Q$, 2015, 'TEC', $Q$Em pacientes com hiperaldosteronismo primário, a hiperplasia bilateral deve ser tratada com:$Q$, $Q$Na hiperplasia adrenal bilateral do hiperaldosteronismo primário, o tratamento é clínico com espironolactona (50 a 300 mg/dia) — alternativa D.$Q$, $Q$No hiperaldosteronismo primário, o tratamento depende da causa:
• Adenoma produtor de aldosterona (unilateral): adrenalectomia, em geral laparoscópica.
• Hiperplasia adrenal bilateral (idiopática): tratamento medicamentoso com antagonista do receptor mineralocorticoide.
• Espironolactona é o fármaco de escolha, em doses que podem variar de 50 a 300 mg/dia conforme a resposta e o potássio; a eplerenona é alternativa quando há ginecomastia. Amilorida e outros anti-hipertensivos podem ser associados.

Dica de prova: adenoma, cirurgia; hiperplasia, espironolactona.

Por que as outras alternativas estão incorretas:
• A) A cirurgia é reservada ao adenoma unilateral; na hiperplasia bilateral, a adrenalectomia não corrige a hipertensão.
• B) A hidroclorotiazida agrava a hipopotassemia e não atua no mecanismo do excesso de aldosterona.
• C) IECA em dose maior não corrige o hiperaldosteronismo, porque o eixo da angiotensina está suprimido.
• E) Existe resposta correta entre as anteriores (a alternativa D).$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$Em pacientes com hiperaldosteronismo primário, a hiperplasia$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Cirurgia laparoscópica.$Q$, false),
    ('B', $Q$Hidroclorotiazida, 25 mg.$Q$, false),
    ('C', $Q$Enalapril em doses maiores que 10 mg.$Q$, false),
    ('D', $Q$Espironolactona, 50 a 300 mg/dia.$Q$, true),
    ('E', $Q$Nenhuma das respostas anteriores.$Q$, false)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #25] Hipertensão — Gabarito: D =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Hipertensão$Q$, 2015, 'TEC', $Q$Quanto à hipertensão mascarada, é CORRETO afirmar:$Q$, $Q$Na hipertensão mascarada, a PA é normal no consultório e elevada fora dele, com risco cardiovascular semelhante ao dos hipertensos, e o diagnóstico se faz com MAPA ou MRPA — todas as afirmativas estão corretas — alternativa D.$Q$, $Q$Hipertensão mascarada: pressão arterial normal no consultório (menor que 140/90 mmHg) e anormal na monitorização ambulatorial (MAPA) ou residencial (MRPA).
• O risco de lesão de órgão-alvo e de eventos cardiovasculares é semelhante ao dos hipertensos sustentados (alternativa A).
• O diagnóstico exige comparar a medida de consultório com a MAPA ou a MRPA (alternativa B).
• Os níveis de consultório são normais, por definição (alternativa C).
• É mais comum em jovens, fumantes, consumidores de álcool, diabéticos e pessoas com estresse; deve ser suspeitada em quem tem lesão de órgão-alvo sem hipertensão evidente no consultório.

Dica de prova: mascarada = normal no consultório, elevada fora; branco = elevada no consultório, normal fora.

Por que as outras alternativas estão incorretas:
• A) Está correta, mas a alternativa mais completa é a D, porque B e C também estão corretas.
• B) Está correta, mas a alternativa mais completa é a D.
• C) Está correta, mas a alternativa mais completa é a D.
• E) Incompleta, pois a alternativa C também está correta.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$Quanto à hipertensão mascarada, é CORRETO afirmar:$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Tem risco semelhante aos hipertensos de desenvolver lesões de órgãos-alvo.$Q$, false),
    ('B', $Q$Pode ser diagnosticada comparando-se a pressão ambulatorial com monitorização ambulatorial da pressão arterial (MAPA) ou monitorização residencial da pressão arterial (MRPA).$Q$, false),
    ('C', $Q$Os níveis tensionais estão normais no consultório.$Q$, false),
    ('D', $Q$Todas as anteriores.$Q$, true),
    ('E', $Q$Apenas as alternativas A e B estão corretas.$Q$, false)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #28] Hipertensão — Gabarito: D =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Hipertensão$Q$, 2015, 'TEC', $Q$A afirmativa CORRETA sobre hipertensão na gravidez é:$Q$, $Q$O sulfato de magnésio é o fármaco indicado para prevenir convulsões (eclâmpsia) em pacientes com pré-eclâmpsia grave — alternativa D.$Q$, $Q$Pontos de hipertensão na gestação (VI Diretriz Brasileira de Hipertensão):
• O sulfato de magnésio é o fármaco de escolha na prevenção e no tratamento da eclâmpsia em mulheres com pré-eclâmpsia grave ou com sinais de iminência de eclâmpsia, com monitorização de reflexos, diurese e frequência respiratória.
• Na ausência de proteinúria, a pré-eclâmpsia é suspeitada pela presença de sintomas (cefaleia, escotomas, dor epigástrica), edema pulmonar ou alterações laboratoriais como trombocitopenia e aumento de enzimas hepáticas (diminuição, e não aumento, das plaquetas).
• O tratamento definitivo é o parto, mas a conduta depende da gravidade e da idade gestacional, com possibilidade de conduta expectante em casos leves e pré-termo.
• Cálcio e AAS em baixa dose são indicados para mulheres de risco para pré-eclâmpsia, não para todas.
• IECA, BRA e inibidores diretos da renina são contraindicados na gestação.

Por que as outras alternativas estão incorretas:
• A) Na pré-eclâmpsia ocorre queda (e não aumento) do número de plaquetas, junto com elevação de enzimas hepáticas.
• B) Cálcio e AAS em baixa dose são indicados para grupos de risco (cálcio em baixa ingestão), e não para todas as gestantes.
• C) O parto é o tratamento definitivo, mas não é obrigatório imediatamente em todos os casos; em pré-eclâmpsia leve e pré-termo pode haver conduta expectante.
• E) A afirmação é parcialmente correta, mas o limiar de início do tratamento medicamentoso na gestação é mais alto na prática (acima de 150/100 mmHg na maioria das diretrizes da época), e não de 140/90.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$A afirmativa CORRETA sobre hipertensão na gravidez é:$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Na ausência de proteinúria, a pré-eclâmpsia é altamente suspeita quando o aumento da pressão arterial sistêmica se acompanha de cefaleia, visão borrada, dor abdominal, edema pulmonar ou de testes laboratoriais anormais, especialmente aumento do número de plaquetas e enzimas hepáticas.$Q$, false),
    ('B', $Q$A suplementação de cálcio e o uso de ácido acetilsalicílico em doses baixas estão indicados para prevenção de pré-eclâmpsia a partir da 12a semana de gestação em todas as mulheres.$Q$, false),
    ('C', $Q$O tratamento definitivo da pré-eclâmpsia é a interrupção da gravidez, estando sempre indicada imediatamente após o diagnóstico.$Q$, false),
    ('D', $Q$Sulfato de magnésio é indicado para prevenir eclâmpsia em pacientes com pré-eclâmpsia grave.$Q$, true),
    ('E', $Q$Os anti-hipertensivos usados na hipertensão da gravidez são os mesmos usados fora da gestação, exceto os inibidores da renina, os inibidores da enzima conversora da angiotensina (IECA) e os bloqueadores dos receptores de angiotensina (BRA), e devem ser iniciados quando a pressão arterial sistólica for ≥ 140 mmHg ou a pressão arterial diastólica for ≥ 90 mmHg.$Q$, false)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #31] Válvula — Gabarito: C =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Válvula$Q$, 2015, 'TEC', $Q$Paciente masculino, 54 anos, faz seguimento ambulatorial por insuficiência aórtica importante de etiologia reumática, mantendo-se assintomático do ponto de vista cardiovascular. Ao ecocardiograma, além da valvopatia aórtica, verificam-se as seguintes medidas: átrio esquerdo = 40 mm; ventrículo esquerdo (VE) = 66/45 mm; fração de ejeção do VE = 58%; PSAP = 30 mmHg. Qual é a melhor conduta nesse momento?$Q$, $Q$Insuficiência aórtica importante assintomática, com FE de 58% e diâmetro sistólico de 45 mm, não tem indicação cirúrgica e, sem hipertensão, não exige fármaco — seguimento clínico — alternativa C.$Q$, $Q$Indicações de troca valvar na insuficiência aórtica crônica importante:
• Sintomas (classe I).
• Assintomático com FEVE igual ou inferior a 50% ou com diâmetro sistólico final do VE acima de 50 mm (nas diretrizes de 2014, em torno de 50 a 55 mm) ou diastólico acima de 70 a 75 mm.

Neste paciente, FE de 58% e diâmetro sistólico de 45 mm estão abaixo dos limites, apesar de o diâmetro diastólico de 66 mm indicar dilatação. Assim:
• Não há indicação de cirurgia nem de intervenção percutânea (não existe terapia percutânea estabelecida para IAo reumática).
• Vasodilatadores têm benefício claro quando há hipertensão ou quando se aguarda a cirurgia em pacientes sintomáticos; em assintomático normotenso com função preservada, não alteram a história natural de forma convincente.
• Betabloqueador e espironolactona não têm papel nesse cenário.
• Conduta: seguimento clínico e ecocardiográfico regulares (a cada 6 a 12 meses), com tratamento da hipertensão se surgir.

Por que as outras alternativas estão incorretas:
• A) A cirurgia indica-se com sintomas, FE de 50% ou menos ou diâmetro sistólico acima do limite; o paciente não se enquadra.
• B) Enalapril e furosemida têm benefício em sintomáticos ou hipertensos; furosemida não é indicada sem congestão.
• D) Não há intervenção percutânea estabelecida para insuficiência aórtica reumática.
• E) Carvedilol, enalapril e espironolactona tratam disfunção sistólica; o paciente tem FE preservada.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$Paciente masculino, 54 anos, faz seguimento ambulatorial por$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Cirurgia de troca valvar aórtica.$Q$, false),
    ('B', $Q$Prescrição de enalapril e furosemida.$Q$, false),
    ('C', $Q$Seguimento clínico sem necessidade de medicação.$Q$, true),
    ('D', $Q$Intervenção percutânea.$Q$, false),
    ('E', $Q$Prescrição de carvedilol, enalapril e espironolactona.$Q$, false)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #32] Cardiointensiva — Gabarito: A =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Cardiointensiva$Q$, 2015, 'TEC', $Q$A respeito da qualidade de ressuscitação cardiopulmonar (RCP), considere as assertivas abaixo.
I. Na capnografia quantitativa se PETCO2 < 10 mmHg, deve-se melhorar a qualidade da reanimação.
II. Se a pressão intra-arterial na fase de relaxamento (diastólica) estiver < 20 mmHg, a qualidade da RCP está satisfatória.
III. Deve-se comprimir o tórax no mínimo 5 cm de profundidade, sendo o retorno completo do tórax não necessário em alguns casos.
Em relação às afirmações anteriores, assinale a alternativa CORRETA.$Q$, $Q$Apenas a assertiva I está correta: PETCO2 abaixo de 10 mmHg indica má qualidade de ressuscitação, que deve ser melhorada — alternativa A.$Q$, $Q$Parâmetros de qualidade da RCP (diretrizes da AHA, 2010 e 2015):
I. Correta. Na capnografia, PETCO2 menor que 10 mmHg após 20 minutos de RCP associa-se a mau prognóstico, e valores baixos indicam compressões ineficazes: deve-se melhorar a qualidade da reanimação.
II. Incorreta. Pressão diastólica intra-arterial menor que 20 mmHg indica qualidade inadequada, e não satisfatória; o alvo é igual ou superior a 20 mmHg.
III. Incorreta. A compressão torácica deve ter profundidade de pelo menos 5 cm (até 6 cm), e o retorno completo do tórax é necessário, pois permite o enchimento do coração; apoiar-se no tórax impede o retorno.

Dica de prova: compressões de 100 a 120 por minuto, 5 a 6 cm, retorno completo e mínimo de interrupções.

Por que as outras alternativas estão incorretas:
• B) A pressão diastólica abaixo de 20 mmHg sinaliza compressões inadequadas.
• C) O retorno completo do tórax é necessário em todos os casos.
• D) II e III estão incorretas.
• E) II e III estão incorretas.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$A respeito da qualidade de ressuscitação cardiopulmonar (RCP$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Apenas I.$Q$, true),
    ('B', $Q$Apenas II.$Q$, false),
    ('C', $Q$Apenas III.$Q$, false),
    ('D', $Q$II e III.$Q$, false),
    ('E', $Q$I, II e III.$Q$, false)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #33] Hipertensão — Gabarito: E =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Hipertensão$Q$, 2015, 'TEC', $Q$Quanto às indicações da monitorização residencial da pressão arterial (MRPA) em pacientes hipertensos tratados, qual alternativa é ERRADA?$Q$, $Q$A inversão do padrão circadiano (ausência de descenso noturno) só é avaliada pela MAPA, e não pela MRPA — alternativa E.$Q$, $Q$A monitorização residencial da pressão arterial (MRPA) é feita pelo paciente em casa, com aparelho validado, em dias e horários definidos, sem aferições durante o sono.
Indicações da MRPA em hipertensos tratados:
• Avaliar a eficácia do tratamento anti-hipertensivo.
• Identificar hipertensão mascarada.
• Identificar o efeito do avental branco.
• Avaliar a hipertensão resistente.
• Melhorar a adesão do paciente.

O padrão circadiano (descenso noturno, ausência ou inversão) exige medidas durante o sono e, portanto, é avaliado pela MAPA de 24 horas.

Por que as outras alternativas estão incorretas:
• A) A MRPA é indicada para avaliar a terapêutica anti-hipertensiva.
• B) A MRPA permite identificar a hipertensão mascarada.
• C) A MRPA é útil na avaliação da hipertensão resistente e da pseudorresistência.
• D) A MRPA identifica o efeito do avental branco no tratado.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$Quanto às indicações da monitorização residencial da pressão$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Avaliação da terapêutica anti-hipertensiva.$Q$, false),
    ('B', $Q$Avaliação de hipertensão mascarada.$Q$, false),
    ('C', $Q$Avaliação da hipertensão resistente.$Q$, false),
    ('D', $Q$Identificação do efeito do avental branco.$Q$, false),
    ('E', $Q$Avaliar a inversão de padrão circadiano.$Q$, true)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #34] Coronária Crônica — Gabarito: C =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Coronária Crônica$Q$, 2015, 'TEC', $Q$A intervenção coronária percutânea está indicada, EXCETO a:$Q$, $Q$A oclusão crônica de enxerto de veia safena não é indicação de angioplastia, pela baixa taxa de sucesso e alto risco de embolização — alternativa C.$Q$, $Q$Questão do tipo EXCETO: a alternativa-resposta é a que não tem indicação.
• Oclusão total crônica (maior que 3 meses) de artéria nativa, com sintomas ou isquemia e viabilidade, pode ser tratada por ICP em centros experientes (alternativa A).
• Lesão de tronco de coronária esquerda com Syntax baixo (até 22), mesmo em multiarteriais, pode ser tratada por ICP, em especial quando o risco cirúrgico (Euroscore) é alto (alternativa B).
• Choque cardiogênico secundário ao IAM: a revascularização precoce, em geral percutânea, é recomendada (alternativa D).
• Angina limitante apesar de tratamento clínico otimizado, com anatomia favorável (alternativa E).
• Oclusão crônica de enxerto de safena: a recanalização tem taxa de sucesso baixa e muito risco de embolização distal e reestenose; não se indica.

Por que as outras alternativas estão incorretas:
• A) Indicada: oclusão crônica nativa com isquemia ou viabilidade em centros com experiência.
• B) Indicada: tronco com Syntax baixo e alto risco cirúrgico é cenário aceito para ICP.
• D) Indicada: no choque cardiogênico por IAM, a revascularização precoce reduz mortalidade (estudo SHOCK).
• E) Indicada: angina refratária com anatomia favorável é indicação clássica.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$A intervenção coronária percutânea está indicada, EXCETO a:$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Oclusão crônica presumida (superior a três meses) associada a sinais e sintomas de isquemia miocárdica (angina ou prova funcional positiva) e/ou viabilidade funcional na área relacionada ao vaso ocluído nativo.$Q$, false),
    ('B', $Q$Paciente multiarterial com lesão de tronco de coronária esquerda com escore Syntax menor que 22 e Euroscore alto.$Q$, false),
    ('C', $Q$Oclusão crônica presumida (superior a três meses) em enxerto de veia safena.$Q$, true),
    ('D', $Q$Pacientes com choque cardiogênico secundário a infarto agudo do miocárdio com quatro horas de evolução.$Q$, false),
    ('E', $Q$Pacientes com angina limitante apesar do tratamento otimizado com anatomia favorável à intervenção.$Q$, false)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #35] Sd. Coronariana Aguda — Gabarito: E =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Sd. Coronariana Aguda$Q$, 2015, 'TEC', $Q$A necrose miocárdica secundária ao infarto libera macromoléculas intracelulares e proteínas estruturais no interstício cardíaco. Em relação aos marcadores de necrose miocárdica, assinale a alternativa ERRADA.$Q$, $Q$Os marcadores de necrose continuam essenciais no diagnóstico, na estratificação prognóstica e no diagnóstico de reinfarto, mesmo na era da intervenção — alternativa E.$Q$, $Q$Questão do tipo ERRADA: a alternativa-resposta é a falsa.

Marcadores de necrose miocárdica:
• CK total: sensível a lesão muscular, mas pouco específica para o coração.
• Mioglobina: sobe em 1 a 2 horas; tem alto valor preditivo negativo precoce e, por isso, ajuda a afastar infarto nas primeiras horas.
• CK-MB massa: melhor sensibilidade e especificidade que a atividade.
• Reinfarto: aumento de pelo menos 20% em relação ao valor anterior de CK-MB (ou troponina), com quadro clínico compatível, firma o diagnóstico (a CK-MB, de meia-vida curta, é útil).
• Troponina: marcador preferencial, com papel diagnóstico e prognóstico; a dosagem permanece indispensável na avaliação de extensão da lesão, prognóstico e reinfarto.

Dica de prova: afirmações de que um exame perdeu a utilidade costumam ser falsas.

Por que as outras alternativas estão incorretas:
• A) Verdadeira: a CK total eleva-se em lesão de músculo esquelético e tem baixa especificidade.
• B) Verdadeira: a mioglobina sobe precocemente e seu valor preditivo negativo ajuda a afastar infarto.
• C) Verdadeira: elevação de pelo menos 20% da CK-MB com clínica compatível indica reinfarto.
• D) Verdadeira: a CK-MB massa supera a atividade em sensibilidade e especificidade.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$A necrose miocárdica secundária ao infarto libera macromoléc$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$A creatina quinase (CK total) é um sensível indicador de lesão muscular, porém com baixa especificidade para o diagnóstico de lesão miocárdica.$Q$, false),
    ('B', $Q$A mioglobina eleva-se rapidamente após o início dos sintomas e, devido ao seu excelente valor preditivo negativo, torna-se de muita utilidade para afastar o diagnóstico de infarto agudo do miocárdio.$Q$, false),
    ('C', $Q$Uma elevação de ao menos 20% no resultado prévio da CK-MB, associada a quadro clínico sugestivo, permite o diagnóstico de reinfarto.$Q$, false),
    ('D', $Q$A CK-MB massa possui melhor sensibilidade clínica e especificidade analítica quando comparada à CK-MB atividade, sendo o melhor teste para dosagem da CK-MB atualmente.$Q$, false),
    ('E', $Q$Nos dias atuais, com a crescente importância da cardiologia intervencionista no diagnóstico e no tratamento do infarto agudo do miocárdio, os marcadores de lesão miocárdica perderam sua utilidade na avaliação da extensão, do prognóstico e do diagnóstico de reinfarto nesses pacientes.$Q$, true)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #40] Hipertensão — Gabarito: C =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Hipertensão$Q$, 2015, 'TEC', $Q$Em relação à farmacologia dos anti-hipertensivos, assinale a alternativa ERRADA.$Q$, $Q$Os efeitos metabólicos dos tiazídicos (hiperglicemia, hipertrigliceridemia) são dose-dependentes e minimizados com doses baixas — alternativa C.$Q$, $Q$Questão do tipo ERRADA: a alternativa-resposta é a falsa.

Farmacologia dos anti-hipertensivos:
• IECA: tosse seca, alteração do paladar, rash e angioedema (verdadeira).
• Di-idropiridínicos de curta ação (nifedipino): ativação simpática reflexa e taquicardia, o que justifica o uso de formulações de ação prolongada (verdadeira).
• Tiazídicos: hipopotassemia, hiperuricemia, aumento de glicemia e de triglicerídeos; os efeitos metabólicos são dose-dependentes, e por isso se usam doses baixas (12,5 a 25 mg de hidroclorotiazida ou clortalidona 12,5 a 25 mg).
• Carvedilol: bloqueio beta e alfa-1, com efeito vasodilatador (verdadeira).
• Clonidina: agonista alfa-2 central, com sonolência, hipotensão postural, boca seca e hipertensão rebote na retirada abrupta (verdadeira).

Por que as outras alternativas estão incorretas:
• A) Verdadeira: tosse, alteração do paladar e rash são efeitos descritos dos IECA.
• B) Verdadeira: a vasodilatação rápida do nifedipino de curta ação ativa reflexos simpáticos.
• D) Verdadeira: o carvedilol bloqueia beta e alfa-1, daí o efeito vasodilatador.
• E) Verdadeira: a clonidina é agonista alfa-2 com os efeitos citados.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$Em relação à farmacologia dos anti-hipertensivos, assinale a$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Os inibidores da enzima conversora de angiotensina podem causar tosse, alteração do paladar e erupções cutâneas como efeitos colaterais.$Q$, false),
    ('B', $Q$Os bloqueadores dos canais de cálcio di-idropiridínicos de curta ação podem causar ativação simpática reflexa.$Q$, false),
    ('C', $Q$Os diuréticos tiazídicos levam ao aumento de glicemia e trigliceridemia de maneira não dose-dependente.$Q$, true),
    ('D', $Q$O carvedilol apresenta bloqueio concomitante do receptor alfa-1-adrenérgico, levando a efeito vasodilatador.$Q$, false),
    ('E', $Q$A clonidina age como agonista do receptor alfa-2-adrenérgico, podendo causar como efeitos colaterais sonolência, hipotensão postural e boca seca.$Q$, false)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #42] Sd. Coronariana Aguda — Gabarito: A =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Sd. Coronariana Aguda$Q$, 2015, 'TEC', $Q$Sobre os efeitos cardiovasculares das drogas ilícitas, é CORRETO afirmar:$Q$, $Q$A maconha eleva a pressão arterial e a frequência cardíaca no uso agudo e pode causar hipotensão em doses altas — alternativa A.$Q$, $Q$Efeitos cardiovasculares das drogas ilícitas:
• Maconha: taquicardia e elevação da pressão arterial no uso agudo, com hipotensão postural e em altas doses; aumenta o risco de infarto, sobretudo na primeira hora após o uso (o risco é estimado em cerca de 4,8 vezes, e não o dobro).
• Cocaína: bloqueia a recaptação de catecolaminas e causa vasoespasmo, trombose, arritmias, infarto e dissecção de aorta, inclusive no primeiro uso (usuários eventuais também têm risco).
• Tratamento da SCA induzida por cocaína: benzodiazepínicos, nitratos e bloqueadores de cálcio; os betabloqueadores devem ser evitados pelo risco de vasoconstrição alfa sem oposição.
• Uso crônico de cocaína pode causar miocardiopatia dilatada por toxicidade direta e hiperatividade simpática, não por vasodilatação e trombose local.

Por que as outras alternativas estão incorretas:
• B) O risco de infarto na primeira hora após a maconha é cerca de 4,8 vezes maior, e não 2 vezes após 60 minutos.
• C) Complicações graves, inclusive fatais, ocorrem também no primeiro uso; não se restringem ao usuário crônico.
• D) Os betabloqueadores são evitados na SCA por cocaína; benzodiazepínicos, nitrato e antagonistas de cálcio são preferidos.
• E) A miocardiopatia do usuário crônico decorre de toxicidade direta e excesso de catecolaminas, não de vasodilatação com trombose local.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$Sobre os efeitos cardiovasculares das drogas ilícitas, é COR$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$A maconha desencadeia aumento da pressão arterial e taquicardia. Pode causar hipotensão em altas doses.$Q$, true),
    ('B', $Q$Após o consumo de maconha, o risco de infarto para cardiopatas é duas vezes maior após 60 minutos do seu consumo.$Q$, false),
    ('C', $Q$O uso agudo da cocaína pode levar a complicações cardiovasculares graves, até fatais, para o usuário crônico. Não ocorre em usuários primários.$Q$, false),
    ('D', $Q$O betabloqueador adrenérgico é o fármaco de escolha no tratamento da síndrome coronariana aguda desencadeada pela cocaína.$Q$, false),
    ('E', $Q$O usuário crônico de cocaína pode apresentar uma forma de cardiomiopatia dilatada por vasodilatação e trombose local.$Q$, false)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #44] Aortopatias — Gabarito: E =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Aortopatias$Q$, 2015, 'TEC', $Q$Paciente, 18 anos, portador de síndrome de Marfan, tem aneurisma de aorta ascendente com 5,2 cm e insuficiência aórtica moderada. Está assintomático, e os diâmetros ventriculares esquerdos não estão aumentados. Qual é a conduta correta a seguir?$Q$, $Q$Na síndrome de Marfan com aneurisma de 5,2 cm de aorta ascendente e insuficiência aórtica moderada, indica-se cirurgia da raiz com tubo valvado — alternativa E.$Q$, $Q$Na síndrome de Marfan, a dilatação da raiz da aorta é a lesão central e leva a dissecção, e a cirurgia é indicada eletivamente antes da complicação:
• Diâmetro da raiz ou da aorta ascendente a partir de 5,0 cm (ou 4,5 cm quando há história familiar de dissecção, crescimento acima de 0,5 cm ao ano, insuficiência aórtica importante ou desejo de gestação).
• Com 5,2 cm, já ultrapassa o limiar; a insuficiência aórtica moderada não impede a decisão.
• Como a raiz e a valva aórtica participam da doença, a ressecção apenas do tubo da aorta ascendente deixaria a raiz doente; a substituição da raiz (operação de Bentall, com tubo valvado, ou técnica com preservação valvar, como David) é o procedimento adequado.
• Betabloqueador ou losartana ajudam a reduzir a velocidade de crescimento, mas não substituem a cirurgia quando o limiar foi atingido.

Dica de prova: Marfan e raiz acima de 5 cm: cirurgia da raiz.

Por que as outras alternativas estão incorretas:
• A) Esperar sintomas é inadequado: a dissecção pode ocorrer sem aviso.
• B) Tratamento clínico e reavaliação não são suficientes para aorta acima de 5 cm.
• C) Losartana reduz o ritmo de dilatação, mas não substitui a cirurgia acima do limiar.
• D) A ressecção isolada da aorta ascendente deixa a raiz dilatada; em Marfan, a raiz deve ser tratada.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$Paciente, 18 anos, portador de síndrome de Marfan, tem aneur$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Manter uso de betabloqueadores e intervir quando apresentar sintomas.$Q$, false),
    ('B', $Q$Manter uso de betabloqueadores e reavaliar em seis meses.$Q$, false),
    ('C', $Q$Iniciar losartana e reavaliar em seis meses.$Q$, false),
    ('D', $Q$Programar ressecção da aorta ascendente.$Q$, false),
    ('E', $Q$Programar substituição da raiz da aorta por tubo valvado.$Q$, true)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #46] Sd. Coronariana Aguda — Gabarito: D =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Sd. Coronariana Aguda$Q$, 2015, 'TEC', $Q$Paciente masculino, com 24 anos, usuário de cocaína, apresentou quadro de síndrome coronariana aguda sem elevação do segmento ST no eletrocardiograma (ECG) associado à elevação dos níveis de troponina e remissão completa da dor com a terapêutica instituída. Qual é a alternativa CORRETA?
I. Os usuários de cocaína apresentam maior chance de síndromes coronarianas agudas. No caso acima, existe uma imagem radioluscente no tronco da coronária esquerda, sendo indicados beta-bloqueador e trombolítico endovenoso.
II. A cocaína pode servir como gatilho para o desencadeamento de espasmos coronarianos, causando redução súbita do fluxo sanguíneo, distúrbios do ritmo cardíaco e formação de trombo.
III. A cocaína induz à isquemia por efeitos diretos sobre a musculatura lisa do vaso e pelo aumento fisiológico dos efeitos das catecolaminas. A cocaína promove aterosclerose acelerada e trombose, aumenta a ativação e a agregabilidade plaquetária, promove anomalias da barreira celular endotelial aumentando a permeabilidade à LDL.$Q$, $Q$A assertiva I está errada (betabloqueador deve ser evitado na SCA por cocaína e trombolítico não se aplica ao SCASSST); II e III estão corretas — alternativa D.$Q$, $Q$I. Incorreta. Em SCA relacionada à cocaína, os betabloqueadores devem ser evitados na fase aguda (risco de vasoconstrição alfa sem oposição), e o trombolítico é indicado apenas em IAM com supradesnivelamento de ST sem acesso à angioplastia, e não em SCA sem supra de ST.
II. Correta. A cocaína causa espasmo coronariano, arritmias e favorece a trombose.
III. Correta. Atua por efeitos diretos sobre o músculo liso vascular e pelo aumento de catecolaminas; promove aterosclerose acelerada, aumento da ativação e da agregabilidade plaquetária e maior permeabilidade endotelial à LDL.

Tratamento: benzodiazepínicos, AAS, nitratos e, se necessário, antagonistas de cálcio.

Por que as outras alternativas estão incorretas:
• A) A assertiva I está incorreta.
• B) A assertiva I é a única incorreta.
• C) A assertiva I está incorreta.
• E) II e III estão corretas.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$Paciente masculino, com 24 anos, usuário de cocaína, apresen$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Todas estão corretas.$Q$, false),
    ('B', $Q$Somente a sentença I está correta.$Q$, false),
    ('C', $Q$Somente as sentenças I e II estão corretas.$Q$, false),
    ('D', $Q$Somente as sentenças II e III estão corretas.$Q$, true),
    ('E', $Q$Todas estão incorretas.$Q$, false)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #48] Aortopatias — Gabarito: B =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Aortopatias$Q$, 2015, 'TEC', $Q$As assertivas abaixo representam situações de indicação cirúrgica na dissecção aórtica tipo B, EXCETO:$Q$, $Q$A falsa luz pérvia isolada não é indicação cirúrgica na dissecção tipo B não complicada — alternativa B.$Q$, $Q$Questão do tipo EXCETO.

Na dissecção aórtica tipo B (Stanford), o tratamento inicial é clínico (controle da pressão e da frequência com betabloqueador). Indicam intervenção (cirurgia ou tratamento endovascular) as complicações:
• Dor persistente ou recorrente, refratária ao tratamento clínico (A).
• Má perfusão de órgãos, como isquemia mesentérica, renal ou de membros (E).
• Dilatação aórtica rápida ou aneurisma com diâmetro acima de 6 cm (C), ou ruptura.
• Extensão retrógrada para a aorta ascendente, que torna o caso uma dissecção tipo A (D).

A falsa luz pérvia isolada é um fator de risco para evolução e crescimento tardio, mas, por si só, não obriga a cirurgia imediata.

Atualização: o tratamento endovascular (TEVAR) hoje é a abordagem preferida nas complicações da dissecção tipo B, e há debate sobre indicá-lo precocemente em casos de alto risco.

Por que as outras alternativas estão incorretas:
• A) Dor persistente indica risco de progressão e ruptura; é indicação de intervenção.
• C) Diâmetro de 6 cm indica risco de ruptura e é indicação de intervenção.
• D) A extensão retrógrada para a aorta ascendente transforma o caso em dissecção tipo A, com indicação cirúrgica.
• E) A isquemia mesentérica é má perfusão de órgão e indica intervenção.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$As assertivas abaixo representam situações de indicação cirú$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Dor torácica persistente.$Q$, false),
    ('B', $Q$Falsa luz pérvia.$Q$, true),
    ('C', $Q$Diâmetro da aorta descendente de 6 cm.$Q$, false),
    ('D', $Q$Extensão retrógrada para a aorta ascendente.$Q$, false),
    ('E', $Q$Isquemia mesentérica.$Q$, false)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #49] Cardiopatia Congênita — Gabarito: D =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Cardiopatia Congênita$Q$, 2015, 'TEC', $Q$Adolescente, 12 anos de idade, com queixa de cefaleia e fadiga nas pernas, em investigação diagnóstica para hipertensão arterial sistêmica. Na radiografia de tórax, observam-se aumento da artéria subclávia esquerda e dilatação da aorta descendente (sinal do 3 invertido). Logo, o diagnóstico deste caso é:$Q$, $Q$Hipertensão em adolescente com fadiga nas pernas e sinal do 3 invertido na radiografia são típicos de coarctação da aorta — alternativa D.$Q$, $Q$O quadro de hipertensão arterial em jovem com claudicação ou fadiga de membros inferiores sugere coarctação da aorta (estreitamento na região do ligamento arterioso, logo após a emergência da subclávia esquerda).
• Achados clínicos: hipertensão em membros superiores, pulsos femorais diminuídos ou atrasados, diferença de pressão entre braços e pernas, sopro sistólico interescapular.
• Radiografia de tórax: dilatação da subclávia esquerda, dilatação pós-estenótica da aorta descendente, que forma o sinal do 3 invertido e, com o tempo, as erosões costais inferiores (sinal de Roesler) por circulação colateral.
• Tratamento: angioplastia com stent ou cirurgia.

O enunciado cita imagem ausente, mas o texto já descreve os achados característicos.

Por que as outras alternativas estão incorretas:
• A) A persistência do canal arterial cursa com aumento do fluxo pulmonar e sopro contínuo, sem esse padrão de aorta.
• B) A drenagem anômala de veias pulmonares causa sobrecarga de câmaras direitas e hiperfluxo pulmonar, sem hipertensão sistêmica.
• C) A estenose aórtica valvar causa sopro sistólico de ejeção e dilatação pós-estenótica da aorta ascendente.
• E) A estenose de veias pulmonares causa hipertensão pulmonar e congestão, não hipertensão sistêmica com dilatação da subclávia.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$Adolescente, 12 anos de idade, com queixa de cefaleia e fadi$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Persistência de canal arterial.$Q$, false),
    ('B', $Q$Drenagem anômala de veias pulmonares.$Q$, false),
    ('C', $Q$Estenose aórtica valvar.$Q$, false),
    ('D', $Q$Coarctação da aorta.$Q$, true),
    ('E', $Q$Estenose de veias pulmonares.$Q$, false)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #51] Cardiopatia Congênita — Gabarito: B =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Cardiopatia Congênita$Q$, 2015, 'TEC', $Q$Com relação às cardiopatias congênitas, marque a alternativa ERRADA:$Q$, $Q$A comunicação interatrial tipo seio venoso não é fechada com prótese percutânea (falta de borda), e o tratamento é cirúrgico — alternativa B.$Q$, $Q$Questão do tipo ERRADA: a alternativa-resposta é a falsa.

• CIA tipo ostium secundum: a única passível de fechamento por prótese (dispositivo), quando há bordas adequadas.
• CIA tipo seio venoso e ostium primum: não têm borda adequada e costumam associar-se a drenagem anômala de veias pulmonares ou fenda mitral; o tratamento é cirúrgico. Por isso, a afirmação B é falsa.
• Síndrome de Eisenmenger: doença vascular pulmonar obstrutiva decorrente de shunt esquerda-direita que leva a inversão do fluxo e cianose.
• CIV restritiva: pode se fechar espontaneamente na infância.
• Persistência do canal arterial é frequente em prematuros de baixo peso, pela imaturidade do mecanismo de fechamento.
• Recoarctação pós-cirúrgica: o tratamento de escolha é percutâneo (balão e stent).

Por que as outras alternativas estão incorretas:
• A) Verdadeira: define a síndrome de Eisenmenger.
• C) Verdadeira: as CIV pequenas ou restritivas tendem a fechar espontaneamente.
• D) Verdadeira: a PCA é muito frequente em prematuros de muito baixo peso.
• E) Verdadeira: a angioplastia com balão e stent é a primeira escolha na recoarctação.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$Com relação às cardiopatias congênitas, marque a alternativa$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$A síndrome de Eisenmenger é uma doença obstrutiva vascular pulmonar decorrente de cardiopatias do shunt esquerdo-direito.$Q$, false),
    ('B', $Q$A comunicação interatrial do tipo seio venoso e com grande repercussão hemodinâmica deve ser fechada com prótese.$Q$, true),
    ('C', $Q$Comunicação interventricular restritiva pode fechar durante a infância.$Q$, false),
    ('D', $Q$A maioria dos neonatos pré-termos e com baixo peso tem persistência do canal arterial.$Q$, false),
    ('E', $Q$A intervenção percutânea constitui tratamento de escolha da recoarctação da aorta pós-cirúrgica.$Q$, false)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #52] Cardiopatia Congênita — Gabarito: E =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Cardiopatia Congênita$Q$, 2015, 'TEC', $Q$A crise de hipóxia caracteristicamente ocorre na tetralogia de Fallot, embora possa ocorrer em outras cardiopatias cianogênicas complexas com fisiologia semelhante. As medidas iniciais utilizadas no tratamento da crise de hipóxia devem ser:$Q$, $Q$A crise hipoxêmica da tetralogia de Fallot é tratada com posição genupeitoral, oxigênio, sedação com morfina e hidratação — alternativa E.$Q$, $Q$A crise hipoxêmica (espasmo infundibular) ocorre por aumento da resistência pulmonar relativa e desvio do sangue do VD para a aorta. As medidas visam reduzir o retorno venoso sistêmico, aumentar a resistência vascular sistêmica e relaxar o infundíbulo:
• Posição genupeitoral (joelho no peito), que aumenta a resistência periférica e reduz o retorno venoso.
• Oxigênio.
• Sedação com morfina (reduz a hiperpneia e a taquicardia) ou outro sedativo.
• Hidratação (volume) para aumentar a pré-carga do VD.
• Se refratária: fenilefrina (vasoconstritor), betabloqueador (propranolol ou esmolol), bicarbonato para acidose e, por fim, cirurgia (Blalock-Taussig ou correção).

Dica de prova: evite digoxina, diuréticos e inotrópicos positivos, que pioram o espasmo.

Por que as outras alternativas estão incorretas:
• A) Digoxina e dobutamina são inotrópicos positivos e agravam o espasmo infundibular.
• B) Os betabloqueadores são usados nos casos refratários, e os diuréticos pioram a hipovolemia; a ordem das medidas iniciais está incorreta.
• C) A cirurgia de urgência e a dilatação com balão são para casos refratários, e a dobutamina é contraindicada.
• D) Digoxina é inadequada, e a ventilação mecânica é reservada para casos graves.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$A crise de hipóxia caracteristicamente ocorre na tetralogia $Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Morfina, digoxina, operação de urgência (Blalock-Taussig) e dobutamina.$Q$, false),
    ('B', $Q$Posição genupeitoral, betabloqueadores, fenilefrina e diurético.$Q$, false),
    ('C', $Q$Operação de urgência (Blalock-Taussig), dilatação com balão da via de saída do ventrículo direito, betabloqueadores e dobutamina.$Q$, false),
    ('D', $Q$Digoxina, ventilação mecânica, betabloqueadores e operação de urgência (Blalock-Taussig).$Q$, false),
    ('E', $Q$Posição genupeitoral, oxigênio, sedação (morfina, meperidina) e hidratação.$Q$, true)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #53] Válvula — Gabarito: D =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Válvula$Q$, 2015, 'TEC', $Q$Em relação à insuficiência mitral (IM), assinale a alternativa ERRADA.$Q$, $Q$A vena contracta que indica insuficiência mitral importante é maior ou igual a 0,7 cm; 0,4 cm não define IM grave — alternativa D.$Q$, $Q$Questão do tipo ERRADA: a alternativa-resposta é a falsa.

• Quando o acometimento é do folheto posterior (prolapso ou flail), o jato é dirigido anteriormente, e o sopro irradia para a região esternal ou aórtica; no folheto anterior o jato é posterior e irradia para a axila e o dorso (alternativa A, verdadeira).
• A calcificação do anel mitral raramente causa IM significativa (B, verdadeira).
• O exercício isométrico (handgrip) aumenta a pós-carga e intensifica o sopro da IM (C, verdadeira).
• Ecocardiograma: vena contracta menor que 0,3 cm indica IM discreta; entre 0,3 e 0,69 cm, intermediária (moderada); maior ou igual a 0,7 cm, grave. Portanto, 0,4 cm não indica IM grave (D, falsa).
• Na IM crônica assintomática não há fármaco que modifique a história natural; a decisão é cirúrgica conforme sintomas, FEVE e dimensões (E, verdadeira).

Por que as outras alternativas estão incorretas:
• A) Verdadeira: o jato do folheto posterior é anterior, com irradiação para base e esterno.
• B) Verdadeira: a calcificação do anel costuma ter pouca consequência funcional.
• C) Verdadeira: o aumento da pós-carga com o handgrip intensifica o sopro.
• E) Verdadeira: não há terapia farmacológica definida para IM crônica assintomática.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$Em relação à insuficiência mitral (IM), assinale a alternati$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Quando a IM é decorrente de alteração do folheto posterior, o sopro pode irradiar para a região esternal ou para a área aórtica.$Q$, false),
    ('B', $Q$A calcificação do anel mitral pode causar IM, mas na maioria dos casos tem pequena consequência funcional.$Q$, false),
    ('C', $Q$O sopro holossistólico da IM usualmente aumenta pelo exercício isométrico.$Q$, false),
    ('D', $Q$No ecocardiograma, a medida da vena contracta, na insuficiência mitral não isquêmica, acima de 0,4 cm indica IM grave ou importante.$Q$, true),
    ('E', $Q$Não há tratamento farmacológico definido para a IM crônica assintomática.$Q$, false)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #54] Hipertensão — Gabarito: B =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Hipertensão$Q$, 2015, 'TEC', $Q$Assinale a alternativa ERRADA em relação aos fatores de risco cardiovasculares adicionais de pacientes com hipertensão, segundo a VI Diretriz Brasileira de Hipertensão Arterial.$Q$, $Q$Na VI Diretriz, alcoolismo não consta entre os fatores de risco cardiovascular adicionais usados na estratificação; idade, tabagismo, diabete e história familiar constam — alternativa B.$Q$, $Q$A estratificação de risco do hipertenso (VI Diretriz Brasileira de Hipertensão, 2010) considera fatores de risco adicionais:
• Idade (homens acima de 55 anos, mulheres acima de 65 anos).
• Tabagismo.
• Dislipidemia.
• Resistência à insulina e diabetes melito.
• História familiar prematura de doença cardiovascular (homens abaixo de 55 e mulheres abaixo de 65 anos).
• Obesidade, em particular a abdominal.

O consumo excessivo de álcool eleva a pressão arterial, mas não faz parte da lista de fatores de risco adicionais para a estratificação.

Por que as outras alternativas estão incorretas:
• A) A idade avançada é fator de risco adicional.
• C) O tabagismo é fator de risco adicional.
• D) O diabete melito entra como fator de risco (e, em algumas classificações, como condição clínica associada).
• E) A história familiar prematura de doença cardiovascular é fator de risco adicional.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$Assinale a alternativa ERRADA em relação aos fatores de risc$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Idade.$Q$, false),
    ('B', $Q$Alcoolismo.$Q$, true),
    ('C', $Q$Tabagismo.$Q$, false),
    ('D', $Q$Diabete melito.$Q$, false),
    ('E', $Q$História familiar prematura de doença cardiovascular.$Q$, false)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #55] Dislipidemia — Gabarito: D =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Dislipidemia$Q$, 2015, 'TEC', $Q$A combinação de fármacos pode ser empregada para alcance de metas lipídicas ou mesmo para controle mais abrangente de dislipidemias mistas, entretanto a seguinte combinação deve ser evitada pelo maior potencial de eventos adversos graves:$Q$, $Q$A associação de estatina com genfibrozila deve ser evitada, pelo maior risco de miopatia e rabdomiólise — alternativa D.$Q$, $Q$A genfibrozila inibe a glicuronidação das estatinas, aumentando seus níveis plasmáticos, e compete pelo metabolismo hepático, o que eleva muito o risco de miopatia e rabdomiólise.
• Quando se precisa associar um fibrato a uma estatina, prefere-se o fenofibrato (ou bezafibrato), que não interfere de forma importante na glicuronidação.
• Colestiramina (separar os horários), ezetimiba e pitavastatina são associações seguras e usadas para alcançar metas de LDL.
• Ácido nicotínico com ezetimiba não implica risco de eventos graves.

Dica de prova: estatina + genfibrozila = risco de rabdomiólise.

Por que as outras alternativas estão incorretas:
• A) Colestiramina com estatinas é associação segura, desde que administradas em horários distintos.
• B) O bezafibrato tem risco menor que a genfibrozila; a associação exige cautela, mas não é a mais perigosa.
• C) A associação de estatina com ezetimiba é bem estabelecida e segura.
• E) Ácido nicotínico com ezetimiba é combinação sem interação grave.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$A combinação de fármacos pode ser empregada para alcance de $Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Colestiramina com estatinas.$Q$, false),
    ('B', $Q$Bezafibrato com estatinas.$Q$, false),
    ('C', $Q$Pitavastatina com ezetimiba.$Q$, false),
    ('D', $Q$Estatinas com genfibrozila.$Q$, true),
    ('E', $Q$Ácido nicotínico com ezetimiba.$Q$, false)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #57] Pré-operatório — Gabarito: C =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Pré-operatório$Q$, 2015, 'TEC', $Q$De acordo com a Diretriz dos Aspectos Médicos em Viagens Aéreas, são contraindicações cardiovasculares para o voo, EXCETO:$Q$, $Q$Cirurgia cardíaca realizada há 4 semanas não contraindica o voo (o limite usual é de 2 semanas) — alternativa C.$Q$, $Q$Questão do tipo EXCETO.

Contraindicações cardiovasculares ao voo comercial (Diretriz de Aspectos Médicos em Viagens Aéreas, SBC):
• Síndrome de Eisenmenger e hipertensão pulmonar grave (hipóxia em altitude de cabine).
• Infarto agudo do miocárdio não complicado nas primeiras 2 semanas e infarto complicado nas primeiras 6 semanas.
• Hipertensão arterial grave e descontrolada.
• Insuficiência cardíaca descompensada, arritmias sintomáticas não controladas, angina instável.
• Cirurgia cardíaca recente: contraindicação nas primeiras 2 semanas (algumas fontes indicam 10 a 14 dias); com 4 semanas, o voo é permitido se não houver complicações.

Por que as outras alternativas estão incorretas:
• A) A hipóxia em altitude de cabine agrava a cianose e a hipertensão pulmonar.
• B) Infarto não complicado há menos de 2 semanas contraindica o voo.
• D) A hipertensão grave descontrolada é contraindicação.
• E) Infarto complicado há menos de 6 semanas contraindica o voo.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$De acordo com a Diretriz dos Aspectos Médicos em Viagens Aér$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Síndrome de Eisenmenger.$Q$, false),
    ('B', $Q$Infarto agudo do miocárdio não complicado há menos de 2 semanas.$Q$, false),
    ('C', $Q$Cirurgia cardíaca realizada há 4 semanas.$Q$, true),
    ('D', $Q$Hipertensão arterial sistêmica grave descontrolada.$Q$, false),
    ('E', $Q$Infarto agudo do miocárdio complicado há menos de 6 semanas.$Q$, false)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #59] Cardiointensiva — Gabarito: C =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Cardiointensiva$Q$, 2015, 'TEC', $Q$São contraindicações para hipotermia terapêutica após ressuscitação cardiopulmonar, EXCETO:$Q$, $Q$Coma após parada por fibrilação ventricular extra-hospitalar é a indicação clássica de hipotermia terapêutica, e não contraindicação — alternativa C.$Q$, $Q$Questão do tipo EXCETO: a alternativa-resposta é a que NÃO é contraindicação.

O controle direcionado de temperatura (hipotermia terapêutica, 32 a 36 graus por 24 horas) é recomendado para pacientes comatosos após parada cardíaca, em especial por ritmo chocável (FV ou TV sem pulso) extra-hospitalar, com retorno da circulação espontânea. Portanto, o cenário da alternativa C é a própria indicação.

Contraindicações ou situações de cautela (na época): coma por overdose de drogas ou outra causa que explique o coma, gravidez, coagulopatia ou sangramento ativo e instabilidade hemodinâmica refratária.

Atualização: as diretrizes atuais recomendam controle de temperatura entre 32 e 37,5 graus (evitando febre) por pelo menos 24 horas, para ritmos chocáveis e não chocáveis.

Por que as outras alternativas estão incorretas:
• A) O coma por overdose de drogas tem outra causa para o rebaixamento, e a hipotermia dificulta a avaliação neurológica.
• B) A gravidez era considerada contraindicação relativa na época.
• D) A coagulopatia aumenta o risco de sangramento com a hipotermia.
• E) A instabilidade hemodinâmica grave contraindica o resfriamento.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$São contraindicações para hipotermia terapêutica após ressus$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Coma por overdose de drogas.$Q$, false),
    ('B', $Q$Gravidez.$Q$, false),
    ('C', $Q$Retorno comatoso após fibrilação ventricular extra-hospitalar.$Q$, true),
    ('D', $Q$Coagulopatia.$Q$, false),
    ('E', $Q$Instabilidade hemodinâmica.$Q$, false)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #61] Insuficiência Cardíaca — Gabarito: ANULADA =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Insuficiência Cardíaca$Q$, 2015, 'TEC', $Q$Paciente do sexo masculino, 45 anos com diagnóstico de cardiomiopatia dilatada chagásica e internações por descompensações cardíacas frequentes, deu entrada no pronto-socorro com queixa de dispneia, mal-estar e edema de membros inferiores iniciados há 20 dias e com piora nas últimas 48 horas. Fazia uso de carvedilol, 25 mg/dia, enalapril, 20 mg/dia, espironolactona, 25 mg/dia e furosemida, 40 mg/dia, irregularmente. Encontrava-se orientado, tempo de enchimento capilar maior que 3 segundos, PA = 80 x 60 mmHg, FC = 78 bpm, presença de terceira bulha e estase jugular importante. Exames de entrada: ureia = 110 mg/dL; creatinina = 1,9 mg/dL; BNP = 1800 pg/mL; ECG em ritmo sinusal, bloqueio divisional anterossuperior esquerdo e bloqueio de ramo direito.

Qual é a melhor conduta neste caso?$Q$, $Q$QUESTÃO ANULADA pela banca. Provável motivo: duas condutas defensáveis na IC descompensada com hipotensão e baixa perfusão, que diferem em detalhes de vasodilatador, inotrópico e betabloqueador.$Q$, $Q$Conceito central: IC descompensada fria e úmida (perfil C), com congestão (terceira bulha, estase jugular, edema e BNP de 1800 pg/mL) e baixa perfusão (enchimento capilar maior que 3 s e PA de 80 x 60 mmHg), em contexto de síndrome cardiorrenal (ureia de 110 e creatinina de 1,9 mg/dL).
• Medidas consensuais: ventilação não invasiva se houver desconforto respiratório, avaliação da volemia, diurético de alça venoso e inotrópico (dobutamina), pela hipoperfusão.
• Vasodilatadores venosos são contraindicados com PA tão baixa, e a levosimendana, que também vasodilata, exige cautela.
• Betabloqueador: reduzir ou suspender na baixa perfusão; IECA: suspender diante de hipotensão e piora da função renal.
• Morfina não é recomendada de rotina e intubação é reservada para falha da ventilação não invasiva.

Por que a questão foi anulada: as alternativas A e C são semelhantes quanto a ventilação, volemia, diurético e suspensão do IECA. A alternativa A inclui vasodilatador endovenoso e/ou dobutamina ou levosimendana, e a C propõe dobutamina com redução ou suspensão do carvedilol; a diferença está em detalhes (uso de vasodilatador com PA de 80 x 60, opções de inotrópico e redução versus suspensão do betabloqueador) sobre os quais as diretrizes admitem variações. Assim, mais de uma conduta é defensável.

Por que as outras alternativas estão incorretas:
• A) Ponto discutível: inclui vasodilatador endovenoso (inadequado com PA de 80 x 60), mas oferece alternativa com dobutamina ou levosimendana e suspende betabloqueador e IECA, o que é coerente com baixa perfusão.
• B) Incorreta: mantém o carvedilol em paciente hipotenso e com baixa perfusão, e inclui vasodilatador endovenoso.
• C) Coerente com o perfil frio e úmido: dobutamina, diurético venoso, VNI, avaliação da volemia, redução ou suspensão do carvedilol e suspensão do enalapril; a expressão suspender ou reduzir é imprecisa.
• D) Incorreta: mantém o enalapril com PA de 80 x 60 mmHg e piora renal, e a morfina não é recomendada de rotina.
• E) Incorreta: indica intubação imediata sem tentar a ventilação não invasiva, e usa morfina; é conduta desproporcional, embora a suspensão de carvedilol e enalapril seja adequada.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$Paciente do sexo masculino, 45 anos com diagnóstico de cardi$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Ventilação não invasiva com pressão positiva; avaliar volemia; vasodilatador endovenoso e/ou dobutamina ou levosimendana; furosemida endovenosa; suspender carvedilol e enalapril.$Q$, true),
    ('B', $Q$Ventilação não invasiva com pressão positiva; avaliar volemia; vasodilatador endovenoso e/ou dobutamina; furosemida endovenosa; manter carvedilol e suspender enalapril.$Q$, true),
    ('C', $Q$Ventilação não invasiva com pressão positiva; avaliar volemia; dobutamina; furosemida endovenosa; suspender ou reduzir carvedilol; suspender enalapril.$Q$, true),
    ('D', $Q$Ventilação não invasiva com pressão positiva; avaliar volemia; morfina; dobutamina e/ou norepinefrina; suspender carvedilol e manter enalapril.$Q$, true),
    ('E', $Q$Intubação orotraqueal; avaliar volemia; morfina; dobutamina e/ou norepinefrina; suspender carvedilol e enalapril.$Q$, true)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #62] Hipertensão — Gabarito: ANULADA =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Hipertensão$Q$, 2015, 'TEC', $Q$A respeito das emergências hipertensivas e suas condutas, considere as assertivas a seguir.
I. Em pacientes com acidente vascular encefálico em evolução, o uso do labetalol, esmolol ou nicardipino deve ser realizado com o objetivo de reduzir a pressão arterial média em até 25% em 6-12 horas.
II. O controle dos paroxismos no feocromocitoma deve ser realizado com o uso de fentolamina.
III. Em pacientes com eclâmpsia, o objetivo é manter uma pressão arterial diastólica inferior a 90 mmHg, sendo a metildopa e a hidralazina os anti-hipertensivos de escolha.
Em relação às afirmações, assinale a alternativa CORRETA.$Q$, $Q$QUESTÃO ANULADA pela banca. Provável motivo: metas e prazos de redução pressórica nas emergências hipertensivas (AVE e eclâmpsia) variam entre diretrizes, deixando as assertivas I e III sem resposta única.$Q$, $Q$Conceito central: tratamento das emergências hipertensivas, que exige redução controlada da pressão com fármaco parenteral e meta definida pela situação clínica.
• Assertiva I (AVE em evolução, redução da PA média em até 25% em 6 a 12 horas com labetalol, esmolol ou nicardipino): as diretrizes recomendam redução cautelosa e gradual, e a meta de redução (por exemplo, de 15 a 25% da PA média) e o prazo variam conforme a fonte e o tipo de AVE, o que torna a afirmação contestável.
• Assertiva II (paroxismo do feocromocitoma controlado com fentolamina): verdadeira, pois a fentolamina é alfabloqueador de escolha, ao lado do nitroprussiato.
• Assertiva III (eclâmpsia, PAD abaixo de 90 mmHg, com metildopa e hidralazina): as metas citadas (PAD em torno de 90 a 100 mmHg) e os fármacos variam entre as referências, e a metildopa é de uso oral e não de ação rápida; o magnésio é o fármaco para prevenir convulsões.

Por que a questão foi anulada: a veracidade das assertivas I e III depende da diretriz consultada, e a combinação das alternativas A a E não permite apontar uma única resposta inequívoca.

Por que as outras alternativas estão incorretas:
• A) Considera apenas I correta: a meta de redução em AVE descrita varia entre as fontes e a assertiva II também é verdadeira, portanto a alternativa é incompleta.
• B) Considera apenas II correta: a fentolamina no feocromocitoma está correta, mas a veracidade de I e III é discutível conforme a diretriz.
• C) Considera apenas III correta: a assertiva II também é verdadeira, e a meta de PAD e os fármacos citados na III variam entre as referências.
• D) Considera II e III corretas: a II é verdadeira, mas a III depende da meta de PAD e dos fármacos aceitos (hidralazina é parenteral, metildopa é oral).
• E) Considera I, II e III corretas: a II é verdadeira, e I e III dependem da diretriz.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$A respeito das emergências hipertensivas e suas condutas, co$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Apenas I.$Q$, true),
    ('B', $Q$Apenas II.$Q$, true),
    ('C', $Q$Apenas III.$Q$, true),
    ('D', $Q$II e III.$Q$, true),
    ('E', $Q$I, II e III.$Q$, true)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #63] TEP e HP — Gabarito: A =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$TEP e HP$Q$, 2015, 'TEC', $Q$Em relação à classificação clínica da hipertensão pulmonar feita para servir como guia para a avaliação clínica e terapêutica desses pacientes, correlacione os tipos de hipertensão pulmonar com sua classe correspondente:
Classes: 1. Hipertensão arterial pulmonar idiopática; 2. Valvopatias esquerdas e cardiomiopatias; 3. Doença pulmonar obstrutiva crônica; 4. Tromboembolismo pulmonar crônico.
Tipos (na ordem a preencher): ( ) Hipertensão venosa pulmonar; ( ) Hipertensão pulmonar causada por doença tromboembólica crônica; ( ) Hipertensão arterial pulmonar; ( ) Hipertensão pulmonar associada com doença pulmonar hipoxêmica.$Q$, $Q$Hipertensão venosa pulmonar é do grupo 2 (valvopatia esquerda), a de doença tromboembólica crônica é do grupo 4, a arterial é o grupo 1 e a associada a doença pulmonar hipoxêmica é o grupo 3 — alternativa A.$Q$, $Q$Classificação clínica da hipertensão pulmonar (Dana Point 2008 e Nice 2013):
• Grupo 1: hipertensão arterial pulmonar (idiopática, hereditária, associada a doenças do tecido conjuntivo, HIV, cardiopatias congênitas, esquistossomose).
• Grupo 2: hipertensão pulmonar por doença cardíaca esquerda (valvopatias esquerdas e cardiomiopatias), chamada de hipertensão venosa pulmonar.
• Grupo 3: doenças pulmonares e/ou hipoxemia (DPOC, doença pulmonar intersticial, apneia do sono).
• Grupo 4: tromboembolismo pulmonar crônico (HP tromboembólica crônica).
• Grupo 5: mecanismos multifatoriais ou incertos.

Preenchendo a ordem do enunciado: hipertensão venosa pulmonar = 2 (valvopatias esquerdas e cardiomiopatias); doença tromboembólica crônica = 4; hipertensão arterial pulmonar = 1; doença pulmonar hipoxêmica = 3.

Por que as outras alternativas estão incorretas:
• B) Sequência incorreta: a HP tromboembólica crônica não é o grupo 1.
• C) Sequência incorreta: a HP venosa é do grupo 2, e não do 4.
• D) Sequência incorreta: a HP venosa é do grupo 2, e não do 3.
• E) Sequência incorreta: a HP venosa é do grupo 2, e não do 1.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$Em relação à classificação clínica da hipertensão pulmonar f$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$2, 4, 1, 3.$Q$, true),
    ('B', $Q$2, 1, 3, 4.$Q$, false),
    ('C', $Q$4, 3, 2, 1.$Q$, false),
    ('D', $Q$3, 4, 1, 2.$Q$, false),
    ('E', $Q$1, 2, 4, 3.$Q$, false)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #65] Válvula — Gabarito: E =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Válvula$Q$, 2015, 'TEC', $Q$Considerando os achados clínicos da febre reumática, qual das manifestações a seguir pode ser considerada mais específica (permite diagnóstico isoladamente) e qual é o seu tratamento?$Q$, $Q$A coreia de Sydenham permite diagnóstico isolado de febre reumática e é tratada com neurolépticos, como o haloperidol — alternativa E.$Q$, $Q$Nos critérios de Jones modificados, a coreia de Sydenham, assim como a cardite indolente, pode ser considerada critério suficiente isoladamente quando outras causas são excluídas, por surgir tardiamente, às vezes meses depois da faringite, quando os marcadores de inflamação e a prova de estreptococo podem já ser normais.
• Tratamento sintomático da coreia: fármacos que bloqueiam a dopamina, como haloperidol ou risperidona (antipsicóticos), ou anticonvulsivantes (ácido valproico, carbamazepina). Também se faz profilaxia secundária com penicilina benzatina.
• Anti-inflamatórios não hormonais tratam a artrite e não são tratamento da coreia.
• O eritema marginado e os nódulos subcutâneos são manifestações maiores, mas não permitem diagnóstico isolado.

Dica de prova: coreia = diagnóstico isolado e tratamento com antipsicótico (haloperidol).

Por que as outras alternativas estão incorretas:
• A) AINE trata a artrite; a coreia é tratada com fármacos antidopaminérgicos ou anticonvulsivantes.
• B) O eritema marginado não fecha o diagnóstico isoladamente e não é tratado com AINE.
• C) A cardite pode ser considerada isoladamente em formas indolentes, mas é tratada com corticoide quando moderada ou grave.
• D) A pregabalina não é o tratamento padrão da coreia reumática.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$Considerando os achados clínicos da febre reumática, qual da$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Coreia/anti-inflamatório não hormonal.$Q$, false),
    ('B', $Q$Eritema marginatum/anti-inflamatório não hormonal.$Q$, false),
    ('C', $Q$Cardite/anti-inflamatório não hormonal.$Q$, false),
    ('D', $Q$Coreia/pregabalina.$Q$, false),
    ('E', $Q$Coreia/antipsicóticos.$Q$, true)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #66] Cardiointensiva — Gabarito: C =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Cardiointensiva$Q$, 2015, 'TEC', $Q$Paciente de 68 anos de idade refere súbita dor torácica intensa e perde a consciência. Você avalia a vítima, ela não responde e não respira. Então, você solicita ajuda e inicia as compressões torácicas.
Assinale a alternativa CORRETA em relação ao seu atendimento.$Q$, $Q$No suporte básico de vida em adulto, as compressões devem ter ritmo de pelo menos 100/min e profundidade de pelo menos 5 cm — alternativa C.$Q$, $Q$Parâmetros da RCP de alta qualidade (AHA 2010/2015):
• Compressões: frequência de 100 a 120 por minuto (na versão de 2010, pelo menos 100/min) e profundidade de pelo menos 5 cm (até 6 cm no adulto), com retorno completo do tórax e mínimo de interrupções.
• Relação 30 compressões para 2 ventilações, em um só socorrista ou em dois socorristas sem via aérea avançada.
• Cada ventilação deve durar cerca de 1 segundo, com elevação visível do tórax.

Análise: a alternativa C descreve o ritmo e a profundidade corretos para a época.

Por que as outras alternativas estão incorretas:
• A) A relação de 15:2 é a de dois socorristas em crianças; no adulto é de 30:2.
• B) A frequência de 80 a 100/min está abaixo do recomendado.
• D) Cada ventilação deve durar 1 segundo.
• E) A profundidade de 3 a 5 cm é insuficiente em adultos; o mínimo é de 5 cm.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$Paciente de 68 anos de idade refere súbita dor torácica inte$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Realizar 15 compressões torácicas e 2 ventilações boca-boca (com dispositivo de barreira).$Q$, false),
    ('B', $Q$Realizar 30 compressões torácicas 80 a 100/minuto.$Q$, false),
    ('C', $Q$Realizar compressões torácicas no ritmo de 100/minuto e com 5 cm de profundidade.$Q$, true),
    ('D', $Q$Ventilações devem ter duração de 2 segundos cada.$Q$, false),
    ('E', $Q$As compressões devem ter de 3 a 5 cm de profundidade.$Q$, false)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #67] Aortopatias — Gabarito: A =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Aortopatias$Q$, 2015, 'TEC', $Q$Dilatação da aorta ascendente, envolvendo os seios de Valsalva e a porção tubular inicial, com dissecção da aorta, prolapso valvar mitral e regurgitação valvar aórtica são manifestações cardiovasculares mais frequentemente encontradas na:$Q$, $Q$Dilatação da raiz da aorta, dissecção, prolapso mitral e insuficiência aórtica formam o quadro cardiovascular clássico da síndrome de Marfan — alternativa A.$Q$, $Q$Síndrome de Marfan: doença autossômica dominante do tecido conjuntivo, por mutação do gene da fibrilina 1 (FBN1).
• Cardiovascular: dilatação da raiz da aorta (seios de Valsalva) e da porção tubular inicial, insuficiência aórtica, dissecção da aorta, prolapso da valva mitral com insuficiência.
• Outros: ectopia do cristalino, aracnodactilia, aumento da envergadura, pectus, escoliose e ectasia dural.

Diferenciais:
• Loeys-Dietz: dilatações arteriais difusas, tortuosidade e dissecção em diâmetros pequenos, úvula bífida e hipertelorismo.
• Valva aórtica bicúspide: dilatação da aorta ascendente tubular, e menos dos seios.
• Ehlers-Danlos vascular: ruptura arterial e intestinal espontânea, sem dilatação de raiz típica.
• Arterite de Takayasu: inflamatória, atinge a aorta e seus ramos em mulheres jovens.

Por que as outras alternativas estão incorretas:
• B) A síndrome de Loeys-Dietz tem envolvimento arterial mais amplo, com tortuosidade, e dissecção em diâmetros menores.
• C) Na valva bicúspide, a dilatação costuma ser tubular da aorta ascendente, sem o padrão de seios de Valsalva.
• D) No Ehlers-Danlos vascular, predominam as rupturas arteriais e viscerais.
• E) A arterite de Takayasu é uma vasculite estenosante e aneurismática, e não um transtorno do tecido conjuntivo.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$Dilatação da aorta ascendente, envolvendo os seios de Valsal$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Síndrome de Marfan.$Q$, true),
    ('B', $Q$Síndrome de Loeys-Dietz.$Q$, false),
    ('C', $Q$Valva aórtica bicúspide.$Q$, false),
    ('D', $Q$Síndrome de Ehlers-Danlos.$Q$, false),
    ('E', $Q$Arterite de Takayasu.$Q$, false)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #68] Cardiointensiva — Gabarito: E =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo, imagem_url)
  select $Q$Cardiointensiva$Q$, 2015, 'TEC', $Q$Após dois minutos de ressuscitação cardiopulmonar, checa-se o ritmo em derivação DII (ver traçado a seguir), o paciente não tem pulso. Qual é a próxima ação, segundo o atendimento de Suporte Avançado de Vida?$Q$, $Q$Após 2 minutos de RCP com ritmo não chocável e sem pulso, o correto é retomar imediatamente as compressões e as ventilações — alternativa E.$Q$, $Q$O traçado não está disponível, portanto a resposta se apoia no algoritmo do SBV/SAV.
• Nos ciclos de RCP, após 2 minutos, verifica-se o ritmo. Se for chocável (FV ou TV sem pulso), aplica-se o choque e retoma-se logo a RCP. Se for não chocável (assistolia ou atividade elétrica sem pulso), retoma-se imediatamente a RCP e administra-se adrenalina assim que possível.
• Como nenhuma alternativa propõe choque, o traçado provavelmente é não chocável, e a conduta é voltar às compressões e ventilações.
• Atropina não tem mais indicação na assistolia ou AESP; marca-passo transcutâneo não é indicado na parada; a intubação não deve interromper as compressões; amiodarona 300 mg é para FV ou TV refratária ao choque.

Dica de prova: depois de cada verificação de ritmo, nunca se atrasa o retorno das compressões.

Por que as outras alternativas estão incorretas:
• A) A atropina deixou de ser recomendada na assistolia e na AESP.
• B) A intubação não deve atrasar ou interromper as compressões; é feita durante a RCP.
• C) O marca-passo transcutâneo não é recomendado na parada cardíaca.
• D) A amiodarona 300 mg é dada para FV ou TV sem pulso refratária ao choque; em ritmo não chocável não se usa.$Q$, 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/tec2015-q68.jpg'
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$Após dois minutos de ressuscitação cardiopulmonar, checa-se $Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Administrar atropina, 0,5 mg, intravenoso.$Q$, false),
    ('B', $Q$Realizar intubação orotraqueal imediatamente.$Q$, false),
    ('C', $Q$Instalar marca-passo transcutâneo.$Q$, false),
    ('D', $Q$Administrar amiodarona, 300 mg.$Q$, false),
    ('E', $Q$Retornar imediatamente às compressões e às ventilações.$Q$, true)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #72] Válvula — Gabarito: E =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Válvula$Q$, 2015, 'TEC', $Q$Paciente feminina, 31 anos, apresenta quadro de ortopneia, dispneia aos pequenos esforços e edema de membros inferiores há dois meses. Nega comorbidades, exceto por história de tabagismo na adolescência. Após investigação, realizou-se diagnóstico de estenose mitral importante, insuficiência mitral moderada e insuficiência aórtica discreta, de etiologia reumática. Calculado escore de Wilkins = 9. Sem evidência de trombo em câmaras cardíacas. Qual é a melhor conduta para essa paciente?$Q$, $Q$Estenose mitral importante sintomática com Wilkins 9 e insuficiência mitral moderada não é candidata a valvoplastia por balão; a conduta é o tratamento cirúrgico da valva mitral — alternativa E.$Q$, $Q$Paciente jovem com estenose mitral reumática importante e sintomática (classe funcional III), sem trombo atrial.
• Valvoplastia por cateter-balão é a primeira escolha quando a anatomia é favorável: escore de Wilkins até 8, ausência de calcificação importante e ausência de insuficiência mitral moderada a grave e de trombo.
• Aqui, o escore de Wilkins é 9 (anatomia desfavorável) e há insuficiência mitral moderada (contraindicação relativa ao balão pelo risco de piora da regurgitação).
• Portanto, o tratamento é a cirurgia da valva mitral (comissurotomia, reparo ou troca valvar).
• A insuficiência aórtica discreta não exige tratamento cirúrgico, não justificando troca da valva aórtica.

Atualização: nas diretrizes recentes, o escore de Wilkins sozinho é menos rígido, mas a presença de IM moderada continua desfavorável para o balão.

Por que as outras alternativas estão incorretas:
• A) Tratamento clínico não resolve a estenose importante e sintomática; há indicação de intervenção.
• B) O escore de Wilkins 9 e a insuficiência mitral moderada desfavorecem o balão.
• C) A insuficiência aórtica discreta não requer troca; a cirurgia deve ser mitral.
• D) A pesquisa de FA paroxística não é a conduta prioritária; o quadro já exige intervenção valvar.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$Paciente feminina, 31 anos, apresenta quadro de ortopneia, d$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Betabloqueador e diurético, com seguimento clínico.$Q$, false),
    ('B', $Q$Valvoplastia mitral por cateter balão.$Q$, false),
    ('C', $Q$Cirurgia de troca valvar mitral e aórtica.$Q$, false),
    ('D', $Q$Holter para pesquisa de fibrilação atrial paroxística.$Q$, false),
    ('E', $Q$Tratamento cirúrgico da valva mitral.$Q$, true)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #73] Coronária Crônica — Gabarito: C =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Coronária Crônica$Q$, 2015, 'TEC', $Q$Em relação ao tratamento percutâneo (ICP) versus tratamento clínico otimizado em pacientes portadores de angina estável, assinale a afirmação ERRADA.$Q$, $Q$A ICP não reduz o risco de infarto nem no curto nem no longo prazo na angina estável (o procedimento pode até causar infarto periprocedimento) — alternativa C.$Q$, $Q$Questão do tipo ERRADA: a alternativa-resposta é a falsa.

Evidências sobre ICP versus tratamento clínico otimizado na doença coronária estável:
• O estudo COURAGE mostrou que a ICP somada ao tratamento clínico não reduziu mortalidade nem infarto em relação ao tratamento clínico isolado (B e E, verdadeiras).
• A ICP está indicada para alívio de sintomas anginosos refratários ao tratamento clínico (A, verdadeira).
• O stent não melhorou sobrevida em comparação com o balão; reduziu reestenose e necessidade de nova revascularização (D, verdadeira).
• A ICP não reduz o risco de infarto em curto prazo; pelo contrário, pode causar infarto periprocedimento (C, falsa).

Atualização: o ISCHEMIA (2020) reforçou que a estratégia invasiva inicial não reduz eventos maiores em doença estável com isquemia moderada a grave, e o ORBITA (2017) mostrou que a melhora dos sintomas pela ICP em um vaso é discreta quando comparada com um procedimento simulado.

Por que as outras alternativas estão incorretas:
• A) Verdadeira: o alívio da angina é a principal indicação da ICP na doença estável.
• B) Verdadeira: COURAGE e outros estudos não mostraram benefício de sobrevida com a ICP.
• D) Verdadeira: o stent reduz a reestenose, mas não alterou a mortalidade em relação ao balão.
• E) Verdadeira: a ICP não diminui o risco de infarto do miocárdio no longo prazo na angina estável.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$Em relação ao tratamento percutâneo (ICP) versus tratamento $Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$A ICP está indicada para alívio de sintomas anginosos.$Q$, false),
    ('B', $Q$A ICP não demonstrou melhorar a sobrevida de pacientes estáveis.$Q$, false),
    ('C', $Q$A ICP reduz o risco de infarto do miocárdio no curto prazo.$Q$, true),
    ('D', $Q$A ICP com stent não modificou a sobrevida em relação à angioplastia com balão.$Q$, false),
    ('E', $Q$A ICP não diminui o risco de infarto do miocárdio no longo prazo.$Q$, false)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #76] Taquiarritmia — Gabarito: D =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Taquiarritmia$Q$, 2015, 'TEC', $Q$Das afirmações a seguir, assinale a ERRADA.$Q$, $Q$A associação de poupadores de potássio com IECA induz hipercalemia, e não hipocalemia — alternativa D.$Q$, $Q$Questão do tipo ERRADA: a alternativa-resposta é a falsa.

Interações medicamentosas cardiovasculares:
• Digoxina: a quinidina, o verapamil, a amiodarona e a propafenona aumentam o nível sérico por redução da depuração (inibição da glicoproteína P e da excreção), com risco de intoxicação (A, verdadeira).
• Nitratos com inibidores da fosfodiesterase-5 (sildenafila, vardenafila, tadalafila): contraindicação formal, por hipotensão grave (B, verdadeira).
• Betabloqueador, verapamil, diltiazem, digoxina e amiodarona: efeitos aditivos sobre nó sinusal e AV, com risco de bradicardia e bloqueios (C, verdadeira).
• Diuréticos poupadores de potássio (espironolactona, amilorida, triantereno) com IECA: causam hipercalemia, sobretudo na disfunção renal; a afirmação de hipocalemia é falsa (D).
• Fármacos que prolongam o QT em associação: risco de torsades de pointes (E, verdadeira).

Por que as outras alternativas estão incorretas:
• A) Verdadeira: essas drogas elevam os níveis da digoxina.
• B) Verdadeira: a associação pode causar hipotensão grave e é contraindicada.
• C) Verdadeira: o efeito aditivo no sistema de condução aumenta o risco de bradicardia e BAV.
• E) Verdadeira: associações de drogas que prolongam o QT aumentam o risco de torsades de pointes.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$Das afirmações a seguir, assinale a ERRADA.$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$A digoxina apresenta interações farmacocinéticas com a quinidina, o verapamil, a amiodarona e a propafenona, pois competem pela mesma via de excreção.$Q$, false),
    ('B', $Q$O uso concomitante de nitrato e inibidores da fosfodiesterase-5 (sildenafila, vardenafila, tadalafila) é formalmente contraindicado.$Q$, false),
    ('C', $Q$A associação de fármacos com efeitos inibitórios sobre o sistema de condução, como os betabloqueadores, verapamil, diltiazem, digitálicos e amiodarona, deve ser cautelosa pelo risco de bradicardia e bloqueios atrioventriculares.$Q$, false),
    ('D', $Q$A associação de diuréticos – triantereno, amilorida, espironolactona – com inibidores da enzima de conversão da angiotensina (IECA) pode induzir à hipocalemia, sobretudo no comprometimento da função renal.$Q$, true),
    ('E', $Q$A combinação de fármacos que prolonga o intervalo QT deve ser evitada, pois pode causar arritmias ventriculares complexas, como Torsades de pointes.$Q$, false)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #77] Hipertensão — Gabarito: B =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Hipertensão$Q$, 2015, 'TEC', $Q$Segundo as VI Diretrizes Brasileiras de Hipertensão, com relação ao tratamento não farmacológico, assinale a alternativa CORRETA.$Q$, $Q$Segundo a diretriz, exercícios físicos (aeróbicos, complementados com resistidos) são recomendados ao hipertenso com PA controlada abaixo de 160/105 mmHg — alternativa B.$Q$, $Q$Tratamento não farmacológico na hipertensão (VI Diretriz Brasileira):
• Atividade física: exercício aeróbico regular, complementado por exercícios resistidos, para hipertensos com a pressão controlada; recomenda-se avaliação prévia, e os pacientes com PA acima de 160/105 mmHg devem ter a pressão controlada antes de iniciar o exercício. Essa é a alternativa que mais se aproxima do texto da diretriz.
• Sódio: a recomendação é ingerir no máximo 2 g de sódio (cerca de 5 g de sal) por dia para todos os hipertensos.
• Álcool: o consumo deve ser limitado; não se recomenda iniciar o consumo para reduzir a pressão.
• Tabagismo: a cessação reduz o risco cardiovascular, mas não reduz de modo claro a pressão.
• Controle do estresse (meditação, ioga, musicoterapia): tem benefício modesto sobre a PA, e as técnicas podem ser recomendadas.

Dica de prova: desconfie de afirmativas com garantias (garante claramente) e de recomendações para começar a beber.

Por que as outras alternativas estão incorretas:
• A) Não se recomenda iniciar o consumo de álcool com o objetivo de reduzir a pressão.
• C) A restrição de sódio (até 5 g de sal por dia) é recomendada a todos os hipertensos; não se tolera mais que isso.
• D) A cessação do tabagismo é essencial pelo risco cardiovascular, mas não garante redução da pressão.
• E) Técnicas de controle do estresse têm algum benefício sobre a PA.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$Segundo as VI Diretrizes Brasileiras de Hipertensão, com rel$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Para hipertensos que não possuem o hábito de ingerir bebida alcoólica, pode-se sugerir o uso de quantidades pequenas de álcool diariamente (< 30 g etanol/dia, ou seja, 1 taça de 300 mL de vinho/dia) com o objetivo de baixar a pressão arterial.$Q$, false),
    ('B', $Q$Todo paciente hipertenso deve realizar exercícios físicos isotônico e resistido, desde que suas pressões arteriais sistólica e diastólica estejam < 160 mmHg e/ou < 105 mmHg, respectivamente.$Q$, true),
    ('C', $Q$Nem todos os hipertensos são beneficiados com a diminuição da ingestão de sódio no tratamento da hipertensão arterial, por isso, para alguns casos, tolera-se o uso de mais de 5 g de sal de cozinha/dia.$Q$, false),
    ('D', $Q$A cessação do tabagismo é fundamental por garantir claramente a diminuição dos níveis de pressão arterial em indivíduos hipertensos.$Q$, false),
    ('E', $Q$Técnicas de controle do estresse como meditação, ioga e musicoterapia não promovem nenhum benefício.$Q$, false)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #80] Hipertensão — Gabarito: E =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Hipertensão$Q$, 2015, 'TEC', $Q$Com relação à hipertensão arterial secundária, assinale a alternativa CORRETA.$Q$, $Q$A displasia fibromuscular é causa de hipertensão renovascular mais frequente em mulheres jovens — alternativa E.$Q$, $Q$Hipertensão secundária:
• Hiperaldosteronismo primário: relação aldosterona/atividade de renina elevada (acima de 30) sugere o diagnóstico; menor que 30 afasta.
• Feocromocitoma: a base do tratamento é o alfabloqueio (fenoxibenzamina ou doxazosina) antes do betabloqueio, para evitar crise hipertensiva por vasoconstrição alfa sem oposição.
• Coarctação da aorta: mais comum em homens; suspeita-se pela diferença de pressão entre braços e pernas e pulsos femorais fracos.
• Apneia obstrutiva do sono: confirmada com índice de apneia-hipopneia de 5 ou mais por hora com sintomas (ou 15 ou mais sem sintomas); grave se 30 ou mais.
• Displasia fibromuscular: causa de estenose de artéria renal em mulheres jovens (20 a 50 anos), com o aspecto em colar de contas na angiografia.

Por que as outras alternativas estão incorretas:
• A) Relação aldosterona/renina acima de 30 sugere hiperaldosteronismo primário; abaixo de 30 reduz a probabilidade.
• B) O tratamento inicial é o alfabloqueio; o betabloqueio isolado pode precipitar crise hipertensiva.
• C) A coarctação é mais comum em homens, e o diagnóstico se faz pela diferença de pressão entre membros superiores e inferiores.
• D) O IAH de 5 ou mais confirma apneia (com sintomas), e a forma grave exige IAH de 30 ou mais.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$Com relação à hipertensão arterial secundária, assinale a al$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Pacientes com relação aldosterona sérica/atividade de renina < 30 têm alta probabilidade de serem portadores de hiperaldosteronismo primário.$Q$, false),
    ('B', $Q$Para o tratamento inicial dos feocromocitomas, deve-se começar pelo uso de betabloqueadores, devido ao risco de taquicardia reflexa dos alfabloqueadores.$Q$, false),
    ('C', $Q$A coarctação de aorta é mais comum em mulheres, e o diagnóstico é feito na maioria das vezes por diferença da pressão arterial entre os braços > 10 mmHg.$Q$, false),
    ('D', $Q$O diagnóstico da síndrome da apneia obstrutiva do sono é confirmado pelo achado de dois episódios de apneia e/ou hipopneia por hora de sono (índice de apneia-hipopneia) na polissonografia. É considerada grave se o índice de apneia-hipopneia for maior ou igual a 10.$Q$, false),
    ('E', $Q$A displasia fibromuscular é mais frequentemente encontrada em mulheres jovens.$Q$, true)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #81] Ausculta — Gabarito: A =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Ausculta$Q$, 2015, 'TEC', $Q$Paciente feminino com 38 anos de idade apresenta queixa de dispneia aos pequenos esforços. Ao exame físico apresenta um sopro diastólico em ruflar na área mitral. Em relação a dados complementares da ausculta cardíaca, qual alternativa é a CORRETA?$Q$, $Q$Na estenose mitral, quanto menor o intervalo entre B2 e o estalido de abertura, maior a pressão atrial esquerda e mais grave a lesão — alternativa A.$Q$, $Q$Achados auscultatórios da estenose mitral (sopro diastólico em ruflar na área mitral):
• B1 hiperfonética: valva ainda móvel (flexível); a B1 diminui quando a valva se calcifica e perde mobilidade.
• Estalido de abertura: logo após B2; quanto mais curto o intervalo B2-EA (menos de 80 ms), maior a pressão atrial esquerda e mais importante a estenose.
• B2 com hiperfonese do componente pulmonar (P2) na hipertensão pulmonar.
• Sopro de Carey Coombs: sopro mesodiastólico mitral breve da cardite reumática aguda (fluxo aumentado por valvulite), e não insuficiência pulmonar.
• A terceira bulha não é característica da estenose mitral pura, pois o enchimento ventricular está limitado.

Dica de prova: EA precoce = estenose mais grave.

Por que as outras alternativas estão incorretas:
• B) A B1 hiperfonética indica valva flexível e móvel; a calcificação a reduz.
• C) A hipertensão pulmonar causa hiperfonese de P2, e não hipofonese de B2.
• D) A B3 geralmente não está presente na estenose mitral pura.
• E) O sopro de Carey Coombs é mitral, da cardite reumática aguda, e não da insuficiência pulmonar (esse é o sopro de Graham Steell).$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$Paciente feminino com 38 anos de idade apresenta queixa de d$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Um intervalo mais curto entre a segunda bulha e o estalido de abertura notado na área mitral indica lesão mais acentuada.$Q$, true),
    ('B', $Q$A primeira bulha hiperfonética indica calcificação acentuada da valva.$Q$, false),
    ('C', $Q$A segunda bulha hipofonética é relacionada com hipertensão pulmonar.$Q$, false),
    ('D', $Q$A terceira bulha está frequentemente presente nessa situação.$Q$, false),
    ('E', $Q$Sopro diastólico de Carey Coombs indica insuficiência pulmonar secundária à hipertensão pulmonar.$Q$, false)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #82] Insuficiência Cardíaca — Gabarito: D =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Insuficiência Cardíaca$Q$, 2015, 'TEC', $Q$Conforme a classificação da insuficiência cardíaca baseada em sintomas e na progressão da doença, qual dos pacientes abaixo poderia ser classificado em classe funcional III estágio C?$Q$, $Q$Paciente com cardiopatia estrutural (dilatação de câmaras esquerdas) e sintomas aos esforços menores que os habituais corresponde ao estágio C e à classe funcional III — alternativa D.$Q$, $Q$Classificação da IC:
• Estágios (ACC/AHA): A, risco de IC sem doença estrutural; B, doença estrutural sem sintomas; C, doença estrutural com sintomas atuais ou prévios; D, IC refratária avançada.
• Classe funcional (NYHA): I, assintomático; II, sintomas aos esforços habituais; III, sintomas aos esforços menores que os habituais; IV, sintomas em repouso.

A paciente da alternativa D tem dilatação de câmaras esquerdas (cardiopatia estrutural) e cansaço aos esforços menores que os habituais: NYHA III, estágio C.

Por que as outras alternativas estão incorretas:
• A) Cardiomiopatia dilatada assintomática há 2 anos: estágio B e NYHA I.
• B) Hipertensão e diabetes com cansaço aos grandes esforços, sem cardiopatia estrutural comprovada: estágio A.
• C) Sintomas em repouso, internações frequentes e terapia máxima: classe IV e estágio D (refratária).
• E) Cardiopatia isquêmica com FE normal e dor torácica recente: é manifestação de isquemia, e não de IC sintomática classe III.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$Conforme a classificação da insuficiência cardíaca baseada e$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Paciente de 67 anos, sexo masculino, com diagnóstico de cardiomiopatia dilatada valvar, fração de ejeção do ventrículo esquerdo de 44%, assintomático há dois anos.$Q$, false),
    ('B', $Q$Paciente de 42 anos, sexo masculino, com história de hipertensão arterial, diabete melito e cansaço aos grandes esforços.$Q$, false),
    ('C', $Q$Paciente de 56 anos, sexo masculino, com hospitalizações frequentes por edema generalizado, dispneia e cansaço em repouso, em uso de captopril, metoprolol, ácido acetilsalicílico, sinvastatina, furosemida, hidroclorotiazida, digoxina e espironolactona.$Q$, false),
    ('D', $Q$Paciente de 54 anos, sexo feminino, com consulta recente em ambulatório de cardiologia, ecocardiograma com dilatação de câmaras esquerdas e fração de ejeção do ventrículo esquerdo de 50%, apresentando cansaço para atividades menores que as habituais.$Q$, true),
    ('E', $Q$Paciente de 62 anos, com diagnóstico de cardiomiopatia isquêmica, fração de ejeção do ventrículo esquerdo de 56%, apresentando dor torácica de início recente.$Q$, false)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #83] Hipertensão — Gabarito: A =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Hipertensão$Q$, 2015, 'TEC', $Q$Entre as recomendações para mensuração da pressão arterial em idosos, assinale a alternativa ERRADA.$Q$, $Q$A medida da pressão arterial exige repouso de 5 minutos e ausência de exercício nos 60 a 90 minutos anteriores; a recomendação de apenas 30 minutos de repouso após exercício está incorreta — alternativa A.$Q$, $Q$Questão do tipo ERRADA: a alternativa-resposta é a falsa.

Cuidados na aferição da PA, especialmente em idosos:
• Antes da medida: repouso de 5 minutos em ambiente calmo; não ter praticado exercícios físicos nos 60 a 90 minutos anteriores, não estar com a bexiga cheia, não ter fumado ou ingerido café ou álcool nos 30 minutos anteriores. O período de 30 minutos citado como repouso após exercício é insuficiente.
• Hiato auscultatório: desaparecimento dos sons entre a fase I e a III de Korotkoff, comum em idosos, pode levar a subestimar a PAS (B, verdadeira).
• Hipotensão pós-prandial e hipotensão ortostática exigem medidas em diferentes posições e horários (C, verdadeira).
• Pseudo-hipertensão: artérias rígidas e calcificadas que não colabam, com leitura falsamente elevada (D, verdadeira).
• Maior variabilidade da pressão (E, verdadeira).

Por que as outras alternativas estão incorretas:
• B) Verdadeira: o hiato auscultatório é frequente em idosos.
• C) Verdadeira: a hipotensão pós-prandial pode alterar a medida.
• D) Verdadeira: a pseudo-hipertensão ocorre por rigidez arterial.
• E) Verdadeira: idosos têm maior variabilidade da pressão arterial.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$Entre as recomendações para mensuração da pressão arterial e$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Solicitar repouso de 30 minutos em ambiente calmo, após ter realizado exercícios físicos.$Q$, true),
    ('B', $Q$Os idosos podem apresentar hiato auscultatório.$Q$, false),
    ('C', $Q$A hipotensão pós-prandial pode prejudicar a interpretação do resultado.$Q$, false),
    ('D', $Q$Pode ocorrer pseudo-hipertensão.$Q$, false),
    ('E', $Q$Os idosos apresentam maior variação da pressão arterial.$Q$, false)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #84] TEP e HP — Gabarito: D =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$TEP e HP$Q$, 2015, 'TEC', $Q$Mulher com hipertensão arterial pulmonar importante, assinale a alternativa CORRETA:$Q$, $Q$Na gestante com hipertensão arterial pulmonar importante, o periparto e o puerpério são as fases de maior risco de óbito materno — alternativa D.$Q$, $Q$A hipertensão arterial pulmonar (HAP) grave tem mortalidade materna elevada (cerca de 30 a 50%), e a gestação é contraindicada, por isso:
• Há contraindicação (classe I) para gravidez em HAP; recomenda-se interrupção precoce se ela ocorrer (A, falsa).
• A maioria das gestações não evolui bem; muitas são interrompidas ou terminam com complicações e prematuridade (B, falsa).
• Anticoncepção: evitar estrogênio (risco trombótico); prefere-se método com progestágeno (implante ou DIU hormonal) ou DIU de cobre; algumas drogas (bosentana) reduzem a eficácia dos anticoncepcionais orais (C, falsa).
• O maior risco materno é no periparto e no puerpério, quando ocorrem as maiores alterações hemodinâmicas (D, verdadeira).

Por que as outras alternativas estão incorretas:
• A) A gravidez é contraindicada na HAP importante, pela alta mortalidade materna.
• B) A mortalidade materna e a prematuridade são altas; a maioria não chega ao termo sem intercorrências.
• C) Anticoncepcionais com estrogênio devem ser evitados pelo risco de trombose.
• E) Somente a D está correta.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$Mulher com hipertensão arterial pulmonar importante, assinal$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Não há contraindicação absoluta para gravidez.$Q$, false),
    ('B', $Q$Apesar do risco de óbito materno, a maioria das gestações chega a termo.$Q$, false),
    ('C', $Q$A anticoncepção deve ser realizada com anticoncepcionais à base de estrógeno.$Q$, false),
    ('D', $Q$Os períodos periparto e puerpério são as fases em que ocorrem maior risco de óbito materno.$Q$, true),
    ('E', $Q$Todas alternativas estão corretas.$Q$, false)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #86] Hipertensão — Gabarito: B =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Hipertensão$Q$, 2015, 'TEC', $Q$De acordo com as VI Diretrizes Brasileiras de Hipertensão Arterial, quanto tempo pode-se e deve-se tentar medidas higienodietéticas antes de se iniciar tratamento medicamentoso em pacientes com risco adicional baixo?$Q$, $Q$Em hipertensos com risco adicional baixo, a diretriz admite tentar apenas medidas higienodietéticas por até 6 meses — alternativa B.$Q$, $Q$Conduta segundo a estratificação de risco (VI Diretriz Brasileira de Hipertensão):
• Sem risco adicional (pré-hipertensão ou normotensos): medidas não farmacológicas.
• Risco adicional baixo: medidas higienodietéticas isoladas por até 6 meses; se a meta não for atingida, inicia-se o tratamento medicamentoso.
• Risco médio: medidas por até 3 meses antes do fármaco.
• Risco alto e muito alto: tratamento medicamentoso imediato associado ao estilo de vida.

Dica de prova: risco baixo, 6 meses; risco médio, 3 meses; alto, imediato.

Por que as outras alternativas estão incorretas:
• A) Nove meses não é o prazo recomendado.
• C) Três meses é o prazo para o risco médio.
• D) Um mês não é o prazo indicado para teste do tratamento não farmacológico.
• E) Um ano é muito longo para manter apenas as medidas não farmacológicas.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$De acordo com as VI Diretrizes Brasileiras de Hipertensão Ar$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Nove meses.$Q$, false),
    ('B', $Q$Seis meses.$Q$, true),
    ('C', $Q$Três meses.$Q$, false),
    ('D', $Q$Um mês.$Q$, false),
    ('E', $Q$Um ano.$Q$, false)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #87] Coronária Crônica — Gabarito: E =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Coronária Crônica$Q$, 2015, 'TEC', $Q$Paciente de 45 anos, sexo feminino, portadora de diabete melito tipo 2, mantendo angina estável em classe funcional II apesar do tratamento clínico otimizado, foi submetida à coronariografia. O exame revelou obstruções maiores que 70% em porção proximal das artérias descendente anterior, circunflexa e coronária direita; a função sistólica global do ventrículo esquerdo estava normal; o escore Syntax foi de 26. Qual é a opção de tratamento mais adequada?$Q$, $Q$Diabética com doença trivascular proximal e Syntax de 26 se beneficia mais da cirurgia de revascularização — alternativa E.$Q$, $Q$Paciente com angina estável persistente apesar do tratamento clínico, diabetes tipo 2, três vasos com lesões proximais e função ventricular normal. Syntax de 26 está na faixa intermediária (23 a 32), em que os dados favorecem a cirurgia.
• No FREEDOM, diabéticos multiarteriais submetidos a RM tiveram menos mortes e infartos do que com ICP e stent farmacológico.
• No SYNTAX, escore intermediário e alto, e diabetes, tiveram melhores resultados com a cirurgia.
• A ICP (com stent convencional ou farmacológico) seria opção para escore baixo (até 22) ou alto risco cirúrgico.
• A FFR é útil para definir lesões intermediárias, o que não é o caso (obstruções acima de 70%).

Dica de prova: diabético multiarterial com Syntax intermediário ou alto: cirurgia.

Por que as outras alternativas estão incorretas:
• A) O tratamento clínico já foi otimizado e a angina persiste, havendo indicação de revascularização.
• B) Stents convencionais são inferiores aos farmacológicos e não são a melhor opção em multiarteriais diabéticos.
• C) ICP com stent farmacológico seria alternativa, mas a cirurgia é superior em diabéticos multiarteriais.
• D) A FFR serve para lesões intermediárias, e aqui as lesões são acima de 70%.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$Paciente de 45 anos, sexo feminino, portadora de diabete mel$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Intensificação do tratamento clínico.$Q$, false),
    ('B', $Q$Angioplastia coronária com stents convencionais.$Q$, false),
    ('C', $Q$Angioplastia coronária com stents farmacológicos.$Q$, false),
    ('D', $Q$Angioplastia coronária dependendo do resultado da reserva de fluxo fracionada (FFR).$Q$, false),
    ('E', $Q$Cirurgia de revascularização do miocárdio.$Q$, true)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #88] Válvula — Gabarito: B =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Válvula$Q$, 2015, 'TEC', $Q$Na estenose aórtica (EAo), está indicada a correção cirúrgica, EXCETO:$Q$, $Q$A cirurgia na estenose aórtica importante depende da presença de sintomas ou de disfunção ventricular, e não é indicada em todos independentemente do risco — alternativa B.$Q$, $Q$Questão do tipo EXCETO.

Indicações de troca valvar na estenose aórtica importante (Diretrizes Brasileiras de Valvopatias):
• Sintomática (angina, síncope ou insuficiência cardíaca): classe I.
• Assintomática com FEVE menor que 50%: classe I (D).
• Quando há cirurgia de revascularização, aorta ou de outra valva: troca da valva aórtica na estenose importante, e deve-se avaliar na moderada (A).
• Assintomática com resposta anormal ao teste ergométrico (sintomas desproporcionais ao esforço ou queda de pressão): indicação (E).

A alternativa B generaliza: nem toda EAo importante, independentemente de sintomas e risco, tem indicação cirúrgica (o paciente assintomático, sem disfunção e sem teste anormal, pode ser acompanhado, e os de risco proibitivo podem receber TAVI ou tratamento conservador).

Por que as outras alternativas estão incorretas:
• A) Indicado: troca da valva aórtica durante revascularização em EAo moderada deve ser avaliada.
• C) Indicado: sintomático com EAo importante tem classe I (área valvar abaixo de cerca de 1,0 cm2 ou 0,6 cm2/m2; o enunciado cita 0,7 cm2).
• D) Indicado: FEVE menor que 50% em EAo importante é indicação classe I mesmo assintomática.
• E) Indicado: teste ergométrico anormal em EAo importante assintomática é indicação.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$Na estenose aórtica (EAo), está indicada a correção cirúrgic$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Pacientes com EAo moderada submetidos à cirurgia de revascularização miocárdica devem ser avaliados quanto à troca da valva aórtica.$Q$, false),
    ('B', $Q$Pacientes com EAo importante, independentemente do risco cirúrgico.$Q$, true),
    ('C', $Q$Pacientes com EAo importante, sintomáticos, está indicada com área valvar abaixo de 0,7 cm2.$Q$, false),
    ('D', $Q$Pacientes com EAo importante e fração de ejeção (FE) < 50%.$Q$, false),
    ('E', $Q$Teste ergométrico com sintomas desproporcionais ao esforço realizado é critério de indicação cirúrgica na EAo importante assintomática.$Q$, false)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #89] Válvula — Gabarito: A =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Válvula$Q$, 2015, 'TEC', $Q$Paciente feminina, 24 anos, com histórico de doença reumática e acometimento na valva mitral. Há dez dias teve contato com um primo que estava com faringite e começou a apresentar febre, dispneia (NYHA III/IV) e mal-estar. Foi avaliada pela equipe de cardiologia, que solicitou um eletrocardiograma, provas de inflamação e pesquisa do estreptococo. Para fechar o diagnóstico de recorrência de febre reumática neste caso são necessários, no mínimo:$Q$, $Q$Na recorrência de febre reumática em portador de cardiopatia reumática, bastam dois critérios menores com infecção estreptocócica comprovada — alternativa A.$Q$, $Q$Critérios de Jones para a recorrência da febre reumática em paciente com cardiopatia reumática estabelecida ou febre reumática prévia:
• Podem ser suficientes dois critérios menores associados à evidência de infecção estreptocócica prévia (cultura de orofaringe, teste rápido, ASLO elevada), segundo a diretriz brasileira e a AHA (2015).
• Em primeiro episódio, são necessários dois critérios maiores ou um maior e dois menores, mais a evidência de infecção estreptocócica.
• Portadores de cardiopatia reumática têm maior risco de recorrência, por isso o limiar diagnóstico é menor.

Neste caso, a paciente tem febre, dispneia e infecção recente por contato com faringite: a recorrência é provável.

Por que as outras alternativas estão incorretas:
• B) Um maior e um menor é insuficiente para o primeiro episódio; para a recorrência, dois menores já bastam com evidência de infecção.
• C) A história prévia não dispensa os critérios; é necessária a evidência de infecção estreptocócica.
• D) Dois critérios maiores bastam, mas não são o mínimo necessário na recorrência.
• E) Cinco critérios menores não são necessários.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$Paciente feminina, 24 anos, com histórico de doença reumátic$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Dois critérios menores e a infecção estreptocócica comprovada.$Q$, true),
    ('B', $Q$Um critério maior, um menor e a infecção estreptocócica comprovada.$Q$, false),
    ('C', $Q$Não há necessidade de nenhum critério pela história prévia.$Q$, false),
    ('D', $Q$Dois critérios maiores.$Q$, false),
    ('E', $Q$Cinco critérios menores e a infecção estreptocócica comprovada.$Q$, false)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #90] Válvula — Gabarito: C =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Válvula$Q$, 2015, 'TEC', $Q$Paciente feminina, 24 anos, com histórico de doença reumática e acometimento na valva mitral. Há dez dias teve contato com um primo que estava com faringite e começou a apresentar febre, dispneia (NYHA III/IV) e mal-estar. Foi avaliada pela equipe de cardiologia, que solicitou um eletrocardiograma, provas de inflamação e pesquisa do estreptococo.

Considerando o quadro clínico e a recorrência da doença reumática, qual seria a provável classificação da cardite da paciente e qual é o tempo total da corticoterapia?$Q$, $Q$Recorrência de febre reumática com dispneia em classe funcional III/IV caracteriza cardite grave, tratada com prednisona por cerca de 12 semanas no total — alternativa C.$Q$, $Q$Raciocínio da banca, com base na Diretriz Brasileira de Febre Reumática:
• Classificação da cardite: leve (sem cardiomegalia significativa nem insuficiência cardíaca), moderada (cardiomegalia moderada, sem IC importante) e grave (cardiomegalia importante, insuficiência cardíaca ou pericardite).
• A paciente tem dispneia em NYHA III/IV, ou seja, insuficiência cardíaca em recorrência de febre reumática sobre valvopatia mitral prévia: cardite grave.
• Corticoterapia: prednisona 1 a 2 mg/kg/dia (máximo de 80 mg) por 4 semanas, com redução gradual (cerca de 20% por semana) até completar aproximadamente 12 semanas no total; a pulsoterapia com metilprednisolona é opção nos casos mais graves.
• Complementam o tratamento o repouso, o controle da insuficiência cardíaca e a penicilina benzatina, que se mantém como profilaxia secundária.

A alternativa C, Cardite grave – corticoide por 12 semanas, reúne a classificação e o tempo corretos.

Por que as outras alternativas estão incorretas:
• A) A paciente tem IC; cardite leve dispensa corticoide, que é indicado nas formas moderada e grave.
• B) A paciente tem insuficiência cardíaca (classificação grave) e o esquema não é de 16 semanas.
• D) A classificação moderada não se aplica a quem tem IC em classe funcional III/IV.
• E) A classificação grave está correta, mas a duração de 18 semanas é maior que a usada na diretriz (cerca de 12 semanas).$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$Paciente feminina, 24 anos, com histórico de doença reumátic$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Cardite leve – corticoide por 12 semanas.$Q$, false),
    ('B', $Q$Cardite moderada – corticoide por 16 semanas.$Q$, false),
    ('C', $Q$Cardite grave – corticoide por 12 semanas.$Q$, true),
    ('D', $Q$Cardite moderada – corticoide por 12 semanas.$Q$, false),
    ('E', $Q$Cardite grave – corticoide por 18 semanas.$Q$, false)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #91] Hipertensão — Gabarito: C =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Hipertensão$Q$, 2015, 'TEC', $Q$Gestante na vigésima oitava semana de gestação com hipertensão grave, edema e proteinúria desenvolve plaquetopenia, elevação de enzima hepática e hemólise. Qual é o diagnóstico?$Q$, $Q$Plaquetopenia, enzimas hepáticas elevadas e hemólise em gestante com hipertensão grave caracterizam a síndrome HELLP — alternativa C.$Q$, $Q$HELLP é uma forma grave de pré-eclâmpsia, nome derivado de Hemolysis, Elevated Liver enzymes, Low Platelets.
• Quadro: hipertensão, proteinúria e edema, com hemólise microangiopática, elevação de enzimas hepáticas e plaquetas abaixo de 100 mil/mm3.
• Pode cursar com dor epigástrica, náuseas e risco de hematoma hepático, descolamento de placenta e CIVD.
• O tratamento é a estabilização (sulfato de magnésio, controle da pressão) e o parto, em geral após 34 semanas ou antes se houver gravidade.
• Eclâmpsia: convulsões em paciente com pré-eclâmpsia; a hipertensão renovascular é causa secundária que não explica o quadro.

Por que as outras alternativas estão incorretas:
• A) A pré-eclâmpsia leve não causa hemólise e plaquetopenia.
• B) A hipertensão gestacional não tem proteinúria nem alterações laboratoriais.
• D) A hipertensão renovascular não cursa com esse quadro.
• E) A eclâmpsia se caracteriza por crises convulsivas, que não foram relatadas.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$Gestante na vigésima oitava semana de gestação com hipertens$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Pré-eclâmpsia leve.$Q$, false),
    ('B', $Q$Hipertensão gestacional.$Q$, false),
    ('C', $Q$Síndrome HELLP.$Q$, true),
    ('D', $Q$Hipertensão renovascular.$Q$, false),
    ('E', $Q$Eclâmpsia.$Q$, false)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #92] Válvula — Gabarito: A =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Válvula$Q$, 2015, 'TEC', $Q$Paciente masculino, 62 anos, previamente hipertenso e diabético, em seguimento ambulatorial por quadro de insuficiência mitral importante, secundária a prolapso de cúspide anterior. Queixando-se de dispneia para esforços habituais nos últimos oito meses. Realizado ecocardiograma transtorácico, que evidenciou rotura de cordoalha da cúspide anterior da valva mitral, com insuficiência importante, além de valva aórtica bicúspide com insuficiência aórtica leve. Não foram evidenciadas dilatação ou disfunção ventricular. Qual é a conduta correta?$Q$, $Q$Insuficiência mitral importante sintomática por rotura de cordoalha tem indicação de tratamento cirúrgico da valva mitral, preferencialmente reparo — alternativa A.$Q$, $Q$Paciente com insuficiência mitral degenerativa importante (rotura de cordoalha/flail da cúspide anterior), sintomático (dispneia aos esforços habituais), sem dilatação ou disfunção ventricular.
• Sintomas com IM importante primária são indicação classe I de cirurgia, independentemente da função do VE.
• Preferência pelo reparo da valva (plastia) sempre que possível, que tem melhor sobrevida que a troca; o reparo da cúspide anterior é tecnicamente mais complexo, mas viável em centros experientes.
• A valva aórtica bicúspide com insuficiência leve não exige procedimento.
• Tratamento clínico não modifica a história natural da IM primária importante.

Dica de prova: IM primária grave + sintomas = cirurgia.

Por que as outras alternativas estão incorretas:
• B) A ergoespirometria não é necessária, pois o paciente já é sintomático.
• C) A insuficiência aórtica leve não justifica troca aórtica.
• D) Aguardar 6 meses é inadequado diante de sintomas.
• E) Enalapril e furosemida não substituem a cirurgia.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$Paciente masculino, 62 anos, previamente hipertenso e diabét$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Tratamento cirúrgico da valva mitral.$Q$, true),
    ('B', $Q$Teste ergoespirométrico para melhor avaliação funcional.$Q$, false),
    ('C', $Q$Cirurgia de troca valvar mitral e aórtica.$Q$, false),
    ('D', $Q$Ecocardiograma transesofágico em seis meses para reavaliação.$Q$, false),
    ('E', $Q$Seguimento clínico com prescrição de enalapril e furosemida.$Q$, false)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #93] Válvula — Gabarito: B =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Válvula$Q$, 2015, 'TEC', $Q$A seleção de pacientes para o implante percutâneo de prótese valvar aórtica deve obedecer aos seguintes critérios gerais de avaliação conforme as Diretrizes Brasileiras de Valvopatias 2011, EXCETO:$Q$, $Q$A idade acima de 70 anos, independentemente do risco cirúrgico, não é critério isolado para TAVI: o implante é indicado para pacientes de alto risco ou inoperáveis — alternativa B.$Q$, $Q$Questão do tipo EXCETO.

Critérios gerais para TAVI (Diretrizes Brasileiras de Valvopatias, 2011):
• Estenose aórtica importante sintomática (A).
• Risco cirúrgico proibitivo ou alto: comorbidades graves como cirrose e doença pulmonar grave (C); múltiplas cirurgias prévias, aorta em porcelana, radioterapia torácica, fragilidade (D).
• Anatomia favorável: via de acesso e características cardíacas adequadas (E).
• A idade, na época, era maior que 75 anos (e não 70), associada ao risco cirúrgico alto; independentemente do risco, não é critério.

Atualização: os estudos PARTNER 3 e Evolut Low Risk ampliaram o TAVI para pacientes de risco intermediário e baixo, e as diretrizes atuais consideram principalmente a idade (acima de 75 a 80 anos) e a decisão do heart team.

Por que as outras alternativas estão incorretas:
• A) É critério: estenose importante sintomática.
• C) É critério: comorbidades que tornam proibitivo o risco da cirurgia convencional.
• D) É critério: situações técnicas que dificultam a reoperação.
• E) É critério: anatomia favorável para o acesso e a prótese.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$A seleção de pacientes para o implante percutâneo de prótese$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Presença de estenose aórtica importante sintomática.$Q$, false),
    ('B', $Q$Idade > 70 anos, independentemente da probabilidade de morbimortalidade cirúrgica.$Q$, true),
    ('C', $Q$Presença de comorbidade que eleve de forma proibitiva o risco da cirurgia cardíaca tradicional, por exemplo: cirrose hepática; doença pulmonar grave.$Q$, false),
    ('D', $Q$Múltiplas cirurgias cardíacas prévias, especialmente com enxerto de artéria mamária; aorta em porcelana; radioterapia torácica prévia; fragilidade orgânica acentuada.$Q$, false),
    ('E', $Q$Presença de condição anatômica e morfológica favorável para o procedimento por cateter, incluindo a avaliação pormenorizada da via de acesso e trajeto vascular, bem como dos aspectos cardíacos de interesse para a exequibilidade do procedimento.$Q$, false)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #95] Fisiologia — Gabarito: D =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Fisiologia$Q$, 2015, 'TEC', $Q$Sobre o controle do fluxo coronariano, assinale a alternativa ERRADA.$Q$, $Q$A perfusão coronariana é maior na diástole, e não menor; a afirmação de que o fluxo arterial diminui na diástole é errada — alternativa D.$Q$, $Q$Questão do tipo ERRADA: a alternativa-resposta é a falsa.

Fisiologia do fluxo coronariano:
• O fluxo varia ao longo do ciclo cardíaco (A, verdadeira).
• Na sístole, a contração eleva a pressão tecidual intramiocárdica, que comprime os vasos intramurais e reduz o diâmetro da microcirculação (C, verdadeira). A compressão é maior na camada subendocárdica, o que redistribui a perfusão em direção às camadas subepicárdicas (B, verdadeira).
• Na diástole, o miocárdio relaxa e a pressão tecidual cai: o fluxo arterial coronariano é máximo, e a perfusão subendocárdica ocorre principalmente nesse período (D, falsa).
• O fluxo venoso coronariano é maior na sístole (espremendo o sangue para fora) e diminui na diástole (E, verdadeira).

Dica de prova: o coração é perfundido na diástole; taquicardia reduz a diástole e favorece isquemia subendocárdica.

Por que as outras alternativas estão incorretas:
• A) Verdadeira: o fluxo coronariano oscila com o ciclo cardíaco, com pico em diástole.
• B) Verdadeira: a compressão sistólica é maior no subendocárdio e desvia fluxo para o subepicárdio.
• C) Verdadeira: a pressão tecidual sistólica estreita os vasos intramiocárdicos.
• E) Verdadeira: o esvaziamento venoso ocorre principalmente na sístole.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$Sobre o controle do fluxo coronariano, assinale a alternativ$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Há variação no fluxo coronariano ao longo do ciclo cardíaco.$Q$, false),
    ('B', $Q$A contração sistólica aumenta a pressão tecidual e redistribui a perfusão das camadas subendocárdicas para as subepicárdicas.$Q$, false),
    ('C', $Q$A compressão sistólica reduz o diâmetro de vasos da microcirculação intramiocárdica.$Q$, false),
    ('D', $Q$Durante a diástole o fluxo arterial coronariano é reduzido, ocorrendo menor perfusão subendocárdica.$Q$, true),
    ('E', $Q$Durante a diástole, o fluxo venoso coronariano diminui.$Q$, false)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #96] Coronária Crônica — Gabarito: A =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Coronária Crônica$Q$, 2015, 'TEC', $Q$Em relação à nefropatia induzida por contraste (NIC):
I. A definição de NIC é um declínio na função renal seguido da administração endovenosa de contraste. Isto é, aumento absoluto na concentração de creatinina sérica de pelo menos 0,5 mg/dL, ou por um aumento relativo de, pelo menos, 25% do valor de base.
II. A NIC parece ser resultado de uma combinação sinérgica de toxicidade direta à célula epitelial tubular renal e isquemia medular renal.
III. Os pacientes com NIC tipicamente apresentam aumento abrupto da creatinina sérica 24 a 48 horas após o exame contrastado. Esse aumento alcança seu pico em 48 a 96 horas, e pode retornar aos valores de base entre sete e dez dias após o exame contrastado.
Assinale a afirmativa CORRETA.$Q$, $Q$As três assertivas descrevem corretamente a nefropatia induzida por contraste: definição, fisiopatologia e curso temporal — alternativa A.$Q$, $Q$Nefropatia induzida por contraste (NIC):
I. Correta. Define-se pelo aumento absoluto da creatinina de pelo menos 0,5 mg/dL ou aumento relativo de pelo menos 25% em relação ao valor basal, após a administração do contraste.
II. Correta. Resulta de toxicidade direta do contraste sobre as células tubulares e de isquemia da medular renal (vasoconstrição, aumento da viscosidade tubular e geração de radicais livres).
III. Correta. A creatinina sobe nas primeiras 24 a 48 horas, atinge o pico em 3 a 5 dias (48 a 96 horas) e volta ao basal em 7 a 10 dias.

Prevenção: hidratação com soro fisiológico, menor volume de contraste, contraste de baixa osmolaridade, suspensão temporária de nefrotóxicos e metformina conforme o caso; N-acetilcisteína tem benefício discutível.

Por que as outras alternativas estão incorretas:
• B) As assertivas II e III também estão corretas.
• C) A assertiva III também está correta.
• D) A assertiva I também está correta.
• E) Todas as assertivas estão corretas.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$Em relação à nefropatia induzida por contraste (NIC): I. A d$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Todas estão corretas.$Q$, true),
    ('B', $Q$Somente a sentença I está correta.$Q$, false),
    ('C', $Q$Somente as sentenças I e II estão corretas.$Q$, false),
    ('D', $Q$Somente as sentenças II e III estão corretas.$Q$, false),
    ('E', $Q$Todas estão incorretas.$Q$, false)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #97] Coronária Crônica — Gabarito: E =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Coronária Crônica$Q$, 2015, 'TEC', $Q$Em pacientes com angina estável, qual dentre os medicamentos abaixo NÃO constitui medicamento de primeira linha?$Q$, $Q$Nitratos de ação prolongada são tratamento sintomático de segunda linha; AAS, estatinas, betabloqueadores e IECA (em diabéticos, hipertensos ou com disfunção) são primeira linha — alternativa E.$Q$, $Q$Tratamento da angina estável (Diretriz de Doença Coronária Estável):
• Fármacos que modificam o prognóstico: AAS, estatinas e IECA (ou BRA), especialmente em diabéticos, hipertensos e com disfunção ventricular.
• Betabloqueadores: primeira linha para alívio dos sintomas e redução de eventos em pacientes com infarto prévio ou disfunção ventricular.
• Nitrato de ação curta: alívio imediato dos sintomas.
• Nitratos de ação prolongada, antagonistas de cálcio, ivabradina, ranolazina e trimetazidina: alternativas ou associações para o controle da angina quando o betabloqueador é contraindicado ou insuficiente.

Dica de prova: nitrato de longa ação não melhora sobrevida e não é a primeira linha.

Por que as outras alternativas estão incorretas:
• A) O AAS é primeira linha, por reduzir eventos cardiovasculares.
• B) As estatinas são primeira linha, pela redução de eventos.
• C) O IECA é recomendado em diabéticos, hipertensos, com disfunção ventricular ou doença vascular.
• D) O betabloqueador é a primeira linha para controle da angina e redução de eventos em muitos pacientes.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$Em pacientes com angina estável, qual dentre os medicamentos$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Ácido acetilsalicílico.$Q$, false),
    ('B', $Q$Estatinas.$Q$, false),
    ('C', $Q$Inibidores da enzima conversora da angiotensina.$Q$, false),
    ('D', $Q$Betabloqueadores.$Q$, false),
    ('E', $Q$Nitratos de ação prolongada.$Q$, true)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #98] Válvula — Gabarito: D =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Válvula$Q$, 2015, 'TEC', $Q$TSR, 59 anos, sexo feminino, apresentando quadro de dispneia progressiva aos esforços há cerca de seis meses, associado à ortopneia e à dispneia paroxística noturna. Nega comorbidades ou uso regular de medicações. Ao exame físico, ritmo cardíaco regular, FC = 76 bpm, PA = 124 x 82 mmHg, sopro mesotelessistólico regurgitativo em foco mitral, +++/6+, irradiando para focos da base. Pulmões limpos. ECG evidencia ritmo sinusal e radiografia do tórax com área cardíaca normal. Qual o achado esperado no ecocardiograma transtorácico?$Q$, $Q$Sopro mesotelessistólico regurgitativo mitral com irradiação para a base em paciente de 59 anos, com área cardíaca normal, sugere prolapso da cúspide posterior — alternativa D.$Q$, $Q$O sopro mesotelessistólico (começa no meio da sístole, após o clique) é típico do prolapso da valva mitral.
• A direção do jato define a irradiação: no prolapso ou flail do folheto posterior, o jato é dirigido anteriormente e o sopro irradia para a base (região esternal e área aórtica), podendo ser confundido com estenose aórtica. No prolapso do folheto anterior, o jato é posterior e o sopro irradia para axila e dorso.
• A paciente não tem febre reumática (sem sintomas ou história), e sem lesão aórtica associada; a etiologia mais provável é degenerativa (mixomatosa).
• A radiografia com área cardíaca normal e o ritmo sinusal são compatíveis com IM de instalação gradual e bem tolerada.

Dica de prova: sopro de IM irradiando para a base sugere folheto posterior; para a axila, folheto anterior.

Por que as outras alternativas estão incorretas:
• A) A etiologia reumática exigiria história compatível e outros achados; o sopro mesotelessistólico sugere prolapso.
• B) O prolapso da cúspide anterior projeta o jato para trás, com irradiação axilar.
• C) A estenose aórtica produz sopro de ejeção em crescendo-decrescendo, e não sopro regurgitativo mitral.
• E) A dupla lesão aórtica tem sopros diastólico e sistólico aórticos, e não sopro mitral regurgitativo.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$TSR, 59 anos, sexo feminino, apresentando quadro de dispneia$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Insuficiência mitral + estenose aórtica de etiologia reumática.$Q$, false),
    ('B', $Q$Insuficiência mitral importante por prolapso da cúspide anterior.$Q$, false),
    ('C', $Q$Estenose aórtica importante + valva aórtica bicúspide.$Q$, false),
    ('D', $Q$Insuficiência mitral importante por prolapso da cúspide posterior.$Q$, true),
    ('E', $Q$Dupla lesão aórtica de etiologia reumática.$Q$, false)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #99] Miocárdio — Gabarito: D =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Miocárdio$Q$, 2015, 'TEC', $Q$A presença de onda Épsilon em um traçado eletrocardiográfico é característica de:$Q$, $Q$A onda épsilon, presente na derivação V1 após o QRS, é característica da cardiomiopatia arritmogênica do ventrículo direito — alternativa D.$Q$, $Q$A onda épsilon é um potencial pequeno e distinto, no final do QRS (início do segmento ST) nas derivações precordiais direitas (V1 a V3), e representa a ativação tardia de áreas do ventrículo direito substituídas por tecido fibrogorduroso.
• É critério maior de diagnóstico da cardiomiopatia (displasia) arritmogênica do ventrículo direito.
• Outros achados: inversão de T de V1 a V3, TV com morfologia de bloqueio de ramo esquerdo, dilatação do VD e realce tardio na ressonância.
• Brugada: padrão de supradesnivelamento ST convexo (tipo 1) em V1-V2. Hipotermia: onda J (Osborn). Cardiomiopatia hipertrófica: hipertrofia ventricular, ondas Q profundas. TVPC: TV bidirecional por esforço.

Por que as outras alternativas estão incorretas:
• A) Na síndrome de Brugada, o achado é o supradesnivelamento do ST em V1-V2 com padrão tipo 1.
• B) Na hipotermia, o achado típico é a onda J de Osborn.
• C) Na cardiomiopatia hipertrófica, há sinais de hipertrofia, ondas Q e alterações de repolarização.
• E) Na TVPC, o ECG basal é normal, e a arritmia é a TV bidirecional com o esforço.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$A presença de onda Épsilon em um traçado eletrocardiográfico$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Síndrome de Brugada.$Q$, false),
    ('B', $Q$Hipotermia.$Q$, false),
    ('C', $Q$Cardiomiopatia hipertrófica.$Q$, false),
    ('D', $Q$Cardiomiopatia arritmogênica do ventrículo direito.$Q$, true),
    ('E', $Q$Taquicardia ventricular polimórfica catecolaminérgica.$Q$, false)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #100] TEP e HP — Gabarito: A =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$TEP e HP$Q$, 2015, 'TEC', $Q$Correlacione os vasodilatores pulmonares a seu mecanismo de ação.
Vasodilatadores: 1. Bosentana; 2. Sildenafila; 3. Ambrisentana; 4. Prostaciclina.
Mecanismos (na ordem a preencher): ( ) Antagonista não seletivo (duplo) dos receptores de endotelina – ET-A e ET-B; ( ) Antagonista seletivo dos receptores A da endotelina – ET-A; ( ) Inibidores da fosfodiesterase-5; ( ) Possui atividade vasodilatadora, antiproliferativa e é potente inibidor da agregação plaquetária.$Q$, $Q$Bosentana é antagonista duplo de endotelina, ambrisentana é seletiva ET-A, sildenafila inibe a fosfodiesterase-5 e a prostaciclina é vasodilatadora antiproliferativa e antiagregante — alternativa A.$Q$, $Q$Fármacos da hipertensão arterial pulmonar:
• Antagonistas dos receptores de endotelina: bosentana (duplo, ET-A e ET-B) e ambrisentana (seletivo ET-A); macitentana é um antagonista dual mais recente. Risco: hepatotoxicidade (bosentana), edema periférico, teratogenicidade.
• Inibidores da fosfodiesterase-5: sildenafila e tadalafila, que aumentam o GMPc e causam vasodilatação.
• Prostanoides: epoprostenol (prostaciclina), treprostinil e iloprosta, potentes vasodilatadores, antiproliferativos e inibidores da agregação plaquetária.

Na ordem do enunciado: duplo ET-A/ET-B = bosentana (1); seletivo ET-A = ambrisentana (3); inibidor da PDE-5 = sildenafila (2); vasodilatador antiproliferativo e antiagregante = prostaciclina (4).

Por que as outras alternativas estão incorretas:
• B) Troca a prostaciclina pelo bloqueador duplo da endotelina.
• C) A sildenafila não é antagonista duplo de endotelina.
• D) A sildenafila não é seletiva ET-A, e a prostaciclina não é inibidora da PDE-5.
• E) A ambrisentana não é duplo antagonista e a prostaciclina não é seletiva ET-A.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$Correlacione os vasodilatores pulmonares a seu mecanismo de $Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$1, 3, 2, 4.$Q$, true),
    ('B', $Q$4, 1, 2, 3.$Q$, false),
    ('C', $Q$2, 3, 1, 4.$Q$, false),
    ('D', $Q$1, 2, 4, 3.$Q$, false),
    ('E', $Q$3, 4, 2, 1.$Q$, false)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #101] Hipertensão — Gabarito: E =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Hipertensão$Q$, 2015, 'TEC', $Q$Quanto ao tratamento medicamentoso da hipertensão arterial, assinale a alternativa ERRADA.$Q$, $Q$O minoxidil é vasodilatador arterial direto (abre canais de potássio e relaxa a musculatura lisa), e não causa contração — alternativa E.$Q$, $Q$Questão do tipo ERRADA: a alternativa-resposta é a falsa.

• Tiazídicos: após 4 a 6 semanas, o volume circulante praticamente se normaliza, e o efeito anti-hipertensivo passa a depender da redução da resistência vascular (A, verdadeira).
• Na disfunção renal grave (clearance abaixo de 30 mL/min), os diuréticos de alça são preferíveis aos tiazídicos (B, verdadeira).
• Alfametildopa: pode causar anemia hemolítica (teste de Coombs positivo), hepatotoxicidade e sedação (C, verdadeira); é de primeira escolha na gestação.
• Alisquireno: inibidor direto da renina (D, verdadeira).
• Minoxidil: abre canais de potássio, causando relaxamento da musculatura lisa e vasodilatação arterial; provoca retenção de sódio, taquicardia reflexa e hirsutismo (E, falsa).

Por que as outras alternativas estão incorretas:
• A) Verdadeira: com o tempo, o volume circulante volta ao normal, e o efeito se mantém por redução da resistência.
• B) Verdadeira: diuréticos de alça mantêm eficácia na disfunção renal grave.
• C) Verdadeira: a metildopa pode causar anemia hemolítica autoimune.
• D) Verdadeira: o alisquireno inibe diretamente a renina.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$Quanto ao tratamento medicamentoso da hipertensão arterial, $Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Após quatro a seis semanas do uso de diuréticos tiazídicos o volume circulante praticamente se normaliza.$Q$, false),
    ('B', $Q$Os diuréticos de alça são preferíveis em pacientes com disfunção renal grave.$Q$, false),
    ('C', $Q$O uso de alfametildopa pode provocar anemia hemolítica.$Q$, false),
    ('D', $Q$O alisquireno é um inibidor direto da ação da renina.$Q$, false),
    ('E', $Q$O minoxidil causa contração da musculatura da parede vascular, levando à diminuição da resistência vascular periférica.$Q$, true)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #112] Aortopatias — Gabarito: B =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Aortopatias$Q$, 2015, 'TEC', $Q$Qual dos exames é o mais adequado para definir o orifício de entrada em paciente com dissecção aórtica aguda tipo A de Stanford?$Q$, $Q$Na dissecção aguda tipo A, a angiotomografia helicoidal é o exame mais utilizado para definir o orifício de entrada, a extensão da dissecção e o acometimento dos ramos — alternativa B.$Q$, $Q$Raciocínio da banca: em paciente instável com suspeita de dissecção aguda, o exame deve ser rápido, amplamente disponível e de alta acurácia. A angiotomografia helicoidal tem sensibilidade e especificidade próximas de 100%, avalia toda a aorta e os ramos, mostra o flap intimal e o orifício de entrada, a extensão proximal e distal, a falsa luz, o derrame pericárdico e o hemomediastino.
• Ecocardiograma transesofágico: excelente para o orifício de entrada na aorta ascendente, a insuficiência aórtica e o derrame, e pode ser feito à beira do leito, porém depende do operador, exige sedação e tem pontos cegos (aorta ascendente distal e arco).
• Aortografia: método invasivo, mais lento, hoje pouco usado.
• Angiorressonância: acurada, mas pouco disponível e pouco prática na emergência, com tempo longo de exame.
• Ecocardiograma transtorácico: limitado para a aorta, útil para a raiz, o derrame e a insuficiência aórtica.

Por que as outras alternativas estão incorretas:
• A) A aortografia é invasiva e lenta, com acurácia inferior à da angiotomografia, e caiu em desuso.
• C) O transesofágico é muito sensível para o orifício de entrada, mas depende do operador, exige sedação e tem pontos cegos; a banca privilegiou a angiotomografia.
• D) A angiorressonância é acurada, mas de disponibilidade limitada e demorada para o paciente instável.
• E) O transtorácico tem janela limitada para a aorta e baixa sensibilidade para o orifício de entrada.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$Qual dos exames é o mais adequado para definir o orifício de$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Aortografia torácica.$Q$, false),
    ('B', $Q$Angiotomografia helicoidal.$Q$, true),
    ('C', $Q$Ecocardiograma transesofágico.$Q$, false),
    ('D', $Q$Angiorressonância magnética.$Q$, false),
    ('E', $Q$Ecocardiograma transtorácico.$Q$, false)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #113] Sd. Coronariana Aguda — Gabarito: D =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo)
  select $Q$Sd. Coronariana Aguda$Q$, 2015, 'TEC', $Q$Em relação aos escores de risco para estratificação prognóstica dos pacientes portadores de angina instável/infarto agudo do miocárdio sem supradesnivelamento do segmento ST, pode-se afirmar que:$Q$, $Q$O escore GRACE incorpora frequência cardíaca, creatinina e parada cardíaca na admissão, e permite estratificação na admissão e na alta — alternativa D.$Q$, $Q$Escores de risco nas síndromes coronarianas sem supra de ST:
• TIMI Risk (sete variáveis): idade de 65 anos ou mais, 3 ou mais fatores de risco, estenose coronariana conhecida de 50% ou mais, desvio do ST, 2 ou mais episódios de angina em 24 horas, uso de AAS nos últimos 7 dias, elevação de marcadores. Não inclui clearance de creatinina.
• GRACE: idade, frequência cardíaca, pressão arterial sistólica, creatinina, classe Killip, parada cardíaca na admissão, desvio de ST e elevação de marcadores; permite estimar o risco intra-hospitalar e em 6 meses, na admissão e na alta; é considerado o escore mais acurado.
• CRUSADE: estima risco de sangramento, e não de morte ou infarto.
• Variáveis clínicas de risco intermediário e alto: idade acima de 75 anos, dor prolongada, sopro mitral novo ou estertores, alterações dinâmicas do ST caracterizam risco alto (e não moderado).

Por que as outras alternativas estão incorretas:
• A) O TIMI inclui o uso de AAS nos últimos 7 dias.
• B) O TIMI usa idade (65 anos ou mais), mas não inclui o clearance de creatinina.
• C) O CRUSADE estratifica risco de sangramento, e não de infarto ou morte.
• E) Os achados citados caracterizam o risco alto, e não moderado.$Q$
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$Em relação aos escores de risco para estratificação prognóst$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$O escore de risco TIMI não leva em conta o uso de medicamentos nos últimos sete dias.$Q$, false),
    ('B', $Q$Entre as variáveis utilizadas no escore de risco TIMI estão a idade do paciente e o clearance de creatinina sérica.$Q$, false),
    ('C', $Q$O escore de risco CRUSADE apresenta superioridade sobre os escores de risco comumente utilizados na avaliação de novo infarto ou morte dos portadores de angina instável/infarto agudo do miocárdio sem supradesnivelamento do segmento ST.$Q$, false),
    ('D', $Q$O escore de risco GRACE permite uma estratificação mais acurada tanto na admissão quanto na alta hospitalar, incorporando outras variáveis prognósticas, entre as quais: frequência cardíaca, nível de creatinina, parada cardíaca na admissão hospitalar.$Q$, true),
    ('E', $Q$Idade > 75 anos, dor precordial prolongada (> 20 minutos), surgimento de sopro em foco mitral e/ou estertoração pulmonar, alterações dinâmicas de ST/T caracterizam os pacientes como de moderado risco para o desenvolvimento de morte ou infarto nas síndromes coronarianas sem supradesnivelamento do segmento ST.$Q$, false)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #118] Válvula — Gabarito: A =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo, imagem_url)
  select $Q$Válvula$Q$, 2015, 'TEC', $Q$Paciente, 48 anos, apresenta quadro súbito de dispneia, que piora com o decúbito, procura a emergência cardiológica onde realiza o ecocardiograma abaixo. Qual é o diagnóstico provável?$Q$, $Q$Dispneia súbita que piora no decúbito sugere insuficiência mitral aguda, por exemplo por ruptura de corda tendínea — alternativa A.$Q$, $Q$A imagem do ecocardiograma não está disponível; a resposta se apoia no quadro clínico.
• Dispneia de início súbito, que piora em decúbito (ortopneia), em paciente de 48 anos: apresentação de edema pulmonar agudo, em geral por insuficiência mitral aguda grave.
• A ruptura de corda tendínea (degeneração mixomatosa, endocardite, trauma) causa sobrecarga súbita do átrio esquerdo, com congestão pulmonar, sem tempo para adaptação.
• Estenose mitral e estenose aórtica têm evolução gradual; mixoma pode causar sintomas posicionais, mas tende a se apresentar de modo mais insidioso, com embolias; cor triatriatum é congênito e se manifesta na infância.

Dica de prova: dispneia súbita + sopro novo = insuficiência mitral aguda; o ecocardiograma mostra folheto flail e jato excêntrico.

Por que as outras alternativas estão incorretas:
• B) A estenose mitral tem evolução gradual, com sopro diastólico em ruflar.
• C) O mixoma costuma ter apresentação mais arrastada, com sintomas constitucionais e embolia; poderia causar dispneia postural, mas a instalação súbita sugere IM aguda.
• D) O cor triatriatum é congênito e se manifesta, em geral, na infância.
• E) A estenose aórtica evolui lentamente com angina, síncope e insuficiência cardíaca.$Q$, 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/tec2015-q118.jpg'
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$Paciente, 48 anos, apresenta quadro súbito de dispneia, que $Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$Insuficiência mitral secundária à ruptura parcial de corda tendínea.$Q$, true),
    ('B', $Q$Estenose mitral.$Q$, false),
    ('C', $Q$Mixoma cardíaco.$Q$, false),
    ('D', $Q$Cor triatriatum.$Q$, false),
    ('E', $Q$Estenose aórtica.$Q$, false)
) as v(letra, texto, correta);

-- ===================== [TEC 2015 #120] Cardiointensiva — Gabarito: A =====================
with q as (
  insert into questions (tema, ano, instituicao, enunciado, comentario, comentario_completo, imagem_url)
  select $Q$Cardiointensiva$Q$, 2015, 'TEC', $Q$Durante o atendimento de vítima em parada cardiorrespiratória foi realizado no segundo ciclo uma desfibrilação com 200 J e administrado 1 mg de epinefrina. Após dois minutos e análise médica do ritmo abaixo, em derivação DII, foi realizada uma nova desfibrilação. Qual fármaco administrar?$Q$, $Q$Em fibrilação ventricular persistente após choque e adrenalina, a primeira dose de antiarrítmico é amiodarona 300 mg — alternativa A.$Q$, $Q$O traçado não está disponível; a descrição (nova desfibrilação indicada após análise do ritmo) corresponde a um ritmo chocável (FV ou TV sem pulso), refratário ao primeiro choque.
• Algoritmo de SAV para ritmo chocável: choque, RCP por 2 minutos, adrenalina 1 mg a cada 3 a 5 minutos após o segundo choque (ou assim que obtido o acesso), e, para FV ou TV refratária, amiodarona 300 mg em bolus na primeira dose; segunda dose de 150 mg.
• A atropina não tem mais papel na parada. A vasopressina deixou de ser recomendada (as diretrizes 2015 a retiraram do algoritmo).
• A adrenalina já foi dada no ciclo anterior, e a nova dose segue o intervalo de 3 a 5 minutos.

Dica de prova: amiodarona 300 mg na primeira dose, 150 mg na segunda; lidocaína é alternativa.

Por que as outras alternativas estão incorretas:
• B) A adrenalina já foi administrada; a repetição segue o intervalo de 3 a 5 minutos, e o fármaco antiarrítmico para ritmo chocável refratário é a amiodarona.
• C) A atropina não é recomendada na parada cardíaca.
• D) A dose de 150 mg é a segunda dose; a primeira é de 300 mg.
• E) A vasopressina foi retirada do algoritmo (equivalente à adrenalina), não sendo a escolha.$Q$, 'https://kjjjkdsexobkwwuosvjb.supabase.co/storage/v1/object/public/question-images/tec2015-q120.jpg'
  where not exists (
    select 1 from questions
    where instituicao = 'TEC' and ano = 2015
      and left(regexp_replace(enunciado, '\s+', ' ', 'g'), 60) = $Q$Durante o atendimento de vítima em parada cardiorrespiratóri$Q$
  )
  returning id
)
insert into question_options (question_id, letra, texto, correta)
select q.id, v.letra, v.texto, v.correta
from q cross join (values
    ('A', $Q$300 mg de amiodarona.$Q$, true),
    ('B', $Q$1 mg de adrenalina.$Q$, false),
    ('C', $Q$1 mg de atropina.$Q$, false),
    ('D', $Q$150 mg de amiodarona.$Q$, false),
    ('E', $Q$40 UI de vasopressina.$Q$, false)
) as v(letra, texto, correta);

-- conferência: deve mostrar o total de questões TEC 2015 no banco (50 já existentes + 70 novas = 120)
select count(*) as total_tec_2015 from questions where instituicao = 'TEC' and ano = 2015;

commit;
