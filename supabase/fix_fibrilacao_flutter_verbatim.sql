-- Corrige enunciados e alternativas de "Fibrilação e Flutter" para ficarem
-- EXATAMENTE iguais ao texto do documento fonte (antes eu tinha parafraseado/
-- resumido vários enunciados e, em algumas questões, reescrevido a alternativa
-- errada como um comentário meu em vez de manter o texto original da opção).
-- Não altera comentario/comentario_completo, nem os IDs das questões.
-- Pequenos erros de português do documento original (ex.: "a ferida" em vez
-- de "aferida" na Q28) foram corrigidos.
--
-- Rode isso depois de já ter rodado seed_fibrilacao_flutter.sql.

-- Q4
update public.questions set enunciado = $q$Paciente do sexo masculino, com 70 anos de idade, hipertenso e diabético, foi acometido de palpitações rápidas e irregulares de início súbito. Ao ser atendido na Emergência, informou que esta era a primeira vez que apresentava tais sintomas. À ocasião do atendimento, foi verificado ritmo cardíaco irregular, com frequência cardíaca (FC) = 140 bpm; e pressão arterial (PA) = 130 x 90 mmHg. De acordo com o eletrocardiograma, a respeito deste paciente, existe uma afirmativa que está ERRADA, identifique-a:$q$ where id = '0e92749c-62c5-484f-9f10-332dc2fdcf7b';

-- Q6
update public.questions set enunciado = $q$Em relação à fibrilação atrial paroxística sintomática, constitui indicação de ablação por radiofrequência, que busca isolar as veias pulmonares, EXCETO:$q$ where id = 'b6bb5826-2fa3-4e95-a8ef-959a0062f91b';

-- Q7
update public.questions set enunciado = $q$Mulher, 35 anos, em pós-operatório tardio de troca valvar (prótese biológica) devido à estenose mitral, comparece à consulta em uso de amiodarona, digoxina e varfarina, devido à fibrilação atrial. Assinale a alternativa CORRETA sobre o tratamento antiarrítmico desta paciente.$q$ where id = '321d8b56-48a5-42d8-9eb9-b401cfefbc19';
update public.question_options set texto = $q$A dose de varfarina necessária para atingir INR (índice de normatização internacional) terapêutico deve ser menor que a usual, devido à interação medicamentosa com a amiodarona.$q$ where question_id = '321d8b56-48a5-42d8-9eb9-b401cfefbc19' and letra = 'c';

-- Q8
update public.questions set enunciado = $q$MOS, 36 anos, masculino, passa em consulta ambulatorial queixando-se de palpitações taquicárdicas intermitentes há cerca de dez meses, associadas a leve desconforto torácico. Antecedentes pessoais: reumatismo e sopro na infância. Nega uso regular de medicações. Ao exame físico: ritmo cardíaco irregular, FC = 108 bpm, PA 118 × 72 mmHg, ausculta cardíaca com sopro diastólico em ruflar e estalido de abertura em foco mitral. Ausculta pulmonar sem alteração significativa. Realizado eletrocardiograma, o qual evidenciou ritmo de fibrilação atrial, com elevada resposta ventricular. Qual é a melhor estratégia antitrombótica para esse paciente?$q$ where id = '2c400475-5b6d-417c-9a83-46073538d65b';

-- Q10
update public.questions set enunciado = $q$Mulher, com 57 anos, hipertensa e em tratamento farmacológico. Tem diagnóstico de episódios recorrentes de palpitação, e na crise mais recente foi realizado eletrocardiograma abaixo, com este ritmo se mantendo até o momento. Ao exame, encontra-se em bom estado geral, pressão arterial (PA) normal, assim como o restante do exame físico. Para o manejo da arritmia, a resposta INCORRETA é:$q$ where id = '2b7b2beb-cf2f-49da-b53b-3486b4fac651';

-- Q11
update public.questions set enunciado = $q$Paciente de 40 anos, sexo feminino, apresentando tremores e palpitações; PA = 150 × 90 mmHg. FC em torno de 120-130 bpm. ECG fibrilação atrial. Dosagem de TSH abaixo e T4 livre acima dos valores de referência. A melhor conduta inicial é:$q$ where id = '4191e590-a526-4698-9259-7801b9c24d28';

