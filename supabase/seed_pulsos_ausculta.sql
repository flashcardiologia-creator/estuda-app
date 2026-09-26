-- Novo conteúdo: temas "Pulsos" e "Ausculta" (cardiologia), banca TEC.
-- Rode este arquivo uma vez no SQL Editor do seu projeto Supabase.
--
-- IMPORTANTE — questões que dependiam de imagem/diagrama foram OMITIDAS,
-- porque o app só suporta texto no enunciado (sem upload de imagem):
--   Pulsos: questão 1 (diagrama de bulhas) e questão 2 (onda de pulso venoso)
--   Ausculta: questão 23 (diagrama do sopro com A2/P2)
--
-- Também sinalizo uma correção: em "Ausculta" questão 21 (estenose mitral),
-- o gabarito original do documento indicava "E", mas a alternativa B é que
-- descreve corretamente a estenose mitral (hiperfonese de B1, estalido de
-- abertura, sopro diastólico em ruflar com reforço pré-sistólico e B2
-- hiperfonética); usei B como correta abaixo. Se você tiver o gabarito
-- oficial e discordar, me avise que eu ajusto.

-- ============================================================
-- Tema: Pulsos
-- ============================================================

insert into public.questions (id, tema, ano, instituicao, enunciado, comentario) values
('41319994-aef5-47ef-9846-8040b0c3e4fa', 'Pulsos', 2018, 'TEC', 'Paciente do sexo feminino, 55 anos de idade, submetida à mastectomia esquerda há 2 anos por neoplasia maligna, seguida de radioterapia e quimioterapia, com boa evolução. Há 15 dias, começou a ter dispneia rapidamente progressiva, chegando à dispneia de repouso há 2 dias, além de palpitações e mal-estar indefinido, motivo pelo qual procurou serviço médico de urgência. Negava dores torácicas e edema de membros inferiores. Ao exame físico: taquipneica; pressão arterial (PA) = 100 x 80 mmHg (durante inspiração profunda 80 x 60 mmHg); frequência cardíaca (FC) = 100 bpm, rítmico; pescoço: estase jugular 3+/4+ a 45°; ausculta cardíaca: bulhas rítmicas hipofonéticas sem sopros; pulmões livres; abdômen e membros inferiores sem alterações ao exame físico. Foi solicitado o eletrocardiograma. Assinale a alternativa CORRETA em relação à investigação diagnóstica e à abordagem clínica.', 'Tamponamento cardíaco: tríade de hipotensão, estase jugular e bulhas hipofonéticas (tríade de Beck), associada a pulso paradoxal (queda da PA sistólica >10 mmHg na inspiração) e alternância elétrica no ECG. Confirma-se com ecocardiograma (derrame com compressão de câmaras direitas) e trata-se com drenagem/pericardiocentese, além de investigar a etiologia (neste caso, provável recidiva neoplásica ou pericardite actínica).'),
('a6c3bef0-73dc-4d78-a96e-e4252f00fd91', 'Pulsos', 2012, 'TEC', 'Em relação ao desdobramento da segunda bulha, pode-se afirmar:', 'No bloqueio de ramo esquerdo, o atraso na ativação elétrica do ventrículo esquerdo retarda o fechamento da valva aórtica, fazendo com que o componente pulmonar (P2) preceda o aórtico (A2) — chamado de desdobramento paradoxal, que fica mais evidente na expiração (o oposto do desdobramento fisiológico).'),
('019c4815-2dc4-411e-a9ee-e778a08465f2', 'Pulsos', 2014, 'TEC', 'Sobre as ondas de pulso venoso, podemos afirmar que:', 'Onda "a" proeminente (ou "em canhão") reflete contração atrial direita contra resistência aumentada, podendo ser vista em situações de hipertensão pulmonar aguda, como na embolia pulmonar maciça, ou em estenose tricúspide.'),
('fbfecf1e-c709-42fd-97aa-640775ac5e83', 'Pulsos', 2019, 'TEC', 'Paciente de 65 anos, com antecedente de neoplasia de pulmão ressecada há dois anos, com queixa de dispneia ao repouso. Durante a avaliação clínica, observou-se frequência cardíaca de 110 bpm e medida de pressão arterial de 110 x 80 mmHg na expiração e 92 x 70 mmHg durante a inspiração. Baseado nesses achados, é correto afirmar que:', 'A queda da PA sistólica maior que 10 mmHg durante a inspiração define pulso paradoxal. Classicamente associado a tamponamento cardíaco, também pode ocorrer em embolia pulmonar maciça e DPOC grave — relevante neste caso pelo antecedente oncológico.'),
('e2185ba1-e7b6-4061-b0a9-4a16e2978fd6', 'Pulsos', 2012, 'TEC', 'Em relação ao pulso alternante (pulsus alternans), pode-se afirmar:', 'O pulso alternante — alternância na amplitude de pulsos sucessivos com ritmo regular — é sinal de disfunção sistólica grave do ventrículo esquerdo, refletindo variação batimento a batimento do volume ejetado.'),
('bae813c8-fac0-47b3-b951-49d90184fd73', 'Pulsos', 2012, 'TEC', 'Em relação ao pulso venoso jugular são verdadeiras as assertivas a seguir, com EXCEÇÃO de:', 'A veia jugular INTERNA (não a externa) é a preferida para avaliação do pulso venoso, pois se comunica diretamente com o átrio direito; a jugular externa tem válvulas e trajeto tortuoso que podem distorcer a curva de pulso.'),
('7d973723-056b-4007-88ad-5f962c5f53c3', 'Pulsos', 2014, 'TEC', 'Várias situações podem evoluir com tamponamento cardíaco na ausência de pulso paradoxal. A exceção é:', 'Tamponamento sem pulso paradoxal ocorre em situações com desequilíbrio de pressões entre as câmaras: CIA, insuficiência aórtica importante, disfunção grave de VE e tamponamento localizado (coágulo pós-operatório). Já o derrame de etiologia neoplásica, por ser circunferencial e progressivo, costuma cursar com o pulso paradoxal clássico — sendo, portanto, a exceção pedida.'),
('d1e3f1e1-09b2-4683-8f63-699f3694b6b2', 'Pulsos', 2013, 'TEC', 'Em relação ao pulso venoso, assinale a alternativa correta:', 'A onda "a" do pulso venoso jugular representa a contração pré-sistólica do átrio direito: surge logo após a onda P do ECG e precede a primeira bulha cardíaca (fechamento das valvas atrioventriculares).'),
('11e7283e-cd26-45e1-b722-b0d311dcc86e', 'Pulsos', 2017, 'TEC', 'No exame do pulso venoso de um paciente, a onda "a" reflete:', 'A onda "a" representa a contração pré-sistólica do átrio direito, ocorrendo imediatamente antes da sístole ventricular.'),
('dde4d085-dd5d-421e-aadf-b0d691aa0b9f', 'Pulsos', 2013, 'TEC', 'Em relação à pericardite crônica constritiva, assinale a alternativa CORRETA:', 'Na pericardite constritiva, o pulso paradoxal ocorre em cerca de 1/3 dos casos. Predominam sinais de insuficiência cardíaca DIREITA; o sinal de Kussmaul é o AUMENTO (e não a redução) da estase jugular na inspiração; e o knock pericárdico é protodiastólico, não telediastólico.'),
('1f60af8f-cd6d-49d8-8d92-5407b74ea1d1', 'Pulsos', 2014, 'TEC', 'Após a discussão de um caso clínico, chegou-se à hipótese diagnóstica de arterite de Takayasu. Qual é provavelmente o(a) paciente da discussão?', 'A arterite de Takayasu ("doença sem pulso") acomete predominantemente mulheres jovens, causando estenoses de grandes vasos, assimetria de pulsos entre membros e sopros vasculares (como o axilar contínuo descrito).'),
('3e4ceee7-1990-444b-9e64-0277cfd5cdba', 'Pulsos', 2016, 'TEC', 'Paciente jovem, 15 anos, chegou ao serviço de emergência após uma síncope. No exame físico, foi observada redução da amplitude dos pulsos arteriais em membros inferiores e, na radiografia de tórax, sinais de erosão na região inferior de alguns arcos costais. O diagnóstico provável é:', 'A coarctação da aorta reduz os pulsos femorais/de membros inferiores (diferencial de pulso e de pressão entre membros superiores e inferiores) e gera circulação colateral pelas artérias intercostais, produzindo erosões costais características na radiografia de tórax ("sinal de Roesler").'),
('1756e645-84fa-4c35-9554-0abd96449051', 'Pulsos', 2017, 'TEC', 'Paciente queixa-se de cefaleia e fraqueza nas pernas aos esforços. Ao exame físico, apresentava sopro sistólico interescapular e ausência de pulsos em membros inferiores. A pressão arterial na artéria braquial era 150 mmHg e, na artéria poplítea, 135 mmHg. A principal suspeita clínica é:', 'A coarctação da aorta cursa com hipertensão em membros superiores, pulsos reduzidos/ausentes em membros inferiores (aqui evidenciado também pela pressão poplítea não maior que a braquial, quando o esperado é o contrário) e sopro sistólico interescapular pelo fluxo turbulento na estenose.');

