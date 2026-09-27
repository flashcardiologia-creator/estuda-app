-- Novo tema: "Taquiarritmia" (cardiologia), banca SBC — último tema da leva.
-- Fonte: documento enviado pelo usuário (Google Docs) — questões numeradas no
-- documento (algumas sem número visível, preenchendo posições na sequência —
-- contadas normalmente aqui). A questão sobre extrassístoles ventriculares
-- idiopáticas (logo após a questão que trata de bloqueios AV/intraventriculares
-- neste arquivo) não tinha NENHUMA alternativa listada no documento fonte —
-- sem as 5 opções, não é possível reproduzir enunciado+alternativas fiéis ao
-- texto fonte, então ela foi OMITIDA aqui.
--
-- A questão sobre WPW com fibrilação atrial e período refratário da via
-- acessória < 50 ms (mais adiante neste arquivo) só trazia a alternativa "A -
-- Ablação por cateter" formatada no documento; as alternativas B a E foram
-- reconstruídas a partir da própria explicação do documento, que nomeia cada
-- fármaco contraindicado nessa ordem (amiodarona, sotalol, digoxina,
-- verapamil) — está sinalizado no comentário completo dessa questão
-- especificamente, caso queira conferir/corrigir com o Google Doc original.
--
-- Restam 66 questões usáveis no total.
--
-- Este documento já trazia boas explicações prontas para cada questão —
-- usadas como base para os comentários (resumido e completo) abaixo.
--
-- ENUNCIADO E ALTERNATIVAS são cópia literal do documento fonte, exceto por
-- correções de erros de digitação evidentes do próprio documento (sem
-- alterar conteúdo/sentido): "Duchene"->"Duchenne"; "Abração"->"Ablação".
--
-- IMPORTANTE — a grande maioria das questões deste tema faz referência a um
-- traçado de ECG (ou, na questão 56, a imagem de um dispositivo/CDI
-- subcutâneo) que não está incluído aqui ainda (sem imagem por enquanto); os
-- comentários já descrevem em texto os achados relevantes, então as questões
-- continuam respondíveis e didáticas mesmo sem a imagem. As imagens serão
-- adicionadas depois.
--
-- Rode este arquivo uma vez no SQL Editor do seu projeto Supabase.

insert into public.questions (id, tema, ano, instituicao, enunciado, comentario, comentario_completo) values

('f0f907c9-6524-4500-96fb-e3351cabea2c', 'Taquiarritmia', 2019, 'SBC', 'Homem, 62 anos, portador de cardiopatia chagásica e disfunção ventricular esquerda grave (fração de ejeção [FE] = 29%). Havia apresentado um episódio de síncope há 8 dias. Encontrava-se internado para investigação diagnóstica, quando apresentou episódio de palpitação com sudorese profusa. O eletrocardiograma (ECG) realizado no momento do sintoma encontra-se nesta imagem. Qual o diagnóstico eletrocardiográfico e a conduta indicada?', 'O ECG mostra taquicardia de QRS largo e monomórfica em paciente com cardiopatia chagásica grave (FE 29%) — TV monomórfica sustentada até que se prove o contrário. Como há instabilidade (síncope prévia + sudorese agora), a conduta é cardioversão elétrica imediata, seguida de CDI por profilaxia secundária (já houve evento arrítmico + síncope).', 'O ECG revela uma taquicardia de complexo largo (QRS alargado), monomórfica (complexos com morfologia uniforme), o que, em um paciente com cardiopatia estrutural grave (Chagas e FE 29%), é Taquicardia Ventricular (TV) Monomórfica Sustentada até que se prove o contrário. Como o paciente apresenta quadro clínico de instabilidade (síncope prévia e, agora, palpitação com sudorese, sugerindo má perfusão), a cardioversão elétrica imediata é o tratamento de escolha. Quanto à prevenção: o paciente teve um episódio de taquicardia ventricular sustentada (documentada) e síncope, caracterizando indicação de prevenção SECUNDÁRIA de morte súbita, o que justifica o implante de CDI — diferente da profilaxia primária, reservada para pacientes que ainda não apresentaram eventos arrítmicos sustentados.

Por que as outras alternativas estão incorretas:
• A) Não se trata de TPSV com aberrância — o contexto de cardiopatia estrutural grave torna a TV monomórfica o diagnóstico mais provável e mais seguro a assumir.
• B) Não é polimórfica (a morfologia é uniforme/monomórfica) — "revisão laboratorial" também não é a conduta prioritária diante de instabilidade.
• D) Não é fibrilação atrial — o contexto (QRS largo monomórfico) não corresponde a essa arritmia.
• E) A indicação de CDI aqui é de profilaxia SECUNDÁRIA (já houve TV sustentada + síncope), não primária.'),

('8c3a169c-a6c0-4723-874c-39e17dde854d', 'Taquiarritmia', 2018, 'SBC', 'Morte súbita cardíaca é uma importante causa de óbito. Assinale a causa de morte súbita cujos fatores desencadeantes sejam ruídos intensos:', 'A Síndrome do QT Longo tipo 2 é classicamente desencadeada por estímulos auditivos súbitos (despertador, ruído intenso, sustos), que podem precipitar Torsades de Pointes.', 'A Síndrome do QT Longo tipo 2 (SQTL2) está associada a mutações no gene KCNH2, que codifica o canal de potássio IKr. Esta variante específica da síndrome é frequentemente desencadeada por estímulos auditivos súbitos, como o toque de um despertador, um ruído intenso ou sustos, que podem precipitar arritmias ventriculares graves, como Torsades de Pointes.

Por que as outras alternativas estão incorretas:
• A) A fibrilação ventricular idiopática não tem um gatilho característico específico como o ruído.
• B) A Síndrome de Brugada é geralmente associada a eventos durante o repouso ou sono, não a ruídos.
• C) A taquicardia ventricular polimórfica catecolaminérgica (TVPC) é classicamente desencadeada por estresse emocional ou esforço físico intenso (descarga adrenérgica), não especificamente por ruídos.
• E) Na displasia arritmogênica do ventrículo direito, os eventos são tipicamente relacionados ao exercício físico.'),

('41304e7d-35e4-4acc-9cb0-3bc81cb044df', 'Taquiarritmia', 2021, 'SBC', 'Homem, 39 anos, com episódios frequentes de palpitações taquicárdicas, de início e término súbitos, muito sintomáticas, porém não documentadas. O ecocardiograma é normal e o eletrocardiograma de repouso apresenta pré-excitação ventricular (onda Delta). A respeito do quadro clínico é correto afirmar:', 'A presença de onda Delta ao ECG de repouso já define pré-excitação ventricular (WPW) — a principal hipótese é taquicardia supraventricular mediada por via acessória, não reentrada nodal.', 'O eletrocardiograma de repouso do paciente apresenta uma onda Delta (encurtamento do intervalo PR e empastamento da porção inicial do complexo QRS), que é o marcador eletrocardiográfico clássico de pré-excitação ventricular (Síndrome de Wolff-Parkinson-White). Em um paciente jovem com palpitações paroxísticas e pré-excitação ao ECG, a principal hipótese diagnóstica é uma taquicardia por reentrada atrioventricular mediada por via acessória.

Por que as outras alternativas estão incorretas:
• A) A taquicardia por reentrada nodal é a causa mais comum de TSV paroxística, mas ocorre em pacientes SEM pré-excitação ao ECG — a onda Delta aponta diretamente para a via acessória.
• B) Bloqueio de ramo esquerdo não é o marcador típico da via de Mahaim, e a descrição da pré-excitação ao ECG já define a conduta principal.
• D) Embora a FA possa ocorrer no contexto de pré-excitação, os episódios de início/término súbitos com pré-excitação tornam a taquicardia por reentrada a hipótese mais provável e característica.
• E) O ECG com pré-excitação já é achado diagnóstico suficiente para direcionar a investigação; a ressonância não é o exame complementar inicial indicado.'),

('2ba43467-2567-4cda-add5-8a6e5da887e0', 'Taquiarritmia', 2020, 'SBC', 'Homem, 79 anos, com queixa de palpitações e dispneia de início súbito. É hipertenso e diabético. Ao exame físico, pressão arterial = 80 x 50 mmHg e estertores crepitantes nas bases pulmonares. Conforme eletrocardiograma abaixo, qual a correta conduta inicial para a reversão da arritmia desse paciente?', 'Paciente instável (hipotenso + edema pulmonar agudo) — diante de qualquer taquiarritmia sintomática com instabilidade hemodinâmica, a conduta mandatória é cardioversão elétrica sincronizada imediata.', 'O paciente apresenta um quadro de instabilidade hemodinâmica (hipotensão arterial com PA = 80 x 50 mmHg e sinais de insuficiência cardíaca aguda, como estertores pulmonares). Diante de qualquer taquiarritmia sintomática com instabilidade, a conduta mandatória de acordo com as diretrizes de suporte avançado de vida e cardiologia é a cardioversão elétrica sincronizada imediata.

Por que as outras alternativas estão incorretas:
• B, C, E) Fármacos antiarrítmicos (adenosina, verapamil, amiodarona) são utilizados para o controle do ritmo ou da frequência em pacientes hemodinamicamente ESTÁVEIS. Em pacientes instáveis, o tempo gasto com medicações pode agravar o quadro clínico.
• D) A ablação é um procedimento eletivo (ou para casos refratários) e não é a conduta inicial para a reversão de uma emergência arrítmica com instabilidade hemodinâmica.'),

('7b766a6a-a647-425a-9c33-ff7a72f9cf68', 'Taquiarritmia', 2020, 'SBC', 'Homem, 43 anos, com história prévia de infarto inferior há três anos tratado com angioplastia primária de artéria coronária direita. Classe funcional I. O ecocardiograma evidenciava acinesia inferodorsal, com fração de ejeção preservada. Apresentou episódio súbito de palpitação taquicárdica. Na admissão, estava lúcido e com pressão arterial 70 x 40 mmHg. O eletrocardiograma da admissão encontra-se abaixo. Qual o diagnóstico e a conduta corretos?', 'TV monomórfica sustentada (QRS largo monomórfico + cicatriz de infarto prévio) com instabilidade hemodinâmica (PA 70x40) — a conduta é cardioversão elétrica SINCRONIZADA (não desfibrilação, pois há pulso/ritmo organizado).', 'O paciente apresenta um quadro de Taquicardia Ventricular (TV) Monomórfica Sustentada (caracterizada pelo QRS largo, monomórfico, em um paciente com cardiopatia estrutural prévia — cicatriz de infarto inferior). Devido à instabilidade hemodinâmica (PA = 70 x 40 mmHg), a conduta correta e mandatória é a cardioversão elétrica SINCRONIZADA.

Por que as outras alternativas estão incorretas:
• B e C) O diagnóstico eletrocardiográfico e clínico não corresponde a taquicardia ramo a ramo ou antidrômica.
• D) Em ritmos organizados com pulso (como a TV monomórfica), utiliza-se a cardioversão SINCRONIZADA, não a desfibrilação (que é utilizada para ritmos caóticos como fibrilação ventricular ou TV sem pulso).
• E) O uso de adenosina é CONTRAINDICADO em quadros de taquicardia com QRS largo e instabilidade hemodinâmica, podendo ser fatal.'),

('b4c5e8df-a776-4975-8250-e7e98b8dfe21', 'Taquiarritmia', 2022, 'SBC', 'Assinale a alternativa correta sobre a taquicardiomiopatia:', 'A taquicardiomiopatia (disfunção ventricular sistólica induzida por taquiarritmia persistente ou extrassístoles muito frequentes) pode ocorrer mesmo em coração estruturalmente normal, e tipicamente é REVERSÍVEL com o controle da arritmia causadora.', 'A taquicardiomiopatia é uma forma de disfunção ventricular sistólica induzida por taquiarritmias persistentes ou contrações ventriculares prematuras frequentes. Ela pode ocorrer em corações estruturalmente normais, sendo caracterizada por dilatação das câmaras e redução da fração de ejeção que, fundamentalmente, pode ser reversível com o controle da frequência cardíaca ou a restauração do ritmo sinusal.

Por que as outras alternativas estão incorretas:
• A) A forma mais comum de taquicardiomiopatia NÃO é a taquicardia sinusal inapropriada, mas sim arritmias como fibrilação atrial, flutter atrial ou taquicardias atriais ectópicas.
• C) Contrações ventriculares prematuras (extrassístoles) muito frequentes (geralmente > 10-15% dos batimentos ao Holter) SÃO, sim, causa reconhecida de taquicardiomiopatia.
• D) Arritmias VENTRICULARES (TV ou grande carga de extrassístoles) também podem causar taquicardiomiopatia, não sendo restrito a arritmias supraventriculares.
• E) Ao contrário do afirmado, a disfunção ventricular na taquicardiomiopatia é TIPICAMENTE REVERSÍVEL após a eliminação da arritmia causadora.'),

('b9370780-85a9-41c5-b660-f5620343dac3', 'Taquiarritmia', 2019, 'SBC', 'As taquicardias ventriculares (TV) idiopáticas são definidas como TV monomórficas que ocorrem em pacientes sem cardiopatia estrutural ou doença coronariana. Entre elas, está a TV de via de saída de ventrículo direito (VD). Suas características eletrocardiográficas são:', 'A TV da via de saída do VD tem morfologia de bloqueio de ramo esquerdo (ativação vai do VD para o VE) com eixo elétrico INFERIOR (positivo em II, III, aVF, pois a ativação segue de cima para baixo).', 'A taquicardia ventricular idiopática originada na via de saída do ventrículo direito (VSVD) apresenta tipicamente o padrão de bloqueio de ramo esquerdo (BRE) — já que o foco está no VD, a ativação vai do VD para o VE, simulando um atraso na condução para o VE — e um eixo elétrico inferior (positivo nas derivações II, III e aVF, pois a ativação cardíaca segue um sentido de cima para baixo, do trato de saída do VD, próximo à base, em direção ao ápice).'),

('e076420d-2172-4307-ae5c-531ecb0f6191', 'Taquiarritmia', 2022, 'SBC', 'Sobre a Síndrome de Brugada (SBr), assinale a alternativa INCORRETA:', 'A Síndrome de Brugada É, sim, uma síndrome arrítmica HEREDITÁRIA (autossômica dominante, canalopatia) — por isso essa é a alternativa incorreta.', 'A Síndrome de Brugada é uma síndrome arrítmica hereditária de padrão autossômico dominante, caracterizada por canalopatias que predispõem a arritmias ventriculares graves. Afirmar que ela "não é uma síndrome arrítmica hereditária" está, portanto, incorreto, sendo esta a alternativa pedida.

Por que as outras alternativas estão corretas (não são a resposta, já que a pergunta pede a incorreta):
• A) Descreve corretamente o padrão eletrocardiográfico tipo 1 da Síndrome de Brugada (supra em cúpula ≥2mm seguido de T negativa em V1-V3).
• B) A arritmia responsável pela morte súbita na SBr é, classicamente, a taquicardia ventricular polimórfica (ou fibrilação ventricular).
• D) A SBr apresenta grande variabilidade fenotípica, com expressividade dependente de fatores genéticos e ambientais.
• E) O gene SCN5A (que codifica o canal de sódio cardíaco) é o principal gene associado à síndrome, sendo responsável por uma parcela significativa dos casos genotipados.'),

('1da985f1-f9ab-411b-987a-41adedaebbba', 'Taquiarritmia', 2018, 'SBC', 'Existem situações quando o verapamil pode ser indicado para o tratamento de arritmias ventriculares. Dentre as opções abaixo, assinale o tipo de taquicardia ventricular verapamil-sensível:', 'A taquicardia ventricular FASCICULAR (TV idiopática do VE, ou TV de Belhassen) é o exemplo clássico de TV verapamil-sensível, por envolver reentrada dentro do sistema de condução especializado (fascículo posterior esquerdo).', 'A Taquicardia Ventricular Fascicular (também conhecida como TV idiopática do ventrículo esquerdo ou TV de Belhassen) é o exemplo clássico de uma taquicardia ventricular que responde ao bloqueador de canal de cálcio (verapamil). Seu mecanismo envolve uma reentrada dentro do sistema de condução especializado (geralmente envolvendo o fascículo posterior esquerdo).

Por que as outras alternativas estão incorretas:
• A, C, D, E) Referem-se a taquicardias ventriculares associadas a cardiopatias estruturais graves (Chagas, infarto, displasia), onde o tratamento de escolha para reversão da arritmia é a cardioversão elétrica (se instável) ou fármacos como amiodarona/lidocaína, não sendo o verapamil a droga de escolha — podendo, inclusive, ser deletério em corações com disfunção ventricular importante.'),

('4cd0ab74-7d9b-4383-a3d5-215860c848d5', 'Taquiarritmia', 2021, 'SBC', 'Mulher, 43 anos, portadora de prótese valvar mitral metálica, evolui com fibrilação atrial permanente de alta resposta ventricular e difícil controle medicamentoso, mantendo frequência cardíaca > 110 bpm em repouso. Múltiplas tentativas de cardioversão elétrica e manutenção de ritmo sinusal não foram bem-sucedidas. Optou-se pela estratégia de ablação do nó atrioventricular e implante de marcapasso definitivo, realizados com sucesso. Imediatamente após o procedimento de ablação, o dispositivo foi programado em modo VVI, com frequência de 60 bpm. Após 48 horas a paciente evoluiu na enfermaria com parada cardiorrespiratória, com necessidade de desfibrilação externa e reprogramação do dispositivo. Qual o provável mecanismo do problema apresentado?', 'Após ablação do nó AV, a paciente ficou dependente de estimulação ventricular (VVI); a bradicardia/estimulação ventricular isolada favorece prolongamento do QT e Torsades de Pointes — mecanismo mais provável da PCR.', 'A paciente possui uma prótese valvar mitral metálica, que é um fator de risco significativo para fenômenos tromboembólicos. Após a ablação do nó AV, a paciente ficou dependente de estimulação ventricular (modo VVI). A ocorrência de parada cardíaca 48 horas após, exigindo desfibrilação, sugere um evento arrítmico grave. Em pacientes com bloqueio AV total ou após ablação do nó AV, a bradicardia ou a estimulação ventricular isolada pode favorecer o prolongamento do intervalo QT e a ocorrência de Torsades de Pointes (taquicardia ventricular polimórfica), especialmente se houver distúrbios eletrolíticos ou uso de medicações que prolongam o QT.

Por que as outras alternativas são menos prováveis:
• A) Deslocamento de eletrodo ventricular costuma causar perda de captura/estimulação (assistolia por falha de estímulo), não uma PCR exigindo desfibrilação (que implica ritmo caótico/FV).
• B) A taquicardia mediada por marca-passo exige um sistema DDD com condução retrógrada, não o modo VVI descrito.
• C) A reversão do bloqueio AV é irrelevante, já que o nó AV foi deliberadamente ablado (procedimento definitivo).
• D) O aumento transitório de limiares causaria falha de captura/estimulação inadequada, não uma PCR com necessidade de desfibrilação.'),

('2839a1d9-97a5-4737-aed7-0896d500c0c3', 'Taquiarritmia', 2021, 'SBC', 'No diagnóstico diferencial das taquiarritmias de QRS largo, qual achado eletrocardiográfico corrobora o diagnóstico de taquicardia supraventricular com aberrância?', 'O início da taquicardia precedido por uma onda P prematura é achado que aponta para TSV (gatilho supraventricular), diferente dos demais critérios listados, que são marcadores clássicos de TV.', 'O início súbito com uma onda P prematura seguido de taquicardia pode ser um gatilho para TSV, corroborando esse diagnóstico em vez de TV.

Por que as outras alternativas sugerem Taquicardia Ventricular (TV), não TSV:
• A) Batimentos de fusão são sinal quase patognomônico de TV, ocorrendo quando um impulso supraventricular e um impulso ventricular se fundem no miocárdio.
• B) A concordância positiva (complexos QRS positivos de V1 a V6) é altamente sugestiva de TV originada no ventrículo esquerdo.
• D) O atraso na ativação inicial (primeiro vetor, medido do início do QRS ao pico da onda R em V1 ou V6) superior a 100 ms é forte marcador de origem ventricular.
• E) O padrão de bloqueio de ramo direito com complexo QRS TRIFÁSICO (rSr'') em V1 é o critério clássico que sugere condução supraventricular com aberrância (não bifásico, como descrito nesta alternativa — a descrição de "bifásico" não corresponde ao padrão trifásico clássico de aberrância).'),

('b6c8ffc6-078d-4419-8fff-5dfc1a89ee04', 'Taquiarritmia', 2020, 'SBC', 'Em relação ao traçado eletrocardiográfico, é correto afirmar que se trata de:', 'O traçado é de taquicardia de complexo estreito, RR regular, com pseudo-R'' em V1/pseudo-S nas inferiores — achado clássico de taquicardia por reentrada nodal (dupla via nodal), a forma mais comum de TSV paroxística.', 'A taquicardia por reentrada nodal (TRN) é a forma mais comum de taquicardia supraventricular paroxística. Eletrocardiograficamente, caracteriza-se por uma taquicardia de complexo estreito, com RR regular e, frequentemente, com pseudo-ondas R em V1 ou pseudo-ondas S nas derivações inferiores (II, III, aVF), que representam a ativação atrial retrógrada simultânea ou logo após a ativação ventricular, características típicas da reentrada nodal comum ("lenta-rápida").

Por que as outras alternativas estão incorretas:
• A) A TV fascicular apresenta QRS ALARGADO (bloqueio de ramo), diferentemente do traçado de complexo estreito exibido.
• B) Na reentrada ortodrômica, a onda P retrógrada costuma ser visível APÓS o complexo QRS (intervalo RP > 70ms), o que não é a marca clássica do padrão de reentrada nodal mais comum.
• D) O flutter atrial típico apresenta ondas de "serrote" (ondas F) características na parede inferior, sem a morfologia de QRS observada nesta TSV.'),