-- Q12 (todas as 5 alternativas estavam reescritas como comentário meu em vez do texto original da opção)
update public.question_options set texto = $q$A ablação por cateter é recomendada para reversão da disfunção ventricular em pacientes com cardiomiopatia induzida por FA, independentemente da existência de sintomas.$q$ where question_id = 'e95076b4-ee98-477d-874e-9884d467a5b2' and letra = 'a';
update public.question_options set texto = $q$A ablação por cateter para tratamento da FA apresenta taxa de recidiva em um ano menor do que 1%, resultado semelhante à ablação do flutter atrial típico.$q$ where question_id = 'e95076b4-ee98-477d-874e-9884d467a5b2' and letra = 'b';
update public.question_options set texto = $q$O benefício da ablação por cateter é maior em pacientes com FA persistente do que paroxística, por não haver confirmação do sucesso do procedimento quando realizado em ritmo sinusal.$q$ where question_id = 'e95076b4-ee98-477d-874e-9884d467a5b2' and letra = 'c';
update public.question_options set texto = $q$A ausência de episódios de FA por 6 meses após nova tentativa de ablação é suficiente para suspensão da anticoagulação oral com segurança deste paciente.$q$ where question_id = 'e95076b4-ee98-477d-874e-9884d467a5b2' and letra = 'd';
update public.question_options set texto = $q$Quanto maior o tempo de duração da FA, maior a chance de sucesso com o procedimento, pela maior especificidade diagnóstica.$q$ where question_id = 'e95076b4-ee98-477d-874e-9884d467a5b2' and letra = 'e';

-- Q14
update public.questions set enunciado = $q$Homem, 76 anos, deu entrada na emergência com queixa de palpitações há 3 dias. Exame físico = pulsos irregulares e de amplitude variável. Ausculta cardíaca = ritmo irregular. Frequência cardíaca = em torno de 140 bpm. Pressão arterial = 110 x 70 mmHg. Ausculta pulmonar normal. Frequência respiratória = 16 irpm. Saturação SpO2 = 97% em ar ambiente. Eletrocardiograma (ECG) = fibrilação atrial, bloqueio completo de ramo direito e bloqueio divisional anterossuperior esquerdo. Para alívio dos sintomas, com o objetivo de baixar rapidamente a frequência cardíaca, a melhor opção é:$q$ where id = '434df373-ffb9-49d7-ad5d-8befce237f56';

-- Q15
update public.questions set enunciado = $q$Paciente feminina, 55 anos, portadora de valvopatia mitral reumática e fibrilação atrial permanente, encontra-se no pós-operatório de troca valvar mitral, tendo sido submetida a implante de prótese mecânica. Qual é a melhor estratégia antitrombótica para essa paciente no seguimento ambulatorial?$q$ where id = '39431eeb-d4a3-4326-8cb8-250fc7b86211';

-- Q16
update public.questions set enunciado = $q$Homem, 58 anos, com queixa de palpitações recorrentes e piora nos últimos 6 meses, com duração de até 40 minutos, apresentando mal-estar e dispneia concomitante ao quadro. Em consulta cardiológica ambulatorial, foi realizado eletrocardiograma (ECG), Holter e ecocardiograma, que não apresentaram alterações significativas, e foi medicado com 25 mg de succinato de metoprolol ao dia. Após três meses, retornou com os mesmos sintomas, trazendo ECG de atendimento à emergência que mostrava fibrilação atrial com frequência cardíaca (FC) = 120 bpm. Foi revertido na emergência com amiodarona endovenosa e recebeu alta com o succinato de metoprolol, do qual já fazia uso. Qual a conduta mais apropriada para a terapia de controle do ritmo do paciente neste momento?$q$ where id = 'c20d2da3-a1bb-4cf2-9557-cbaf00629a9b';

-- Q19
update public.question_options set texto = $q$Em pacientes com alto risco de sangramento, a anticoagulação deve ser substituída por dupla terapia antiplaquetária no período subsequente à intervenção coronariana percutânea com retorno assim que o segundo antiagregante plaquetário não for mais necessário.$q$ where question_id = '8a24948e-c214-4f85-9258-823b27ebe3a3' and letra = 'c';
update public.question_options set texto = $q$O uso de tripla terapia antitrombótica (dupla antiagregação plaquetária + anticoagulação oral) é seguro e deve ser mantido por um ano após a intervenção coronariana percutânea em pacientes com risco isquêmico baixo.$q$ where question_id = '8a24948e-c214-4f85-9258-823b27ebe3a3' and letra = 'e';

-- Q20
update public.question_options set texto = $q$Flutter atrial. Pelo menor risco embólico, pode ser tratado com INR em faixa terapêutica de 1,5 a 2,0 (reduzindo assim o risco hemorrágico).$q$ where question_id = '913dbac7-d0a6-493d-a8a0-918a7261f446' and letra = 'd';

