-- Reescreve o comentário de duas questões:
--  1) SUS-SP 2026 (Bradiarritmia): IC descompensada com CRT-D -> interrogar o dispositivo
--     (explica por que a perda da ressincronização é a suspeita principal).
--  2) TEC 2007 (Saúde Card. da Mulher): primigesta com pré-eclâmpsia, B2 hiperfonética
--     e clique protossistólico (explica a origem dos achados de ausculta).
-- Só altera as colunas comentario e comentario_completo dessas duas linhas.
-- Rode uma vez no SQL Editor do Supabase.

update public.questions set
  comentario = $Q$IC com FE de 20%, CRT-D e piora com congestão apesar de terapia otimizada e boa adesão. O ECG mostra espículas atriais e ventriculares seguidas de QRS, ou seja, há estimulação com captura, mas o QRS é largo e negativo de V1 a V6, que é o padrão de estimulação só do VD. Isso indica que o VE não está sendo ativado pelo dispositivo, ou seja, perdeu a ressincronização (perda de captura do VE). O passo mais direto para confirmar e corrigir é interrogar o dispositivo — alternativa D.$Q$,
  comentario_completo = $Q$Por que o dispositivo é o principal suspeito:
• A paciente tem miocardiopatia dilatada não isquêmica com FE de 20% e já usa os quatro pilares do tratamento (sacubitril/valsartana, carvedilol, espironolactona e empagliflozina), além de furosemida.
• Nega falta de adesão a medicamentos e à dieta, e o enunciado não traz nenhum outro fator desencadeante (nova medicação, infecção, isquemia).
• Ela tem um CRT-D implantado há 6 meses, ou seja, um dispositivo que deveria estar corrigindo a dessincronia. Quando a IC piora sem causa evidente em quem tem CRT, a primeira pergunta é: "a ressincronização está realmente acontecendo?"
• O quadro é de congestão com perfusão preservada (jugular a 12 cmH2O, B3, edema, congestão no RX, mas extremidades aquecidas), ou seja, descompensação "quente e úmida", sem choque.

Por que a CRT depende tanto de estimulação efetiva:
A ressincronização só funciona quando os dois ventrículos são ativados pelo dispositivo (eletrodo do VD e eletrodo do VE, pelo seio coronário). O benefício (melhora dos sintomas, remodelamento reverso, menor mortalidade) depende de uma porcentagem de estimulação biventricular (BiV) próxima de 100%, idealmente acima de 98%. Quando cai abaixo de cerca de 90–95%, o benefício se reduz muito e a IC volta a descompensar. Ou seja, o CRT-D pode estar implantado e "ligado" e, mesmo assim, não estar ressincronizando.

As causas mais comuns de perda de estimulação BiV efetiva são:
• Arritmias que competem com o dispositivo: extrassístoles ventriculares frequentes e fibrilação atrial (ou outras taquiarritmias atriais) com resposta ventricular rápida. Os ventrículos passam a ser ativados pela condução própria (com o BRE nativo) ou por batimentos de fusão e pseudofusão, e o dispositivo não consegue estimular de forma efetiva.
• Perda de captura do VE: elevação do limiar de estimulação (fibrose, medicamentos, distúrbios eletrolíticos) ou deslocamento do eletrodo do seio coronário, que é mais frequente nos primeiros meses e anos após o implante. Nesse caso o ventrículo passa a ser ativado só pelo eletrodo do VD.
• Problemas do eletrodo ou da programação: fratura, falha de isolamento, intervalo AV mal programado ou estimulação frênica que obriga a reduzir a saída. A bateria só é causa provável em implantes antigos, o que não é o caso aqui (6 meses).