('60631a55-9a69-4f70-8e80-152dcdff9b9c', 'Taquiarritmia', 2013, 'SBC', 'Entre os antiarrítmicos que predominantemente bloqueiam canais de potássio e prolongam a repolarização, pode ser incluído(a) o(a):', 'O sotalol é o antiarrítmico de classe III (Vaughan-Williams) entre as opções listadas, bloqueando canais de potássio e prolongando a repolarização/intervalo QT.', 'O Sotalol é classificado como um antiarrítmico de classe III (classificação de Vaughan-Williams). Sua principal característica eletrofisiológica é o bloqueio dos canais de potássio, o que retarda a repolarização e prolonga o potencial de ação e o intervalo QT.

Por que as outras alternativas estão incorretas:
• B) Diltiazem é um bloqueador de canais de cálcio (classe IV).
• C) Metoprolol é um betabloqueador (classe II).
• D) Propafenona é um bloqueador de canais de sódio (classe IC).
• E) Procainamida é um bloqueador de canais de sódio (classe IA).'),

('f682b657-233e-4bdf-a63c-a86e63f7b78b', 'Taquiarritmia', 2020, 'SBC', 'Assinale a situação em que NÃO há indicação de verapamil por via oral para pacientes com arritmias ventriculares:', 'O verapamil NÃO é indicado (e pode até ser deletério) para prevenção de morte súbita/redução de mortalidade pós-infarto — diferente das taquicardias verapamil-sensíveis (via de saída de VD, fasciculares, cardiomiopatia hipertrófica, espasmo coronariano).', 'O uso de verapamil não é indicado para a prevenção de morte súbita ou redução de mortalidade em pacientes pós-infarto do miocárdio. Em pacientes pós-infarto com disfunção ventricular ou arritmias ventriculares, o uso de bloqueadores de canais de cálcio não-diidropiridínicos (como o verapamil) pode até ser deletério, aumentando a mortalidade.

Por que as outras alternativas indicam situações onde o verapamil PODE ser útil (não são a resposta pedida):
• A, B, C, D) O verapamil é fármaco de escolha ou opção terapêutica importante para arritmias ventriculares verapamil-sensíveis, que incluem certas taquicardias idiopáticas (via de saída de VD ou fasciculares) e casos específicos associados a canalopatias ou condições como cardiomiopatia hipertrófica e espasmo coronariano (onde a isquemia é o gatilho da arritmia).'),

('2a410921-f843-4fa7-a7e3-7605be9ab895', 'Taquiarritmia', 2015, 'SBC', 'Na síndrome de Wolff-Parkinson-White, a localização da via acessória em região anterosseptal é caracterizada pela seguinte apresentação eletrocardiográfica:', 'A via acessória anterosseptal cursa com onda delta e QRS negativos em V1 (via à direita/septal, ativação inicial para longe de V1) e eixo elétrico INFERIOR.', 'A alternativa correta para a localização da via acessória em região anterosseptal é "Onda delta e QRS negativos em V1 e eixo inferior".'),

('ffa6f75b-6dc5-4e9a-8239-197cd761af1f', 'Taquiarritmia', 2015, 'SBC', 'Assinale a alternativa CORRETA com relação à taquicardia ventricular fascicular:', 'A TV fascicular é classicamente sensível ao verapamil intravenoso e raramente responde à adenosina — ocorre em corações sem cardiopatia estrutural (TV idiopática), com prognóstico geralmente benigno.', 'A taquicardia ventricular fascicular (frequentemente originada no fascículo posterior do ventrículo esquerdo) é classicamente conhecida por ser verapamil-sensível. Ela ocorre geralmente em pacientes sem cardiopatia estrutural (TV idiopática).

Por que as outras alternativas estão incorretas:
• A) Esta forma de taquicardia tem, em geral, um prognóstico BENIGNO, não estando associada a alto risco de morte súbita.
• B) Não é caracterizada por alargamento do intervalo QTc.
• C) Não há predileção pelo período noturno; os gatilhos costumam ser exercício ou estresse emocional (catecolaminérgicos).
• D) É, por definição, uma TV IDIOPÁTICA, ocorrendo em corações SEM doença estrutural.'),

('bd4094d5-f1c5-4cb5-aa62-74533218534a', 'Taquiarritmia', 2015, 'SBC', 'Em relação aos fatores predisponentes à intoxicação digitálica, assinale a alternativa ERRADA:', 'A associação com atorvastatina NÃO é um fator predisponente reconhecido para intoxicação digitálica — por isso essa é a alternativa errada.', 'A associação com atorvastatina não é um fator predisponente reconhecido para a intoxicação digitálica, sendo esta a alternativa ERRADA pedida.

Por que as outras alternativas SÃO fatores predisponentes reconhecidos (não são a resposta, já que a pergunta pede a errada):
• A) Insuficiência renal: reduz a excreção da digoxina, aumentando seus níveis séricos.
• B) Hipocalemia: a redução do potássio sérico facilita a ligação da digoxina aos receptores da bomba de sódio-potássio (Na+/K+-ATPase) no miocárdio, potencializando sua ação e toxicidade.
• C) Associação com amiodarona: reduz o clearance renal e extrarrenal da digoxina, elevando seus níveis plasmáticos.
• E) Hipomagnesemia: o magnésio é cofator importante para a função da bomba de sódio-potássio; sua deficiência contribui para instabilidade elétrica e aumenta a sensibilidade aos efeitos tóxicos do digitálico.'),

('5abeef5b-ae95-45f1-b9d0-deff2d8baacf', 'Taquiarritmia', 2014, 'SBC', 'Paciente com antecedente de hipertensão arterial sistêmica em investigação de síncope e uso de propranolol, 80 mg, três vezes ao dia, apresentou os traçados a seguir no Holter. No momento da arritmia, a paciente apresentou síncope. Com relação à conduta terapêutica, assinale a alternativa CORRETA:', 'O quadro (síncope + traçado de TV polimórfica, provável Torsades) em paciente já sob betabloqueador otimizado é sugestivo de Síndrome do QT Longo — a síncope apesar do tratamento é indicação de CDI para prevenção secundária.', 'O quadro clínico de síncope em paciente jovem, associado a traçado de taquicardia ventricular polimórfica (frequentemente Torsades de Pointes), é sugestivo de Síndrome do QT Longo (SQTL). Em pacientes que apresentam síncope (como a paciente do caso), mesmo sob terapia betabloqueadora otimizada, a indicação de implante de um Cardioversor-Desfibrilador Implantável (CDI) é recomendação de classe I/IIa nas diretrizes para prevenção secundária de morte súbita cardíaca.

Por que as outras alternativas estão incorretas:
• A e D) O padrão morfológico clássico da TV catecolaminérgica (TVC) é a taquicardia ventricular BIDIRECIONAL, e o contexto de falha terapêutica com betabloqueador em síncope direciona mais fortemente para o diagnóstico de SQTL nesta questão.
• B) A presença de síncope é marcador de ALTO risco na SQTL, tornando a indicação de CDI NECESSÁRIA, não inexistente.
• E) A ablação não é a terapia de escolha ou curativa para canalopatias (como SQTL), que possuem substrato genético difuso.'),

('efe552b9-d384-4317-b970-1688cab672c5', 'Taquiarritmia', 2019, 'SBC', 'Homem, 46 anos, com hipertensão leve à moderada e história de crises de palpitação taquicárdica desde a pré-adolescência. Ecocardiograma normal. Nos últimos anos, houve agravamento dos sintomas, apesar do uso regular de amiodarona (400 mg/dia). Após episódio sincopal, deu entrada no setor de emergência, apresentando o eletrocardiograma (ECG) da imagem. Estável hemodinamicamente. Qual o diagnóstico eletrocardiográfico e a conduta indicada?', 'TPSV com aberrância, inicialmente pelo ramo esquerdo e depois pelo direito — a conduta é adenosina para reversão aguda (paciente estável) e indicação de ablação por cateter para tratamento definitivo, já que amiodarona em dose otimizada falhou.', 'O quadro (crises desde a pré-adolescência, refratariedade à amiodarona em dose otimizada, paciente estável hemodinamicamente) é de taquicardia paroxística supraventricular (TPSV) com aberrância — inicialmente pelo ramo esquerdo e, posteriormente, pelo ramo direito. A conduta indicada é adenosina para reversão aguda da crise (paciente estável) e, como tratamento definitivo diante da refratariedade e cronicidade, indicação de ablação por cateter.

Por que as outras alternativas estão incorretas:
• A) Não há elementos que sustentem TV monomórfica sustentada como diagnóstico principal neste contexto de longa história de palpitações desde a pré-adolescência com coração estruturalmente normal.
• B) Não corresponde ao quadro de TV polimórfica descrito.
• D) A TV bidirecional é achado específico de outras condições (TVPC, intoxicação digitálica), não correspondendo ao quadro deste paciente.
• E) Não há elementos que sustentem FA em WPW como diagnóstico principal aqui.'),

('cc0aa165-f5e9-4936-9a78-0fd90afcc867', 'Taquiarritmia', 2023, 'SBC', 'Homem, 25 anos, com quadro de síncope em repouso, sem pródromos e com traumatismo craniano leve. Abaixo está o eletrocardiograma realizado após evento. Qual a conduta adequada?', 'O quadro (síncope em repouso sem pródromos, jovem) sugere canalopatia de alto risco (Brugada ou QT longo) — a conduta é implante de CDI para prevenção SECUNDÁRIA de morte súbita, já que o paciente já é sintomático (síncope).', 'Em pacientes jovens com síncope associada a padrões eletrocardiográficos compatíveis com síndromes arritmogênicas hereditárias de alto risco (como o padrão de Brugada tipo 1 ou QT longo), a indicação de implante de Cardioversor-Desfibrilador Implantável (CDI) é recomendação de classe I para prevenção secundária de morte súbita cardíaca.

Por que as outras alternativas estão incorretas:
• A) O estudo eletrofisiológico tem valor prognóstico limitado na maioria das canalopatias e não substitui a terapia de proteção (CDI) em pacientes já sintomáticos (síncope).
• B) A amiodarona não é o tratamento para prevenção de morte súbita nessas condições e pode até ser ineficaz ou deletéria.
• D) O Tilt Test é indicado para síncope vasovagal, mas não é o exame de escolha para paciente com suspeita de arritmia ventricular primária e síncope em repouso.
• E) O monitor de eventos implantável (Loop Recorder) é indicado para síncopes de etiologia indeterminada após avaliação inicial, mas, diante de um ECG com alterações sugestivas de alto risco, a conduta definitiva é o implante de CDI.'),

('071d1ebf-bcef-47f5-a7f5-2e49985433e8', 'Taquiarritmia', 2013, 'SBC', 'Paciente do sexo masculino, 55 anos, com diagnóstico prévio de cardiomiopatia hipertrófica, é internado com arritmia ventricular. O paciente é admitido na unidade coronária e, após administração de amiodarona por via intravenosa, espera-se:', 'A amiodarona IV causa vasodilatação periférica (efeito bloqueador alfa-adrenérgico + relaxamento direto da musculatura lisa vascular), podendo causar hipotensão, especialmente em bolus rápido.', 'A administração intravenosa de amiodarona, especialmente em bolus rápido, pode causar hipotensão arterial devido à sua ação vasodilatadora periférica, que ocorre por um efeito bloqueador alfa-adrenérgico e um efeito relaxante direto na musculatura lisa vascular.

Por que as outras alternativas estão incorretas:
• B) O início de ação da amiodarona IV é variável, mas geralmente NÃO é tão rápido (15-20 min); seus efeitos antiarrítmicos mais pronunciados podem levar tempo para se consolidarem.
• C) A amiodarona possui ação ANTAGONISTA (bloqueadora) dos receptores beta-adrenérgicos, não agonista.
• D) A amiodarona INIBE a conversão periférica de tiroxina (T4) em tri-iodotironina (T3), efeito conhecido sobre o metabolismo tireoidiano — o oposto do afirmado.
• E) A amiodarona possui efeito inotrópico NEGATIVO (embora leve), podendo REDUZIR a força contrátil, não aumentá-la.'),

('1ef9b39c-1796-432a-bbca-64fbbe073ceb', 'Taquiarritmia', 2020, 'SBC', 'Mulher, 23 anos, queixa de palpitações rápidas e tontura, de início súbito. Refere episódios anteriores similares. Ao exame físico: frequência cardíaca = 190 bpm; pressão arterial = 100 x 70 mmHg. O eletrocardiograma mostrava taquicardia regular, com QRS estreito, não sendo visível atividade elétrica atrial. Qual deve ser a primeira opção para a reversão dessa arritmia?', 'TSVP em paciente estável (PA 100x70) — a conduta de primeira linha é manobra vagal e, se não resolver, adenosina endovenosa (meia-vida curtíssima, alta eficácia bloqueando o nó AV).', 'O quadro clínico descrito (taquicardia regular de QRS estreito em paciente jovem, com estabilidade hemodinâmica mantida) é clássico de Taquicardia Supraventricular Paroxística (TSVP). A conduta de primeira linha, de acordo com as diretrizes de ACLS e da SBC, é o uso de manobras vagais (como a manobra de Valsalva). Caso esta não seja eficaz, a adenosina endovenosa é o fármaco de escolha por sua meia-vida curtíssima e alta eficácia em bloquear o nó atrioventricular e interromper o circuito de reentrada.

Por que as outras alternativas estão incorretas:
• A) A cardioversão elétrica é reservada para pacientes hemodinamicamente INSTÁVEIS, o que não é o caso desta paciente (PA 100x70 mmHg).
• B) A ablação é o tratamento definitivo, mas não é a manobra de reversão imediata na emergência.
• D) Embora os betabloqueadores possam ser usados, a adenosina é preferível como primeira escolha medicamentosa após a falha da manobra vagal.
• E) O uso de digitálicos não é mais a primeira opção para a reversão aguda de TSV.'),

('84b74e49-dfd9-4a33-b365-35b8473f3b3b', 'Taquiarritmia', 2023, 'SBC', 'Jovem mulher, 20 anos, sem comorbidades, apresenta palpitações e desconforto torácico iniciados há 10 minutos. Não faz uso de medicação regular. Ao exame físico, pressão arterial: 110 x 70 mmHg, frequência cardíaca: 180 bpm, eupneica, com ausculta cardiopulmonar sem alterações. Eletrocardiograma abaixo. A próxima medida a ser tomada é:', 'Taquicardia de QRS estreito regular, paciente estável (PA 110x70) — a próxima medida é manobra vagal (antes mesmo da adenosina).', 'A paciente apresenta um quadro de taquicardia de QRS estreito e regular, hemodinamicamente estável (PA 110x70 mmHg). Conforme os algoritmos de atendimento a taquicardias supraventriculares (como o da SBC e ACLS), a primeira medida indicada para pacientes estáveis é a manobra vagal (como a manobra de Valsalva).

Por que as outras alternativas são incorretas como "próxima medida":
• A) A adenosina é o fármaco de escolha, mas deve ser utilizada caso a manobra vagal falhe.
• C) A cardioversão elétrica é indicada apenas para pacientes hemodinamicamente instáveis (hipotensão, choque, alteração de nível de consciência), o que não é o caso desta paciente.
• D e E) Betabloqueadores e antiarrítmicos como a amiodarona são opções secundárias ou reservadas para situações específicas quando as manobras iniciais e a adenosina não são eficazes ou não podem ser utilizadas.'),

('5cd7ea82-d458-4575-a658-859555c5f6b6', 'Taquiarritmia', 2015, 'SBC', 'A taquicardia por reentrada nodal é caracterizada pela presença de complexos QRS estreitos e:', 'Na TRN típica (forma mais comum), o intervalo RP'' é curto, geralmente inferior a 70 ms, pois a ativação atrial ocorre quase simultaneamente à ventricular.', 'A taquicardia por reentrada nodal (TRN), na sua forma mais comum (típica ou "lento-rápida"), caracteriza-se por um intervalo RP'' curto, geralmente inferior a 70 ms. Isso ocorre porque a ativação atrial acontece quase simultaneamente à ventricular, resultando em uma onda P (quando visível) "enterrada" no complexo QRS ou imediatamente após o seu término (pseudo-onda R'' em V1 ou pseudo-onda S em derivações inferiores).

Por que as outras alternativas estão incorretas:
• A) Esta característica (RP'' > P''R) descreve taquicardias com intervalo RP LONGO, comuns na forma atípica da TRN ou na taquicardia juncional ectópica.
• B e E) Na TRN típica, a relação entre a frequência atrial e ventricular é de 1:1 (não uma maior que a outra).
• C) A dissociação atrioventricular NÃO ocorre na TRN, pois a ativação atrial é dependente da condução retrógrada do circuito de reentrada que envolve o nó atrioventricular.'),

('0db6fb3a-593f-4d62-8c7c-861883a6eb5b', 'Taquiarritmia', 2023, 'SBC', 'Em relação ao eletrocardiograma abaixo, assinale a alternativa correta sobre a localização da via acessória:', 'Segundo o gabarito oficial da banca, o padrão de pré-excitação identifica uma via acessória anterosseptal direita.', 'De acordo com o gabarito oficial da banca, a via acessória identificada pelo padrão de pré-excitação presente no traçado é a anterosseptal direita. Nota: a localização de vias acessórias em eletrocardiogramas com WPW utiliza algoritmos complexos (como o de Arruda) que avaliam a polaridade da onda delta e do complexo QRS em múltiplas derivações — diferentes interpretações técnicas podem ocorrer, mas o gabarito validado para esta questão específica é a alternativa A.'),

('135c3853-8f89-424d-98a0-d55ccc883f90', 'Taquiarritmia', 2014, 'SBC', 'Paciente masculino, 23 anos, procurou avaliação médica após um episódio de síncope sem pródromos e grave lesão corporal há 3 semanas. O exame físico, a rotina laboratorial, o ecocardiograma, a ressonância cardíaca e o tilt-test foram normais. Não fazia uso de qualquer medicação regular. O ECG basal é apresentado a seguir. Quais são o diagnóstico e a conduta médica?', 'O ECG mostra padrão clássico de Brugada tipo 1 (supra em cúpula descendente em V1-V2). Em jovem com síncope + esse padrão, indica-se implante de CDI (prevenção — já sintomático).', 'O eletrocardiograma apresentado mostra o padrão clássico de Síndrome de Brugada (tipo 1), caracterizado por supradesnivelamento do segmento ST em derivações precordiais direitas (V1 e V2), com morfologia descendente ("coved type"). Em pacientes jovens que apresentam síncope (evento de alto risco) com este achado eletrocardiográfico, a indicação de implante de CDI é recomendação de classe I para prevenção de morte súbita cardíaca.

Por que as outras alternativas estão incorretas:
• A) Embora o QT Longo também cause síncope, o padrão de ECG apresentado (supradesnivelamento de ST em precordiais direitas) é específico da Síndrome de Brugada, não do QT longo.
• B e D) O achado não é um simples atraso de condução ou bloqueio de ramo direito comum; trata-se de uma canalopatia arritmogênica de alto risco, exigindo conduta ativa (CDI) e não apenas monitorização ou estudo eletrofisiológico.
• E) A displasia arritmogênica do ventrículo direito (DAVD) é diagnóstico diferencial importante, mas a ressonância cardíaca normal fornecida torna este diagnóstico menos provável, reforçando a canalopatia (Brugada) como causa primária.'),

('58ad1ce9-087f-4e43-967a-b7f78541c2a5', 'Taquiarritmia', 2014, 'SBC', 'Paciente masculino, 58 anos, admitido na emergência com palpitação de início súbito. Apresentava-se lúcido, normocorado, eupneico, taquicárdico e com pressão arterial de 110 x 60 mmHg. O ECG de admissão é apresentado na Figura 1. Referia história de infarto do miocárdio prévio com revascularização percutânea há 4 anos. Classe funcional II (NYHA). Após a reversão da arritmia, realizou ecocardiograma, que demonstrou fração de ejeção do ventrículo esquerdo por Simpson de 29%, com átrio esquerdo de 42 mm, e extensa área discinética anterior. A cineangiocoronariografia demonstrou stent pérvio em terço proximal da artéria descendente anterior sem outras lesões obstrutivas. Rotina laboratorial normal. O ECG após a reversão é apresentado na Figura 2. Quais são o diagnóstico eletrocardiográfico da arritmia e a proposta terapêutica nesse momento?', 'TV monomórfica sustentada em cardiopatia isquêmica crônica com FE muito reduzida (29%) — indicação de CDI dupla-câmara para prevenção de morte súbita.', 'O paciente apresenta quadro de taquicardia ventricular monomórfica sustentada em contexto de cardiopatia isquêmica crônica, com disfunção ventricular importante (FE 29%). De acordo com as diretrizes de manejo de pacientes com taquicardias ventriculares e disfunção ventricular, a indicação de implante de CDI é o padrão-ouro para a prevenção de morte súbita cardíaca em pacientes com arritmias ventriculares documentadas. A escolha por um dispositivo dupla-câmara é a terapia apropriada neste momento.

Por que as outras alternativas estão incorretas:
• B e D) O diagnóstico não é de taquicardia supraventricular, visto o histórico de infarto prévio, extensa área discinética e a morfologia do traçado.
• A) Embora o ressincronizador (TRC-D) possa ser uma opção dependendo da largura do QRS (não especificada), o CDI é a indicação primordial aqui.
• C) A aneurismectomia cirúrgica não é a terapia de primeira linha para arritmias ventriculares.'),