insert into public.question_options (id, question_id, letra, texto, correta) values
(gen_random_uuid(), '41319994-aef5-47ef-9846-8040b0c3e4fa', 'a', 'A paciente apresenta quadro clínico de tamponamento cardíaco, que pode ser comprovado pelo ecocardiograma, mostrando espaço pericárdico maior que 20 mm e compressão de átrio e ventrículo direitos. Deve ser tratada com diurético de alça, oxigênio e repouso absoluto, com programação de abordagem cirúrgica pela rotina.', false),
(gen_random_uuid(), '41319994-aef5-47ef-9846-8040b0c3e4fa', 'b', 'A paciente apresenta quadro clínico de tamponamento cardíaco, com pulso paradoxal ao exame físico e alternância elétrica ao eletrocardiograma. Deve ser submetida a ecocardiograma para comprovação da presença de derrame pericárdico importante e, em seguida, drenagem.', true),
(gen_random_uuid(), '41319994-aef5-47ef-9846-8040b0c3e4fa', 'c', 'A paciente apresenta quadro clínico de pericardite constritiva. A estase jugular importante e a piora rápida da dispneia, além da hipofonese de bulhas e os antecedentes de radioterapia, tornam esse diagnóstico mais provável.', false),
(gen_random_uuid(), '41319994-aef5-47ef-9846-8040b0c3e4fa', 'd', 'A paciente apresenta quadro clínico de comprometimento miocárdico secundário à quimioterapia. Deve receber diurético de alça e oxigênio contínuo, além de betabloqueadores por causa da frequência cardíaca elevada.', false),
(gen_random_uuid(), '41319994-aef5-47ef-9846-8040b0c3e4fa', 'e', 'Após o eletrocardiograma, o exame de escolha seria a radiografia de tórax, que mostraria aumento global da área cardíaca com ampliação de hilos pulmonares e cefalização da trama vascular pulmonar.', false),

(gen_random_uuid(), 'a6c3bef0-73dc-4d78-a96e-e4252f00fd91', 'a', 'O fechamento da valva pulmonar precede a valva aórtica em indivíduos sadios.', false),
(gen_random_uuid(), 'a6c3bef0-73dc-4d78-a96e-e4252f00fd91', 'b', 'Portadores de comunicação interatrial (CIA) apresentam desdobramento constante e variável com a respiração.', false),
(gen_random_uuid(), 'a6c3bef0-73dc-4d78-a96e-e4252f00fd91', 'c', 'Portadores de bloqueio de ramo esquerdo (BRE) apresentam desdobramento paradoxal.', true),
(gen_random_uuid(), 'a6c3bef0-73dc-4d78-a96e-e4252f00fd91', 'd', 'Portadores de bloqueio de ramo direito têm desdobramento constante, não sendo modificado pelo padrão respiratório.', false),
(gen_random_uuid(), 'a6c3bef0-73dc-4d78-a96e-e4252f00fd91', 'e', 'A inspiração encurta o tempo de ejeção ventricular direita por reduzir a pressão em artéria pulmonar.', false),

(gen_random_uuid(), '019c4815-2dc4-411e-a9ee-e778a08465f2', 'a', 'No tamponamento cardíaco o descenso Y está acentuado.', false),
(gen_random_uuid(), '019c4815-2dc4-411e-a9ee-e778a08465f2', 'b', 'Bloqueio AV de primeiro grau pode gerar ondas A em canhão.', false),
(gen_random_uuid(), '019c4815-2dc4-411e-a9ee-e778a08465f2', 'c', 'Sinal de Kussmaul é patognomônico de pericardite constritiva.', false),
(gen_random_uuid(), '019c4815-2dc4-411e-a9ee-e778a08465f2', 'd', 'Onda A proeminente pode ser vista em casos de embolia pulmonar maciça.', true),
(gen_random_uuid(), '019c4815-2dc4-411e-a9ee-e778a08465f2', 'e', 'Refluxo mitral importante causa ondas V gigantes na observação do pulso venoso jugular.', false),

(gen_random_uuid(), 'fbfecf1e-c709-42fd-97aa-640775ac5e83', 'a', 'Trata-se de um achado compatível com a normalidade e não deve gerar preocupações quanto a diagnósticos diferenciais.', false),
(gen_random_uuid(), 'fbfecf1e-c709-42fd-97aa-640775ac5e83', 'b', 'O achado do exame físico é compatível com pulso alternante e, nesse caso, pode estar relacionado à doença pulmonar obstrutiva grave.', false),
(gen_random_uuid(), 'fbfecf1e-c709-42fd-97aa-640775ac5e83', 'c', 'Tal achado é compatível com pulso paradoxal, sendo patognomônico de tamponamento cardíaco.', false),
(gen_random_uuid(), 'fbfecf1e-c709-42fd-97aa-640775ac5e83', 'd', 'O sinal de Kussmaul, conforme descrito no paciente em questão, é típico de situações de hipovolemia.', false),
(gen_random_uuid(), 'fbfecf1e-c709-42fd-97aa-640775ac5e83', 'e', 'Trata-se de um achado compatível com pulso paradoxal e, nesse caso, pode estar relacionado provavelmente a tamponamento cardíaco e/ou embolia pulmonar.', true),

(gen_random_uuid(), 'e2185ba1-e7b6-4061-b0a9-4a16e2978fd6', 'a', 'É característico da fibrilação atrial.', false),
(gen_random_uuid(), 'e2185ba1-e7b6-4061-b0a9-4a16e2978fd6', 'b', 'Pode estar presente em portadores de insuficiência cardíaca grave.', true),
(gen_random_uuid(), 'e2185ba1-e7b6-4061-b0a9-4a16e2978fd6', 'c', 'É exacerbado por hipervolemia e estados hipotensivos.', false),
(gen_random_uuid(), 'e2185ba1-e7b6-4061-b0a9-4a16e2978fd6', 'd', 'Variações do ciclo respiratório o acentuam.', false),
(gen_random_uuid(), 'e2185ba1-e7b6-4061-b0a9-4a16e2978fd6', 'e', 'A inspiração encurta o tempo de ejeção ventricular direita por reduzir a pressão em artéria pulmonar.', false),

(gen_random_uuid(), 'bae813c8-fac0-47b3-b951-49d90184fd73', 'a', 'Permite avaliar à beira do leito o estado volêmico do paciente.', false),
(gen_random_uuid(), 'bae813c8-fac0-47b3-b951-49d90184fd73', 'b', 'A pressão venosa se modifica com a inspiração.', false),
(gen_random_uuid(), 'bae813c8-fac0-47b3-b951-49d90184fd73', 'c', 'A presença de turgência jugular esquerda isolada ocorre na persistência da veia cava superior esquerda.', false),
(gen_random_uuid(), 'bae813c8-fac0-47b3-b951-49d90184fd73', 'd', 'A presença de refluxo abdominojugular é indicativa de hipertensão venosa.', false),
(gen_random_uuid(), 'bae813c8-fac0-47b3-b951-49d90184fd73', 'e', 'As veias jugulares externas não possuem válvulas e, portanto, devem ser preferidas para a avaliação do pulso venoso.', true),

(gen_random_uuid(), '7d973723-056b-4007-88ad-5f962c5f53c3', 'a', 'CIA.', false),
(gen_random_uuid(), '7d973723-056b-4007-88ad-5f962c5f53c3', 'b', 'Derrame pericárdico de etiologia neoplásica.', true),
(gen_random_uuid(), '7d973723-056b-4007-88ad-5f962c5f53c3', 'c', 'Insuficiência aórtica importante.', false),
(gen_random_uuid(), '7d973723-056b-4007-88ad-5f962c5f53c3', 'd', 'Disfunção sistólica importante de VE.', false),
(gen_random_uuid(), '7d973723-056b-4007-88ad-5f962c5f53c3', 'e', 'Tamponamento de câmaras direitas devido a coágulo pós-operatório.', false),

(gen_random_uuid(), 'd1e3f1e1-09b2-4683-8f63-699f3694b6b2', 'a', 'Na comunicação interatrial, a amplitude da onda (v) é menor que a da onda (a).', false),
(gen_random_uuid(), 'd1e3f1e1-09b2-4683-8f63-699f3694b6b2', 'b', 'O descenso da onda (y) representa o fechamento da válvula tricúspide.', false),
(gen_random_uuid(), 'd1e3f1e1-09b2-4683-8f63-699f3694b6b2', 'c', 'A onda (a) "em canhão" pode ser vista na fibrilação atrial.', false),
(gen_random_uuid(), 'd1e3f1e1-09b2-4683-8f63-699f3694b6b2', 'd', 'O descenso (x) aumenta na insuficiência tricúspide.', false),
(gen_random_uuid(), 'd1e3f1e1-09b2-4683-8f63-699f3694b6b2', 'e', 'A onda (a) reflete a contração pré-sistólica do átrio direito, ocorre logo depois da onda P no eletrocardiograma e precede a primeira bulha cardíaca (B1).', true),

