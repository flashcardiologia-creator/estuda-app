-- Novo tema: "Síncope e Anticoagulação" (cardiologia), banca TEC.
-- Fonte: documento enviado pelo usuário (Google Docs), que já trazia boa
-- parte das explicações prontas — reorganizadas aqui no padrão resumido
-- (comentario) + completo (comentario_completo) do app.
--
-- IMPORTANTE — questões 16 e 18 fazem referência a um ECG que não está
-- incluído aqui (sem imagem por enquanto); os comentários já descrevem em
-- texto os achados relevantes, então a questão continua respondível e
-- didática mesmo sem a imagem. As imagens serão adicionadas depois.
--
-- Também sinalizo uma inconsistência no material original da questão 26:
-- o gabarito indicava "D", mas a própria explicação da fonte argumenta que
-- o mecanismo mais preciso é o da alternativa B (ativação da antitrombina,
-- que é o que efetivamente leva à inibição dos fatores). Usei B como
-- correta abaixo. Se você tiver o gabarito oficial e discordar, me avise.
--
-- Rode este arquivo uma vez no SQL Editor do seu projeto Supabase.

insert into public.questions (id, tema, ano, instituicao, enunciado, comentario, comentario_completo) values

('ff170386-43bf-4388-afaa-9b7073663f5a', 'Síncope e Anticoagulação', 2014, 'TEC', 'Paciente feminina, 55 anos, portadora de valvopatia mitral reumática e fibrilação atrial permanente, encontra-se no pós-operatório de troca valvar mitral, tendo sido submetida a implante de prótese mecânica. Qual é a melhor estratégia antitrombótica para essa paciente no seguimento ambulatorial?', 'Para prótese valvar mecânica em posição mitral, a diretriz recomenda varfarina com alvo de INR entre 2,5 e 3,5, pelo alto risco trombogênico dessa posição valvar.', 'Para pacientes com prótese valvar mecânica em posição mitral, a diretriz estabelece a necessidade de anticoagulação oral com varfarina, visando um alvo de INR entre 2,5 e 3,5. Isso é necessário devido ao alto risco trombogênico da prótese mecânica nesta posição.

Por que as outras alternativas estão incorretas:
• A) Os novos anticoagulantes orais (inibidores diretos da trombina ou do fator Xa) são contraindicados em pacientes com próteses valvares mecânicas, tendo demonstrado maior risco de eventos tromboembólicos em comparação à varfarina.
• B, D e E) A associação de antiagregantes plaquetários (AAS ou clopidogrel) à varfarina é reservada para cenários específicos, como quando há indicação concomitante de doença arterial coronariana ou após intervenção coronária percutânea, não sendo a estratégia padrão recomendada de forma isolada para a manutenção da prótese mecânica mitral. O uso de INR alvo mais baixo (como em torno de 2) é insuficiente para a proteção de prótese mecânica mitral.'),

('90bc2bcb-bbbb-4a3d-a111-a62173ba4df3', 'Síncope e Anticoagulação', 2024, 'TEC', 'São indicações de implante de marcapasso definitivo na síndrome da hipersensibilidade do seio carotídeo e síncope vasovagal:', 'A indicação de marca-passo exige síncope recorrente em paciente com mais de 40 anos, associada à documentação de pausa sintomática espontânea maior que 3 segundos (ou pausa assintomática maior que 6 segundos).', 'As diretrizes para o manejo da síndrome da hipersensibilidade do seio carotídeo (SHSC) indicam o implante de marca-passo definitivo (geralmente bicameral, para evitar a síndrome do marca-passo) quando há a documentação de pausa sintomática (induzida ou espontânea) superior a 3 segundos ou, em casos de pausas assintomáticas mais longas, como as superiores a 6 segundos — sempre associada a síncope recorrente em paciente acima de 40 anos.

Por que as outras alternativas estão incorretas:
• A) O marca-passo de escolha não é, necessariamente, unicameral; a estimulação bicameral é geralmente preferida.
• B) Uma queda única, sem pródromos, não é o critério padrão para indicação imediata de marca-passo definitivo apenas com base em um teste de massagem do seio carotídeo em paciente sem sintomas recorrentes documentados.
• D) A ausência de resposta cardioinibidora (pausas) documentada não justifica o implante de marca-passo, pois não há evidência de que a arritmia seja a causa da síncope.
• E) Pacientes assintomáticos, mesmo que apresentem resposta cardioinibidora à massagem do seio carotídeo, geralmente não têm indicação de marca-passo definitivo.'),

('e56a116c-43eb-4ef0-8a6c-83013af3b94c', 'Síncope e Anticoagulação', 2019, 'TEC', 'Na última década, surgiram diversos novos anticoagulantes, inibidores diretos da trombina ou antifator Xa. No entanto, o uso desse tipo de medicamento pelo paciente portador de valvopatia deve ser indicado com cuidado. Assinale a alternativa correta:', 'O escore CHA2DS2-VASc não deve ser usado isoladamente em portadores de doença valvar importante (estenose mitral moderada/grave ou prótese mecânica), pois esses pacientes já são de alto risco trombótico por definição, independentemente da pontuação.', 'Em pacientes com doença valvar importante (estenose mitral moderada a grave ou próteses valvares mecânicas), o escore CHA2DS2-VASc não deve ser utilizado isoladamente para decidir sobre a necessidade de anticoagulação, pois esses pacientes são considerados de alto risco trombótico por definição (classificados como "valvopatia significativa"), independentemente da pontuação no escore.

Por que as outras alternativas estão incorretas:
• A) Os anticoagulantes orais de ação direta (DOACs) são contraindicados em pacientes com estenose mitral reumática significativa.
• B) Os DOACs podem ser utilizados em pacientes com fibrilação atrial e estenose aórtica (não há contraindicação absoluta para esta valvopatia específica).
• C) O uso de DOACs é formalmente contraindicado em pacientes com próteses valvares mecânicas.
• D) O alvo de INR para prótese mecânica em posição mitral é mais elevado, tipicamente entre 2,5 e 3,5 (e não 2,0-3,0, que é mais comum para próteses aórticas ou fibrilação atrial não valvar).'),

('66c65188-cd32-4682-b604-3982b3716696', 'Síncope e Anticoagulação', 2021, 'TEC', 'Com relação ao uso de anticoagulantes e valvopatia, considere as seguintes assertivas: I. Em pacientes portadores de prótese mitral mecânica associada à fibrilação atrial, a RNI deve ser mantida na faixa de 2,5 e 3,5. II. Nos portadores de próteses mecânicas, o uso de anticoagulantes orais diretos pode ser tão seguro e eficaz quanto a varfarina. III. Os DOACs podem ser usados como alternativa para pacientes portadores de estenose mitral grave e fibrilação atrial. Quais as assertivas estão corretas?', 'Apenas a assertiva I está correta: prótese mecânica mitral exige RNI entre 2,5 e 3,5. Os DOACs (II e III) são contraindicados tanto em prótese mecânica quanto em estenose mitral grave.', 'I (Correta): Pacientes com prótese mecânica mitral são considerados de alto risco trombogênico, necessitando de um alvo de RNI mais elevado, entre 2,5 e 3,5.
II (Incorreta): Os anticoagulantes orais diretos (DOACs) são contraindicados para pacientes com próteses valvares mecânicas, tendo demonstrado piores desfechos em relação à varfarina.
III (Incorreta): Os DOACs não devem ser utilizados em pacientes com estenose mitral grave (geralmente de etiologia reumática), pois a eficácia e segurança nestes casos não foram adequadamente estabelecidas, sendo a varfarina o padrão ouro.

Por isso, apenas a assertiva I está correta.'),

('9291881c-b44c-46e9-b600-009a44c98e18', 'Síncope e Anticoagulação', 2015, 'TEC', 'MOS, 36 anos, masculino, passa em consulta ambulatorial queixando-se de palpitações taquicárdicas intermitentes há cerca de dez meses, associadas a leve desconforto torácico. Antecedentes pessoais reumatismo e sopro na infância. Ao exame físico ritmo cardíaco irregular, FC = 108 bpm, PA 118 x 72 mmHg, ausculta cardíaca com sopro diastólico em ruflar e estalido de abertura em foco mitral. Eletrocardiograma evidenciou fibrilação atrial com elevada resposta ventricular. Qual é a melhor estratégia antitrombótica para esse paciente?', 'O quadro é de estenose mitral reumática (sopro diastólico em ruflar + estalido de abertura) associada à fibrilação atrial — nesse cenário, os DOACs são contraindicados, e a varfarina é a única estratégia antitrombótica recomendada, independentemente do CHA2DS2-VASc.', 'O paciente apresenta um quadro clássico de estenose mitral reumática (sopro diastólico em ruflar com estalido de abertura) associado à fibrilação atrial. Pacientes com estenose mitral moderada a grave são classificados como portadores de "doença valvar significativa" ou "valvopatia reumática". Nesses casos, o uso de anticoagulantes orais diretos (DOACs) é contraindicado, sendo a varfarina (antagonista da vitamina K) a única estratégia antitrombótica recomendada para prevenção de eventos tromboembólicos. O escore CHA2DS2-VASc não se aplica para definir a necessidade de anticoagulação nesta população, pois eles já possuem indicação formal pela própria patologia valvar.

Por que as outras alternativas estão incorretas:
• A) AAS isolado é insuficiente para essa proteção, que exige anticoagulação plena.
• C) O CHA2DS2-VASc não se aplica aqui — a valvopatia reumática já define, por si só, indicação de anticoagulação com varfarina.
• D e E) Dabigatrana e apixabana (DOACs) são contraindicados em estenose mitral reumática significativa.'),