('8c195312-973e-4d45-bdeb-4a88d1cbabbd', 'Taquiarritmia', 2013, 'SBC', 'Paciente do sexo masculino, 45 anos, é admitido com palpitação e dispneia. ECG mostra taquicardia supraventricular. Após tentativa de reversão da arritmia com manobra vagal e adenosina IV, é administrado verapamil EV. Entre os prováveis efeitos hemodinâmicos a serem observados, pode-se citar:', 'O verapamil causa vasodilatação periférica com possível hipotensão reflexa, desencadeando ativação simpática compensatória (efeitos simpáticos reflexos/taquicardia reflexa).', 'O verapamil é um bloqueador dos canais de cálcio do grupo das fenilalquilaminas. Ele possui efeito vasodilatador periférico e pode causar redução na contratilidade miocárdica (efeito inotrópico negativo). Como resposta compensatória à queda na resistência vascular periférica e à hipotensão leve que pode ocorrer após sua administração, o organismo frequentemente desencadeia uma ativação do sistema nervoso simpático, resultando em taquicardia reflexa (efeitos simpáticos reflexos).

Por que as outras alternativas estão incorretas:
• A) O verapamil tem ação inotrópica NEGATIVA (depressora da contratilidade), não positiva.
• C) Pelo contrário, o verapamil causa RELAXAMENTO da célula muscular lisa vascular (vasodilatação), não contração.
• D) A vasodilatação causada pelo verapamil decorre do bloqueio dos canais de cálcio, não sendo mediada ou bloqueada por receptores beta-adrenérgicos (propranolol).
• E) O verapamil provoca vasodilatação TANTO nas artérias coronárias QUANTO nos leitos vasculares periféricos.'),

('0771f98c-abf3-4912-9f54-d3b00935b99d', 'Taquiarritmia', 2015, 'SBC', 'Paciente feminina, 56 anos, com queixa de palpitação de início há 40 minutos, muito sintomática, porém sem sinais ou sintomas de baixo débito cardíaco. A pressão arterial na admissão era 130 × 80 mmHg. O traçado da crise encontra-se abaixo. Não apresenta cardiopatia estrutural e nenhuma outra comorbidade clínica. Quais são o diagnóstico e o tratamento na emergência?', 'TSV com aberrância pelo ramo direito, paciente estável — administração imediata de adenosina (conforme gabarito da plataforma).', 'É uma taquicardia supraventricular com aberrância (morfologia de bloqueio de ramo direito). Como a paciente encontra-se estável hemodinamicamente, a adenosina é a droga de escolha para a reversão da arritmia (explicação conforme gabarito da plataforma).'),

('51beae04-abb7-4da0-bd10-893acda90a64', 'Taquiarritmia', 2014, 'SBC', 'Durante a realização de um teste ergométrico, paciente refere dor torácica intensa. Sinais vitais: pressão arterial, 60x40 mmHg; saturação de oxigênio, 87%; frequência cardíaca, 220 bpm; frequência respiratória, 25 rpm. Quais são o ritmo provável e a conduta imediata?', 'Instabilidade hemodinâmica grave (choque) + taquicardia de complexo largo em 220 bpm = TV monomórfica; a conduta é cardioversão elétrica sincronizada imediata, independentemente do tipo exato de taquicardia.', 'O paciente apresenta um quadro clínico de instabilidade hemodinâmica grave (hipotensão 60x40 mmHg, dor torácica, alteração da saturação) associado a uma taquicardia de complexo largo com frequência de 220 bpm, característica de uma Taquicardia Ventricular (TV) monomórfica. Em situações de instabilidade hemodinâmica, a conduta preconizada pelos protocolos de ACLS é a cardioversão elétrica sincronizada imediata, independentemente do tipo de taquicardia, para reverter a arritmia e restaurar o débito cardíaco.

Por que as outras alternativas estão incorretas:
• A) O paciente apresenta sinais claros de choque cardiogênico, logo, NÃO está estável.
• C) A amiodarona é opção para TV estável; em pacientes instáveis, a prioridade é a desfibrilação/cardioversão.
• D e E) O diagnóstico de taquicardia supraventricular é improvável diante do QRS alargado e da gravidade clínica, e retardar a cardioversão para administrar medicamentos como adenosina ou diltiazem em paciente instável é conduta contraindicada.'),

('252f80d1-b3e9-4d54-b987-7c1352cdcb96', 'Taquiarritmia', 2017, 'SBC', 'Sobre a taquicardia ventricular polimórfica catecolaminérgica, é INCORRETO afirmar:', 'A TVPC se manifesta tipicamente de forma PRECOCE (infância/adolescência), não a partir da sétima década de vida — por isso essa é a alternativa incorreta.', 'A afirmação é falsa, pois a taquicardia ventricular polimórfica catecolaminérgica, ao contrário de algumas arritmias degenerativas, manifesta-se tipicamente de forma precoce, durante a infância ou adolescência, e não na sétima década de vida.

Por que as outras alternativas estão corretas (não são a resposta, já que a pergunta pede a incorreta):
• A, B, D, E) São afirmações verdadeiras sobre a patologia. A TVPC é uma canalopatia hereditária caracterizada por um ECG de repouso (incluindo o intervalo QT) normal, mas com arritmias graves e frequentemente bidirecionais deflagradas por estresse ou esforço físico, sendo a restrição a atividades físicas intensas parte fundamental do manejo clínico.'),

('c172d19f-de2d-40e4-9249-bca1198d9da1', 'Taquiarritmia', 2015, 'SBC', 'Sobre as alterações dos distúrbios hidroeletrolíticos no eletrocardiograma de repouso, pode-se afirmar que:', 'O efeito mais precoce e clássico da hiperpotassemia é o surgimento de ondas T apiculadas, estreitas e pontiagudas, "em tenda".', 'O efeito eletrocardiográfico mais precoce e clássico da hiperpotassemia (hipercalemia) é o surgimento de ondas T apiculadas, estreitas e com base estreita, frequentemente descritas como "em tenda" ou "em barraca".

Por que as outras alternativas estão incorretas:
• A) A hipocalcemia tipicamente PROLONGA o intervalo QT à custa do alongamento do segmento ST.
• B) A hipercalcemia ENCURTA o segmento ST (e consequentemente o intervalo QT), não o aumentando.
• C) Na hiperpotassemia, ocorre a DIMINUIÇÃO da amplitude da onda P (e até seu desaparecimento), não o aumento. O alargamento do QRS é sinal tardio de hiperpotassemia grave.
• E) A onda J (de Osborn) é tipicamente associada à HIPOTERMIA, não à hiponatremia.'),

('f2c993e5-2864-4c87-80ac-b5b8bb577129', 'Taquiarritmia', 2016, 'SBC', 'Paciente masculino, 18 anos, vem à avaliação por repetidos episódios sincopais, especialmente aos esforços. Exame físico e ecocardiograma são normais. Eletrocardiograma com bradicardia sinusal e presença de onda U. Ao teste ergométrico, desenvolveu taquicardia ventricular bidirecional no pico do esforço, com bloqueio atrioventricular total temporário e curto ao interromper a taquicardia. Qual é o mais provável diagnóstico no caso?', 'Síncope induzida por esforço, ecocardiograma normal e TV bidirecional deflagrada pelo esforço é o padrão-ouro para o diagnóstico de Taquicardia Ventricular Polimórfica Catecolaminérgica (TVPC).', 'O quadro clínico de um paciente jovem com síncope induzida pelo esforço, em presença de ecocardiograma normal e arritmia ventricular típica (taquicardia ventricular bidirecional) deflagrada por esforço, é o padrão-ouro para o diagnóstico de Taquicardia Ventricular Polimórfica Catecolaminérgica (TVPC). A presença de onda U no ECG de repouso e as pausas ou bloqueios atrioventriculares transitórios pós-esforço também são achados frequentemente associados a esta condição.

Por que as outras alternativas estão incorretas:
• A) Amiloidose causaria alterações estruturais evidentes no ecocardiograma.
• B) BAV total congênito isolado não explica o desencadeamento de taquicardia ventricular bidirecional pelo esforço.
• C) Embora o QT longo possa causar síncope ao esforço, a descrição da taquicardia bidirecional é muito mais específica da TVPC.
• D) A Síndrome de Brugada apresenta padrão eletrocardiográfico específico (supradesnivelamento de ST em V1-V2) e não é tipicamente induzida apenas pelo esforço físico intenso da mesma forma que a TVPC.'),

('e4addfc7-e044-42cd-a6f9-6f3e032ae018', 'Taquiarritmia', 2017, 'SBC', 'A ablação e a modificação da condução atrioventricular podem ser consideradas nas condições a seguir, EXCETO:', 'A ablação/modificação da condução AV não é indicada em taquicardias atriais esquerdas ASSINTOMÁTICAS — o risco do procedimento (incluindo dependência de marca-passo) não se justifica sem sintomas.', 'A ablação e a modificação da condução atrioventricular (geralmente acompanhada de implante de marcapasso definitivo) é procedimento invasivo indicado para controle de frequência em arritmias SINTOMÁTICAS. Não há indicação para realizar este procedimento em taquicardias assintomáticas, pois o risco do procedimento (incluindo a dependência permanente de marcapasso) não justifica a intervenção na ausência de sintomas.

Por que as outras alternativas SÃO indicações possíveis (não são a resposta pedida):
• B, C, D, E) Descrevem cenários onde o controle farmacológico da frequência é ineficaz, impossível ou o paciente é sintomático, tornando a modificação da condução atrioventricular estratégia terapêutica reconhecida para melhorar a qualidade de vida e evitar a cardiomiopatia induzida por taquicardia.'),

('d1cb5542-6566-443f-b8f4-b68bdc337646', 'Taquiarritmia', 2024, 'SBC', 'Sobre os fármacos antiarrítmicos é correto afirmar:', 'Historicamente, a maioria dos antiarrítmicos não reduziu mortalidade global em cardiopatas (estudo CAST) — apenas os betabloqueadores demonstraram redução consistente de mortalidade nessa população.', 'Historicamente, diversos estudos (como o CAST) demonstraram que a maioria dos agentes antiarrítmicos, embora eficazes em suprimir arritmias, não reduziu a mortalidade global e, em alguns casos, aumentou o risco de morte em pacientes com cardiopatia estrutural. Os betabloqueadores são, de fato, a classe de fármacos que demonstrou redução consistente na mortalidade de pacientes cardiopatas.

Por que as outras alternativas estão incorretas:
• B) O sotalol é geralmente CONTRAINDICADO ou usado com extrema cautela em pacientes com IC e disfunção ventricular grave, pelo efeito inotrópico negativo e potencial pró-arrítmico.
• C) A propafenona é CONTRAINDICADA em pacientes com cardiopatia isquêmica e disfunção ventricular, pelo risco de arritmias ventriculares graves (efeito pró-arrítmico).
• D) A adenosina, embora preferencialmente usada em taquicardias de QRS estreito, NÃO é contraindicação absoluta em todas as taquicardias de QRS largo, podendo ser usada para fins diagnósticos em taquicardias de QRS largo monomórficas estáveis com dúvida diagnóstica (com extrema cautela).
• E) Esta é contraindicação clássica: bloqueadores do nó AV (diltiazem, verapamil e digoxina) NÃO devem ser usados em pacientes com síndrome de WPW, pois podem facilitar a condução pela via acessória e precipitar fibrilação ventricular.'),

('d5116c38-25d9-41ac-8321-b3bb079e682d', 'Taquiarritmia', 2014, 'SBC', 'Sobre a cardiomiopatia arritmogênica do ventrículo direito, assinale a alternativa CORRETA:', 'As alterações eletrocardiográficas típicas da CAVD incluem inversão de onda T nas precordiais direitas, QRS alargado nessas derivações e a onda épsilon.', 'As alterações eletrocardiográficas típicas da Cardiomiopatia Arritmogênica do Ventrículo Direito (CAVD) incluem a inversão da onda T nas derivações precordiais direitas (V1-V3), prolongamento do complexo QRS nessas mesmas derivações (devido ao retardo de condução pelo miocárdio substituído por gordura e fibrose) e a presença da onda épsilon (pequena deflexão terminal no final do complexo QRS, também nas precordiais direitas).

Por que as outras alternativas estão incorretas:
• B) A doença PODE acometer o ventrículo esquerdo, especialmente em estágios mais avançados (formas biventriculares).
• C) A herança é, na maioria dos casos, AUTOSSÔMICA DOMINANTE (embora existam formas recessivas, como a Síndrome de Naxos).
• D) Os sintomas costumam surgir PRECOCEMENTE, geralmente entre a segunda e a quarta década de vida.
• E) Os betabloqueadores SÃO uma das principais bases do tratamento farmacológico para controle de arritmias e redução dos sintomas em pacientes com CAVD.'),

('2d9c92c2-2f61-4f70-82e9-a9e26da19e84', 'Taquiarritmia', 2015, 'SBC', 'Paciente masculino, 32 anos, com história prévia de crises de palpitação taquicárdica. Deu entrada na emergência com queixa de palpitação de início há uma hora e sinais e sintomas de baixo débito cardíaco (ECG abaixo). Não apresenta cardiopatia estrutural (ecocardiograma prévio normal). Quais são o diagnóstico e a conduta indicados?', 'O traçado (taquicardia IRREGULAR de complexo largo, FC muito elevada) é de fibrilação atrial em portador de pré-excitação ventricular (WPW) — com baixo débito, a conduta é cardioversão elétrica imediata e posterior ablação da via acessória.', 'O traçado eletrocardiográfico apresenta uma taquicardia irregular de complexo largo, com frequência cardíaca muito elevada, compatível com fibrilação atrial conduzida através de uma via acessória (Síndrome de Wolff-Parkinson-White). A irregularidade (intervalos R-R variáveis) é a chave diagnóstica que a diferencia de uma taquicardia ventricular monomórfica. Como o paciente apresenta sinais de baixo débito (instabilidade hemodinâmica), a cardioversão elétrica imediata é o tratamento de escolha, seguida de estudo eletrofisiológico e ablação da via acessória para tratamento definitivo.

Por que as outras alternativas estão incorretas:
• A, D, E) O traçado não apresenta a morfologia clássica de "torsades de pointes" (que exige intervalo QT longo prévio) ou de taquicardia ventricular bidirecional.
• B) Fibrilação atrial com aberrância (bloqueio de ramo) geralmente apresenta QRS mais uniforme e não causa a mesma instabilidade hemodinâmica tão rapidamente em pacientes sem cardiopatia, além de não ser o diagnóstico principal diante da pré-excitação oculta ou patente.'),

('4098bf4a-b620-412d-a0a5-a7742ed531f1', 'Taquiarritmia', 2015, 'SBC', 'Homem de 76 anos foi admitido no serviço de emergência com queixa de palpitações taquicárdicas e refere ser portador de insuficiência cardíaca. Foi realizado o eletrocardiograma abaixo. O diagnóstico eletrocardiográfico e o exame para esclarecimento da causa do ritmo cardíaco apresentado são, respectivamente:', 'O traçado tem 3+ morfologias de onda P com PP/PR/RR irregulares — Taquicardia Atrial Multifocal (TAM). Deve-se dosar nível sérico de digoxina, já que a intoxicação digitálica é causa clássica de TAM.', 'O traçado eletrocardiográfico apresenta características de Taquicardia Atrial Multifocal (TAM): frequência cardíaca > 100 bpm, presença de pelo menos três morfologias diferentes de onda P com intervalos P-P, P-R e R-R irregulares. A TAM está frequentemente associada a doenças pulmonares crônicas, distúrbios eletrolíticos ou toxicidade por medicamentos, sendo o nível sérico de digoxina exame fundamental para descartar intoxicação digitálica como fator precipitante em pacientes que fazem uso desse fármaco.

Por que as outras alternativas estão incorretas:
• A) A fibrilação atrial é caracterizada pela ausência de ondas P definidas, o que não é o caso aqui (observam-se ondas P com diferentes morfologias).
• B e D) O ritmo apresentado NÃO é sinusal, pois a morfologia da onda P não é constante.
• E) A taquicardia juncional não apresenta a variabilidade de ondas P observada na taquicardia atrial multifocal.'),

('bb6f61be-fa39-483f-85a1-9e03f8dbe3dd', 'Taquiarritmia', 2014, 'SBC', 'Quanto aos betabloqueadores, assinale a alternativa CORRETA:', 'Betabloqueadores hidrofílicos (como atenolol) têm menor metabolismo hepático (excreção renal), o que permite posologia de dose única diária em muitos casos.', 'Os betabloqueadores hidrofílicos (como o atenolol) apresentam menor metabolismo hepático, maior meia-vida e excreção predominantemente renal, o que permite, em muitos casos, a posologia de uma única dose diária.

Por que as outras alternativas estão incorretas:
• B) O carvedilol é ALTAMENTE lipofílico, o que facilita sua passagem pela barreira hematoencefálica (ao contrário da afirmação da alternativa).
• C) O bisoprolol é considerado betabloqueador altamente seletivo para receptores β1, SUPERIOR à seletividade do metoprolol.
• D) A seletividade de um fármaco é característica intrínseca de sua afinidade química pelos receptores; o AUMENTO da dose, na verdade, tende a DIMINUIR a seletividade, podendo levar ao bloqueio de receptores β2.
• E) Embora carvedilol, bisoprolol e succinato de metoprolol tenham benefício comprovado na redução de mortalidade na IC sistólica, o ATENOLOL NÃO tem esse benefício comprovado para essa indicação.'),

('e01ada26-76a1-4a58-938b-01e11cfb5e54', 'Taquiarritmia', 2025, 'SBC', 'Paciente de 46 anos no primeiro dia de pós-operatório de troca valvar aórtica evolui com frequência cardíaca elevada. Nega dispneia, dor torácica ou outras alterações. É obtido o seguinte eletrocardiograma. Sobre esse cenário, é correto afirmar:', 'FA pós-operatória: a incidência é comprovadamente maior após cirurgia valvar do que após revascularização miocárdica, pelo maior trauma/manipulação atrial nas cirurgias valvares.', 'A fibrilação atrial (FA) é complicação pós-operatória frequente em cirurgias cardíacas. A incidência é comprovadamente maior em cirurgias de troca valvar do que em cirurgias de revascularização do miocárdio, devido ao maior trauma atrial e à manipulação necessária nessas intervenções.

Por que as outras alternativas estão incorretas:
• A) A decisão de anticoagulação de longo prazo depende do escore de risco tromboembólico (ex: CHA2DS2-VASc) e da persistência da arritmia, não sendo indicada para "todos" os pacientes automaticamente.
• B) Pelo contrário, o uso de betabloqueadores no pré-operatório é estratégia estabelecida para PREVENIR o surgimento de FA no pós-operatório.
• C) A amiodarona NÃO é contraindicada; é uma das opções farmacológicas para controle de ritmo ou frequência em pacientes com FA pós-operatória.
• D) O paciente está ESTÁVEL (nega dispneia, dor torácica ou outras alterações). Em pacientes hemodinamicamente estáveis com FA pós-operatória, a estratégia inicial preferencial é o controle da frequência ventricular (ou reversão química), não sendo mandatória a cardioversão elétrica imediata.'),

('5162f415-2786-4f2c-9bb7-50c0c12eb861', 'Taquiarritmia', 2024, 'SBC', 'Dentre as alternativas abaixo, assinale aquela na qual o estudo eletrofisiológico diagnóstico está indicado:', 'Em cardiomiopatia chagásica com FE 45% + BRD + bloqueios AV Mobitz II intermitentes + síncope precedida de taquicardia, o EEF é fundamental para documentar a arritmia e orientar a conduta (dispositivo/ablação).', 'O estudo eletrofisiológico (EEF) está indicado em casos onde há suspeita de arritmias complexas que explicam sintomas como síncope, especialmente em cardiopatias onde a estratificação de risco é crucial. Em pacientes com cardiomiopatia chagásica que apresentam síncope precedida por taquicardia e alterações na condução (bloqueio atrioventricular Mobitz II), o EEF é fundamental para documentar a arritmia e orientar a conduta terapêutica (como o implante de dispositivos ou ablação).

Por que as outras alternativas são menos adequadas (no contexto de indicação de EEF diagnóstico):
• A) Pacientes com FE muito reduzida (26%) e TVNS já possuem indicação classe I de implante de CDI (prevenção primária), não sendo o EEF diagnóstico a etapa mandatória para decisão terapêutica.
• B) A Síndrome de Brugada com síncope típica já possui indicação de implante de CDI por si só; o EEF diagnóstico não é o padrão de conduta para decidir o tratamento nesse cenário.
• D) A cardiomiopatia hipertrófica possui critérios próprios (como espessura septal ≥ 30 mm ou síncope inexplicada) que já estratificam o risco para indicação de CDI, não sendo o EEF a ferramenta principal de escolha.
• E) O bloqueio Mobitz I e pausas sinusais durante o sono são, muitas vezes, achados benignos (fisiológicos) em indivíduos assintomáticos, não justificando um procedimento invasivo como o EEF.'),

