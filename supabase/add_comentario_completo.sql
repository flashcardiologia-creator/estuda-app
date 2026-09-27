-- Adiciona a coluna de "resposta completa" (explicação mais longa, com o
-- porquê de cada alternativa errada estar errada) e preenche para as 49
-- questões de Pulsos e Ausculta já existentes. A coluna `comentario`
-- continua sendo a resposta resumida, sempre mostrada por padrão; esta
-- nova coluna só aparece quando a pessoa clica em "Resposta completa".
--
-- Rode este arquivo uma vez no SQL Editor do seu projeto Supabase.

alter table public.questions add column if not exists comentario_completo text;

-- ============================================================
-- Tema: Pulsos
-- ============================================================

update public.questions set comentario_completo = 'O diagrama mostra um desdobramento amplo e fixo de B2, lembrando o padrão de bloqueio de ramo direito, mas decorrente de estimulação artificial do ventrículo direito: o eletrodo do marca-passo, posicionado no ápice do VD, ativa esse ventrículo de forma elétrica "manual" e atrasada em relação ao VE, exatamente como um BRD nativo faria — só que aqui a causa é a espícula do marca-passo, não uma doença do sistema de condução.

Por que as outras alternativas estão incorretas:
• A) Comunicação interatrial: causaria desdobramento fixo de B2 por sobrecarga de volume do VD, mas sempre acompanhado de sopro sistólico em foco pulmonar por hiperfluxo — não há evidência disso aqui, e o achado central da imagem é a espícula de marca-passo, não um sopro.
• C) Estenose pulmonar: atrasa o COMPONENTE PULMONAR (P2) por obstrução na via de saída do VD, gerando desdobramento amplo mas sem relação com estimulação elétrica artificial — o mecanismo é mecânico/obstrutivo, não elétrico.
• D) Bloqueio completo do ramo direito: produziria um padrão eletrocardiográfico semelhante, mas nativo (sem espícula) — a presença do estímulo do marca-passo no traçado é o que definitivamente aponta para estimulação artificial, e não para um BRD espontâneo.
• E) Estenose mitral: não se relaciona ao desdobramento de B2; seus achados são estalido de abertura e sopro diastólico em ruflar no foco mitral, sem qualquer ligação com a ativação ventricular direita.'
where id = '68b5cb1c-87a8-4e6c-90c0-5f8244a2ef96';

update public.questions set comentario_completo = 'A curva mostra ondas "a" em canhão — picos altos e irregulares na coluna de pulso venoso — dissociadas da atividade ventricular, achado característico do bloqueio atrioventricular de terceiro grau (BAVT). No BAVT, átrio e ventrículo batem de forma totalmente independente; quando o átrio contrai bem no momento em que a valva tricúspide está fechada (porque o ventrículo já contraiu por conta própria), a pressão gerada não tem para onde escoar e "estoura" na jugular como uma onda gigante — a onda em canhão.

Por que as outras alternativas estão incorretas:
• A) Fibrilação atrial: não existe contração atrial coordenada, então a onda "a" simplesmente desaparece da curva — não há como gerar uma onda em canhão, que depende justamente de uma contração atrial organizada malsincronizada com o ventrículo.
• B) Flutter atrial: pode gerar ondulações rápidas e regulares na jugular (ondas de flutter, ~300/min), mas não o padrão de canhão intermitente e dissociado que a curva mostra, que exige perda completa da sincronia AV.
• D) Estenose aórtica: é uma doença do pulso ARTERIAL (parvus et tardus) e não altera a morfologia do pulso venoso jugular, que é o que a curva representa.
• E) Insuficiência tricúspide: gera uma onda "v" gigante fundida com a "c" (onda "cv") por regurgitação sistólica de sangue para o átrio direito, um padrão bem diferente da onda "a" em canhão vista aqui.'
where id = '713674bb-f3f5-4a26-8ec0-7f85bea156c2';

update public.questions set comentario_completo = 'Tamponamento cardíaco: tríade de hipotensão, estase jugular e bulhas hipofonéticas (tríade de Beck), associada a pulso paradoxal (queda da PA sistólica >10 mmHg na inspiração) e alternância elétrica no ECG. O quadro clínico (dispneia rapidamente progressiva em paciente com radioterapia/quimioterapia prévias) sugere um derrame pericárdico volumoso de instalação relativamente rápida. Confirma-se com ecocardiograma (derrame com compressão de átrio e ventrículo direitos) e trata-se com drenagem/pericardiocentese — não com conduta conservadora —, além de investigar a etiologia (aqui, recidiva neoplásica ou pericardite actínica são as suspeitas mais prováveis).

Por que as outras alternativas estão incorretas:
• A) Repete parte do quadro de tamponamento, mas propõe conduta ERRADA e perigosa: diurético/repouso e cirurgia eletiva "pela rotina" — tamponamento com hipotensão e dispneia progressiva é emergência, exige drenagem/pericardiocentese, não conduta expectante.
• C) Descreve pericardite CONSTRITIVA (achado crônico, de meses a anos), incompatível com a evolução aguda de 15 dias e a hipotensão franca do caso — a estase jugular e a hipofonese de bulhas aqui refletem compressão aguda por derrame, não um pericárdio rígido e cicatricial.
• D) Atribui o quadro a cardiotoxicidade direta da quimioterapia (miocardiopatia), mas essa entidade cursaria com sinais de congestão pulmonar e disfunção de bomba, não com a combinação específica de hipotensão + estase jugular + bulhas hipofonéticas sem sopros, que é a tríade clássica de tamponamento.
• E) Sugere radiografia de tórax com sinais de congestão pulmonar — porém no tamponamento a área cardíaca pode aumentar (derrame), mas SEM congestão pulmonar associada, já que o problema é compressivo/extracardíaco e não de falência de bomba do VE.'
where id = '41319994-aef5-47ef-9846-8040b0c3e4fa';

update public.questions set comentario_completo = 'No bloqueio de ramo esquerdo (BRE), o atraso na ativação elétrica do ventrículo esquerdo retarda o fechamento da valva aórtica, fazendo com que o componente pulmonar (P2) preceda o aórtico (A2) — o inverso da ordem fisiológica. É o chamado desdobramento paradoxal, que fica mais evidente na EXPIRAÇÃO: na inspiração, o atraso fisiológico do P2 (por maior retorno venoso ao VD) "encontra" o A2 já atrasado pelo BRE, e os dois sons se aproximam ou até se fundem; na expiração, o P2 volta a seu tempo normal (mais precoce) e o A2, atrasado, faz o desdobramento reaparecer.

Por que as outras alternativas estão incorretas:
• A) Em indivíduos sadios ocorre o oposto: o componente AÓRTICO (A2) precede o pulmonar (P2), porque o VE termina a ejeção antes do VD.
• B) Na comunicação interatrial (CIA), o desdobramento de B2 é FIXO — ou seja, não varia com a respiração —, e não "constante e variável" como a alternativa descreve (constante e variável são conceitos opostos colocados juntos).
• D) O bloqueio de ramo direito (BRD) também tem desdobramento amplo, mas ele AINDA responde à respiração (se acentua na inspiração); descrevê-lo como "constante, não modificado pelo padrão respiratório" é o que define a CIA, não o BRD.
• E) A inspiração, na verdade, AUMENTA o retorno venoso ao VD e prolonga (não encurta) o tempo de ejeção ventricular direita — é justamente esse mecanismo que atrasa fisiologicamente o P2 e gera o desdobramento fisiológico de B2 na inspiração.'
where id = 'a6c3bef0-73dc-4d78-a96e-e4252f00fd91';

update public.questions set comentario_completo = 'Onda "a" proeminente (ou "em canhão") reflete contração atrial direita contra resistência aumentada. Quando o VD precisa ejetar contra uma pressão pulmonar subitamente elevada — como na embolia pulmonar maciça — ou contra uma valva tricúspide estreitada, o átrio direito precisa contrair com mais força para vencer essa resistência, e essa contração vigorosa aparece como uma onda "a" bem mais alta que o normal na curva de pulso venoso.

Por que as outras alternativas estão incorretas:
• A) No tamponamento cardíaco o descenso Y fica ACHATADO/atenuado (não acentuado) — a compressão externa contínua impede o esvaziamento rápido do átrio direito mesmo após a abertura da tricúspide, o que é o oposto de um descenso Y proeminente.
• B) O bloqueio AV de PRIMEIRO grau apenas prolonga o intervalo PR, mas mantém a condução 1:1 (toda onda P é seguida de um QRS) — a onda "a" em canhão exige dissociação entre átrio e ventrículo, como ocorre no BAV de TERCEIRO grau, não no de primeiro.
• C) O sinal de Kussmaul (aumento paradoxal da estase jugular na inspiração) é mais associado à pericardite constritiva, mas não é exclusivo dela — também pode ocorrer em cardiomiopatia restritiva, infarto de VD e, mais raramente, em tamponamento; por isso "patognomônico" é uma afirmação forte demais para estar correta.
• E) O refluxo mitral gera onda "v" gigante na curva de pressão do ÁTRIO ESQUERDO (visível no capilar pulmonar/eco), não no pulso venoso JUGULAR, que reflete as pressões do átrio direito.'
where id = '019c4815-2dc4-411e-a9ee-e778a08465f2';

