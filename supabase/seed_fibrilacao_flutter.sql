-- Novo tema: "Fibrilação e Flutter" (cardiologia), banca TEC/SBC.
-- Fonte: documento enviado pelo usuário (Google Docs), que já trazia boa
-- parte das explicações prontas — reorganizadas aqui no padrão resumido
-- (comentario) + completo (comentario_completo) do app.
--
-- Algumas questões deste tema descrevem o mesmo caso clínico já usado em
-- "Síncope e Anticoagulação" (o documento fonte se repete entre os temas);
-- foram incluídas aqui também porque fazem parte do arquivo original deste
-- tema especificamente.
--
-- IMPORTANTE — questões 10, 25, 27 e 41 fazem referência a um ECG que não
-- está incluído aqui (sem imagem por enquanto); os comentários já
-- descrevem em texto os achados relevantes, então a questão continua
-- respondível e didática mesmo sem a imagem. As imagens serão adicionadas
-- depois, numa etapa própria.
--
-- Uma questão do documento original (a que descreve a paciente de 55 anos
-- com prótese mecânica mitral) aparecia duplicada de forma idêntica na
-- fonte — foi incluída apenas uma vez aqui.
--
-- Rode este arquivo uma vez no SQL Editor do seu projeto Supabase.

insert into public.questions (id, tema, ano, instituicao, enunciado, comentario, comentario_completo) values

('147e5e2f-66a7-4b2e-a888-922294dc5a9d', 'Fibrilação e Flutter', 2022, 'TEC', 'Em relação ao cuidado ao paciente pós-ablação de fibrilação atrial (FA), assinale a alternativa INCORRETA:', 'A fístula atrioesofágica é uma complicação rara (embora gravíssima) da ablação de FA, não a mais comum. As complicações mais frequentes são no sítio de punção vascular (hematomas, pseudoaneurismas) e o derrame pericárdico.', 'A fístula atrioesofágica é uma complicação rara (embora extremamente grave e frequentemente fatal) da ablação de fibrilação atrial, e não a complicação "mais comum" como a alternativa afirma. Complicações mais frequentes incluem as relacionadas ao sítio de punção vascular (hematomas, pseudoaneurismas) e o derrame pericárdico — por isso essa é a alternativa INCORRETA pedida.

Por que as outras alternativas estão corretas (não são a resposta, já que a pergunta pede a incorreta):
• A) Ablação de FA é de fato menos eficaz em FA persistente/longa duração, cardiomiopatia hipertrófica, obesidade e apneia do sono.
• B) Focos extra veias pulmonares realmente ocorrem mais em formas persistentes de FA ou com remodelamento atrial.
• D) Manter anticoagulação pós-ablação em pacientes de maior risco (CHA2DS2-VASc ≥2) é, de fato, prudente.
• E) Reconexão de veias pulmonares e focos externos são, de fato, os principais fatores de recorrência pós-ablação.'),

('28239ad9-9b89-4a11-9064-b5ce45972c84', 'Fibrilação e Flutter', 2016, 'TEC', 'Paciente feminina, 28 anos, diabética, com fibrilação atrial paroxística sintomática refratária a sotalol e amiodarona usados isoladamente, coração estruturalmente normal, vem discutir a possibilidade de ablação por radiofrequência. Qual das seguintes afirmativas está CORRETA nesse contexto?', 'O sucesso da ablação por radiofrequência para FA paroxística em coração estruturalmente normal é de aproximadamente 70% sem antiarrítmicos e mais de 80% associando fármacos depois.', 'As taxas de sucesso da ablação por radiofrequência para FA paroxística em pacientes com coração estruturalmente normal situam-se, historicamente, na faixa de ~70% sem fármacos e mais de 80% com o uso posterior de antiarrítmicos associados.

Por que as outras alternativas estão incorretas:
• A) A anticoagulação é mandatória em pacientes submetidos à ablação de FA, pelo risco tromboembólico do procedimento (manipulação de cateteres no átrio esquerdo), independentemente do coração ser estruturalmente normal.
• B) A falha de dois ou mais fármacos antiarrítmicos (ou mesmo de apenas um, pelas diretrizes mais atuais) já justifica a indicação de ablação.
• D) A complicação mais comum NÃO é a fístula atrioesofágica (rara, porém grave) — são mais comuns as complicações do sítio de punção venosa e o derrame pericárdico.
• E) O pilar do procedimento é o isolamento elétrico das veias pulmonares; isolar o apêndice atrial e fazer linhas adicionais é reservado para FA persistente de longa duração ou refratária, não sendo padrão para FA paroxística com coração normal.'),

('80dff5e9-2ef5-47cc-9eb1-2bb9765db184', 'Fibrilação e Flutter', 2018, 'TEC', 'Em relação ao manejo de pacientes portadores de fibrilação atrial (FA), é correto afirmar que:', 'A ablação por cateter está indicada para pacientes sintomáticos e refratários a pelo menos uma droga antiarrítmica, quando a estratégia de controle do ritmo é desejada.', 'As diretrizes recomendam a ablação por cateter como estratégia eficaz para o controle do ritmo em pacientes sintomáticos com FA que falharam ou são intolerantes a pelo menos um fármaco antiarrítmico.

Por que as outras alternativas estão incorretas:
• A) Embora a anticoagulação seja necessária antes da cardioversão, a diretriz estabelece critérios específicos de tempo e forma para essa anticoagulação; a formulação da alternativa é imprecisa.
• B) A ablação da junção AV é estratégia de "controle de frequência" quando o controle medicamentoso falha, não restrita a casos de taquicardiomiopatia.
• C) A oclusão do apêndice atrial é opção para pacientes de alto risco embólico E contraindicação (ou risco inaceitável) à anticoagulação oral, não restrita a quem já teve evento tromboembólico prévio.
• E) Propafenona e bloqueadores do canal de cálcio são CONTRAINDICADOS na FA com pré-excitação (WPW), pois podem facilitar a condução pela via acessória e precipitar fibrilação ventricular.'),

('0e92749c-62c5-484f-9f10-332dc2fdcf7b', 'Fibrilação e Flutter', 2018, 'TEC', 'Paciente do sexo masculino, 70 anos, hipertenso e diabético, com palpitações rápidas e irregulares de início súbito, primeira vez. FC = 140 bpm, PA = 130 x 90 mmHg. Existe uma afirmativa ERRADA sobre a conduta, identifique-a:', 'A propafenona é contraindicada em pacientes com insuficiência cardíaca descompensada (efeito inotrópico negativo); nesses casos, prefere-se digoxina ou amiodarona — por isso é errado indicar propafenona para reversão nesse cenário.', 'A propafenona é um antiarrítmico da classe IC, que possui efeito inotrópico negativo significativo. Por isso, ela é contraindicada em pacientes com insuficiência cardíaca (IC) descompensada ou disfunção ventricular importante, pois pode agravar o quadro clínico do paciente — sendo essa, portanto, a alternativa ERRADA. Em pacientes com IC descompensada e FA, outras opções (como amiodarona ou digoxina) são preferidas para o controle da frequência.

Por que as outras alternativas estão corretas (não são a resposta, já que a pergunta pede a errada):
• A) Digoxina ou amiodarona IV são, de fato, preferíveis para controle de frequência na IC descompensada.
• B) O hipertireoidismo pode, de fato, causar FA, sendo mais frequente em homens e idosos.
• C) Verificar distúrbios hidroeletrolíticos antes de antiarrítmicos é, de fato, importante pelo risco de pró-arritmia.
• D) Na ausência de IC, betabloqueadores ou bloqueadores de canal de cálcio não di-idropiridínicos são, de fato, opções válidas para controle de frequência.'),

('5b0cb8ae-af94-4981-ab59-7955bb2c063d', 'Fibrilação e Flutter', 2021, 'TEC', 'Para manutenção do ritmo sinusal (prevenção de recidivas) após reversão de fibrilação atrial em pacientes com fração de ejeção do ventrículo esquerdo ≤ 35%, qual a melhor alternativa medicamentosa?', 'Em pacientes com FE ≤35%, a amiodarona é a droga de escolha para manter o ritmo sinusal, por ter perfil de segurança mais favorável e não ter o efeito inotrópico negativo de outros antiarrítmicos.', 'Em pacientes com insuficiência cardíaca e disfunção ventricular importante (fração de ejeção ≤ 35%), a amiodarona é a droga de escolha para a manutenção do ritmo sinusal, pois possui um perfil de segurança mais favorável nessa população e não apresenta o efeito inotrópico negativo acentuado de outros antiarrítmicos (como a propafenona, que é contraindicada em pacientes com disfunção ventricular).

Por que as outras alternativas estão incorretas:
• A) Atenolol (betabloqueador) controla frequência, mas não é a droga padrão para manutenção do ritmo sinusal nesse contexto.
• B) Propafenona é contraindicada em disfunção ventricular importante pelo efeito inotrópico negativo.
• C) Sotalol também tem efeito inotrópico negativo e risco pró-arrítmico maior em disfunção ventricular, sendo evitado nesse cenário.
• E) Verapamil (bloqueador de canal de cálcio) tem efeito inotrópico negativo relevante e não é indicado para manutenção de ritmo em disfunção ventricular importante.'),

('b6bb5826-2fa3-4e95-a8ef-959a0062f91b', 'Fibrilação e Flutter', 2015, 'TEC', 'Em relação à fibrilação atrial paroxística sintomática, constitui indicação de ablação por radiofrequência (isolamento de veias pulmonares), EXCETO:', 'No contexto histórico desta questão (2015), a ablação era classicamente indicada após falha de terapia medicamentosa — sendo considerada de segunda linha, não a "primeira opção terapêutica" (alternativa C), que é o EXCETO pedido.', 'Embora as diretrizes tenham evoluído, no contexto desta questão de 2015, a ablação era classicamente indicada após a falha de terapia medicamentosa (refratariedade), sendo considerada um procedimento de segunda linha, diferentemente da indicação como "primeira opção" — por isso a alternativa C é o EXCETO pedido.

Por que as outras alternativas SÃO critérios aceitos de indicação (não são a resposta, que busca o que NÃO é critério):
• A) Contraindicação para uso crônico de anticoagulantes orais é critério aceito.
• B) Refratariedade a pelo menos um fármaco antiarrítmico é critério aceito.
• D) Desejo do paciente é considerado nas diretrizes.
• E) Remodelamento atrial esquerdo ausente ou discreto favorece o sucesso e é critério aceito.'),

('321d8b56-48a5-42d8-9eb9-b401cfefbc19', 'Fibrilação e Flutter', 2018, 'TEC', 'Mulher, 35 anos, em pós-operatório tardio de troca valvar (prótese biológica) devido à estenose mitral, em uso de amiodarona, digoxina e varfarina devido à fibrilação atrial. Assinale a alternativa CORRETA sobre o tratamento antiarrítmico desta paciente.', 'A amiodarona inibe o metabolismo da varfarina (via citocromo P450), potencializando seu efeito — por isso a dose de varfarina necessária para atingir o INR terapêutico deve ser menor que a usual quando associada à amiodarona.', 'A amiodarona inibe o metabolismo da varfarina (via citocromo P450), o que potencializa o efeito anticoagulante do fármaco. Portanto, quando se inicia ou se mantém a amiodarona em um paciente que usa varfarina, é necessário reduzir a dose desta última para evitar níveis de INR excessivamente elevados e o risco de sangramento.

Por que as outras alternativas estão incorretas:
• A) A amiodarona não é a primeira linha para controle da resposta ventricular; betabloqueadores e bloqueadores de cálcio são preferenciais para isso.
• B) A amiodarona, na verdade, REDUZ o clearance da digoxina, podendo levar a níveis tóxicos — não a uma má resposta por eliminação aumentada.
• D) A amiodarona causa PROLONGAMENTO (não encurtamento) do intervalo QT, pelo bloqueio de canais de potássio.
• E) A digoxina é pouco eficaz no controle da frequência cardíaca durante o EXERCÍCIO, sendo mais efetiva em repouso — não é eficaz "tanto no repouso quanto no exercício".'),

('2c400475-5b6d-417c-9a83-46073538d65b', 'Fibrilação e Flutter', 2015, 'TEC', 'MOS, 36 anos, masculino, com palpitações taquicárdicas intermitentes, antecedente de reumatismo e sopro na infância. Ritmo irregular, FC = 108 bpm, sopro diastólico em ruflar e estalido de abertura em foco mitral. ECG evidenciou fibrilação atrial com elevada resposta ventricular. Qual é a melhor estratégia antitrombótica?', 'O quadro é de estenose mitral reumática (sopro diastólico em ruflar + estalido de abertura) com FA — nesse cenário os DOACs são contraindicados, sendo a varfarina a única estratégia antitrombótica recomendada.', 'O paciente apresenta estenose mitral (evidenciada pelo sopro diastólico em ruflar e estalido de abertura). A presença de estenose mitral moderada a grave (ou prótese valvar mecânica) classifica o paciente como tendo "doença valvar significativa". Nestes casos, os Novos Anticoagulantes Orais (DOACs, como dabigatrana e apixabana) não são indicados. A indicação formal de anticoagulação para prevenção de fenômenos tromboembólicos nesse cenário é o uso de antagonistas da vitamina K (varfarina), com RNI alvo geralmente entre 2,0 e 3,0.

Por que as outras alternativas estão incorretas:
• A) AAS isolado é insuficiente para essa proteção, que exige anticoagulação plena.
• C) O CHA2DS2-VASc não se aplica aqui — a valvopatia reumática já define, por si só, indicação de anticoagulação com varfarina.
• D e E) Dabigatrana e apixabana (DOACs) são contraindicados em estenose mitral reumática significativa.'),

('f3bdca44-63f8-4438-a7ce-1bba46ea646b', 'Fibrilação e Flutter', 2016, 'TEC', 'Sobre a farmacocinética da amiodarona, é CORRETO afirmar:', 'A amiodarona é altamente lipofílica, o que explica sua distribuição extensa pelo corpo e deposição preferencial nos tecidos hepático, adiposo e pulmonar, além de sua meia-vida extremamente longa.', 'A amiodarona é um fármaco altamente lipofílico. Essa característica determina seu grande volume de distribuição, permitindo que ela se acumule extensamente em tecidos com alto teor de gordura e em órgãos como fígado, pulmões e tecido adiposo. Devido a essa farmacocinética, sua meia-vida de eliminação é extremamente longa (podendo durar meses), e seu início de ação, mesmo com dose de ataque, é geralmente lento. Além disso, ela é metabolizada pelo fígado (principalmente via CYP3A4) no metabólito ativo desetilamiodarona, e não eliminada inalterada.

Por que as outras alternativas estão incorretas:
• A) A eliminação não é principalmente renal, dada sua natureza lipofílica e metabolização hepática predominante.
• B) O início de ação após administração oral é lento (dias a semanas), não de 1-2 horas.
• C) Ela É metabolizada, formando o metabólito ativo desetilamiodarona — não é eliminada em sua forma original.
• E) Pela meia-vida longuíssima (semanas a meses), ela NÃO é totalmente eliminada em 7 dias após a interrupção.'),