('a39138c4-a56a-4fb0-a121-fc604341bd76', 'Taquiarritmia', 2018, 'SBC', 'Paciente do sexo feminino, com 26 anos de idade, foi atendida na emergência com queixa de palpitações rápidas de início súbito há cerca de 40 minutos. Negava outros sintomas ou antecedentes significativos. Informou que, há menos de 4 meses, durante avaliação para prática desportiva, realizara exame cardiológico, inclusive com ecocardiograma com resultados normais. No atendimento, foi verificado: ritmo cardíaco regular; pressão arterial (PA) = 110 x 70 mmHg; nenhuma outra anormalidade. Conforme eletrocardiograma, o diagnóstico mais provável para a arritmia desta paciente é:', 'Jovem sem cardiopatia estrutural, taquicardia de início súbito, ritmo regular, bom estado hemodinâmico — quadro clássico de Taquicardia Paroxística Supraventricular.', 'O quadro clínico de uma paciente jovem, sem cardiopatia estrutural (ecocardiograma normal), apresentando taquicardia de início súbito, ritmo regular e bom estado hemodinâmico, é altamente sugestivo de Taquicardia Paroxística Supraventricular (TPSV), habitualmente mediada por reentrada nodal ou via acessória oculta.

Por que as outras alternativas estão incorretas:
• A) Taquicardias ventriculares são muito menos frequentes em pacientes jovens sem cardiopatia estrutural e geralmente apresentam QRS largo.
• B, D, E) O ritmo está descrito como "regular", o que praticamente exclui a fibrilação atrial (que é irregular). O flutter atrial (2:1 ou 1:1) é menos provável nessa faixa etária sem cardiopatia prévia, e a apresentação clínica é mais característica de uma TPSV comum.'),

('fab09740-8def-4910-b55f-620a00ccb631', 'Taquiarritmia', 2022, 'SBC', 'Paciente do sexo feminino, de 18 anos de idade, com história de três internações em pronto-socorro para reversão de arritmia com medicação endovenosa. Medicada com amiodarona há alguns meses; no momento, assintomática. Teve conhecimento sobre os problemas do uso crônico da amiodarona. Seu exame físico está dentro dos limites da normalidade. Eletrocardiograma a seguir. Qual é o diagnóstico e a conduta adequados?', 'O ECG mostra a tríade clássica de WPW (PR curto + onda delta + repolarização secundária alterada) — a conduta é ablação por radiofrequência, tratamento curativo que evita o uso crônico de antiarrítmicos.', 'O eletrocardiograma apresenta a tríade clássica da Síndrome de Wolff-Parkinson-White (WPW): intervalo PR curto, presença de onda delta (empastamento inicial do QRS) e alterações secundárias da repolarização ventricular. A ablação por radiofrequência da via acessória é o tratamento de escolha para a cura definitiva, evitando o uso crônico de antiarrítmicos (como a amiodarona) em uma paciente jovem.

Por que as outras alternativas estão incorretas:
• B, C, D, E) Não condizem com o diagnóstico eletrocardiográfico e clínico apresentado. A Síndrome de Brugada (D) e a Cardiomiopatia Arritmogênica do VD (C) apresentam padrões eletrocardiográficos distintos e condutas específicas diferentes da ablação de via acessória.'),

('9555d70f-d1be-4830-a644-e4babd34fb21', 'Taquiarritmia', 2013, 'SBC', 'Paciente do sexo masculino, 32 anos, com diagnóstico prévio de síndrome de pré-excitação ventricular, é atendido em serviço de pronto-atendimento com quadro de sudorese, palidez cutâneo-mucosa, hipotensão e taquicardia. O ECG mostrou taquicardia de QRS largo e intervalos R-R irregulares. A conduta correta, neste caso, deve ser:', 'FA pré-excitada (WPW) instável (hipotensão, sudorese, palidez) — a conduta é cardioversão elétrica imediata; fármacos que bloqueiam o nó AV são contraindicados nesse cenário.', 'O paciente apresenta Síndrome de Wolff-Parkinson-White (pré-excitação) com quadro de fibrilação atrial (FA) pré-excitada. O ECG com taquicardia de QRS largo (devido à condução pela via acessória) e intervalos R-R irregulares é o padrão característico. Como o paciente está instável (hipotensão, sudorese, palidez), a cardioversão elétrica imediata é a conduta de escolha para restaurar o ritmo sinusal.

Por que as outras alternativas estão incorretas:
• A, D, E) O uso de fármacos que bloqueiam o nó atrioventricular (betabloqueadores, amiodarona, adenosina ou verapamil/diltiazem) é CONTRAINDICADO na FA pré-excitada, pois podem reduzir a condução pelo nó AV e promover condução preferencial pela via acessória, acelerando a frequência ventricular e podendo degenerar para fibrilação ventricular.
• B) A compressão do seio carotídeo é ineficaz para o tratamento de taquiarritmias ventriculares ou FA pré-excitada e não é a conduta para um paciente instável.'),

('004a1b0c-2465-4616-adc0-78d808eb4337', 'Taquiarritmia', 2016, 'SBC', 'Paciente feminina, 30 anos, tem eletrocardiograma (ECG) com padrão de Wolff-Parkinson-White, nunca tratado por ser assintomática. Chega à emergência com primeira crise de palpitações rápidas e desconforto, mas estável hemodinamicamente. ECG mostra taquicardia supraventricular regular com QRS estreito, FC 200 bpm, compatível com taquicardia ortodrômica atrioventricular. Quais são as melhores condutas na emergência e para evitar novas crises?', 'Para TSV ortodrômica (QRS estreito) estável, a adenosina IV é o fármaco de escolha para reversão aguda; para evitar novas crises em paciente com WPW já sintomático, a ablação por radiofrequência é a conduta definitiva.', 'Para uma taquicardia supraventricular (TSV) com QRS estreito (taquicardia ortodrômica) em paciente estável, a adenosina é o fármaco de escolha para a reversão imediata (quebra da reentrada no nó AV). Como a paciente possui a via acessória (WPW) e já apresentou crise sintomática, a ablação por radiofrequência é a conduta definitiva indicada para prevenir novas recorrências e eliminar o risco de arritmias futuras.

Por que as outras alternativas estão incorretas:
• A) A cardioversão elétrica é reservada para pacientes instáveis hemodinamicamente.
• B e C) O uso de sotalol ou verapamil não é a primeira linha de escolha para a reversão aguda em comparação à eficácia e segurança da adenosina, e a ablação é superior ao tratamento farmacológico contínuo ("VO") para prevenção em pacientes jovens com WPW.
• E) A amiodarona não é o fármaco de primeira escolha para reversão de TSV de QRS estreito e tem perfil de efeitos adversos importante, não sendo a recomendação preferencial.'),

('5ae2029a-c0f7-4a8f-8cde-18d952d61d66', 'Taquiarritmia', 2015, 'SBC', 'Paciente idoso, morador de casa de repouso, é trazido ao serviço de emergência. Ao ser monitorado, foi observado o ritmo abaixo. Assinale a medicação que NÃO predispõe à ocorrência do ritmo acima:', 'O ritmo mostrado é Torsades de Pointes. A espironolactona (diurético poupador de potássio) NÃO prolonga o QT — pelo contrário, ao aumentar o potássio sérico poderia até ter efeito protetor contra arritmias por hipopotassemia.', 'O ritmo apresentado na imagem é uma Torsades de Pointes (taquicardia ventricular polimórfica associada ao prolongamento do intervalo QT). A espironolactona é um diurético poupador de potássio e não causa prolongamento do intervalo QT; pelo contrário, por aumentar o potássio sérico, ela poderia, teoricamente, ter efeito protetor contra arritmias induzidas por hipopotassemia.

Por que as outras alternativas PREDISPÕEM à Torsades de Pointes (não são a resposta pedida):
• B (Amiodarona): É antiarrítmico que prolonga o intervalo QT (Classe III), embora o risco de Torsades com ela seja menor do que com outros fármacos dessa classe.
• C (Clortalidona): É diurético tiazídico que pode causar hipopotassemia e hipomagnesemia, distúrbios eletrolíticos que são fatores de risco potentes para o prolongamento do QT e Torsades de Pointes.
• D (Claritromicina): É antibiótico macrolídeo, conhecido por causar prolongamento do intervalo QT.
• E (Amitriptilina): É antidepressivo tricíclico que, em doses elevadas ou superdosagem, tem efeito estabilizador de membrana e pode prolongar o intervalo QT, predispondo a arritmias ventriculares.'),

('095b02f8-a907-4b46-afe9-c2063045f282', 'Taquiarritmia', 2013, 'SBC', 'Paciente do sexo feminino, 30 anos, foi encaminhada ao cardiologista após episódio de síncope não relacionada ao esforço. O exame físico resultou normal. Não fazia uso de nenhum medicamento. O intervalo QTc medido no ECG de repouso foi 510ms. Com base nos dados descritos e nos critérios atualmente aceitos para diagnóstico da síndrome do QT longo (SQTL), a paciente em questão possui:', 'Pelo Escore de Schwartz, QTc ≥480ms já pontua 3 pontos, e síncope não relacionada ao esforço soma mais pontos — com pontuação total ≥4, a paciente tem ALTA probabilidade de SQTL.', 'O diagnóstico clínico da Síndrome do QT Longo (SQTL) é realizado através do Escore de Schwartz. Este escore pontua achados eletrocardiográficos (como o valor do QTc), história clínica (síncope, parada cardíaca) e história familiar. Um intervalo QTc ≥ 480 ms (em repouso) isoladamente já pontua 3 pontos; história de síncope não relacionada ao esforço pontua 1 a 2 pontos (dependendo da interpretação do contexto). Com uma pontuação de 4 pontos ou mais, a probabilidade de SQTL é considerada alta. Portanto, uma paciente de 30 anos com QTc de 510 ms e história de síncope preenche critérios para alta probabilidade diagnóstica.

Por que as outras alternativas estão incorretas:
• B e C) Subestimam a gravidade e os critérios diagnósticos presentes no caso.
• D) Embora o teste genético confirme o diagnóstico, a SQTL é síndrome com diagnóstico clínico estabelecido pelo Escore de Schwartz, não dependendo exclusivamente da genética.
• E) A presença de Torsades de Pointes é manifestação arrítmica da síndrome, mas não é pré-requisito obrigatório para o diagnóstico; o prolongamento do QT e a história clínica são suficientes para a estratificação.'),

('c5b24dba-b0da-4627-90a6-3b262e6b2fbd', 'Taquiarritmia', 2013, 'SBC', 'Após mudar de cidade, um paciente procurou um cardiologista para seguir acompanhando seu caso. Havia uma história de taquiarritmia não especificada e o paciente fazia uso de sotalol 160 mg/dia. Após analisar os exames complementares, realizar o exame físico e observar o ECG do paciente, o médico decidiu descontinuar o uso do sotalol, por ter identificado uma CONTRAINDICAÇÃO ao seu uso, qual seja:', 'O sotalol prolonga a repolarização ventricular (aumenta o QT); quando o QT já está muito prolongado (>500ms), seu uso é contraindicado pelo risco de Torsades de Pointes.', 'O sotalol é antiarrítmico da Classe III que possui como efeito farmacológico principal o prolongamento da repolarização ventricular, o que se traduz no aumento do intervalo QT no eletrocardiograma. Quando o intervalo QT já se encontra muito prolongado (geralmente considerado > 500 ms), o uso de sotalol torna-se contraindicado devido ao risco elevado de arritmias ventriculares graves, especificamente a Torsades de Pointes.

Por que as outras alternativas não representam contraindicação absoluta:
• A) Hiperuricemia não é contraindicação para o uso de sotalol.
• C) O sotalol não possui metabolismo hepático significativo (é eliminado predominantemente pelos rins), portanto, não é contraindicado por alteração de enzimas hepáticas.
• D) O sotalol pode ser utilizado em pacientes com disfunção ventricular, embora exija cautela devido ao seu efeito betabloqueador (inotrópico negativo).
• E) O desvio do eixo elétrico não interfere na segurança ou na indicação do uso de sotalol.'),

('1e78551e-902d-4f7d-94ee-ef337ad1ba0e', 'Taquiarritmia', 2025, 'SBC', 'Paciente de 28 anos, assintomático, comparece para avaliação pré-operatória de colecistectomia após alteração encontrada em ausculta cardíaca, sem histórico familiar significativo. Realiza o eletrocardiograma (ECG) abaixo. Ecocardiograma sem alterações significativas. Ao teste ergométrico há resolução do achado descrito no ECG durante o esforço. Holter de 24h com 35% de extrassístoles ventriculares monomórficas. Sobre o caso, é INCORRETO afirmar:', 'O paciente é jovem, assintomático, ecocardiograma normal e a arritmia desaparece com o esforço (achado de benignidade) — NÃO há justificativa para suspender a cirurgia eletiva para investigar isquemia apenas pela presença de extrassístoles monomórficas — por isso essa é a alternativa incorreta.', 'O paciente é jovem, assintomático, tem ecocardiograma normal e a arritmia desaparece com o esforço (fator que sugere benignidade). Não há justificativa para suspender uma cirurgia eletiva ou realizar investigação invasiva de isquemia miocárdica (como cineangiocoronariografia) apenas pela presença de extrassístoles ventriculares monomórficas em paciente sem outros sinais de cardiopatia.

Por que as outras alternativas são afirmações CORRETAS sobre o caso (não são a resposta pedida):
• A) Em pacientes assintomáticos com extrassístoles monomórficas sem evidência de disfunção ventricular ou cardiopatia estrutural, a ablação NÃO é mandatória.
• C) A morfologia típica de extrassístoles com bloqueio de ramo esquerdo (BRE) e eixo inferior é característica clássica de focos na via de saída do ventrículo direito, frequentemente idiopáticos e benignos.
• D) Uma carga de extrassístoles muito elevada (como 35% no Holter) pode, ao longo do tempo, levar a taquicardiomiopatia, sendo necessário acompanhamento para monitorar a função do ventrículo esquerdo.
• E) O uso de amiodarona é geralmente evitado em pacientes jovens com arritmias idiopáticas benignas devido ao seu perfil de efeitos colaterais sistêmicos a longo prazo, sendo preferível betabloqueadores ou a ablação (se indicada) em casos sintomáticos.'),

('a77a382c-901c-48bc-8daf-df901dcc7046', 'Taquiarritmia', 2023, 'SBC', 'Homem, 21 anos, apresenta taquicardia de início súbito, evoluindo com episódio de síncope de curta duração, sendo levado à emergência. Admitido com pressão arterial = 80 x 40 mmHg, frequência cardíaca = 240 bpm e saturação de O2 = 98% em ar ambiente. Qual alternativa representa o diagnóstico e a conduta correta:', 'Taquicardia de complexo largo, irregular, FC muito elevada (240bpm) + instabilidade = fibrilação atrial pré-excitada (WPW); a conduta é cardioversão elétrica imediata.', 'O paciente apresenta um quadro de fibrilação atrial pré-excitada (em portador de síndrome de Wolff-Parkinson-White). O traçado mostra uma taquicardia de complexo largo, com frequência cardíaca muito elevada (240 bpm) e irregularidade dos intervalos R-R. A instabilidade hemodinâmica (PA 80 x 40 mmHg) indica a necessidade de cardioversão elétrica imediata.

Por que as outras alternativas estão incorretas:
• A, B, C) O traçado e a apresentação clínica não são típicos de taquicardia ventricular monomórfica ou Torsades de Pointes (que exigiria prolongamento do intervalo QT prévio e morfologia específica).
• E) Embora a fibrilação atrial com aberrância possa apresentar complexo largo, a irregularidade marcada e a alta frequência em paciente jovem com instabilidade hemodinâmica sugerem fortemente a via acessória (WPW) como mecanismo, tornando a FA pré-excitada o diagnóstico mais provável e a cardioversão elétrica a conduta mandatória.'),

('8e5b0f4c-1108-42b6-be50-f50b03b61fc4', 'Taquiarritmia', 2019, 'SBC', 'Mulher, 33 anos, com história de palpitação há 5 anos e sensação de batimento em fúrcula esternal. Vinha em uso de propranolol e atualmente de propafenona. Coração estruturalmente normal. Procurou o setor de emergência com queixa de taquicardia. Na admissão, apresentava-se lúcida, taquicárdica e com pressão arterial (PA) = 110 x 70 mmHg. O eletrocardiograma (ECG) de admissão encontra-se apresentado nesta imagem. Qual o diagnóstico eletrocardiográfico e provável mecanismo da taquicardia?', 'TPSV com aberrância, provável mecanismo de taquicardia relacionada à síndrome de Wolff-Parkinson-White (via acessória), em paciente já refratária a propranolol e propafenona.', 'O quadro (palpitações crônicas com sensação em fúrcula esternal, refratariedade a propranolol e propafenona, coração estruturalmente normal) e o ECG de admissão são compatíveis com taquicardia paroxística supraventricular com aberrância, cujo provável mecanismo é uma taquicardia relacionada à síndrome de Wolff-Parkinson-White (condução por via acessória).'),

('80d7ff8b-74e8-44b4-87f3-5679ca2b2a0d', 'Taquiarritmia', 2023, 'SBC', 'Sobre a taquicardia e o QRS alargado, marque a afirmativa cujo critério de Brugada indique TV (taquiarritmia ventricular):', 'Um dos critérios de Brugada positivos para TV é a presença de intervalo RS > 100 ms (do início do R ao nadir do S) em qualquer derivação precordial.', 'O critério de Brugada é um algoritmo utilizado para diferenciar taquicardia ventricular (TV) de taquicardia supraventricular (TSV) com aberrância em casos de taquicardia de QRS largo. Um dos critérios positivos para TV é a presença de um intervalo RS > 100 ms (medido do início da onda R até o nadir da onda S) em pelo menos uma das derivações precordiais (V1 a V6).

Por que as outras alternativas estão incorretas (em relação ao critério de Brugada para TV):
• A) A AUSÊNCIA de complexos RS em todas as derivações precordiais (concordância negativa) é critério a favor de TV. A PRESENÇA de RS em todas as derivações é, na verdade, critério que favorece TSV.
• C) A PRESENÇA de dissociação AV é critério a favor de TV. A ausência de dissociação não ajuda a diagnosticar TV.
• D) A presença de RSR'' em V1 (padrão de bloqueio de ramo direito) é mais característica de TSV com aberrância. Na TV, o padrão em V1 costuma ser R monofásica, qR ou Rs.
• E) O padrão R pura em V6 (concordância positiva) é critério a favor de TV, mas o padrão específico "R pura em meseta" com entalhes descrito quando há BRE é diagnóstico diferencial mais refinado (critérios de Vereckei), não sendo a descrição clássica do critério de Brugada.'),

('207052d5-edc3-48ef-a44d-d6b9d102411a', 'Taquiarritmia', 2023, 'SBC', 'Paciente com 55 anos de idade e infarto agudo do miocárdio prévio, com taquicardia com QRS de 200 ms, regular, frequência cardíaca = 170 bpm. Apesar de ter apresentado síncope, no momento se encontra consciente, com dor torácica escore 4/10, estertores bilateralmente em bases; pressão arterial = 80 x 40 mmHg. Qual a melhor conduta?', 'QRS muito largo (200ms) + instabilidade hemodinâmica (PA 80x40, estertores) — a conduta é cardioversão elétrica sincronizada imediata, independentemente do mecanismo exato da arritmia.', 'O paciente apresenta um quadro de taquicardia de complexo largo (QRS = 200 ms) com sinais claros de instabilidade hemodinâmica (hipotensão arterial: PA = 80 x 40 mmHg) e congestão pulmonar (estertores). Nestes casos, independentemente do mecanismo preciso da arritmia, a conduta de escolha preconizada pelas diretrizes de suporte avançado de vida é a cardioversão elétrica sincronizada imediata.

Por que as outras alternativas estão incorretas:
• A) A amiodarona é opção para taquicardias ventriculares ESTÁVEIS, mas não é a primeira escolha em paciente instável.
• B e E) A adenosina e o metoprolol (betabloqueador) são fármacos que bloqueiam o nó atrioventricular e são CONTRAINDICADOS em taquicardias ventriculares ou quadros instáveis, podendo piorar a perfusão.
• D) Bloqueadores de canais de cálcio (como verapamil) também são contraindicados em taquicardias de QRS largo com suspeita de origem ventricular, especialmente com instabilidade hemodinâmica.'),