(gen_random_uuid(), '11e7283e-cd26-45e1-b722-b0d311dcc86e', 'a', 'O enchimento atrial.', false),
(gen_random_uuid(), '11e7283e-cd26-45e1-b722-b0d311dcc86e', 'b', 'A sucção diastólica atrial.', false),
(gen_random_uuid(), '11e7283e-cd26-45e1-b722-b0d311dcc86e', 'c', 'A queda da pressão do átrio direito.', false),
(gen_random_uuid(), '11e7283e-cd26-45e1-b722-b0d311dcc86e', 'd', 'A contração pré-sistólica do átrio direito.', true),
(gen_random_uuid(), '11e7283e-cd26-45e1-b722-b0d311dcc86e', 'e', 'A queda da pressão do átrio direito após a abertura da valva tricúspide.', false),

(gen_random_uuid(), 'dde4d085-dd5d-421e-aadf-b0d691aa0b9f', 'a', 'Geralmente o paciente se apresenta com sinais e sintomas de insuficiência cardíaca predominantemente de câmaras esquerdas.', false),
(gen_random_uuid(), 'dde4d085-dd5d-421e-aadf-b0d691aa0b9f', 'b', 'O sinal de Kussmaul, redução da estase jugular durante a inspiração profunda, pode estar presente.', false),
(gen_random_uuid(), 'dde4d085-dd5d-421e-aadf-b0d691aa0b9f', 'c', 'Pulso paradoxal pode ocorrer em um terço dos casos.', true),
(gen_random_uuid(), 'dde4d085-dd5d-421e-aadf-b0d691aa0b9f', 'd', 'Knock pericárdico é um achado físico comum, caracterizado por ruído agudo, telediastólico e determinado pela contração atrial.', false),
(gen_random_uuid(), 'dde4d085-dd5d-421e-aadf-b0d691aa0b9f', 'e', 'Pulso arterial alternante é característico de casos graves.', false),

(gen_random_uuid(), '1f60af8f-cd6d-49d8-8d92-5407b74ea1d1', 'a', 'Mulher de 60 anos, diabética, com síndrome coronariana aguda.', false),
(gen_random_uuid(), '1f60af8f-cd6d-49d8-8d92-5407b74ea1d1', 'b', 'Homem de 65 anos com hipertensão renovascular.', false),
(gen_random_uuid(), '1f60af8f-cd6d-49d8-8d92-5407b74ea1d1', 'c', 'Mulher de 28 anos, com assimetria dos pulsos nos membros superiores e sopro contínuo na região axilar direita.', true),
(gen_random_uuid(), '1f60af8f-cd6d-49d8-8d92-5407b74ea1d1', 'd', 'Homem de 30 anos com doença valvar reumática e febre diária há 15 dias.', false),
(gen_random_uuid(), '1f60af8f-cd6d-49d8-8d92-5407b74ea1d1', 'e', 'Início da contração atrial.', false),

(gen_random_uuid(), '3e4ceee7-1990-444b-9e64-0277cfd5cdba', 'a', 'Coarctação de aorta.', true),
(gen_random_uuid(), '3e4ceee7-1990-444b-9e64-0277cfd5cdba', 'b', 'Comunicação interatrial.', false),
(gen_random_uuid(), '3e4ceee7-1990-444b-9e64-0277cfd5cdba', 'c', 'Estenose pulmonar.', false),
(gen_random_uuid(), '3e4ceee7-1990-444b-9e64-0277cfd5cdba', 'd', 'Insuficiência aórtica.', false),
(gen_random_uuid(), '3e4ceee7-1990-444b-9e64-0277cfd5cdba', 'e', 'Tetralogia de Fallot.', false),

(gen_random_uuid(), '1756e645-84fa-4c35-9554-0abd96449051', 'a', 'Coarctação da aorta.', true),
(gen_random_uuid(), '1756e645-84fa-4c35-9554-0abd96449051', 'b', 'Síndrome de Marfan.', false),
(gen_random_uuid(), '1756e645-84fa-4c35-9554-0abd96449051', 'c', 'Doença de Kawasaki.', false),
(gen_random_uuid(), '1756e645-84fa-4c35-9554-0abd96449051', 'd', 'Dissecção aórtica aguda.', false),
(gen_random_uuid(), '1756e645-84fa-4c35-9554-0abd96449051', 'e', 'Aneurisma de aorta descendente.', false);

-- ============================================================
-- Tema: Ausculta
-- ============================================================