O que o ECG da questão mostra:
• Espículas atriais e ventriculares, cada uma seguida de onda P ou de QRS: há estimulação atrial e ventricular sequencial com captura. O dispositivo está "disparando" e o coração responde, então o problema não é falta de estímulo, nem bateria, nem FA ou extrassístoles, que mostrariam ritmo irregular, batimentos de fusão ou QRS estreito intrínseco.
• QRS largo e negativo de V1 a V6: esse é o padrão clássico de estimulação isolada do ventrículo direito. O estímulo sai da ponta do VD e a ativação caminha de baixo para cima e para trás, afastando-se de todas as derivações precordiais, que registram complexos negativos (QS ou rS). É um padrão de BRE, mas mais largo e sem a transição para R nas precordiais esquerdas.
• Com ressincronização eficaz, a ativação do VE (pelo eletrodo do seio coronário, na parede lateral ou posterolateral) se soma à do VD. O resultado costuma ser um QRS mais estreito que o do BRE basal e, em V1, um complexo com R dominante (padrão tipo BRD). A ausência disso, com negativo de V1 a V6, indica que o VE não está sendo capturado.

O ponto fino é este: o contador de estimulação BiV do aparelho conta estímulos entregues, e não captura efetiva. Por isso ele pode marcar perto de 100% enquanto o VE, na prática, não captura. A paciente parece "bem ressincronizada" pelos números e está sem ressincronização de fato. Só a interrogação, com o teste de limiar de captura do VE e a conferência da impedância e do vetor de estimulação, fecha o diagnóstico.

Por que interrogar o dispositivo vem antes dos outros exames:
A interrogação é rápida, não invasiva e feita no próprio consultório. Ela mostra, de forma direta, a porcentagem de estimulação BiV, o teste de limiar de captura do VE, os limiares e as impedâncias de cada eletrodo, a sensibilidade, os episódios de FA, TV e extrassístoles armazenados, as terapias aplicadas pelo desfibrilador e, em alguns aparelhos, os índices de congestão. Além de confirmar a hipótese, ela já indica o tratamento: reprogramar (vetor de estimulação, saída, intervalos AV e VV), tratar a FA ou as extrassístoles (antiarrítmico, ablação) ou reposicionar o eletrodo — alternativa D.

Por que as outras alternativas estão incorretas:
• A) O hemograma busca anemia, que pode descompensar a IC, mas nada no enunciado sugere anemia (sem palidez, sangramento ou outro dado) e, mesmo que fosse feito, não explicaria a piora em quem tem um CRT-D que pode ter parado de funcionar.
• B) A cintilografia ventilação-perfusão investiga tromboembolismo pulmonar. Aqui o quadro é de congestão sistêmica e pulmonar de IC (jugular elevada, B3, edema, congestão no RX), sem hipoxemia, dor pleurítica ou outro dado de TEP, e o exame não é prioritário.
• C) O NT-proBNP confirmaria a descompensação, mas ela já é evidente clínica e radiologicamente, e o exame não identifica a causa nem muda a conduta imediata. Vale lembrar que, em uso de sacubitril/valsartana, o BNP fica falsamente elevado e o NT-proBNP é o marcador mais confiável.
• E) O ecocardiograma é útil depois (FE, regurgitação mitral funcional, dessincronia, otimização do dispositivo), mas é mais demorado e menos direcionado. A interrogação é mais simples e mais rápida para detectar a perda de ressincronização, que é a causa corrigível mais provável.$Q$
where id = '4b14467e-8b19-4c4f-af9c-a80d4e986383';

update public.questions set
  comentario = $Q$Hipertensão, proteinúria importante, cefaleia, escotomas e dor em hipocôndrio direito após a 20ª semana em primigesta configuram pré-eclâmpsia com sinais de gravidade. A B2 hiperfonética reflete a pressão elevada e o clique protossistólico reflete o estado hiperdinâmico da gestação com hipertensão; nenhum dos dois, por si só, indica valvopatia — alternativa B.$Q$,
  comentario_completo = $Q$Pré-eclâmpsia é a síndrome hipertensiva específica da gestação, que surge após a 20ª semana, definida por pressão arterial ≥ 140/90 mmHg associada a proteinúria (classicamente ≥ 300 mg/24 h ou fita +/4 ou mais). A primigesta jovem é o grupo de maior risco. Aqui há PA de 145/90 mmHg na 26ª semana e proteinúria +++/4, o que fecha o diagnóstico.

Cefaleia e escotomas (distúrbios visuais) são sintomas de iminência de eclâmpsia, por edema cerebral e vasoespasmo, e a dor no flanco direito/hipocôndrio direito traduz distensão da cápsula hepática (comprometimento hepático, podendo evoluir para síndrome HELLP). Portanto, é pré-eclâmpsia com sinais de gravidade. O hematócrito de 32% e a hemoglobina de 11 são compatíveis com a hemodiluição fisiológica da gestação e a leucocitúria sugere infecção urinária associada, sem mudar o diagnóstico principal.