('407ede6b-ebc0-4ec5-afc2-95e12363e97f', 'Taquiarritmia', 2019, 'SBC', 'Dentre as alternativas, qual apresenta arritmias que podem ser interrompidas com adenosina?', 'A adenosina bloqueia temporariamente a condução pelo nó AV, sendo eficaz para interromper arritmias que dependem do nó AV para o circuito de reentrada: taquicardia por reentrada nodal e taquicardia por reentrada atrioventricular (AV).', 'A adenosina atua bloqueando temporariamente a condução através do nó atrioventricular (AV). Por isso, é altamente eficaz na interrupção de taquicardias que dependem do nó AV para manter o circuito de reentrada, especificamente a taquicardia por reentrada nodal e a taquicardia por reentrada atrioventricular (AV).

Por que as outras alternativas estão incorretas:
• A, C, D, E) O flutter atrial, a fibrilação atrial e as taquicardias ventriculares NÃO são interrompidos pela adenosina. No caso do flutter e da FA, a adenosina pode apenas reduzir temporariamente a frequência ventricular devido ao bloqueio no nó AV, mas não encerra a arritmia atrial em si. A taquicardia ventricular, via de regra, não responde à adenosina (exceto casos raros de TV idiopática sensível a verapamil/adenosina, mas não é a resposta padrão para a questão).'),

('36c4e526-d9f0-4895-86fe-431598d1cb0f', 'Taquiarritmia', 2016, 'SBC', 'Paciente de 60 anos foi admitido na emergência com quadro de taquicardia regular de QRS largo e frequência cardíaca de 164 bpm. Assinale a opção que indica o diagnóstico de taquicardia ventricular:', 'A dissociação atrioventricular é um dos critérios mais específicos e diagnósticos de TV — ocorre quando os ventrículos são ativados pelo foco ectópico ventricular enquanto os átrios continuam ativados pelo nó sinusal de forma independente.', 'A dissociação atrioventricular (AV) é um dos critérios mais específicos e diagnósticos de taquicardia ventricular (TV). Ela ocorre quando os ventrículos são ativados pelo foco ectópico ventricular, enquanto os átrios continuam a ser ativados pelo nó sinusal de forma independente, resultando em frequência atrial diferente da frequência ventricular.

Por que as outras alternativas estão incorretas:
• A) A ausência de RS (concordância negativa) em todas as derivações precordiais é critério a favor de TV. A presença de complexos RS em todas as derivações (V2-V6) sugere fortemente TSV com aberrância.
• B) O padrão RSR'' em V1 com QRS largo é o padrão clássico de bloqueio de ramo direito, típico de TSV com aberrância.
• C) Um intervalo RS (do início do R ao nadir do S) superior a 100 ms em pelo menos uma derivação precordial é critério de Brugada POSITIVO para TV. Menor que 100 ms favorece TSV.
• E) Um padrão R/S em V6 maior que 1 indica complexo predominantemente positivo em V6, o que é critério favorável a TSV. Na TV, o complexo em V6 geralmente é predominantemente negativo (relação R/S < 1).'),

('85f05fdb-852e-450a-9513-b20d2a500f34', 'Taquiarritmia', 2025, 'SBC', 'Sobre o dispositivo presente na imagem abaixo, é INCORRETO afirmar:', 'O CDI subcutâneo NÃO deve ser evitado em portadores de canalopatias — pelo contrário, é excelente opção para pacientes jovens/canalopatas (QT longo, Brugada), pois evita eletrodos intravasculares — por isso essa é a alternativa incorreta.', 'A afirmação de que o CDI subcutâneo (CDI-S) deve ser evitado em portadores de canalopatias está incorreta. O CDI-S é, na verdade, uma excelente opção para pacientes jovens ou com canalopatias (como Síndrome do QT Longo, Síndrome de Brugada, etc.), pois evita a necessidade de eletrodos intravasculares, preservando o acesso venoso e reduzindo o risco de complicações relacionadas aos eletrodos a longo prazo.

Por que as outras alternativas são afirmações CORRETAS (não são a resposta pedida):
• A) O CDI-S não possui função de ressincronização cardíaca (TRC). Se o paciente tiver indicação de TRC, o sistema transvenoso é o indicado.
• B) O CDI-S não tem capacidade de estimulação antibradicárdica (marcapasso). Se o paciente necessitar de suporte para bradicardia, não deve ser usado como dispositivo único.
• C) Por não possuir eletrodos dentro do coração, o CDI-S é alternativa viável para pacientes com infecções sistêmicas ou endocardite relacionadas a dispositivos transvenosos prévios.
• D) O CDI-S é indicado para prevenção de morte súbita tanto em prevenção primária quanto secundária.'),

('98f94b41-2441-4dc5-bf01-0c62f615f3d2', 'Taquiarritmia', 2015, 'SBC', 'Quanto ao comportamento dos betabloqueadores, assinale a alternativa ERRADA:', 'O propranolol é betabloqueador NÃO seletivo (não cardiosseletivo) — os cardiosseletivos clássicos são metoprolol, atenolol, bisoprolol e nebivolol — por isso essa é a alternativa errada.', 'Esta alternativa está errada porque o propranolol é um betabloqueador não seletivo, e não cardiosseletivo. Os betabloqueadores cardiosseletivos (ou seletivos β1) mais comuns incluem o metoprolol, o atenolol, o bisoprolol e o nebivolol.

Por que as outras alternativas estão corretas (não são a resposta, já que a pergunta pede a errada):
• A) A seletividade β1 é relativa; com o aumento da dose, o fármaco perde a seletividade e passa a bloquear também os receptores β2.
• B) Betabloqueadores não seletivos (como propranolol e carvedilol) bloqueiam tanto receptores β1 quanto β2 desde o início.
• D) O carvedilol possui ação bloqueadora α1-adrenérgica periférica, resultando em vasodilatação.
• E) O mecanismo anti-hipertensivo dos betabloqueadores baseia-se na redução do débito cardíaco (por cronotropismo e inotropismo negativos) e na inibição da secreção de renina pelos rins, ambos mediados pela sinalização β1.'),

('2c2cd32c-e032-469e-abb0-2f8303e89637', 'Taquiarritmia', 2016, 'SBC', 'Um jogador de futebol com 30 anos de idade apresentava eletrocardiograma de repouso com pré-excitação ventricular e presença de onda delta. Certo dia, após um jogo competitivo, foi admitido na emergência com quadro de palpitações taquicárdicas, sendo feito diagnóstico de fibrilação atrial. Realizou estudo eletrofisiológico que evidenciou o período refratário da via anômala < 50 ms. A melhor estratégia de tratamento da arritmia é:', 'Período refratário da via anômala extremamente curto (<50ms, sinal de altíssimo risco de condução rápida para os ventrículos e morte súbita) — a estratégia definitiva e curativa é a ablação por cateter da via anômala.', 'Em pacientes com Síndrome de Wolff-Parkinson-White (WPW) que apresentam fibrilação atrial, a presença de um período refratário da via acessória muito curto (< 250 ms, e neste caso < 50 ms, extremamente curto e de alto risco) indica risco elevado de condução rápida para os ventrículos, podendo levar a fibrilação ventricular e morte súbita. A ablação por cateter da via anômala é a estratégia terapêutica definitiva e curativa, recomendada como primeira linha nesses casos de alto risco, para eliminar o substrato da arritmia.

Por que fármacos NÃO são a resposta correta neste cenário:
Amiodarona, sotalol, digoxina e bloqueadores de canais de cálcio (verapamil) são CONTRAINDICADOS no tratamento agudo de fibrilação atrial em pacientes com via acessória (pré-excitação), pois podem facilitar a condução através da via anômala, acelerando ainda mais a frequência ventricular e aumentando o risco de degeneração para fibrilação ventricular. (Nota: no documento fonte, esta questão apresentava apenas a alternativa "A - Ablação por cateter" formatada, sem o texto completo das demais 4 alternativas; o conteúdo das alternativas B a E foi reconstruído a partir da própria explicação do documento, que cita nominalmente cada fármaco contraindicado nessa ordem — amiodarona, sotalol, digoxina e verapamil. Se você tiver a formatação exata dessas alternativas no Google Doc original, me avise para eu ajustar o texto literal.)'),

('9bbc58b3-a2ff-4054-9285-a27f727ca4bd', 'Taquiarritmia', 2024, 'SBC', 'Sobre a arritmia presente no eletrocardiograma abaixo, assinale a alternativa INCORRETA:', 'O traçado é de fibrilação atrial pré-excitada (WPW), não fibrilação ventricular verdadeira — por isso essa é a alternativa incorreta; a conduta correta é cardioversão elétrica, não o algoritmo padrão de ACLS para FV.', 'A alternativa afirma que o traçado mostra uma "fibrilação ventricular" (FV). No entanto, o contexto clínico e o traçado de uma arritmia de complexo largo em um paciente com via acessória (WPW) é de uma fibrilação atrial pré-excitada. Embora a gravidade seja extrema e exija ação imediata, o termo técnico correto para a arritmia de base é fibrilação atrial, e não FV. A conduta de escolha é a cardioversão elétrica imediata, não o algoritmo padrão de parada cardiorrespiratória (ACLS) como se fosse uma FV isolada.

Por que as outras alternativas são CORRETAS (não são a resposta, já que a pergunta pede a incorreta):
• A) O menor intervalo RR durante a FA é, de fato, o marcador clínico de maior risco para degeneração em fibrilação ventricular em pacientes com WPW.
• C) A ablação por cateter da via acessória elimina o substrato da arritmia, sendo o tratamento definitivo.
• D) Devido ao risco de instabilidade, a cardioversão é a estratégia de primeira linha na emergência.
• E) A FA pré-excitada é uma emergência médica que, mesmo em corações sadios, pode levar a óbito por condução anômala rápida para os ventrículos.'),

('d4e074c0-14e3-40df-9baa-8dedea41f7e4', 'Taquiarritmia', 2024, 'SBC', 'Paciente do sexo feminino, 74 anos, portadora de hipertensão arterial sistêmica, diabetes melito tipo 2 e histórico de fibrilação atrial paroxística. Em uso regular de losartana, anlodipino, metformina e propafenona há 1 ano, mantendo ritmo sinusal e com exames de controle adequados. Procurou atendimento com queixa de palpitações na última semana. Admitida hemodinamicamente estável com eletrocardiograma abaixo. Sobre o caso, é correto afirmar:', 'O ECG mostra flutter atrial (mesmo substrato fisiopatológico da FA) em paciente com histórico de FA paroxística — há indicação de ablação por cateter em momento oportuno, se for do desejo da paciente.', 'A paciente apresenta histórico de fibrilação atrial (FA) paroxística e o ECG mostra um flutter atrial (padrão em "dente de serra" nas derivações inferiores). O flutter atrial compartilha o mesmo substrato fisiopatológico da FA, e a ablação por cateter é terapia eficaz e recomendada, especialmente em pacientes que já apresentam recorrência de arritmias atriais, para melhorar a qualidade de vida e reduzir a dependência de fármacos antiarrítmicos.

Por que as outras alternativas estão incorretas:
• A) Embora a cardioversão elétrica seja uma opção, não é necessariamente o "tratamento de escolha" único para todos os casos de flutter atrial estável. O controle da frequência ventricular ou a própria ablação podem ser estratégias preferenciais dependendo do contexto.
• B) A decisão de anticoagulação em pacientes com FA/flutter atrial não depende apenas de estar em ritmo sinusal; é guiada pelo risco embólico (escore CHA2DS2-VASc). Aos 74 anos, com hipertensão e diabetes, a paciente possui indicação clara de terapia antitrombótica, independentemente do ritmo.
• C) A carga de 50 Joules é geralmente BAIXA para a reversão de flutter atrial por cardioversão elétrica sincronizada; doses mais elevadas (frequentemente iniciando com 100-200 Joules) são mais eficazes.
• E) Embora o ecocardiograma transesofágico (ETE) possa descartar trombos e permitir cardioversão imediata, ele NÃO dispensa a necessidade de anticoagulação após o procedimento, pois o risco embólico persiste pelo risco de recorrência da arritmia e pela disfunção atrial pós-choque.'),

('9701deae-d4d3-43c3-9ab1-5d36a0432662', 'Taquiarritmia', 2013, 'SBC', 'Paciente do sexo masculino, 55 anos, com cardiomiopatia dilatada, é admitido na emergência com quadro de palpitações. Faz uso de carvedilol 12,5 mg 12/12 h, enalapril 10 mg 12/12 h e espironolactona 25 mg 1 X /dia. Ao exame físico, observa-se que o paciente se encontra taquicárdico, taquipneico PA = 90 X 60 mmHg. Ritmo cardíaco regular. Ausculta pulmonar com crepitações bibasais. ECG revela taquicardia ventricular sustentada. Realizada cardioversão elétrica com sucesso para reversão ao ritmo sinusal. Diante deste quadro clínico, a melhor conduta a ser tomada deve ser o(a):', 'Cardiopatia estrutural (dilatada) + TV sustentada com instabilidade — indicação formal de implante de CDI para prevenção SECUNDÁRIA de morte súbita.', 'O paciente apresenta cardiomiopatia dilatada e um episódio de taquicardia ventricular (TV) sustentada com instabilidade hemodinâmica (hipotensão e sinais de insuficiência cardíaca/congestão). De acordo com as diretrizes de cardiologia, pacientes com cardiopatia estrutural e TV sustentada têm indicação formal de implante de CDI para prevenção secundária de morte súbita.

Por que as outras alternativas estão incorretas:
• A e B) Embora o tratamento clínico otimizado da insuficiência cardíaca seja fundamental, ele não previne o risco de morte súbita arrítmica neste paciente após um evento grave como uma TV sustentada.
• D) A propafenona é antiarrítmico da classe IC, CONTRAINDICADO em pacientes com cardiopatia estrutural (como a cardiomiopatia dilatada deste paciente) pelo alto risco de pró-arritmia e aumento da mortalidade.
• E) A troca de betabloqueador por sotalol não substitui a indicação de CDI em prevenção secundária para este perfil de paciente.'),

('147da0f8-1518-444b-acb6-923759eac2a3', 'Taquiarritmia', 2025, 'SBC', 'Paciente com episódio de taquicardia seguida de síncope encaminhado à emergência. Eletrocardiograma abaixo. Submetido à cardioversão elétrica com retorno ao ritmo sinusal. Assinale a alternativa correta:', 'Trata-se de FA pré-excitada (WPW); o tratamento definitivo é a ablação por cateter da via acessória.', 'Trata-se de fibrilação atrial pré-excitada (síndrome de Wolff-Parkinson-White). O tratamento definitivo é a ablação por cateter da via acessória.'),

('08868501-e853-46b1-9ef6-bfa5c58757fb', 'Taquiarritmia', 2017, 'SBC', 'Quanto à taquicardia por reentrada nodal atrioventricular, podemos AFIRMAR que:', 'A TRNAV é a forma mais comum de TSV paroxística em corações estruturalmente normais — sem substrato de cardiopatia grave, o prognóstico é excelente, com a ablação sendo opção curativa altamente eficaz.', 'A taquicardia por reentrada nodal atrioventricular (TRNAV) é a forma mais comum de taquicardia supraventricular paroxística em indivíduos com corações estruturalmente normais. Como não envolve substratos de cardiopatia grave, o prognóstico é considerado excelente, sendo a ablação por cateter uma opção curativa altamente eficaz.

Por que as outras alternativas estão incorretas:
• A) A TRNAV é causa frequente de palpitações e PODE, sim, causar síncope ou pré-síncope, especialmente se a frequência ventricular for muito elevada ou houver hipotensão associada.
• B) A arritmia é FREQUENTEMENTE sintomática, apresentando-se classicamente com palpitações de início e término súbito, podendo vir acompanhada de tontura e desconforto cervical.
• C) Por ser uma taquicardia, ela ENCURTA o tempo de enchimento diastólico, o que pode REDUZIR o débito cardíaco, sendo essa a causa dos sintomas hemodinâmicos.
• D) A TRNAV é mais comum em adultos jovens e de meia-idade, com prevalência notavelmente maior em MULHERES (não a partir da sexta década).'),

('15434b78-6311-45fc-9e1e-4accfcc78148', 'Taquiarritmia', 2025, 'SBC', 'Assinale a alternativa correta em relação aos efeitos adversos da amiodarona:', 'A amiodarona contém iodo em sua molécula e pode causar tanto hipotireoidismo (mais comum) quanto hipertireoidismo.', 'A amiodarona contém iodo em sua molécula e pode interferir na função tireoidiana, causando tanto hipotireoidismo (mais comum) quanto hipertireoidismo (tireotoxicose por amiodarona).

Por que as outras alternativas estão incorretas:
• B) Os depósitos corneanos (microdepósitos de lipofuscina) são extremamente comuns (quase universais com uso prolongado), mas RARAMENTE causam sintomas visuais e NÃO obrigam a suspensão do tratamento.
• C) A amiodarona FREQUENTEMENTE causa alterações cutâneas, como fotossensibilidade e coloração azul-acinzentada da pele em áreas expostas ao sol.
• D) Embora a amiodarona prolongue o intervalo QTc, ela possui risco de Torsades de Pointes MUITO BAIXO em comparação com outros antiarrítmicos da classe III (como o sotalol), devido aos seus efeitos bloqueadores de múltiplos canais iônicos.
• E) O uso de amiodarona na gestação deve ser EVITADO ao máximo (geralmente categoria D, pelos riscos de bócio e disfunção tireoidiana no feto/recém-nascido), sendo reservada apenas para arritmias refratárias com risco de vida para a mãe.'),

('2c48aad8-365a-44a9-8f54-108328222b4b', 'Taquiarritmia', 2024, 'SBC', 'Sobre os bloqueios atrioventriculares e intraventriculares é correto afirmar:', 'O bloqueio de ramo alternante (alternância entre BRD e BRE, ou bloqueios fasciculares) é marcador de doença infra-hisiana grave e progressiva — a recomendação é implante de marcapasso definitivo mesmo em pacientes ASSINTOMÁTICOS, pelo alto risco de progressão súbita para BAVT.', 'O bloqueio de ramo alternante (alternância entre bloqueio de ramo direito e esquerdo, ou bloqueios fasciculares) é um marcador clínico de doença infra-hisiana grave e progressiva. Devido ao risco elevado de progressão súbita para bloqueio atrioventricular total (BAVT), a recomendação é o implante de marcapasso definitivo, mesmo em pacientes assintomáticos.

Por que as outras alternativas estão incorretas:
• A) Embora os bloqueios de 1º grau e 2º grau Mobitz I sejam comuns e geralmente benignos em atletas (tônus vagal), a alternativa erra ao sugerir que a atividade física deva ser suspensa de forma ROTINEIRA antes de qualquer avaliação — o manejo prioriza excluir cardiopatia antes de qualquer interrupção.
• C) O BAVT congênito exige monitoramento cuidadoso de múltiplos fatores (FC, sintomas, QRS, função ventricular), não sendo escolha "independente" de critérios clínicos.
• D) O intervalo HV é parâmetro eletrofisiológico importante, mas o corte de 50 ms é NORMAL, não servindo como indicação isolada de marcapasso.
• E) Embora raro, o BAV de 1º grau extremo (PR muito longo) pode, em casos específicos com sintomas de dissincronia AV (síndrome tipo marcapasso), ter indicação de implante.'),

('d4d346a5-bf6c-42af-9dbb-5486725ee33a', 'Taquiarritmia', 2025, 'SBC', 'Sobre o tratamento da síndrome de Wolff-Parkinson-White, assinale a afirmativa correta:', 'Em crianças, especialmente nos primeiros anos de vida, pode haver desaparecimento espontâneo da via acessória (degeneração/fibrose), com resolução da pré-excitação em número significativo de casos.', 'Em crianças, especialmente nos primeiros anos de vida, é documentado que a via acessória pode sofrer um processo de degeneração ou fibrose, resultando no desaparecimento espontâneo da pré-excitação em número significativo de casos.

Por que as outras alternativas estão incorretas:
• A) A ablação por cateter é o tratamento definitivo de escolha e apresenta taxas de sucesso muito elevadas (geralmente >95%) com BAIXA (não alta) taxa de recorrência.
• C) A ablação NÃO é contraindicada para assintomáticos; pelo contrário, em pacientes com achados de alto risco (via acessória com período refratário curto), a ablação é recomendada mesmo em assintomáticos para prevenir morte súbita.
• D) Fibrilação atrial pré-excitada é condição de risco de vida. NÃO deve ser manejada apenas com medicação ambulatorial; a ablação da via acessória é a conduta definitiva indicada para prevenir novos episódios potencialmente fatais.
• E) A amiodarona não é formalmente contraindicada no cenário ambulatorial por essa razão — a afirmação generaliza de forma incorreta.');

insert into public.question_options (id, question_id, letra, texto, correta) values
(gen_random_uuid(), 'f0f907c9-6524-4500-96fb-e3351cabea2c', 'a', 'Taquicardia paroxística supraventricular (TPSV) com aberrância pelo ramo direito. Amiodarona venosa e, caso não reverta, cardioversão elétrica.', false),
(gen_random_uuid(), 'f0f907c9-6524-4500-96fb-e3351cabea2c', 'b', 'Taquicardia ventricular polimórfica. Cardioversão elétrica e revisão laboratorial.', false),
(gen_random_uuid(), 'f0f907c9-6524-4500-96fb-e3351cabea2c', 'c', 'Taquicardia ventricular monomórfica sustentada. Cardioversão elétrica de imediato. Implante de cardioversor desfibrilador implantável (CDI) por profilaxia secundária.', true),
(gen_random_uuid(), 'f0f907c9-6524-4500-96fb-e3351cabea2c', 'd', 'Fibrilação atrial com elevada resposta ventricular. Cardioversão elétrica de imediato. Amiodarona.', false),
(gen_random_uuid(), 'f0f907c9-6524-4500-96fb-e3351cabea2c', 'e', 'Taquicardia ventricular monomórfica sustentada. Amiodarona. Implante de cardioversor desfibrilador implantável (CDI) por profilaxia primária.', false),