('2b7b2beb-cf2f-49da-b53b-3486b4fac651', 'Fibrilação e Flutter', 2018, 'TEC', 'Mulher, 57 anos, hipertensa, com palpitações recorrentes. ECG na crise mais recente mostrou um ritmo que se mantém até o momento. PA normal, exame físico normal. Para o manejo da arritmia, a resposta INCORRETA é:', 'O traçado é de Flutter Atrial (padrão em "dentes de serra"). A ablação é o tratamento de escolha, mas NÃO é necessário "manter" a arritmia até o procedimento — deve-se considerar reversão ou controle de frequência conforme o quadro clínico.', 'O eletrocardiograma da questão caracteriza um Flutter Atrial (frequência atrial em torno de 300 bpm, com padrão clássico em "dentes de serra" nas derivações inferiores). A alternativa A está incorreta pois, embora a ablação por radiofrequência seja, de fato, o tratamento de escolha para o flutter atrial (com altíssima taxa de sucesso e cura), afirmar que a arritmia deve ser "mantida" até a realização do procedimento é conduta errônea; deve-se considerar a reversão ao ritmo sinusal ou o controle da frequência ventricular conforme o estado clínico do paciente, não havendo obrigatoriedade de manter a arritmia até a ablação.

Por que as outras alternativas estão corretas (não são a resposta, já que a pergunta pede a incorreta):
• B) O tratamento farmacológico para reversão do flutter é de fato pouco eficaz, sendo a cardioversão elétrica eletiva frequentemente indicada.
• C) A prevenção de fenômenos embólicos no flutter segue, de fato, a mesma estratégia da fibrilação atrial.
• D) A ablação por radiofrequência tem, de fato, excelentes resultados na prevenção de recorrências do flutter.
• E) O controle de frequência com betabloqueadores ou bloqueadores de canal de cálcio (verapamil/diltiazem) é, de fato, uma opção válida.'),

('4191e590-a526-4698-9259-7801b9c24d28', 'Fibrilação e Flutter', 2015, 'TEC', 'Paciente de 40 anos, sexo feminino, com tremores e palpitações; PA = 150 x 90 mmHg, FC 120-130 bpm. ECG fibrilação atrial. TSH baixo e T4 livre alto. A melhor conduta inicial é:', 'O quadro é de tireotoxicose complicando com FA — a conduta inicial é betabloqueador já de início, associado ao metimazol para tratar a causa base.', 'A paciente apresenta um quadro de hipertireoidismo (tireotoxicose) complicando com fibrilação atrial. A conduta inicial ideal visa o controle dos sintomas adrenérgicos e da frequência cardíaca elevada com betabloqueadores (como o propranolol, que também auxilia na conversão periférica de T4 em T3), associado ao início imediato do tratamento da causa base com metimazol (tionamida) para bloquear a síntese de hormônios tireoidianos.

Por que as outras alternativas estão incorretas:
• A) Usar metimazol ANTES do betabloqueador atrasa o controle imediato dos sintomas adrenérgicos e da frequência cardíaca.
• C) Digoxina não é a primeira escolha para controlar a resposta ventricular na FA por tireotoxicose (o excesso adrenérgico responde melhor a betabloqueador).
• D) Iodo radioativo antes do betabloqueador também atrasa o controle sintomático imediato e não é a conduta inicial na crise.
• E) Cardioversão elétrica sem controle prévio da tireotoxicose tem alta chance de recorrência imediata da FA, pois a causa de base não foi tratada.'),

('e95076b4-ee98-477d-874e-9884d467a5b2', 'Fibrilação e Flutter', 2021, 'TEC', 'Considerando as indicações de tratamento invasivo da fibrilação atrial (FA), assinale a alternativa correta:', 'A ablação por cateter é recomendada para reversão da disfunção ventricular em pacientes com cardiomiopatia induzida por FA (taquicardiomiopatia), mesmo que estejam assintomáticos.', 'A ablação por cateter é uma estratégia recomendada em pacientes com taquicardiomiopatia induzida por fibrilação atrial, visando a recuperação da função ventricular, mesmo quando os pacientes se apresentam assintomáticos.

Por que as outras alternativas estão incorretas:
• B) A ablação por cateter para FA não tem taxa de recidiva em um ano menor que 1% — as taxas de recidiva são substancialmente maiores, variando conforme o tipo de FA.
• C) O benefício da ablação é geralmente MAIOR na FA paroxística do que na persistente, não o contrário.
• D) Ausência de FA por 6 meses após nova ablação NÃO é, isoladamente, suficiente para suspender a anticoagulação com segurança — essa decisão depende do escore de risco embólico (CHA2DS2-VASc).
• E) Quanto MAIOR o tempo de duração/cronicidade da FA, MENOR (não maior) a chance de sucesso do procedimento.'),

('858b7cd9-7e96-4717-9a37-869b589e9d1a', 'Fibrilação e Flutter', 2015, 'TEC', 'Em relação aos anticoagulantes na fibrilação atrial (FA), assinale a alternativa CORRETA:', 'Os DOACs são formalmente contraindicados em pacientes com prótese valvar metálica — nesses casos, o padrão-ouro continua sendo a varfarina.', 'Os novos anticoagulantes orais (DOACs/NACOs) — como dabigatrana, rivaroxabana, apixabana e edoxabana — são formalmente contraindicados em pacientes portadores de prótese valvar metálica (e geralmente em estenose mitral moderada a grave), casos em que a varfarina permanece como a droga de escolha.

Por que as outras alternativas estão incorretas:
• A) A dose de varfarina muitas vezes precisa ser MENOR em idosos, pela farmacocinética alterada e maior risco de sangramento — não maior.
• B) Os DOACs agem diretamente sobre fatores específicos (Xa ou trombina), não reduzindo a síntese hepática de fatores de coagulação.
• D) A apixabana demonstrou, nos grandes estudos (como o ARISTOTLE), MENORES taxas de sangramento maior em comparação à varfarina, não taxas iguais.
• E) A dabigatrana é inibidor direto da TROMBINA (fator IIa), não do fator Xa, e também é contraindicada em prótese valvar mecânica.'),

('434df373-ffb9-49d7-ad5d-8befce237f56', 'Fibrilação e Flutter', 2021, 'TEC', 'Homem, 76 anos, com palpitações há 3 dias. Pulsos irregulares. FC ~140 bpm, PA = 110 x 70 mmHg. ECG = fibrilação atrial, BRD completo e bloqueio divisional anterossuperior esquerdo. Para alívio dos sintomas, baixando rapidamente a FC, a melhor opção é:', 'Para controle agudo da frequência em FA hemodinamicamente estável, betabloqueador venoso (ou bloqueador de canal de cálcio não di-idropiridínico) é a primeira escolha.', 'Para o controle agudo da frequência cardíaca em pacientes com fibrilação atrial estáveis hemodinamicamente (como neste caso, com PA 110 x 70 mmHg), os betabloqueadores (como metoprolol ou esmolol) ou bloqueadores dos canais de cálcio não diidropiridínicos (como diltiazem ou verapamil) são as drogas de primeira escolha.

Por que as outras alternativas estão incorretas:
• A) A amiodarona é geralmente reservada para pacientes com disfunção ventricular importante ou quando as outras medidas falham, não sendo a primeira escolha aqui.
• B) A adenosina não é indicada para controle de frequência na fibrilação atrial.
• C) A lidocaína não possui ação relevante sobre o nó atrioventricular para controle de frequência nesta arritmia.
• E) A propafenona oral não é a opção para baixar RAPIDAMENTE a frequência por via de controle do nó AV, além de ter outras contraindicações a avaliar antes do uso.'),

('39431eeb-d4a3-4326-8cb8-250fc7b86211', 'Fibrilação e Flutter', 2014, 'TEC', 'Paciente feminina, 55 anos, portadora de valvopatia mitral reumática e fibrilação atrial permanente, no pós-operatório de troca valvar mitral com implante de prótese mecânica. Qual é a melhor estratégia antitrombótica para essa paciente no seguimento ambulatorial?', 'Para prótese valvar mecânica em posição mitral, a diretriz recomenda varfarina com alvo de INR entre 2,5 e 3,5, pelo alto risco trombogênico dessa posição valvar.', 'Para pacientes com próteses valvares mecânicas em posição mitral, a diretriz estabelece a anticoagulação crônica com varfarina para manter um alvo de RNI (INR) mais elevado, geralmente entre 2,5 e 3,5, visando a prevenção de eventos tromboembólicos. Os novos anticoagulantes orais (DOACs) não possuem indicação para pacientes com próteses mecânicas.

Por que as outras alternativas estão incorretas:
• A) DOACs são contraindicados em prótese mecânica, tendo maior risco de eventos tromboembólicos que a varfarina.
• B, D e E) Associar antiagregantes (AAS/clopidogrel) à varfarina é reservado a cenários específicos (DAC concomitante, ICP recente), não sendo a estratégia padrão isolada; e um INR alvo mais baixo (em torno de 2) é insuficiente para proteger a prótese mecânica mitral.'),

('c20d2da3-a1bb-4cf2-9557-cbaf00629a9b', 'Fibrilação e Flutter', 2019, 'TEC', 'Homem, 58 anos, com palpitações recorrentes há 6 meses, ECG/Holter/ecocardiograma normais, medicado com succinato de metoprolol 25 mg/dia. Retornou com FA (FC=120) revertida com amiodarona EV, alta com metoprolol. Qual a conduta mais apropriada para terapia de controle do ritmo agora?', 'Para FA paroxística sintomática sem cardiopatia estrutural, fármacos como propafenona (ou flecainida) são de primeira linha para manutenção do ritmo sinusal, antes de considerar ablação.', 'O paciente apresenta FA paroxística sintomática sem cardiopatia estrutural significativa (ecocardiograma normal). De acordo com as diretrizes de manejo da fibrilação atrial, para pacientes sintomáticos e sem doença cardíaca estrutural importante, fármacos como a propafenona (ou flecainida) são considerados agentes de primeira linha para a manutenção do ritmo sinusal.

Por que as outras alternativas estão incorretas:
• B) Apenas aumentar a dose do betabloqueador não trata adequadamente o componente de controle de RITMO (recorrência da FA), que é o problema central do caso.
• C) A ablação é eficaz, mas geralmente indicada após falha de terapia medicamentosa antiarrítmica adequada, salvo preferência explícita do paciente.
• D) Iniciar amiodarona diretamente pula a primeira linha (propafenona/flecainida), reservada para casos com cardiopatia estrutural ou falha de outros fármacos.
• E) Não há indicação de estudo eletrofisiológico neste momento, já que o diagnóstico (FA paroxística) já está estabelecido.'),

('cfbf53a3-bf2d-405c-b38d-2d7aed44b082', 'Fibrilação e Flutter', 2020, 'TEC', 'Em relação à ocorrência de fibrilação atrial (FA) após cirurgia de revascularização miocárdica, é correto afirmar que:', 'A FA pós-CRM ocorre tipicamente entre o 2º e 4º dia de pós-operatório, atingindo 25-40% dos pacientes — é a epidemiologia mais citada sobre o tema.', 'A fibrilação atrial no pós-operatório de cirurgia cardíaca é uma complicação comum, ocorrendo tipicamente entre o segundo e o quarto dia após o procedimento, atingindo uma incidência de 25% a 40% dos pacientes.

Por que as outras alternativas estão incorretas:
• A) A cardioversão elétrica NÃO é a conduta inicial em pacientes estáveis — prioriza-se controle de frequência ou reversão medicamentosa.
• C) A amiodarona NÃO é mantida rotineiramente por 3-6 meses após a alta nesse contexto.
• D) O uso de CEC está, na verdade, associado a MAIOR (não menor) risco de FA pós-operatória.
• E) A FA no pós-operatório AUMENTA sim o risco de complicações tromboembólicas, não devendo ser subestimada.'),

('987751d7-40b6-423e-903a-596c4871a36a', 'Fibrilação e Flutter', 2013, 'TEC', 'Em pacientes com disfunção ventricular moderada a grave, o fármaco de escolha para a cardioversão farmacológica da fibrilação atrial é:', 'Em disfunção ventricular moderada a grave, a amiodarona é o fármaco de escolha para cardioversão farmacológica, por ter o melhor perfil de segurança nessa população (outros antiarrítmicos são contraindicados por risco de pró-arritmia/depressão miocárdica).', 'Em pacientes com disfunção ventricular moderada a grave (insuficiência cardíaca ou cardiopatia estrutural importante), a maioria dos fármacos antiarrítmicos (como a propafenona) é contraindicada devido ao risco de proarritmia e depressão miocárdica. A amiodarona é o fármaco de escolha para a cardioversão farmacológica e manutenção do ritmo nestes pacientes, por ser o agente com melhor perfil de segurança nessa população.

Por que as outras alternativas estão incorretas:
• A) Sotalol tem risco pró-arrítmico (Torsades) maior em disfunção ventricular, sendo evitado.
• B) Digoxina não é eficaz para CARDIOVERSÃO (reversão de ritmo), apenas para controle de frequência.
• D) Propafenona é contraindicada em disfunção ventricular importante, pelo efeito inotrópico negativo.
• E) Dronedarona também é contraindicada em insuficiência cardíaca avançada/disfunção ventricular grave.'),

('8a24948e-c214-4f85-9258-823b27ebe3a3', 'Fibrilação e Flutter', 2022, 'TEC', 'Em relação aos pacientes submetidos à intervenção coronariana percutânea recente e que possuam indicação de anticoagulação oral por fibrilação atrial, é correto afirmar:', 'Em pacientes com alto risco de sangramento e menor risco isquêmico, o uso de clopidogrel associado a anticoagulante oral direto (dupla terapia) pode ser considerado desde o início do tratamento, em vez da terapia tripla.', 'Em pacientes que necessitam de anticoagulação crônica (como na fibrilação atrial) e que são submetidos a uma intervenção coronariana percutânea (ICP), o manejo antitrombótico deve ser individualizado para equilibrar o risco isquêmico e o risco de sangramento. As diretrizes atuais recomendam a estratégia de dupla terapia (anticoagulante oral direto + um antiagregante, geralmente o clopidogrel) como preferencial em muitos cenários, especialmente naqueles com maior risco de sangramento, para reduzir complicações hemorrágicas, em detrimento da tripla terapia prolongada.

Por que as outras alternativas estão incorretas:
• A) Prasugrel e ticagrelor são antiagregantes MAIS potentes, que aumentam o risco de sangramento quando associados a anticoagulante — não são preferíveis por "menor risco".
• B) A varfarina não é contraindicada nesse contexto; pode ser usada como parte do esquema antitrombótico conforme o caso.
• C) A recomendação é justamente o oposto do descrito para alto risco de sangramento: reduzir para dupla terapia, não trocar TUDO por dupla antiagregação sem anticoagulante.
• E) A tripla terapia prolongada por um ano NÃO é considerada segura de forma geral — associa-se a alto risco hemorrágico, sendo evitada por períodos longos.'),