update public.questions set comentario_completo = 'A queda da PA sistólica maior que 10 mmHg durante a inspiração define pulso paradoxal — no caso, de 110x80 para 92x70 (queda de 18 mmHg), configurando o achado. Classicamente associado a tamponamento cardíaco, o pulso paradoxal também pode ocorrer em embolia pulmonar maciça e DPOC grave, ambas relevantes neste paciente pelo antecedente de neoplasia de pulmão ressecada (risco de recidiva/êmbolo tumoral e de doença pulmonar associada).

Por que as outras alternativas estão incorretas:
• A) Uma queda de 18 mmHg na PA sistólica com a inspiração NÃO é achado normal (o limite fisiológico é até 10 mmHg) — é sinal de alerta que exige investigação, não deve ser ignorado.
• B) O achado descrito (variação de PA com o ciclo respiratório) é pulso PARADOXAL, não pulso ALTERNANTE (que é uma variação de amplitude entre batimentos sucessivos, independente da respiração, ligada à disfunção sistólica do VE) — os dois conceitos e mecanismos são diferentes.
• C) O pulso paradoxal está classicamente associado ao tamponamento, mas não é patognomônico dele — ocorre também em DPOC grave, asma grave e embolia pulmonar maciça, como o próprio contexto do paciente sugere.
• D) O sinal de Kussmaul relaciona-se à dificuldade de enchimento do ventrículo direito (pericardite constritiva, tamponamento com componente restritivo, infarto de VD), não à hipovolemia — na hipovolemia isolada não se espera esse sinal.'
where id = 'fbfecf1e-c709-42fd-97aa-640775ac5e83';

update public.questions set comentario_completo = 'O pulso alternante — alternância na amplitude de pulsos sucessivos com ritmo cardíaco REGULAR — é sinal de disfunção sistólica grave do ventrículo esquerdo. Ele reflete uma variação batimento a batimento do volume ejetado: como o miocárdio já está muito comprometido, pequenas variações na pré-carga e no número de fibras recrutadas a cada ciclo produzem ora um batimento mais forte, ora um mais fraco, de forma cadenciada.

Por que as outras alternativas estão incorretas:
• A) A fibrilação atrial já tem ritmo IRREGULAR por definição — não é possível caracterizar uma alternância cadenciada de amplitude (que pressupõe ritmo regular) num ritmo que já é caoticamente irregular.
• C) O pulso alternante é acentuado por sobrecarga de volume/pressão com disfunção sistólica associada — hipovolemia e hipotensão tendem a MASCARAR o achado (por reduzirem o volume ejetado como um todo), não a exacerbá-lo.
• D) Variações de amplitude ligadas ao ciclo RESPIRATÓRIO descrevem o pulso PARADOXAL, não o pulso alternante — que independe da respiração e depende apenas da contratilidade miocárdica batimento a batimento.
• E) Essa frase descreve o mecanismo do desdobramento fisiológico da segunda bulha (encurtamento do tempo de ejeção do VD na inspiração), um conceito de outra questão sem relação com o pulso alternante.'
where id = 'e2185ba1-e7b6-4061-b0a9-4a16e2978fd6';

update public.questions set comentario_completo = 'A veia jugular INTERNA (não a externa) é a preferida para avaliação do pulso venoso, pois se comunica diretamente com o átrio direito através de um trajeto retilíneo, sem válvulas que distorçam a curva de pressão. A jugular externa, ao contrário, tem válvulas e um trajeto mais tortuoso (atravessa a fáscia cervical em ângulo), o que pode alterar artificialmente a morfologia das ondas — por isso ela é a exceção pedida na questão.

Por que as outras alternativas NÃO são a exceção (ou seja, são verdadeiras):
• A) O pulso venoso jugular de fato permite avaliar à beira do leito o estado volêmico do paciente (altura da coluna e resposta a manobras como o refluxo abdominojugular).
• B) A pressão venosa realmente se modifica com a inspiração (cai fisiologicamente, pela redução da pressão intratorácica que "puxa" o sangue venoso para dentro do tórax).
• C) A turgência jugular ESQUERDA isolada (sem turgência à direita) é de fato um achado descrito na persistência de veia cava superior esquerda, uma variante anatômica congênita rara.
• D) O refluxo abdominojugular positivo (aumento sustentado da altura da coluna jugular à compressão do abdome) é, de fato, indicativo de hipertensão venosa/congestão sistêmica.'
where id = 'bae813c8-fac0-47b3-b951-49d90184fd73';

update public.questions set comentario_completo = 'Tamponamento sem pulso paradoxal ocorre em situações com desequilíbrio de pressões entre as câmaras cardíacas, que "mascaram" o mecanismo clássico do pulso paradoxal (queda exagerada do volume de enchimento do VE na inspiração por compressão externa): CIA, insuficiência aórtica importante, disfunção sistólica grave de VE e tamponamento localizado por coágulo pós-operatório. Já o derrame de etiologia NEOPLÁSICA, por ser tipicamente circunferencial e de instalação progressiva, costuma cursar com o pulso paradoxal clássico — sendo, portanto, a exceção pedida (é o único cenário da lista em que o pulso paradoxal SE espera).

Por que as outras alternativas NÃO são a exceção (ou seja, cursam sem pulso paradoxal, como a pergunta descreve):
• A) Na CIA, a comunicação entre os átrios permite equalizar as pressões entre as câmaras direita e esquerda, atenuando a transmissão da variação respiratória e mascarando o pulso paradoxal.
• C) Na insuficiência aórtica importante, o VE já recebe volume extra por outra via (regurgitação diastólica), o que atenua o impacto da variação inspiratória sobre seu enchimento.
• D) Na disfunção sistólica grave do VE, as pressões de enchimento já estão cronicamente muito elevadas, e o tamponamento agudo altera proporcionalmente menos esse padrão já alterado.
• E) Um coágulo localizado pós-operatório comprime seletivamente uma câmara, sem a compressão circunferencial uniforme que é necessária para gerar o pulso paradoxal clássico.'
where id = '7d973723-056b-4007-88ad-5f962c5f53c3';

update public.questions set comentario_completo = 'A onda "a" do pulso venoso jugular representa a contração pré-sistólica do átrio direito: ela surge logo após a onda P do ECG (que representa a despolarização/contração atrial) e precede a primeira bulha cardíaca, que marca o fechamento das valvas atrioventriculares (mitral e tricúspide) no início da sístole ventricular. É, portanto, a primeira onda ascendente da curva do pulso venoso, correspondendo ao momento em que o átrio "empurra" o último volume de sangue para dentro do ventrículo antes dele contrair.

Por que as outras alternativas estão incorretas:
• A) Na comunicação interatrial, a onda "v" costuma ficar igual ou mais proeminente que a "a" (pela sobrecarga de volume do átrio direito), e não menor — o afirmado é o oposto do esperado.
• B) O descenso "y" representa a ABERTURA da valva tricúspide (esvaziamento rápido do átrio para o ventrículo já relaxado), não o seu fechamento — quem representa o fechamento tricúspide é o início da onda "c", não o descenso "y".
• C) Na fibrilação atrial não existe contração atrial coordenada — por isso a onda "a" simplesmente DESAPARECE da curva, ela não fica "em canhão" (esse achado depende de dissociação AV, como no BAV total, não de fibrilação).
• D) Na insuficiência tricúspide, o descenso "x" tende a se ATENUAR ou desaparecer (substituído por uma onda sistólica positiva "cv"), e não a aumentar — o sangue que deveria "descer" durante a sístole ventricular na verdade reflui para o átrio.'
where id = 'd1e3f1e1-09b2-4683-8f63-699f3694b6b2';

update public.questions set comentario_completo = 'A onda "a" representa a contração pré-sistólica do átrio direito, ocorrendo imediatamente antes da sístole ventricular — é o átrio "empurrando" o volume final de sangue para dentro do ventrículo relaxado, um instante antes de este último se contrair e fechar as valvas atrioventriculares.

Por que as outras alternativas estão incorretas:
• A) "Enchimento atrial" descreve um evento passivo anterior (o átrio se enchendo de sangue vindo das veias cavas/pulmonares), não o evento ativo de contração que a onda "a" representa.
• B) Não existe, na fisiologia do ciclo cardíaco, o conceito de "sucção diastólica atrial" como definição da onda "a" — trata-se de um termo distrator sem correspondência fisiológica direta com essa onda.
• C) "Queda da pressão do átrio direito" descreve um DESCENSO (X ou Y, que são quedas na curva), não uma onda ASCENDENTE como a "a".
• E) "Queda da pressão após a abertura da tricúspide" descreve especificamente o descenso Y, que ocorre depois — e não antes — da contração ventricular representada pela onda "a".'
where id = '11e7283e-cd26-45e1-b722-b0d311dcc86e';