(gen_random_uuid(), '8c3a169c-a6c0-4723-874c-39e17dde854d', 'a', 'Fibrilação ventricular idiopática.', false),
(gen_random_uuid(), '8c3a169c-a6c0-4723-874c-39e17dde854d', 'b', 'Síndrome de Brugada.', false),
(gen_random_uuid(), '8c3a169c-a6c0-4723-874c-39e17dde854d', 'c', 'Taquicardia ventricular polimórfica catecolaminérgica.', false),
(gen_random_uuid(), '8c3a169c-a6c0-4723-874c-39e17dde854d', 'd', 'Síndrome do QT longo tipo 2.', true),
(gen_random_uuid(), '8c3a169c-a6c0-4723-874c-39e17dde854d', 'e', 'Displasia arritmogênica do ventrículo direito.', false),

(gen_random_uuid(), '41304e7d-35e4-4acc-9cb0-3bc81cb044df', 'a', 'A principal hipótese seria taquicardia por reentrada nodal, por ser o mecanismo de taquicardia supraventricular com o RR regular mais frequente na prática clínica.', false),
(gen_random_uuid(), '41304e7d-35e4-4acc-9cb0-3bc81cb044df', 'b', 'A presença de bloqueio de ramo esquerdo sugere que o mecanismo possa ser uma taquicardia supraventricular mediada por uma via acessória tipo Mahaim.', false),
(gen_random_uuid(), '41304e7d-35e4-4acc-9cb0-3bc81cb044df', 'c', 'A principal hipótese seria taquicardia supraventricular mediada por uma via acessória, pela observação de pré-excitação manifesta ao ECG.', true),
(gen_random_uuid(), '41304e7d-35e4-4acc-9cb0-3bc81cb044df', 'd', 'A principal hipótese é fibrilação atrial, por ser a taquiarritmia mais frequente no cenário clínico.', false),
(gen_random_uuid(), '41304e7d-35e4-4acc-9cb0-3bc81cb044df', 'e', 'O ECG de repouso isoladamente não permite esclarecer a sintomatologia, sendo necessária complementação com ressonância nuclear magnética cardíaca.', false),

(gen_random_uuid(), '2ba43467-2567-4cda-add5-8a6e5da887e0', 'a', 'cardioversão elétrica sincronizada', true),
(gen_random_uuid(), '2ba43467-2567-4cda-add5-8a6e5da887e0', 'b', 'adenosina por via endovenosa', false),
(gen_random_uuid(), '2ba43467-2567-4cda-add5-8a6e5da887e0', 'c', 'verapamil por via endovenosa', false),
(gen_random_uuid(), '2ba43467-2567-4cda-add5-8a6e5da887e0', 'd', 'ablação por radiofrequência', false),
(gen_random_uuid(), '2ba43467-2567-4cda-add5-8a6e5da887e0', 'e', 'amiodarona por via endovenosa', false),

(gen_random_uuid(), '7b766a6a-a647-425a-9c33-ff7a72f9cf68', 'a', 'taquicardia ventricular monomórfica sustentada e cardioversão elétrica sincronizada', true),
(gen_random_uuid(), '7b766a6a-a647-425a-9c33-ff7a72f9cf68', 'b', 'taquicardia ventricular ramo a ramo e cardioversão elétrica de imediato', false),
(gen_random_uuid(), '7b766a6a-a647-425a-9c33-ff7a72f9cf68', 'c', 'taquicardia antidrômica e cardioversão elétrica de imediato', false),
(gen_random_uuid(), '7b766a6a-a647-425a-9c33-ff7a72f9cf68', 'd', 'taquicardia ventricular monomórfica sustentada e desfibrilação elétrica', false),
(gen_random_uuid(), '7b766a6a-a647-425a-9c33-ff7a72f9cf68', 'e', 'taquicardia com QRS largo e adenosina para definição diagnóstica; posteriormente, cardioversão elétrica sincronizada', false),

(gen_random_uuid(), 'b4c5e8df-a776-4975-8250-e7e98b8dfe21', 'a', 'A forma mais tradicional de taquicardiomiopatia é causada por taquicardia sinusal inapropriada detectada ao Holter de 24 horas.', false),
(gen_random_uuid(), 'b4c5e8df-a776-4975-8250-e7e98b8dfe21', 'b', 'Taquicardia por períodos prolongados pode induzir disfunção ventricular mesmo na ausência de doença estrutural.', true),
(gen_random_uuid(), 'b4c5e8df-a776-4975-8250-e7e98b8dfe21', 'c', 'Contrações ventriculares prematuras persistentes e frequentes não levam à taquicardiomiopatia.', false),
(gen_random_uuid(), 'b4c5e8df-a776-4975-8250-e7e98b8dfe21', 'd', 'Apenas as arritmias supraventriculares com resposta ventricular elevada podem causar taquicardiomiopatia.', false),
(gen_random_uuid(), 'b4c5e8df-a776-4975-8250-e7e98b8dfe21', 'e', 'Na maioria dos casos, independentemente da correção da arritmia, a disfunção ventricular é irreversível.', false),

(gen_random_uuid(), 'b9370780-85a9-41c5-b660-f5620343dac3', 'a', 'Morfologia de bloqueio de ramo esquerdo e eixo elétrico inferior no plano frontal.', true),
(gen_random_uuid(), 'b9370780-85a9-41c5-b660-f5620343dac3', 'b', 'Morfologia de bloqueio de ramo direito e eixo elétrico inferior no plano frontal.', false),
(gen_random_uuid(), 'b9370780-85a9-41c5-b660-f5620343dac3', 'c', 'Morfologia de bloqueio de ramo direito e eixo elétrico desviado à esquerda no plano frontal.', false),
(gen_random_uuid(), 'b9370780-85a9-41c5-b660-f5620343dac3', 'd', 'Morfologia de bloqueio de ramo esquerdo e eixo elétrico desviado à esquerda no plano frontal.', false),
(gen_random_uuid(), 'b9370780-85a9-41c5-b660-f5620343dac3', 'e', 'Morfologia de bloqueio de ramo direito e eixo elétrico desviado à direita no plano frontal.', false),

(gen_random_uuid(), 'e076420d-2172-4307-ae5c-531ecb0f6191', 'a', 'A SBr caracteriza-se por eletrocardiograma com elevação em cúpula do segmento ST (≥ 2 mm), seguidos de onda T negativa nas derivações precordiais direitas V1 a V3.', false),
(gen_random_uuid(), 'e076420d-2172-4307-ae5c-531ecb0f6191', 'b', 'A SBr associa-se a aumento do risco de morte súbita cardíaca secundária a episódios de taquicardia ventricular polimórfica.', false),
(gen_random_uuid(), 'e076420d-2172-4307-ae5c-531ecb0f6191', 'c', 'A SBr não é uma síndrome arrítmica hereditária.', true),
(gen_random_uuid(), 'e076420d-2172-4307-ae5c-531ecb0f6191', 'd', 'A penetrância e a expressividade desse distúrbio são altamente variáveis, desde indivíduos de idades mais avançadas assintomáticos até casos de morte súbita cardíaca no primeiro ano de vida.', false),
(gen_random_uuid(), 'e076420d-2172-4307-ae5c-531ecb0f6191', 'e', 'Vários são os genes implicados na patogenicidade da SBr, mas somente o SCN5A demonstra contribuição significativa para a doença.', false),

(gen_random_uuid(), '1da985f1-f9ab-411b-987a-41adedaebbba', 'a', 'Taquicardia ventricular secundária à Doença de Chagas.', false),
(gen_random_uuid(), '1da985f1-f9ab-411b-987a-41adedaebbba', 'b', 'Taquicardia ventricular fascicular.', true),
(gen_random_uuid(), '1da985f1-f9ab-411b-987a-41adedaebbba', 'c', 'Taquicardia ventricular relacionada com cicatriz de infarto do miocárdio.', false),
(gen_random_uuid(), '1da985f1-f9ab-411b-987a-41adedaebbba', 'd', 'Taquicardia na fase aguda do infarto do miocárdio.', false),
(gen_random_uuid(), '1da985f1-f9ab-411b-987a-41adedaebbba', 'e', 'Taquicardia ventricular secundária à displasia arritmogênica do ventrículo direito (VD).', false),

(gen_random_uuid(), '4cd0ab74-7d9b-4383-a3d5-215860c848d5', 'a', 'Deslocamento de eletrodo ventricular.', false),
(gen_random_uuid(), '4cd0ab74-7d9b-4383-a3d5-215860c848d5', 'b', 'Taquicardia mediada pelo marcapasso.', false),
(gen_random_uuid(), '4cd0ab74-7d9b-4383-a3d5-215860c848d5', 'c', 'Reversão parcial do bloqueio atrioventricular (AV).', false),
(gen_random_uuid(), '4cd0ab74-7d9b-4383-a3d5-215860c848d5', 'd', 'Aumento transitório dos limiares de estimulação.', false),
(gen_random_uuid(), '4cd0ab74-7d9b-4383-a3d5-215860c848d5', 'e', 'Torsades de Pointes.', true),

(gen_random_uuid(), '2839a1d9-97a5-4737-aed7-0896d500c0c3', 'a', 'Presença de batimentos de fusão.', false),
(gen_random_uuid(), '2839a1d9-97a5-4737-aed7-0896d500c0c3', 'b', 'Desvio esquerdo do eixo e concordância positiva dos complexos QRS em derivações precordiais.', false),
(gen_random_uuid(), '2839a1d9-97a5-4737-aed7-0896d500c0c3', 'c', 'Início da taquicardia com onda P prematura.', true),
(gen_random_uuid(), '2839a1d9-97a5-4737-aed7-0896d500c0c3', 'd', 'Primeiro vetor de ativação > 100 milissegundos.', false),
(gen_random_uuid(), '2839a1d9-97a5-4737-aed7-0896d500c0c3', 'e', 'Padrão de bloqueio de ramo direito, com complexo QRS bifásico em V1.', false),

(gen_random_uuid(), 'b6c8ffc6-078d-4419-8fff-5dfc1a89ee04', 'a', 'Taquicardia ventricular fascicular relacionada ao fascículo posteroinferior do ramo esquerdo.', false),
(gen_random_uuid(), 'b6c8ffc6-078d-4419-8fff-5dfc1a89ee04', 'b', 'Taquicardia supraventricular sustentada sugestiva de reentrada atrioventricular (ortodrômica), mediada por via acessória.', false),
(gen_random_uuid(), 'b6c8ffc6-078d-4419-8fff-5dfc1a89ee04', 'c', 'Taquicardia supraventricular sustentada sugestiva de reentrada nodal (dupla via nodal).', true),
(gen_random_uuid(), 'b6c8ffc6-078d-4419-8fff-5dfc1a89ee04', 'd', 'Traçado compatível com flutter atrial típico com elevada resposta ventricular.', false),
(gen_random_uuid(), 'b6c8ffc6-078d-4419-8fff-5dfc1a89ee04', 'e', 'Taquicardia supraventricular sustentada, não sendo possível sugerir seu mecanismo.', false),

(gen_random_uuid(), '60631a55-9a69-4f70-8e80-152dcdff9b9c', 'a', 'Sotalol.', true),
(gen_random_uuid(), '60631a55-9a69-4f70-8e80-152dcdff9b9c', 'b', 'Diltiazem.', false),
(gen_random_uuid(), '60631a55-9a69-4f70-8e80-152dcdff9b9c', 'c', 'Metoprolol.', false),
(gen_random_uuid(), '60631a55-9a69-4f70-8e80-152dcdff9b9c', 'd', 'Propafenona.', false),
(gen_random_uuid(), '60631a55-9a69-4f70-8e80-152dcdff9b9c', 'e', 'Procainamida.', false),

(gen_random_uuid(), 'f682b657-233e-4bdf-a63c-a86e63f7b78b', 'a', 'Prevenção de taquicardias originadas na via de saída do ventrículo direito.', false),
(gen_random_uuid(), 'f682b657-233e-4bdf-a63c-a86e63f7b78b', 'b', 'Portadores de cardiomiopatia hipertrófica pós-parada cardiorrespiratória.', false),
(gen_random_uuid(), 'f682b657-233e-4bdf-a63c-a86e63f7b78b', 'c', 'Portadores de arritmia ventricular relacionada com espasmo de coronária.', false),
(gen_random_uuid(), 'f682b657-233e-4bdf-a63c-a86e63f7b78b', 'd', 'Pacientes com variante de acoplamento curto de taquicardia ventricular polimórfica.', false),
(gen_random_uuid(), 'f682b657-233e-4bdf-a63c-a86e63f7b78b', 'e', 'Pacientes em pós-infarto do miocárdio sem elevação do segmento ST para prevenção de morte súbita e redução de mortalidade.', true),

(gen_random_uuid(), '2a410921-f843-4fa7-a7e3-7605be9ab895', 'a', 'Onda delta e QRS negativos em V1, onda delta e QRS negativos em D2, D3 e aVF.', false),
(gen_random_uuid(), '2a410921-f843-4fa7-a7e3-7605be9ab895', 'b', 'Onda delta e QRS negativos em V1 e eixo para a esquerda.', false),
(gen_random_uuid(), '2a410921-f843-4fa7-a7e3-7605be9ab895', 'c', 'Onda delta e QRS negativos em V1 e eixo inferior.', true),
(gen_random_uuid(), '2a410921-f843-4fa7-a7e3-7605be9ab895', 'd', 'Onda delta e QRS positivos em V1 e onda delta e QRS negativos em D2, D3 e aVF.', false),
(gen_random_uuid(), '2a410921-f843-4fa7-a7e3-7605be9ab895', 'e', 'Onda delta e QRS positivos em V1 e onda delta negativa ou isoelétrica em D1, aVL, V5 e V6.', false),

(gen_random_uuid(), 'ffa6f75b-6dc5-4e9a-8239-197cd761af1f', 'a', 'Está associada com alto risco de morte súbita.', false),
(gen_random_uuid(), 'ffa6f75b-6dc5-4e9a-8239-197cd761af1f', 'b', 'É precedida por alargamento do intervalo QTc.', false),
(gen_random_uuid(), 'ffa6f75b-6dc5-4e9a-8239-197cd761af1f', 'c', 'Ocorre com maior frequência durante o período noturno.', false),
(gen_random_uuid(), 'ffa6f75b-6dc5-4e9a-8239-197cd761af1f', 'd', 'É frequente a sua associação com cardiopatia estrutural.', false),
(gen_random_uuid(), 'ffa6f75b-6dc5-4e9a-8239-197cd761af1f', 'e', 'É sensível ao verapamil intravenoso e raramente à adenosina.', true),

(gen_random_uuid(), 'bd4094d5-f1c5-4cb5-aa62-74533218534a', 'a', 'Insuficiência renal.', false),
(gen_random_uuid(), 'bd4094d5-f1c5-4cb5-aa62-74533218534a', 'b', 'Hipocalemia.', false),
(gen_random_uuid(), 'bd4094d5-f1c5-4cb5-aa62-74533218534a', 'c', 'Associação com amiodarona.', false),
(gen_random_uuid(), 'bd4094d5-f1c5-4cb5-aa62-74533218534a', 'd', 'Associação com atorvastatina.', true),
(gen_random_uuid(), 'bd4094d5-f1c5-4cb5-aa62-74533218534a', 'e', 'Hipomagnesemia.', false),

(gen_random_uuid(), '5abeef5b-ae95-45f1-b9d0-deff2d8baacf', 'a', 'Diagnóstico de taquicardia ventricular catecolaminérgica; indicação de cardioversor-desfibrilador implantável (CDI) para prevenção primária.', false),
(gen_random_uuid(), '5abeef5b-ae95-45f1-b9d0-deff2d8baacf', 'b', 'Diagnóstico de síndrome do QT longo; sem indicação de CDI.', false),
(gen_random_uuid(), '5abeef5b-ae95-45f1-b9d0-deff2d8baacf', 'c', 'Diagnóstico de síndrome do QT longo; indicação de CDI.', true),
(gen_random_uuid(), '5abeef5b-ae95-45f1-b9d0-deff2d8baacf', 'd', 'Diagnóstico de taquicardia ventricular catecolaminérgica; indicação de ablação de extrassístole ventricular.', false),
(gen_random_uuid(), '5abeef5b-ae95-45f1-b9d0-deff2d8baacf', 'e', 'Indicação de ablação de taquicardia ventricular.', false),

(gen_random_uuid(), 'efe552b9-d384-4317-b970-1688cab672c5', 'a', 'Taquicardia ventricular monomórfica sustentada. Amiodarona venosa.', false),
(gen_random_uuid(), 'efe552b9-d384-4317-b970-1688cab672c5', 'b', 'Taquicardia ventricular polimórfica. Cardioversão elétrica sincronizada.', false),
(gen_random_uuid(), 'efe552b9-d384-4317-b970-1688cab672c5', 'c', 'Taquicardia paroxística supraventricular (TPSV) com aberrância pelo ramo esquerdo e posteriormente pelo ramo direito. Adenosina para reversão e indicar ablação por cateter.', true),
(gen_random_uuid(), 'efe552b9-d384-4317-b970-1688cab672c5', 'd', 'Taquicardia ventricular bidirecional. Cardioversão elétrica de imediato.', false),
(gen_random_uuid(), 'efe552b9-d384-4317-b970-1688cab672c5', 'e', 'Fibrilação atrial em portador de síndrome de Wolff-Parkinson-White. Amiodarona venosa.', false),

(gen_random_uuid(), 'cc0aa165-f5e9-4936-9a78-0fd90afcc867', 'a', 'Paciente deve ser submetido ao estudo eletrofisiológico.', false),
(gen_random_uuid(), 'cc0aa165-f5e9-4936-9a78-0fd90afcc867', 'b', 'Paciente deve ser tratado com amiodarona.', false),
(gen_random_uuid(), 'cc0aa165-f5e9-4936-9a78-0fd90afcc867', 'c', 'Paciente deve ser submetido a implante de cardiodesfibrilador.', true),
(gen_random_uuid(), 'cc0aa165-f5e9-4936-9a78-0fd90afcc867', 'd', 'Paciente deve ser submetido à realização de teste de inclinação (Tilt Test).', false),
(gen_random_uuid(), 'cc0aa165-f5e9-4936-9a78-0fd90afcc867', 'e', 'Paciente deve receber monitor de eventos implantável.', false),

(gen_random_uuid(), '071d1ebf-bcef-47f5-a7f5-2e49985433e8', 'a', 'Vasodilatação periférica.', true),
(gen_random_uuid(), '071d1ebf-bcef-47f5-a7f5-2e49985433e8', 'b', 'Início de ação em 15 a 20 minutos.', false),
(gen_random_uuid(), '071d1ebf-bcef-47f5-a7f5-2e49985433e8', 'c', 'Ação agonista no receptor beta-adrenérgico.', false),
(gen_random_uuid(), '071d1ebf-bcef-47f5-a7f5-2e49985433e8', 'd', 'Maior conversão da tiroxina em tri-iodotironina.', false),
(gen_random_uuid(), '071d1ebf-bcef-47f5-a7f5-2e49985433e8', 'e', 'Aumento da força contrátil do ventrículo esquerdo.', false),

(gen_random_uuid(), '1ef9b39c-1796-432a-bbca-64fbbe073ceb', 'a', 'Cardioversão elétrica sincronizada', false),
(gen_random_uuid(), '1ef9b39c-1796-432a-bbca-64fbbe073ceb', 'b', 'Ablação por radiofrequência para interromper o circuito da arritmia', false),
(gen_random_uuid(), '1ef9b39c-1796-432a-bbca-64fbbe073ceb', 'c', 'Manobra vagal e, caso não resolva, adenosina endovenosa', true),
(gen_random_uuid(), '1ef9b39c-1796-432a-bbca-64fbbe073ceb', 'd', 'Manobra vagal e, caso não resolva, betabloqueador endovenoso', false),
(gen_random_uuid(), '1ef9b39c-1796-432a-bbca-64fbbe073ceb', 'e', 'Digital endovenoso', false),

(gen_random_uuid(), '84b74e49-dfd9-4a33-b365-35b8473f3b3b', 'a', 'Adenosina 6 mg venosa.', false),
(gen_random_uuid(), '84b74e49-dfd9-4a33-b365-35b8473f3b3b', 'b', 'Manobra vagal.', true),
(gen_random_uuid(), '84b74e49-dfd9-4a33-b365-35b8473f3b3b', 'c', 'Cardioversão elétrica sincronizada.', false),
(gen_random_uuid(), '84b74e49-dfd9-4a33-b365-35b8473f3b3b', 'd', 'Metoprolol 5 mg venoso.', false),
(gen_random_uuid(), '84b74e49-dfd9-4a33-b365-35b8473f3b3b', 'e', 'Amiodarona venosa.', false),