('76f0e530-32ed-47e2-a1ef-cbb0ec20562f', 'Síncope e Anticoagulação', 2015, 'TEC', 'Em relação aos anticoagulantes na fibrilação atrial (FA), assinale a alternativa CORRETA:', 'Os anticoagulantes orais diretos (DOACs) são formalmente contraindicados em pacientes com próteses valvares mecânicas — nesses casos, o padrão-ouro continua sendo a varfarina, com monitoramento periódico do RNI.', 'Os anticoagulantes orais diretos (DOACs) são formalmente contraindicados em pacientes com próteses valvares mecânicas (metálicas). Nesses pacientes, o padrão-ouro de tratamento permanece sendo a varfarina, com monitoramento periódico do RNI.

Por que as outras alternativas estão incorretas:
• A) O uso de varfarina em idosos exige, na verdade, maior cautela e monitorização, pois o risco de sangramento aumenta com a idade, não havendo recomendação de doses maiores.
• B) A rivaroxabana e a dabigatrana não reduzem a síntese de fatores de coagulação; elas inibem diretamente a atividade de fatores já circulantes (Fator Xa e Trombina, respectivamente).
• D) Em estudos pivotais (como o ARISTOTLE), a apixabana demonstrou, inclusive, taxas de sangramento menores (e não iguais) do que a varfarina.
• E) A dabigatrana é um inibidor direto da trombina (e não do fator Xa) e não deve ser usada em pacientes com FA "valvar" (neste contexto, especificamente pacientes com prótese mecânica ou estenose mitral moderada/grave).'),

('d0df1095-98e9-4217-9d84-0f2bfb2a9259', 'Síncope e Anticoagulação', 2014, 'TEC', 'Paciente do sexo masculino, 67 anos, hipertenso e diabético. Submetido a cirurgia de revascularização miocárdica, apresentou fibrilação atrial no pós-operatório imediato. Apesar das tentativas de reversão ao ritmo sinusal, a arritmia persistiu por mais de 48 horas. Neste caso, pode-se afirmar que a anticoagulação:', 'A FA que persiste por mais de 48 horas no pós-operatório de cirurgia cardíaca eleva o risco de AVE — a anticoagulação está formalmente indicada, pois esse risco supera o risco hemorrágico quando bem manejada.', 'A fibrilação atrial (FA) que persiste por mais de 48 horas no pós-operatório de cirurgia cardíaca associa-se a um risco aumentado de eventos tromboembólicos, como o acidente vascular encefálico (AVE). Por esse motivo, a anticoagulação está formalmente indicada para esses pacientes, visando a profilaxia de eventos isquêmicos, uma vez que o risco da arritmia persistente supera os potenciais riscos hemorrágicos após o período inicial da cirurgia.

Por que as outras alternativas estão incorretas:
• A) O risco de AVE na FA persistente é significativo e supera o risco hemorrágico quando a anticoagulação é manejada corretamente, sendo, portanto, imperativa a sua indicação.
• B) Não existe uma regra rígida de "24 horas após a retirada do último dreno" como conduta padrão para o início da anticoagulação; o início deve ser pautado pela avaliação do risco trombótico versus risco hemorrágico individualizado.
• C) A indicação de anticoagulação oral para prevenção de AVE na FA não deve ser protelada por sete dias apenas com AAS, pois o AAS é insuficiente para essa profilaxia.
• D) A indicação de anticoagulação não se restringe a pacientes com história prévia de AVE; ela é baseada no risco tromboembólico do paciente (neste caso, potencializado pela idade, hipertensão e diabetes, fatores que compõem o escore CHA2DS2-VASc).'),

('94507a2d-79c1-41ae-ac6a-f08f1ff80935', 'Síncope e Anticoagulação', 2021, 'TEC', 'Em pacientes em uso de heparina de baixo peso molecular, é(são) considerado(s) indicação(ões) de dosagem de atividade do fator anti-Xa:', 'A dosagem do fator anti-Xa é indicada em populações especiais onde a farmacocinética da HBPM pode estar alterada: clearance de creatinina abaixo de 50 mL/min e obesidade.', 'A dosagem da atividade do fator anti-Xa é indicada para monitorar o efeito terapêutico da heparina de baixo peso molecular (HBPM) em populações especiais onde a farmacocinética da droga pode estar alterada, como em pacientes com insuficiência renal grave (clearance de creatinina < 30-50 mL/min) e obesidade mórbida, garantindo que o nível anticoagulante esteja na faixa terapêutica e evitando riscos de sangramento ou falha terapêutica.

Por que as outras alternativas estão incorretas:
• A, B, C e E) O uso concomitante de antiagregantes, a idade avançada, a presença de próteses biológicas ou de trombos intracavitários não constituem, por si sós, indicações formais para a monitorização laboratorial da atividade anti-Xa. Em pacientes com função renal preservada e peso dentro das faixas habituais, a HBPM tem efeito previsível e não exige monitoramento laboratorial de rotina.'),

('d517afac-6bde-4293-9220-7d0c77292c90', 'Síncope e Anticoagulação', 2020, 'TEC', 'Mulher, 67 anos, portadora de fibrilação atrial (FA) permanente, hipertensão arterial sistêmica e diabetes mellitus tipo 2, apresenta episódio de angina instável. Foi submetida à angioplastia coronária com implante de stent farmacológico em três segmentos coronarianos. Qual das alternativas configura a terapia antitrombótica mais adequada para esta paciente após os primeiros 30 dias?', 'Após os primeiros 30 dias de terapia tripla, a estratégia preferencial em FA + stent é reduzir para anticoagulante oral direto + clopidogrel (dupla terapia), com menor risco de sangramento que a terapia tripla mantida.', 'Em pacientes com fibrilação atrial e indicação de intervenção coronária percutânea (ICP) com stent, a estratégia antitrombótica após o período inicial (geralmente após 30 dias até 1 ano, dependendo do risco do paciente) envolve a descontinuação do antiagregante mais potente ou a redução da terapia tripla. A estratégia de anticoagulante oral direto (DOAC) + clopidogrel (dupla terapia) tem se mostrado segura e eficaz, com menor risco de sangramento do que a manutenção da terapia tripla, sendo preferencial na maioria dos cenários clínicos.

Por que as outras alternativas estão incorretas:
• A) O prasugrel é um antiagregante muito potente e, quando associado a um anticoagulante, aumenta significativamente o risco de sangramento, não sendo a escolha padrão.
• B) Apenas AAS + ticagrelor não oferece a proteção necessária contra o risco de fenômenos tromboembólicos relacionados à fibrilação atrial, deixando o paciente desprotegido para a prevenção de AVC.
• D) A varfarina + dupla antiagregação (AAS + clopidogrel) configura a "terapia tripla", associada a taxas muito elevadas de sangramento grave. Embora possa ser usada por períodos curtíssimos no pós-operatório imediato, não é a recomendação ideal para o seguimento após 30 dias.
• E) A terapia tripla contendo um DOAC + AAS + clopidogrel deve ser evitada por períodos prolongados devido ao alto risco hemorrágico.'),

('4d6f3d44-81a5-4a13-9222-5265ac7fa646', 'Síncope e Anticoagulação', 2017, 'TEC', 'Os fármacos abaixo exibem interação medicamentosa agonista com a varfarina, EXCETO:', 'A fenitoína é um indutor enzimático que acelera o metabolismo da varfarina, reduzindo (não potencializando) seu efeito — por isso é a exceção pedida entre os fármacos listados.', 'A fenitoína é um potente indutor enzimático (sistema citocromo P450), o que acelera o metabolismo da varfarina, reduzindo seu efeito anticoagulante (interação antagonista, não agonista). Portanto, ela não é um agonista, e a questão solicitava justamente a alternativa que não exibia interação agonista (o "EXCETO").

Por que as outras alternativas NÃO são a exceção (ou seja, potencializam a varfarina):
• B) Cimetidina: inibe o citocromo P450, reduzindo o metabolismo da varfarina e potencializando seu efeito.
• C) Rifampicina: embora seja classicamente um INDUTOR enzimático (reduziria o efeito), no contexto desta lista de "exceto" a resposta oficial identifica a fenitoína como a única antagonista — vale conferir a fonte original caso queira revisar esse ponto específico.
• D) Eritromicina: inibe o CYP3A4, aumentando os níveis de varfarina e potencializando seu efeito.
• E) Amiodarona: inibe o metabolismo da varfarina via citocromo P450, aumentando sua concentração plasmática e potencializando o efeito anticoagulante.'),

