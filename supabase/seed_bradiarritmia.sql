-- Novo tema: "Bradiarritmia" (cardiologia), banca TEC/SBC.
-- Fonte: documento enviado pelo usuário (Google Docs), que já trazia boa
-- parte das explicações prontas — foram reorganizadas aqui no padrão
-- resumido (comentario) + completo (comentario_completo) do app.
--
-- IMPORTANTE — várias questões fazem referência a um traçado de ECG/Holter
-- que não está incluído aqui (sem imagem por enquanto); os comentários já
-- descrevem em texto os achados relevantes do traçado, então a questão
-- continua respondível e didática mesmo sem a imagem. As imagens serão
-- adicionadas depois, numa etapa própria, para todos os temas de uma vez.
--
-- Rode este arquivo uma vez no SQL Editor do seu projeto Supabase.

insert into public.questions (id, tema, ano, instituicao, enunciado, comentario, comentario_completo) values

('d32573c2-25f1-4019-9dd1-bf1f71134c6c', 'Bradiarritmia', 2021, 'TEC', 'Mulher, 78 anos, portadora de marcapasso definitivo de longa data, procurou atendimento médico por episódios de síncope de repetição. O traçado de Holter 24 horas permite afirmar qual diagnóstico?', 'O traçado mostra a espícula do marca-passo presente, mas sem resposta ventricular subsequente (o QRS não é gerado) — isso é falha de captura ventricular, e explica a síncope da paciente.', 'Ao analisar o traçado do Holter, observam-se dois elementos-chave: a espícula do marca-passo está presente (o aparelho emite o estímulo elétrico destinado a estimular o ventrículo), mas não há resposta miocárdica após ela — o complexo QRS esperado não é gerado. O marca-passo "tenta" capturar o coração, mas o estímulo não consegue desencadear a contração ventricular. Essa falha de captura explica a síncope da paciente, já que o dispositivo não consegue manter a frequência cardíaca quando o ritmo próprio falha.

Por que as outras alternativas estão incorretas:
• A) Undersensing ventricular: ocorreria se o marca-passo não "enxergasse" a atividade elétrica própria do paciente, disparando desnecessariamente em cima de batimentos naturais — no traçado, veríamos o marca-passo disparando sobre um QRS próprio já existente, o que não é o caso aqui.
• C) Falha de captura atrial e ventricular: a imagem foca especificamente no ventrículo, sem evidências claras de falha também no canal atrial nesse segmento do traçado.
• D) Undersensing atrial: refere-se à falha do marca-passo em detectar a onda P do paciente, disparando o estímulo atrial em momentos inadequados — um problema diferente do observado.
• E) Taquicardia mediada pelo marca-passo: é uma arritmia reentrante em que o marca-passo detecta uma atividade ventricular e dispara um estímulo atrial prematuro, criando um ciclo vicioso — o traçado não apresenta os critérios necessários para esse diagnóstico.'),

('6ca5766b-5efc-41c2-8879-c855d86e4b56', 'Bradiarritmia', 2021, 'TEC', 'Mulher, 84 anos, hipertensa e coronariopata crônica, com história de palpitação nos últimos meses, pré-síncope de repetição e episódio de síncope sem pródromos. O ecocardiograma demonstrou fração de ejeção do ventrículo esquerdo preservada. Ao Holter 24h, pôde-se observar frequência cardíaca média de 52 bpm, além de diversos episódios de taquiarritmia atrial seguidos de pausas prolongadas. Qual diagnóstico e conduta adequados?', 'O quadro é clássico de Síndrome Taquicardia-Bradicardia (uma forma de disfunção do nó sinusal): períodos de taquiarritmia atrial (palpitações) seguidos de pausas sinusais prolongadas (síncope/pré-síncope). A indicação é implante de marca-passo definitivo.', 'O caso descrito é clássico de Síndrome Taquicardia-Bradicardia, uma forma de disfunção do nó sinusal. O Holter mostra episódios de taquiarritmia atrial (possivelmente fibrilação ou taquicardia atrial paroxística) seguidos de pausas prolongadas ao término da arritmia — essas pausas se correlacionam com os sintomas da paciente: as palpitações correspondem à fase de taquicardia, e a síncope/pré-síncope correspondem às pausas prolongadas após o término da arritmia, quando há falha na retomada do ritmo sinusal.

Diante de uma disfunção do nó sinusal sintomática, especialmente com síncope documentada correlacionada a pausas longas, a indicação é o implante de marca-passo definitivo. O marca-passo não apenas previne a bradicardia grave e a síncope, como também permite tratar a arritmia atrial associada com medicações que, de outra forma, seriam perigosas por agravarem a bradicardia.

Por que as outras alternativas estão incorretas:
• B) Bloqueio atrioventricular Mobitz I: não explica o padrão de taquiarritmia seguida de pausa prolongada descrito no Holter, que é característico da doença do nó sinusal, não de um bloqueio AV.
• C) Bloqueio atrioventricular total: cursaria com dissociação AV constante, não com o padrão intermitente de taqui-bradi observado.
• D) Bloqueio sinoatrial Mobitz II: não é o achado central descrito (pausas após taquiarritmia, não bloqueios de saída isolados do nó sinusal).
• E) Bloqueio atrioventricular avançado: também não corresponde ao padrão de taqui-bradi, que é uma disfunção do próprio nó sinusal, não do nó AV.'),

('97163364-1910-4e79-87da-d8acfa65c544', 'Bradiarritmia', 2020, 'TEC', 'Qual a conduta correta frente aos achados identificados neste registro eletrocardiográfico, que apresenta alternância de bloqueios de ramo (BRD e BRE) associada a um BAV de 1º grau, em paciente que já apresentou síncope?', 'A alternância de bloqueios de ramo indica doença nos dois ramos do sistema de condução, com risco iminente de evolução para bloqueio atrioventricular total. Como a paciente já teve síncope, a indicação de marca-passo definitivo é formal e imediata.', 'O traçado apresenta uma alternância de bloqueios de ramo (BRD e BRE) associada a um bloqueio atrioventricular de 1º grau — um achado de altíssimo risco para a condução cardíaca. A alternância de bloqueios de ramo indica que a doença está presente nos dois ramos do sistema de condução (direito e esquerdo); em termos práticos, o sistema de condução está gravemente comprometido, e a progressão súbita para um Bloqueio Atrioventricular Total (BAVT) é um risco real e iminente.

Como a paciente já apresentou um quadro de síncope, a indicação de marca-passo definitivo é formal, independentemente de novas pausas serem documentadas no Holter, pois o risco de um evento catastrófico é elevado. Não se deve esperar pela ocorrência de novas síncopes ou pela documentação de BAVT em exame ambulatorial para intervir.

Por que as outras alternativas estão incorretas:
• A) Aguardar Holter de 24h e só indicar marca-passo se houver pausa maior que 3 segundos: postergaria uma intervenção já formalmente indicada pelo próprio achado eletrocardiográfico de alto risco associado à síncope.
• C) Acompanhamento clínico e marca-passo só quando surgirem sintomas: a paciente JÁ tem sintoma (síncope) — esperar novos sintomas expõe a um risco desnecessário de evento grave.
• D) Estudo eletrofisiológico antes de decidir: não é necessário quando já há indicação clínica formal e direta pela combinação de achado eletrocardiográfico de alto risco com síncope.
• E) Avaliar fração de ejeção e indicar conforme o valor: a indicação aqui é pelo risco de condução (alternância de bloqueios de ramo + síncope), não pela função sistólica.'),