(gen_random_uuid(), '5cd7ea82-d458-4575-a658-859555c5f6b6', 'a', 'Intervalo RP'' maior que intervalo P''R.', false),
(gen_random_uuid(), '5cd7ea82-d458-4575-a658-859555c5f6b6', 'b', 'Frequência atrial maior que frequência ventricular.', false),
(gen_random_uuid(), '5cd7ea82-d458-4575-a658-859555c5f6b6', 'c', 'Dissociação entre batimentos atriais e ventriculares.', false),
(gen_random_uuid(), '5cd7ea82-d458-4575-a658-859555c5f6b6', 'd', 'Intervalo RP'' inferior a 70 milissegundos.', true),
(gen_random_uuid(), '5cd7ea82-d458-4575-a658-859555c5f6b6', 'e', 'Frequência ventricular maior que frequência atrial.', false),

(gen_random_uuid(), '0db6fb3a-593f-4d62-8c7c-861883a6eb5b', 'a', 'Via acessória anterosseptal direita.', true),
(gen_random_uuid(), '0db6fb3a-593f-4d62-8c7c-861883a6eb5b', 'b', 'Via acessória lateral esquerda.', false),
(gen_random_uuid(), '0db6fb3a-593f-4d62-8c7c-861883a6eb5b', 'c', 'Via acessória posterosseptal direita.', false),
(gen_random_uuid(), '0db6fb3a-593f-4d62-8c7c-861883a6eb5b', 'd', 'Via acessória posterolateral esquerda.', false),
(gen_random_uuid(), '0db6fb3a-593f-4d62-8c7c-861883a6eb5b', 'e', 'Via acessória posterosseptal esquerda.', false),

(gen_random_uuid(), '135c3853-8f89-424d-98a0-d55ccc883f90', 'a', 'Síndrome do QT longo congênito. Indicado implante de CDI (cardioversor-desfibrilador implantável).', false),
(gen_random_uuid(), '135c3853-8f89-424d-98a0-d55ccc883f90', 'b', 'Atraso de condução pelo ramo direito. Indicado looper implantável para elucidação diagnóstica da síncope.', false),
(gen_random_uuid(), '135c3853-8f89-424d-98a0-d55ccc883f90', 'c', 'Síndrome de Brugada. Indicado implante de CDI.', true),
(gen_random_uuid(), '135c3853-8f89-424d-98a0-d55ccc883f90', 'd', 'Bloqueio de ramo direito. Indicado estudo eletrofisiológico para elucidação diagnóstica da síncope.', false),
(gen_random_uuid(), '135c3853-8f89-424d-98a0-d55ccc883f90', 'e', 'Displasia arritmogênica do ventrículo direito. Indicado implante de CDI.', false),

(gen_random_uuid(), '58ad1ce9-087f-4e43-967a-b7f78541c2a5', 'a', 'Taquicardia ventricular monomórfica sustentada. Indicar implante de cardioversor-desfibrilador ressincronizador.', false),
(gen_random_uuid(), '58ad1ce9-087f-4e43-967a-b7f78541c2a5', 'b', 'Taquicardia supraventricular com aberrância. Iniciar amiodarona e, após impregnação, acompanhamento ambulatorial com Holter de 24 horas seriado.', false),
(gen_random_uuid(), '58ad1ce9-087f-4e43-967a-b7f78541c2a5', 'c', 'Taquicardia ventricular monomórfica sustentada. Indicar aneurismectomia cirúrgica para resolução do quadro.', false),
(gen_random_uuid(), '58ad1ce9-087f-4e43-967a-b7f78541c2a5', 'd', 'Taquicardia supraventricular com aberrância. Não iniciar droga antiarrítmica e indicar estudo eletrofisiológico para elucidação diagnóstica.', false),
(gen_random_uuid(), '58ad1ce9-087f-4e43-967a-b7f78541c2a5', 'e', 'Taquicardia ventricular monomórfica sustentada. Indicar implante de cardioversor-desfibrilador dupla-câmara.', true),

(gen_random_uuid(), '8c195312-973e-4d45-bdeb-4a88d1cbabbd', 'a', 'Ação inotrópica positiva.', false),
(gen_random_uuid(), '8c195312-973e-4d45-bdeb-4a88d1cbabbd', 'b', 'Efeitos simpáticos reflexos.', true),
(gen_random_uuid(), '8c195312-973e-4d45-bdeb-4a88d1cbabbd', 'c', 'Contração da célula muscular lisa vascular.', false),
(gen_random_uuid(), '8c195312-973e-4d45-bdeb-4a88d1cbabbd', 'd', 'Vasodilatação que é bloqueada com propranolol.', false),
(gen_random_uuid(), '8c195312-973e-4d45-bdeb-4a88d1cbabbd', 'e', 'Vasodilatação coronária, mas não nos leitos vasculares periféricos.', false),

(gen_random_uuid(), '0771f98c-abf3-4912-9f54-d3b00935b99d', 'a', 'Trata-se de taquicardia supraventricular com aberrância pelo ramo esquerdo. Administração imediata de adenosina.', false),
(gen_random_uuid(), '0771f98c-abf3-4912-9f54-d3b00935b99d', 'b', 'Trata-se de taquicardia ventricular fascicular. Cardioversão elétrica de imediato.', false),
(gen_random_uuid(), '0771f98c-abf3-4912-9f54-d3b00935b99d', 'c', 'Trata-se de taquicardia ventricular fascicular. Verapamil ou qualquer outro antagonista de cálcio venoso.', false),
(gen_random_uuid(), '0771f98c-abf3-4912-9f54-d3b00935b99d', 'd', 'Trata-se de taquicardia supraventricular com aberrância pelo ramo direito. Administração imediata de adenosina.', true),
(gen_random_uuid(), '0771f98c-abf3-4912-9f54-d3b00935b99d', 'e', 'Trata-se de taquicardia ventricular monomórfica sustentada e estável. Administração de procainamida ou amiodarona IV.', false),

(gen_random_uuid(), '51beae04-abb7-4da0-bd10-893acda90a64', 'a', 'Taquicardia sinusal, pois o paciente está estável.', false),
(gen_random_uuid(), '51beae04-abb7-4da0-bd10-893acda90a64', 'b', 'Taquicardia ventricular monomórfica. Realizar cardioversão elétrica sincronizada.', true),
(gen_random_uuid(), '51beae04-abb7-4da0-bd10-893acda90a64', 'c', 'Taquicardia ventricular monomórfica. Administrar 300 mg de amiodarona intravenosa.', false),
(gen_random_uuid(), '51beae04-abb7-4da0-bd10-893acda90a64', 'd', 'Taquicardia supraventricular. Interromper o exame, colocar o paciente em repouso e administrar adenosina.', false),
(gen_random_uuid(), '51beae04-abb7-4da0-bd10-893acda90a64', 'e', 'Taquicardia supraventricular. Administrar diltiazem intravenoso 0,25 mg/kg.', false),

(gen_random_uuid(), '252f80d1-b3e9-4d54-b987-7c1352cdcb96', 'a', 'o intervalo QT é normal.', false),
(gen_random_uuid(), '252f80d1-b3e9-4d54-b987-7c1352cdcb96', 'b', 'é uma forma hereditária de taquicardia ventricular.', false),
(gen_random_uuid(), '252f80d1-b3e9-4d54-b987-7c1352cdcb96', 'c', 'é uma arritmia que se manifesta mais comumente a partir da sétima década de vida.', true),
(gen_random_uuid(), '252f80d1-b3e9-4d54-b987-7c1352cdcb96', 'd', 'a taquicardia ventricular é reprodutível, induzida pelo esforço e frequentemente bidirecional.', false),
(gen_random_uuid(), '252f80d1-b3e9-4d54-b987-7c1352cdcb96', 'e', 'pacientes portadores dessa arritmia devem ser orientados a evitar exercícios físicos vigorosos.', false),

(gen_random_uuid(), 'c172d19f-de2d-40e4-9249-bca1198d9da1', 'a', 'A hipocalcemia não interfere na duração do segmento ST.', false),
(gen_random_uuid(), 'c172d19f-de2d-40e4-9249-bca1198d9da1', 'b', 'A hipercalcemia encurta a fase 2 do potencial de ação aumentando o segmento ST.', false),
(gen_random_uuid(), 'c172d19f-de2d-40e4-9249-bca1198d9da1', 'c', 'A hiperpotassemia causa alargamento do complexo QRS e aumento da amplitude da onda P.', false),
(gen_random_uuid(), 'c172d19f-de2d-40e4-9249-bca1198d9da1', 'd', 'O efeito mais precoce da hiperpotassemia é o desenvolvimento da onda T mais estreita e pontiaguda "em tenda".', true),
(gen_random_uuid(), 'c172d19f-de2d-40e4-9249-bca1198d9da1', 'e', 'A hiponatremia pode causar onda J (onda de Osborn).', false),

(gen_random_uuid(), 'f2c993e5-2864-4c87-80ac-b5b8bb577129', 'a', 'Amiloidose.', false),
(gen_random_uuid(), 'f2c993e5-2864-4c87-80ac-b5b8bb577129', 'b', 'Bloqueio atrioventricular total congênito intermitente.', false),
(gen_random_uuid(), 'f2c993e5-2864-4c87-80ac-b5b8bb577129', 'c', 'Síndrome do QT longo tipo I.', false),
(gen_random_uuid(), 'f2c993e5-2864-4c87-80ac-b5b8bb577129', 'd', 'Síndrome de Brugada.', false),
(gen_random_uuid(), 'f2c993e5-2864-4c87-80ac-b5b8bb577129', 'e', 'Taquicardia ventricular polimórfica catecolaminérgica.', true),

(gen_random_uuid(), 'e4addfc7-e044-42cd-a6f9-6f3e032ae018', 'a', 'nas taquicardias atriais esquerdas assintomáticas.', true),
(gen_random_uuid(), 'e4addfc7-e044-42cd-a6f9-6f3e032ae018', 'b', 'nos casos de taquicardia juncional sintomática e não paroxística resistente ao tratamento farmacológico.', false),
(gen_random_uuid(), 'e4addfc7-e044-42cd-a6f9-6f3e032ae018', 'c', 'pacientes com taquiarritmias atriais sintomáticas que apresentam controle inadequado da frequência ventricular.', false),
(gen_random_uuid(), 'e4addfc7-e044-42cd-a6f9-6f3e032ae018', 'd', 'pacientes com taquiarritmias atriais sintomáticas que não toleram ou não desejam usar drogas para controle da frequência cardíaca e dos sintomas.', false),
(gen_random_uuid(), 'e4addfc7-e044-42cd-a6f9-6f3e032ae018', 'e', 'nos casos de taquicardia mediada por marca-passo, quando o tratamento efetivo não pode ser realizado através de drogas ou da reprogramação do dispositivo.', false),

(gen_random_uuid(), 'd1cb5542-6566-443f-b8f4-b68bdc337646', 'a', 'Nenhum antiarrítmico (com exceção dos betabloqueadores) reduz a mortalidade global de pacientes cardiopatas com arritmias cardíacas.', true),
(gen_random_uuid(), 'd1cb5542-6566-443f-b8f4-b68bdc337646', 'b', 'No Brasil os únicos antiarrítmicos com uso permitido em pacientes com insuficiência cardíaca e disfunção sistólica grave são a amiodarona e o sotalol.', false),
(gen_random_uuid(), 'd1cb5542-6566-443f-b8f4-b68bdc337646', 'c', 'Apesar de estar associada a aumento de intervalo QTc, independente do alargamento do QRS, a propafenona pode ser usada com segurança em pacientes com cardiopatia isquêmica.', false),
(gen_random_uuid(), 'd1cb5542-6566-443f-b8f4-b68bdc337646', 'd', 'A adenosina é um fármaco de meia-vida muito curta (10 a 30 segundos) utilizada para fins diagnósticos e terapêuticos na taquicardia supraventricular e está contraindicada nos casos de taquicardia de QRS largo.', false),
(gen_random_uuid(), 'd1cb5542-6566-443f-b8f4-b68bdc337646', 'e', 'Os bloqueadores de canais de cálcio, diltiazem e verapamil, e digoxina podem ser usados nos pacientes com Síndrome de Wolff-Parkinson-White na prevenção de taquicardias.', false),

(gen_random_uuid(), 'd5116c38-25d9-41ac-8321-b3bb079e682d', 'a', 'Alterações eletrocardiográficas incluem a inversão da onda T em derivações precordiais direitas QRS alargado nas precordiais direitas e onda épsilon.', true),
(gen_random_uuid(), 'd5116c38-25d9-41ac-8321-b3bb079e682d', 'b', 'Nunca acomete o ventrículo esquerdo.', false),
(gen_random_uuid(), 'd5116c38-25d9-41ac-8321-b3bb079e682d', 'c', 'A doença é herdada principalmente como traço recessivo.', false),
(gen_random_uuid(), 'd5116c38-25d9-41ac-8321-b3bb079e682d', 'd', 'Os sintomas costumam surgir depois da quarta década de vida.', false),
(gen_random_uuid(), 'd5116c38-25d9-41ac-8321-b3bb079e682d', 'e', 'Não deve ser tratada com betabloqueadores.', false),

(gen_random_uuid(), '2d9c92c2-2f61-4f70-82e9-a9e26da19e84', 'a', 'Trata-se de taquicardia ventricular polimórfica. Cardioversão elétrica e posterior implante de cardioversor desfibrilador (CDI).', false),
(gen_random_uuid(), '2d9c92c2-2f61-4f70-82e9-a9e26da19e84', 'b', 'Trata-se de fibrilação atrial com aberrância. Cardioversão elétrica de imediato, anticoagulação e posterior ablação por cateter da fibrilação atrial.', false),
(gen_random_uuid(), '2d9c92c2-2f61-4f70-82e9-a9e26da19e84', 'c', 'Trata-se de fibrilação atrial em portador de pré-excitação ventricular. Cardioversão elétrica de imediato e posterior ablação da via acessória.', true),
(gen_random_uuid(), '2d9c92c2-2f61-4f70-82e9-a9e26da19e84', 'd', 'Trata-se de taquicardia ventricular (torsades de pointes) associada à síndrome do QT longo congênito. Cardioversão elétrica e posterior implante de CDI.', false),
(gen_random_uuid(), '2d9c92c2-2f61-4f70-82e9-a9e26da19e84', 'e', 'Trata-se de taquicardia ventricular bidirecional (catecolaminérgica-dependente). Cardioversão elétrica de imediato, betabloqueador venoso e posterior implante de CDI.', false),

(gen_random_uuid(), '4098bf4a-b620-412d-a0a5-a7742ed531f1', 'a', 'Fibrilação atrial, sorologia para Chagas.', false),
(gen_random_uuid(), '4098bf4a-b620-412d-a0a5-a7742ed531f1', 'b', 'Taquicardia sinusal, hemoglobina glicada.', false),
(gen_random_uuid(), '4098bf4a-b620-412d-a0a5-a7742ed531f1', 'c', 'Taquicardia atrial multifocal, nível sérico de digoxina.', true),
(gen_random_uuid(), '4098bf4a-b620-412d-a0a5-a7742ed531f1', 'd', 'Taquicardia sinusal, D-dímero.', false),
(gen_random_uuid(), '4098bf4a-b620-412d-a0a5-a7742ed531f1', 'e', 'Taquicardia juncional, sorologia para Chagas.', false),

(gen_random_uuid(), 'bb6f61be-fa39-483f-85a1-9e03f8dbe3dd', 'a', 'Os betabloqueadores com comportamento hidrofílico podem ser prescritos uma vez ao dia por apresentarem menor metabolismo hepático.', true),
(gen_random_uuid(), 'bb6f61be-fa39-483f-85a1-9e03f8dbe3dd', 'b', 'O carvedilol é pouco lipofílico, o que impede a sua ação no sistema nervoso central.', false),
(gen_random_uuid(), 'bb6f61be-fa39-483f-85a1-9e03f8dbe3dd', 'c', 'O bisoprolol apresenta capacidade de seletividade inferior ao succinato de metoprolol.', false),
(gen_random_uuid(), 'bb6f61be-fa39-483f-85a1-9e03f8dbe3dd', 'd', 'O aumento progressivo da posologia dos betabloqueadores permite maior seletividade sobre os receptores beta-1.', false),
(gen_random_uuid(), 'bb6f61be-fa39-483f-85a1-9e03f8dbe3dd', 'e', 'O carvedilol, o metoprolol, o atenolol e o bisoprolol têm benefício comprovado na redução da mortalidade dos pacientes com insuficiência cardíaca sistólica.', false),

(gen_random_uuid(), 'e01ada26-76a1-4a58-938b-01e11cfb5e54', 'a', 'Está indicada a anticoagulação de longo prazo para todos os pacientes que evoluem com essa arritmia.', false),
(gen_random_uuid(), 'e01ada26-76a1-4a58-938b-01e11cfb5e54', 'b', 'O uso de betabloqueadores no pré-operatório aumenta o risco da arritmia apresentada.', false),
(gen_random_uuid(), 'e01ada26-76a1-4a58-938b-01e11cfb5e54', 'c', 'A amiodarona está contraindicada nesse cenário pelo risco de reversão da arritmia antes da anticoagulação plena.', false),
(gen_random_uuid(), 'e01ada26-76a1-4a58-938b-01e11cfb5e54', 'd', 'O diagnóstico é de fibrilação atrial de alta resposta ventricular e deve ser feita cardioversão elétrica sincronizada imediata.', false),
(gen_random_uuid(), 'e01ada26-76a1-4a58-938b-01e11cfb5e54', 'e', 'A incidência da arritmia apresentada é maior após cirurgias valvares do que após cirurgia de revascularização do miocárdio.', true),

(gen_random_uuid(), '5162f415-2786-4f2c-9bb7-50c0c12eb861', 'a', 'Paciente com cardiomiopatia isquêmica e fração de ejeção do ventrículo esquerdo = 26%, com dois episódios de taquicardia ventricular não sustentada com 4 batimentos em Holter.', false),
(gen_random_uuid(), '5162f415-2786-4f2c-9bb7-50c0c12eb861', 'b', 'Paciente com Síndrome de Brugada e padrão eletrocardiográfico tipo 1, com síncope sem pródromos e em posição supina.', false),
(gen_random_uuid(), '5162f415-2786-4f2c-9bb7-50c0c12eb861', 'c', 'Paciente com cardiomiopatia chagásica, fração de ejeção do ventrículo esquerdo = 45%, eletrocardiograma com bloqueio de ramo direito, Holter com dois períodos curtos de bloqueio atrioventricular Mobitz II e síncope precedida por taquicardia.', true),
(gen_random_uuid(), '5162f415-2786-4f2c-9bb7-50c0c12eb861', 'd', 'Paciente com cardiomiopatia hipertrófica, septo interventricular de 35 mm, síncope e taquicardia ventricular não sustentada de 10 batimentos em Holter.', false),
(gen_random_uuid(), '5162f415-2786-4f2c-9bb7-50c0c12eb861', 'e', 'Paciente com bloqueio atrioventricular de segundo grau Mobitz I e pausas sinusais durante o sono.', false),

(gen_random_uuid(), 'a39138c4-a56a-4fb0-a121-fc604341bd76', 'a', 'Taquicardia ventricular.', false),
(gen_random_uuid(), 'a39138c4-a56a-4fb0-a121-fc604341bd76', 'b', 'Flutter atrial com condução 2:1.', false),
(gen_random_uuid(), 'a39138c4-a56a-4fb0-a121-fc604341bd76', 'c', 'Taquicardia paroxística supraventricular.', true),
(gen_random_uuid(), 'a39138c4-a56a-4fb0-a121-fc604341bd76', 'd', 'Flutter atrial com condução 1:1.', false),
(gen_random_uuid(), 'a39138c4-a56a-4fb0-a121-fc604341bd76', 'e', 'Fibrilação atrial com resposta ventricular rápida.', false),

(gen_random_uuid(), 'fab09740-8def-4910-b55f-620a00ccb631', 'a', 'Wolff-Parkinson-White. Ablação por radiofrequência.', true),
(gen_random_uuid(), 'fab09740-8def-4910-b55f-620a00ccb631', 'b', 'Distrofia muscular de Duchenne. Implante de marca-passo definitivo.', false),
(gen_random_uuid(), 'fab09740-8def-4910-b55f-620a00ccb631', 'c', 'Cardiomiopatia arritmogênica do ventrículo direito. Implante de cardiodesfibrilador implantável.', false),
(gen_random_uuid(), 'fab09740-8def-4910-b55f-620a00ccb631', 'd', 'Síndrome de Brugada. Trocar amiodarona por ivabradina.', false),
(gen_random_uuid(), 'fab09740-8def-4910-b55f-620a00ccb631', 'e', 'Síndrome de Lown-Ganong-Levine. Ablação por laser.', false),

(gen_random_uuid(), '9555d70f-d1be-4830-a644-e4babd34fb21', 'a', 'Betabloqueador intravenoso, para reduzir a frequência cardíaca.', false),
(gen_random_uuid(), '9555d70f-d1be-4830-a644-e4babd34fb21', 'b', 'Compressão do seio carotídeo.', false),
(gen_random_uuid(), '9555d70f-d1be-4830-a644-e4babd34fb21', 'c', 'Cardioversão elétrica imediata.', true),
(gen_random_uuid(), '9555d70f-d1be-4830-a644-e4babd34fb21', 'd', 'Amiodarona intravenoso.', false),
(gen_random_uuid(), '9555d70f-d1be-4830-a644-e4babd34fb21', 'e', 'Adenosina intravenosa.', false),