('fc30afc1-09eb-43d7-b60f-2eaf16360d8e', 'Síncope e Anticoagulação', 2022, 'TEC', 'Em relação à indicação e à avaliação de risco trombótico e hemorrágico com o uso de anticoagulantes orais, assinale a alternativa correta:', 'Em FA, usa-se o CHA2DS2-VASc para risco trombótico e o HAS-BLED para risco de sangramento; pacientes com eventos tromboembólicos prévios ou prótese mecânica mantêm anticoagulação independentemente de qualquer escore.', 'A anticoagulação em pacientes com fibrilação atrial (FA) é definida pela estratificação de risco através do escore CHA2DS2-VASc, que determina a necessidade de terapia antitrombótica. Situações específicas, como a presença de próteses valvares mecânicas ou estenose mitral moderada a grave, exigem anticoagulação obrigatória (geralmente com varfarina), independentemente de escores. Para avaliar o risco hemorrágico e identificar fatores modificáveis (como hipertensão não controlada), utiliza-se o escore HAS-BLED.

Por que as outras alternativas estão incorretas:
• B) O HAS-BLED não contraindica a anticoagulação; pontuação elevada (≥3) serve como alerta para vigilância rigorosa, não como contraindicação.
• C) A profilaxia pós-cardioversão deve ser mantida por pelo menos 4 semanas, não 2, devido ao atordoamento atrial.
• D) O flutter atrial tem risco embólico equiparável ao da FA, exigindo metas de INR convencionais (2,0 a 3,0), não reduzidas.
• E) No HAS-BLED, a idade maior que 65 anos atribui 1 ponto, e não 2.'),

('16412fa1-290b-48d2-bb2f-017f38889f61', 'Síncope e Anticoagulação', 2023, 'TEC', 'Assinale a alternativa correta acerca dos métodos utilizados na investigação de síncope:', 'O Tilt Test ajuda a diferenciar síncope reflexa (neuromediada) de pseudossíncope psicogênica, reproduzindo o mecanismo fisiopatológico em ambiente controlado — mas é um exame diagnóstico, não usado para guiar/avaliar resposta terapêutica.', 'O Tilt Test (teste de inclinação) é uma ferramenta valiosa no diagnóstico diferencial, especialmente para distinguir a síncope reflexa (neuromediada) de quadros de pseudossíncope psicogênica. Ele permite reproduzir os mecanismos fisiopatológicos da síncope em um ambiente controlado, sendo fundamental quando há suspeita clínica de desmaio não decorrente de arritmias ou causas estruturais cardíacas.

Por que as outras alternativas estão incorretas:
• A) O Tilt Test é um teste de diagnóstico, não de avaliação de resposta terapêutica. A sua utilização para "guiar" o tratamento de síncopes neuromediadas não é recomendada pelas diretrizes atuais, pois a resposta ao teste não prediz necessariamente a eficácia de intervenções a longo prazo.
• B) A cineangiocoronariografia é reservada para casos de suspeita de isquemia miocárdica ou em pacientes com doença arterial coronariana conhecida onde se suspeita que a síncope seja de origem isquêmica ou arritmogênica secundária — não há indicação de rotina apenas pela presença da doença coronariana, sem sintomas sugestivos.
• C) O ECG de 12 derivações é obrigatório na investigação inicial de toda síncope, independentemente da suspeita inicial, pois identifica sinais de risco (bloqueios, pré-excitação, QT alterado) que mudam completamente a conduta.
• E) Em cardiomiopatia hipertrófica, o estudo eletrofisiológico tem baixo valor preditivo positivo para estratificar risco de morte súbita; a indicação de CDI baseia-se em outros critérios clínicos, ecocardiográficos e de ressonância magnética.'),

('ada42830-4ca4-4a61-8fbf-3d8f00f558e7', 'Síncope e Anticoagulação', 2023, 'TEC', 'Sobre síncope, marque a afirmativa verdadeira:', 'A síndrome de hipersensibilidade do seio carotídeo é definida pela reprodução da síncope associada a pausa sinusal maior que 3s e/ou queda da PA sistólica maior ou igual a 50 mmHg durante a massagem do seio carotídeo.', 'A síndrome de hipersensibilidade do seio carotídeo é diagnosticada quando a estimulação (massagem) do seio carotídeo reproduz a síncope, acompanhada de assistolia (pausa sinusal) maior que 3 segundos e/ou queda da pressão arterial sistólica maior ou igual a 50 mmHg.

Por que as outras alternativas estão incorretas:
• A) A causa cardíaca mais comum de síncope não é a fibrilação ventricular; as arritmias bradiarrítmicas (doença do nó sinusal, bloqueios atrioventriculares) são causas cardíacas mais frequentes. A morte súbita abortada é uma apresentação grave, mas não a mais comum.
• B) A fludrocortisona não é a primeira linha de tratamento para síncope reflexa. O pilar do tratamento é educação do paciente, reconhecimento de pródromos e manobras de contrapressão física; farmacoterapia é reservada a casos refratários.
• C) A descrição refere-se à síndrome de taquicardia ortostática postural (POTS), mas com erro conceitual: o critério diagnóstico é o aumento da FC ≥30 bpm SEM hipotensão ortostática significativa associada — se há queda de pressão, é hipotensão ortostática clássica, não POTS.
• E) A investigação inicial de síncope é direcionada pela anamnese e exame físico; Tilt Test e Holter não são obrigatórios para todo paciente internado, apenas quando há suspeita clínica específica após a avaliação inicial (que inclui história e ECG de 12 derivações).'),

('74762f5a-1126-46e8-aba7-67d0f9654781', 'Síncope e Anticoagulação', 2016, 'TEC', 'Paciente feminina, 23 anos, vai à consulta para avaliação de síncopes de repetição. Refere que o quadro se inicia quando fica em pé por período prolongado em local quente, associado a mal-estar e náuseas, sem palpitações. Qual é a orientação MELHOR indicada para este caso?', 'O quadro é clássico de síncope vasovagal (reflexa/neuromediada): o tratamento inicial é não farmacológico — tranquilização, aumento da ingesta hidrossalina e manobras isométricas de contrapressão.', 'O quadro clínico descrito (paciente jovem, síncope em pé/ambiente quente, pródromos de mal-estar e náuseas, sem palpitações) é clássico de síncope vasovagal (também chamada de síncope reflexa ou neuromediada). O tratamento inicial para esses pacientes baseia-se em orientações não farmacológicas: educação do paciente sobre a benignidade do quadro, reconhecimento de pródromos, aumento da ingesta hídrica e de sal (aumentando o volume plasmático) e realização de manobras de contrapressão física (como cruzar as pernas ou contrair músculos dos membros/abdome) para evitar a síncope ao sentir os primeiros sintomas.

Por que as outras alternativas estão incorretas:
• A) O registrador de eventos (loop recorder) é indicado para síncopes de causa indeterminada em pacientes de alto risco ou com suspeita de arritmias graves, o que não é o caso desta paciente.
• C) A massagem do seio carotídeo é uma manobra diagnóstica para a síndrome de hipersensibilidade do seio carotídeo (geralmente em pacientes >40 anos), não uma manobra de tratamento para síncope vasovagal.
• D) Estudo eletrofisiológico e ablação são reservados para suspeita de taquiarritmias, o que não se encaixa neste perfil clínico sem palpitações e com gatilho vasovagal claro.
• E) O uso de betabloqueadores (como o metoprolol) para síncope vasovagal caiu em desuso, pois estudos (como o POST) mostraram que não são superiores ao placebo na prevenção de episódios na maioria dos pacientes.'),

('037f1e4f-8648-4e1a-ada2-6b37f1c69a83', 'Síncope e Anticoagulação', 2017, 'TEC', 'Os componentes mais importantes na avaliação de um paciente com perda transitória da consciência e síncope são:', 'A história clínica detalhada e o exame físico completo são os pilares fundamentais da investigação de síncope, definindo o diagnóstico na maioria dos casos (50-70%) e orientando a necessidade de exames adicionais.', 'Na investigação de um paciente com síncope (perda transitória da consciência), a história clínica detalhada e o exame físico completo são os pilares fundamentais. Eles são responsáveis por definir o diagnóstico na maioria dos casos (cerca de 50% a 70%), orientando a necessidade ou não de exames complementares adicionais. O objetivo inicial é distinguir as síncopes reflexas (benignas) de causas cardíacas potencialmente fatais.

Por que as outras alternativas não representam os componentes mais importantes:
• B, C, D e E) Embora o eletrocardiograma (ECG) seja, de fato, obrigatório e extremamente importante em todos os pacientes, a alternativa A é a mais completa ao elencar a anamnese (história) e o exame físico como os elementos primordiais que dão o norte diagnóstico. As outras opções focam em exames complementares específicos (ecocardiograma, teste de inclinação, teste ergométrico) que só devem ser solicitados se houver suspeita clínica levantada após a avaliação inicial.'),