('01a85324-e737-4ef1-bc26-f09a3450fe8c', 'Bradiarritmia', 2023, 'TEC', 'Em quais das condições abaixo NÃO está indicado o implante de marca-passo em pacientes assintomáticos e com bloqueio atrioventricular total congênito?', 'Uma frequência cardíaca isoladamente baixa (menor que 70 bpm em repouso) não é, por si só, critério de indicação de marca-passo em pacientes com BAVT congênito assintomáticos, com boa tolerância ao esforço e sem disfunção ventricular.', 'Para pacientes com Bloqueio Atrioventricular Total (BAVT) congênito assintomáticos, as diretrizes de marcapasso estabelecem critérios específicos para indicação do implante — e uma frequência cardíaca lenta isolada não é um desses critérios, desde que o paciente seja assintomático, tenha boa tolerância ao esforço e não apresente disfunção ventricular. Valores como frequência abaixo de 70 bpm são comuns e bem tolerados nesse grupo, não justificando implante profilático apenas por esse achado.

Por que as outras alternativas SÃO critérios de indicação (não são a resposta pedida, que busca o que NÃO indica):
• A) Presença de arritmia ventricular complexa é critério reconhecido de indicação, por sinalizar maior instabilidade elétrica.
• B) Intervalo QTc aumentado é fator de risco adicional para eventos arrítmicos graves, justificando o implante.
• D) Intolerância ao esforço físico e disfunção ventricular esquerda são sinais de repercussão hemodinâmica da bradicardia crônica, indicando o implante.
• E) QRS largo sugere um escape mais baixo (infra-hissiano) e menos confiável, sendo também critério de indicação.'),

('ad0e5096-5abc-4dfa-9ceb-430d33b7a1d2', 'Bradiarritmia', 2014, 'TEC', 'Paciente masculino, 77 anos, com queixa de palpitação e pré-síncope de repetição nos últimos 3 meses. Ecocardiograma com função sistólica preservada. O ECG realizado durante exacerbação dos sintomas mostra um padrão alternando taquiarritmia atrial e pausas/bradicardia acentuada. Quais são o diagnóstico e a conduta terapêutica adequada?', 'Trata-se de síndrome bradi-taqui (disfunção sinusal): indicado marca-passo definitivo dupla-câmara para tratar a bradicardia, associado a medidas profiláticas de tromboembolismo, já que esses pacientes costumam ter fibrilação/taquiarritmia atrial associada.', 'Esta questão aborda o manejo de pacientes com disfunção do nó sinusal que apresentam a chamada Síndrome Taquicardia-Bradicardia. O eletrocardiograma (e a descrição do quadro de palpitação seguida de pré-síncope) é clássico dessa síndrome: o paciente alterna entre períodos de taquiarritmia atrial (responsável pelas palpitações) e pausas sinusais ou bradicardia acentuada após o término da arritmia (responsável pela pré-síncope).

Conduta: o implante de marca-passo definitivo (dupla-câmara) é indicado para tratar o componente bradiarrítmico. Além disso, como esses pacientes frequentemente apresentam episódios de fibrilação atrial (ou outras taquiarritmias atriais) associados à disfunção do nó, é fundamental instituir medidas profiláticas de tromboembolismo (geralmente anticoagulação), baseando-se no escore de risco do paciente (CHA2DS2-VASc), para prevenir eventos embólicos como o AVC.

Por que as outras alternativas estão incorretas:
• A) Bloqueio atrioventricular avançado paroxístico: não corresponde ao padrão descrito de alternância entre taquiarritmia atrial e pausa, que é típico de disfunção sinusal, não de um bloqueio AV.
• B) Bloqueio AV total intermitente: mesma lógica — o padrão descrito é de doença do nó sinusal, não do nó AV.
• D) Marca-passo ressincronizador: não há indicação de ressincronização nesse quadro (função sistólica preservada, sem dessincronia ventricular descrita); o modo correto é o convencional dupla-câmara.
• E) "MPD pelo diagnóstico de doença do nó sinusal" sem mencionar a profilaxia de tromboembolismo: incompleta, pois omite a conduta igualmente importante de prevenção de eventos embólicos associados à taquiarritmia atrial.'),

('3d941793-5ed4-457c-bf9d-144cdc294295', 'Bradiarritmia', 2012, 'TEC', 'Paciente do sexo feminino, 68 anos, com dispneia aos esforços habituais, palpitações e escurecimento visual esporadicamente há 4 meses. Faz uso de atenolol 50 mg duas vezes ao dia e sinvastatina para HAS e dislipidemia. ECG evidenciou bradiarritmia. Quanto à indicação de implante de marca-passo definitivo, escolha a afirmativa correta:', 'Antes de indicar marca-passo, é obrigatório avaliar se a bradiarritmia não está sendo causada ou agravada pelo betabloqueador (atenolol). A conduta correta é modificar o anti-hipertensivo e reavaliar a necessidade de marca-passo depois.', 'Esta é uma questão clássica de raciocínio clínico em cardiologia. A paciente apresenta sintomas claros (dispneia, palpitações e síncope) em uso de atenolol (um betabloqueador) na dose de 50 mg duas vezes ao dia — um fármaco que reduz a frequência cardíaca e a contratilidade. Antes de indicar um procedimento invasivo e definitivo como o implante de um marca-passo, é obrigatório avaliar se a bradiarritmia não é iatrogênica ou agravada pelo medicamento.

Conduta: a suspensão ou redução da dose do betabloqueador é o passo inicial mandatório. Após a retirada da droga, deve-se reavaliar a paciente (novo ECG ou Holter) para verificar se a bradiarritmia persiste. Se, mesmo após a suspensão da medicação, a bradiarritmia e os sintomas se mantiverem, aí sim o implante de marca-passo definitivo torna-se a conduta indicada. Modificar o tratamento medicamentoso antes de definir o implante é a conduta ética e tecnicamente correta para evitar procedimentos desnecessários.

Por que as outras alternativas estão incorretas:
• A) e B) Classificar diretamente como doença do nó sinusal com indicação de marca-passo (classe I ou IIa) pula a etapa obrigatória de excluir a causa medicamentosa antes de rotular a bradiarritmia como doença intrínseca do nó sinusal.
• D) Modificar o anti-hipertensivo E já implantar o marca-passo ao mesmo tempo antecipa uma decisão invasiva que só deve ser tomada após confirmar que a bradiarritmia persiste sem o medicamento.
• E) Manter o betabloqueador e implantar marca-passo ignora completamente a causa iatrogênica mais provável e mais fácil de reverter antes de um procedimento definitivo.'),

('17c9d7af-2edb-4fc1-9241-76700ba1fe2b', 'Bradiarritmia', 2012, 'TEC', 'Paciente do sexo feminino, 84 anos, hipertensa de longa data, deu entrada na emergência após episódio sincopal com lesão corporal. Sem cardiopatia estrutural, marcadores de necrose miocárdica normais. Na admissão, torporosa, palidez cutaneomucosa e PA = 70 x 40 mmHg. Qual o diagnóstico eletrocardiográfico e a conduta clínica a ser adotada?', 'O quadro de choque (hipotensão grave e rebaixamento do nível de consciência) por bradiarritmia é compatível com Bloqueio Atrioventricular Total. A conduta é marca-passo provisório imediato para estabilização, seguido de marca-passo definitivo.', 'O quadro clínico da paciente é de instabilidade hemodinâmica grave (PA 70 x 40 mmHg, torporosa), decorrente de uma bradiarritmia. A descrição de um episódio sincopal em paciente idosa, associado a sintomas de baixo débito (hipotensão e alteração do nível de consciência), sugere um bloqueio de alto grau — nesse contexto de choque cardiogênico por bradicardia, o Bloqueio Atrioventricular Total (BAVT) é o diagnóstico que melhor justifica a gravidade do quadro.

Conduta: o marca-passo provisório é a medida imediata para estabilizar a frequência cardíaca e a pressão arterial, pois a paciente está em choque e a atropina muitas vezes é insuficiente ou ineficaz em bloqueios infra-hissianos. Na sequência, o BAVT sintomático, independentemente da causa, tem indicação de implante de marca-passo definitivo (Classe I de recomendação).

Por que as outras alternativas estão incorretas:
• A) e C) Sugerem apenas atropina, uma conduta inadequada para uma paciente com hipotensão grave e instabilidade, cenário em que a estimulação elétrica é mandatória (a atropina costuma ser ineficaz em bloqueios de localização mais baixa).
• B) Bloqueio AV de 2º grau Mobitz II: também levaria a marca-passo, mas o quadro completo de choque e torpor descrito é mais consistente com BAVT do que com um bloqueio de 2º grau.
• D) Bloqueio AV de 2º grau avançado: mesma lógica — a gravidade extrema do quadro (choque franco) aponta para o diagnóstico de BAVT, não de um bloqueio de grau intermediário.'),