update public.questions set comentario_completo = 'Na pericardite constritiva, o pulso paradoxal ocorre em cerca de 1/3 dos casos (não é a regra, ao contrário do que se poderia supor). Predominam sinais de insuficiência cardíaca DIREITA (estase jugular, hepatomegalia, edema, ascite), já que o pericárdio rígido limita principalmente o enchimento e a expansão das câmaras direitas. O sinal de Kussmaul é o AUMENTO (e não a redução) da estase jugular na inspiração, pois o pericárdio fibrótico impede que o aumento do retorno venoso inspiratório seja acomodado pelo coração; e o knock pericárdico é um som PROTODIASTÓLICO (precoce), gerado pela parada abrupta do enchimento ventricular contra o pericárdio rígido — não é um som telediastólico (tardio).

Por que as outras alternativas estão incorretas:
• A) O predomínio é de câmaras DIREITAS, não esquerdas — a apresentação clássica é de estase jugular, hepatomegalia e edema periférico, um quadro de insuficiência cardíaca direita.
• B) O sinal de Kussmaul é definido como AUMENTO (não redução) da estase jugular na inspiração profunda — a alternativa inverte o sinal do achado.
• D) O knock pericárdico é PROTODIASTÓLICO (logo após B2), determinado pela parada súbita do enchimento ventricular precoce contra o pericárdio rígido — descrevê-lo como "telediastólico" e ligado à contração atrial é incorreto (isso lembraria antes uma B4).
• E) O pulso arterial alternante é achado clássico de disfunção SISTÓLICA GRAVE do ventrículo esquerdo, não de pericardite constritiva (onde a função sistólica do miocárdio costuma estar preservada, sendo o problema mecânico/pericárdico).'
where id = 'dde4d085-dd5d-421e-aadf-b0d691aa0b9f';

update public.questions set comentario_completo = 'A arterite de Takayasu ("doença sem pulso") acomete predominantemente MULHERES JOVENS, causando estenoses inflamatórias de grandes vasos (aorta e seus ramos), com assimetria de pulsos entre membros e sopros vasculares — como o sopro axilar contínuo descrito na alternativa correta, que reflete a estenose de um ramo do arco aórtico (subclávia/axilar).

Por que as outras alternativas estão incorretas:
• A) Mulher de 60 anos, diabética, com síndrome coronariana aguda: descreve um perfil de doença aterosclerótica coronariana, associado a fatores de risco cardiovascular tradicionais — não ao perfil demográfico (mulher jovem) nem à apresentação vascular periférica da Takayasu.
• B) Homem de 65 anos com hipertensão renovascular: sugere doença aterosclerótica ou displasia fibromuscular de artéria renal em faixa etária e sexo que não são os classicamente afetados pela Takayasu.
• D) Homem de 30 anos com doença valvar reumática e febre diária: descreve um quadro de febre reumática ativa ou endocardite, uma doença valvar inflamatória diferente, sem relação com vasculite de grandes vasos.
• E) "Início da contração atrial": é uma frase fora de contexto, que na verdade descreve a onda "a" do pulso venoso (de outra questão), não um perfil clínico de paciente.'
where id = '1f60af8f-cd6d-49d8-8d92-5407b74ea1d1';

update public.questions set comentario_completo = 'A coarctação da aorta reduz os pulsos femorais/de membros inferiores (gerando diferencial de pulso e de pressão entre membros superiores e inferiores, o que pode causar síncope por hipoperfusão relativa) e gera circulação colateral pelas artérias intercostais para contornar a obstrução aórtica — esse fluxo colateral aumentado "desgasta" a borda inferior das costelas ao longo dos anos, produzindo as erosões costais características na radiografia de tórax (o chamado "sinal de Roesler" ou entalhes de Roesler).

Por que as outras alternativas estão incorretas:
• B) A comunicação interatrial não reduz os pulsos de membros inferiores nem produz erosões costais — seu achado radiológico típico é o aumento da trama vascular pulmonar por hiperfluxo, não erosão óssea.
• C) A estenose pulmonar não causa diferencial de pulsos entre membros (afeta a circulação pulmonar, não a sistêmica) nem gera circulação colateral intercostal.
• D) A insuficiência aórtica causa pulsos AMPLOS e céleres (martelo d''água) em todo o corpo, o oposto de pulsos reduzidos e assimétricos em membros inferiores.
• E) A tetralogia de Fallot cursa com cianose (por shunt direita-esquerda) e sopro de estenose pulmonar, um quadro clínico completamente diferente do descrito, sem relação com esse padrão de pulsos ou com erosões costais.'
where id = '3e4ceee7-1990-444b-9e64-0277cfd5cdba';

update public.questions set comentario_completo = 'A coarctação da aorta cursa com hipertensão em membros superiores (a braquial de 150 mmHg) e pulsos/pressão reduzidos em membros inferiores — aqui evidenciado pela pressão poplítea de 135 mmHg, MENOR que a braquial, quando o esperado fisiologicamente é que a pressão poplítea seja igual ou até um pouco MAIOR que a braquial (efeito de amplificação distal do pulso). Some-se a isso o sopro sistólico interescapular, gerado pelo fluxo turbulento através do segmento estreitado da aorta, e o quadro de cefaleia (hipertensão cefálica) com fraqueza de pernas aos esforços (hipoperfusão relativa dos membros inferiores) fecha o diagnóstico.

Por que as outras alternativas estão incorretas:
• B) A síndrome de Marfan predispõe a aneurismas e dissecção aórtica, mas não explica esse gradiente específico de pressão entre membros superiores e inferiores, nem é sua apresentação típica.
• C) A doença de Kawasaki é uma vasculite de artérias coronárias que acomete predominantemente crianças pequenas, sem relação com esse quadro de hipertensão de membros superiores e claudicação.
• D) A dissecção aórtica aguda cursa com dor torácica ou dorsal súbita e intensa (lancinante), um quadro agudo e dramático — não uma cefaleia insidiosa com fraqueza crônica nas pernas aos esforços.
• E) Um aneurisma de aorta descendente isolado não costuma gerar esse gradiente de pressão entre os membros nem o sopro interescapular característico da coarctação (que decorre de um estreitamento, não de uma dilatação).'
where id = '1756e645-84fa-4c35-9554-0abd96449051';

-- ============================================================
-- Tema: Ausculta
-- ============================================================

update public.questions set comentario_completo = 'O sopro diastólico aspirativo em foco aórtico acessório é característico de insuficiência aórtica. O rufiar diastólico mitral associado (sopro de Austin-Flint) resulta do jato regurgitante da aorta que impede a abertura plena da valva mitral durante a diástole, simulando uma estenose mitral — mas sem que haja estenose mitral verdadeira. É exatamente por isso que faltam os achados típicos de estenose mitral orgânica: não há estalido de abertura (que depende de uma valva mitral doente e ainda móvel, mas com abertura em "tenda") nem reforço pré-sistólico (que depende de um gradiente diastólico real entre átrio e ventrículo esquerdos mantido até o fim da diástole).

Por que as outras alternativas estão incorretas:
• A) Estenose mitral importante teria estalido de abertura logo após B2 e sopro em ruflar com reforço pré-sistólico bem definido — achados que o enunciado explicitamente descreve como AUSENTES.
• C) Insuficiência mitral importante geraria um sopro HOLOSSISTÓLICO em foco mitral irradiado para a axila, não um sopro diastólico aspirativo em foco aórtico acessório como o descrito.
• D) A combinação com estenose mitral exigiria os achados típicos dela (estalido, reforço pré-sistólico), que estão ausentes no caso — não há dado que sustente uma dupla lesão.
• E) Dupla lesão mitral (estenose com insuficiência) também dependeria de sinais mitrais específicos não descritos; o quadro é puramente de válvula aórtica.'
where id = '5d093e78-bf06-47e8-94ae-718e685e44c6';

update public.questions set comentario_completo = 'Pulso célere (em martelo d''água, de ascensão rápida e colapso igualmente rápido) e pressão de pulso alargada/divergente (152 x 60 mmHg) são clássicos da insuficiência aórtica importante. O sopro mesossistólico em base reflete o alto fluxo anterógrado que atravessa a valva aórtica mesmo sem estenose (fluxo aumentado pelo volume regurgitante que retorna e soma-se ao débito normal), e o sopro holodiastólico aspirativo em borda esternal esquerda confirma a regurgitação propriamente dita. O íctus desviado, hiperdinâmico e "em três polpas" reflete a sobrecarga crônica de volume do ventrículo esquerdo.

Por que as outras alternativas estão incorretas:
• A) "Dupla disfunção aórtica discreta" contradiz a intensidade dos achados descritos (pulso célere e amplo, PA muito divergente, íctus hiperdinâmico), que indicam doença relevante, não discreta, e não há evidência de estenose associada (não há sopro em diamante com irradiação para carótidas).
• C) Estenose mitral grave cursaria com B1 hiperfonética, estalido de abertura e sopro diastólico em ruflar no ápice — nenhum desses achados foi descrito; o exame é predominantemente de válvula aórtica.
• D) "Dupla lesão mitral discreta" também exigiria achados mitrais específicos ausentes no caso.
• E) Estenose aórtica geraria pulso PARVUS ET TARDUS (lento e de baixa amplitude) — o oposto do pulso célere e amplo descrito no paciente.'
where id = 'af2d8d08-1b98-408b-8a75-73f2fb4a06df';