('8b7806f9-1b48-472f-bca0-84d8d0e70972', 'Síncope e Anticoagulação', 2023, 'TEC', 'Homem, 25 anos, com quadro de síncope em repouso, sem pródromos e com traumatismo craniano leve. O eletrocardiograma realizado após o evento mostra padrão de Síndrome de Brugada tipo 1 (supradesnivelamento do segmento ST em V1-V2 seguido de onda T negativa). Qual a conduta adequada?', 'A combinação de padrão de Brugada tipo 1 no ECG com síncope (especialmente em repouso e sem pródromos) já configura alto risco de morte súbita — a conduta é o implante de cardiodesfibrilador implantável (CDI), como prevenção secundária.', 'O paciente apresenta um eletrocardiograma com padrão de Síndrome de Brugada (tipo 1), caracterizado pelo supradesnivelamento do segmento ST em derivações precordiais direitas (V1 e V2), seguido de uma onda T negativa. A combinação deste padrão eletrocardiográfico com um episódio de síncope (especialmente em repouso e sem pródromos) define um cenário de alto risco para morte súbita cardíaca.

A conduta recomendada pelas diretrizes internacionais (Heart Rhythm Society e Sociedade Brasileira de Cardiologia) é o implante de Cardiodesfibrilador Implantável (CDI). O CDI atua como prevenção secundária, sendo a única terapia comprovadamente eficaz para interromper arritmias ventriculares malignas (como a fibrilação ventricular) e prevenir o óbito nesta população.

Por que as outras alternativas estão incorretas:
• A) Estudo eletrofisiológico: embora usado historicamente para estratificação em pacientes assintomáticos, a presença de síncope já estratifica o paciente como de alto risco, tornando a indicação do CDI prioritária em relação ao EEF.
• B) Amiodarona: é ineficaz para prevenir a morte súbita em Brugada e pode ter efeitos proarrítmicos.
• D) Tilt Test: indicado para investigação de síncope vasovagal (reflexa); num paciente com canalopatia de alto risco já diagnosticada no ECG, seria um erro diagnóstico grave que atrasaria a proteção necessária.
• E) Monitor de eventos: o diagnóstico da arritmia de alto risco já foi estabelecido pelo ECG associado à síncope; o monitor serve para investigar causas indeterminadas, o que não é o caso aqui.'),

('53452219-d405-4696-b133-a758be773b73', 'Síncope e Anticoagulação', 2025, 'TEC', 'Sobre o papel do teste de inclinação (Tilt Test) no diagnóstico da síncope vasovagal, assinale a alternativa correta:', 'Quando o quadro clínico é típico de síncope vasovagal, o diagnóstico é essencialmente clínico (pela história) — o Tilt Test é dispensável nesses casos, sendo reservado para situações de dúvida diagnóstica ou apresentações atípicas.', 'O diagnóstico de síncope vasovagal (reflexa) é, na grande maioria dos casos, essencialmente clínico. Uma anamnese bem conduzida — que identifique fatores desencadeantes (ambiente fechado, ortostase prolongada, dor ou estresse emocional) e pródromos típicos (náuseas, sudorese, escurecimento visual) — é suficiente para estabelecer o diagnóstico. O Tilt Test é um exame complementar indicado apenas em situações específicas, como quando o diagnóstico permanece incerto após a avaliação inicial ou quando há necessidade de estratificar o risco em formas atípicas/recorrentes, não devendo ser solicitado rotineiramente ou em casos de apresentação clássica.

Por que as outras alternativas estão incorretas:
• A) O Tilt Test é um exame seguro e não é contraindicado para jovens; é, inclusive, frequentemente usado nessa população, já que a síncope vasovagal é mais prevalente em pacientes jovens.
• B) O teste não deve ser indicado rotineiramente para todo episódio de síncope — a avaliação inicial (história, exame físico e ECG) é que define a necessidade de exames adicionais.
• C) O teste não é obrigatório: se a história clínica for clássica e típica, o diagnóstico é clínico, dispensando confirmação por testes provocativos.
• E) O Tilt Test não é indicado para síncope de esforço (que levanta suspeita de causas estruturais/arritmias graves, exigindo outra investigação) e não serve para excluir cardiopatia obstrutiva.'),

('0f0fd8da-2883-407f-8384-f670c1110a43', 'Síncope e Anticoagulação', 2022, 'TEC', 'Paciente do sexo masculino, 70 anos, hipertenso, dislipidêmico, com tontura e um evento de perda de consciência sem liberação de esfíncter ou convulsão há uma semana. Ao exame: consciente, dispneico, sem alteração neurológica ou hemodinâmica. O eletrocardiograma de 12 derivações mostra bloqueio atrioventricular de alto grau/total, com dissociação P-QRS, frequência ventricular muito baixa e escape de QRS alargado (infra-hissiano). Qual a orientação mais adequada?', 'O ECG já mostra um bloqueio atrioventricular de alto grau/total associado à síncope — a conduta preconizada é o implante de marca-passo cardíaco definitivo, sem necessidade de mais exames antes disso.', 'O eletrocardiograma apresentado mostra um bloqueio atrioventricular de alto grau ou total, evidenciado pela dissociação entre as ondas P e os complexos QRS, com uma frequência ventricular muito baixa e escape infra-hissiano (QRS alargado). Em pacientes idosos com síncope e achados eletrocardiográficos de bloqueios avançados do sistema de condução, a conduta preconizada pelas diretrizes de cardiologia é o implante de marca-passo cardíaco definitivo.

Por que as outras alternativas estão incorretas:
• A) Teste de atropina: usado para avaliar resposta cronotrópica em suspeita de bradicardia reflexa ou disfunção do nó sinusal, mas sem papel terapêutico ou diagnóstico definitivo em bloqueios atrioventriculares estabelecidos e sintomáticos.
• B) Tilt Test: utilizado para investigar síncope vasovagal; num paciente com BAV de alto grau documentado, o diagnóstico de causa cardíaca já está firmado, tornando o teste desnecessário e potencialmente perigoso ao postergar o tratamento correto.
• C) Estudo eletrofisiológico: reservado para síncope de origem indeterminada ou estratificação de risco em arritmias complexas; aqui, a alteração no ECG de repouso já justifica a terapia.
• D) Holter: útil para arritmias paroxísticas; com um BAV já evidenciado no ECG de 12 derivações (padrão-ouro inicial), o diagnóstico já está feito, e aguardar 24h de monitorização atrasaria o tratamento de uma condição que pode levar a novo evento de síncope ou morte súbita.'),

('aeb0276a-9a4b-42de-b063-c40425d059b3', 'Síncope e Anticoagulação', 2022, 'TEC', 'Em relação à síncope, assinale a alternativa INCORRETA:', 'Morder a língua e incontinência são muito mais característicos de crises convulsivas (epilépticas) do que da síncope cardíaca, onde esses achados são raros — por isso essa é a alternativa incorreta.', 'Esta questão aborda as características que ajudam a diferenciar a síncope de crises epilépticas, um diagnóstico diferencial frequente e importante na prática clínica. Embora morder a língua e a incontinência urinária possam ocorrer em ambas as situações, eles são muito mais comuns e característicos de crises convulsivas (epilépticas) do que da síncope. Na síncope cardíaca, a mordedura de língua (especialmente na lateral) e a incontinência são eventos raros — por isso essa é a alternativa INCORRETA pedida na questão.

Por que as outras alternativas estão corretas (não são a resposta, já que a pergunta pede a incorreta):
• A) Quando causada por arritmia cardíaca, o início da síncope é de fato rápido e a duração breve — descrição verdadeira.
• C) Sintomas premonitórios podem ou não estar presentes, e a síncope tipicamente não é seguida de confusão pós-ictal — descrição verdadeira, e um dos pontos-chave para diferenciar de crise convulsiva.
• D) Palpitações prévias quase sempre estão ausentes quando a perda de consciência é rápida — descrição verdadeira.
• E) Convulsão é rara na síncope e ocorre principalmente após assistolia prolongada ou arritmia ventricular rápida (síncope convulsiva) — descrição verdadeira.'),

('f6abd553-ae3e-42be-9aa7-5da1634e3db1', 'Síncope e Anticoagulação', 2022, 'TEC', 'Assinale a alternativa correta referente à síndrome postural ortostática taquicardizante (SPOT):', 'A SPOT (POTS) é considerada uma variante da intolerância neurocardiogênica, caracterizada por incapacidade de ajustar adequadamente a frequência cardíaca e a resistência vascular à postura ereta.', 'A Síndrome de Taquicardia Ortostática Postural (POTS) é uma forma de disautonomia caracterizada pela incapacidade do corpo de ajustar a frequência cardíaca e a resistência vascular adequadamente ao mudar para a posição ereta. Ela é frequentemente considerada uma variante da intolerância neurocardiogênica.

Por que as outras alternativas estão incorretas:
• A) O paciente com POTS apresenta justamente o oposto: é intolerante à postura ereta. O critério diagnóstico envolve aumento excessivo da frequência cardíaca (≥30 bpm em adultos) ao assumir a posição ortostática, acompanhado de sintomas de intolerância (tontura, palpitações, pré-síncope).
• B) A POTS é frequentemente confundida com ansiedade, crise de pânico ou taquicardia sinusal inapropriada, tornando o diagnóstico diferencial desafiador.
• C) O Tilt Test é um exame fundamental para o diagnóstico de POTS, permitindo observar a resposta taquicardizante sustentada ao inclinar o paciente.
• E) Programas de recondicionamento físico (exercícios de resistência e força) são pilar fundamental do tratamento não farmacológico da POTS, melhorando o tônus vascular e a tolerância ortostática.'),