('0e516885-ee23-467d-bf0e-e039355a0f6d', 'Bradiarritmia', 2019, 'TEC', 'Em relação ao traçado de Holter, qual afirmação está correta: trata-se de um bloqueio atrioventricular de 2º grau tipo I (Wenckebach), o que normalmente não deve ser considerado de alto risco em pacientes assintomáticos?', 'O BAV de 2º grau tipo I (Mobitz I/Wenckebach) tem localização predominantemente no próprio nó AV (supra-hissiano), costuma ser reversível e é considerado de baixo risco em pacientes assintomáticos, não exigindo marca-passo na maioria dos casos.', 'O traçado apresentado refere-se a um Bloqueio Atrioventricular (BAV) de 2º grau tipo I (Mobitz I ou Wenckebach), caracterizado pelo prolongamento progressivo do intervalo PR até que um impulso atrial não seja conduzido aos ventrículos (onda P bloqueada). O BAV de 2º grau tipo I é, na vasta maioria dos casos, de localização supra-hissiana (no próprio nó atrioventricular). Por ser uma alteração no nó AV, muitas vezes reversível (por aumento do tônus vagal ou uso de medicações), ele é considerado um bloqueio de baixo risco em pacientes assintomáticos, não necessitando, via de regra, de marca-passo definitivo.

Por que as outras alternativas estão incorretas:
• B) O Mobitz I (Wenckebach) localiza-se preferencialmente no nó atrioventricular, e não no feixe de His.
• C) O BAV de 2º grau tipo II caracteriza-se por intervalos PR fixos antes da onda P bloqueada, e sua localização anatômica é infra-hissiana (sistema His-Purkinje), sendo considerado de alto risco — o oposto do tipo I.
• D) O distúrbio no sistema His-Purkinje é típico do BAV de 2º grau tipo II (ou bloqueios de alto grau), e não do tipo I.
• E) Embora o BAV de 2º grau possa ser influenciado por drogas, ele não é classificado como "fisiológico"; a presença desse bloqueio, especialmente se recorrente ou associado a sintomas, deve sempre ser investigada, não sendo considerada uma variante do normal.'),

('51f2bbf7-b3ea-4bdf-b66f-d0f6f990331c', 'Bradiarritmia', 2014, 'TEC', 'Motorista profissional teve marca-passo convencional implantado após diagnóstico de bradiarritmia sintomática sem cardiopatia estrutural, sem intercorrências, evoluindo assintomático. Quanto à atividade profissional, o médico assistente pode liberá-lo a retornar ao trabalho:', 'Para atividades de maior risco como a direção profissional, recomenda-se aguardar cerca de seis semanas após o implante, tempo necessário para cicatrização e estabilização dos eletrodos, garantindo que não haja complicações agudas como deslocamento de cabo.', 'De acordo com as diretrizes da Sociedade Brasileira de Cardiologia (e consensos internacionais de cardiologia e medicina do tráfego), o tempo de cicatrização e estabilização dos eletrodos (para evitar deslocamento) geralmente requer um período de repouso. Para atividades profissionais de maior risco, como a direção profissional, é prudente aguardar seis semanas após o implante. Isso garante que o paciente esteja totalmente recuperado do procedimento cirúrgico, que o dispositivo esteja funcionando adequadamente e que não haja complicações agudas (como deslocamento de cabo ou hematoma de loja), minimizando o risco de eventos enquanto ele exerce sua profissão.

Por que as outras alternativas estão incorretas:
• B) Trinta dias sem sintomas não é o critério utilizado — o parâmetro reconhecido é o prazo fixo de seis semanas relacionado à cicatrização do sistema, não um período variável de ausência de sintomas.
• C) Afastamento definitivo da profissão não é necessário para um paciente que evoluiu assintomático e sem intercorrências após o implante.
• D) Embora função ventricular e comorbidades sejam relevantes em outros contextos, para a liberação padrão pós-implante sem intercorrências o prazo de referência é objetivo (seis semanas), não "variável" sem critério definido.
• E) Indicação de cardioversor-desfibrilador não se aplica a esse quadro de bradiarritmia sintomática sem cardiopatia estrutural nem arritmia ventricular maligna documentada.'),

('5d21c0ee-1a99-4017-8ebe-84f8ecb8f419', 'Bradiarritmia', 2017, 'TEC', 'No código de cinco letras empregado para descrever as operações dos dispositivos cardíacos eletrônicos implantáveis, a terceira letra descreve:', 'No código NBG (NASPE/BPEG) de cinco letras dos marca-passos, a terceira letra descreve o modo de resposta à sensibilidade — como o aparelho reage ao que "sente" (se inibe o estímulo ou dispara em resposta).', 'O código NBG (NASPE/BPEG) descreve as funções do marca-passo da seguinte forma:
• 1ª letra: câmara estimulada (A, V, D ou O).
• 2ª letra: câmara sentida (A, V, D ou O).
• 3ª letra: modo de resposta à sensibilidade — indica como o aparelho reage ao que "sente" (se inibe o estímulo ou dispara em resposta a um evento próprio detectado).
• 4ª letra: funções programáveis/frequência adaptativa.
• 5ª letra: funções de terapia antitaquicardia.

Por que as outras alternativas estão incorretas:
• A) Câmara sentida é descrita pela 2ª letra do código, não pela 3ª.
• B) Câmara estimulada é descrita pela 1ª letra do código, não pela 3ª.
• C) Estimulação multissítio não faz parte das cinco posições clássicas do código NBG da forma descrita nessa alternativa.
• E) Modulação de frequência (resposta de frequência adaptativa) corresponde à 4ª letra do código, não à 3ª.'),

('e7d020da-de89-4e4f-98b2-8fda8a73905a', 'Bradiarritmia', 2017, 'TEC', 'Dentre as alterações que podem ser observadas ao Holter, a que NÃO deve ser encontrada em indivíduos saudáveis é:', 'O bloqueio atrioventricular de 2º grau tipo II (Mobitz II) é sempre patológico — é um distúrbio de condução infra-hissiano com alto risco de progressão para BAV total, ao contrário dos outros achados listados, que podem ocorrer normalmente em pessoas saudáveis (especialmente atletas ou durante o sono).', 'O objetivo da questão é identificar qual dessas alterações não é considerada uma variante do normal ou um achado comum em indivíduos saudáveis (especialmente atletas ou durante o sono, quando o tônus vagal é elevado). O Bloqueio Atrioventricular (BAV) de 2º grau tipo II (Mobitz II) é um distúrbio de condução infra-hissiano (abaixo do nó AV), sempre patológico, indicando doença grave do sistema de condução. Diferente do tipo I (Wenckebach), que pode ocorrer fisiologicamente devido ao aumento do tônus vagal, o Mobitz II não é uma resposta fisiológica e tem alto risco de progressão para BAV total (BAVT) ou síncope.

Por que as outras alternativas PODEM ser encontradas em indivíduos saudáveis (não são a resposta pedida):
• A) Marca-passo atrial ectópico: pode ocorrer em indivíduos saudáveis, especialmente durante o sono ou repouso, quando o nó sinusal reduz sua frequência e permite que focos atriais inferiores assumam o comando.
• B) BAV de 2º grau tipo I: o fenômeno de Wenckebach é achado relativamente comum em atletas de alto desempenho e jovens saudáveis durante o sono, refletindo tônus vagal elevado.
• D) Arritmia sinusal: é variação normal da frequência cardíaca ligada ao ciclo respiratório; embora pausas sinusais possam ocorrer, isso não é sinônimo de doença.
• E) Bradicardia sinusal 35-40 bpm: achado extremamente comum e fisiológico em atletas de elite ("coração de atleta"), por aumento do tônus vagal e adaptação cardíaca.'),