insert into public.questions (id, tema, ano, instituicao, enunciado, comentario) values
('5d093e78-bf06-47e8-94ae-718e685e44c6', 'Ausculta', 2018, 'TEC', 'Paciente do sexo masculino, com 36 anos, comparece à consulta referindo dispneia aos moderados esforços (NYHA CF II). Nega antecedentes e uso de medicações. Ao exame clínico, apresenta pulso amplo, ritmo cardíaco regular, sopro holodiastólico aspirativo +++/6+, melhor audível em foco aórtico acessório, e apresenta em foco mitral B1 hipofonética, rufiar diastólico ++/6+ em foco mitral, ausência de reforço pré-sistólico e ausência de clique de abertura de válvula mitral. Qual o diagnóstico anatômico valvar?', 'O sopro diastólico aspirativo em foco aórtico acessório é característico de insuficiência aórtica. O rufiar diastólico mitral associado (sopro de Austin-Flint) resulta do jato regurgitante que impede a abertura plena da valva mitral, sem que haja estenose mitral verdadeira — por isso não há estalido de abertura nem reforço pré-sistólico.'),
('af2d8d08-1b98-408b-8a75-73f2fb4a06df', 'Ausculta', 2012, 'TEC', 'Paciente do sexo masculino, 32 anos, assintomático, é avaliado em consulta de rotina: pulso com ascenso rápido e amplitude aumentada, FC = 80 bpm, PA = 152 x 60 mmHg, impulsão palpável em fúrcula, sem frêmito, íctus desviado para baixo e para a esquerda, hiperdinâmico e com três polpas, discreto sopro mesossistólico em base e sopro holodiastólico aspirativo 2+/6+ em borda esternal esquerda. Este exame físico é compatível com:', 'Pulso célere (martelo d''água) e pressão de pulso alargada (divergente) são clássicos da insuficiência aórtica importante. O sopro mesossistólico em base reflete o alto fluxo anterógrado pela valva aórtica, e o sopro diastólico aspirativo confirma a regurgitação.'),
('360b0578-2837-4b0b-bb2a-200b7b6610c8', 'Ausculta', 2022, 'TEC', 'São achados do exame físico de pacientes com insuficiência mitral primária importante:', 'Na insuficiência mitral primária importante e crônica, a sobrecarga volumétrica do átrio e ventrículo esquerdos leva, com a evolução da doença, a hipertensão pulmonar e sinais de insuficiência cardíaca direita.'),
('4057ecca-716c-4c63-a774-4292b9aacda5', 'Ausculta', 2013, 'TEC', 'Entre os indivíduos assintomáticos, sem outros sinais de doença cardiovascular, o único dos abaixo listados em que não está indicado um ecocardiograma transtorácico é aquele que apresenta, na ausculta cardíaca, apenas um sopro 2+/6+:', 'Um sopro mesossistólico suave (até 2+/6+), isolado, em paciente assintomático e sem outros achados, costuma ser funcional/inocente e não requer investigação ecocardiográfica de rotina. Sopros diastólicos, contínuos, protossistólicos, telessistólicos ou pré-sistólicos são sempre patológicos e indicam avaliação.'),
('3c7b69d5-9f09-46ea-84b1-d578c9521df1', 'Ausculta', 2016, 'TEC', 'Paciente portador de cardiopatia reumática apresenta, ao exame físico: pulso arterial de forma normal com amplitude diminuída; pulso venoso com onda "v" mais ampla que a onda "a" e colapso "y" profundo; impulsão do ventrículo esquerdo no 4º espaço intercostal esquerdo de difícil palpação; impulsão do ventrículo direito palpável e hiperdinâmica; B1 hiperfonética; P2 mais intensa que A2; estalido de abertura amplo, muito próximo de B2, introduzindo sopro mesodiastólico que se intensifica com a expiração; B3 ampla com manobra inspiratória; sopro sistólico 2+/4+ no 4º espaço intercostal paraesternal esquerdo que se intensifica com a inspiração. Qual é o diagnóstico?', 'B1 hiperfonética, estalido de abertura próximo a B2 e sopro mesodiastólico caracterizam estenose mitral; P2 aumentada indica hipertensão pulmonar; e o sopro sistólico que se intensifica com a inspiração (sinal de Rivero-Carvallo) indica insuficiência tricúspide associada.'),
('139fc49e-52ce-4a1b-ab94-8da41d2a14e8', 'Ausculta', 2022, 'TEC', 'Sobre a ausculta cardíaca, é correto afirmar:', 'A quarta bulha (B4) é gerada pela contração atrial contra um ventrículo pouco complacente, refletindo pressões de enchimento elevadas — como na hipertrofia ventricular esquerda por hipertensão arterial ou estenose aórtica.'),
('9445b795-230d-4eda-8774-deff58ac6e81', 'Ausculta', 2013, 'TEC', 'Uma terceira bulha fisiológica pode ser auscultada em uma condição hipercinética, especialmente em crianças e adolescentes. Este achado pode ser atribuído a(o):', 'A terceira bulha fisiológica resulta do rápido enchimento ventricular precoce associado a relaxamento diastólico ativo e vigoroso do ventrículo esquerdo, comum em crianças e jovens em estados hipercinéticos.'),
('6e45d53f-8514-45cb-8de1-55f6b452d9cd', 'Ausculta', 2013, 'TEC', 'Paciente do sexo feminino, 55 anos, em classe funcional I, apresenta, ao exame físico, um ventrículo direito palpável, estando a segunda bulha com desdobramento fixo e com o componente pulmonar aumentado. Um sopro sistólico de intensidade 2/6+ é auscultado em foco pulmonar. Diante deste quadro clínico, o diagnóstico deve ser:', 'O desdobramento fixo da segunda bulha (não varia com a respiração) é o achado clássico da comunicação interatrial; o componente pulmonar aumentado indica hipertensão pulmonar associada.'),
('37910bb7-a8d6-4789-9858-8708eb34eeac', 'Ausculta', 2015, 'TEC', 'Dentre os achados de exame físico abaixo, qual NÃO é característico de um episódio anginoso provocado por isquemia miocárdica?', 'Na isquemia miocárdica aguda podem surgir B3, B4, sopro de regurgitação mitral (por disfunção de músculo papilar) e desdobramento paradoxal de B2 (por atraso na contração do VE). O sopro diastólico aspirativo em foco aórtico acessório não se relaciona à isquemia, e sim à insuficiência aórtica estrutural.'),
('e71c6f35-e94f-4388-b732-45252d9dbba1', 'Ausculta', 2012, 'TEC', 'Paciente do sexo masculino, 47 anos, relata dispneia há 6 meses, pior há 7 dias, com fadiga e edema de membros inferiores; sorologia para Chagas positiva. Ao exame físico: bom estado geral, hipocorado +/4+, hidratado, taquipneico, estase jugular com onda V proeminente, hepatomegalia dolorosa, edema de MMII, pulmões com raros estertores em base, extremidades frias, pulso fino e regular com variação de amplitude, FC = 112 bpm, PA = 92 x 78 mmHg. Ictus desviado para a esquerda e para baixo, B1 hipofonética, B2 normofonética. Sopro holossistólico em platô 2+/6+ em borda esternal esquerda que aumenta à inspiração profunda, e sopro mitral que aumenta em decúbito lateral esquerdo; B3 em ápice. Pode-se AFIRMAR a presença de:', 'A cardiomiopatia chagásica cursa com dilatação biventricular. O sopro que se intensifica na inspiração (sinal de Rivero-Carvallo) indica insuficiência tricúspide, e o sopro mitral que aumenta em decúbito lateral esquerdo indica insuficiência mitral associada — configurando quadro de insuficiência cardíaca de baixo débito com dupla regurgitação atrioventricular.'),
('a190eb39-c32b-4a5f-9f4c-7de0d7ce0534', 'Ausculta', 2017, 'TEC', 'Sopro sistólico que é melhor audível na borda esternal esquerda, aumenta durante a inspiração e é acompanhado de onda v acentuada e y decrescente no pulso venoso jugular sugere:', 'Sopro sistólico que aumenta com a inspiração (sinal de Rivero-Carvallo), associado a onda "v" proeminente e descenso "y" rápido no pulso venoso jugular, é característico de insuficiência tricúspide.'),
('30bb3be6-5483-48a5-a919-dfe19ac6a3b7', 'Ausculta', 2013, 'TEC', 'Paciente do sexo feminino, 38 anos, é atendida no consultório com diagnóstico prévio de prolapso da valva mitral. Após examiná-la em decúbito dorsal, o médico solicita que a paciente fique na posição de cócoras. Nesta posição, nova ausculta cardíaca é realizada, devendo ser observado que:', 'Manobras que aumentam o volume ventricular esquerdo (cócoras, handgrip) retardam o prolapso valvar, afastando o clique mesossistólico de B1 e encurtando a duração do sopro; manobras que reduzem o volume (Valsalva, ortostase) aproximam o clique de B1 e alongam o sopro.'),
('5ab93625-48c8-41e5-951c-57f6fd763592', 'Ausculta', 2022, 'TEC', 'Paciente do sexo masculino, de 52 anos de idade, hipertenso e tabagista, admitido com quadro de dispneia aos pequenos esforços e dor torácica. Ao exame físico, observam-se sinais de insuficiência aórtica grave. Com relação a esse caso, assinale a alternativa INCORRETA:', 'Na insuficiência aórtica grave o pulso é amplo e célere (martelo d''água), com pressão de pulso divergente — e não de amplitude reduzida e duração prolongada, o que descreve outras condições (como o pulso parvus et tardus da estenose aórtica). Por isso essa afirmativa é a incorreta.'),
('a6a79759-eabd-4087-a399-a4dfca61f11e', 'Ausculta', 2014, 'TEC', 'Em relação à insuficiência aórtica grave, assinale a resposta CORRETA:', 'O sopro diastólico da insuficiência aórtica de origem valvar é mais bem audível no 3º/4º espaço intercostal de borda esternal esquerda; quando secundário à dilatação da raiz aórtica, é mais bem audível na borda esternal direita alta.'),
('501a077b-7e5a-44b9-84b4-a98841ee785a', 'Ausculta', 2017, 'TEC', 'O sopro de Graham-Steel é característico da seguinte lesão valvar:', 'O sopro de Graham-Steell é um sopro diastólico decrescente por insuficiência pulmonar, geralmente secundária à dilatação do anel valvar em contexto de hipertensão pulmonar grave.'),
('1500875c-0a77-471c-be2f-01fe3494d73e', 'Ausculta', 2012, 'TEC', 'Qual das seguintes afirmativas é CORRETA?', 'O esforço isométrico (manobra de handgrip) aumenta a resistência vascular periférica (pós-carga), intensificando sopros de regurgitação como a insuficiência mitral e a insuficiência aórtica.'),
('e2255aff-f60a-4982-a60d-8c866d6bf44d', 'Ausculta', 2020, 'TEC', 'Mulher, 55 anos, apresenta ao exame clínico pressão arterial = 140 x 70 mmHg, ictus do ventrículo esquerdo desviado e propulsivo, terceira bulha e sopro sistólico contínuo e suave (+4/+6) no bordo esternal esquerdo (4º/5º espaços intercostais) e ponta com irradiação para axila. O sopro não se altera com o ciclo respiratório e na manobra de Handgrip aumenta sua intensidade. Neste caso, o diagnóstico mais provável é:', 'Sopro sistólico com irradiação para a axila, que não varia com a respiração (lesão de câmaras esquerdas) e se intensifica com o handgrip (aumento de pós-carga/regurgitação), é típico de insuficiência mitral.'),
('edd15d37-964f-42b5-83ce-bd5f344b5641', 'Ausculta', 2012, 'TEC', 'Paciente do sexo masculino de 84 anos apresenta sopro sistólico, em focos da base, intensidade 3+/6+, configuração em diamante, com pico tardio, rude, irradiado para carótidas e fúrcula; também apresenta sopro sistólico, audível no foco mitral, intensidade 2+/6+, configuração em diamante, com timbre piante. Não aumenta com decúbito lateral esquerdo. Assinale a alternativa que contempla a hipótese diagnóstica CORRETA:', 'O sopro sistólico em crescendo-decrescendo (diamante) irradiado para carótidas é típico de estenose aórtica. O componente ouvido no ápice, que não se comporta como sopro mitral verdadeiro (não se intensifica em decúbito lateral esquerdo), corresponde à irradiação de componentes de alta frequência do próprio sopro aórtico — fenômeno de Gallavardin.'),
('227784d3-780f-4b20-81ac-aa848866c547', 'Ausculta', 2019, 'TEC', 'Homem, 82 anos, está sendo examinado no ambulatório de cardiologia com diagnóstico de estenose aórtica. Durante a ausculta cardíaca, apresenta uma extrassístole. Sobre o sopro no batimento seguinte à extrassístole, é correto afirmar:', 'Após uma extrassístole, a pausa compensatória aumenta o enchimento diastólico do ventrículo esquerdo, elevando o volume ejetado no batimento seguinte (potenciação pós-extrassistólica) e intensificando o sopro da estenose aórtica — diferentemente do que ocorre, por exemplo, na insuficiência mitral, em que o sopro não se modifica.'),
('ed67fbc4-9cca-447b-907b-7bac440f4c0e', 'Ausculta', 2013, 'TEC', 'Em relação à estenose aórtica grave, assinale a resposta ERRADA:', 'Quanto mais grave a estenose aórtica, mais TARDIO (e não mais precoce) é o pico de intensidade do sopro em crescendo-decrescendo, refletindo maior tempo necessário para gerar o gradiente pressórico máximo entre VE e aorta.'),
('73837f19-84ca-4902-a10b-f1bf08d5f64b', 'Ausculta', 2014, 'TEC', 'São características auscultatórias da estenose mitral:', 'A descrição correta da estenose mitral é: hiperfonese de primeira bulha, estalido de abertura mitral, sopro diastólico em ruflar com reforço pré-sistólico (em ritmo sinusal) e segunda bulha hiperfonética (componente pulmonar) quando há hipertensão pulmonar associada. Observação: o gabarito original do material indicava a alternativa E, mas ela não descreve estenose mitral — a alternativa B é a correta e foi a usada aqui; verifique com sua fonte caso queira confirmar.'),
('6b4b79c2-b204-423c-8df8-261af4088fa0', 'Ausculta', 2017, 'TEC', 'O fenômeno de Gallavardin é observado na seguinte condição clínica:', 'O fenômeno de Gallavardin ocorre na estenose aórtica calcificada, quando os componentes de alta frequência do sopro se irradiam para o ápice, podendo simular um sopro de regurgitação mitral.'),
('3c2acc85-9020-4edd-8c22-beb121a68025', 'Ausculta', 2012, 'TEC', 'Em relação à estenose mitral isolada GRAVE, são verdadeiras as assertivas a seguir, com EXCEÇÃO de:', 'Quanto mais grave a estenose mitral (maior o gradiente entre átrio e ventrículo esquerdos), MENOR — e não maior — é o intervalo entre B2 e o estalido de abertura mitral. Por isso essa afirmativa é a exceção pedida.'),
('e6512aad-3cbd-4fc6-90c1-9e79d76faa34', 'Ausculta', 2017, 'TEC', 'Paciente de 42 anos queixa-se de dispneia aos esforços, com piora nos últimos dois meses. Ao exame físico, observa-se sopro sistólico em base com pico tardio e irradiação para as carótidas. O pulso carotídeo é lento e de baixa amplitude. Dentre as alternativas abaixo, a principal suspeita diagnóstica é:', 'Pulso carotídeo "parvus et tardus" (lento e de baixa amplitude) associado a sopro sistólico em crescendo-decrescendo, com pico tardio e irradiado para carótidas, é o quadro clássico de estenose aórtica.'),
('adf4eb34-07a9-45c1-aa9f-1ca43b497584', 'Ausculta', 2014, 'TEC', 'Assinale a alternativa ERRADA:', 'O sopro de Carey Coombs é um sopro MESODIASTÓLICO mitral (e não sistólico), causado por valvulite na fase aguda da febre reumática. Por isso essa afirmativa está incorreta.'),
('828285b3-dc0b-46ea-a5e6-2c50153303d7', 'Ausculta', 2012, 'TEC', 'Em relação aos achados semiológicos da cardiomiopatia hipertrófica, é CORRETO afirmar:', 'Na cardiomiopatia hipertrófica obstrutiva, manobras que reduzem o volume ventricular esquerdo (fase de esforço da manobra de Valsalva, ortostase) aumentam a obstrução dinâmica da via de saída do VE, intensificando o sopro — efeito oposto ao observado na estenose aórtica valvar fixa.'),
('c059e438-e905-49d7-a38b-343909549944', 'Ausculta', 2018, 'TEC', 'Qual a alternativa INCORRETA sobre a estenose mitral:', 'O reforço pré-sistólico do sopro da estenose mitral depende de contração atrial efetiva. Na fibrilação atrial (sem contração atrial coordenada) esse reforço desaparece — por isso a afirmativa que o descreve como frequente na fibrilação atrial está incorreta.'),
('cd2c15c8-a428-48a5-99c5-f0c337e72f98', 'Ausculta', 2022, 'TEC', 'Sobre a ausculta cardíaca, é correto afirmar:', 'A quarta bulha (B4) é gerada pela contração atrial contra um ventrículo pouco complacente, refletindo pressões de enchimento elevadas do ventrículo esquerdo.'),
('cdb77732-1bf9-4682-8b34-c4b13cc2570c', 'Ausculta', 2022, 'TEC', 'No exame físico de pacientes com estenose mitral importante, pode(m) ser encontrado(s), EXCETO:', 'Na estenose mitral, B1 costuma ser HIPERFONÉTICA (e não hipofonética), exceto em casos muito avançados/calcificados. A opção que descreve B1 e B2 hipofonéticas não é um achado típico da doença, sendo a exceção pedida.'),
('2347ad26-c072-4c2a-8f85-9dc1ec0499d1', 'Ausculta', 2021, 'TEC', 'A insuficiência aórtica pode ser classificada como importante pela presença dos seguintes sinais, EXCETO:', 'Sopro holodiastólico aspirativo com B2 hipofonética, ruflar diastólico (Austin-Flint) e pulso em martelo d''água são sinais diretamente associados à gravidade da insuficiência aórtica. Já a piora do sopro com o handgrip é um achado inespecífico de regurgitações em geral, não sendo por si só um marcador de gravidade — por isso é a exceção considerada aqui.'),
('68eae4bd-9775-414e-aedd-5858b2c99f45', 'Ausculta', 2012, 'TEC', 'Em relação ao exame do aparelho cardiovascular, todas as afirmativas são corretas, com EXCEÇÃO de:', 'Na insuficiência mitral importante, o ictus cordis se desloca para BAIXO e para a ESQUERDA (sobrecarga de volume do ventrículo esquerdo), e não "para cima" — por isso essa afirmativa é a exceção incorreta.'),
('3730b050-20ab-4666-9421-5f67a64f2578', 'Ausculta', 2015, 'TEC', 'O sopro de Austin-Flint é:', 'O sopro de Austin-Flint é um ruflar mesodiastólico (por vezes com reforço pré-sistólico), auscultado no ápice em pacientes com insuficiência aórtica importante, mimetizando uma estenose mitral funcional.'),
('6302c497-7680-4c3c-ab4d-c2d4713f1740', 'Ausculta', 2012, 'TEC', 'Em relação ao desdobramento da segunda bulha, pode-se afirmar:', 'No bloqueio de ramo esquerdo, o atraso na ativação elétrica do ventrículo esquerdo retarda o fechamento da valva aórtica, fazendo com que o componente pulmonar (P2) preceda o aórtico (A2) — desdobramento paradoxal, mais evidente na expiração.');