('913dbac7-d0a6-493d-a8a0-918a7261f446', 'Fibrilação e Flutter', 2022, 'TEC', 'Em relação à indicação e à avaliação de risco trombótico e hemorrágico com o uso de anticoagulantes orais, assinale a alternativa correta:', 'Em FA, usa-se o CHA2DS2-VASc para risco trombótico e o HAS-BLED para risco de sangramento; pacientes com eventos tromboembólicos prévios ou prótese mecânica mantêm anticoagulação independentemente de qualquer escore.', 'O escore CHA2DS2-VASc é o padrão-ouro para estratificação de risco tromboembólico na fibrilação atrial (FA). Pacientes com próteses valvares mecânicas possuem indicação de anticoagulação absoluta, e o escore HAS-BLED é utilizado para avaliar o risco de sangramento, ajudando a identificar fatores de risco modificáveis sem, contudo, contraindicar automaticamente o uso do anticoagulante.

Por que as outras alternativas estão incorretas:
• B) HAS-BLED ≥3 indica alto risco e necessidade de cautela/vigilância, mas não contraindica formalmente a anticoagulação.
• C) A profilaxia pós-cardioversão deve ser mantida por pelo menos 4 semanas, não 2.
• D) O flutter atrial possui risco embólico semelhante à FA, exigindo INR convencional (2,0-3,0), não reduzido.
• E) No HAS-BLED, idade >65 anos (não 75) confere 1 ponto.'),

('6ea0cdda-8bd2-4522-8a57-8b4ea400036f', 'Fibrilação e Flutter', 2014, 'TEC', 'Paciente feminina, 70 anos, cardiomiopatia dilatada com FE reduzida (isquêmica), já em betabloqueador dose máxima, IC crônica. Nova FA identificada. PA 110x70, FC 98. Clearance de creatinina = 20 mL/min. Qual a melhor conduta considerando os fatores de risco?', 'Com clearance de creatinina de 20 mL/min (doença renal grave), os DOACs (como dabigatrana) são contraindicados ou exigem extrema cautela — a varfarina é a escolha mais segura e estabelecida nesse cenário, junto ao controle de frequência.', 'A paciente apresenta fibrilação atrial e alto risco embólico (pontuação alta no CHA2DS2-VASc devido à idade e insuficiência cardíaca). O tratamento anticoagulante é mandatório. Contudo, a paciente apresenta uma taxa de filtração glomerular (clearance de creatinina) de 20 mL/min, o que caracteriza uma doença renal crônica grave. Os novos anticoagulantes orais (DOACs/NACOs), como a dabigatrana, possuem contraindicação ou exigem extremo ajuste/cautela em níveis tão baixos de clearance, sendo a varfarina a escolha mais segura e estabelecida para pacientes com insuficiência renal avançada.

Por que as outras alternativas estão incorretas:
• B) Cardioversão elétrica não é indicada de rotina sem antes garantir anticoagulação adequada e avaliar o contexto clínico; controle de frequência + anticoagulação é a conduta inicial preferida aqui.
• C) Estudo eletrofisiológico não é indicado neste cenário simples de FA com IC.
• D) Dabigatrana é a opção CONTRAINDICADA justamente pela função renal muito reduzida.
• E) Internação e heparina de baixo peso + dabigatrana não são necessárias/apropriadas — a paciente pode ser manejada ambulatorialmente com varfarina.'),

('ceb6857d-684e-4f8a-b157-c696ddb8a871', 'Fibrilação e Flutter', 2024, 'TEC', 'Paciente do sexo feminino, 50 anos, troca valvar aórtica (prótese biológica). No 2º dia de PO, FA revertida com amiodarona. Sem novos eventos em 7 meses (incluindo Holter). Em uso de amiodarona e anticoagulação, assintomática, exames normais, bioprótese normofuncionante. Conduta mais apropriada:', 'FA pós-operatória isolada, sem recidiva em 7 meses de seguimento (incluindo Holter normal), não exige manutenção crônica de antiarrítmico nem anticoagulação — a conduta é suspender ambas as medicações.', 'A paciente apresenta fibrilação atrial (FA) pós-operatória que ocorreu há 7 meses e não recidivou. Segundo as diretrizes atuais, a FA que ocorre no pós-operatório de cirurgia cardíaca e não apresenta recorrência não exige manutenção crônica de antiarrítmicos ou anticoagulação, uma vez que o fator desencadeante foi o estresse cirúrgico. Como a paciente está assintomática, com exames normais (incluindo o Holter) e com a bioprótese normofuncionante, a suspensão de ambas as medicações (amiodarona e anticoagulante) é a conduta mais apropriada.

Por que as outras alternativas estão incorretas:
• B, D e E) Manter qualquer uma das duas medicações (antiarrítmico ou anticoagulante) de forma crônica não se justifica, já que o fator desencadeante foi transitório (estresse cirúrgico) e não houve recorrência documentada em 7 meses de seguimento rigoroso.
• C) Trocar amiodarona por propafenona não faz sentido quando a conduta correta é suspender o antiarrítmico completamente.'),

('bd1f7329-4277-4267-9250-74eba8bdf11e', 'Fibrilação e Flutter', 2018, 'TEC', 'Gestante, 16ª semana, prótese biológica mitral há 4 anos, palpitações e dispneia há uma semana. FC=120, PA=100x60, estertores crepitantes de bases. ECG: taquicardia regular QRS estreito, novo ECG mostra flutter atrial 2:1. Conduta inicial na emergência:', 'Paciente instável (dispneia, estertores) com flutter 2:1 e prótese valvar: a conduta é cardioversão elétrica (segura na gestação), com anticoagulação plena (enoxaparina) e ecocardiograma transesofágico para excluir trombo antes/durante o procedimento.', 'A paciente apresenta um quadro de instabilidade clínica (dispneia, estertores pulmonares) decorrente de um flutter atrial com resposta ventricular rápida em uma gestante com prótese valvar. A conduta de escolha para reversão do ritmo em pacientes instáveis ou com necessidade de rápida reversão na gestação é a cardioversão elétrica, que é considerada segura para o feto quando realizada com a técnica adequada. Dada a presença de prótese valvar e o quadro de taquicardia sustentada, há alto risco de eventos tromboembólicos, sendo necessária a anticoagulação plena com heparina (enoxaparina) e a realização de ecocardiograma transesofágico para exclusão de trombos intracavitários e avaliação da prótese.

Por que as outras alternativas estão incorretas:
• A) Adenosina não reverte flutter atrial (é útil para diagnóstico, não tratamento definitivo); e enoxaparina isolada não trata a instabilidade.
• B) Amiodarona IV em bolo não é a conduta prioritária diante de instabilidade franca — cardioversão elétrica é mais indicada; aspirina é insuficiente para o risco tromboembólico dessa paciente.
• C) Controle de frequência com atenolol/verapamil não resolve a instabilidade hemodinâmica aguda que exige reversão.
• E) Propafenona para controle de frequência não é o uso correto da droga (é antiarrítmico, não bradicardizante primário) e enoxaparina profilática é insuficiente para o risco tromboembólico presente.'),

('00eceba8-0519-483d-bf9d-fff4c53fc841', 'Fibrilação e Flutter', 2017, 'TEC', 'No manejo clínico da fibrilação atrial, está contraindicado:', 'A propafenona é formalmente contraindicada em pacientes com disfunção ventricular esquerda, pelo efeito inotrópico negativo e risco de descompensação/aumento de mortalidade.', 'A propafenona (assim como a flecainida) é um antiarrítmico da classe IC, que possui efeito inotrópico negativo significativo. Por isso, é formalmente contraindicada em pacientes com disfunção ventricular esquerda (fração de ejeção reduzida) ou doença cardíaca estrutural importante, devido ao risco de insuficiência cardíaca descompensada e aumento da mortalidade.

Por que as outras alternativas estão incorretas:
• A) Sotalol para evitar recorrência é uma opção terapêutica comumente utilizada (com as devidas precauções de QT).
• B) Amiodarona para evitar recorrência é opção segura mesmo em cardiopatia estrutural, ao contrário da propafenona.
• C) Diltiazem para controle de resposta ventricular é opção padrão e segura.
• E) Associar betabloqueador com digoxina para controle de frequência é estratégia comum e aceita.'),

('8a73aa14-db87-4ce5-8a4a-fabd379a6a6f', 'Fibrilação e Flutter', 2025, 'TEC', 'Paciente com história de valvoplastia mitral percutânea por estenose valvar mitral reumática, mal-estar há uma semana. ECG registrado mostra ondas F negativas em II, III e aVF. Sobre o cenário, é correto afirmar:', 'O ECG mostra flutter atrial típico, um circuito de macroreentrada no átrio direito usando o istmo cavotricuspídeo — mesmo com histórico de intervenção em átrio esquerdo, a apresentação típica indica o circuito clássico de átrio direito.', 'O eletrocardiograma mostra um flutter atrial típico, que é classicamente caracterizado por um circuito de macroreentrada no átrio direito, utilizando o istmo cavotricuspídeo como barreira crítica. Embora o paciente tenha histórico de intervenção no átrio esquerdo, a apresentação eletrocardiográfica de um flutter típico (ondas F negativas nas derivações inferiores II, III e aVF) indica, na maioria das vezes, o circuito convencional de átrio direito.

Por que as outras alternativas estão incorretas:
• A) A morfologia das ondas F no flutter típico é MONOMÓRFICA (regular, previsível), não variável — o que gera R-R regular na condução fixa (ex.: 2:1), não muito irregular.
• B) A condução 1:1 é POSSÍVEL e pode levar à instabilidade, mas não é a característica mais frequente nem a definição diagnóstica do flutter típico.
• D) O histórico de intervenção em átrio esquerdo não torna automaticamente a arritmia um flutter atípico — a morfologia típica no ECG aponta para o circuito clássico de átrio direito.
• E) A ablação do istmo cavotricuspídeo no flutter típico apresenta taxas de sucesso MUITO ELEVADAS, não baixas, mesmo na presença de cardiopatia estrutural associada.'),

('060fa95b-15b8-495d-9a3a-994255dc8fe2', 'Fibrilação e Flutter', 2012, 'TEC', 'Para um paciente com fibrilação atrial permanente e angina de difícil controle, qual dos medicamentos não teria efeito terapêutico:', 'A ivabradina atua bloqueando a corrente If no nó sinoatrial, funcionando apenas em ritmo sinusal — na FA permanente (sem onda P organizada) ela não tem mecanismo de ação, não trazendo benefício para a angina.', 'A ivabradina é um fármaco que atua especificamente bloqueando a corrente If ("funny") no nó sinoatrial, reduzindo a frequência cardíaca exclusivamente em pacientes que se encontram em ritmo sinusal. Como o paciente apresenta fibrilação atrial permanente (ausência de ritmo sinusal e de onda P organizada), a ivabradina não possui mecanismo de ação para reduzir a frequência cardíaca neste cenário e, portanto, não apresenta efeito terapêutico para o controle da angina em pacientes com FA.

Por que as outras alternativas estão incorretas (têm, sim, efeito terapêutico):
• A e D) Bisoprolol e atenolol (betabloqueadores) controlam a frequência ventricular na FA e têm efeito antianginoso.
• B) Verapamil controla a frequência ventricular na FA e tem efeito antianginoso (bloqueador de canal de cálcio).
• C) Trimetazidina tem efeito antianginoso metabólico, independente do ritmo cardíaco.'),

('8bacc543-4fb7-4af7-8bdd-ec7d05bff98c', 'Fibrilação e Flutter', 2019, 'TEC', 'ECG registrado durante emergência, paciente com síncope, sinais de baixo débito e precordialgia, mostrando taquicardia de QRS largo, morfologia variável e FC muito elevada. O que sugere o ECG e qual a conduta?', 'O padrão sugere fibrilação atrial com condução por via acessória (WPW com FA) — alto risco de degenerar para fibrilação ventricular. A conduta é cardioversão elétrica imediata seguida de ablação da via acessória; drogas que bloqueiam o nó AV são contraindicadas.', 'O traçado eletrocardiográfico mostra uma fibrilação atrial com condução anterógrada via via acessória (Síndrome de Wolff-Parkinson-White com FA). Caracteriza-se por uma taquicardia com complexos QRS largos, de morfologia variável e frequência ventricular muito elevada (que pode ser superior a 200-250 bpm em alguns batimentos). Esta é uma arritmia de alto risco, pois pode degenerar para fibrilação ventricular. A conduta mandatória em paciente sintomático/instável é a cardioversão elétrica imediata, seguida de encaminhamento para ablação por cateter da via acessória para tratamento definitivo. Medicamentos que bloqueiam o nó AV (como betabloqueadores, digoxina, verapamil ou diltiazem) são contraindicados neste cenário, pois podem favorecer a condução pela via acessória e piorar a taquicardia.

Por que as outras alternativas estão incorretas:
• A) O padrão descrito não é de fibrilação ventricular clássica (que é caótica, sem complexos organizados) — é FA conduzida por via acessória.
• B) Não há elementos típicos de TV polimórfica catecolaminérgica (contexto de esforço/estresse emocional em jovem sem cardiopatia) descritos no caso.
• C) Não há descrição de contexto de síndrome coronariana aguda que sustente essa hipótese como a principal.
• E) O ECG não é simplesmente "FA de alta resposta com BRE" — o QRS largo de morfologia VARIÁVEL e a frequência extrema apontam para condução por via acessória (WPW), um cenário de risco bem mais específico e grave.'),

('4a5b36a0-b03c-4165-9793-03d08cedda66', 'Fibrilação e Flutter', 2013, 'TEC', 'Gestante primípara, 29ª semana, fibrilação atrial persistente, FC=140 bpm, mal-estar. PA=140x70, pulmões limpos, discreto edema perimaleolar. Conduta inicial adequada:', 'Paciente hemodinamicamente estável — a estratégia inicial preferencial em gestante com FA estável é o controle da frequência cardíaca (betabloqueador, bloqueador de canal de cálcio ou digoxina), reservando a cardioversão para instabilidade.', 'A paciente está hemodinamicamente estável (PA 140x70 mmHg e pulmões limpos). Em gestantes com fibrilação atrial, a estratégia inicial preferencial, na ausência de instabilidade hemodinâmica grave, é o controle da frequência cardíaca utilizando fármacos como betabloqueadores (observando-se os riscos ao feto) ou bloqueadores dos canais de cálcio (verapamil ou diltiazem) e a digoxina.

Por que as outras alternativas estão incorretas:
• A) Interromper a gestação não é justificado por uma FA hemodinamicamente estável e controlável clinicamente.
• B) A cardioversão elétrica é reservada para casos de instabilidade hemodinâmica, o que não é o caso aqui.
• C) Ablação das veias pulmonares não é a conduta INICIAL de urgência para esse quadro.
• D) A amiodarona é geralmente evitada na gestação, pelos riscos de toxicidade tireoidiana e bradicardia fetal.'),