('a649b4c4-b85e-4113-b299-f4d5672b1da7', 'Bradiarritmia', 2019, 'TEC', 'Mulher, 82 anos, hipertensa e diabética, admitida com cansaço progressivo há um mês e síncope sem pródromos. Marcadores de necrose normais. Ecocardiograma com hipertrofia concêntrica do VE. O ECG mostra um bloqueio atrioventricular com padrão 2:1. Qual o diagnóstico eletrocardiográfico e a conduta médica indicada?', 'Trata-se de bloqueio atrioventricular 2:1 (para cada duas ondas P, um QRS é conduzido) em paciente sintomática. A conduta é marca-passo provisório para estabilização inicial, seguido de marca-passo definitivo.', 'Esta questão apresenta um caso de uma paciente idosa com síncope e sintomas de baixo débito. O traçado apresenta um bloqueio atrioventricular (AV) com padrão 2:1 (para cada duas ondas P, apenas um complexo QRS é conduzido).

Conduta clínica: em um paciente sintomático e hemodinamicamente instável (ou com alto risco de progressão imediata), a estabilização inicial com marca-passo provisório é frequentemente indicada para garantir a frequência cardíaca antes do procedimento definitivo. Sendo um bloqueio de alto grau (2:1 em paciente sintomática), a indicação de implante de marca-passo definitivo é uma classe I de recomendação, sendo o tratamento definitivo para prevenir novas síncopes e complicações graves. Embora na prática clínica a distinção entre BAVT e BAV 2:1 possa ser sutil dependendo da frequência, o foco da questão é a instabilidade clínica que exige suporte elétrico imediato (provisório) seguido da correção permanente.

Por que as outras alternativas estão incorretas:
• A) Bloqueio atrioventricular total: o padrão descrito no traçado é especificamente 2:1, uma entidade distinta do BAVT completo.
• C) Mobitz II com atropina venosa: a atropina costuma ser ineficaz em bloqueios de localização mais baixa (infra-hissiana), como sugerido pelo contexto, sendo insuficiente como conduta isolada.
• D) Mobitz I: o padrão de bloqueio 2:1 fixo não corresponde ao prolongamento progressivo do PR característico do Mobitz I.
• E) Bradicardia sinusal sintomática com atropina: não descreve o achado de bloqueio AV 2:1 observado no traçado, e a atropina isolada não é a conduta definitiva indicada neste grau de bloqueio sintomático.'),

('52780979-b792-4eb6-8df4-e02292ccab55', 'Bradiarritmia', 2024, 'TEC', 'Paciente do sexo masculino, 82 anos, assintomático, hipertenso e dislipidêmico, ativo (Pilates 3x/semana), com ECG mostrando bradicardia sinusal (FC 44 bpm), ecocardiograma e cintilografia normais, Holter sem arritmias significativas (FC média 48 bpm). Sobre esse paciente, é correto afirmar:', 'Paciente totalmente assintomático, com coração estruturalmente normal, sem isquemia e sem arritmias complexas ao Holter — a bradicardia de 44 bpm reflete apenas tônus vagal aumentado (comum em pessoas ativas) e não traz indicação de marca-passo ou de qualquer investigação adicional.', 'Esta é uma questão clássica que testa o conceito de bradicardia sinusal assintomática. O paciente é ativo fisicamente (faz Pilates), está totalmente assintomático e seus exames mostram um coração estruturalmente normal (ecocardiograma normal), sem isquemia (cintilografia negativa) e sem arritmias complexas ou pausas significativas (Holter normal). A bradicardia de 44 bpm em um indivíduo assintomático e sem disfunção do sistema de condução é um achado comum, frequentemente associado ao aumento do tônus vagal. Nesses casos, o implante de marca-passo não traz benefício e, portanto, não é indicado — o paciente deve apenas manter acompanhamento clínico regular.

Por que as outras alternativas estão incorretas:
• A, B e C) O implante de qualquer tipo de marca-passo (unicameral ou bicameral) é contraindicado, pois o paciente não apresenta sintomas (síncope, pré-síncope, dispneia) nem evidências de doença do nó sinusal ou bloqueio atrioventricular que justifiquem a intervenção.
• D) Não há indicação de estudo eletrofisiológico (EEF) neste paciente — o EEF é reservado para casos de suspeita de doença do sistema de condução quando a correlação entre sintomas e achados de superfície não está clara, o que não é o caso aqui, já que o paciente está assintomático e o Holter foi normal.'),

('19396bda-af5f-40e2-b96d-1ae8cb103a7e', 'Bradiarritmia', 2014, 'TEC', 'Mulher, 46 anos, com hipertensão arterial, deu entrada com cansaço, tontura e lipotimia há 1 mês. História familiar de doença de Chagas. Durante o ECG, apresentou pré-síncope. Quanto à abordagem terapêutica, qual é a alternativa CORRETA?', 'O traçado mostra padrão típico de Disfunção do Nó Sinusal (bradicardia acentuada/pausas sinusais correlacionadas aos sintomas). Bradicardia sintomática, mesmo por disfunção do nó sinusal, é indicação formal de marca-passo definitivo.', 'Esta questão apresenta o caso de uma paciente com sintomas de baixo débito cardíaco (cansaço, tontura, lipotimia) e pré-síncope documentada durante o exame. O traçado eletrocardiográfico mostra um padrão típico de Disfunção do Nó Sinusal, caracterizado por períodos de bradicardia acentuada ou pausas sinusais, que se correlacionam com os sintomas da paciente. Essa condição, quando sintomática, define a chamada "Síndrome Taqui-Bradicardia" (se houver episódios de taquiarritmia atrial associados) ou simplesmente Doença do Nó Sinusal sintomática.

Conduta: conforme as diretrizes, a presença de bradicardia sintomática (independente da causa, sendo a disfunção do nó sinusal uma delas) é indicação formal de implante de marca-passo definitivo (MPD), para eliminar a bradicardia e permitir o uso de medicações para controlar possíveis taquiarritmias, caso existam.

Por que as outras alternativas estão incorretas:
• A) QT longo: não é o diagnóstico sugerido pelo quadro e pelo traçado descritos, que apontam para disfunção do nó sinusal, não para uma canalopatia de repolarização.
• B) BAV tipo II (Mobitz II): o padrão descrito é de disfunção sinusal (bradicardia/pausas), não de um bloqueio na condução AV.
• C) Complementar com Holter antes de indicar MPD: a pré-síncope já foi documentada durante o próprio ECG, correlacionando sintoma e achado — a indicação já está estabelecida, não sendo necessário postergar com mais exames.
• D) Marca-passo provisório até o definitivo por "bloqueio atrioventricular avançado": o diagnóstico correto do quadro é doença do nó sinusal, não um bloqueio AV avançado.'),

('866e9c66-9354-459b-b713-015423d14259', 'Bradiarritmia', 2014, 'TEC', 'Paciente feminina, 21 anos, assintomática (CF I-NYHA), com BAV total congênito. Ao Holter, intensa atividade ectópica ventricular polimórfica com surtos de taquicardia ventricular não sustentada. FC máxima no ergométrico de 69 bpm. Ecocardiograma sem cardiopatia, função biventricular preservada. Qual a conduta clínica a ser adotada?', 'Está indicado implante de marca-passo definitivo, sendo o modo DDDR o ideal: preserva a sincronia entre átrio e ventrículo e ajusta a frequência cardíaca conforme a necessidade, o mais fisiológico para BAV total.', 'Para esta paciente jovem (21 anos) com Bloqueio Atrioventricular Total congênito assintomático, mas com evidência de arritmia ventricular significativa (taquicardia ventricular não sustentada ao Holter), a indicação de marca-passo definitivo é uma classe de recomendação I.

O modo DDDR é o ideal porque é o mais fisiológico para pacientes com BAV total: permite sensoriamento e estimulação tanto no átrio quanto no ventrículo, preservando a sincronia atrioventricular (fundamental para manter o débito cardíaco adequado, especialmente durante atividades físicas) e possui resposta de frequência (R), essencial para que o marca-passo ajuste a frequência cardíaca conforme a necessidade metabólica da paciente (já que o nó sinusal está íntegro, mas a condução AV está bloqueada).

Por que as outras alternativas estão incorretas:
• A) VVIR: estimula apenas o ventrículo sem sincronia com o átrio, o que pode levar à "síndrome do marca-passo" (perda da contribuição atrial, desconforto hemodinâmico e risco de fibrilação atrial).
• C) Apenas acompanhamento regular: incorreta, pois a presença de taquicardia ventricular não sustentada em paciente com BAV total é marcador de instabilidade elétrica e risco, não um quadro benigno para somente observar.
• D) AAIR: não é adequado para BAV total, pois esse modo estimula apenas o átrio e não resolveria o bloqueio de condução AV.
• E) Cardioversor-desfibrilador: embora a paciente apresente TVNS, o tratamento de escolha inicial para estabilizar o sistema de condução e reduzir o risco arrítmico secundário à bradicardia crônica é o marca-passo, não sendo o CDI a primeira linha para uma paciente jovem sem cardiopatia estrutural e sem TV sustentada documentada.'),