insert into public.question_options (id, question_id, letra, texto, correta) values
(gen_random_uuid(), '5d093e78-bf06-47e8-94ae-718e685e44c6', 'a', 'Estenose mitral importante.', false),
(gen_random_uuid(), '5d093e78-bf06-47e8-94ae-718e685e44c6', 'b', 'Insuficiência aórtica importante.', true),
(gen_random_uuid(), '5d093e78-bf06-47e8-94ae-718e685e44c6', 'c', 'Insuficiência mitral importante.', false),
(gen_random_uuid(), '5d093e78-bf06-47e8-94ae-718e685e44c6', 'd', 'Insuficiência aórtica e estenose mitral importantes.', false),
(gen_random_uuid(), '5d093e78-bf06-47e8-94ae-718e685e44c6', 'e', 'Dupla lesão mitral com estenose importante e insuficiência moderada.', false),

(gen_random_uuid(), 'af2d8d08-1b98-408b-8a75-73f2fb4a06df', 'a', 'Dupla disfunção aórtica discreta.', false),
(gen_random_uuid(), 'af2d8d08-1b98-408b-8a75-73f2fb4a06df', 'b', 'Insuficiência aórtica importante.', true),
(gen_random_uuid(), 'af2d8d08-1b98-408b-8a75-73f2fb4a06df', 'c', 'Estenose mitral grave.', false),
(gen_random_uuid(), 'af2d8d08-1b98-408b-8a75-73f2fb4a06df', 'd', 'Dupla lesão mitral discreta.', false),
(gen_random_uuid(), 'af2d8d08-1b98-408b-8a75-73f2fb4a06df', 'e', 'Estenose aórtica com insuficiência mitral moderada.', false),

(gen_random_uuid(), '360b0578-2837-4b0b-bb2a-200b7b6610c8', 'a', 'Ictus cordis no quarto espaço intercostal na linha hemiclavicular esquerda.', false),
(gen_random_uuid(), '360b0578-2837-4b0b-bb2a-200b7b6610c8', 'b', 'Sopro sistólico regurgitativo <+++/6+.', false),
(gen_random_uuid(), '360b0578-2837-4b0b-bb2a-200b7b6610c8', 'c', 'Sinais clínicos de insuficiência cardíaca direita.', true),
(gen_random_uuid(), '360b0578-2837-4b0b-bb2a-200b7b6610c8', 'd', 'B1 hiperfonética.', false),
(gen_random_uuid(), '360b0578-2837-4b0b-bb2a-200b7b6610c8', 'e', 'B2 hipofonética.', false),

(gen_random_uuid(), '4057ecca-716c-4c63-a774-4292b9aacda5', 'a', 'Mesossistólico.', true),
(gen_random_uuid(), '4057ecca-716c-4c63-a774-4292b9aacda5', 'b', 'Protossistólico.', false),
(gen_random_uuid(), '4057ecca-716c-4c63-a774-4292b9aacda5', 'c', 'Holossistólico.', false),
(gen_random_uuid(), '4057ecca-716c-4c63-a774-4292b9aacda5', 'd', 'Telessistólico.', false),
(gen_random_uuid(), '4057ecca-716c-4c63-a774-4292b9aacda5', 'e', 'Pré-sistólico.', false),