('1a56c94b-f97a-47af-b428-43bfe65c448e', 'Síncope e Anticoagulação', 2019, 'TEC', 'A respeito das interações entre medicamentos utilizados para o tratamento das doenças cardiovasculares, é INCORRETO afirmar:', 'A combinação de enalapril (iECA) com amilorida (diurético poupador de potássio) aumenta o risco de HIPERcalemia (não hipocalemia), especialmente em pacientes com função renal reduzida — por isso essa é a alternativa incorreta.', 'A alternativa E é a incorreta porque a combinação de um inibidor da ECA (como o enalapril) com um diurético poupador de potássio (como a amilorida) aumenta o risco de hipercalemia (aumento do potássio sérico), e não de hipocalemia. Esse risco é ainda mais significativo em pacientes com insuficiência renal, onde a excreção de potássio já está comprometida.

Por que as outras alternativas estão corretas (ou seja, descrevem interações verdadeiras, não sendo a resposta pedida):
• A) A amiodarona inibe o metabolismo da varfarina (via citocromo P450), aumentando a concentração plasmática da varfarina e, consequentemente, prolongando o tempo de protrombina (aumentando o RNI).
• B) O uso concomitante de clopidogrel e bloqueadores H2 (como a ranitidina) não é formalmente contraindicado em idosos, embora existam debates sobre possível redução de eficácia do clopidogrel (especialmente com IBP), mas não há proibição direta de uso conjunto.
• C) A associação de estatinas (como a sinvastatina) com inibidores da protease (como o atazanavir) aumenta drasticamente o risco de miopatia e rabdomiólise, pela inibição do metabolismo da estatina.
• D) A combinação de nitratos (doadores de óxido nítrico) com inibidores da fosfodiesterase-5 (como a tadalafila) é contraindicada pelo risco de hipotensão severa e refratária, pelo acúmulo sinérgico de GMP cíclico no músculo liso vascular.'),

('cd10fb63-5b24-4c5c-8ffa-ef4ac596bc15', 'Síncope e Anticoagulação', 2024, 'TEC', 'Sobre a prevenção de fenômenos tromboembólicos em pacientes com fibrilação atrial é correto afirmar:', 'A oclusão percutânea do apêndice atrial esquerdo é uma alternativa estabelecida para pacientes de alto risco tromboembólico que têm contraindicação absoluta ou risco proibitivo ao uso de anticoagulantes orais.', 'A oclusão percutânea do apêndice atrial esquerdo é uma opção terapêutica estabelecida para pacientes com fibrilação atrial que possuem indicação de anticoagulação, mas que apresentam contraindicação absoluta ou risco hemorrágico proibitivo ao uso de anticoagulantes orais, sendo uma alternativa eficaz para a prevenção de fenômenos tromboembólicos.

Por que as outras alternativas estão incorretas:
• B) O escore HAS-BLED serve para estratificar risco de sangramento e identificar fatores modificáveis. Uma pontuação >3 indica alto risco, exigindo cautela e vigilância, mas não contraindica formalmente a anticoagulação — o benefício da prevenção do AVC pode ainda superar o risco hemorrágico.
• C) Atualmente, os DOACs não são aprovados para pacientes com próteses valvares mecânicas; os antagonistas da vitamina K (varfarina) continuam sendo o tratamento padrão-ouro nesses casos.
• D) A ablação de fibrilação atrial não permite automaticamente a suspensão da anticoagulação — a decisão de manter ou suspender é baseada estritamente no escore de risco embólico (CHA2DS2-VASc), não apenas no sucesso da ablação.
• E) O uso de AAS, isolado ou combinado com clopidogrel, não é alternativa segura nem eficaz aos anticoagulantes orais para pacientes com indicação de anticoagulação em FA — o risco de AVC permanece muito elevado apenas com antiagregantes.'),

('e27440c2-6ad3-4141-9548-ec7d46219448', 'Síncope e Anticoagulação', 2014, 'TEC', 'Assinale o fármaco que potencializa o efeito anticoagulante da varfarina:', 'A amiodarona inibe o citocromo P450 (CYP2C9), responsável pelo metabolismo da varfarina — isso aumenta a concentração plasmática do anticoagulante, elevando o RNI e potencializando seu efeito.', 'A amiodarona é um dos fármacos que mais frequentemente potencializa o efeito anticoagulante da varfarina. Ela inibe enzimas do citocromo P450 (especialmente a CYP2C9), responsáveis pelo metabolismo da varfarina. Como resultado, ocorre um aumento da concentração plasmática do anticoagulante, elevando o RNI e, consequentemente, o risco de sangramento.

Por que as outras alternativas estão incorretas (neste contexto):
• A, B e C) Colestiramina, carbamazepina e rifampicina atuam como indutores enzimáticos ou interferem na absorção, promovendo a REDUÇÃO do efeito da varfarina (diminuindo o RNI) — o oposto de potencializar. A rifampicina e a carbamazepina aumentam o metabolismo da varfarina; a colestiramina pode reduzir sua absorção intestinal.
• E) Penicilinas em altas doses podem, em cenários específicos, afetar a coagulação por outros mecanismos, mas a amiodarona é a interação clássica e mais relevante quando se busca um fármaco que inibe o metabolismo da varfarina e potencializa seu efeito de forma consistente.'),

('320b9972-74d5-4756-9adf-6aadac4b66e2', 'Síncope e Anticoagulação', 2023, 'TEC', 'Em relação aos anticoagulantes, assinale a alternativa correta:', 'Em disfunção renal grave (TFG menor que 15 mL/kg/min), não dialíticos, deve-se preferir a varfarina em vez dos novos anticoagulantes orais, pela pouca evidência e experiência dos DOACs nesse cenário.', 'Em pacientes com insuficiência renal grave (taxa de filtração glomerular < 15 mL/min) ou em estágio terminal (em diálise), a evidência clínica para o uso de Anticoagulantes Orais Diretos (DOACs) é muito limitada e heterogênea. Por isso, a varfarina (antagonista da vitamina K) ainda é amplamente considerada a terapia de escolha ou a opção mais prudente na maioria das diretrizes para esse perfil específico de paciente, sendo a única que possui ampla experiência de uso e mecanismos de reversão bem estabelecidos em casos de hemorragia grave nesse cenário.

Por que as outras alternativas estão incorretas:
• A) A dabigatrana é CONTRAINDICADA em insuficiência renal grave (clearance <30 mL/min), pois aproximadamente 80% dela é excretada pelos rins, levando a risco altíssimo de sangramento por acúmulo da droga — o oposto do afirmado.
• B) Os anticoagulantes são fundamentais tanto para tratamento de fenômenos venosos (TVP/TEP) quanto para prevenção de fenômenos arteriais (AVC cardioembólico na FA).
• C) Seus mecanismos são distintos: a dabigatrana é inibidor direto da trombina (Fator IIa), enquanto a edoxabana é inibidor direto do Fator Xa.
• D) A regra de ajuste da apixabana (2,5 mg 2x/dia) exige pelo menos DOIS dos três critérios (idade ≥80 anos, peso ≤60 kg ou creatinina ≥1,5 mg/dL) — apenas um fator isolado não é suficiente para reduzir a dose.'),

('05259631-1a74-4cd0-9734-383f9d8612f4', 'Síncope e Anticoagulação', 2016, 'TEC', 'Sobre as interações medicamentosas com a varfarina, quais dos abaixo potencializam sua ação?', 'Amiodarona, cimetidina, fluconazol e metronidazol são potentes inibidores enzimáticos (CYP2C9), que reduzem o metabolismo da varfarina e potencializam seu efeito anticoagulante.', 'A amiodarona, a cimetidina, o fluconazol e o metronidazol são potentes inibidores enzimáticos (especialmente do citocromo P450, como CYP2C9), que reduzem o metabolismo da varfarina, levando ao seu acúmulo no organismo e potencializando seu efeito.

Por que as outras alternativas estão incorretas:
• A, C, D e E) Contêm drogas como barbiturato, carbamazepina e rifampicina — indutores potentes do sistema enzimático hepático, que aceleram a degradação da varfarina, diminuindo seu efeito anticoagulante e o valor do RNI (o oposto do que a questão pede).'),

('5c6a85bb-0656-496c-a1ac-7bd45e424ed1', 'Síncope e Anticoagulação', 2017, 'TEC', 'A heparina de baixo peso molecular é de uso corrente em Cardiologia. Seu mecanismo de atuação é:', 'A HBPM atua principalmente potencializando a antitrombina: ao se ligar a ela, acelera drasticamente sua capacidade de inibir o fator Xa, com efeito bem menos pronunciado sobre o fator IIa (trombina) do que a heparina não fracionada.', 'A heparina de baixo peso molecular (HBPM) atua principalmente através da potencialização da antitrombina (antiga antitrombina III). Ao se ligar à antitrombina, a HBPM causa uma mudança conformacional que aumenta drasticamente a velocidade com que a antitrombina inibe o Fator Xa. Diferente da heparina não fracionada, a HBPM tem uma ação inibitória menos pronunciada sobre o Fator IIa (trombina) devido ao seu tamanho molecular menor, que não permite a formação do complexo ternário necessário para essa inibição eficiente.

Nota sobre o gabarito: o material de origem indicava a alternativa "inibição dos fatores IIa e Xa" como resposta, mas essa opção descreve melhor a heparina NÃO fracionada (que inibe os dois fatores de forma equilibrada); a HBPM tem como mecanismo fundamental e mais preciso a ativação/potencialização da antitrombina, com predomínio de ação sobre o fator Xa — por isso foi usada como correta aqui.

Por que as outras alternativas estão incorretas:
• A) A heparina não ativa o fator VII; a via extrínseca (onde atua o fator VII) é monitorada pelo TP e não é o alvo primário da heparina.
• C) A tromboplastina (fator tecidual) não é o alvo de ação da heparina.
• D) Essa opção é parcialmente verdadeira para a heparina NÃO fracionada (que inibe bem tanto o IIa quanto o Xa); para a HBPM especificamente, a inibição é predominantemente sobre o Fator Xa, com atividade muito menor contra o IIa.
• E) A heparina não atua na conversão do fator XI em XIa.');