('64fd416c-5e1e-4301-8a8a-54b17b63c435', 'Bradiarritmia', 2016, 'TEC', 'Paciente com 58 anos refere tontura e apresenta diagnóstico de IAM de parede inferior e frequência cardíaca de 32 bpm, com ritmo de bloqueio atrioventricular total e escape de QRS largo. PA de admissão 100x60 mmHg. A MELHOR conduta inicial é:', 'Diante de BAVT com escape de QRS largo (sugerindo bloqueio mais baixo, infra-hissiano) e frequência muito baixa com hipoperfusão, a conduta imediata é o implante de marca-passo temporário transvenoso.', 'Esta é uma questão clássica de emergência cardiológica que exige a identificação do manejo correto em um cenário de instabilidade hemodinâmica aguda secundária a uma bradiarritmia. O paciente apresenta um Infarto Agudo do Miocárdio (IAM) de parede inferior complicado com Bloqueio Atrioventricular Total (BAVT) e um ritmo de escape de QRS largo (infra-hissiano).

No IAM de parede inferior, o BAVT costuma ser supra-hissiano (o nó AV é irrigado pela artéria coronária direita). Contudo, a presença de um escape de QRS largo sugere que o bloqueio se localiza mais abaixo (infra-hissiano), o que é um marcador de maior risco e instabilidade. Como a frequência cardíaca está muito baixa (32 bpm) e há sinais de hipoperfusão (tontura, PA limítrofe de 100x60 mmHg), a estimulação elétrica é mandatória. O marca-passo transvenoso temporário é a medida de escolha imediata para estabilizar a frequência cardíaca e garantir o débito cardíaco enquanto se aguarda a reperfusão da artéria responsável pelo infarto ou a possível resolução do quadro.

Por que as outras alternativas estão incorretas:
• A) Atropina endovenosa: tende a ser ineficaz em bloqueios de localização mais baixa (infra-hissiana), como sugerido pelo QRS largo do escape.
• B) Marca-passo definitivo: não é a conduta INICIAL num cenário agudo de IAM — primeiro estabiliza-se com o transvenoso temporário.
• D) Cirurgia de revascularização urgente: não é a conduta imediata prioritária diante da instabilidade elétrica aguda, que exige estabilização elétrica primeiro.
• E) Observação clínica: inadequada diante de bradicardia extrema (32 bpm) com sinais de hipoperfusão — a estimulação elétrica é mandatória, não se deve apenas observar.'),

('83be3847-99ee-4b35-87a3-384341f1007c', 'Bradiarritmia', 2018, 'TEC', 'Em várias situações, está indicado o uso de atropina para o tratamento agudo de bradiarritmias. Assinale a situação clínica em que o uso de atropina esteja CONTRAINDICADO:', 'A atropina é ineficaz e potencialmente contraindicada no BAV de 3º grau com suspeita de comprometimento infra-hissiano (Sistema de His-Purkinje) — ela atua bloqueando o vago no nó AV, mas o problema nesse caso está abaixo do nó AV, onde ela não tem ação.', 'Esta questão aborda a segurança e a eficácia da atropina no tratamento agudo de bradiarritmias, um conceito fundamental na emergência cardiológica. A atropina atua bloqueando o efeito do nervo vago no nó atrioventricular (nó AV). Em bloqueios atrioventriculares de 3º grau (BAV Total) com escape de QRS largo, a falha na condução ocorre abaixo do nó AV, no Sistema de His-Purkinje (nível infra-hissiano). Como a atropina não atua abaixo do nó AV, ela é ineficaz nesses casos — além disso, existe o risco teórico de a atropina aumentar a frequência atrial e, consequentemente, a demanda de oxigênio do miocárdio sem melhorar a condução ventricular, o que pode piorar a estabilidade hemodinâmica do paciente. Nessas situações, a conduta correta é a estimulação cardíaca artificial (marca-passo), não o uso de drogas.

Por que as outras alternativas NÃO são a contraindicada (a atropina pode ser tentada nesses cenários):
• A) BAV de 3º grau relacionado a IAM inferior: nesse contexto o bloqueio costuma ser supra-hissiano (nó AV irrigado pela coronária direita), onde a atropina pode ter alguma eficácia.
• C) BAV de 2º grau relacionado a IAM inferior: também tende a ser supra-hissiano, respondendo melhor à atropina do que os bloqueios infra-hissianos.
• D) Bradicardia sinusal sintomática: é justamente uma das principais indicações de atropina, que age bem no próprio nó sinusal.
• E) Bloqueio sinoatrial sintomático: também tende a responder à atropina, que atua no tônus vagal sobre o nó sinusal.'),

('c6c6db4c-a3d3-4bc0-a53d-b41bca46654a', 'Bradiarritmia', 2023, 'TEC', 'Segundo a Diretriz Brasileira de Dispositivos Cardíacos Eletrônicos Implantáveis – 2023, é recomendação para estimulação fisiológica (feixe de His, ramo esquerdo) para tratamento de bradiarritmias:', 'Em pacientes com fibrilação atrial permanente que necessitam de ablação da junção atrioventricular para controle de frequência, a estimulação fisiológica (feixe de His ou ramo esquerdo) é indicada para manter a ativação ventricular sincrônica e preservar a função do VE.', 'De acordo com a Diretriz Brasileira de Dispositivos Cardíacos Eletrônicos Implantáveis de 2023, a estimulação fisiológica do sistema de condução (feixe de His ou ramo esquerdo) é uma estratégia crescente para evitar os efeitos deletérios da estimulação ventricular direita convencional (apical), que pode induzir dessincronia e, consequentemente, cardiomiopatia induzida por marca-passo. Em pacientes com fibrilação atrial (FA) permanente que necessitam de ablação da junção atrioventricular (AV) para controle da frequência cardíaca (por falha do tratamento farmacológico), a estimulação fisiológica é uma excelente indicação para manter a ativação ventricular sincrônica e preservar a função sistólica do ventrículo esquerdo.

Por que as outras alternativas estão incorretas:
• B) Bloqueio de ramo completo alternante: é indicação de marca-passo em si (pelo altíssimo risco de BAVT), mas não é especificamente listado como a recomendação clássica de estimulação fisiológica citada na diretriz da forma pedida pela questão.
• C) Bloqueio trifascicular em amiloidose cardíaca: é um cenário de alto risco de bloqueio, mas não a indicação clássica citada para estimulação fisiológica do sistema de condução.
• D) BAV com disfunção sistólica biventricular: nesse caso a discussão terapêutica giraria mais em torno de terapia de ressincronização cardíaca (TRC) tradicional, não necessariamente da estimulação fisiológica descrita.
• E) BRD associado a bloqueio divisional póstero-inferior do ramo esquerdo: representa um bloqueio bifascicular, cujo manejo depende de outros fatores (sintomas, síncope) e não é, isoladamente, a indicação clássica de estimulação fisiológica citada.'),