update public.questions set comentario_completo = 'Na insuficiência mitral primária importante e crônica, a sobrecarga volumétrica progressiva do átrio e do ventrículo esquerdos, ao longo do tempo, transmite-se retrogradamente à circulação pulmonar, levando a hipertensão pulmonar e, na evolução mais avançada, a sinais de insuficiência cardíaca DIREITA (turgência jugular, hepatomegalia, edema) — mesmo sendo uma doença de origem em câmaras esquerdas.

Por que as outras alternativas estão incorretas:
• A) O ictus normal se localiza no 4º espaço intercostal, linha hemiclavicular — na IM importante, pela sobrecarga de volume do VE, o ictus se desloca para BAIXO e para a ESQUERDA/lateralmente (geralmente 6º espaço ou mais, linha axilar), não permanece nessa posição habitual.
• B) Um sopro sistólico regurgitativo de intensidade LEVE (<+++/6+) é incompatível com IM classificada como "importante", que tipicamente produz sopro mais intenso (≥3+/6+, muitas vezes com frêmito palpável).
• D) B1 hiperfonética é achado típico de ESTENOSE mitral (folhetos ainda móveis se fechando com força); na insuficiência mitral, B1 tende a ser normal ou hipofonética, não hiperfonética.
• E) B2 hipofonética não é um achado esperado ou característico da insuficiência mitral isolada.'
where id = '360b0578-2837-4b0b-bb2a-200b7b6610c8';

update public.questions set comentario_completo = 'Um sopro MESOSSISTÓLICO suave (até 2+/6+), isolado, em paciente assintomático e sem outros achados de alerta, costuma ser funcional/inocente (sopro de hiperfluxo, comum e benigno) e não requer investigação ecocardiográfica de rotina. Isso porque os sopros mesossistólicos leves refletem, na maioria das vezes, apenas o fluxo normal de sangue através de câmaras e valvas estruturalmente saudáveis, sem turbulência patológica relevante.

Por que as outras alternativas estão incorretas:
• B) Sopro PROTOSSISTÓLICO (logo no início da sístole) costuma indicar comunicação interventricular pequena/restritiva ou regurgitação tricúspide leve — ambas alterações estruturais que justificam avaliação.
• C) Sopro HOLOSSISTÓLICO (ocupando toda a sístole) é sempre patológico — indica regurgitação mitral, tricúspide ou comunicação interventricular, e sempre merece investigação.
• D) Sopro TELESSISTÓLICO (no final da sístole) está associado classicamente a prolapso da valva mitral, merecendo avaliação ecocardiográfica.
• E) Sopro PRÉ-SISTÓLICO é, na prática, sempre um sopro diastólico tardio de estenose mitral — acompanhado de reforço pela contração atrial —, sempre patológico e indicando investigação.'
where id = '4057ecca-716c-4c63-a774-4292b9aacda5';

update public.questions set comentario_completo = 'B1 hiperfonética, estalido de abertura muito próximo de B2 e sopro mesodiastólico que se intensifica com a expiração caracterizam estenose mitral (quanto mais grave a estenose, mais próximo de B2 fica o estalido — maior o gradiente atrioventricular esquerdo). P2 mais intensa que A2 indica hipertensão pulmonar associada, uma consequência esperada da estenose mitral crônica e significativa. E o sopro sistólico que se intensifica especificamente com a INSPIRAÇÃO (sinal de Rivero-Carvallo, positivo para lesões de câmaras direitas) indica insuficiência tricúspide associada — provavelmente secundária à dilatação do VD por hipertensão pulmonar crônica.

Por que as outras alternativas estão incorretas:
• A) "Estenose mitral LEVE" não combina com B1 hiperfonética marcante, estalido muito próximo de B2 e P2 aumentada — esses achados, em conjunto, sugerem doença mais avançada (grave), não leve.
• B) "Dupla lesão mitral com predomínio de insuficiência" exigiria um sopro sistólico holossistólico em foco mitral irradiado para axila, que não é mencionado — o quadro descrito é puramente de estenose e suas repercussões.
• D) "Predomínio de estenose" na dupla lesão mitral pressupõe a presença concomitante de algum grau de insuficiência mitral (sopro sistólico em foco mitral), que não foi descrita no caso.
• E) O ventrículo esquerdo aqui está com impulsão de DIFÍCIL PALPAÇÃO (hipoatuante) — o oposto do que se espera numa insuficiência mitral grave, que cursaria com VE hiperdinâmico; além disso, B1 hiperfonética e estalido de abertura não são achados de insuficiência mitral.'
where id = '3c7b69d5-9f09-46ea-84b1-d578c9521df1';

update public.questions set comentario_completo = 'A quarta bulha (B4) é gerada pela contração atrial vigorosa empurrando sangue contra um ventrículo pouco complacente ("rígido"), refletindo pressões de enchimento ventricular elevadas — um achado comum na hipertrofia ventricular esquerda por hipertensão arterial crônica ou por estenose aórtica, condições em que a parede do VE se torna espessada e menos complacente ao enchimento diastólico.

Por que as outras alternativas estão incorretas:
• A) No desdobramento fisiológico de B2, o componente AÓRTICO (A2) antecede o pulmonar (P2) — é o VE que termina a ejeção primeiro; a alternativa inverte essa ordem.
• C) É a primeira bulha (B1) que coincide, aproximadamente, com o início do pulso carotídeo (marca o começo da sístole ventricular) — a segunda bulha (B2) marca o FIM da sístole, não uma coincidência com o pulso carotídeo.
• D) A terceira bulha (B3) é um som PROTODIASTÓLICO (logo no início da diástole, pelo enchimento ventricular rápido), mais audível no foco MITRAL/ápice — descrevê-la como "protossistólica" e do foco aórtico acessório inverte tanto o tempo do ciclo cardíaco quanto o local de melhor ausculta.
• E) A segunda bulha (B2) costuma ter duração mais CURTA e tom mais agudo que a primeira bulha (B1), que é mais prolongada e de tom mais grave — a alternativa inverte essa relação.'
where id = '139fc49e-52ce-4a1b-ab94-8da41d2a14e8';

update public.questions set comentario_completo = 'A terceira bulha fisiológica resulta do relaxamento diastólico ATIVO e vigoroso do ventrículo esquerdo, que acelera o enchimento ventricular precoce logo após a abertura da valva mitral. Esse relaxamento potente e a desaceleração súbita do sangue que entra rapidamente no ventrículo geram uma vibração audível — a B3 —, achado comum em corações jovens e hiperdinâmicos (crianças, adolescentes, atletas, gestantes), justamente por sua maior complacência e vigor de relaxamento miocárdico, sem significar doença nesses casos.

Por que as outras alternativas estão incorretas:
• A) "Enchimento mais tardio contra um gradiente de pressão" descreve um mecanismo de B3 PATOLÓGICA (como na insuficiência cardíaca, em que o enchimento encontra resistência), não da B3 fisiológica de indivíduos jovens e saudáveis.
• C) "Equalização da pressão no átrio e ventrículo" não é o mecanismo gerador da B3 — a B3 se origina da desaceleração do FLUXO de enchimento rápido, não de uma simples igualdade de pressões entre as câmaras.
• D) "Parada rápida do enchimento diastólico" descreve, na verdade, um conceito mais associado à gênese da quarta bulha ou de fenômenos de complacência reduzida, não da B3 fisiológica.
• E) "Início da contração atrial" é o mecanismo gerador da QUARTA bulha (B4), não da terceira.'
where id = '9445b795-230d-4eda-8774-deff58ac6e81';

update public.questions set comentario_completo = 'O desdobramento FIXO da segunda bulha (que não varia com a respiração, ao contrário do desdobramento fisiológico) é o achado clássico da comunicação interatrial (CIA): o shunt esquerda-direita crônico sobrecarrega de volume o átrio e o ventrículo direitos de forma constante, "igualando" o comportamento respiratório dos dois lados do coração e fazendo o intervalo entre A2 e P2 permanecer sempre o mesmo. O componente pulmonar (P2) aumentado de intensidade indica hipertensão pulmonar associada, uma complicação da CIA de longa data com hiperfluxo pulmonar mantido.

Por que as outras alternativas estão incorretas:
• A) Persistência do canal arterial (PCA) com hipertensão pulmonar cursaria com sopro CONTÍNUO (sistólico e diastólico) em região infraclavicular esquerda, não com desdobramento fixo de B2 como achado central.
• B) PCA sem hipertensão pulmonar também tem como marca registrada o sopro contínuo em "maquinaria", não o desdobramento fixo de B2.
• C) CIA SEM hipertensão pulmonar não explicaria o "componente pulmonar aumentado" (P2 hiperfonética) descrito no caso, que é justamente o sinal de hipertensão pulmonar associada.
• E) Hipertensão pulmonar primária isolada não produz desdobramento FIXO de B2 (que depende especificamente da sobrecarga de volume do VD por um shunt, típica da CIA) — na HAP primária, o que se destaca é P2 muito hiperfonética, sem necessariamente esse padrão fixo de desdobramento.'
where id = '6e45d53f-8514-45cb-8de1-55f6b452d9cd';