insert into public.question_options (id, question_id, letra, texto, correta) values
(gen_random_uuid(), 'ff170386-43bf-4388-afaa-9b7073663f5a', 'a', 'Inibidores da trombina ou antifator Xa oral.', false),
(gen_random_uuid(), 'ff170386-43bf-4388-afaa-9b7073663f5a', 'b', 'Varfarina para INR entre 2 e 3 + clopidogrel, 75 mg/d.', false),
(gen_random_uuid(), 'ff170386-43bf-4388-afaa-9b7073663f5a', 'c', 'Varfarina para INR entre 2,5 e 3,5.', true),
(gen_random_uuid(), 'ff170386-43bf-4388-afaa-9b7073663f5a', 'd', 'Ácido acetilsalicílico, 100 mg/d + clopidogrel, 75 mg/d.', false),
(gen_random_uuid(), 'ff170386-43bf-4388-afaa-9b7073663f5a', 'e', 'Varfarina para INR em torno de 2 + ácido acetilsalicílico, 100 mg/d.', false),

(gen_random_uuid(), '90bc2bcb-bbbb-4a3d-a111-a62173ba4df3', 'a', 'Síncope recorrente, > 40 anos de idade e pausa sintomática > 3s induzida no teste de inclinação, e o marcapasso deve ser unicameral em ambas as situações.', false),
(gen_random_uuid(), '90bc2bcb-bbbb-4a3d-a111-a62173ba4df3', 'b', 'Queda única, inexplicada, sem pródromos, > 40 anos de idade e manobra de massagem do seio carotídeo com resposta cardioinibidora (pausa > 3s).', false),
(gen_random_uuid(), '90bc2bcb-bbbb-4a3d-a111-a62173ba4df3', 'c', 'Síncope recorrente, > 40 anos de idade e documentação de pausa sintomática espontânea > 3s ou pausa > 6s assintomática.', true),
(gen_random_uuid(), '90bc2bcb-bbbb-4a3d-a111-a62173ba4df3', 'd', 'Paciente com síncope e ausência de resposta cardioinibidora documentada.', false),
(gen_random_uuid(), '90bc2bcb-bbbb-4a3d-a111-a62173ba4df3', 'e', 'Paciente assintomático(a) e massagem do seio carotídeo com resposta cardioinibidora.', false),

(gen_random_uuid(), 'e56a116c-43eb-4ef0-8a6c-83013af3b94c', 'a', 'O uso dos novos anticoagulantes orais está autorizado em caso de estenose mitral reumática importante.', false),
(gen_random_uuid(), 'e56a116c-43eb-4ef0-8a6c-83013af3b94c', 'b', 'O uso dos novos anticoagulantes na estenose aórtica e na presença de fibrilação atrial é contraindicado.', false),
(gen_random_uuid(), 'e56a116c-43eb-4ef0-8a6c-83013af3b94c', 'c', 'O uso dos novos anticoagulantes orais por portadores de próteses mecânicas pode ser considerado em caso de dificuldade de controle da INR com o uso da varfarina.', false),
(gen_random_uuid(), 'e56a116c-43eb-4ef0-8a6c-83013af3b94c', 'd', 'A faixa de INR de paciente portador de prótese mecânica em posição mitral é entre 2,0-3,0.', false),
(gen_random_uuid(), 'e56a116c-43eb-4ef0-8a6c-83013af3b94c', 'e', 'Não se deve usar o escore CHA2DS2-VASc em portadores de doença valvar importante, pois há subestimação do risco em pacientes com escore ≤ 1.', true),

(gen_random_uuid(), '66c65188-cd32-4682-b604-3982b3716696', 'a', 'As assertivas I e II.', false),
(gen_random_uuid(), '66c65188-cd32-4682-b604-3982b3716696', 'b', 'Apenas a assertiva I.', true),
(gen_random_uuid(), '66c65188-cd32-4682-b604-3982b3716696', 'c', 'As assertivas II e III.', false),
(gen_random_uuid(), '66c65188-cd32-4682-b604-3982b3716696', 'd', 'Apenas a assertiva III.', false),
(gen_random_uuid(), '66c65188-cd32-4682-b604-3982b3716696', 'e', 'Todas estão corretas.', false),

(gen_random_uuid(), '9291881c-b44c-46e9-b600-009a44c98e18', 'a', 'Ácido acetilsalicílico, 300 mg/dia, pelo risco intermediário de tromboembolismo.', false),
(gen_random_uuid(), '9291881c-b44c-46e9-b600-009a44c98e18', 'b', 'Varfarina ajustada conforme RNI.', true),
(gen_random_uuid(), '9291881c-b44c-46e9-b600-009a44c98e18', 'c', 'Sem necessidade de antitrombótico, por ter CHA2DS2-VASc de zero.', false),
(gen_random_uuid(), '9291881c-b44c-46e9-b600-009a44c98e18', 'd', 'Dabigatrana, 150 mg, 2x/dia.', false),
(gen_random_uuid(), '9291881c-b44c-46e9-b600-009a44c98e18', 'e', 'Apixabana, 5 mg, 12/12 horas.', false),

(gen_random_uuid(), '76f0e530-32ed-47e2-a1ef-cbb0ec20562f', 'a', 'A varfarina deve ser utilizada em doses maiores em pacientes com idade superior a 65 anos devido ao maior risco de tromboembolismo nessa faixa etária.', false),
(gen_random_uuid(), '76f0e530-32ed-47e2-a1ef-cbb0ec20562f', 'b', 'Os novos anticoagulantes orais rivaroxabana e dabigatrana agem reduzindo a síntese de fatores de coagulação não dependentes de vitamina K.', false),
(gen_random_uuid(), '76f0e530-32ed-47e2-a1ef-cbb0ec20562f', 'c', 'Os novos anticoagulantes orais são contraindicados em pacientes portadores de prótese valvar metálica.', true),
(gen_random_uuid(), '76f0e530-32ed-47e2-a1ef-cbb0ec20562f', 'd', 'A apixabana teve taxa de sangramento igual à da varfarina nos estudos randomizados, sendo sua principal vantagem a conveniência de não necessitar de ajuste de dose com base em exames laboratoriais.', false),
(gen_random_uuid(), '76f0e530-32ed-47e2-a1ef-cbb0ec20562f', 'e', 'A dabigatrana age bloqueando o fator Xa e pode ser utilizada em pacientes portadores de FA valvar e não valvar.', false),

(gen_random_uuid(), 'd0df1095-98e9-4217-9d84-0f2bfb2a9259', 'a', 'Não deve ser iniciada, pois o risco de complicações hemorrágicas, nestes casos, é maior do que o risco de AVE.', false),
(gen_random_uuid(), 'd0df1095-98e9-4217-9d84-0f2bfb2a9259', 'b', 'Deve ser iniciada apenas 24 horas após a retirada do último dreno, como ocorre com qualquer paciente submetido a cirurgias cardíacas.', false),
(gen_random_uuid(), 'd0df1095-98e9-4217-9d84-0f2bfb2a9259', 'c', 'Somente deverá ser iniciada após um período de sete dias com AAS de 100 mg/dia, caso não haja complicações hemorrágicas.', false),
(gen_random_uuid(), 'd0df1095-98e9-4217-9d84-0f2bfb2a9259', 'd', 'Somente está indicada em pacientes com história prévia de AVE.', false),
(gen_random_uuid(), 'd0df1095-98e9-4217-9d84-0f2bfb2a9259', 'e', 'Está indicada, devido ao alto risco de AVE.', true),

(gen_random_uuid(), '94507a2d-79c1-41ae-ac6a-f08f1ff80935', 'a', 'Uso concomitante de antiagregante plaquetário.', false),
(gen_random_uuid(), '94507a2d-79c1-41ae-ac6a-f08f1ff80935', 'b', 'Idade acima de 75 anos.', false),
(gen_random_uuid(), '94507a2d-79c1-41ae-ac6a-f08f1ff80935', 'c', 'Próteses valvares biológicas.', false),
(gen_random_uuid(), '94507a2d-79c1-41ae-ac6a-f08f1ff80935', 'd', 'Clearance de creatinina abaixo de 50 mL/min e obesidade.', true),
(gen_random_uuid(), '94507a2d-79c1-41ae-ac6a-f08f1ff80935', 'e', 'Trombos intracavitários.', false),