(gen_random_uuid(), '3c7b69d5-9f09-46ea-84b1-d578c9521df1', 'a', 'Estenose mitral leve e insuficiência tricúspide grave.', false),
(gen_random_uuid(), '3c7b69d5-9f09-46ea-84b1-d578c9521df1', 'b', 'Dupla lesão mitral com predomínio da insuficiência.', false),
(gen_random_uuid(), '3c7b69d5-9f09-46ea-84b1-d578c9521df1', 'c', 'Estenose mitral grave, hipertensão arterial pulmonar e insuficiência tricúspide.', true),
(gen_random_uuid(), '3c7b69d5-9f09-46ea-84b1-d578c9521df1', 'd', 'Dupla lesão mitral com predomínio da estenose.', false),
(gen_random_uuid(), '3c7b69d5-9f09-46ea-84b1-d578c9521df1', 'e', 'Insuficiência mitral grave com hipertensão arterial pulmonar.', false),

(gen_random_uuid(), '139fc49e-52ce-4a1b-ab94-8da41d2a14e8', 'a', 'No desdobramento fisiológico da segunda bulha, o fechamento da valva pulmonar antecede o da aórtica.', false),
(gen_random_uuid(), '139fc49e-52ce-4a1b-ab94-8da41d2a14e8', 'b', 'A quarta bulha relaciona-se a aumento das pressões de enchimento do ventrículo esquerdo.', true),
(gen_random_uuid(), '139fc49e-52ce-4a1b-ab94-8da41d2a14e8', 'c', 'A segunda bulha coincide com o pulso carotídeo.', false),
(gen_random_uuid(), '139fc49e-52ce-4a1b-ab94-8da41d2a14e8', 'd', 'A terceira bulha é um ruído protossistólico mais audível em foco aórtico acessório.', false),
(gen_random_uuid(), '139fc49e-52ce-4a1b-ab94-8da41d2a14e8', 'e', 'A segunda bulha tem duração maior que a primeira bulha.', false),

(gen_random_uuid(), '9445b795-230d-4eda-8774-deff58ac6e81', 'a', 'Enchimento ventricular mais tardio contra um gradiente de pressão.', false),
(gen_random_uuid(), '9445b795-230d-4eda-8774-deff58ac6e81', 'b', 'Relaxamento diastólico ativo do ventrículo esquerdo.', true),
(gen_random_uuid(), '9445b795-230d-4eda-8774-deff58ac6e81', 'c', 'Equalização da pressão no átrio e ventrículo.', false),
(gen_random_uuid(), '9445b795-230d-4eda-8774-deff58ac6e81', 'd', 'Parada rápida do enchimento diastólico.', false),
(gen_random_uuid(), '9445b795-230d-4eda-8774-deff58ac6e81', 'e', 'Início da contração atrial.', false),

(gen_random_uuid(), '6e45d53f-8514-45cb-8de1-55f6b452d9cd', 'a', 'Persistência do canal arterial com hipertensão pulmonar.', false),
(gen_random_uuid(), '6e45d53f-8514-45cb-8de1-55f6b452d9cd', 'b', 'Persistência do canal arterial sem hipertensão pulmonar.', false),
(gen_random_uuid(), '6e45d53f-8514-45cb-8de1-55f6b452d9cd', 'c', 'Comunicação interatrial sem hipertensão pulmonar.', false),
(gen_random_uuid(), '6e45d53f-8514-45cb-8de1-55f6b452d9cd', 'd', 'Comunicação interatrial com hipertensão pulmonar.', true),
(gen_random_uuid(), '6e45d53f-8514-45cb-8de1-55f6b452d9cd', 'e', 'Hipertensão pulmonar primária.', false),

(gen_random_uuid(), '37910bb7-a8d6-4789-9858-8708eb34eeac', 'a', 'Sopro diastólico aspirativo em foco aórtico acessório.', true),
(gen_random_uuid(), '37910bb7-a8d6-4789-9858-8708eb34eeac', 'b', 'Terceira bulha.', false),
(gen_random_uuid(), '37910bb7-a8d6-4789-9858-8708eb34eeac', 'c', 'Quarta bulha.', false),
(gen_random_uuid(), '37910bb7-a8d6-4789-9858-8708eb34eeac', 'd', 'Sopro de regurgitação mitral.', false),
(gen_random_uuid(), '37910bb7-a8d6-4789-9858-8708eb34eeac', 'e', 'Desdobramento paradoxal da segunda bulha.', false),

(gen_random_uuid(), 'e71c6f35-e94f-4388-b732-45252d9dbba1', 'a', 'Insuficiência cardíaca (IC) com baixo débito com estenose aórtica.', false),
(gen_random_uuid(), 'e71c6f35-e94f-4388-b732-45252d9dbba1', 'b', 'Somente IC esquerda com baixo débito e insuficiência mitral.', false),
(gen_random_uuid(), 'e71c6f35-e94f-4388-b732-45252d9dbba1', 'c', 'IC com baixo débito e insuficiências mitral e tricúspide.', true),
(gen_random_uuid(), 'e71c6f35-e94f-4388-b732-45252d9dbba1', 'd', 'Somente IC direita com alto débito e insuficiência tricúspide.', false),
(gen_random_uuid(), 'e71c6f35-e94f-4388-b732-45252d9dbba1', 'e', 'Somente IC esquerda com baixo débito e miocardiopatia.', false),

(gen_random_uuid(), 'a190eb39-c32b-4a5f-9f4c-7de0d7ce0534', 'a', 'Estenose aórtica.', false),
(gen_random_uuid(), 'a190eb39-c32b-4a5f-9f4c-7de0d7ce0534', 'b', 'Insuficiência mitral.', false),
(gen_random_uuid(), 'a190eb39-c32b-4a5f-9f4c-7de0d7ce0534', 'c', 'Insuficiência tricúspide.', true),
(gen_random_uuid(), 'a190eb39-c32b-4a5f-9f4c-7de0d7ce0534', 'd', 'Defeito do septo ventricular.', false),
(gen_random_uuid(), 'a190eb39-c32b-4a5f-9f4c-7de0d7ce0534', 'e', 'Ruptura de cordoalha tendínea do folheto posterior da valva mitral.', false),

(gen_random_uuid(), '30bb3be6-5483-48a5-a919-dfe19ac6a3b7', 'a', 'O sopro sistólico fica mais precoce.', false),
(gen_random_uuid(), '30bb3be6-5483-48a5-a919-dfe19ac6a3b7', 'b', 'O clique sistólico aumenta de intensidade.', false),
(gen_random_uuid(), '30bb3be6-5483-48a5-a919-dfe19ac6a3b7', 'c', 'O sopro mesossistólico aumenta de intensidade.', false),
(gen_random_uuid(), '30bb3be6-5483-48a5-a919-dfe19ac6a3b7', 'd', 'O clique sistólico se aproxima da primeira bulha.', false),
(gen_random_uuid(), '30bb3be6-5483-48a5-a919-dfe19ac6a3b7', 'e', 'O clique sistólico se distancia da primeira bulha.', true),

(gen_random_uuid(), '5ab93625-48c8-41e5-951c-57f6fd763592', 'a', 'Em alguns casos, encontramos uma pressão arterial divergente e o pulso com amplitude reduzida e duração prolongada.', true),
(gen_random_uuid(), '5ab93625-48c8-41e5-951c-57f6fd763592', 'b', 'A característica é de sopro diastólico, aspirativo, que se inicia imediatamente após a segunda bulha.', false),
(gen_random_uuid(), '5ab93625-48c8-41e5-951c-57f6fd763592', 'c', 'Podemos encontrar o sopro de Austin-Flint, que corresponde ao impacto do jato regurgitante da insuficiência aórtica sobre o folheto anterior da valva mitral.', false),
(gen_random_uuid(), '5ab93625-48c8-41e5-951c-57f6fd763592', 'd', 'Dentre as etiologias de insuficiência aórtica, encontramos valva aórtica bicúspide, síndrome de Marfan e espondilite anquilosante.', false),
(gen_random_uuid(), '5ab93625-48c8-41e5-951c-57f6fd763592', 'e', 'O sinal de Quincke representa a pulsação visível no leito ungueal, enquanto o sinal de Müller consiste em pulsações sistólicas da úvula.', false),

(gen_random_uuid(), 'a6a79759-eabd-4087-a399-a4dfca61f11e', 'a', 'Sinal de Müller é o movimento involuntário da cabeça acompanhando cada batimento cardíaco.', false),
(gen_random_uuid(), 'a6a79759-eabd-4087-a399-a4dfca61f11e', 'b', 'Sinal de Musset consiste em pulsações da úvula acompanhando os batimentos cardíacos.', false),
(gen_random_uuid(), 'a6a79759-eabd-4087-a399-a4dfca61f11e', 'c', 'Ruído de pistola (ou sinal de Traube) são batimentos intensos, amplos e curtos, melhor palpáveis comprimindo-se com uma mão o antebraço do paciente.', false),
(gen_random_uuid(), 'a6a79759-eabd-4087-a399-a4dfca61f11e', 'd', 'Sinal de Quincke consiste em pulsações capilares visíveis na glote.', false),
(gen_random_uuid(), 'a6a79759-eabd-4087-a399-a4dfca61f11e', 'e', 'Na regurgitação aórtica causada por doença valvar, o sopro diastólico costuma ser mais bem audível no 3º e 4º espaços intercostais da borda esternal esquerda; quando secundário à dilatação da aorta, é mais bem audível na borda esternal direita alta.', true),