('e45e3bfd-d75f-4dc7-abdb-c117912e1765', 'Fibrilação e Flutter', 2018, 'TEC', 'A fibrilação atrial (FA) é ocorrência comum no pós-operatório de cirurgia cardíaca. Assinale a alternativa CORRETA com relação à FA no pós-operatório de cirurgia cardíaca:', 'A hipomagnesemia é fator de risco bem estabelecido para FA pós-operatória, e a reposição de magnésio (pré/per/pós-operatória) demonstrou reduzir sua incidência.', 'A hipomagnesemia é um fator de risco bem estabelecido para a ocorrência de fibrilação atrial no pós-operatório (PO) de cirurgia cardíaca, e a reposição de magnésio demonstrou ser eficaz na redução da incidência de FA.

Por que as outras alternativas estão incorretas:
• B) O uso de corticoide (hidrocortisona) TEM evidências de redução da FA no PO — o oposto do afirmado.
• C) Betabloqueadores são primeira linha de prevenção, mas a amiodarona também é muito efetiva, com eficácia similar/superior em subgrupos — não é correto dizer que betabloqueador é "mais efetivo" de forma categórica.
• D) Estatinas (atorvastatina) TÊM evidências de redução da incidência de FA pós-operatória.
• E) Colchicina TEM evidências de efetividade na redução da incidência de FA pós-operatória.'),

('673ea280-bb4f-469f-a2e1-e3cc876eed70', 'Fibrilação e Flutter', 2016, 'TEC', 'Em relação ao tratamento farmacológico da fibrilação atrial, qual das seguintes alternativas está CORRETA?', 'Verapamil e diltiazem (bloqueadores de canal de cálcio não di-idropiridínicos) apresentam bons resultados no controle da frequência ventricular na FA, com boa segurança e melhora da qualidade de vida em pacientes selecionados.', 'Os bloqueadores dos canais de cálcio não diidropiridínicos (verapamil e diltiazem) são agentes eficazes para o controle da frequência ventricular em pacientes com fibrilação atrial, apresentando bom perfil de segurança e melhora sintomática em pacientes selecionados.

Por que as outras alternativas estão incorretas:
• A) O sotalol é CONTRAINDICADO na insuficiência cardíaca (risco pró-arrítmico), não é o fármaco de escolha para evitar recorrências nesse grupo.
• B) A cardioversão em pacientes INSTÁVEIS deve ser ELÉTRICA, não farmacológica com amiodarona em bolo.
• C) A digoxina não apresenta "piores resultados" especificamente por idade ou sedentarismo — é frequentemente usada justamente em pacientes sedentários/idosos.
• E) A propafenona (classe IC) é CONTRAINDICADA em pacientes com insuficiência cardíaca estrutural, pelo risco de depressão miocárdica — não deve ser usada nesse contexto.'),

('f5630002-333b-410d-911e-78fd3baf145d', 'Fibrilação e Flutter', 2025, 'TEC', 'Paciente do sexo feminino, 63 anos, 84 kg, FA paroxística em Holter após AVC isquêmico. Creatinina = 1,2 mg/dL, clearance = 40,9 mL/min, sem outras comorbidades, FEVE=70%. Sobre a anticoagulação, assinale a alternativa cuja dose está adequada:', 'A edoxabana tem dose padrão de 60 mg/dia, ajustada para 30 mg/dia quando clearance está entre 15-50 mL/min, peso ≤60 kg ou uso de inibidor potente da glicoproteína P — o clearance de 40,9 mL/min desta paciente justifica a dose ajustada de 30 mg/dia.', 'A paciente apresenta FA com indicação de anticoagulação (CHA2DS2-VASc ≥ 2). A dose padrão da edoxabana é 60 mg/dia. No entanto, para pacientes com clearance de creatinina entre 15 e 50 mL/min, peso ≤ 60 kg ou uso concomitante de inibidores potentes da glicoproteína P, a dose deve ser ajustada para 30 mg/dia — critério que esta paciente preenche pelo clearance de 40,9 mL/min.

Por que as outras alternativas estão incorretas:
• A) Rivaroxabana 20 mg/dia é a dose padrão sem ajuste, mas não é a opção destacada como corretamente ajustada neste cenário específico da questão.
• B) Apixabana 2,5 mg 12/12h é a dose REDUZIDA, usada quando há pelo menos 2 de 3 critérios (idade ≥80, peso ≤60kg, creatinina ≥1,5) — a paciente não preenche esses critérios para essa dose reduzida.
• D) Varfarina com INR 2,5-3,5 é o alvo para prótese mecânica mitral, não o cenário desta paciente (FA não valvar).
• E) A paciente TEM indicação de anticoagulação (CHA2DS2-VASc ≥2 pelo AVC prévio), então essa alternativa está incorreta.'),

('f74a09b4-1dd5-40c2-98ef-117a51713372', 'Fibrilação e Flutter', 2016, 'TEC', 'Sobre as interações medicamentosas com a varfarina, quais dos abaixo potencializam sua ação?', 'Amiodarona, cimetidina, fluconazol e metronidazol são potentes inibidores enzimáticos (CYP2C9), que reduzem o metabolismo da varfarina e potencializam seu efeito anticoagulante.', 'A varfarina tem seu efeito anticoagulante potencializado por diversas drogas que inibem seu metabolismo hepático (via citocromo P450) ou que interferem na sua absorção/disponibilidade. A amiodarona, a cimetidina, o fluconazol e o metronidazol são exemplos clássicos de fármacos que aumentam o efeito da varfarina, elevando o RNI e o risco de sangramento.

Por que as outras alternativas estão incorretas:
• A, C, D e E) Contêm drogas como barbiturato, carbamazepina e rifampicina — indutores enzimáticos potentes, que aceleram a degradação da varfarina, DIMINUINDO seu efeito (o oposto do que a questão pede).'),

('0301c484-82ce-4bc8-bd4a-b19488ef43ad', 'Fibrilação e Flutter', 2023, 'TEC', 'Paciente com 82 anos, 75 kg, FA permanente, TFG=60 mL/min, em atenolol 25mg e edoxabana 60mg/dia. Queda da própria altura, hematoma em face, sem lesão intracraniana. Queda prévia no ano anterior. Qual a melhor conduta?', 'O paciente não preenche critérios de ajuste de dose da edoxabana (apenas idade avançada isolada não basta) e não há sangramento maior/intracraniano — a conduta é manter o tratamento, com acompanhamento para prevenir novas quedas.', 'A conduta correta é manter o tratamento. O paciente apresenta fibrilação atrial permanente com indicação de anticoagulação. O episódio de queda, embora necessite de acompanhamento para prevenir novos eventos (avaliação de equilíbrio, ambiente e medicação), não é uma contraindicação absoluta para a manutenção da anticoagulação, especialmente sem lesões hemorrágicas maiores (tomografia normal).

Por que as outras alternativas estão incorretas:
• A) A redução da dose da edoxabana não é indicada apenas pela idade — o ajuste baseia-se em clearance de creatinina, peso ou uso de inibidores da glicoproteína P, critérios que este paciente (75 kg, TFG 60) não preenche para a dose de 30 mg.
• C) Suspender a anticoagulação "por não ter indicação" está incorreto — o paciente TEM indicação clara (FA permanente).
• D) Usar HAS-BLED para eventualmente suspender não é a conduta recomendada — escore elevado pede vigilância, não suspensão.
• E) Trocar por dabigatrana não se justifica pelo perfil clínico apresentado, sem motivo específico para essa troca.'),

('de0e4d80-4c9c-408c-9c2b-da1ba658ce00', 'Fibrilação e Flutter', 2013, 'TEC', 'Paciente do sexo masculino, 67 anos, hipertenso e diabético. Submetido a cirurgia de revascularização miocárdica, apresentou fibrilação atrial no pós-operatório imediato. Apesar das tentativas de reversão ao ritmo sinusal, a arritmia persistiu por mais de 48 horas. Neste caso, pode-se afirmar que a anticoagulação:', 'A FA que persiste por mais de 48 horas no pós-operatório de cirurgia cardíaca eleva o risco de AVE — a anticoagulação está formalmente indicada, pois esse risco supera o risco hemorrágico quando bem manejada.', 'A fibrilação atrial (FA) que persiste por mais de 48 horas no pós-operatório de cirurgia cardíaca confere um risco tromboembólico significativo, especialmente em pacientes com fatores de risco associados (idade, hipertensão e diabetes, neste caso). Portanto, a anticoagulação está indicada para a prevenção de eventos tromboembólicos, como o acidente vascular encefálico (AVE), uma vez que o benefício da prevenção do AVE supera o risco hemorrágico pós-operatório quando avaliado individualmente.

Por que as outras alternativas estão incorretas:
• A) O risco de AVE na FA persistente é significativo e supera o risco hemorrágico quando a anticoagulação é bem manejada.
• B) Não existe uma regra rígida de "24 horas após a retirada do dreno" — o início deve ser pautado pela avaliação individualizada de risco trombótico versus hemorrágico.
• C) A anticoagulação não deve ser protelada por sete dias apenas com AAS, que é insuficiente para essa profilaxia.
• D) A indicação não se restringe a pacientes com AVE prévio — baseia-se no risco tromboembólico geral do paciente.'),

('67c76566-ac1b-4e52-91a6-f3d0b24db87f', 'Fibrilação e Flutter', 2013, 'TEC', 'Paciente em uso de sotalol 160 mg/dia. Após análise de exames, exame físico e ECG, o médico decidiu descontinuar o sotalol, por ter identificado uma CONTRAINDICAÇÃO ao seu uso:', 'O sotalol prolonga o intervalo QT — um QT maior que 500 ms é contraindicação absoluta para seu uso, pelo alto risco de Torsades de Pointes.', 'O sotalol é um agente antiarrítmico de classe III que possui propriedades de bloqueio beta-adrenérgico. Seu principal efeito colateral, que limita seu uso, é o prolongamento do intervalo QT, o que aumenta o risco de arritmias ventriculares graves, como a Torsades de Pointes. Portanto, um intervalo QT > 500 ms é uma contraindicação absoluta para o início ou a manutenção da terapia com sotalol, devido ao risco elevado de toxicidade pró-arrítmica.

Por que as outras alternativas não representam contraindicações diretas ao sotalol:
• A) Ácido úrico elevado não é uma contraindicação relacionada ao sotalol.
• C) Aumento de transaminases não é a contraindicação clássica e mais relevante do sotalol (que é cardíaca, ligada ao QT).
• D) Disfunção ventricular LEVE não é, por si só, contraindicação absoluta ao sotalol (diferente de disfunção moderada-grave).
• E) Uso de outras drogas para controle de frequência não é, isoladamente, uma contraindicação ao sotalol.'),

('54e352a6-91e7-4d15-96b4-45efe0d94c13', 'Fibrilação e Flutter', 2017, 'TEC', 'Ao diagnosticar flutter atrial agudo em um paciente, o cardiologista deve optar como tratamento inicial para reversão ao ritmo sinusal:', 'A cardioversão elétrica é o tratamento inicial de escolha para reversão do flutter atrial agudo, com taxas de sucesso muito elevadas — o flutter costuma ser mais resistente à reversão só farmacológica.', 'A cardioversão elétrica é a modalidade de escolha e o tratamento inicial mais eficaz para a reversão do flutter atrial, especialmente em um cenário agudo, apresentando taxas de sucesso muito elevadas. Diferente da fibrilação atrial, o flutter atrial costuma ser mais resistente à reversão exclusivamente farmacológica e, por se tratar de um circuito de macroreentrada bem definido, a cardioversão elétrica (frequentemente com níveis de energia mais baixos do que na FA) é altamente resolutiva.

Por que as outras alternativas estão incorretas:
• B) Betabloqueador oral controla frequência, mas não reverte o flutter para ritmo sinusal de forma eficaz como primeira escolha.
• C) Estimulação cardíaca artificial (overdrive pacing) é uma opção em cenários específicos, não a primeira escolha padrão.
• D) Amiodarona EV pode ser usada, mas o flutter é classicamente mais resistente à reversão farmacológica do que a cardioversão elétrica.
• E) A adenosina pode auxiliar no DIAGNÓSTICO (revelando ondas F ao reduzir a condução AV transitoriamente), mas não interrompe o circuito do flutter.'),

('ada6b5fe-2ff7-4a8a-a181-2008a41024fd', 'Fibrilação e Flutter', 2015, 'TEC', 'Quanto ao comportamento dos betabloqueadores, assinale a alternativa ERRADA:', 'O propranolol é um betabloqueador NÃO seletivo (bloqueia β1 e β2) — não é cardiosseletivo como metoprolol e atenolol; por isso essa é a alternativa errada.', 'A alternativa C é a ERRADA. O propranolol é um betabloqueador não seletivo (bloqueia receptores β1 e β2), e não um fármaco cardiosseletivo. O metoprolol e o atenolol são, de fato, cardiosseletivos (seletivos para receptores β1).

Por que as outras alternativas estão corretas (não são a resposta, já que a pergunta pede a errada):
• A) A seletividade para receptores β1 tende a ser relativa e pode ser perdida em altas doses — descrição correta.
• B) Bloqueadores não seletivos atuam em ambos os receptores (β1 e β2) já em doses baixas — descrição correta.
• D) O carvedilol possui atividade de bloqueio alfa-adrenérgico, conferindo-lhe propriedades vasodilatadoras — descrição correta.
• E) Os mecanismos de controle pressórico descritos (redução do débito cardíaco via β1 e redução da liberação de renina via β1) estão corretos.'),

('43fa0de1-344b-4968-999b-fff600890397', 'Fibrilação e Flutter', 2016, 'TEC', 'Qual das alternativas apresenta paraefeitos relacionados aos antiarrítmicos verapamil, propafenona, sotalol e amiodarona, respectivamente:', 'Verapamil: constipação intestinal. Propafenona: piora da função ventricular. Sotalol: Torsades de Pointes. Amiodarona: ataxia — essa é a combinação correta de efeitos colaterais clássicos.', 'Verapamil: Um efeito colateral muito comum é a constipação intestinal (devido ao bloqueio de canais de cálcio no trato gastrointestinal).
Propafenona: Como antiarrítmico de classe IC, possui efeito inotrópico negativo, podendo causar piora da função ventricular em pacientes com cardiopatia estrutural.
Sotalol: Por prolongar o intervalo QT, seu principal risco é a ocorrência de arritmias ventriculares graves, como a Torsades de pointes.
Amiodarona: Dentre seus diversos efeitos adversos extracardíacos, a ataxia (instabilidade da marcha/incoordenação motora) é um efeito neurológico clássico associado ao uso crônico.

Por que as outras combinações (alternativas A, C, D, E) estão incorretas: cada uma associa esses ou outros fármacos a efeitos colaterais que não são os classicamente mais associados a eles nas provas de cardiologia (como crise hipertensiva, agranulocitose, cefaleia ou epididimite, que não são os efeitos clássicos de verapamil/propafenona/sotalol/amiodarona nessa ordem).'),

('3a47c1af-2204-432f-a60c-40c34a161e0d', 'Fibrilação e Flutter', 2015, 'TEC', 'Paciente de 76 anos, dispneia progressiva (atual em repouso). Ritmo de FA, FC=106, PA=160x95, congestão venosa (edema MMII, hepatomegalia, estertores). HAS de longa data, tratamento irregular. Qual medicação NÃO está indicada?', 'O paciente tem IC descompensada + FA. A ivabradina não tem efeito em FA (atua só em ritmo sinusal), sendo a medicação NÃO indicada nesse contexto.', 'O paciente apresenta quadro de insuficiência cardíaca congestiva descompensada (congestão sistêmica e pulmonar) associada a fibrilação atrial (FA). A ivabradina é um fármaco que atua exclusivamente no nó sinusal, reduzindo a frequência cardíaca em pacientes em ritmo sinusal. Ela não tem efeito em pacientes com fibrilação atrial, pois na FA o ritmo não é comandado pelo nó sinusal. Portanto, não há benefício e seu uso não é indicado neste contexto.

Por que as outras alternativas ESTÃO indicadas (não são a resposta pedida):
• A) Furosemida é essencial para alívio da congestão.
• B) Inibidor de ECA é padrão no tratamento da insuficiência cardíaca e hipertensão.
• C) Digoxina é frequentemente utilizada para controle da frequência ventricular na FA com IC.
• D) Betabloqueadores (metoprolol/bisoprolol/carvedilol) são frequentemente utilizados para controle de frequência na FA com IC, quando compensada/tolerada.'),