(gen_random_uuid(), '004a1b0c-2465-4616-adc0-78d808eb4337', 'a', 'Cardioversão elétrica e ablação por radiofrequência.', false),
(gen_random_uuid(), '004a1b0c-2465-4616-adc0-78d808eb4337', 'b', 'Adenosina IV e sotalol VO.', false),
(gen_random_uuid(), '004a1b0c-2465-4616-adc0-78d808eb4337', 'c', 'Verapamil IV em bolo e metoprolol VO.', false),
(gen_random_uuid(), '004a1b0c-2465-4616-adc0-78d808eb4337', 'd', 'Adenosina IV em bolo e ablação por radiofrequência.', true),
(gen_random_uuid(), '004a1b0c-2465-4616-adc0-78d808eb4337', 'e', 'Amiodarona IV e amiodarona VO.', false),

(gen_random_uuid(), '5ae2029a-c0f7-4a8f-8cde-18d952d61d66', 'a', 'Espironolactona', true),
(gen_random_uuid(), '5ae2029a-c0f7-4a8f-8cde-18d952d61d66', 'b', 'Amiodarona', false),
(gen_random_uuid(), '5ae2029a-c0f7-4a8f-8cde-18d952d61d66', 'c', 'Clortalidona', false),
(gen_random_uuid(), '5ae2029a-c0f7-4a8f-8cde-18d952d61d66', 'd', 'Claritromicina', false),
(gen_random_uuid(), '5ae2029a-c0f7-4a8f-8cde-18d952d61d66', 'e', 'Amitriptilina', false),

(gen_random_uuid(), '095b02f8-a907-4b46-afe9-c2063045f282', 'a', 'Alta probabilidade de SQTL.', true),
(gen_random_uuid(), '095b02f8-a907-4b46-afe9-c2063045f282', 'b', 'Baixa probabilidade de SQTL.', false),
(gen_random_uuid(), '095b02f8-a907-4b46-afe9-c2063045f282', 'c', 'Probabilidade intermediária de SQTL.', false),
(gen_random_uuid(), '095b02f8-a907-4b46-afe9-c2063045f282', 'd', 'Somente o estudo genético permite o diagnóstico da SQTL.', false),
(gen_random_uuid(), '095b02f8-a907-4b46-afe9-c2063045f282', 'e', 'Os dados acima são insuficientes para o diagnóstico, pois este exige a presença de taquicardia ventricular polimórfica tipo Torsades de Pointes.', false),

(gen_random_uuid(), 'c5b24dba-b0da-4627-90a6-3b262e6b2fbd', 'a', 'Ácido úrico > 8 mg/dL.', false),
(gen_random_uuid(), 'c5b24dba-b0da-4627-90a6-3b262e6b2fbd', 'b', 'Intervalo QT > 500 ms.', true),
(gen_random_uuid(), 'c5b24dba-b0da-4627-90a6-3b262e6b2fbd', 'c', 'Aumento de transaminases hepáticas.', false),
(gen_random_uuid(), 'c5b24dba-b0da-4627-90a6-3b262e6b2fbd', 'd', 'Disfunção ventricular leve ao ecocardiograma.', false),
(gen_random_uuid(), 'c5b24dba-b0da-4627-90a6-3b262e6b2fbd', 'e', 'Desvio do eixo elétrico para a esquerda no ECG.', false),

(gen_random_uuid(), '1e78551e-902d-4f7d-94ee-ef337ad1ba0e', 'a', 'A ablação não está indicada.', false),
(gen_random_uuid(), '1e78551e-902d-4f7d-94ee-ef337ad1ba0e', 'b', 'O procedimento deve ser suspenso até que seja feita avaliação de isquemia miocárdica.', true),
(gen_random_uuid(), '1e78551e-902d-4f7d-94ee-ef337ad1ba0e', 'c', 'A morfologia da arritmia é característica de arritmias idiopáticas benignas do ventrículo direito.', false),
(gen_random_uuid(), '1e78551e-902d-4f7d-94ee-ef337ad1ba0e', 'd', 'O paciente deve manter seguimento cardiológico regular pela possibilidade de taquicardiomiopatia.', false),
(gen_random_uuid(), '1e78551e-902d-4f7d-94ee-ef337ad1ba0e', 'e', 'Amiodarona é contraindicada para esses pacientes.', false),

(gen_random_uuid(), 'a77a382c-901c-48bc-8daf-df901dcc7046', 'a', 'Taquicardia ventricular polimórfica; cardioversão elétrica.', false),
(gen_random_uuid(), 'a77a382c-901c-48bc-8daf-df901dcc7046', 'b', 'Torsades de Pointes; infusão de magnésio endovenoso.', false),
(gen_random_uuid(), 'a77a382c-901c-48bc-8daf-df901dcc7046', 'c', 'Taquicardia ventricular monomórfica; amiodarona endovenosa.', false),
(gen_random_uuid(), 'a77a382c-901c-48bc-8daf-df901dcc7046', 'd', 'Fibrilação atrial pré-excitada; cardioversão elétrica.', true),
(gen_random_uuid(), 'a77a382c-901c-48bc-8daf-df901dcc7046', 'e', 'Fibrilação atrial com aberrância; cardioversão elétrica.', false),

(gen_random_uuid(), '8e5b0f4c-1108-42b6-be50-f50b03b61fc4', 'a', 'Taquicardia paroxística supraventricular (TPSV) com aberrância. Provável reentrada nodal.', false),
(gen_random_uuid(), '8e5b0f4c-1108-42b6-be50-f50b03b61fc4', 'b', 'Taquicardia ventricular monomórfica sustentada. Reentrada.', false),
(gen_random_uuid(), '8e5b0f4c-1108-42b6-be50-f50b03b61fc4', 'c', 'Taquicardia paroxística supraventricular (TPSV) com aberrância. Provável taquicardia relacionada à síndrome de Wolff-Parkinson-White.', true),
(gen_random_uuid(), '8e5b0f4c-1108-42b6-be50-f50b03b61fc4', 'd', 'Torsades de Pointes. Atividade deflagrada.', false),
(gen_random_uuid(), '8e5b0f4c-1108-42b6-be50-f50b03b61fc4', 'e', 'Taquicardia ventricular bidirecional. Pós-potencial.', false),

(gen_random_uuid(), '80d7ff8b-74e8-44b4-87f3-5679ca2b2a0d', 'a', 'Presença de complexos RS em todas as derivações precordiais.', false),
(gen_random_uuid(), '80d7ff8b-74e8-44b4-87f3-5679ca2b2a0d', 'b', 'Maior intervalo RS > 100 ms em qualquer derivação precordial.', true),
(gen_random_uuid(), '80d7ff8b-74e8-44b4-87f3-5679ca2b2a0d', 'c', 'Ausência de dissociação atrioventricular (AV).', false),
(gen_random_uuid(), '80d7ff8b-74e8-44b4-87f3-5679ca2b2a0d', 'd', 'Presença de RSR'' em V1 quando há morfologia de bloqueio de ramo direito.', false),
(gen_random_uuid(), '80d7ff8b-74e8-44b4-87f3-5679ca2b2a0d', 'e', 'Padrão R pura em "meseta" em V6 quando há morfologia de bloqueio de ramo esquerdo.', false),

(gen_random_uuid(), '207052d5-edc3-48ef-a44d-d6b9d102411a', 'a', 'Amiodarona 300 mg em bolus intravenoso.', false),
(gen_random_uuid(), '207052d5-edc3-48ef-a44d-d6b9d102411a', 'b', 'Adenosina 12 mg intravenosa em bolus.', false),
(gen_random_uuid(), '207052d5-edc3-48ef-a44d-d6b9d102411a', 'c', 'Cardioversão elétrica, posto que o paciente está instável hemodinamicamente.', true),
(gen_random_uuid(), '207052d5-edc3-48ef-a44d-d6b9d102411a', 'd', 'Bloqueadores de canais de cálcio intravenosos em 30 minutos.', false),
(gen_random_uuid(), '207052d5-edc3-48ef-a44d-d6b9d102411a', 'e', 'Metoprolol 5 mg, endovenoso, em bolus em 3 minutos.', false),

(gen_random_uuid(), '407ede6b-ebc0-4ec5-afc2-95e12363e97f', 'a', 'Taquicardia por reentrada nodal e flutter atrial.', false),
(gen_random_uuid(), '407ede6b-ebc0-4ec5-afc2-95e12363e97f', 'b', 'Taquicardia por reentrada atrioventricular (AV) e taquicardia por reentrada nodal.', true),
(gen_random_uuid(), '407ede6b-ebc0-4ec5-afc2-95e12363e97f', 'c', 'Taquicardia atrial e taquicardia ventricular fascicular.', false),
(gen_random_uuid(), '407ede6b-ebc0-4ec5-afc2-95e12363e97f', 'd', 'Taquicardia ventricular e fibrilação atrial.', false),
(gen_random_uuid(), '407ede6b-ebc0-4ec5-afc2-95e12363e97f', 'e', 'Taquicardia por reentrada AV e flutter atrial.', false),

(gen_random_uuid(), '36c4e526-d9f0-4895-86fe-431598d1cb0f', 'a', 'Presença de RS nas derivações de V2 a V6.', false),
(gen_random_uuid(), '36c4e526-d9f0-4895-86fe-431598d1cb0f', 'b', 'Padrão trifásico RSR'' em V1.', false),
(gen_random_uuid(), '36c4e526-d9f0-4895-86fe-431598d1cb0f', 'c', 'Intervalo de RS menor que 100ms nas derivações precordiais.', false),
(gen_random_uuid(), '36c4e526-d9f0-4895-86fe-431598d1cb0f', 'd', 'Presença de dissociação atrioventricular.', true),
(gen_random_uuid(), '36c4e526-d9f0-4895-86fe-431598d1cb0f', 'e', 'Padrão R/S em V6 maior que 1.', false),

(gen_random_uuid(), '85f05fdb-852e-450a-9513-b20d2a500f34', 'a', 'Se houver indicação de ressincronização cardíaca não é a melhor opção.', false),
(gen_random_uuid(), '85f05fdb-852e-450a-9513-b20d2a500f34', 'b', 'Não deve ser usado isoladamente na presença de bradicardias significativas.', false),
(gen_random_uuid(), '85f05fdb-852e-450a-9513-b20d2a500f34', 'c', 'Pode ser alternativa para pacientes com endocardite prévia associada a dispositivo.', false),
(gen_random_uuid(), '85f05fdb-852e-450a-9513-b20d2a500f34', 'd', 'É útil tanto na prevenção primária como secundária de morte súbita.', false),
(gen_random_uuid(), '85f05fdb-852e-450a-9513-b20d2a500f34', 'e', 'Deve ser evitado em portadores de canalopatias.', true),

(gen_random_uuid(), '98f94b41-2441-4dc5-bf01-0c62f615f3d2', 'a', 'A ação dos betabloqueadores seletivos dos receptores beta 1 é perdida com o aumento da dose.', false),
(gen_random_uuid(), '98f94b41-2441-4dc5-bf01-0c62f615f3d2', 'b', 'Os betabloqueadores não seletivos têm atuação de bloqueio dos receptores β1 e β2 já em baixas doses.', false),
(gen_random_uuid(), '98f94b41-2441-4dc5-bf01-0c62f615f3d2', 'c', 'Os betabloqueadores cardiosseletivos são propranolol, metoprolol e atenolol.', true),
(gen_random_uuid(), '98f94b41-2441-4dc5-bf01-0c62f615f3d2', 'd', 'O carvedilol tem ação vasodilatadora em decorrência do bloqueio dos alfa-receptores periféricos.', false),
(gen_random_uuid(), '98f94b41-2441-4dc5-bf01-0c62f615f3d2', 'e', 'A ação anti-hipertensiva envolve a redução do débito cardíaco (bloqueio β1-R) e a redução da liberação da renina (bloqueio β1-R).', false),

(gen_random_uuid(), '2c2cd32c-e032-469e-abb0-2f8303e89637', 'a', 'Ablação por cateter.', true),
(gen_random_uuid(), '2c2cd32c-e032-469e-abb0-2f8303e89637', 'b', 'Amiodarona.', false),
(gen_random_uuid(), '2c2cd32c-e032-469e-abb0-2f8303e89637', 'c', 'Sotalol.', false),
(gen_random_uuid(), '2c2cd32c-e032-469e-abb0-2f8303e89637', 'd', 'Digoxina.', false),
(gen_random_uuid(), '2c2cd32c-e032-469e-abb0-2f8303e89637', 'e', 'Bloqueador de canal de cálcio (verapamil).', false),

(gen_random_uuid(), '9bbc58b3-a2ff-4054-9285-a27f727ca4bd', 'a', 'O melhor parâmetro para predizer o risco de morte súbita nesses pacientes é o menor intervalo RR observado durante a fibrilação atrial (< 220 ms = alto risco).', false),
(gen_random_uuid(), '9bbc58b3-a2ff-4054-9285-a27f727ca4bd', 'b', 'Por se tratar de fibrilação ventricular, deve-se seguir o algoritmo do ACLS (Suporte Avançado de Vida Cardiovascular) com rápido início de ressuscitação cardiopulmonar e desfibrilação.', true),
(gen_random_uuid(), '9bbc58b3-a2ff-4054-9285-a27f727ca4bd', 'c', 'A ablação é o tratamento definitivo de escolha.', false),
(gen_random_uuid(), '9bbc58b3-a2ff-4054-9285-a27f727ca4bd', 'd', 'Nesse caso, o tratamento de escolha na emergência é a cardioversão.', false),
(gen_random_uuid(), '9bbc58b3-a2ff-4054-9285-a27f727ca4bd', 'e', 'Apesar de essa arritmia ocorrer quase sempre em corações estruturalmente normais, ela geralmente evolui com instabilidade hemodinâmica e risco de morte súbita.', false),

(gen_random_uuid(), 'd4e074c0-14e3-40df-9baa-8dedea41f7e4', 'a', 'Por se tratar de flutter atrial o tratamento de escolha é a cardioversão elétrica sincronizada após sedação e analgesia adequadas.', false),
(gen_random_uuid(), 'd4e074c0-14e3-40df-9baa-8dedea41f7e4', 'b', 'Como a paciente vinha em ritmo sinusal não estava indicado uso de terapia antitrombótica ambulatorialmente.', false),
(gen_random_uuid(), 'd4e074c0-14e3-40df-9baa-8dedea41f7e4', 'c', 'Para realização de cardioversão elétrica, uma vez que o diagnóstico eletrocardiográfico é de flutter atrial, a carga escolhida deve ser de 50 joules com alta taxa de sucesso na reversão da arritmia.', false),
(gen_random_uuid(), 'd4e074c0-14e3-40df-9baa-8dedea41f7e4', 'd', 'Paciente tem indicação de ablação de fibrilação atrial em momento oportuno, caso seja do desejo da paciente.', true),
(gen_random_uuid(), 'd4e074c0-14e3-40df-9baa-8dedea41f7e4', 'e', 'Caso esteja disponível, o ecocardiograma transesofágico pode ser usado para descartar trombos intracavitários e dispensa a anticoagulação pós cardioversão elétrica.', false),

(gen_random_uuid(), '9701deae-d4d3-43c3-9ab1-5d36a0432662', 'a', 'Início de ivabradina.', false),
(gen_random_uuid(), '9701deae-d4d3-43c3-9ab1-5d36a0432662', 'b', 'Aumento do enalapril.', false),
(gen_random_uuid(), '9701deae-d4d3-43c3-9ab1-5d36a0432662', 'c', 'Implante de desfibrilador.', true),
(gen_random_uuid(), '9701deae-d4d3-43c3-9ab1-5d36a0432662', 'd', 'Indicação de propafenona.', false),
(gen_random_uuid(), '9701deae-d4d3-43c3-9ab1-5d36a0432662', 'e', 'Troca de carvedilol por sotalol.', false),

(gen_random_uuid(), '147da0f8-1518-444b-acb6-923759eac2a3', 'a', 'O paciente deve ser submetido à ablação por cateter.', true),
(gen_random_uuid(), '147da0f8-1518-444b-acb6-923759eac2a3', 'b', 'O paciente deve ser inicialmente investigado com ressonância cardíaca para investigação de miocardite aguda.', false),
(gen_random_uuid(), '147da0f8-1518-444b-acb6-923759eac2a3', 'c', 'O paciente deve ser inicialmente tratado com betabloqueador, preferencialmente propranolol.', false),
(gen_random_uuid(), '147da0f8-1518-444b-acb6-923759eac2a3', 'd', 'O paciente deve ser submetido ao implante de cardioversor desfibrilador implantável.', false),
(gen_random_uuid(), '147da0f8-1518-444b-acb6-923759eac2a3', 'e', 'O paciente deve realizar ecocardiograma, teste ergométrico e Holter e, a partir desses exames, deve-se avaliar a necessidade de estudo eletrofisiológico.', false),

(gen_random_uuid(), '08868501-e853-46b1-9ef6-bfa5c58757fb', 'a', 'não é causa de síncope.', false),
(gen_random_uuid(), '08868501-e853-46b1-9ef6-bfa5c58757fb', 'b', 'geralmente é assintomática.', false),
(gen_random_uuid(), '08868501-e853-46b1-9ef6-bfa5c58757fb', 'c', 'não altera o débito cardíaco.', false),
(gen_random_uuid(), '08868501-e853-46b1-9ef6-bfa5c58757fb', 'd', 'é mais comum a partir da sexta década de vida.', false),
(gen_random_uuid(), '08868501-e853-46b1-9ef6-bfa5c58757fb', 'e', 'o prognóstico em pacientes sem doença cardíaca é bom.', true),

(gen_random_uuid(), '15434b78-6311-45fc-9e1e-4accfcc78148', 'a', 'pode resultar em hipertireoidismo.', true),
(gen_random_uuid(), '15434b78-6311-45fc-9e1e-4accfcc78148', 'b', 'corpos na córnea ("deposição corneal") são permanentes e obrigam a suspensão do tratamento.', false),
(gen_random_uuid(), '15434b78-6311-45fc-9e1e-4accfcc78148', 'c', 'tem amplo espectro de efeitos colaterais, mas não são relatadas alterações cutâneas.', false),
(gen_random_uuid(), '15434b78-6311-45fc-9e1e-4accfcc78148', 'd', 'pelo prolongamento do intervalo QTc, o risco de Torsades de Pointes é alto.', false),
(gen_random_uuid(), '15434b78-6311-45fc-9e1e-4accfcc78148', 'e', 'é categoria C para uso na gestação e é frequente o uso no tratamento de arritmias fetais.', false),

(gen_random_uuid(), '2c48aad8-365a-44a9-8f54-108328222b4b', 'a', 'Em atletas é comum a presença de bloqueios atrioventriculares de primeiro grau e segundo grau tipo I. A atividade física deve ser suspensa até a realização de avaliação complementar e, caso se confirme se tratarem de alterações benignas, podem ser liberados para participação esportiva.', false),
(gen_random_uuid(), '2c48aad8-365a-44a9-8f54-108328222b4b', 'b', 'Para pacientes com bloqueio de ramo alternante, independentemente de sintomas, está recomendado o implante de marcapasso definitivo.', true),
(gen_random_uuid(), '2c48aad8-365a-44a9-8f54-108328222b4b', 'c', 'Nos portadores de bloqueio atrioventricular total congênito, assintomáticos, que apresentam QRS estreito pode ser optado por acompanhamento clínico sem implante de marcapasso definitivo independente da frequência cardíaca média ou outros fatores de risco.', false),
(gen_random_uuid(), '2c48aad8-365a-44a9-8f54-108328222b4b', 'd', 'O intervalo HV é um bom preditor da evolução para bloqueio atrioventricular total, e valores maiores que 50 ms em pacientes sintomáticos indicam implante de marcapasso definitivo.', false),
(gen_random_uuid(), '2c48aad8-365a-44a9-8f54-108328222b4b', 'e', 'Não há indicação de implante de marcapasso para portadores de bloqueio atrioventricular de 1° grau.', false),

(gen_random_uuid(), 'd4d346a5-bf6c-42af-9dbb-5486725ee33a', 'a', 'A ablação é o tratamento curativo de escolha mas apresenta alta taxa de recorrência.', false),
(gen_random_uuid(), 'd4d346a5-bf6c-42af-9dbb-5486725ee33a', 'b', 'Em crianças pode haver desaparecimento espontâneo da via acessória.', true),
(gen_random_uuid(), 'd4d346a5-bf6c-42af-9dbb-5486725ee33a', 'c', 'A ablação é contraindicada para pacientes assintomáticos.', false),
(gen_random_uuid(), 'd4d346a5-bf6c-42af-9dbb-5486725ee33a', 'd', 'Pacientes com episódio de fibrilação atrial pré-excitada devem ser acompanhados ambulatorialmente com tratamento medicamentoso e apenas em caso de recorrência deve ser indicada ablação.', false),
(gen_random_uuid(), 'd4d346a5-bf6c-42af-9dbb-5486725ee33a', 'e', 'Amiodarona é contraindicada no cenário ambulatorial devido aos efeitos colaterais frequentes.', false);