-- Q21
update public.questions set enunciado = $q$Paciente feminina, 70 anos, com diagnóstico de cardiomiopatia dilatada com fração de ejeção reduzida, etiologia isquêmica, já em uso de betabloqueador em dose máxima e em seguimento clínico por insuficiência cardíaca crônica. Em exames de rotina, foi identificada a presença de fibrilação atrial. Ao exame: bom estado geral, pressão arterial de 110 x 70 mmHg, frequência cardíaca de 98 bpm com bulhas arrítmicas, ausência de turgência jugular ou edema periférico. Sem história pregressa de sangramentos, doença vascular encefálica ou doença hepática. Nos últimos exames laboratoriais, apresentava clearance de creatinina estimada em 20 mL/min, quando iniciou seguimento paralelo na nefrologia. Considerando os fatores de risco, qual seria a melhor conduta?$q$ where id = '6ea0cdda-8bd2-4522-8a57-8b4ea400036f';

-- Q22
update public.questions set enunciado = $q$Paciente do sexo feminino, 50 anos, submetida à troca valvar aórtica por prótese biológica, sem comorbidades. No segundo dia de pós-operatório, apresentou fibrilação atrial, revertida com amiodarona. Sem novos eventos de fibrilação atrial nos últimos 7 meses, incluindo exame de Holter no mesmo período. Desde então, em uso dessa medicação e de anticoagulação oral, assintomática e exame físico sem alterações. Eletrocardiograma, Holter de 48 horas e ecocardiograma transtorácico estão normais, e a bioprótese está normofuncionante. A conduta mais apropriada é:$q$ where id = 'ceb6857d-684e-4f8a-b157-c696ddb8a871';

-- Q23
update public.questions set enunciado = $q$Paciente de 25 anos, em curso de 16ª semana da 2ª gestação, com história de troca valvar por prótese biológica mitral há 4 anos, assintomática, em uso de penicilina benzatina profilática para doença reumática. Procurou o pronto-socorro com queixa de palpitações e dispneia aos esforços, que iniciou há uma semana. Ao exame físico, estava com frequência cardíaca (FC) = 120 bpm; pressão arterial (PA) = 100 x 60 mmHg. Ausculta cardíaca mostrava ritmo cardíaco regular, sopro sistólico discreto em área mitral e presença de 3ª bulha; a ausculta pulmonar mostrava estertores crepitantes de bases. O eletrocardiograma revelou taquicardia regular de QRS estreito com FC = 140 bpm. Realizada massagem do seio carotídeo sem sucesso e, após a revisão de novo eletrocardiograma, o traçado mostrou flutter atrial 2:1. Assinale a alternativa CORRETA acerca da conduta inicial para o atendimento na sala de emergência:$q$ where id = 'bd1f7329-4277-4267-9250-74eba8bdf11e';

-- Q25
update public.questions set enunciado = $q$Paciente de 48 anos com história de valvoplastia mitral percutânea por estenose valvar mitral reumática chega ao pronto-socorro com queixa de mal-estar há cerca de uma semana. O eletrocardiograma (ECG) abaixo é registrado. Sobre o cenário, é correto afirmar:$q$ where id = '8a73aa14-db87-4ce5-8a4a-fabd379a6a6f';

-- Q27
update public.questions set enunciado = $q$O eletrocardiograma (ECG) da imagem a seguir foi registrado durante emergência, em atendimento de paciente com síncope, apresentando-se com sinais de baixo débito e precordialgia. O que sugere o ECG e qual a conduta?$q$ where id = '8bacc543-4fb7-4af7-8bdd-ec7d05bff98c';
update public.question_options set texto = $q$ECG sugestivo de fibrilação ventricular, devendo o paciente ser desfibrilado imediatamente e submetido a implante de cardioversor desfibrilador implantável (CDI).$q$ where question_id = '8bacc543-4fb7-4af7-8bdd-ec7d05bff98c' and letra = 'a';
update public.question_options set texto = $q$ECG de taquicardia ventricular polimórfica catecolaminérgica. A administração de betabloqueador intravenoso está indicada para controle de arritmias.$q$ where question_id = '8bacc543-4fb7-4af7-8bdd-ec7d05bff98c' and letra = 'b';
update public.question_options set texto = $q$ECG de taquicardia ventricular polimórfica relacionada à síndrome coronariana aguda. O paciente deve ser cardiovertido e encaminhado à sala de hemodinâmica para tratamento percutâneo quanto antes.$q$ where question_id = '8bacc543-4fb7-4af7-8bdd-ec7d05bff98c' and letra = 'c';
update public.question_options set texto = $q$ECG de fibrilação atrial de alta resposta e bloqueio de ramo esquerdo. Paciente deve ser cardiovertido e encaminhado à ablação de fibrilação atrial (FA), para isolamento das veias pulmonares.$q$ where question_id = '8bacc543-4fb7-4af7-8bdd-ec7d05bff98c' and letra = 'e';

-- Q28
update public.questions set enunciado = $q$Gestante primípara, na 29ª semana de gestação, apresenta fibrilação atrial persistente, com frequência cardíaca de 140 bpm acompanhada de mal-estar. A pressão arterial aferida foi 140 x 70 mmHg. Ao exame físico, verificam-se pulmões limpos e discreto edema perimaleolar. A conduta inicial adequada, neste caso, deve ser:$q$ where id = '4a5b36a0-b03c-4165-9793-03d08cedda66';