Por que a ausculta está assim (B2 hiperfonética e clique protossistólico):
• B2 hiperfonética: a segunda bulha é formada pelo fechamento da valva aórtica (A2) e da valva pulmonar (P2). Na pré-eclâmpsia há vasoespasmo generalizado, aumento da resistência vascular periférica e da pressão arterial. Com a pressão diastólica na aorta mais alta, a valva aórtica fecha com mais força e A2 fica hiperfonética. É o mesmo achado da hipertensão arterial sistêmica de qualquer causa e traduz a pressão elevada, não um problema da valva.
• Clique protossistólico na borda esternal esquerda: é um clique de ejeção, que ocorre logo no início da sístole, quando o sangue é lançado e distende de forma brusca a raiz da aorta ou o tronco da pulmonar. Pode ter origem valvar (valva bicúspide, estenose valvar) ou vascular, sem lesão de valva, quando o vaso está dilatado ou tenso e o fluxo é alto. A gestação é um estado hiperdinâmico (débito cardíaco 30–50% maior, volemia aumentada) e, somado à hipertensão, favorece esse clique "vascular". Por isso ele é um achado inespecífico e não explica o quadro sistêmico (proteinúria, cefaleia, escotomas e dor hepática), que é de pré-eclâmpsia.
• Sopro: o enunciado não descreve sopro. Mesmo assim, vale saber que em gestantes é comum um sopro sistólico ejetivo suave por hiperfluxo, fisiológico. Se o clique ou um sopro persistirem após o parto, ou se houver sinais de valvopatia, solicita-se ecocardiograma para afastar valva aórtica bicúspide ou outra lesão.

O tratamento é sulfato de magnésio para prevenir eclâmpsia, controle da pressão arterial (metildopa, hidralazina, nifedipino) e, nos casos graves, interrupção da gestação conforme a idade gestacional e a estabilidade materno-fetal — alternativa B.

Atualização: os critérios atuais permitem o diagnóstico mesmo sem proteinúria, quando há hipertensão associada a disfunção de órgão-alvo (plaquetopenia, elevação de transaminases, insuficiência renal, sintomas cerebrais ou visuais).

Por que as outras alternativas estão incorretas:
• A) Colecistopatia aguda causa dor em hipocôndrio direito com febre e sinal de Murphy, mas não explica hipertensão, proteinúria maciça, cefaleia e escotomas.
• C) Estenose aórtica produz sopro sistólico ejetivo rude, com B2 hipofonética ou única (A2 diminuída pela valva calcificada), pulso de baixa amplitude e angina, síncope ou dispneia; aqui não há sopro, a B2 é hiperfonética (e não hipofonética) e o quadro é hipertensivo sistêmico com proteinúria.
• D) Síndrome nefrótica causa proteinúria, edema e hipoalbuminemia, mas não explica a hipertensão com sintomas neurológicos e dor hepática por distensão da cápsula na gestação.
• E) Enxaqueca gestacional causa cefaleia e escotomas, mas sem hipertensão nem proteinúria e sem dor em flanco direito.$Q$
where id = '5147d91c-b752-4e0b-8f93-c980511f880f';

-- TEC 2014 (Saúde Card. da Mulher): mesmo caso clínico da TEC 2007, com PA 140x90 e ECG normal.
update public.questions set
  comentario = $Q$Gestante após 20 semanas com hipertensão, proteinúria de 3+ e sintomas de gravidade (cefaleia, escotomas, dor no flanco direito) tem pré-eclâmpsia. A B2 hiperfonética reflete a pressão elevada e o clique protossistólico reflete o estado hiperdinâmico da gestação com hipertensão; nenhum dos dois, por si só, indica valvopatia — alternativa B.$Q$,
  comentario_completo = $Q$Pré-eclâmpsia é definida por hipertensão (PA igual ou superior a 140x90 mmHg) surgida após a 20ª semana de gestação em paciente previamente normotensa, associada a proteinúria (ou, em critérios mais recentes, a disfunção de órgão-alvo). Aparecem sinais de gravidade quando há cefaleia persistente, distúrbios visuais (escotomas), dor epigástrica ou em hipocôndrio direito (distensão da cápsula hepática, podendo indicar síndrome HELLP), plaquetopenia, elevação de enzimas hepáticas ou disfunção renal.