('9a31f3b1-431c-4d92-9c32-d9989f5bac22', 'Bradiarritmia', 2025, 'TEC', 'Em relação ao implante de marcapasso é correto afirmar:', 'Na distrofia muscular miotônica, mesmo pacientes assintomáticos com BAV de 1º grau (PR > 240 ms) ou QRS alargado (> 120 ms) têm indicação de marca-passo definitivo, pelo alto risco de bloqueios súbitos e morte súbita nessa doença.', 'Esta questão aborda indicações específicas de marca-passo em situações clínicas particulares. Na distrofia muscular miotônica (tipo 1), o sistema de condução cardíaco é frequentemente afetado de forma progressiva e imprevisível, com alto risco de bloqueios atrioventriculares súbitos e arritmias ventriculares malignas. Devido a esse risco elevado e à possibilidade de morte súbita, a presença de alterações na condução — mesmo que o paciente esteja assintomático —, como BAV de 1º grau com PR longo (> 240 ms) ou QRS largo (> 120 ms), constitui indicação formal (Classe IIa/IIb dependendo da diretriz) para o implante de marca-passo definitivo, visando prevenção.

Por que as outras alternativas estão incorretas:
• A) Cardiomiopatia hipertrófica obstrutiva com sintomas refratários: a primeira escolha nesses casos costuma ser miectomia septal ou ablação septal alcoólica, não o marca-passo bicameral como primeira escolha.
• B) Disfunção do nó atrioventricular como causa mais comum no transplantado: no paciente transplantado, a causa mais comum de bradiarritmia costuma estar relacionada à disfunção do nó SINUSAL (por lesão durante a cirurgia/denervação), não do nó AV.
• C) Bradiarritmias noturnas por apneia do sono sem tratamento específico: a conduta correta nesse cenário é tratar a apneia (CPAP), não implantar marca-passo antes de tentar essa medida.
• D) Indicação primária de marca-passo para prevenção de morte súbita na Síndrome do QT Longo Congênito: a prevenção de morte súbita nessa síndrome é feita primariamente com betabloqueadores e, em casos refratários, com CDI — não com marca-passo isolado.'),

('3e76f1dc-86d5-4589-a10e-a9702d8d6509', 'Bradiarritmia', 2016, 'TEC', 'Em relação a bloqueios atrioventriculares (BAV) que se manifestam durante o infarto agudo do miocárdio (IAM), assinalar a alternativa correta:', 'Bloqueios de condução intraventricular e o bloqueio Mobitz II durante o IAM são sinais premonitórios de progressão para bloqueio atrioventricular total, pois indicam dano ao sistema de condução abaixo do nó AV (infra-hissiano).', 'Esta questão aborda a estratificação de risco em pacientes que desenvolvem bloqueios atrioventriculares (BAV) no contexto do Infarto Agudo do Miocárdio (IAM). No IAM, a presença de bloqueios infranodais (como o Mobitz II e bloqueios de ramo, que indicam dano ao sistema de condução abaixo do nó AV, ou seja, no feixe de His ou seus ramos) é um marcador de alto risco para progressão súbita para Bloqueio Atrioventricular Total (BAVT) e assistolia. Por isso, são considerados sinais "premonitórios".

Por que as outras alternativas estão incorretas:
• B) Marca-passo com desfibrilador (CDI) não é o dispositivo de rotina indicado simplesmente pelo desenvolvimento de BAV de alto grau no IAM agudo — a conduta imediata é estimulação temporária, e a decisão sobre CDI depende de avaliação posterior da função ventricular e do risco arrítmico residual.
• C) Os bloqueios intranodais (dentro do próprio nó AV) são, na maioria das vezes, associados a infartos de parede INFERIOR (irrigados pela coronária direita), não anterosseptais.
• D) BAV na vigência de infarto de parede inferior costuma ser transitório e de bom prognóstico na maioria dos casos, não configurando indicação formal automática de marca-passo definitivo apenas por essa localização.
• E) Bloqueios infranodais têm relação direta e importante com a mortalidade do paciente, justamente por indicarem maior extensão de dano ao sistema de condução (geralmente em infartos anteriores extensos).');

insert into public.question_options (id, question_id, letra, texto, correta) values
(gen_random_uuid(), 'd32573c2-25f1-4019-9dd1-bf1f71134c6c', 'a', 'Undersensing ventricular.', false),
(gen_random_uuid(), 'd32573c2-25f1-4019-9dd1-bf1f71134c6c', 'b', 'Falha de captura ventricular.', true),
(gen_random_uuid(), 'd32573c2-25f1-4019-9dd1-bf1f71134c6c', 'c', 'Falha de captura atrial e ventricular.', false),
(gen_random_uuid(), 'd32573c2-25f1-4019-9dd1-bf1f71134c6c', 'd', 'Undersensing atrial.', false),
(gen_random_uuid(), 'd32573c2-25f1-4019-9dd1-bf1f71134c6c', 'e', 'Taquicardia mediada pelo marcapasso.', false),

(gen_random_uuid(), '6ca5766b-5efc-41c2-8879-c855d86e4b56', 'a', 'Pausa sinusal (síndrome bradicardia-taquicardia). Indicação de implante de marcapasso definitivo.', true),
(gen_random_uuid(), '6ca5766b-5efc-41c2-8879-c855d86e4b56', 'b', 'Bloqueio atrioventricular Mobitz I. Avaliar evolutivamente a necessidade de implante de marcapasso definitivo.', false),
(gen_random_uuid(), '6ca5766b-5efc-41c2-8879-c855d86e4b56', 'c', 'Bloqueio atrioventricular total. Indicação de marcapasso definitivo em caráter de emergência.', false),
(gen_random_uuid(), '6ca5766b-5efc-41c2-8879-c855d86e4b56', 'd', 'Bloqueio sinoatrial Mobitz II. Observação e investigação clínica e avaliar posterior indicação de implante de marcapasso.', false),
(gen_random_uuid(), '6ca5766b-5efc-41c2-8879-c855d86e4b56', 'e', 'Bloqueio atrioventricular avançado. Indicação de marcapasso definitivo em caráter de emergência.', false),

(gen_random_uuid(), '97163364-1910-4e79-87da-d8acfa65c544', 'a', 'Realização de Holter de 24 horas e indicação de marca-passo se houver pausa superior a três segundos.', false),
(gen_random_uuid(), '97163364-1910-4e79-87da-d8acfa65c544', 'b', 'Implante de marca-passo definitivo.', true),
(gen_random_uuid(), '97163364-1910-4e79-87da-d8acfa65c544', 'c', 'Acompanhamento clínico e indicação de marca-passo definitivo quando ocorrerem sintomas.', false),
(gen_random_uuid(), '97163364-1910-4e79-87da-d8acfa65c544', 'd', 'Realização de estudo eletrofisiológico para avaliar a necessidade de indicação de marca-passo.', false),
(gen_random_uuid(), '97163364-1910-4e79-87da-d8acfa65c544', 'e', 'Avaliação da fração de ejeção e, se inferior a 40%, indicar marca-passo.', false),

(gen_random_uuid(), '01a85324-e737-4ef1-bc26-f09a3450fe8c', 'a', 'Presença de arritmia ventricular complexa.', false),
(gen_random_uuid(), '01a85324-e737-4ef1-bc26-f09a3450fe8c', 'b', 'Intervalo QTc aumentado.', false),
(gen_random_uuid(), '01a85324-e737-4ef1-bc26-f09a3450fe8c', 'c', 'Frequência cardíaca menor que 70 bpm em repouso.', true),
(gen_random_uuid(), '01a85324-e737-4ef1-bc26-f09a3450fe8c', 'd', 'Intolerância ao esforço físico e disfunção ventricular esquerda.', false),
(gen_random_uuid(), '01a85324-e737-4ef1-bc26-f09a3450fe8c', 'e', 'Presença de QRS largo.', false),

(gen_random_uuid(), 'ad0e5096-5abc-4dfa-9ceb-430d33b7a1d2', 'a', 'Trata-se de bloqueio atrioventricular (AV) avançado paroxístico. Indicado implante de marca-passo definitivo dupla-câmara.', false),
(gen_random_uuid(), 'ad0e5096-5abc-4dfa-9ceb-430d33b7a1d2', 'b', 'Trata-se de bloqueio AV total intermitente. Indicado implante de marca-passo definitivo dupla-câmara.', false),
(gen_random_uuid(), 'ad0e5096-5abc-4dfa-9ceb-430d33b7a1d2', 'c', 'Trata-se de síndrome bradi-taqui (disfunção sinusal). Indicado implante de marca-passo dupla-câmara e medidas profiláticas de tromboembolismo.', true),
(gen_random_uuid(), 'ad0e5096-5abc-4dfa-9ceb-430d33b7a1d2', 'd', 'Trata-se de síndrome bradi-taqui (disfunção sinusal). Indicado implante de marca-passo ressincronizador e medidas profiláticas de tromboembolismo.', false),
(gen_random_uuid(), 'ad0e5096-5abc-4dfa-9ceb-430d33b7a1d2', 'e', 'Indicação de MPD pelo diagnóstico de doença do nó sinusal.', false),