(gen_random_uuid(), '501a077b-7e5a-44b9-84b4-a98841ee785a', 'a', 'Estenose aórtica.', false),
(gen_random_uuid(), '501a077b-7e5a-44b9-84b4-a98841ee785a', 'b', 'Insuficiência mitral.', false),
(gen_random_uuid(), '501a077b-7e5a-44b9-84b4-a98841ee785a', 'c', 'Estenose tricúspide.', false),
(gen_random_uuid(), '501a077b-7e5a-44b9-84b4-a98841ee785a', 'd', 'Insuficiência aórtica.', false),
(gen_random_uuid(), '501a077b-7e5a-44b9-84b4-a98841ee785a', 'e', 'Insuficiência pulmonar.', true),

(gen_random_uuid(), '1500875c-0a77-471c-be2f-01fe3494d73e', 'a', 'O sopro de Graham Steel decorre de regurgitação aórtica.', false),
(gen_random_uuid(), '1500875c-0a77-471c-be2f-01fe3494d73e', 'b', 'O sopro de estenose mitral é sistólico e apresenta reforço pré-sistólico quando em ritmo sinusal.', false),
(gen_random_uuid(), '1500875c-0a77-471c-be2f-01fe3494d73e', 'c', 'O esforço isométrico aumenta a intensidade do sopro na regurgitação mitral.', true),
(gen_random_uuid(), '1500875c-0a77-471c-be2f-01fe3494d73e', 'd', 'A oclusão das artérias braquiais pela insuflação de dois manguitos de pressão determina redução da intensidade do sopro da comunicação interventricular.', false),
(gen_random_uuid(), '1500875c-0a77-471c-be2f-01fe3494d73e', 'e', 'Sopro de insuficiência tricúspide se acentua na expiração profunda.', false),

(gen_random_uuid(), 'e2255aff-f60a-4982-a60d-8c866d6bf44d', 'a', 'Estenose aórtica.', false),
(gen_random_uuid(), 'e2255aff-f60a-4982-a60d-8c866d6bf44d', 'b', 'Insuficiência aórtica.', false),
(gen_random_uuid(), 'e2255aff-f60a-4982-a60d-8c866d6bf44d', 'c', 'Insuficiência tricúspide.', false),
(gen_random_uuid(), 'e2255aff-f60a-4982-a60d-8c866d6bf44d', 'd', 'Cardiomiopatia hipertrófica.', false),
(gen_random_uuid(), 'e2255aff-f60a-4982-a60d-8c866d6bf44d', 'e', 'Insuficiência mitral.', true),

(gen_random_uuid(), 'edd15d37-964f-42b5-83ce-bd5f344b5641', 'a', 'Estenose pulmonar grave e insuficiência mitral moderada.', false),
(gen_random_uuid(), 'edd15d37-964f-42b5-83ce-bd5f344b5641', 'b', 'Estenose aórtica moderada e insuficiência mitral moderada.', false),
(gen_random_uuid(), 'edd15d37-964f-42b5-83ce-bd5f344b5641', 'c', 'Insuficiência mitral grave.', false),
(gen_random_uuid(), 'edd15d37-964f-42b5-83ce-bd5f344b5641', 'd', 'Estenose aórtica grave.', true),
(gen_random_uuid(), 'edd15d37-964f-42b5-83ce-bd5f344b5641', 'e', 'Insuficiência aórtica grave.', false),

(gen_random_uuid(), '227784d3-780f-4b20-81ac-aa848866c547', 'a', 'O sopro se mantém inalterado.', false),
(gen_random_uuid(), '227784d3-780f-4b20-81ac-aa848866c547', 'b', 'O sopro reduz.', false),
(gen_random_uuid(), '227784d3-780f-4b20-81ac-aa848866c547', 'c', 'Não há sopro.', false),
(gen_random_uuid(), '227784d3-780f-4b20-81ac-aa848866c547', 'd', 'O sopro torna-se diastólico.', false),
(gen_random_uuid(), '227784d3-780f-4b20-81ac-aa848866c547', 'e', 'O sopro aumenta.', true),

(gen_random_uuid(), 'ed67fbc4-9cca-447b-907b-7bac440f4c0e', 'a', 'O pulso carotídeo tem baixa amplitude, ascensão lenta e pico tardio.', false),
(gen_random_uuid(), 'ed67fbc4-9cca-447b-907b-7bac440f4c0e', 'b', 'A segunda bulha é hipofonética e, quanto mais grave a estenose, mais a hipofonese se acentua.', false),
(gen_random_uuid(), 'ed67fbc4-9cca-447b-907b-7bac440f4c0e', 'c', 'O sopro aórtico é ejetivo, rude, em crescendo-decrescendo, irradia-se para as carótidas, e, quanto mais intensa a estenose, mais precoce se torna o pico máximo de intensidade do sopro.', true),
(gen_random_uuid(), 'ed67fbc4-9cca-447b-907b-7bac440f4c0e', 'd', 'O fenômeno de Gallavardin refere-se à possível irradiação de componentes de alta frequência do sopro aórtico para o ápex, que pode confundir-se com sopro de regurgitação mitral.', false),
(gen_random_uuid(), 'ed67fbc4-9cca-447b-907b-7bac440f4c0e', 'e', 'O sopro sistólico aórtico aumenta na posição de cócoras.', false),

(gen_random_uuid(), '73837f19-84ca-4902-a10b-f1bf08d5f64b', 'a', 'Fibrilação atrial, sopro sistólico em ruflar e hiperfonese de primeira bulha.', false),
(gen_random_uuid(), '73837f19-84ca-4902-a10b-f1bf08d5f64b', 'b', 'Hiperfonese de primeira bulha com estalido de abertura mitral, sopro diastólico em ruflar com reforço pré-sistólico e segunda bulha hiperfonética (componente pulmonar).', true),
(gen_random_uuid(), '73837f19-84ca-4902-a10b-f1bf08d5f64b', 'c', 'Sopro diastólico aspirativo, reforço pré-diastólico e hiperfonese de primeira bulha (componente mitral).', false),
(gen_random_uuid(), '73837f19-84ca-4902-a10b-f1bf08d5f64b', 'd', 'Sopro sistodiastólico com desdobramento fixo da segunda bulha e hipofonese de bulhas.', false),
(gen_random_uuid(), '73837f19-84ca-4902-a10b-f1bf08d5f64b', 'e', 'Sopro sistólico ejetivo irradiado para a axila com hiperfonese de segunda bulha.', false),

(gen_random_uuid(), '6b4b79c2-b204-423c-8df8-261af4088fa0', 'a', 'Atresia tricúspide.', false),
(gen_random_uuid(), '6b4b79c2-b204-423c-8df8-261af4088fa0', 'b', 'Estenose pulmonar.', false),
(gen_random_uuid(), '6b4b79c2-b204-423c-8df8-261af4088fa0', 'c', 'Insuficiência pulmonar.', false),
(gen_random_uuid(), '6b4b79c2-b204-423c-8df8-261af4088fa0', 'd', 'Estenose aórtica calcificada.', true),
(gen_random_uuid(), '6b4b79c2-b204-423c-8df8-261af4088fa0', 'e', 'Dupla lesão mitral com predomínio de estenose.', false),

(gen_random_uuid(), '3c2acc85-9020-4edd-8c22-beb121a68025', 'a', 'O intervalo entre a segunda bulha e o estalido de abertura mitral é diretamente proporcional ao gradiente entre o átrio esquerdo e o ventrículo esquerdo.', true),
(gen_random_uuid(), '3c2acc85-9020-4edd-8c22-beb121a68025', 'b', 'Hiperfonese de segunda bulha em foco pulmonar é indicativo da presença de hipertensão pulmonar.', false),
(gen_random_uuid(), '3c2acc85-9020-4edd-8c22-beb121a68025', 'c', 'O sopro é holodiastólico.', false),
(gen_random_uuid(), '3c2acc85-9020-4edd-8c22-beb121a68025', 'd', 'Geralmente, há sinais de insuficiência cardíaca direita associada.', false),
(gen_random_uuid(), '3c2acc85-9020-4edd-8c22-beb121a68025', 'e', 'A intensidade da primeira bulha geralmente é reduzida.', false),

(gen_random_uuid(), 'e6512aad-3cbd-4fc6-90c1-9e79d76faa34', 'a', 'Estenose mitral.', false),
(gen_random_uuid(), 'e6512aad-3cbd-4fc6-90c1-9e79d76faa34', 'b', 'Estenose aórtica.', true),
(gen_random_uuid(), 'e6512aad-3cbd-4fc6-90c1-9e79d76faa34', 'c', 'Insuficiência mitral.', false),
(gen_random_uuid(), 'e6512aad-3cbd-4fc6-90c1-9e79d76faa34', 'd', 'Insuficiência tricúspide crônica e grave.', false),
(gen_random_uuid(), 'e6512aad-3cbd-4fc6-90c1-9e79d76faa34', 'e', 'Comunicação intraventricular (CIV) sem hipertensão pulmonar grave.', false),