update public.questions set comentario_completo = 'Na isquemia miocárdica aguda podem surgir B3 (por disfunção sistólica transitória), B4 (por redução aguda da complacência ventricular), sopro de regurgitação mitral (por disfunção transitória do músculo papilar isquêmico) e desdobramento paradoxal de B2 (por atraso na contração/ejeção do VE isquêmico). Já o sopro diastólico aspirativo em foco aórtico acessório reflete uma lesão ESTRUTURAL crônica da valva aórtica (insuficiência aórtica orgânica) — não é um achado gerado por um episódio agudo e transitório de isquemia miocárdica, sendo por isso a alternativa correta (a que NÃO se relaciona ao evento anginoso).

Por que as outras alternativas NÃO são a resposta certa (ou seja, PODEM sim ocorrer na isquemia):
• B) A terceira bulha pode surgir por disfunção sistólica transitória do VE isquêmico durante o episódio anginoso.
• C) A quarta bulha pode surgir pela redução aguda da complacência ventricular causada pela isquemia.
• D) O sopro de regurgitação mitral pode surgir por disfunção transitória do músculo papilar durante a isquemia, mesmo sem lesão estrutural da valva.
• E) O desdobramento paradoxal de B2 pode ocorrer pelo atraso transitório na contração do VE isquêmico durante o episódio anginoso.'
where id = '37910bb7-a8d6-4789-9858-8708eb34eeac';

update public.questions set comentario_completo = 'A cardiomiopatia chagásica cursa com dilatação biventricular e disfunção sistólica progressiva. O sopro que se intensifica na INSPIRAÇÃO (sinal de Rivero-Carvallo, positivo para lesões de câmaras direitas) indica insuficiência tricúspide — provavelmente funcional, por dilatação do anel valvar secundária à dilatação do VD. O sopro mitral que aumenta em decúbito lateral esquerdo (posição que aproxima o ápice cardíaco da parede torácica, facilitando a ausculta de fenômenos do VE) indica insuficiência mitral associada, também funcional pela dilatação do VE. Juntos, esses achados configuram um quadro de insuficiência cardíaca de baixo débito (extremidades frias, pulso fino, PA baixa) com dupla regurgitação atrioventricular — mitral e tricúspide.

Por que as outras alternativas estão incorretas:
• A) Não há descrição de sopro sistólico ejetivo em foco aórtico irradiado para carótidas nem de pulso parvus et tardus, achados que se esperariam numa estenose aórtica associada.
• B) "Somente IC esquerda... insuficiência mitral" ignora o sopro que se intensifica na inspiração (Rivero-Carvallo), que é a evidência clínica de acometimento tricúspide/câmaras direitas também presente no caso.
• D) "Somente IC direita com ALTO débito" contradiz tanto o exame físico (extremidades frias e pulso fino são sinais de BAIXO débito, não alto) quanto a presença do sopro mitral, que indica acometimento também de câmaras esquerdas.
• E) "Somente IC esquerda... miocardiopatia" sem citar as valvopatias ignora os dois sopros regurgitantes (mitral e tricúspide) claramente descritos no exame físico.'
where id = 'e71c6f35-e94f-4388-b732-45252d9dbba1';

update public.questions set comentario_completo = 'Sopro sistólico que aumenta com a inspiração (sinal de Rivero-Carvallo — a inspiração aumenta o retorno venoso ao coração direito, intensificando sopros de origem em câmaras direitas), associado a onda "v" proeminente e descenso "y" rápido/decrescente no pulso venoso jugular, é característico de insuficiência tricúspide: o sangue regurgita do VD para o AD durante a sístole, elevando a pressão atrial direita (onda "v" grande) e depois esvaziando rapidamente para o ventrículo relaxado na diástole (descenso "y" rápido).

Por que as outras alternativas estão incorretas:
• A) Estenose aórtica gera sopro sistólico em foco aórtico irradiado para carótidas, sem relação com o padrão de pulso venoso jugular descrito (que reflete o átrio direito, não a valva aórtica).
• B) Insuficiência mitral gera sopro que se irradia para a axila e não varia tipicamente com a respiração — além disso, o padrão de pulso venoso jugular (onda v/y) descrito reflete pressões do átrio DIREITO, não da valva mitral (câmaras esquerdas).
• D) Comunicação interventricular gera sopro holossistólico em borda esternal esquerda baixa, sem essa relação específica com a curva de pulso venoso jugular.
• E) Ruptura de cordoalha tendínea (causa de insuficiência mitral aguda) segue a mesma lógica da alternativa B — sopro mitral, sem a relação descrita com o pulso jugular nem com a variação respiratória.'
where id = 'a190eb39-c32b-4a5f-9f4c-7de0d7ce0534';

update public.questions set comentario_completo = 'Manobras que aumentam o volume ventricular esquerdo — como ficar de cócoras (aumenta o retorno venoso e a pós-carga) — RETARDAM o prolapso da valva mitral: com mais sangue enchendo o ventrículo, os folhetos mitrais demoram mais tempo na sístole para se tornarem redundantes e prolapsarem. Isso afasta o clique mesossistólico de B1 (ele fica mais tardio no ciclo) e encurta a duração do sopro que se segue a ele. O oposto ocorre com manobras que reduzem o volume ventricular (Valsalva, ortostase): o prolapso acontece mais cedo, aproximando o clique de B1 e alongando o sopro.

Por que as outras alternativas estão incorretas:
• A) O sopro fica mais TARDIO (não mais precoce) com o aumento de volume ventricular provocado pela posição de cócoras.
• B) A manobra altera o TEMPO em que o clique ocorre no ciclo cardíaco, não sua intensidade/volume sonoro.
• C) O que se altera é a DURAÇÃO/o momento do sopro (ele encurta, por começar mais tarde), não necessariamente sua intensidade.
• D) O clique sistólico se AFASTA de B1 (fica mais tardio) com o aumento do volume ventricular pela posição de cócoras — o oposto do afirmado.'
where id = '30bb3be6-5483-48a5-a919-dfe19ac6a3b7';

update public.questions set comentario_completo = 'Na insuficiência aórtica grave o pulso é AMPLO e CÉLERE — o clássico pulso "em martelo d''água" (ascensão rápida seguida de colapso igualmente rápido) —, com pressão de pulso divergente/alargada (sistólica alta, diastólica baixa). Descrever o pulso como de "amplitude reduzida e duração prolongada" está errado e na verdade descreve outra condição bem diferente: o pulso PARVUS ET TARDUS da estenose aórtica (lento para subir e de baixa amplitude). Por isso essa é a alternativa INCORRETA pedida na questão.

Por que as outras alternativas estão corretas (não são a resposta, já que a pergunta pede a incorreta):
• B) O sopro diastólico da insuficiência aórtica é de fato aspirativo e decrescente, iniciando-se imediatamente após B2 (assim que a valva aórtica insuficiente permite o refluxo).
• C) O sopro de Austin-Flint de fato corresponde ao impacto do jato regurgitante da IAo sobre o folheto anterior da valva mitral, funcionalmente restringindo sua abertura.
• D) As etiologias citadas (valva bicúspide, síndrome de Marfan, espondilite anquilosante) são, de fato, causas reconhecidas de insuficiência aórtica na literatura.
• E) Os sinais de Quincke (pulsação capilar no leito ungueal) e de Müller (pulsação sistólica da úvula) estão descritos corretamente, sendo achados clássicos (embora pouco sensíveis) de insuficiência aórtica importante.'
where id = '5ab93625-48c8-41e5-951c-57f6fd763592';

update public.questions set comentario_completo = 'O sopro diastólico da insuficiência aórtica de origem VALVAR (doença primária dos folhetos, como valva bicúspide ou sequela reumática) é mais bem audível no 3º/4º espaço intercostal de borda esternal esquerda, o foco aórtico acessório clássico. Quando a insuficiência é secundária à DILATAÇÃO da raiz aórtica (aneurisma, Marfan, dissecção), o jato regurgitante tende a se direcionar mais para a direita, tornando o sopro mais bem audível na borda esternal DIREITA alta — uma pista semiológica útil para sugerir a etiologia provável antes mesmo do ecocardiograma.

Por que as outras alternativas estão incorretas:
• A) Sinal de Müller é o movimento pulsátil da ÚVULA (não da cabeça) a cada batimento — a alternativa descreve o sinal de Musset (movimento da cabeça), trocando as definições.
• B) Sinal de Musset é o movimento da CABEÇA (não pulsações da úvula) sincronizado com os batimentos — de novo, a definição está trocada com a do sinal de Müller.
• C) O "ruído de pistola"/sinal de Traube são batimentos arteriais amplos e curtos auscultados sobre grandes artérias (como a femoral); a manobra de comprimir o antebraço para auscultar um sopro sistólico-diastólico duplo é o sinal de DUROZIEZ, não o de Traube — a alternativa mistura as duas descrições.
• D) Sinal de Quincke é a pulsação CAPILAR visível no LEITO UNGUEAL (unha), não na glote — a alternativa descreve o local errado para esse sinal.'
where id = 'a6a79759-eabd-4087-a399-a4dfca61f11e';

update public.questions set comentario_completo = 'O sopro de Graham-Steell é um sopro diastólico decrescente, de timbre agudo/aspirativo, causado por insuficiência (regurgitação) da valva PULMONAR — geralmente secundária à dilatação do anel valvar pulmonar em contexto de hipertensão pulmonar grave (não por doença primária da própria valva pulmonar). É um dos principais diagnósticos diferenciais do sopro diastólico da insuficiência aórtica, mas se origina do lado direito do coração.