('df12ddcf-6a9a-43a8-94c6-3d9a127e953c', 'Fibrilação e Flutter', 2016, 'TEC', 'Em relação à prevenção de fenômenos tromboembólicos na fibrilação e no flutter atrial, é correto afirmar que:', 'Os DOACs (dabigatrana, rivaroxabana, apixabana) reduziram as taxas de AVE hemorrágico em comparação aos antagonistas da vitamina K nos grandes ensaios clínicos.', 'Os estudos pivotais dos novos anticoagulantes orais (NOACs) demonstraram, de forma consistente, uma redução significativa na incidência de AVE hemorrágico e de hemorragia intracraniana em comparação com a varfarina (antagonista da vitamina K).

Por que as outras alternativas estão incorretas:
• B) A indicação de anticoagulação baseia-se no risco embólico (CHA2DS2-VASc), não apenas na forma de apresentação (paroxística, persistente, permanente).
• C) A anticoagulação é recomendada para pontuação ≥2 (homens) ou ≥3 (mulheres), não estritamente "acima de 3".
• D) Em prótese valvar mecânica, os NOACs são CONTRAINDICADOS — a varfarina continua sendo o tratamento de escolha.
• E) Idade avançada e AVE prévio são fatores de ALTO risco para novos eventos, tornando a anticoagulação ainda mais importante, não uma contraindicação.'),

('191de5c4-a11a-468a-9caa-9037b6f3244f', 'Fibrilação e Flutter', 2015, 'TEC', 'Mulher, 69 anos, diabética, infarto há 3 anos, FEVE 35%, palpitações taquicárdicas há 4h. PA 144x80, FC 143, estável, sem dor/síncope/dispneia. ECG mostra taquiarritmia. Sobre o tratamento, é CORRETO afirmar:', 'A paciente tem CHA2DS2-VASc elevado (idade, diabetes, cardiopatia estrutural) — a anticoagulação oral é mandatória independentemente da estratégia antiarrítmica escolhida (ritmo ou frequência).', 'A paciente é diabética, tem 69 anos e possui cardiopatia estrutural (infarto prévio e FE 35%), resultando em um escore CHA2DS2-VASc elevado (≥ 3). A anticoagulação é mandatória na fibrilação atrial quando o risco embólico é alto, independentemente de se optar pelo controle de ritmo ou frequência.

Por que as outras alternativas estão incorretas:
• B) A paciente está hemodinamicamente ESTÁVEL (PA 144x80), logo a cardioversão elétrica imediata não é a primeira conduta obrigatória.
• C) Propafenona (classe IC) é CONTRAINDICADA em cardiopatia estrutural (infarto prévio e disfunção ventricular), pelo risco de arritmias ventriculares graves.
• D) A ablação por cateter É uma opção estabelecida mesmo em disfunção ventricular, não estando contraindicada pelo risco do procedimento.
• E) A ivabradina NÃO tem eficácia no controle de frequência na FA (atua só em ritmo sinusal).'),

('8340a39e-836a-4935-9f84-e1eee34fc04e', 'Fibrilação e Flutter', 2025, 'TEC', 'Em relação à ablação por cateter da fibrilação atrial (FA), assinale a afirmativa correta:', 'A ablação por cateter pode ser considerada primeira linha em FA paroxística sintomática, mesmo antes de tentar tratamento medicamentoso, visando maior eficácia e melhor qualidade de vida.', 'As diretrizes atuais permitem que a ablação por cateter seja considerada como terapia de primeira linha para FA paroxística sintomática em pacientes selecionados, mesmo antes da tentativa de controle com fármacos antiarrítmicos, visando maior eficácia na manutenção do ritmo sinusal e melhora da qualidade de vida.

Por que as outras alternativas estão incorretas:
• B) A ablação tem se mostrado superior ao tratamento medicamentoso em diversos cenários, e não apenas após falha deste.
• C) O alvo fundamental da ablação na FA é o isolamento das veias PULMONARES, não das veias cavas.
• D) A ablação é, na verdade, opção terapêutica importante em pacientes com FA e IC com fração de ejeção reduzida, podendo melhorar a função ventricular.
• E) Idade avançada isolada não é contraindicação absoluta — a decisão é individualizada por risco-benefício, comorbidades e fragilidade, não apenas pelo critério cronológico de 80 anos.'),

('1282452d-bcf2-49c1-a883-c96714ffd390', 'Fibrilação e Flutter', 2025, 'TEC', 'Assinale a alternativa correta em relação aos efeitos adversos da amiodarona:', 'A amiodarona tem alto teor de iodo, podendo desencadear tanto hipotireoidismo (mais comum) quanto hipertireoidismo — por isso pode, sim, resultar em hipertireoidismo.', 'A amiodarona possui um alto conteúdo de iodo em sua estrutura química, o que pode interferir no metabolismo da glândula tireoide, podendo desencadear tanto hipotireoidismo (mais comum) quanto hipertireoidismo.

Por que as outras alternativas estão incorretas:
• B) A deposição corneana de amiodarona é achado muito frequente (microdepósitos), mas raramente causa sintomas visuais significativos e, na grande maioria dos casos, NÃO obriga a suspensão da medicação.
• C) A amiodarona PODE causar alterações cutâneas (fotossensibilidade, coloração azulada/acinzentada da pele) — a afirmação de que "não são relatadas" está incorreta.
• D) Embora prolongue o QTc, o risco clínico de Torsades de Pointes com amiodarona é considerado BAIXO comparado a outros antiarrítmicos de classe III (como o sotalol).
• E) A amiodarona é categoria D (evidência de risco fetal) na gestação, não C, e não é droga de primeira linha nesse contexto.'),

('6c4042b1-ca15-4cfb-b1fc-53be8c238eca', 'Fibrilação e Flutter', 2023, 'TEC', 'Em relação à ablação de fibrilação atrial, assinale a alternativa correta:', 'A anticoagulação após ablação de FA deve ser mantida por pelo menos 60 dias (2-3 meses), mesmo em pacientes com CHA2DS2-VASc de 0 ou 1, pelo risco de eventos tromboembólicos durante a cicatrização do átrio.', 'As diretrizes recomendam que, independentemente do escore CHA2DS2-VASc (mesmo naqueles com risco baixo, 0 ou 1), a anticoagulação oral deve ser mantida por pelo menos 2 a 3 meses (60 a 90 dias) após a ablação de fibrilação atrial, devido ao risco de eventos tromboembólicos no período de cicatrização do átrio esquerdo.

Por que as outras alternativas estão incorretas:
• A) A ablação PODE ser considerada primeira linha em pacientes selecionados, não dependendo exclusivamente da falha de antiarrítmicos de classe III.
• B) A ablação é opção importante mesmo em IC com FA permanente, podendo levar à melhora da função ventricular.
• D) A ablação NÃO substitui a anticoagulação em pacientes com indicação, pois não elimina totalmente o risco tromboembólico.
• E) A taxa de sucesso é geralmente SUPERIOR na FA paroxística do que na permanente/persistente de longa duração, não igual.'),

('629f3614-f5d6-4647-91bf-d6b359e046c8', 'Fibrilação e Flutter', 2014, 'TEC', 'Com relação ao manejo da fibrilação atrial (FA), é CORRETO afirmar que:', 'Na cardiomiopatia hipertrófica, o diagnóstico de FA já é marcador de alto risco tromboembólico — a anticoagulação oral é indicada diretamente e prontamente, independentemente do cálculo do CHA2DS2-VASc.', 'Na Cardiomiopatia Hipertrófica (CMH), o diagnóstico de Fibrilação Atrial (FA) é considerado um marcador de alto risco para fenômenos tromboembólicos. Por isso, a indicação de anticoagulação oral nesses pacientes é direta e deve ser iniciada prontamente, independentemente do cálculo do escore CHA2DS2-VASc.

Por que as outras alternativas estão incorretas:
• B) A ablação da via anômala na FA+WPW depende de critérios específicos de risco (não apenas "frequência rápida, síncope e período refratário longo" isoladamente formulados dessa forma genérica) — a formulação simplificada não capta os critérios reais de indicação.
• C) Pré-tratamento com digital ou verapamil NÃO demonstrou prevenir a FA pós-operatória de forma consistente.
• D) FA causando terapias inapropriadas de CDI é situação relevante, mas a formulação "quando outros métodos não obtiverem sucesso" não é a definição padrão de indicação primária.
• E) A eficácia da ablação de FA no longo prazo, embora boa, não é "comprovada" de forma absoluta e universal — há recorrências e a eficácia varia conforme o tipo de FA e substrato.'),

('3101c813-fba6-4663-a3e1-3f247ca924b0', 'Fibrilação e Flutter', 2014, 'TEC', 'Em relação à ação eletrofisiológica dos fármacos antiarrítmicos, assinale a alternativa CORRETA:', 'O sotalol (betabloqueador não seletivo com propriedades de classe III) prolonga mais o potencial de ação em frequências cardíacas baixas; e a propafenona bloqueia canais de sódio no miocárdio ventricular — ambas as afirmações (A e C) estão corretas.', 'O sotalol é um betabloqueador não seletivo (bloqueia receptores beta1 e beta2) que também possui propriedades de classe III (bloqueio de canais de potássio), prolongando o potencial de ação. Seu efeito de prolongamento do intervalo QT é mais pronunciado em frequências cardíacas mais baixas (fenômeno de dependência reversa do uso). A propafenona é um antiarrítmico de classe IC, que atua bloqueando os canais de sódio voltagem-dependentes, o que reduz a velocidade de condução tanto no miocárdio atrial quanto no ventricular.

Como tanto a afirmação A (sobre o sotalol) quanto a C (sobre a propafenona) estão corretas, a alternativa que reúne as duas é a resposta certa.

Por que as outras alternativas isoladas não bastam:
• B) A amiodarona tem ação sobre os potenciais de ação tanto atrial quanto ventricular, sem a especificidade de atuação "mais intensa" descrita — não é a mais precisa das opções.
• D) A lidocaína atua principalmente no tecido ventricular (canais de sódio), não reduzindo a automaticidade do nó sinusal como afirmado.');

insert into public.question_options (id, question_id, letra, texto, correta) values
(gen_random_uuid(), '147e5e2f-66a7-4b2e-a888-922294dc5a9d', 'a', 'Ablação de FA é menos eficaz em FA persistente ou de longa duração, em portadores de cardiomiopatia hipertrófica, na obesidade e na apneia do sono.', false),
(gen_random_uuid(), '147e5e2f-66a7-4b2e-a888-922294dc5a9d', 'b', 'Presença de focos extra veias pulmonares ocorrem mais frequentemente em formas persistentes de FA ou em paciente com remodelamento atrial.', false),
(gen_random_uuid(), '147e5e2f-66a7-4b2e-a888-922294dc5a9d', 'c', 'Fístula atrioesofágica é a complicação mais comum pós-ablação de fibrilação atrial, ocorrendo no final da primeira semana.', true),
(gen_random_uuid(), '147e5e2f-66a7-4b2e-a888-922294dc5a9d', 'd', 'Após ablação, é prudente manter anticoagulação em pacientes com maior risco (CHA2DS2VASC ≥ 2).', false),
(gen_random_uuid(), '147e5e2f-66a7-4b2e-a888-922294dc5a9d', 'e', 'Reconexão de veias pulmonares e presença de focos externos às veias pulmonares são fatores predominantes que justificam recorrência da FA pós-ablação.', false),

(gen_random_uuid(), '28239ad9-9b89-4a11-9064-b5ce45972c84', 'a', 'Por ter coração normal, não é necessária anticoagulação pré-, trans- ou pós-procedimento.', false),
(gen_random_uuid(), '28239ad9-9b89-4a11-9064-b5ce45972c84', 'b', 'Não há indicação para o procedimento, já que não foram testadas associações de fármacos.', false),
(gen_random_uuid(), '28239ad9-9b89-4a11-9064-b5ce45972c84', 'c', 'O sucesso do procedimento é de aproximadamente 70% sem uso de fármacos antiarrítmicos e mais de 80% com o uso posterior de fármacos.', true),
(gen_random_uuid(), '28239ad9-9b89-4a11-9064-b5ce45972c84', 'd', 'Em jovens, a taxa de complicações maiores é de 2%, sendo a fístula atrioesofágica a complicação mais comum.', false),
(gen_random_uuid(), '28239ad9-9b89-4a11-9064-b5ce45972c84', 'e', 'Neste caso, o procedimento consiste em isolamento de veias pulmonares e apêndice atrial esquerdo, associado com linhas no teto do átrio e veia pulmonar inferior esquerda-anel mitral.', false),

(gen_random_uuid(), '80dff5e9-2ef5-47cc-9eb1-2bb9765db184', 'a', 'A cardioversão elétrica realizada após um período de anticoagulação mínimo de duas semanas com qualquer um dos novos anticoagulantes orais e mantida por quatro semanas está prevista na diretriz brasileira de FA.', false),
(gen_random_uuid(), '80dff5e9-2ef5-47cc-9eb1-2bb9765db184', 'b', 'A ablação da junção atrioventricular está indicada apenas quando há sinais clínicos e ecocardiográficos de taquicardiomiopatia.', false),
(gen_random_uuid(), '80dff5e9-2ef5-47cc-9eb1-2bb9765db184', 'c', 'A oclusão percutânea do apêndice atrial esquerdo está indicada apenas para pacientes com fenômenos tromboembólicos e os anticoagulantes orais estão contraindicados.', false),
(gen_random_uuid(), '80dff5e9-2ef5-47cc-9eb1-2bb9765db184', 'd', 'A ablação por cateter está indicada para pacientes sintomáticos e refratários a pelo menos uma droga antiarrítmica, quando a estratégia de controle do ritmo é desejada.', true),
(gen_random_uuid(), '80dff5e9-2ef5-47cc-9eb1-2bb9765db184', 'e', 'A propafenona e os antagonistas de cálcio podem ser utilizados na presença de fibrilação atrial e pré-excitação ventricular.', false),