(gen_random_uuid(), 'adf4eb34-07a9-45c1-aa9f-1ca43b497584', 'a', 'Sopro de Graham Steel é o sopro diastólico devido à regurgitação da valva pulmonar por hipertensão pulmonar.', false),
(gen_random_uuid(), 'adf4eb34-07a9-45c1-aa9f-1ca43b497584', 'b', 'Sopro de Carey Coombs é o sopro sistólico mitral devido à valvulite na fase aguda de doença reumática.', true),
(gen_random_uuid(), 'adf4eb34-07a9-45c1-aa9f-1ca43b497584', 'c', 'Sopro de Austin Flint é o sopro diastólico mais bem audível no ápice, determinado pelo jato de regurgitação aórtica colidindo com o folheto anterior da mitral ou a parede livre do ventrículo esquerdo.', false),
(gen_random_uuid(), 'adf4eb34-07a9-45c1-aa9f-1ca43b497584', 'd', 'Mixoma atrial pode determinar sopro diastólico mitral.', false),
(gen_random_uuid(), 'adf4eb34-07a9-45c1-aa9f-1ca43b497584', 'e', 'Na síndrome de Marfan, pode ocorrer regurgitação da valva pulmonar por dilatação dessa artéria.', false),

(gen_random_uuid(), '828285b3-dc0b-46ea-a5e6-2c50153303d7', 'a', 'Há acentuação do sopro na fase de esforço da manobra de Valsalva.', true),
(gen_random_uuid(), '828285b3-dc0b-46ea-a5e6-2c50153303d7', 'b', 'Posição de agachamento acentua a intensidade do sopro.', false),
(gen_random_uuid(), '828285b3-dc0b-46ea-a5e6-2c50153303d7', 'c', 'Pulso paradoxal pode estar presente na forma obstrutiva da doença.', false),
(gen_random_uuid(), '828285b3-dc0b-46ea-a5e6-2c50153303d7', 'd', 'A presença de pulso tardus e parvus a diferencia da estenose aórtica.', false),
(gen_random_uuid(), '828285b3-dc0b-46ea-a5e6-2c50153303d7', 'e', 'Sopro diastólico surge quando o movimento sistólico anterior da valva mitral está presente.', false),

(gen_random_uuid(), 'c059e438-e905-49d7-a38b-343909549944', 'a', 'A fácies mitral se caracteriza por manchas róseas nos maxilares e pode estar associada a nanismo e caquexia.', false),
(gen_random_uuid(), 'c059e438-e905-49d7-a38b-343909549944', 'b', 'Situações como anemia, infecção e estresse emocional podem aumentar o gradiente transmitral, gerando discordância entre o resultado do ecocardiograma e a clínica de dispneia.', false),
(gen_random_uuid(), 'c059e438-e905-49d7-a38b-343909549944', 'c', 'Na ausculta de pacientes com fibrilação atrial, percebe-se frequentemente o reforço pré-sistólico.', true),
(gen_random_uuid(), 'c059e438-e905-49d7-a38b-343909549944', 'd', 'São causas raras a síndrome carcinoide e o lúpus eritematoso sistêmico.', false),
(gen_random_uuid(), 'c059e438-e905-49d7-a38b-343909549944', 'e', 'É contraindicação para o procedimento percutâneo a insuficiência mitral moderada a importante.', false),

(gen_random_uuid(), 'cd2c15c8-a428-48a5-99c5-f0c337e72f98', 'a', 'No desdobramento fisiológico da segunda bulha, o fechamento da valva pulmonar antecede o da aórtica.', false),
(gen_random_uuid(), 'cd2c15c8-a428-48a5-99c5-f0c337e72f98', 'b', 'A quarta bulha relaciona-se a aumento das pressões de enchimento do ventrículo esquerdo.', true),
(gen_random_uuid(), 'cd2c15c8-a428-48a5-99c5-f0c337e72f98', 'c', 'A segunda bulha coincide com o pulso carotídeo.', false),
(gen_random_uuid(), 'cd2c15c8-a428-48a5-99c5-f0c337e72f98', 'd', 'A terceira bulha é um ruído protossistólico mais audível em foco aórtico acessório.', false),
(gen_random_uuid(), 'cd2c15c8-a428-48a5-99c5-f0c337e72f98', 'e', 'A segunda bulha tem duração maior que a primeira bulha.', false),

(gen_random_uuid(), 'cdb77732-1bf9-4682-8b34-c4b13cc2570c', 'a', 'Estalido de abertura precoce.', false),
(gen_random_uuid(), 'cdb77732-1bf9-4682-8b34-c4b13cc2570c', 'b', 'B1 e B2 hipofonéticas.', true),
(gen_random_uuid(), 'cdb77732-1bf9-4682-8b34-c4b13cc2570c', 'c', 'Sopro diastólico em ruflar com reforço pré-sistólico em ritmo sinusal.', false),
(gen_random_uuid(), 'cdb77732-1bf9-4682-8b34-c4b13cc2570c', 'd', 'Sinais de congestão pulmonar.', false),
(gen_random_uuid(), 'cdb77732-1bf9-4682-8b34-c4b13cc2570c', 'e', 'Sinais de insuficiência cardíaca direita.', false),

(gen_random_uuid(), '2347ad26-c072-4c2a-8f85-9dc1ec0499d1', 'a', 'Piora do sopro com a manobra de Handgrip.', true),
(gen_random_uuid(), '2347ad26-c072-4c2a-8f85-9dc1ec0499d1', 'b', 'Sopro holodiastólico, aspirativo, decrescente, com B2 hipofonética.', false),
(gen_random_uuid(), '2347ad26-c072-4c2a-8f85-9dc1ec0499d1', 'c', 'Sopro mesossistólico, pouco rude, de baixa intensidade.', false),
(gen_random_uuid(), '2347ad26-c072-4c2a-8f85-9dc1ec0499d1', 'd', 'Sopro diastólico em ruflar.', false),
(gen_random_uuid(), '2347ad26-c072-4c2a-8f85-9dc1ec0499d1', 'e', 'Pulso em martelo d''água.', false),

(gen_random_uuid(), '68eae4bd-9775-414e-aedd-5858b2c99f45', 'a', 'Frêmitos estão associados a sopros com intensidade igual ou superior a 4+ em 6.', false),
(gen_random_uuid(), '68eae4bd-9775-414e-aedd-5858b2c99f45', 'b', 'Pulso em martelo d''água está relacionado com insuficiência aórtica acentuada.', false),
(gen_random_uuid(), '68eae4bd-9775-414e-aedd-5858b2c99f45', 'c', 'O ictus cordis está deslocado para a esquerda e para cima na insuficiência mitral acentuada.', true),
(gen_random_uuid(), '68eae4bd-9775-414e-aedd-5858b2c99f45', 'd', 'Sopro de Austin Flint não é indicador preciso de gravidade na insuficiência aórtica.', false),
(gen_random_uuid(), '68eae4bd-9775-414e-aedd-5858b2c99f45', 'e', 'O ictus cordis normal apresenta diâmetro de até 2 cm.', false),

(gen_random_uuid(), '3730b050-20ab-4666-9421-5f67a64f2578', 'a', 'Mesodiastólico.', true),
(gen_random_uuid(), '3730b050-20ab-4666-9421-5f67a64f2578', 'b', 'Sistólico precoce.', false),
(gen_random_uuid(), '3730b050-20ab-4666-9421-5f67a64f2578', 'c', 'Pré-sistólico.', false),
(gen_random_uuid(), '3730b050-20ab-4666-9421-5f67a64f2578', 'd', 'Holossistólico.', false),
(gen_random_uuid(), '3730b050-20ab-4666-9421-5f67a64f2578', 'e', 'Diastólico precoce.', false),

(gen_random_uuid(), '6302c497-7680-4c3c-ab4d-c2d4713f1740', 'a', 'O fechamento da valva pulmonar precede a valva aórtica em indivíduos sadios.', false),
(gen_random_uuid(), '6302c497-7680-4c3c-ab4d-c2d4713f1740', 'b', 'Portadores de comunicação interatrial (CIA) apresentam desdobramento constante e variável com a respiração.', false),
(gen_random_uuid(), '6302c497-7680-4c3c-ab4d-c2d4713f1740', 'c', 'Portadores de bloqueio de ramo esquerdo (BRE) apresentam desdobramento paradoxal.', true),
(gen_random_uuid(), '6302c497-7680-4c3c-ab4d-c2d4713f1740', 'd', 'Portadores de bloqueio de ramo direito têm desdobramento constante, não sendo modificado pelo padrão respiratório.', false),
(gen_random_uuid(), '6302c497-7680-4c3c-ab4d-c2d4713f1740', 'e', 'Estenose valvar mitral.', false);