Por que as outras alternativas estão incorretas:
• A) A estenose aórtica gera sopro SISTÓLICO (ejetivo, em diamante), não o sopro diastólico descrito.
• B) A insuficiência mitral gera sopro sistólico (holossistólico), com timbre e tempo do ciclo cardíaco diferentes do sopro de Graham-Steell.
• C) A estenose tricúspide gera sopro diastólico, mas em foco TRICÚSPIDE, com características de ruflar (semelhante à estenose mitral) — não o sopro aspirativo decrescente descrito, que é típico de regurgitação, não de estenose.
• D) A insuficiência aórtica gera um sopro diastólico de timbre muito semelhante (é o principal diagnóstico diferencial acústico), mas tem origem na valva AÓRTICA, não na pulmonar — a etiologia por hipertensão pulmonar é o que define especificamente o Graham-Steell.'
where id = '501a077b-7e5a-44b9-84b4-a98841ee785a';

update public.questions set comentario_completo = 'O esforço isométrico (manobra de handgrip — apertar a mão com força sustentada) aumenta a resistência vascular periférica (a pós-carga do ventrículo esquerdo), o que dificulta a ejeção anterógrada de sangue e favorece o refluxo através de valvas incompetentes. Por isso, essa manobra intensifica sopros de REGURGITAÇÃO, como a insuficiência mitral e a insuficiência aórtica — mais sangue "escolhe" o caminho de menor resistência, que é regurgitar pela valva doente, em vez de vencer a maior resistência periférica.

Por que as outras alternativas estão incorretas:
• A) O sopro de Graham-Steell decorre de regurgitação PULMONAR (associada a hipertensão pulmonar), não de regurgitação aórtica.
• B) O sopro da estenose mitral é DIASTÓLICO (em ruflar, com reforço pré-sistólico em ritmo sinusal) — descrevê-lo como "sistólico" está incorreto, mesmo mantendo a parte certa sobre o reforço pré-sistólico.
• D) A oclusão simultânea das artérias braquiais com dois manguitos insuflados, na verdade, AUMENTA a resistência periférica e tende a acentuar (não reduzir) o sopro de uma CIV com shunt esquerda-direita, por dificultar ainda mais a via de saída sistêmica.
• E) O sopro de insuficiência tricúspide se acentua na INSPIRAÇÃO (sinal de Rivero-Carvallo), não na expiração — a expiração, ao contrário, tende a acentuar sopros de câmaras ESQUERDAS.'
where id = '1500875c-0a77-471c-be2f-01fe3494d73e';

update public.questions set comentario_completo = 'Sopro sistólico com irradiação para a axila, que NÃO varia com o ciclo respiratório (característica de lesão de câmaras ESQUERDAS, ao contrário das lesões direitas, que variam com a respiração pelo sinal de Rivero-Carvallo) e que se INTENSIFICA com a manobra de handgrip (o aumento de pós-carga/resistência periférica favorece o refluxo por uma valva regurgitante), é o quadro típico de insuficiência mitral. O íctus desviado e propulsivo e a terceira bulha completam o quadro de sobrecarga de volume crônica do ventrículo esquerdo.

Por que as outras alternativas estão incorretas:
• A) Estenose aórtica gera sopro sistólico EJETIVO (em diamante) no foco aórtico, irradiado para as carótidas — não para a axila —, sem essa característica de intensificação com handgrip da mesma forma (na verdade, na EAo grave o handgrip pode até reduzir discretamente o sopro, ao aumentar a pós-carga contra uma via de saída já fixa).
• B) Insuficiência aórtica gera sopro DIASTÓLICO (aspirativo), não sistólico como o descrito.
• C) Insuficiência tricúspide teria sopro que VARIA com a respiração (se intensifica na inspiração — sinal de Rivero-Carvallo), o oposto do que a questão descreve ("não se altera com o ciclo respiratório").
• D) Cardiomiopatia hipertrófica obstrutiva tem sopro que tipicamente AUMENTA com manobras que reduzem o volume ventricular (Valsalva, ortostase) e DIMINUI com o handgrip — exatamente o oposto do comportamento descrito no caso.'
where id = 'e2255aff-f60a-4982-a60d-8c866d6bf44d';

update public.questions set comentario_completo = 'O sopro sistólico em crescendo-decrescendo (formato "em diamante"), com pico tardio, rude e irradiado para carótidas e fúrcula, é o quadro clássico de estenose aórtica — e o pico tardio, em especial, já sugere gravidade (quanto mais grave a estenose, mais tempo o VE leva para gerar o gradiente máximo de pressão contra a via de saída obstruída). O componente ouvido no foco mitral, com timbre "piante" e que NÃO se intensifica em decúbito lateral esquerdo (ou seja, não se comporta como um verdadeiro sopro mitral, que se intensificaria nessa posição), corresponde à irradiação dos componentes de alta frequência do próprio sopro aórtico para o ápice — o fenômeno de Gallavardin —, e não a uma valvopatia mitral associada.'
where id = 'edd15d37-964f-42b5-83ce-bd5f344b5641';

update public.questions set comentario_completo = 'Após uma extrassístole, ocorre uma pausa compensatória que aumenta o tempo de enchimento diastólico do ventrículo esquerdo, elevando o volume de sangue disponível para ejeção no batimento seguinte. Numa via de saída fixa e obstruída, como na estenose aórtica, esse maior volume gera um gradiente de pressão maior e, portanto, um sopro mais intenso nesse batimento pós-extrassistólico — fenômeno chamado de potenciação pós-extrassistólica, útil clinicamente para diferenciar estenose aórtica (sopro aumenta) de sopros de regurgitação como a insuficiência mitral (o sopro não se modifica de forma relevante, pois a regurgitação depende mais da área do orifício incompetente do que do volume ventricular).'
where id = '227784d3-780f-4b20-81ac-aa848866c547';

update public.questions set comentario_completo = 'Quanto mais grave a estenose aórtica, mais TARDIO — e não mais precoce — é o pico de intensidade do sopro em crescendo-decrescendo. Isso ocorre porque, com uma via de saída mais obstruída, o ventrículo esquerdo precisa de mais tempo dentro da sístole para gerar o gradiente pressórico máximo entre o VE e a aorta; por isso, o pico do sopro "atrasa" dentro do ciclo sistólico à medida que a estenose se agrava. É essa a alternativa ERRADA pedida na questão.

Por que as outras alternativas estão corretas (não são a resposta, já que a pergunta pede a errada):
• A) O pulso carotídeo parvus et tardus (baixa amplitude, ascensão lenta e pico tardio) é, de fato, achado clássico da estenose aórtica grave.
• B) A segunda bulha de fato se torna mais hipofonética à medida que a valva aórtica se calcifica e perde mobilidade — quanto mais grave, mais acentuada a hipofonese.
• D) O fenômeno de Gallavardin (irradiação dos componentes agudos do sopro aórtico para o ápice, simulando sopro de regurgitação mitral) está descrito corretamente.
• E) O sopro sistólico aórtico de fato aumenta na posição de cócoras (maior retorno venoso e volume ejetado através da via de saída obstruída).'
where id = 'ed67fbc4-9cca-447b-907b-7bac440f4c0e';

update public.questions set comentario_completo = 'A descrição correta da estenose mitral reúne: hiperfonese de primeira bulha (folhetos ainda móveis se fechando com força contra o gradiente), estalido de abertura mitral (abertura brusca dos folhetos ainda flexíveis, mas restritos), sopro diastólico em ruflar com reforço pré-sistólico (quando em ritmo sinusal, pela contração atrial adicionando fluxo no fim da diástole) e segunda bulha hiperfonética — especificamente seu componente pulmonar — quando há hipertensão pulmonar associada, uma consequência comum da estenose mitral avançada.

Observação sobre o gabarito: o material original indicava a alternativa E como correta, mas ela não descreve a estenose mitral (mistura elementos de outras valvopatias); a alternativa B é a que reúne corretamente os achados clássicos da doença, e foi essa a usada como resposta. Se você tiver o gabarito oficial e discordar, verifique a fonte original.

Por que as outras alternativas estão incorretas:
• A) Atribui à fibrilação atrial um "sopro sistólico em ruflar" — o sopro da EM é DIASTÓLICO, não sistólico; além disso, na fibrilação atrial o reforço pré-sistólico desaparece (por falta de contração atrial coordenada), o que a alternativa não leva em conta.
• C) Descreve "sopro diastólico aspirativo" e "reforço pré-diastólico" — termos que não correspondem à EM: o sopro da EM é em RUFLAR (grave, rombo), não aspirativo (agudo, este é típico da insuficiência aórtica); "reforço pré-diastólico" também não é o termo correto (é pré-sistólico).
• D) Descreve "sopro sistodiastólico com desdobramento fixo de B2" — isso lembra muito mais uma comunicação interatrial do que uma estenose mitral.
• E) Descreve "sopro sistólico ejetivo irradiado para axila com B2 hiperfonética" — esse padrão lembra insuficiência mitral ou estenose aórtica, não a estenose mitral.'
where id = '73837f19-84ca-4902-a10b-f1bf08d5f64b';