No caso: primigesta (fator de risco), 26 semanas, PA de 140x90, cefaleia, escotomas, dor no flanco direito e proteinúria de 3+ formam um quadro típico de pré-eclâmpsia com sinais de gravidade. O hematócrito de 32% e a hemoglobina de 11 são compatíveis com a hemodiluição fisiológica da gestação, a leucocitúria sugere infecção urinária associada e os cristais de oxalato não mudam o diagnóstico. O ECG normal mostra que não há sobrecarga ou doença cardíaca que explique os sintomas.

Por que a ausculta está assim (B2 hiperfonética e clique protossistólico):
• B2 hiperfonética: a segunda bulha é formada pelo fechamento da valva aórtica (A2) e da valva pulmonar (P2). Na pré-eclâmpsia há vasoespasmo generalizado, aumento da resistência vascular periférica e da pressão arterial. Com a pressão diastólica na aorta mais alta, a valva aórtica fecha com mais força e A2 fica hiperfonética. É o mesmo achado da hipertensão arterial sistêmica de qualquer causa e traduz a pressão elevada, não um problema da valva.
• Clique protossistólico na borda esternal esquerda: é um clique de ejeção, que ocorre logo no início da sístole, quando o sangue é lançado e distende de forma brusca a raiz da aorta ou o tronco da pulmonar. Pode ter origem valvar (valva aórtica bicúspide, estenose valvar) ou vascular, sem lesão de valva, quando o vaso está dilatado ou tenso e o fluxo é alto. A gestação é um estado hiperdinâmico (débito cardíaco 30–50% maior, volemia aumentada) e, somado à hipertensão, favorece esse clique "vascular". Por isso ele é um achado inespecífico e não explica o quadro sistêmico (proteinúria, cefaleia, escotomas e dor hepática), que é de pré-eclâmpsia.
• Sopro: o enunciado não descreve sopro. Mesmo assim, vale saber que em gestantes é comum um sopro sistólico ejetivo suave por hiperfluxo, fisiológico. Se o clique ou um sopro persistirem após o parto, ou se houver sinais de valvopatia, solicita-se ecocardiograma para afastar valva aórtica bicúspide ou outra lesão.

A conduta envolve internação, sulfato de magnésio para prevenir convulsões, controle da pressão arterial (metildopa, hidralazina, nifedipino), avaliação laboratorial (hemograma, plaquetas, enzimas hepáticas, creatinina) e planejamento do momento do parto conforme a idade gestacional e a gravidade — alternativa B.

Por que as outras alternativas estão incorretas:
• A) Colecistopatia aguda explicaria a dor no flanco direito, mas causa febre e sinal de Murphy e não explica a hipertensão, os escotomas, a cefaleia e a proteinúria de 3+.
• C) Estenose aórtica produz sopro sistólico ejetivo rude, com B2 hipofonética ou única (A2 diminuída pela valva calcificada), pulso de baixa amplitude e dispneia, angina ou síncope; aqui não há sopro, a B2 é hiperfonética (e não hipofonética), o ECG é normal e o quadro é hipertensivo sistêmico com proteinúria.
• D) Síndrome nefrótica causa edema, hipoalbuminemia e dislipidemia, sem a associação de cefaleia e escotomas com hipertensão de início na gestação; a proteinúria aqui é parte da pré-eclâmpsia.
• E) Enxaqueca gestacional não causa hipertensão nem proteinúria. A leucocitúria e os cristais de oxalato são distratores.$Q$
where id = 'f00965b8-defe-4247-b342-a88979323190';

-- Conferência: deve voltar 3 linhas.
select id, instituicao, ano, tema, left(comentario, 80) as comentario_inicio
from public.questions
where id in ('4b14467e-8b19-4c4f-af9c-a80d4e986383', '5147d91c-b752-4e0b-8f93-c980511f880f',
             'f00965b8-defe-4247-b342-a88979323190');