(gen_random_uuid(), '3d941793-5ed4-457c-bf9d-144cdc294295', 'a', 'Paciente com diagnóstico de doença do nó sinusal e indicação classe I de implante de marca-passo definitivo.', false),
(gen_random_uuid(), '3d941793-5ed4-457c-bf9d-144cdc294295', 'b', 'Paciente com diagnóstico de doença do nó sinusal e indicação classe IIa de implante de marca-passo definitivo.', false),
(gen_random_uuid(), '3d941793-5ed4-457c-bf9d-144cdc294295', 'c', 'Modificar o medicamento anti-hipertensivo e reavaliar necessidade de implante de marca-passo definitivo.', true),
(gen_random_uuid(), '3d941793-5ed4-457c-bf9d-144cdc294295', 'd', 'Modificar o medicamento anti-hipertensivo e implantar marca-passo definitivo.', false),
(gen_random_uuid(), '3d941793-5ed4-457c-bf9d-144cdc294295', 'e', 'Manter o medicamento anti-hipertensivo e implantar marca-passo definitivo.', false),

(gen_random_uuid(), '17c9d7af-2edb-4fc1-9241-76700ba1fe2b', 'a', 'Bradicardia sinusal. Administração de atropina 1 mg IV.', false),
(gen_random_uuid(), '17c9d7af-2edb-4fc1-9241-76700ba1fe2b', 'b', 'Bloqueio atrioventricular de segundo grau Mobitz II. Implante de marca-passo provisório e posterior implante de marca-passo definitivo.', false),
(gen_random_uuid(), '17c9d7af-2edb-4fc1-9241-76700ba1fe2b', 'c', 'Bloqueio atrioventricular de segundo grau avançado. Administração de atropina, 1 mg IV.', false),
(gen_random_uuid(), '17c9d7af-2edb-4fc1-9241-76700ba1fe2b', 'd', 'Bloqueio atrioventricular de segundo grau avançado. Implante de marca-passo provisório e posterior implante de marca-passo definitivo.', false),
(gen_random_uuid(), '17c9d7af-2edb-4fc1-9241-76700ba1fe2b', 'e', 'Bloqueio atrioventricular total. Implante de marca-passo provisório e posterior implante de marca-passo definitivo.', true),

(gen_random_uuid(), '0e516885-ee23-467d-bf0e-e039355a0f6d', 'a', 'Trata-se de um bloqueio atrioventricular de 2º grau tipo I, o que normalmente não deve ser considerado de alto risco em pacientes assintomáticos.', true),
(gen_random_uuid(), '0e516885-ee23-467d-bf0e-e039355a0f6d', 'b', 'Trata-se de um bloqueio atrioventricular de 2º grau tipo Wenckebach, que apresenta localização anatômica mais provável no feixe de His.', false),
(gen_random_uuid(), '0e516885-ee23-467d-bf0e-e039355a0f6d', 'c', 'Trata-se de um bloqueio atrioventricular de 2º grau tipo II, que tem sua localização anatômica mais frequente no nó atrioventricular.', false),
(gen_random_uuid(), '0e516885-ee23-467d-bf0e-e039355a0f6d', 'd', 'Essa manifestação eletrocardiográfica é típica de distúrbio no sistema His-Purkinje.', false),
(gen_random_uuid(), '0e516885-ee23-467d-bf0e-e039355a0f6d', 'e', 'Trata-se de bloqueio atrioventricular do 2° grau fisiológico, secundário à extrassístole atrial, o que pode ser causado por uso crônico de betabloqueador e/ou digoxina.', false),

(gen_random_uuid(), '51f2bbf7-b3ea-4bdf-b66f-d0f6f990331c', 'a', 'Seis semanas após o implante do dispositivo.', true),
(gen_random_uuid(), '51f2bbf7-b3ea-4bdf-b66f-d0f6f990331c', 'b', 'Após um período mínimo de trinta dias sem sintomas.', false),
(gen_random_uuid(), '51f2bbf7-b3ea-4bdf-b66f-d0f6f990331c', 'c', 'O paciente deve ser definitivamente afastado de sua atividade profissional.', false),
(gen_random_uuid(), '51f2bbf7-b3ea-4bdf-b66f-d0f6f990331c', 'd', 'O prazo de retorno ao trabalho é variável, depende da função ventricular e da presença de comorbidades.', false),
(gen_random_uuid(), '51f2bbf7-b3ea-4bdf-b66f-d0f6f990331c', 'e', 'Indicado implante de cardioversor-desfibrilador em função da arritmia documentada ao Holter de 24 horas.', false),

(gen_random_uuid(), '5d21c0ee-1a99-4017-8ebe-84f8ecb8f419', 'a', 'câmara sentida.', false),
(gen_random_uuid(), '5d21c0ee-1a99-4017-8ebe-84f8ecb8f419', 'b', 'câmara estimulada.', false),
(gen_random_uuid(), '5d21c0ee-1a99-4017-8ebe-84f8ecb8f419', 'c', 'estimulação multissítio.', false),
(gen_random_uuid(), '5d21c0ee-1a99-4017-8ebe-84f8ecb8f419', 'd', 'resposta à sensibilidade.', true),
(gen_random_uuid(), '5d21c0ee-1a99-4017-8ebe-84f8ecb8f419', 'e', 'modulação de frequência.', false),

(gen_random_uuid(), 'e7d020da-de89-4e4f-98b2-8fda8a73905a', 'a', 'marca-passo atrial ectópico.', false),
(gen_random_uuid(), 'e7d020da-de89-4e4f-98b2-8fda8a73905a', 'b', 'bloqueio atrioventricular de segundo grau tipo I.', false),
(gen_random_uuid(), 'e7d020da-de89-4e4f-98b2-8fda8a73905a', 'c', 'bloqueio atrioventricular de segundo grau tipo II.', true),
(gen_random_uuid(), 'e7d020da-de89-4e4f-98b2-8fda8a73905a', 'd', 'arritmia sinusal com pausa superior a 3 segundos.', false),
(gen_random_uuid(), 'e7d020da-de89-4e4f-98b2-8fda8a73905a', 'e', 'bradicardia sinusal com frequência entre 35-40 batimentos por minuto.', false),

(gen_random_uuid(), 'a649b4c4-b85e-4113-b299-f4d5672b1da7', 'a', 'Bloqueio atrioventricular (AV) total. Implante de marca-passo definitivo.', false),
(gen_random_uuid(), 'a649b4c4-b85e-4113-b299-f4d5672b1da7', 'b', 'Bloqueio atrioventricular (AV) segundo grau 2:1. Implante de marca-passo provisório e posterior implante de marca-passo definitivo.', true),
(gen_random_uuid(), 'a649b4c4-b85e-4113-b299-f4d5672b1da7', 'c', 'Bloqueio atrioventricular (AV) de segundo grau Mobitz II, atropina venosa e implante de marca-passo definitivo.', false),
(gen_random_uuid(), 'a649b4c4-b85e-4113-b299-f4d5672b1da7', 'd', 'Bloqueio atrioventricular (AV) segundo grau Mobitz I. Implante de marca-passo provisório e posterior implante de marca-passo definitivo.', false),
(gen_random_uuid(), 'a649b4c4-b85e-4113-b299-f4d5672b1da7', 'e', 'Bradicardia sinusal sintomática. Atropina venosa.', false),