update public.questions set comentario_completo = 'O fenômeno de Gallavardin ocorre na estenose aórtica CALCIFICADA (mais comum em idosos), quando os componentes de alta frequência (agudos) do sopro sistólico ejetivo se irradiam preferencialmente para o ápice cardíaco, podendo simular acusticamente um sopro de regurgitação mitral — daí a importância de reconhecê-lo, para não confundir uma estenose aórtica com uma insuficiência mitral associada que não existe.

Por que as outras alternativas estão incorretas:
• A) Atresia tricúspide é uma cardiopatia congênita cianótica complexa, sem relação com esse fenômeno acústico específico de irradiação de sopro.
• B) Estenose pulmonar gera sopro ejetivo no foco PULMONAR, sem a irradiação característica para o ápice que define o Gallavardin.
• C) Insuficiência pulmonar gera o sopro de Graham-Steell (diastólico), um mecanismo e tempo do ciclo cardíaco diferentes do fenômeno de Gallavardin.
• E) Dupla lesão mitral com predomínio de estenose tem sua própria ausculta característica (estalido, ruflar diastólico), sem relação com esse fenômeno de irradiação específico da estenose aórtica.'
where id = '6b4b79c2-b204-423c-8df8-261af4088fa0';

update public.questions set comentario_completo = 'Quanto mais grave a estenose mitral (maior o gradiente de pressão entre átrio esquerdo e ventrículo esquerdo), MENOR — e não maior — é o intervalo entre B2 e o estalido de abertura mitral: a pressão atrial muito elevada empurra os folhetos mitrais a se abrirem quase imediatamente após o fechamento da valva aórtica/pulmonar (B2), encurtando esse intervalo. Um intervalo B2-estalido mais curto é, portanto, sinal de doença mais grave — o inverso do que a alternativa (incorretamente) afirma como proporcionalidade direta. Por isso essa é a EXCEÇÃO pedida na questão.

Por que as outras alternativas NÃO são a exceção (ou seja, são verdadeiras na estenose mitral grave):
• B) A hiperfonese de P2 em foco pulmonar é, de fato, indicativa de hipertensão pulmonar associada — uma complicação esperada da EM grave e duradoura.
• C) O sopro da estenose mitral é de fato HOLODIASTÓLICO nos casos mais graves (ocupa toda a diástole, refletindo um gradiente sustentado durante todo esse período).
• D) Sinais de insuficiência cardíaca direita (congestão sistêmica) são, de fato, esperados na EM grave, secundários à hipertensão pulmonar crônica.
• E) A intensidade de B1 pode de fato se REDUZIR nos casos mais avançados e calcificados, quando os folhetos perdem mobilidade — é um achado aceito, especialmente em fases tardias da doença.'
where id = '3c2acc85-9020-4edd-8c22-beb121a68025';

update public.questions set comentario_completo = 'Pulso carotídeo "parvus et tardus" (de baixa amplitude e ascensão lenta, com pico tardio) associado a sopro sistólico em crescendo-decrescendo, com pico tardio e irradiado para as carótidas, é o quadro clássico de estenose aórtica — a dispneia progressiva reflete a repercussão hemodinâmica da obstrução na via de saída do ventrículo esquerdo.

Por que as outras alternativas estão incorretas:
• A) Estenose mitral não altera o pulso carotídeo (arterial) — seu impacto é sobre a curva de pulso venoso e o enchimento do VE, não sobre a ejeção sistólica que gera o pulso carotídeo.
• C) Insuficiência mitral gera pulso arterial normal ou até hiperdinâmico (pela ejeção facilitada por uma via de "escape" para o átrio), não parvus et tardus, e o sopro se irradia para a axila, não para as carótidas.
• D) Insuficiência tricúspide gera sopro em borda esternal esquerda baixa que varia com a respiração, sem relação com o pulso carotídeo ou irradiação para carótidas.
• E) Comunicação intraventricular (CIV) sem hipertensão pulmonar grave gera sopro holossistólico em borda esternal esquerda, com pulso arterial tipicamente normal.'
where id = 'e6512aad-3cbd-4fc6-90c1-9e79d76faa34';

update public.questions set comentario_completo = 'O sopro de Carey Coombs é um sopro MESODIASTÓLICO mitral (e não sistólico) causado por valvulite ativa na fase aguda da febre reumática — a inflamação dos folhetos mitrais gera um fluxo turbulento durante o enchimento diastólico, mesmo sem uma estenose mitral orgânica estabelecida. Por isso a alternativa que o descreve como um sopro "sistólico" está incorreta, sendo essa a resposta buscada na questão.

Por que as outras alternativas estão corretas (não são a resposta, já que a pergunta pede a errada):
• A) O sopro de Graham-Steell de fato decorre de regurgitação da valva pulmonar por hipertensão pulmonar — descrição correta.
• C) O sopro de Austin-Flint de fato é mais audível no ápice, gerado pelo jato de regurgitação aórtica colidindo com o folheto anterior da mitral ou a parede livre do VE — descrição correta.
• D) Um mixoma atrial de fato pode determinar sopro diastólico mitral, ao se comportar como uma "bola-valva" que obstrui intermitentemente o orifício mitral, mimetizando estenose mitral.
• E) Na síndrome de Marfan, a dilatação da artéria pulmonar pode, de fato, ocasionalmente causar regurgitação pulmonar — descrição aceita, ainda que menos comum que o acometimento aórtico.'
where id = 'adf4eb34-07a9-45c1-aa9f-1ca43b497584';

update public.questions set comentario_completo = 'Na cardiomiopatia hipertrófica obstrutiva, manobras que REDUZEM o volume ventricular esquerdo — como a fase de esforço da manobra de Valsalva (reduz o retorno venoso) — aumentam a obstrução dinâmica da via de saída do VE: com menos sangue dentro do ventrículo, o septo hipertrofiado e o folheto anterior da mitral (por movimento sistólico anterior, SAM) se aproximam ainda mais, estreitando a via de saída e intensificando o sopro. Esse comportamento é o OPOSTO do observado na estenose aórtica valvar fixa, em que reduzir o volume ventricular não altera (ou até discretamente reduz) o sopro, já que a obstrução ali é uma área fixa e não dinâmica.

Por que as outras alternativas estão incorretas:
• B) A posição de agachamento (cócoras) AUMENTA o retorno venoso e o volume ventricular, o que REDUZ (não acentua) a obstrução dinâmica e a intensidade do sopro na CMH — o oposto do afirmado.
• C) Pulso paradoxal não é um achado característico da cardiomiopatia hipertrófica; está muito mais associado a tamponamento cardíaco e doenças pericárdicas/pulmonares.
• D) O pulso PARVUS ET TARDUS é característico da estenose aórtica FIXA; na CMH obstrutiva, o pulso costuma ser bisferiens (dois picos), de ascensão inicial rápida — por isso essa característica não é o que diferencia as duas condições da forma descrita.
• E) O movimento sistólico anterior (SAM) da valva mitral, presente na CMH obstrutiva, é o que GERA o próprio sopro sistólico obstrutivo — ele não está associado ao surgimento de um sopro diastólico adicional.'
where id = '828285b3-dc0b-46ea-a5e6-2c50153303d7';

update public.questions set comentario_completo = 'O reforço pré-sistólico do sopro da estenose mitral depende de uma contração atrial efetiva e coordenada, que empurra um volume extra de sangue através da valva estreitada bem no fim da diástole. Na fibrilação atrial, não existe mais essa contração atrial organizada — o átrio apenas "treme" (fibrila) — e por isso esse reforço pré-sistólico DESAPARECE. Descrever esse reforço como um achado "frequentemente percebido" em pacientes fibrilados está incorreto, sendo essa a resposta buscada na questão.

Por que as outras alternativas estão corretas (não são a resposta, já que a pergunta pede a incorreta):
• A) A fácies mitral (manchas/eritema malar arroxeado) é, de fato, um achado clássico descrito na estenose mitral avançada, por vezes associada a nanismo e caquexia em casos muito antigos/graves.
• B) Situações hiperdinâmicas como anemia, infecção e estresse emocional de fato podem aumentar o fluxo transmitral e descompensar sintomas de dispneia mesmo sem mudança na área valvar medida ao ecocardiograma — gerando essa discordância clínico-ecocardiográfica descrita.
• D) Síndrome carcinoide e lúpus eritematoso sistêmico são, de fato, causas raras e reconhecidas (mas não as mais comuns, que são reumáticas/degenerativas) de estenose mitral.
• E) Insuficiência mitral moderada a importante associada é, de fato, uma contraindicação relativa ao procedimento percutâneo (valvoplastia mitral por balão), que só trata o componente de estenose.'
where id = 'c059e438-e905-49d7-a38b-343909549944';

update public.questions set comentario_completo = 'A quarta bulha (B4) é gerada pela contração atrial vigorosa empurrando sangue contra um ventrículo pouco complacente ("rígido"), refletindo pressões de enchimento elevadas do ventrículo esquerdo — achado comum em condições que espessam e enrijecem a parede do VE, como hipertrofia por hipertensão arterial crônica ou estenose aórtica.