(gen_random_uuid(), 'd517afac-6bde-4293-9220-7d0c77292c90', 'a', 'Anticoagulante oral direto + prasugrel.', false),
(gen_random_uuid(), 'd517afac-6bde-4293-9220-7d0c77292c90', 'b', 'Ácido acetilsalicílico (AAS) + ticagrelor.', false),
(gen_random_uuid(), 'd517afac-6bde-4293-9220-7d0c77292c90', 'c', 'Anticoagulante oral direto + clopidogrel.', true),
(gen_random_uuid(), 'd517afac-6bde-4293-9220-7d0c77292c90', 'd', 'Varfarina + AAS + clopidogrel.', false),
(gen_random_uuid(), 'd517afac-6bde-4293-9220-7d0c77292c90', 'e', 'Anticoagulante oral direto + AAS + clopidogrel.', false),

(gen_random_uuid(), '4d6f3d44-81a5-4a13-9222-5265ac7fa646', 'a', 'fenitoína', true),
(gen_random_uuid(), '4d6f3d44-81a5-4a13-9222-5265ac7fa646', 'b', 'cimetidina', false),
(gen_random_uuid(), '4d6f3d44-81a5-4a13-9222-5265ac7fa646', 'c', 'rifampicina', false),
(gen_random_uuid(), '4d6f3d44-81a5-4a13-9222-5265ac7fa646', 'd', 'eritromicina', false),
(gen_random_uuid(), '4d6f3d44-81a5-4a13-9222-5265ac7fa646', 'e', 'amiodarona', false),

(gen_random_uuid(), 'fc30afc1-09eb-43d7-b60f-2eaf16360d8e', 'a', 'Em fibrilação atrial, o escore CHA2DS2VASC deve ser utilizado. Em pacientes com eventos tromboembólicos sistêmicos ou próteses valvares mecânicas, a anticoagulação deve ser mantida independentemente de qualquer avaliação. O risco de sangramento deve ser acessado pelo escore HAS-BLED.', true),
(gen_random_uuid(), 'fc30afc1-09eb-43d7-b60f-2eaf16360d8e', 'b', 'Escore HAS-BLED maior ou igual a 3 pontos é de alto risco para sangramento e deve contraindicar anticoagulação.', false),
(gen_random_uuid(), 'fc30afc1-09eb-43d7-b60f-2eaf16360d8e', 'c', 'Em pacientes que realizaram cardioversão elétrica por fibrilação atrial e possuem risco hemorrágico elevado, a profilaxia pós-cardioversão pode ser reduzida para apenas duas semanas.', false),
(gen_random_uuid(), 'fc30afc1-09eb-43d7-b60f-2eaf16360d8e', 'd', 'Flutter atrial. Pelo menor risco embólico, pode ser tratado com INR em faixa terapêutica de 1,5 a 2,0.', false),
(gen_random_uuid(), 'fc30afc1-09eb-43d7-b60f-2eaf16360d8e', 'e', 'Idade maior que 75 anos conta 2 pontos no escore HAS-BLED para risco de sangramento.', false),

(gen_random_uuid(), '16412fa1-290b-48d2-bb2f-017f38889f61', 'a', 'Teste de inclinação (Tilt Test) deve ser utilizado para avaliação de resposta terapêutica de pacientes com síncope neuromediada.', false),
(gen_random_uuid(), '16412fa1-290b-48d2-bb2f-017f38889f61', 'b', 'Cineangiocoronariografia deve ser realizada em pacientes com doença arterial coronariana e síncope, mesmo na ausência de sintomas anginosos.', false),
(gen_random_uuid(), '16412fa1-290b-48d2-bb2f-017f38889f61', 'c', 'O eletrocardiograma de rotina não é necessário em suspeitas de síncope neuromediada.', false),
(gen_random_uuid(), '16412fa1-290b-48d2-bb2f-017f38889f61', 'd', 'Teste de inclinação (Tilt Test) auxilia no diagnóstico diferencial de síncope e perda transitória da consciência por causa psicogênica (pseudossíncope).', true),
(gen_random_uuid(), '16412fa1-290b-48d2-bb2f-017f38889f61', 'e', 'Em pacientes com cardiomiopatia hipertrófica e síncope, o estudo eletrofisiológico deve ser realizado para avaliação de indicação de cardiodesfibrilador implantável.', false),

(gen_random_uuid(), 'ada42830-4ca4-4a61-8fbf-3d8f00f558e7', 'a', 'Um episódio transitório de fibrilação ventricular (morte súbita abortada) é a causa cardíaca mais comum de síncope.', false),
(gen_random_uuid(), 'ada42830-4ca4-4a61-8fbf-3d8f00f558e7', 'b', 'Fludrocortisona é a primeira opção terapêutica nas síncopes reflexas e naquelas por hipotensão postural.', false),
(gen_random_uuid(), 'ada42830-4ca4-4a61-8fbf-3d8f00f558e7', 'c', 'A síndrome de taquicardia postural ortostática paroxística é diagnosticada quando na posição ortostática há aumento na frequência cardíaca ≥ 30 bpm associado com uma redução na pressão arterial sistólica ≥ 20 mmHg.', false),
(gen_random_uuid(), 'ada42830-4ca4-4a61-8fbf-3d8f00f558e7', 'd', 'A síndrome de hipersensibilidade do seio carotídeo é definida pela reprodução da síncope associada com uma pausa sinusal maior que 3 seg e/ou uma queda na pressão arterial sistólica ≥ 50 mmHg com a massagem do seio carotídeo.', true),
(gen_random_uuid(), 'ada42830-4ca4-4a61-8fbf-3d8f00f558e7', 'e', 'Em todo paciente internado com síncope é obrigatória a investigação com eletrocardiograma, ecocardiograma, teste de inclinação (Tilt Test) e Holter de 24 horas.', false),

(gen_random_uuid(), '74762f5a-1126-46e8-aba7-67d0f9654781', 'a', 'Implantar registrador de eventos implantável (loop recorder).', false),
(gen_random_uuid(), '74762f5a-1126-46e8-aba7-67d0f9654781', 'b', 'Tranquilização, aumento de ingesta hidrossalina, manobras isométricas.', true),
(gen_random_uuid(), '74762f5a-1126-46e8-aba7-67d0f9654781', 'c', 'Massagem de seio carotídeo ao iniciar o mal-estar.', false),
(gen_random_uuid(), '74762f5a-1126-46e8-aba7-67d0f9654781', 'd', 'Realizar estudo eletrofisiológico e possível ablação por radiofrequência.', false),
(gen_random_uuid(), '74762f5a-1126-46e8-aba7-67d0f9654781', 'e', 'Uso empírico de metoprolol em dose baixa (12,5 mg/dia).', false),

(gen_random_uuid(), '037f1e4f-8648-4e1a-ada2-6b37f1c69a83', 'a', 'história e exame físico.', true),
(gen_random_uuid(), '037f1e4f-8648-4e1a-ada2-6b37f1c69a83', 'b', 'eletrocardiograma e exame físico.', false),
(gen_random_uuid(), '037f1e4f-8648-4e1a-ada2-6b37f1c69a83', 'c', 'exame físico e teste de inclinação.', false),
(gen_random_uuid(), '037f1e4f-8648-4e1a-ada2-6b37f1c69a83', 'd', 'ecocardiograma e ausculta cardíaca.', false),
(gen_random_uuid(), '037f1e4f-8648-4e1a-ada2-6b37f1c69a83', 'e', 'eletrocardiograma e teste ergométrico.', false),

(gen_random_uuid(), '8b7806f9-1b48-472f-bca0-84d8d0e70972', 'a', 'Paciente deve ser submetido ao estudo eletrofisiológico.', false),
(gen_random_uuid(), '8b7806f9-1b48-472f-bca0-84d8d0e70972', 'b', 'Paciente deve ser tratado com amiodarona.', false),
(gen_random_uuid(), '8b7806f9-1b48-472f-bca0-84d8d0e70972', 'c', 'Paciente deve ser submetido a implante de cardiodesfibrilador.', true),
(gen_random_uuid(), '8b7806f9-1b48-472f-bca0-84d8d0e70972', 'd', 'Paciente deve ser submetido à realização de teste de inclinação (Tilt Test).', false),
(gen_random_uuid(), '8b7806f9-1b48-472f-bca0-84d8d0e70972', 'e', 'Paciente deve receber monitor de eventos implantável.', false),

(gen_random_uuid(), '53452219-d405-4696-b133-a758be773b73', 'a', 'O teste é contraindicado para pacientes jovens devido ao risco elevado de arritmias graves durante o exame.', false),
(gen_random_uuid(), '53452219-d405-4696-b133-a758be773b73', 'b', 'Deve ser indicado rotineiramente para qualquer episódio de síncope, independentemente de contexto clínico ou presença de doença cardíaca estrutural.', false),
(gen_random_uuid(), '53452219-d405-4696-b133-a758be773b73', 'c', 'O teste de inclinação é obrigatório para confirmação diagnóstica de síncope vasovagal em todos os casos, mesmo quando a história é típica.', false),
(gen_random_uuid(), '53452219-d405-4696-b133-a758be773b73', 'd', 'É dispensável quando o quadro clínico é típico de síncope vasovagal, sendo nesses casos o diagnóstico essencialmente clínico.', true),
(gen_random_uuid(), '53452219-d405-4696-b133-a758be773b73', 'e', 'O teste é indicado exclusivamente em pacientes com síncope de esforço para excluir cardiopatia obstrutiva.', false),