(gen_random_uuid(), '52780979-b792-4eb6-8df4-e02292ccab55', 'a', 'Está indicado o implante de marcapasso definitivo unicameral atrial.', false),
(gen_random_uuid(), '52780979-b792-4eb6-8df4-e02292ccab55', 'b', 'Está indicado o implante de marcapasso definitivo unicameral ventricular.', false),
(gen_random_uuid(), '52780979-b792-4eb6-8df4-e02292ccab55', 'c', 'Está indicado o implante de marcapasso definitivo bicameral (atrioventricular).', false),
(gen_random_uuid(), '52780979-b792-4eb6-8df4-e02292ccab55', 'd', 'Está indicado o estudo eletrofisiológico para avaliação do intervalo HV e implante de marcapasso definitivo.', false),
(gen_random_uuid(), '52780979-b792-4eb6-8df4-e02292ccab55', 'e', 'Paciente deve permanecer em acompanhamento clínico regular sem indicação de medidas adicionais no momento.', true),

(gen_random_uuid(), '19396bda-af5f-40e2-b96d-1ae8cb103a7e', 'a', 'Indicação de implante de marca-passo definitivo (MPD) ventricular por síndrome de QT longo.', false),
(gen_random_uuid(), '19396bda-af5f-40e2-b96d-1ae8cb103a7e', 'b', 'Diagnóstico de bloqueio atrioventricular tipo II (Mobitz II) e indicação de MPD.', false),
(gen_random_uuid(), '19396bda-af5f-40e2-b96d-1ae8cb103a7e', 'c', 'Complementar avaliação com Holter antes de indicar o implante de MPD.', false),
(gen_random_uuid(), '19396bda-af5f-40e2-b96d-1ae8cb103a7e', 'd', 'Indicação de marca-passo provisório até o implante de MPD por bloqueio atrioventricular avançado.', false),
(gen_random_uuid(), '19396bda-af5f-40e2-b96d-1ae8cb103a7e', 'e', 'Indicação de MPD pelo diagnóstico de doença do nó sinusal.', true),

(gen_random_uuid(), '866e9c66-9354-459b-b713-015423d14259', 'a', 'Indicado implante de marca-passo definitivo, sendo o modo VVIR o modo ideal de estimulação para essa paciente.', false),
(gen_random_uuid(), '866e9c66-9354-459b-b713-015423d14259', 'b', 'Indicado implante de marca-passo definitivo, sendo o modo DDDR o modo ideal de estimulação para essa paciente.', true),
(gen_random_uuid(), '866e9c66-9354-459b-b713-015423d14259', 'c', 'Indicado acompanhamento regular pelo fato de a paciente ser assintomática e não apresentar cardiopatia estrutural.', false),
(gen_random_uuid(), '866e9c66-9354-459b-b713-015423d14259', 'd', 'Indicado implante de marca-passo definitivo, sendo o modo AAIR o modo ideal de estimulação para essa paciente.', false),
(gen_random_uuid(), '866e9c66-9354-459b-b713-015423d14259', 'e', 'Indicado implante de cardioversor-desfibrilador em função da arritmia documentada ao Holter de 24 horas.', false),

(gen_random_uuid(), '64fd416c-5e1e-4301-8a8a-54b17b63c435', 'a', 'Atropina endovenosa.', false),
(gen_random_uuid(), '64fd416c-5e1e-4301-8a8a-54b17b63c435', 'b', 'Implante de marca-passo definitivo.', false),
(gen_random_uuid(), '64fd416c-5e1e-4301-8a8a-54b17b63c435', 'c', 'Implante de marca-passo temporário transvenoso.', true),
(gen_random_uuid(), '64fd416c-5e1e-4301-8a8a-54b17b63c435', 'd', 'Indicação urgente de cirurgia de revascularização miocárdica.', false),
(gen_random_uuid(), '64fd416c-5e1e-4301-8a8a-54b17b63c435', 'e', 'Observação clínica.', false),

(gen_random_uuid(), '83be3847-99ee-4b35-87a3-384341f1007c', 'a', 'Bloqueio atrioventricular (AV) de 3° grau relacionado com infarto agudo do miocárdio inferior.', false),
(gen_random_uuid(), '83be3847-99ee-4b35-87a3-384341f1007c', 'b', 'Bloqueio atrioventricular (AV) de 3° grau, com suspeita de comprometimento do Sistema de His-Purkinje.', true),
(gen_random_uuid(), '83be3847-99ee-4b35-87a3-384341f1007c', 'c', 'Bloqueio atrioventricular (AV) de 2° grau relacionado com infarto agudo do miocárdio inferior.', false),
(gen_random_uuid(), '83be3847-99ee-4b35-87a3-384341f1007c', 'd', 'Bradicardia sinusal sintomática.', false),
(gen_random_uuid(), '83be3847-99ee-4b35-87a3-384341f1007c', 'e', 'Bloqueio sinoatrial sintomático.', false),

(gen_random_uuid(), 'c6c6db4c-a3d3-4bc0-a53d-b41bca46654a', 'a', 'Fibrilação atrial permanente com indicação de ablação da junção atrioventricular para controle da frequência cardíaca.', true),
(gen_random_uuid(), 'c6c6db4c-a3d3-4bc0-a53d-b41bca46654a', 'b', 'Bloqueio de ramo completo alternante.', false),
(gen_random_uuid(), 'c6c6db4c-a3d3-4bc0-a53d-b41bca46654a', 'c', 'Bloqueio trifascicular em pacientes com amiloidose cardíaca.', false),
(gen_random_uuid(), 'c6c6db4c-a3d3-4bc0-a53d-b41bca46654a', 'd', 'Bloqueio atrioventricular com disfunção sistólica biventricular.', false),
(gen_random_uuid(), 'c6c6db4c-a3d3-4bc0-a53d-b41bca46654a', 'e', 'Bloqueio de ramo direito associado com bloqueio divisional póstero-inferior do ramo esquerdo.', false),

(gen_random_uuid(), '9a31f3b1-431c-4d92-9c32-d9989f5bac22', 'a', 'Em geral, pacientes com cardiomiopatia hipertrófica obstrutiva, com sintomas refratários ao tratamento farmacológico, devem ser considerados para implante de marcapasso bicameral como primeira escolha.', false),
(gen_random_uuid(), '9a31f3b1-431c-4d92-9c32-d9989f5bac22', 'b', 'A disfunção do nó atrioventricular é a causa mais comumente encontrada no paciente transplantado.', false),
(gen_random_uuid(), '9a31f3b1-431c-4d92-9c32-d9989f5bac22', 'c', 'Pacientes com bradiarritmias noturnas, sem cardiopatia, assintomáticos no período de vigília, com síndrome de apneia obstrutiva do sono nos quais não foi realizado o tratamento específico podem receber marcapasso cardíaco.', false),
(gen_random_uuid(), '9a31f3b1-431c-4d92-9c32-d9989f5bac22', 'd', 'Há indicação primária de implante de marcapasso para prevenção de morte súbita na Síndrome do QT Longo Congênito.', false),
(gen_random_uuid(), '9a31f3b1-431c-4d92-9c32-d9989f5bac22', 'e', 'Pacientes com bloqueio atrioventricular de 1º (PR > 240 ms) ou QRS alargado (QRS > 120 ms) assintomáticos (na distrofia muscular miotônica) têm indicação de marcapasso definitivo.', true),

(gen_random_uuid(), '3e76f1dc-86d5-4589-a10e-a9702d8d6509', 'a', 'Bloqueio da condução intraventricular e bloqueio do tipo Mobitz II são premonitórios de BAV total.', true),
(gen_random_uuid(), '3e76f1dc-86d5-4589-a10e-a9702d8d6509', 'b', 'Marca-passo com desfibrilador deve ser implantado em pacientes que desenvolvem BAV de alto grau.', false),
(gen_random_uuid(), '3e76f1dc-86d5-4589-a10e-a9702d8d6509', 'c', 'Os bloqueios intranodais são, na maioria das vezes, causados por infartos anterosseptais.', false),
(gen_random_uuid(), '3e76f1dc-86d5-4589-a10e-a9702d8d6509', 'd', 'BAV na vigência de infarto de parede inferior ou inferodorsal é indicação formal de marca-passo definitivo.', false),
(gen_random_uuid(), '3e76f1dc-86d5-4589-a10e-a9702d8d6509', 'e', 'Bloqueios infranodais não guardam relação com a mortalidade do paciente.', false);