Por que as outras alternativas estão incorretas:
• A) No desdobramento fisiológico de B2, o componente AÓRTICO (A2) antecede o pulmonar (P2) — a alternativa inverte essa ordem.
• C) É a primeira bulha (B1) que coincide, aproximadamente, com o início do pulso carotídeo — não a segunda bulha (B2), que marca o fim, não o início, da sístole ventricular.
• D) A terceira bulha (B3) é um som PROTODIASTÓLICO (não protossistólico), mais audível no foco MITRAL/ápice, não no foco aórtico acessório — a alternativa erra tanto o tempo do ciclo cardíaco quanto o local.
• E) A segunda bulha (B2) tem duração mais CURTA que a primeira bulha (B1), e não maior — a alternativa inverte essa relação.'
where id = 'cd2c15c8-a428-48a5-99c5-f0c337e72f98';

update public.questions set comentario_completo = 'Na estenose mitral, B1 costuma ser HIPERFONÉTICA (e não hipofonética) na maior parte da evolução da doença, pois os folhetos ainda móveis se fecham com força contra o gradiente de pressão aumentado — só em casos muito avançados e com calcificação/imobilidade extrema dos folhetos é que B1 pode perder essa hiperfonese. Por isso, descrever "B1 e B2 hipofonéticas" como achado esperado na estenose mitral importante não corresponde ao padrão típico da doença, sendo essa a EXCEÇÃO pedida na questão.

Por que as outras alternativas NÃO são a exceção (ou seja, são achados esperados na EM importante):
• A) Um estalido de abertura mais precoce (mais próximo de B2) é achado esperado e indica maior gravidade (maior gradiente atrioventricular esquerdo).
• C) O sopro diastólico em ruflar com reforço pré-sistólico (em ritmo sinusal) é o achado auscultatório clássico e central da estenose mitral.
• D) Sinais de congestão pulmonar são esperados pela dificuldade de esvaziamento do átrio esquerdo, que se transmite retrogradamente aos pulmões.
• E) Sinais de insuficiência cardíaca direita são esperados na doença avançada, secundários à hipertensão pulmonar crônica gerada pela congestão retrógrada.'
where id = 'cdb77732-1bf9-4682-8b34-c4b13cc2570c';

update public.questions set comentario_completo = 'Sopro holodiastólico aspirativo com B2 hipofonética, ruflar diastólico (sopro de Austin-Flint) e pulso em martelo d''água são sinais diretamente ligados à quantidade de sangue que regurgita e, portanto, marcadores reconhecidos de GRAVIDADE da insuficiência aórtica. Já a piora do sopro com a manobra de handgrip é um comportamento INESPECÍFICO, comum a praticamente qualquer sopro de regurgitação (mitral, aórtica) — reflete apenas o aumento geral da pós-carga/resistência periférica, e não é, por si só, um marcador específico de gravidade da insuficiência aórtica. Por isso essa é a exceção pedida.

Por que as outras alternativas NÃO são a exceção (ou seja, são de fato sinais de gravidade da IAo):
• B) Sopro holodiastólico aspirativo, decrescente, com B2 hipofonética indica maior volume regurgitante e/ou comprometimento da própria valva aórtica — sinal de gravidade.
• C) Sopro mesossistólico (de hiperfluxo) mais intenso reflete maior volume total ejetado (soma do débito normal com o volume regurgitante que retorna), acompanhando a gravidade.
• D) O ruflar diastólico (Austin-Flint) tende a ser mais proeminente quanto maior o volume e a velocidade do jato regurgitante, sendo também associado a maior gravidade.
• E) O pulso em martelo d''água (célere e amplo) é tanto mais evidente quanto maior o volume regurgitante e a pressão de pulso divergente — sinal clássico de gravidade.'
where id = '2347ad26-c072-4c2a-8f85-9dc1ec0499d1';

update public.questions set comentario_completo = 'Na insuficiência mitral acentuada, o ictus cordis se desloca para BAIXO e para a ESQUERDA (e não "para cima") — um reflexo direto da sobrecarga crônica de volume do ventrículo esquerdo, que se dilata e desloca sua ponta lateral e inferiormente na parede torácica. Descrevê-lo como deslocado "para cima" contraria a fisiopatologia da sobrecarga volumétrica do VE, sendo essa a EXCEÇÃO (a alternativa incorreta) pedida na questão.

Por que as outras alternativas NÃO são a exceção (ou seja, são corretas):
• A) A convenção de graduação de sopros de fato associa frêmito palpável a intensidades igual ou superior a 4+ em 6 — descrição correta.
• B) O pulso em martelo d''água de fato está relacionado à insuficiência aórtica acentuada (pulso célere e amplo) — descrição correta.
• D) O sopro de Austin-Flint de fato não é um indicador preciso/quantitativo da gravidade da insuficiência aórtica, podendo estar presente em graus variados da doença — descrição correta.
• E) Um ictus cordis normal com diâmetro de até cerca de 2 cm é, de fato, a descrição semiológica aceita para o exame físico normal.'
where id = '68eae4bd-9775-414e-aedd-5858b2c99f45';

update public.questions set comentario_completo = 'O sopro de Austin-Flint é um ruflar MESODIASTÓLICO (por vezes com reforço pré-sistólico associado), auscultado no ápice cardíaco em pacientes com insuficiência aórtica importante. Ele é gerado pelo jato de regurgitação aórtica colidindo com o folheto anterior da valva mitral (ou com a parede livre do ventrículo esquerdo), o que restringe funcionalmente a abertura mitral durante a diástole — mimetizando, na ausculta, uma estenose mitral, mesmo sem que exista doença orgânica da valva mitral.

Por que as outras alternativas estão incorretas:
• B) "Sistólico precoce" não corresponde à classificação temporal do Austin-Flint, que ocorre na DIÁSTOLE (mesodiastólico), não na sístole.
• C) "Pré-sistólico" isoladamente não é a classificação correta — o componente pré-sistólico pode estar presente como reforço adicional, mas a classificação central do sopro é mesodiastólica.
• D) "Holossistólico" descreveria um sopro de regurgitação (mitral, por exemplo) ocupando toda a sístole — tempo do ciclo cardíaco incorreto para o Austin-Flint.
• E) "Diastólico precoce" descreveria melhor o próprio sopro aspirativo da insuficiência aórtica (que começa logo após B2), não o ruflar mesodiastólico do Austin-Flint, que ocorre um pouco mais tarde na diástole.'
where id = '3730b050-20ab-4666-9421-5f67a64f2578';

update public.questions set comentario_completo = 'No bloqueio de ramo esquerdo (BRE), o atraso na ativação elétrica do ventrículo esquerdo retarda o fechamento da valva aórtica, fazendo com que o componente pulmonar (P2) preceda o aórtico (A2) — o inverso da ordem fisiológica. É o chamado desdobramento paradoxal, mais evidente na expiração: na inspiração, o atraso fisiológico do P2 se aproxima do A2 (já atrasado pelo BRE) e os sons quase se fundem; na expiração, o P2 volta ao seu tempo normal mais precoce, e o desdobramento reaparece.

Por que as outras alternativas estão incorretas:
• A) Em indivíduos sadios, o componente AÓRTICO (A2) é que precede o pulmonar (P2) — o oposto do afirmado.
• B) Na comunicação interatrial, o desdobramento de B2 é FIXO (não varia com a respiração) — descrevê-lo como "constante e variável" mistura dois conceitos opostos.
• D) O bloqueio de ramo direito (BRD) também tem desdobramento amplo, mas ainda responde à respiração (se acentua na inspiração) — não é fixo e imutável como a CIA.
• E) "Estenose valvar mitral" não tem relação com o desdobramento da segunda bulha, que depende do fechamento das valvas semilunares (aórtica e pulmonar), não da valva mitral.'
where id = '6302c497-7680-4c3c-ab4d-c2d4713f1740';

update public.questions set comentario_completo = 'O diagrama mostra desdobramento amplo de B2 com P2 muito atrasado, compatível com estenose pulmonar significativa (aqui, de uma valva bicúspide) — a obstrução na via de saída do ventrículo direito prolonga o tempo de ejeção desse ventrículo, atrasando bastante o fechamento da valva pulmonar (P2) em relação à aórtica (A2), o que se traduz em um desdobramento amplo e persistente de B2.

Por que as outras alternativas estão incorretas:
• B) Estenose aórtica bicúspide atrasaria o componente AÓRTICO (A2), podendo até gerar desdobramento PARADOXAL (P2 antes de A2) em casos graves — um padrão diferente do atraso isolado de P2 mostrado no diagrama.
• C) Insuficiência mitral crônica e grave não se relaciona ao mecanismo de ejeção do ventrículo direito nem costuma alterar o desdobramento de B2 dessa forma.
• D) Insuficiência tricúspide crônica e grave também não altera classicamente o tempo de ejeção do VD a ponto de atrasar tanto o P2 como mostrado.
• E) Comunicação intraventricular (CIV) sem hipertensão pulmonar grave cursa tipicamente com sopro holossistólico e, quando muito grande, desdobramento amplo mas geralmente variável — não o padrão fixo de atraso isolado do componente pulmonar por obstrução na via de saída, como no diagrama.'
where id = 'ac3c563d-24c5-4a15-8d6f-860fba211e98';