-- Q31
update public.questions set enunciado = $q$Paciente do sexo feminino, 63 anos, 84 kg, diagnosticada com fibrilação atrial (FA) paroxística em Holter após acidente vascular cerebral isquêmico. Apresenta creatinina = 1,2 mg/dL, com clearance de creatinina = 40,9 mL/min, sem outras comorbidades cardiovasculares. Ecocardiograma normal (fração de ejeção do ventrículo esquerdo = 70%). Sobre a anticoagulação neste caso, assinale a alternativa cuja anticoagulação está adequada:$q$ where id = 'f5630002-333b-410d-911e-78fd3baf145d';
update public.question_options set texto = $q$Varfarina com objetivo de manter INR (razão normalizada internacional) entre 2,5 e 3,5.$q$ where question_id = 'f5630002-333b-410d-911e-78fd3baf145d' and letra = 'd';

-- Q33
update public.questions set enunciado = $q$Paciente com 82 anos de idade, 75 kg, com fibrilação atrial permanente, taxa de filtração glomerular = 60 mL/min, em uso de atenolol 25 mg e edoxabana 60 mg/dia. Apresenta queda da própria altura e hematoma em face. Sem lesão intracraniana na tomografia. Referiu uma queda da própria altura no ano anterior. Qual a melhor conduta?$q$ where id = '0301c484-82ce-4bc8-bd4a-b19488ef43ad';

-- Q34
update public.questions set enunciado = $q$Paciente do sexo masculino, 67 anos, hipertenso e diabético. Submetido a cirurgia de revascularização miocárdica para tratamento de insuficiência coronariana, apresentou fibrilação atrial no pós-operatório imediato. Apesar das tentativas de reversão ao ritmo sinusal, a arritmia persistiu por mais de 48 horas. Neste caso, pode-se afirmar que a anticoagulação:$q$ where id = 'de0e4d80-4c9c-408c-9c2b-da1ba658ce00';

-- Q35
update public.questions set enunciado = $q$Após mudar de cidade, um paciente procurou um cardiologista para seguir acompanhando seu caso. Havia uma história de taquiarritmia não especificada e o paciente fazia uso de sotalol 160 mg/dia. Após analisar os exames complementares, realizar o exame físico e observar o ECG do paciente, o médico decidiu descontinuar o uso do sotalol, por ter identificado uma CONTRAINDICAÇÃO ao seu uso:$q$ where id = '67c76566-ac1b-4e52-91a6-f3d0b24db87f';

-- Q39
update public.questions set enunciado = $q$Paciente de 76 anos com história de dispneia de caráter progressivo, atualmente mesmo em repouso. O seu exame físico mostrou ritmo de fibrilação atrial, FC = 106 bpm e PA = 160 × 95 mmHg além de congestão venosa (edema de membros inferiores, hepatomegalia e estertores pulmonares). Tem antecedente de hipertensão arterial de longa data com tratamento irregular. Pensando em otimizar a sua prescrição, assinale qual medicação NÃO está indicada nesse paciente:$q$ where id = '3a47c1af-2204-432f-a60c-40c34a161e0d';

-- Q40
update public.question_options set texto = $q$Grandes ensaios clínicos mostraram que os novos anticoagulantes orais (dabigatran, rivaroxaban e apixaban) reduzem as taxas de acidente vascular encefálico (AVE) hemorrágico ao serem comparados aos antagonistas da vitamina K.$q$ where question_id = 'df12ddcf-6a9a-43a8-94c6-3d9a127e953c' and letra = 'a';

-- Q41
update public.questions set enunciado = $q$Mulher, 69 anos, diabética, com infarto há 3 anos e fração de ejeção do ventrículo esquerdo 35% procura o pronto-socorro por palpitações taquicárdicas iniciadas há quatro horas. Nega dor torácica, síncope ou dispneia. Ao exame físico, PA 144 × 80 mmHg, FC = 143 bpm, eupneica e afebril, ausculta pulmonar limpa, sem edema ou turgência jugular. O eletrocardiograma ilustra uma taquiarritmia. Sobre o seu tratamento, é CORRETO afirmar:$q$ where id = '191de5c4-a11a-468a-9caa-9037b6f3244f';
update public.question_options set texto = $q$Caso seja optado por controle da frequência cardíaca, podem ser utilizadas as seguintes medicações: betabloqueador, inibidor dos canais de cálcio do tipo não di-idropiridínico, digoxina e ivabradina.$q$ where question_id = '191de5c4-a11a-468a-9caa-9037b6f3244f' and letra = 'e';