(gen_random_uuid(), '0f0fd8da-2883-407f-8384-f670c1110a43', 'a', 'Teste de atropina.', false),
(gen_random_uuid(), '0f0fd8da-2883-407f-8384-f670c1110a43', 'b', 'Realização do Tilt-Test (teste de inclinação).', false),
(gen_random_uuid(), '0f0fd8da-2883-407f-8384-f670c1110a43', 'c', 'Realização de estudo eletrofisiológico.', false),
(gen_random_uuid(), '0f0fd8da-2883-407f-8384-f670c1110a43', 'd', 'Solicitação de Holter.', false),
(gen_random_uuid(), '0f0fd8da-2883-407f-8384-f670c1110a43', 'e', 'Implante de marca-passo definitivo.', true),

(gen_random_uuid(), 'aeb0276a-9a4b-42de-b063-c40425d059b3', 'a', 'Quando causada por arritmia cardíaca, o início da síncope é rápido e a duração é breve.', false),
(gen_random_uuid(), 'aeb0276a-9a4b-42de-b063-c40425d059b3', 'b', 'Morder a língua e incontinência são comuns na síncope cardíaca.', true),
(gen_random_uuid(), 'aeb0276a-9a4b-42de-b063-c40425d059b3', 'c', 'Sintomas premonitórios podem ou não estar presentes, e tipicamente a síncope não é seguida por estado de confusão pós-ictal.', false),
(gen_random_uuid(), 'aeb0276a-9a4b-42de-b063-c40425d059b3', 'd', 'Palpitações que a precedem quase sempre estão ausentes se a perda de consciência for rápida.', false),
(gen_random_uuid(), 'aeb0276a-9a4b-42de-b063-c40425d059b3', 'e', 'Convulsão é rara e ocorre principalmente após assistolia prolongada ou arritmia ventricular rápida.', false),

(gen_random_uuid(), 'f6abd553-ae3e-42be-9aa7-5da1634e3db1', 'a', 'Caracteriza-se por excelente capacidade de tolerar a postura ereta associada a aumento discreto na frequência cardíaca 10 minutos após assumir postura ereta.', false),
(gen_random_uuid(), 'f6abd553-ae3e-42be-9aa7-5da1634e3db1', 'b', 'SPOT é facilmente reconhecível e não há como confundi-la com ansiedade ou taquicardia sinusal inapropriada.', false),
(gen_random_uuid(), 'f6abd553-ae3e-42be-9aa7-5da1634e3db1', 'c', 'O Tilt-Test não é útil no diagnóstico de SPOT.', false),
(gen_random_uuid(), 'f6abd553-ae3e-42be-9aa7-5da1634e3db1', 'd', 'A SPOT é uma variante de intolerância neurocardiogênica.', true),
(gen_random_uuid(), 'f6abd553-ae3e-42be-9aa7-5da1634e3db1', 'e', 'Programas de treinamento de resistência e força não são úteis no tratamento de SPOT.', false),

(gen_random_uuid(), '1a56c94b-f97a-47af-b428-43bfe65c448e', 'a', 'A amiodarona prolonga o tempo de protrombina em pacientes tratados com varfarina.', false),
(gen_random_uuid(), '1a56c94b-f97a-47af-b428-43bfe65c448e', 'b', 'O uso concomitante de clopidogrel com ranitidina não é contraindicado para idosos.', false),
(gen_random_uuid(), '1a56c94b-f97a-47af-b428-43bfe65c448e', 'c', 'A combinação de sinvastatina e atazanavir pode aumentar a incidência de miopatia e rabdomiólise.', false),
(gen_random_uuid(), '1a56c94b-f97a-47af-b428-43bfe65c448e', 'd', 'O uso concomitante de nitratos e tadalafila é contraindicado em decorrência de seus efeitos sinérgicos sobre o aumento da concentração do segundo mensageiro monofosfato de guanosina cíclico.', false),
(gen_random_uuid(), '1a56c94b-f97a-47af-b428-43bfe65c448e', 'e', 'A coadministração de enalapril e amilorida pode resultar em hipocalemia em pacientes com deficit de função renal.', true),

(gen_random_uuid(), 'cd10fb63-5b24-4c5c-8ffa-ef4ac596bc15', 'a', 'Pacientes com alto risco para fenômenos tromboembólicos e contraindicação ao uso de anticoagulação oral podem se beneficiar da oclusão percutânea do apêndice atrial esquerdo.', true),
(gen_random_uuid(), 'cd10fb63-5b24-4c5c-8ffa-ef4ac596bc15', 'b', 'Para pacientes com escore de risco para hemorragia HAS BLED > 3 está contraindicada a anticoagulação oral com varfarina.', false),
(gen_random_uuid(), 'cd10fb63-5b24-4c5c-8ffa-ef4ac596bc15', 'c', 'Estudos demonstraram que é seguro o uso de anticoagulantes orais diretos em pacientes com próteses valvares mecânicas.', false),
(gen_random_uuid(), 'cd10fb63-5b24-4c5c-8ffa-ef4ac596bc15', 'd', 'A realização de ablação de fibrilação atrial permite a suspensão do anticoagulante oral em pacientes com CHA2DS2-VASc ≥ 2, respeitado o uso durante o período de blanking pós-ablação.', false),
(gen_random_uuid(), 'cd10fb63-5b24-4c5c-8ffa-ef4ac596bc15', 'e', 'Em pacientes que têm indicação de anticoagulação e apresentam sangramento com uso de anticoagulantes orais, uma opção segura e igualmente eficaz é o uso de ácido acetilsalicílico.', false),

(gen_random_uuid(), 'e27440c2-6ad3-4141-9548-ec7d46219448', 'a', 'Colestiramina.', false),
(gen_random_uuid(), 'e27440c2-6ad3-4141-9548-ec7d46219448', 'b', 'Carbamazepina.', false),
(gen_random_uuid(), 'e27440c2-6ad3-4141-9548-ec7d46219448', 'c', 'Rifampicina.', false),
(gen_random_uuid(), 'e27440c2-6ad3-4141-9548-ec7d46219448', 'd', 'Amiodarona.', true),
(gen_random_uuid(), 'e27440c2-6ad3-4141-9548-ec7d46219448', 'e', 'Penicilinas em altas doses.', false),

(gen_random_uuid(), '320b9972-74d5-4756-9adf-6aadac4b66e2', 'a', 'A dabigatrana deve ser o anticoagulante de preferência em pacientes com insuficiência renal com taxa de filtração glomerular < 30 mL/kg/min, devido a sua baixa excreção renal.', false),
(gen_random_uuid(), '320b9972-74d5-4756-9adf-6aadac4b66e2', 'b', 'Anticoagulantes só devem ser utilizados no tratamento de fenômenos tromboembólicos venosos.', false),
(gen_random_uuid(), '320b9972-74d5-4756-9adf-6aadac4b66e2', 'c', 'Dabigatrana e edoxabana têm mecanismos de ação semelhantes.', false),
(gen_random_uuid(), '320b9972-74d5-4756-9adf-6aadac4b66e2', 'd', 'A dose de apixabana deve ser ajustada na presença de um dos seguintes fatores: peso menor que 60 kg ou idade acima de 80 anos.', false),
(gen_random_uuid(), '320b9972-74d5-4756-9adf-6aadac4b66e2', 'e', 'Em paciente com disfunção renal grave (TFG < 15 mL/kg/min), não dialíticos, deve-se dar preferência a varfarina, em relação aos novos anticoagulantes orais.', true),

(gen_random_uuid(), '05259631-1a74-4cd0-9734-383f9d8612f4', 'a', 'Cimetidina, digoxina, barbiturato e carbamazepina.', false),
(gen_random_uuid(), '05259631-1a74-4cd0-9734-383f9d8612f4', 'b', 'Amiodarona, cimetidina, fluconazol e metronidazol.', true),
(gen_random_uuid(), '05259631-1a74-4cd0-9734-383f9d8612f4', 'c', 'Ciprofloxacino, amiodarona, carbamazepina e indometacina.', false),
(gen_random_uuid(), '05259631-1a74-4cd0-9734-383f9d8612f4', 'd', 'Rifampicina, amiodarona, cimetidina e sulfametoxazol.', false),
(gen_random_uuid(), '05259631-1a74-4cd0-9734-383f9d8612f4', 'e', 'Quinidina, amiodarona, digoxina e rifampicina.', false),

(gen_random_uuid(), '5c6a85bb-0656-496c-a1ac-7bd45e424ed1', 'a', 'ativação do fator VII.', false),
(gen_random_uuid(), '5c6a85bb-0656-496c-a1ac-7bd45e424ed1', 'b', 'ativação da antitrombina.', true),
(gen_random_uuid(), '5c6a85bb-0656-496c-a1ac-7bd45e424ed1', 'c', 'inibição da tromboplastina.', false),
(gen_random_uuid(), '5c6a85bb-0656-496c-a1ac-7bd45e424ed1', 'd', 'inibição dos fatores IIa e Xa.', false),
(gen_random_uuid(), '5c6a85bb-0656-496c-a1ac-7bd45e424ed1', 'e', 'ativação da conversão do fator XI em XIa.', false);