(gen_random_uuid(), '0e92749c-62c5-484f-9f10-332dc2fdcf7b', 'a', 'Caso sejam constatados sinais de insuficiência cardíaca descompensada, pode-se dar preferência à digoxina ou amiodarona intravenosa para controle da frequência cardíaca.', false),
(gen_random_uuid(), '0e92749c-62c5-484f-9f10-332dc2fdcf7b', 'b', 'O hipertireoidismo pode ser causa desta arritmia, considerando que é mais frequente em homens e idosos.', false),
(gen_random_uuid(), '0e92749c-62c5-484f-9f10-332dc2fdcf7b', 'c', 'Antes de administrar qualquer droga antiarrítmica é importante verificar a existência de distúrbios hidroeletrolíticos, os quais podem predispor ao risco de pró-arritmias.', false),
(gen_random_uuid(), '0e92749c-62c5-484f-9f10-332dc2fdcf7b', 'd', 'Na ausência de sinais de insuficiência cardíaca, o controle da frequência cardíaca pode ser feito com betabloqueadores ou bloqueadores dos canais de cálcio não diidropiridínicos.', false),
(gen_random_uuid(), '0e92749c-62c5-484f-9f10-332dc2fdcf7b', 'e', 'Caso sejam constatados sinais de insuficiência cardíaca descompensada, deve-se dar preferência à propafenona para reversão da arritmia.', true),

(gen_random_uuid(), '5b0cb8ae-af94-4981-ab59-7955bb2c063d', 'a', 'Atenolol.', false),
(gen_random_uuid(), '5b0cb8ae-af94-4981-ab59-7955bb2c063d', 'b', 'Propafenona.', false),
(gen_random_uuid(), '5b0cb8ae-af94-4981-ab59-7955bb2c063d', 'c', 'Sotalol.', false),
(gen_random_uuid(), '5b0cb8ae-af94-4981-ab59-7955bb2c063d', 'd', 'Amiodarona.', true),
(gen_random_uuid(), '5b0cb8ae-af94-4981-ab59-7955bb2c063d', 'e', 'Verapamil.', false),

(gen_random_uuid(), 'b6bb5826-2fa3-4e95-a8ef-959a0062f91b', 'a', 'Contraindicação para o uso crônico de anticoagulantes orais.', false),
(gen_random_uuid(), 'b6bb5826-2fa3-4e95-a8ef-959a0062f91b', 'b', 'Refratariedade a pelo menos fármaco antiarrítmico.', false),
(gen_random_uuid(), 'b6bb5826-2fa3-4e95-a8ef-959a0062f91b', 'c', 'Pode ser a primeira opção terapêutica para controle do ritmo.', true),
(gen_random_uuid(), 'b6bb5826-2fa3-4e95-a8ef-959a0062f91b', 'd', 'Desejo do paciente.', false),
(gen_random_uuid(), 'b6bb5826-2fa3-4e95-a8ef-959a0062f91b', 'e', 'Remodelamento atrial esquerdo ausente ou discreto.', false),

(gen_random_uuid(), '321d8b56-48a5-42d8-9eb9-b401cfefbc19', 'a', 'A amiodarona apresenta a mesma eficácia em relação ao betabloqueador no que diz respeito ao controle da resposta ventricular.', false),
(gen_random_uuid(), '321d8b56-48a5-42d8-9eb9-b401cfefbc19', 'b', 'A amiodarona aumenta o clearance renal de digoxina, sendo causa de má resposta a este medicamento.', false),
(gen_random_uuid(), '321d8b56-48a5-42d8-9eb9-b401cfefbc19', 'c', 'A dose de varfarina necessária para atingir INR terapêutico deve ser menor que a usual, devido à interação medicamentosa com a amiodarona.', true),
(gen_random_uuid(), '321d8b56-48a5-42d8-9eb9-b401cfefbc19', 'd', 'Devido ao bloqueio dos canais de potássio, a amiodarona leva à redução de frequência cardíaca e ao encurtamento do intervalo QT.', false),
(gen_random_uuid(), '321d8b56-48a5-42d8-9eb9-b401cfefbc19', 'e', 'A digoxina é eficaz para a redução da resposta ventricular tanto no repouso quanto no exercício.', false),

(gen_random_uuid(), '2c400475-5b6d-417c-9a83-46073538d65b', 'a', 'Ácido acetilsalicílico, 300 mg/dia, pelo risco intermediário de tromboembolismo.', false),
(gen_random_uuid(), '2c400475-5b6d-417c-9a83-46073538d65b', 'b', 'Varfarina ajustada conforme RNI.', true),
(gen_random_uuid(), '2c400475-5b6d-417c-9a83-46073538d65b', 'c', 'Sem necessidade de antitrombótico, por ter CHA2DS2-VASc de zero.', false),
(gen_random_uuid(), '2c400475-5b6d-417c-9a83-46073538d65b', 'd', 'Dabigatrana, 150 mg, 2x/dia.', false),
(gen_random_uuid(), '2c400475-5b6d-417c-9a83-46073538d65b', 'e', 'Apixabana, 5 mg, 12/12 horas.', false),

(gen_random_uuid(), 'f3bdca44-63f8-4438-a7ce-1bba46ea646b', 'a', 'Tem eliminação principalmente renal.', false),
(gen_random_uuid(), 'f3bdca44-63f8-4438-a7ce-1bba46ea646b', 'b', 'Após administração oral tem início de ação em uma a duas horas.', false),
(gen_random_uuid(), 'f3bdca44-63f8-4438-a7ce-1bba46ea646b', 'c', 'É eliminada em sua forma original, sem formação de metabólitos.', false),
(gen_random_uuid(), 'f3bdca44-63f8-4438-a7ce-1bba46ea646b', 'd', 'É altamente solúvel em lipídios, o que explica a distribuição extensa por todo o corpo e a deposição preferencial nos tecidos hepáticos, adiposo e pulmonar.', true),
(gen_random_uuid(), 'f3bdca44-63f8-4438-a7ce-1bba46ea646b', 'e', 'Após a interrupção, é totalmente eliminada em 7 dias.', false),

(gen_random_uuid(), '2b7b2beb-cf2f-49da-b53b-3486b4fac651', 'a', 'A arritmia deve ser mantida até que seja realizada a ablação com radiofrequência, que é o tratamento mais indicado.', true),
(gen_random_uuid(), '2b7b2beb-cf2f-49da-b53b-3486b4fac651', 'b', 'O tratamento farmacológico para a reversão costuma ser pouco eficaz, sendo que a cardioversão elétrica eletiva costuma ser indicada.', false),
(gen_random_uuid(), '2b7b2beb-cf2f-49da-b53b-3486b4fac651', 'c', 'A estratégia de prevenção de fenômenos embólicos deve ser a mesma aplicada a pacientes com fibrilação atrial.', false),
(gen_random_uuid(), '2b7b2beb-cf2f-49da-b53b-3486b4fac651', 'd', 'A ablação com radiofrequência tem excelentes resultados na prevenção de recorrências.', false),
(gen_random_uuid(), '2b7b2beb-cf2f-49da-b53b-3486b4fac651', 'e', 'O controle da frequência cardíaca pode ser obtido com betabloqueadores ou com bloqueadores dos canais de cálcio, como verapamil ou diltiazem.', false),

(gen_random_uuid(), '4191e590-a526-4698-9259-7801b9c24d28', 'a', 'Uso do metimazol para controle da tireoide antes de se iniciar o betabloqueador.', false),
(gen_random_uuid(), '4191e590-a526-4698-9259-7801b9c24d28', 'b', 'Uso do betabloqueador já de início, conjuntamente com o metimazol.', true),
(gen_random_uuid(), '4191e590-a526-4698-9259-7801b9c24d28', 'c', 'Uso de digoxina como primeira escolha para controlar a resposta ventricular.', false),
(gen_random_uuid(), '4191e590-a526-4698-9259-7801b9c24d28', 'd', 'Uso de iodo radioativo antes de se iniciar o betabloqueador.', false),
(gen_random_uuid(), '4191e590-a526-4698-9259-7801b9c24d28', 'e', 'Cardioversão elétrica.', false),

(gen_random_uuid(), 'e95076b4-ee98-477d-874e-9884d467a5b2', 'a', 'A ablação por cateter é recomendada para reversão da disfunção ventricular em pacientes com cardiomiopatia induzida por FA, independentemente da existência de sintomas.', true),
(gen_random_uuid(), 'e95076b4-ee98-477d-874e-9884d467a5b2', 'b', 'A ablação por cateter para tratamento da FA apresenta taxa de recidiva em um ano menor do que 1%, resultado semelhante à ablação do flutter atrial típico.', false),
(gen_random_uuid(), 'e95076b4-ee98-477d-874e-9884d467a5b2', 'c', 'O benefício da ablação por cateter é maior em pacientes com FA persistente do que paroxística, por não haver confirmação do sucesso do procedimento quando realizado em ritmo sinusal.', false),
(gen_random_uuid(), 'e95076b4-ee98-477d-874e-9884d467a5b2', 'd', 'A ausência de episódios de FA por 6 meses após nova tentativa de ablação é suficiente para suspensão da anticoagulação oral com segurança deste paciente.', false),
(gen_random_uuid(), 'e95076b4-ee98-477d-874e-9884d467a5b2', 'e', 'Quanto maior o tempo de duração da FA, maior a chance de sucesso com o procedimento, pela maior especificidade diagnóstica.', false),

(gen_random_uuid(), '858b7cd9-7e96-4717-9a37-869b589e9d1a', 'a', 'A varfarina deve ser utilizada em doses maiores em pacientes com idade superior a 65 anos devido ao maior risco de tromboembolismo nessa faixa etária.', false),
(gen_random_uuid(), '858b7cd9-7e96-4717-9a37-869b589e9d1a', 'b', 'Os novos anticoagulantes orais rivaroxabana e dabigatrana agem reduzindo a síntese de fatores de coagulação não dependentes de vitamina K.', false),
(gen_random_uuid(), '858b7cd9-7e96-4717-9a37-869b589e9d1a', 'c', 'Os novos anticoagulantes orais são contraindicados em pacientes portadores de prótese valvar metálica.', true),
(gen_random_uuid(), '858b7cd9-7e96-4717-9a37-869b589e9d1a', 'd', 'A apixabana teve taxa de sangramento igual à da varfarina nos estudos randomizados, sendo sua principal vantagem a conveniência de não necessitar de ajuste de dose com base em exames laboratoriais.', false),
(gen_random_uuid(), '858b7cd9-7e96-4717-9a37-869b589e9d1a', 'e', 'A dabigatrana age bloqueando o fator Xa e pode ser utilizada em pacientes portadores de FA valvar e não valvar.', false),

(gen_random_uuid(), '434df373-ffb9-49d7-ad5d-8befce237f56', 'a', 'Amiodarona venosa.', false),
(gen_random_uuid(), '434df373-ffb9-49d7-ad5d-8befce237f56', 'b', 'Adenosina venosa.', false),
(gen_random_uuid(), '434df373-ffb9-49d7-ad5d-8befce237f56', 'c', 'Lidocaína venosa.', false),
(gen_random_uuid(), '434df373-ffb9-49d7-ad5d-8befce237f56', 'd', 'Betabloqueador venoso.', true),
(gen_random_uuid(), '434df373-ffb9-49d7-ad5d-8befce237f56', 'e', 'Propafenona oral.', false),

(gen_random_uuid(), '39431eeb-d4a3-4326-8cb8-250fc7b86211', 'a', 'Inibidores da trombina ou antifator Xa oral.', false),
(gen_random_uuid(), '39431eeb-d4a3-4326-8cb8-250fc7b86211', 'b', 'Varfarina para INR entre 2 e 3 + clopidogrel, 75 mg/d.', false),
(gen_random_uuid(), '39431eeb-d4a3-4326-8cb8-250fc7b86211', 'c', 'Varfarina para INR entre 2,5 e 3,5.', true),
(gen_random_uuid(), '39431eeb-d4a3-4326-8cb8-250fc7b86211', 'd', 'Ácido acetilsalicílico, 100 mg/d + clopidogrel, 75 mg/d.', false),
(gen_random_uuid(), '39431eeb-d4a3-4326-8cb8-250fc7b86211', 'e', 'Varfarina para INR em torno de 2 + ácido acetilsalicílico, 100 mg/d.', false),

(gen_random_uuid(), 'c20d2da3-a1bb-4cf2-9557-cbaf00629a9b', 'a', 'Iniciar tratamento com propafenona.', true),
(gen_random_uuid(), 'c20d2da3-a1bb-4cf2-9557-cbaf00629a9b', 'b', 'Aumentar a dose do succinato de metoprolol.', false),
(gen_random_uuid(), 'c20d2da3-a1bb-4cf2-9557-cbaf00629a9b', 'c', 'Indicar ablação por cateter para fibrilação atrial.', false),
(gen_random_uuid(), 'c20d2da3-a1bb-4cf2-9557-cbaf00629a9b', 'd', 'Iniciar tratamento com amiodarona.', false),
(gen_random_uuid(), 'c20d2da3-a1bb-4cf2-9557-cbaf00629a9b', 'e', 'Indicar estudo eletrofisiológico para melhor conhecimento da arritmia.', false),

(gen_random_uuid(), 'cfbf53a3-bf2d-405c-b38d-2d7aed44b082', 'a', 'A cardioversão elétrica imediata é a conduta inicial de escolha para redução do risco de complicações em pacientes estáveis hemodinamicamente.', false),
(gen_random_uuid(), 'cfbf53a3-bf2d-405c-b38d-2d7aed44b082', 'b', 'O maior risco de ocorrência da FA é no segundo dia do pós-operatório, ocorrendo em 25% a 40% dos pacientes.', true),
(gen_random_uuid(), 'cfbf53a3-bf2d-405c-b38d-2d7aed44b082', 'c', 'O tratamento para manutenção do ritmo com amiodarona deve ser mantido entre três a seis meses após a alta hospitalar, pelo alto risco de recorrência da FA.', false),
(gen_random_uuid(), 'cfbf53a3-bf2d-405c-b38d-2d7aed44b082', 'd', 'Pacientes submetidos à cirurgia com o auxílio de circulação extracorpórea (CEC) têm menor risco de desenvolver FA do que aqueles operados sem CEC.', false),
(gen_random_uuid(), 'cfbf53a3-bf2d-405c-b38d-2d7aed44b082', 'e', 'Por ser habitualmente de resolução espontânea, a FA no pós-operatório não aumenta o risco de complicações tromboembólicas.', false),

(gen_random_uuid(), '987751d7-40b6-423e-903a-596c4871a36a', 'a', 'Sotalol.', false),
(gen_random_uuid(), '987751d7-40b6-423e-903a-596c4871a36a', 'b', 'Digoxina.', false),
(gen_random_uuid(), '987751d7-40b6-423e-903a-596c4871a36a', 'c', 'Amiodarona.', true),
(gen_random_uuid(), '987751d7-40b6-423e-903a-596c4871a36a', 'd', 'Propafenona.', false),
(gen_random_uuid(), '987751d7-40b6-423e-903a-596c4871a36a', 'e', 'Dronedarona.', false),

(gen_random_uuid(), '8a24948e-c214-4f85-9258-823b27ebe3a3', 'a', 'O uso de antiagregantes plaquetários mais modernos tais como prasugrel e ticagrelor é preferível diante do menor risco de sangramento que tais medicações proporcionam.', false),
(gen_random_uuid(), '8a24948e-c214-4f85-9258-823b27ebe3a3', 'b', 'O uso de varfarina é contraindicado neste caso diante do maior risco de sangramento.', false),
(gen_random_uuid(), '8a24948e-c214-4f85-9258-823b27ebe3a3', 'c', 'Em pacientes com alto risco de sangramento, a anticoagulação deve ser substituída por dupla terapia antiplaquetária no período subsequente à intervenção coronariana percutânea.', false),
(gen_random_uuid(), '8a24948e-c214-4f85-9258-823b27ebe3a3', 'd', 'Nos pacientes com alto risco de sangramento e menor risco isquêmico, o uso de clopidogrel associado com anticoagulante oral direto (DOAC) pode ser considerado desde o início do tratamento.', true),
(gen_random_uuid(), '8a24948e-c214-4f85-9258-823b27ebe3a3', 'e', 'O uso de tripla terapia antitrombótica é seguro e deve ser mantido por um ano após a intervenção coronariana percutânea em pacientes com risco isquêmico baixo.', false),

(gen_random_uuid(), '913dbac7-d0a6-493d-a8a0-918a7261f446', 'a', 'Em fibrilação atrial, o escore CHA2DS2VASC deve ser utilizado. Em pacientes com eventos tromboembólicos sistêmicos ou próteses valvares mecânicas, a anticoagulação deve ser mantida independentemente de qualquer avaliação. O risco de sangramento deve ser acessado pelo escore HAS-BLED.', true),
(gen_random_uuid(), '913dbac7-d0a6-493d-a8a0-918a7261f446', 'b', 'Escore HAS-BLED maior ou igual a 3 pontos é de alto risco para sangramento e deve contraindicar anticoagulação.', false),
(gen_random_uuid(), '913dbac7-d0a6-493d-a8a0-918a7261f446', 'c', 'Em pacientes que realizaram cardioversão elétrica por fibrilação atrial e possuem risco hemorrágico elevado, a profilaxia pós-cardioversão pode ser reduzida para apenas duas semanas.', false),
(gen_random_uuid(), '913dbac7-d0a6-493d-a8a0-918a7261f446', 'd', 'Flutter atrial. Pelo menor risco embólico, pode ser tratado com INR em faixa terapêutica de 1,5 a 2,0.', false),
(gen_random_uuid(), '913dbac7-d0a6-493d-a8a0-918a7261f446', 'e', 'Idade maior que 75 anos conta 2 pontos no escore HAS-BLED para risco de sangramento.', false),

(gen_random_uuid(), '6ea0cdda-8bd2-4522-8a57-8b4ea400036f', 'a', 'Controle da frequência cardíaca e anticoagulação oral com varfarina.', true),
(gen_random_uuid(), '6ea0cdda-8bd2-4522-8a57-8b4ea400036f', 'b', 'Controle da frequência cardíaca e cardioversão elétrica.', false),
(gen_random_uuid(), '6ea0cdda-8bd2-4522-8a57-8b4ea400036f', 'c', 'Controle da frequência cardíaca e estudo eletrofisiológico.', false),
(gen_random_uuid(), '6ea0cdda-8bd2-4522-8a57-8b4ea400036f', 'd', 'Controle da frequência cardíaca e anticoagulação oral com dabigatrana.', false),
(gen_random_uuid(), '6ea0cdda-8bd2-4522-8a57-8b4ea400036f', 'e', 'Controle da frequência cardíaca, internação, anticoagulação plena com heparina de baixo peso molecular e introdução de dabigatrana.', false),

(gen_random_uuid(), 'ceb6857d-684e-4f8a-b157-c696ddb8a871', 'a', 'Suspender ambas as medicações.', true),
(gen_random_uuid(), 'ceb6857d-684e-4f8a-b157-c696ddb8a871', 'b', 'Suspender amiodarona e manter anticoagulação.', false),
(gen_random_uuid(), 'ceb6857d-684e-4f8a-b157-c696ddb8a871', 'c', 'Suspender anticoagulação e trocar amiodarona por propafenona.', false),
(gen_random_uuid(), 'ceb6857d-684e-4f8a-b157-c696ddb8a871', 'd', 'Trocar amiodarona por atenolol e manter anticoagulação.', false),
(gen_random_uuid(), 'ceb6857d-684e-4f8a-b157-c696ddb8a871', 'e', 'Manter anticoagulação e trocar amiodarona por propafenona.', false),

(gen_random_uuid(), 'bd1f7329-4277-4267-9250-74eba8bdf11e', 'a', 'Adenosina é o tratamento preferencial, visto que não tem contraindicação na gravidez; e enoxaparina em dose plena para a prevenção do tromboembolismo.', false),
(gen_random_uuid(), 'bd1f7329-4277-4267-9250-74eba8bdf11e', 'b', 'Amiodarona intravenosa em bolo para a reversão do ritmo; ecotransesofágico para exclusão de trombo intracavitário; e aspirina para a prevenção do tromboembolismo.', false),
(gen_random_uuid(), 'bd1f7329-4277-4267-9250-74eba8bdf11e', 'c', 'Atenolol associado a verapamil para o controle da frequência cardíaca; e varfarina sódica para a prevenção do tromboembolismo.', false),
(gen_random_uuid(), 'bd1f7329-4277-4267-9250-74eba8bdf11e', 'd', 'Enoxaparina em dose plena para a prevenção de tromboembolismo; ecotransesofágico para a exclusão de trombo intracavitário e avaliação do estado funcional da prótese; e a cardioversão elétrica para reversão do ritmo, porque geralmente não é nociva para o feto.', true),
(gen_random_uuid(), 'bd1f7329-4277-4267-9250-74eba8bdf11e', 'e', 'Propafenona para o controle da frequência cardíaca; enoxaparina em dose profilática para a prevenção do tromboembolismo; e ultrassonografia de abdome para avaliar vitalidade fetal.', false),

(gen_random_uuid(), '00eceba8-0519-483d-bf9d-fff4c53fc841', 'a', 'Sotalol para evitar recorrência da arritmia.', false),
(gen_random_uuid(), '00eceba8-0519-483d-bf9d-fff4c53fc841', 'b', 'Amiodarona para evitar recorrência da arritmia.', false),
(gen_random_uuid(), '00eceba8-0519-483d-bf9d-fff4c53fc841', 'c', 'Diltiazem para o controle da resposta ventricular.', false),
(gen_random_uuid(), '00eceba8-0519-483d-bf9d-fff4c53fc841', 'd', 'Propafenona em pacientes com disfunção ventricular esquerda.', true),
(gen_random_uuid(), '00eceba8-0519-483d-bf9d-fff4c53fc841', 'e', 'Associação de betabloqueadores com digoxina para o controle da resposta ventricular.', false),

(gen_random_uuid(), '8a73aa14-db87-4ce5-8a4a-fabd379a6a6f', 'a', 'A morfologia das ondas F ao ECG é frequentemente variável, o que resulta em intervalo R-R muito irregular.', false),
(gen_random_uuid(), '8a73aa14-db87-4ce5-8a4a-fabd379a6a6f', 'b', 'A condução 1:1 nesse tipo de arritmia é muito frequente e pode levar à instabilidade hemodinâmica.', false),
(gen_random_uuid(), '8a73aa14-db87-4ce5-8a4a-fabd379a6a6f', 'c', 'Trata-se de circuito de macroreentrada em átrio direito.', true),
(gen_random_uuid(), '8a73aa14-db87-4ce5-8a4a-fabd379a6a6f', 'd', 'Uma vez que há histórico de intervenção em átrio esquerdo, a arritmia apresentada é um flutter atípico (flutter do átrio esquerdo).', false),
(gen_random_uuid(), '8a73aa14-db87-4ce5-8a4a-fabd379a6a6f', 'e', 'O tratamento com ablação por radiofrequência é útil porém com baixa taxa de sucesso, pela presença de cardiopatia estrutural.', false),

(gen_random_uuid(), '060fa95b-15b8-495d-9a3a-994255dc8fe2', 'a', 'Bisoprolol.', false),
(gen_random_uuid(), '060fa95b-15b8-495d-9a3a-994255dc8fe2', 'b', 'Verapamil.', false),
(gen_random_uuid(), '060fa95b-15b8-495d-9a3a-994255dc8fe2', 'c', 'Trimetazidina.', false),
(gen_random_uuid(), '060fa95b-15b8-495d-9a3a-994255dc8fe2', 'd', 'Atenolol.', false),
(gen_random_uuid(), '060fa95b-15b8-495d-9a3a-994255dc8fe2', 'e', 'Ivabradina.', true),

(gen_random_uuid(), '8bacc543-4fb7-4af7-8bdd-ec7d05bff98c', 'a', 'ECG sugestivo de fibrilação ventricular, devendo o paciente ser desfibrilado imediatamente e submetido a implante de CDI.', false),
(gen_random_uuid(), '8bacc543-4fb7-4af7-8bdd-ec7d05bff98c', 'b', 'ECG de taquicardia ventricular polimórfica catecolaminérgica. Betabloqueador intravenoso está indicado para controle de arritmias.', false),
(gen_random_uuid(), '8bacc543-4fb7-4af7-8bdd-ec7d05bff98c', 'c', 'ECG de taquicardia ventricular polimórfica relacionada à síndrome coronariana aguda. O paciente deve ser cardiovertido e encaminhado à hemodinâmica.', false),
(gen_random_uuid(), '8bacc543-4fb7-4af7-8bdd-ec7d05bff98c', 'd', 'ECG de fibrilação atrial, em paciente com via acessória atrioventricular (AV) apresentando alto risco de morte súbita. Deve ser cardiovertido e encaminhado para ablação por cateter da via acessória.', true),
(gen_random_uuid(), '8bacc543-4fb7-4af7-8bdd-ec7d05bff98c', 'e', 'ECG de fibrilação atrial de alta resposta e bloqueio de ramo esquerdo. Paciente deve ser cardiovertido e encaminhado à ablação de FA.', false),

(gen_random_uuid(), '4a5b36a0-b03c-4165-9793-03d08cedda66', 'a', 'Interromper a gestação.', false),
(gen_random_uuid(), '4a5b36a0-b03c-4165-9793-03d08cedda66', 'b', 'Cardioversão elétrica imediata.', false),
(gen_random_uuid(), '4a5b36a0-b03c-4165-9793-03d08cedda66', 'c', 'Ablação das veias pulmonares.', false),
(gen_random_uuid(), '4a5b36a0-b03c-4165-9793-03d08cedda66', 'd', 'Tentar cardioversão farmacológica com amiodarona venosa.', false),
(gen_random_uuid(), '4a5b36a0-b03c-4165-9793-03d08cedda66', 'e', 'Controlar a frequência cardíaca com digoxina, betabloqueador ou bloqueador dos canais de cálcio.', true),

(gen_random_uuid(), 'e45e3bfd-d75f-4dc7-abdb-c117912e1765', 'a', 'Hipomagnesemia é etiologia comum, e a administração de magnésio nos períodos pré, pós e perioperatório diminui sua incidência.', true),
(gen_random_uuid(), 'e45e3bfd-d75f-4dc7-abdb-c117912e1765', 'b', 'Administração de hidrocortisona não diminui sua incidência.', false),
(gen_random_uuid(), 'e45e3bfd-d75f-4dc7-abdb-c117912e1765', 'c', 'Administração de betabloqueadores é mais efetiva que administração de amiodarona para a prevenção.', false),
(gen_random_uuid(), 'e45e3bfd-d75f-4dc7-abdb-c117912e1765', 'd', 'Atorvastatina não mostrou diminuição de sua incidência.', false),
(gen_random_uuid(), 'e45e3bfd-d75f-4dc7-abdb-c117912e1765', 'e', 'Colchicina não mostrou efetividade na diminuição de sua incidência.', false),

(gen_random_uuid(), '673ea280-bb4f-469f-a2e1-e3cc876eed70', 'a', 'Sotalol, via oral, é o fármaco de escolha para evitar recorrências em pacientes com insuficiência cardíaca congestiva.', false),
(gen_random_uuid(), '673ea280-bb4f-469f-a2e1-e3cc876eed70', 'b', 'Amiodarona intravenosa em bolo está indicada na cardioversão da fibrilação atrial com instabilidade hemodinâmica.', false),
(gen_random_uuid(), '673ea280-bb4f-469f-a2e1-e3cc876eed70', 'c', 'O uso de digoxina para controle da frequência ventricular apresenta piores resultados em idosos e sedentários.', false),
(gen_random_uuid(), '673ea280-bb4f-469f-a2e1-e3cc876eed70', 'd', 'Verapamil e diltiazem apresentam bons resultados no controle da frequência ventricular, inclusive com melhora da qualidade de vida.', true),
(gen_random_uuid(), '673ea280-bb4f-469f-a2e1-e3cc876eed70', 'e', 'Para a reversão de fibrilação atrial aguda em pacientes com insuficiência cardíaca, a propafenona via oral deve ser usada na dose única de 450 mg.', false),

(gen_random_uuid(), 'f5630002-333b-410d-911e-78fd3baf145d', 'a', 'Rivaroxabana 20 mg/dia.', false),
(gen_random_uuid(), 'f5630002-333b-410d-911e-78fd3baf145d', 'b', 'Apixabana 2,5 mg, de 12 em 12 horas.', false),
(gen_random_uuid(), 'f5630002-333b-410d-911e-78fd3baf145d', 'c', 'Edoxabana 30 mg/dia.', true),
(gen_random_uuid(), 'f5630002-333b-410d-911e-78fd3baf145d', 'd', 'Varfarina com objetivo de manter INR entre 2,5 e 3,5.', false),
(gen_random_uuid(), 'f5630002-333b-410d-911e-78fd3baf145d', 'e', 'Paciente não apresenta indicação de anticoagulação oral.', false),

(gen_random_uuid(), 'f74a09b4-1dd5-40c2-98ef-117a51713372', 'a', 'Cimetidina, digoxina, barbiturato e carbamazepina.', false),
(gen_random_uuid(), 'f74a09b4-1dd5-40c2-98ef-117a51713372', 'b', 'Amiodarona, cimetidina, fluconazol e metronidazol.', true),
(gen_random_uuid(), 'f74a09b4-1dd5-40c2-98ef-117a51713372', 'c', 'Ciprofloxacino, amiodarona, carbamazepina e indometacina.', false),
(gen_random_uuid(), 'f74a09b4-1dd5-40c2-98ef-117a51713372', 'd', 'Rifampicina, amiodarona, cimetidina e sulfametoxazol.', false),
(gen_random_uuid(), 'f74a09b4-1dd5-40c2-98ef-117a51713372', 'e', 'Quinidina, amiodarona, digoxina e rifampicina.', false),

(gen_random_uuid(), '0301c484-82ce-4bc8-bd4a-b19488ef43ad', 'a', 'Reduzir dose da edoxabana para 30 mg, pela idade superior a 75 anos.', false),
(gen_random_uuid(), '0301c484-82ce-4bc8-bd4a-b19488ef43ad', 'b', 'Manter tratamento.', true),
(gen_random_uuid(), '0301c484-82ce-4bc8-bd4a-b19488ef43ad', 'c', 'Suspender anticoagulação por não ter indicação.', false),
(gen_random_uuid(), '0301c484-82ce-4bc8-bd4a-b19488ef43ad', 'd', 'Usar HASBLED para avaliar risco hemorrágico e suspender apenas se HASBLED elevado.', false),
(gen_random_uuid(), '0301c484-82ce-4bc8-bd4a-b19488ef43ad', 'e', 'Trocar edoxabana por dabigatrana, 150 mg, 2x/dia.', false),

(gen_random_uuid(), 'de0e4d80-4c9c-408c-9c2b-da1ba658ce00', 'a', 'Não deve ser iniciada, pois o risco de complicações hemorrágicas, nestes casos, é maior do que o risco de acidente vascular encefálico (AVE).', false),
(gen_random_uuid(), 'de0e4d80-4c9c-408c-9c2b-da1ba658ce00', 'b', 'Deve ser iniciada apenas 24 horas após a retirada do último dreno, como ocorre com qualquer paciente submetido a cirurgias cardíacas.', false),
(gen_random_uuid(), 'de0e4d80-4c9c-408c-9c2b-da1ba658ce00', 'c', 'Somente deverá ser iniciada após um período de sete dias com AAS de 100 mg/dia, caso não haja complicações hemorrágicas.', false),
(gen_random_uuid(), 'de0e4d80-4c9c-408c-9c2b-da1ba658ce00', 'd', 'Somente está indicada em pacientes com história prévia de AVE.', false),
(gen_random_uuid(), 'de0e4d80-4c9c-408c-9c2b-da1ba658ce00', 'e', 'Está indicada, devido ao alto risco de AVE.', true),

(gen_random_uuid(), '67c76566-ac1b-4e52-91a6-f3d0b24db87f', 'a', 'Ácido úrico > 8 mg/dL.', false),
(gen_random_uuid(), '67c76566-ac1b-4e52-91a6-f3d0b24db87f', 'b', 'Intervalo QT > 500 ms.', true),
(gen_random_uuid(), '67c76566-ac1b-4e52-91a6-f3d0b24db87f', 'c', 'Aumento de transaminases hepáticas.', false),
(gen_random_uuid(), '67c76566-ac1b-4e52-91a6-f3d0b24db87f', 'd', 'Disfunção ventricular leve ao ecocardiograma.', false),
(gen_random_uuid(), '67c76566-ac1b-4e52-91a6-f3d0b24db87f', 'e', 'Controle da frequência cardíaca com digoxina, betabloqueador ou bloqueador dos canais de cálcio.', false),

(gen_random_uuid(), '54e352a6-91e7-4d15-96b4-45efe0d94c13', 'a', 'Cardioversão elétrica.', true),
(gen_random_uuid(), '54e352a6-91e7-4d15-96b4-45efe0d94c13', 'b', 'Betabloqueador por via oral.', false),
(gen_random_uuid(), '54e352a6-91e7-4d15-96b4-45efe0d94c13', 'c', 'Estimulação cardíaca artificial.', false),
(gen_random_uuid(), '54e352a6-91e7-4d15-96b4-45efe0d94c13', 'd', 'Amiodarona por via endovenosa.', false),
(gen_random_uuid(), '54e352a6-91e7-4d15-96b4-45efe0d94c13', 'e', 'Interrupção do circuito com adenosina.', false),

(gen_random_uuid(), 'ada6b5fe-2ff7-4a8a-a181-2008a41024fd', 'a', 'A ação dos betabloqueadores seletivos dos receptores beta 1 é perdida com o aumento da dose.', false),
(gen_random_uuid(), 'ada6b5fe-2ff7-4a8a-a181-2008a41024fd', 'b', 'Os betabloqueadores não seletivos têm atuação de bloqueio dos receptores β1 e β2 já em baixas doses.', false),
(gen_random_uuid(), 'ada6b5fe-2ff7-4a8a-a181-2008a41024fd', 'c', 'Os betabloqueadores cardiosseletivos são propranolol, metoprolol e atenolol.', true),
(gen_random_uuid(), 'ada6b5fe-2ff7-4a8a-a181-2008a41024fd', 'd', 'O carvedilol tem ação vasodilatadora em decorrência do bloqueio dos alfa-receptores periféricos.', false),
(gen_random_uuid(), 'ada6b5fe-2ff7-4a8a-a181-2008a41024fd', 'e', 'A ação anti-hipertensiva envolve a redução do débito cardíaco (bloqueio β1-R) e a redução da liberação da renina (bloqueio β1-R).', false),

(gen_random_uuid(), '43fa0de1-344b-4968-999b-fff600890397', 'a', 'Crise hipertensiva; pró-arritmia; tremor de mãos; pneumonite.', false),
(gen_random_uuid(), '43fa0de1-344b-4968-999b-fff600890397', 'b', 'Constipação intestinal; piora da função ventricular; Torsades de pointes; ataxia.', true),
(gen_random_uuid(), '43fa0de1-344b-4968-999b-fff600890397', 'c', 'Agranulocitose; disfunção renal; crise asmática; hipo ou hipertireoidismo.', false),
(gen_random_uuid(), '43fa0de1-344b-4968-999b-fff600890397', 'd', 'Cefaleia; rash cutâneo; visão borrada; cirrose hepática.', false),
(gen_random_uuid(), '43fa0de1-344b-4968-999b-fff600890397', 'e', 'Dissociação atrioventricular; epididimite; fadiga; gosto metálico.', false),

(gen_random_uuid(), '3a47c1af-2204-432f-a60c-40c34a161e0d', 'a', 'Furosemida', false),
(gen_random_uuid(), '3a47c1af-2204-432f-a60c-40c34a161e0d', 'b', 'Inibidor de enzima conversora da angiotensina.', false),
(gen_random_uuid(), '3a47c1af-2204-432f-a60c-40c34a161e0d', 'c', 'Digoxina.', false),
(gen_random_uuid(), '3a47c1af-2204-432f-a60c-40c34a161e0d', 'd', 'Betabloqueador (metoprolol ou bisoprolol ou carvedilol).', false),
(gen_random_uuid(), '3a47c1af-2204-432f-a60c-40c34a161e0d', 'e', 'Ivabradina.', true),

(gen_random_uuid(), 'df12ddcf-6a9a-43a8-94c6-3d9a127e953c', 'a', 'Grandes ensaios clínicos mostraram que os novos anticoagulantes orais (dabigatran, rivaroxaban e apixaban) reduzem as taxas de AVE hemorrágico ao serem comparados aos antagonistas da vitamina K.', true),
(gen_random_uuid(), 'df12ddcf-6a9a-43a8-94c6-3d9a127e953c', 'b', 'A anticoagulação plena só é indicada nas formas persistente e permanente da fibrilação ou flutter atrial típico.', false),
(gen_random_uuid(), 'df12ddcf-6a9a-43a8-94c6-3d9a127e953c', 'c', 'O escore de CHA2DS2-VASc é usado para avaliar risco tromboembólico, sendo indicada anticoagulação com escores acima de 3 pontos.', false),
(gen_random_uuid(), 'df12ddcf-6a9a-43a8-94c6-3d9a127e953c', 'd', 'O anticoagulante de preferência em pacientes com prótese valvar mecânica aórtica é o dabigatran.', false),
(gen_random_uuid(), 'df12ddcf-6a9a-43a8-94c6-3d9a127e953c', 'e', 'Pacientes com mais de 80 anos e que já tiveram AVE isquêmico prévio não devem ser anticoagulados, devido ao alto risco de sangramento intracerebral.', false),

(gen_random_uuid(), '191de5c4-a11a-468a-9caa-9037b6f3244f', 'a', 'Independentemente da conduta antiarrítmica escolhida, esta paciente possui indicação de anticoagulação oral para a prevenção de fenômenos cardioembólicos.', true),
(gen_random_uuid(), '191de5c4-a11a-468a-9caa-9037b6f3244f', 'b', 'O tratamento imediato desta paciente é a cardioversão elétrica, de modo a evitar a possibilidade de instabilidade hemodinâmica.', false),
(gen_random_uuid(), '191de5c4-a11a-468a-9caa-9037b6f3244f', 'c', 'Propafenona, antiarrítmico da classe IC, é uma das medicações possíveis a ser utilizada para a reversão farmacológica do ritmo desta paciente.', false),
(gen_random_uuid(), '191de5c4-a11a-468a-9caa-9037b6f3244f', 'd', 'Ablação por cateter de radiofrequência não é uma opção para esta paciente, caso ela se torne refratária às medicações para controle de ritmo, devido ao alto risco do procedimento.', false),
(gen_random_uuid(), '191de5c4-a11a-468a-9caa-9037b6f3244f', 'e', 'Caso seja optado por controle da frequência cardíaca, podem ser utilizadas: betabloqueador, inibidor dos canais de cálcio não di-idropiridínico, digoxina e ivabradina.', false),

(gen_random_uuid(), '8340a39e-836a-4935-9f84-e1eee34fc04e', 'a', 'Pode ser considerada primeira linha em FA paroxística sintomática, mesmo para pacientes que ainda não recebem tratamento medicamentoso.', true),
(gen_random_uuid(), '8340a39e-836a-4935-9f84-e1eee34fc04e', 'b', 'O tratamento com antiarrítmicos é superior em todos os casos, mas quando há falha está indicado tratamento adjuvante com ablação.', false),
(gen_random_uuid(), '8340a39e-836a-4935-9f84-e1eee34fc04e', 'c', 'O alvo da ablação é o isolamento elétrico das veias pulmonares e das veias cavas.', false),
(gen_random_uuid(), '8340a39e-836a-4935-9f84-e1eee34fc04e', 'd', 'Pode ser útil em casos selecionados mas não é indicada para pacientes com insuficiência cardíaca e fração de ejeção do ventrículo esquerdo reduzida.', false),
(gen_random_uuid(), '8340a39e-836a-4935-9f84-e1eee34fc04e', 'e', 'É contraindicada para pacientes com idade superior a 80 anos por estar relacionada a aumento de morbimortalidade.', false),

(gen_random_uuid(), '1282452d-bcf2-49c1-a883-c96714ffd390', 'a', 'Pode resultar em hipertireoidismo.', true),
(gen_random_uuid(), '1282452d-bcf2-49c1-a883-c96714ffd390', 'b', 'Corpos na córnea ("deposição corneal") são permanentes e obrigam a suspensão do tratamento.', false),
(gen_random_uuid(), '1282452d-bcf2-49c1-a883-c96714ffd390', 'c', 'Tem amplo espectro de efeitos colaterais, mas não são relatadas alterações cutâneas.', false),
(gen_random_uuid(), '1282452d-bcf2-49c1-a883-c96714ffd390', 'd', 'Pelo prolongamento do intervalo QTc, o risco de Torsades de Pointes é alto.', false),
(gen_random_uuid(), '1282452d-bcf2-49c1-a883-c96714ffd390', 'e', 'É categoria C para uso na gestação e é frequente o uso no tratamento de arritmias fetais.', false),

(gen_random_uuid(), '6c4042b1-ca15-4cfb-b1fc-53be8c238eca', 'a', 'Ablação de fibrilação atrial só deve ser indicada após falha do controle do ritmo com antiarrítmicos de classe III.', false),
(gen_random_uuid(), '6c4042b1-ca15-4cfb-b1fc-53be8c238eca', 'b', 'A ablação de fibrilação atrial não deve ser indicada para pacientes com insuficiência cardíaca e fibrilação atrial permanente.', false),
(gen_random_uuid(), '6c4042b1-ca15-4cfb-b1fc-53be8c238eca', 'c', 'Anticoagulação após ablação de fibrilação atrial deve ser mantida por pelo menos 60 dias após o procedimento, mesmo em pacientes com CHADS-VASC = 0 ou 1.', true),
(gen_random_uuid(), '6c4042b1-ca15-4cfb-b1fc-53be8c238eca', 'd', 'A ablação de fibrilação atrial pode ser indicada para aqueles pacientes que não podem realizar anticoagulação, objetivando diminuição de eventos tromboembólicos.', false),
(gen_random_uuid(), '6c4042b1-ca15-4cfb-b1fc-53be8c238eca', 'e', 'A ablação de fibrilação atrial tem a mesma chance de sucesso em pacientes com fibrilação atrial paroxística e permanente.', false),

(gen_random_uuid(), '629f3614-f5d6-4647-91bf-d6b359e046c8', 'a', 'A anticoagulação oral está indicada para todos os pacientes com cardiomiopatia hipertrófica e FA que persiste por mais de 48 horas, por conta do alto risco de AVE isquêmico ou tromboembolismo sistêmico.', true),
(gen_random_uuid(), '629f3614-f5d6-4647-91bf-d6b359e046c8', 'b', 'Na presença de FA e síndrome de Wolff-Parkinson-White, a ablação por cateter da via anômala está indicada em pacientes com frequência cardíaca rápida, síncope e período refratário efetivo longo da via acessória.', false),
(gen_random_uuid(), '629f3614-f5d6-4647-91bf-d6b359e046c8', 'c', 'O pré-tratamento com digital ou verapamil é capaz de prevenir a FA pós-operatória.', false),
(gen_random_uuid(), '629f3614-f5d6-4647-91bf-d6b359e046c8', 'd', 'A FA gerando terapias inapropriadas do cardioversor-desfibrilador implantável é indicação de ablação da FA quando outros métodos terapêuticos não obtiverem sucesso.', false),
(gen_random_uuid(), '629f3614-f5d6-4647-91bf-d6b359e046c8', 'e', 'A ablação da FA para manutenção do ritmo sinusal, quando indicada corretamente, apresenta eficácia comprovada no longo prazo.', false),

(gen_random_uuid(), '3101c813-fba6-4663-a3e1-3f247ca924b0', 'a', 'O sotalol é um betabloqueador não seletivo com propriedade de prolongar o potencial de ação principalmente em frequência cardíaca reduzida.', true),
(gen_random_uuid(), '3101c813-fba6-4663-a3e1-3f247ca924b0', 'b', 'A amiodarona tem atuação mais intensa sobre o potencial de ação do miocárdio atrial que ventricular.', false),
(gen_random_uuid(), '3101c813-fba6-4663-a3e1-3f247ca924b0', 'c', 'A propafenona promove o bloqueio dos canais de sódio no miocárdio ventricular.', true),
(gen_random_uuid(), '3101c813-fba6-4663-a3e1-3f247ca924b0', 'd', 'A lidocaína reduz a automaticidade do nódulo sinusal.', false),
(gen_random_uuid(), '3101c813-fba6-4663-a3e1-3f247ca924b0', 'e', 'As letras A e C estão corretas.', true);
