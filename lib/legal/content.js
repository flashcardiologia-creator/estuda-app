// Textos jurídicos exibidos no app (/termos e /privacidade) e usados no registro do aceite.
// Ao mudar qualquer texto, atualize LEGAL_VERSION e LEGAL_UPDATED: o aceite guarda a versão
// e uma impressão digital (hash) do texto que a pessoa viu.
//
// Blocos: string = parágrafo; { sub } = subtítulo em negrito; { list } = lista; { table } = tabela.

export const LEGAL_VERSION = "2026-10-16.2";
export const LEGAL_UPDATED = "16 de outubro de 2026";

// Interruptor da tela de aceite exibida após o login a quem ainda não aceitou a versão atual.
// Mude para false para desligar (ninguém é bloqueado).
export const TERMS_GATE_ENABLED = true;

export const ACCEPT_LABEL = "Li e concordo com os Termos de Uso e a Política de Privacidade";

export const TERMS = {
  title: "Termos de Uso do FlashCardio",
  sections: [
    {
      title: "1. Quem somos e o que é o FlashCardio",
      blocks: [
        "1.1. O FlashCardio é um aplicativo web de estudo para a prova de título de especialista em cardiologia e para residência médica. Ele reúne questões, flashcards, missão diária, estatísticas, desafios entre amigos e ranking.",
        '1.2. O serviço é oferecido por Rodrigo Aragão Andrade, CPF 10021813647, doravante "FlashCardio". Contato: flashcardiologia@gmail.com.',
        "1.3. O acesso ao app pode ser gratuito em períodos promocionais temporários, mas, via de regra, é pago, em plano mensal ou anual. Preços, forma de pagamento, renovação e reembolso estão descritos na cláusula 12.",
      ],
    },
    {
      title: "2. Aceite dos termos",
      blocks: [
        "2.1. Ao criar uma conta ou usar o FlashCardio, você declara que leu e concorda com estes Termos de Uso e com a Política de Privacidade.",
        "2.2. Se você não concordar com algum ponto, não deve criar conta nem usar o app.",
        "2.3. O uso do FlashCardio é permitido apenas a maiores de 18 anos. Ao criar a conta, você declara ter 18 anos ou mais.",
      ],
    },
    {
      title: "3. Conta e cadastro",
      blocks: [
        "3.1. Para usar o app você cria uma conta com nome, e-mail e senha. As informações devem ser verdadeiras e mantidas atualizadas.",
        "3.2. A conta é pessoal e intransferível. Você é responsável por guardar sua senha e por tudo o que for feito na sua conta. Avise-nos imediatamente se suspeitar de uso indevido.",
        "3.3. Você pode usar a mesma conta em mais de um aparelho seu. É proibido compartilhar o acesso com outras pessoas.",
        "3.4. Você pode excluir sua conta a qualquer momento pelos canais de contato. Os dados serão tratados conforme a cláusula 10.",
      ],
    },
    {
      title: "4. Como o app funciona",
      blocks: [
        "4.1. O FlashCardio oferece questões, flashcards, missão diária (por exemplo, cinco questões e cinco flashcards, ou dez questões), estatísticas de desempenho, desafios com amigos e ranking.",
        "4.2. Podemos adicionar, alterar ou retirar funcionalidades, conteúdos e regras de pontuação. Quando a mudança afetar de forma relevante o seu uso, avisaremos no app ou por e-mail.",
        "4.3. Para usar o app você precisa de internet e de um aparelho compatível, por sua conta. O app pode ficar indisponível por manutenção ou por falhas de terceiros, sem garantia de funcionamento ininterrupto.",
        "4.4. Acesso gratuito e acesso de assinante. Sem assinatura ativa, você continua usando a missão diária, o ranking, as estatísticas e a sua conta, e pode criar 1 desafio por dia. Questões e flashcards, e a criação de até 5 desafios por dia, são exclusivos de quem tem assinatura ativa.",
        "4.5. Por enquanto não há período de teste gratuito. Podemos oferecer períodos gratuitos promocionais temporários, que terminam na data informada.",
      ],
    },
    {
      title: "5. Uso permitido e condutas proibidas",
      blocks: [
        "5.1. Você pode usar o app para estudo pessoal.",
        "5.2. É proibido:",
        {
          list: [
            "compartilhar, vender, alugar ou ceder sua conta;",
            "copiar, reproduzir, publicar ou distribuir questões, comentários, flashcards ou imagens do app, no todo ou em parte, fora do uso pessoal;",
            "usar robôs, scripts, raspagem de dados ou qualquer meio automático para extrair conteúdo;",
            "tentar burlar o sistema de pontuação, o ranking, os desafios ou as regras de acesso;",
            "invadir, sobrecarregar ou tentar comprometer a segurança do app;",
            "usar nomes, frases ou conteúdos ofensivos, discriminatórios ou que violem direitos de terceiros;",
            "usar o app para qualquer finalidade ilegal.",
          ],
        },
        "5.3. Se identificarmos violação, podemos advertir, suspender ou encerrar a conta. O reembolso, nesses casos, segue a cláusula 12.3.",
      ],
    },
    {
      title: "6. Conteúdo do app e propriedade intelectual",
      blocks: [
        "6.1. O app reúne questões retiradas de provas anteriores de diferentes instituições, comentários, flashcards, imagens, textos, layout e marca. As questões são reproduzidas das provas originais com finalidade educacional. Os comentários e os flashcards são de autoria do FlashCardio, produzidos com o auxílio de ferramentas de inteligência artificial.",
        "6.2. As questões das provas pertencem às respectivas bancas e instituições. O FlashCardio não tem vínculo oficial com elas. Os demais conteúdos, a marca e o código do app pertencem ao FlashCardio ou a quem nos licenciou.",
        "6.3. Você recebe uma licença pessoal, limitada, não exclusiva e revogável para usar o app como ferramenta de estudo. Isso não transfere a você nenhum direito sobre o conteúdo.",
        "6.4. Os flashcards e anotações que você criar continuam sendo seus. Você nos autoriza a armazená-los e exibi-los para você no app. Você declara ter direito sobre o que cadastrar e não incluir material de terceiros protegido por direito autoral.",
        "6.5. Se você acreditar que algum conteúdo viola seus direitos, avise em flashcardiologia@gmail.com e vamos analisar e, se for o caso, retirar o conteúdo.",
      ],
    },
    {
      title: "7. Finalidade educacional",
      blocks: [
        "7.1. O FlashCardio é uma ferramenta de apoio ao estudo. Não garantimos aprovação em prova, nota mínima ou qualquer resultado.",
        "7.2. O conteúdo não substitui livros, diretrizes oficiais, orientação de professores nem avaliação clínica. As informações não devem ser usadas para decidir sobre o cuidado de pacientes reais.",
        "7.3. Gabaritos, comentários e flashcards podem conter erros ou ficar desatualizados, inclusive por terem sido produzidos com auxílio de inteligência artificial. Confira informações importantes em fontes oficiais. Se encontrar algum erro, use a opção de reportar problema no app.",
      ],
    },
    {
      title: "8. Estatísticas, ranking, amigos e desafios",
      blocks: [
        "8.1. O app calcula estatísticas do seu desempenho (acertos, questões respondidas, flashcards vistos, desafios vencidos).",
        '8.2. O ranking compara usuários com base nessas estatísticas. Você pode escolher se seu nome aparece. Se não permitir, você continua no ranking como "Anônimo".',
        "8.3. Você pode escolher uma frase de comemoração entre as opções oferecidas, que aparecerá para outros usuários no ranking.",
        "8.4. Você pode adicionar amigos e enviar ou receber desafios. Ao desafiar alguém, os resultados do desafio ficam visíveis para os participantes.",
        "8.5. Podemos corrigir ou zerar pontuações obtidas de forma irregular, e remover do ranking quem violar estes termos.",
      ],
    },
    {
      title: "9. Notificações e comunicações",
      blocks: [
        "9.1. Se você permitir, o app envia lembretes por notificação (push) às 10h e às 22h sobre sua missão diária. Você pode ativar ou desativar a qualquer momento nas permissões do app ou do aparelho.",
        "9.2. Podemos enviar e-mails sobre sua conta (confirmação de cadastro, recuperação de senha, avisos importantes). E-mails promocionais só serão enviados com seu consentimento, e você poderá cancelar a qualquer momento.",
      ],
    },
    {
      title: "10. Dados pessoais e privacidade",
      blocks: [
        "10.1. Tratamos seus dados conforme a Lei Geral de Proteção de Dados (Lei 13.709/2018) e nossa Política de Privacidade, disponível no app.",
        "10.2. Coletamos nome, e-mail, desempenho nos estudos, preferências, lista de amigos e dados técnicos necessários para o app e as notificações. Usamos esses dados para prestar o serviço, calcular estatísticas e ranking, enviar lembretes, dar suporte e manter a segurança.",
        "10.3. Não vendemos seus dados. Podemos compartilhá-los com provedores que nos ajudam a operar o app (hospedagem, banco de dados, envio de e-mail e de notificações) e com autoridades, quando a lei exigir.",
        "10.4. Você pode, a qualquer momento, pedir acesso, correção, exclusão ou portabilidade dos seus dados e revogar consentimentos, por flashcardiologia@gmail.com. Encarregado de dados (DPO): Rodrigo Aragão Andrade, flashcardiologia@gmail.com.",
        "10.5. Ao excluir a conta, apagamos ou anonimizamos os dados pessoais, salvo o que precisarmos guardar por obrigação legal.",
      ],
    },
    {
      title: "11. Suporte e reporte de problemas",
      blocks: [
        "11.1. Você pode falar com a gente pelo botão de reportar problema no app ou por flashcardiologia@gmail.com. Respondemos em até 7 dias úteis.",
        "11.2. Reportes de erro em questões ou flashcards nos ajudam a melhorar o conteúdo, mas não obrigam a alteração.",
      ],
    },
    {
      title: "12. Pagamento, renovação e reembolso",
      blocks: [
        "12.1. O acesso completo ao app é vendido em plano mensal ou anual, pelos preços informados no app no momento da contratação. O pagamento é feito por transferência bancária para a conta de pessoa física do desenvolvedor, cujos dados são informados no momento da contratação. A assinatura não renova automaticamente: ao fim do período contratado o acesso termina, e você pode contratar de novo. O preço pode ser reajustado a cada mês nos planos mensais e a cada ano no plano anual, e o novo valor vale apenas para as contratações seguintes. Podemos oferecer períodos gratuitos promocionais temporários, que terminam na data informada.",
        "12.2. Por ser uma contratação feita online, você pode desistir em até 7 dias corridos a partir da contratação, conforme o art. 49 do Código de Defesa do Consumidor. Nesse caso, devolvemos o valor integral por transferência bancária em até 7 dias úteis.",
        "12.3. Se a conta for suspensa ou encerrada por violação destes termos, o acesso é extinto imediatamente e não é devida nenhuma devolução, restituição ou ressarcimento dos valores pagos, que ficam retidos a título de multa contratual, sem prejuízo das medidas legais cabíveis. Se a suspensão ou o encerramento ocorrer por erro nosso, ou se nós descontinuarmos o serviço, devolvemos o valor proporcional ao período não utilizado.",
        "12.4. Como o acesso é liberado. O acesso de assinante começa depois que confirmamos o pagamento, e o prazo é contado a partir do dia do pagamento: 30 dias corridos no plano mensal e 365 dias corridos no plano anual. Se você pagar antes de o período atual terminar, os dias novos começam quando o período atual termina, e você não perde nenhum dia.",
        "12.5. Fim do período. Quando o prazo termina, o acesso a questões e flashcards é bloqueado e a conta volta ao acesso gratuito descrito na cláusula 4.4. Seus dados, seu histórico e suas estatísticas são mantidos. Para voltar, basta contratar um novo período.",
        "12.6. Mercado Pago. Quando o pagamento pelo Mercado Pago estiver disponível, ele será processado pelo próprio Mercado Pago, e valerão também os termos e a política de privacidade dele. O acesso será liberado quando o Mercado Pago informar a aprovação do pagamento.",
      ],
    },
    {
      title: "13. Limitação de responsabilidade",
      blocks: [
        '13.1. Fazemos o possível para manter o app disponível e correto, mas ele é oferecido "no estado em que está". Não garantimos que ficará livre de erros, interrupções ou ataques.',
        "13.2. Não respondemos por: resultado em provas; falhas de internet, do aparelho ou de serviços de terceiros; perda de dados causada por uso indevido da conta; ou uso do app em desacordo com estes termos.",
        "13.3. Nada nestes termos exclui ou limita direitos que a lei garante ao consumidor nem nossa responsabilidade por dolo ou culpa grave.",
        "13.4. Você responde pelos danos que causar ao FlashCardio ou a terceiros por uso do app em violação a estes termos ou à lei.",
      ],
    },
    {
      title: "14. Vigência, encerramento e alteração dos termos",
      blocks: [
        "14.1. Estes termos valem enquanto você tiver conta ou usar o app.",
        "14.2. Você pode encerrar a conta quando quiser. Nós podemos suspender ou encerrar contas que violem estes termos ou a lei, ou, com aviso prévio razoável, se o serviço for descontinuado.",
        "14.3. Podemos atualizar estes termos. Quando a mudança for relevante, avisaremos no app ou por e-mail com 15 dias de antecedência. Se continuar usando após a mudança, entendemos que você concorda; se não concordar, pode encerrar a conta.",
      ],
    },
    {
      title: "15. Disposições gerais e foro",
      blocks: [
        "15.1. Se alguma cláusula for considerada inválida, as demais continuam valendo.",
        "15.2. Deixar de exigir um direito não significa renunciar a ele.",
        "15.3. Estes termos seguem a lei brasileira. Para resolver conflitos, fica eleito o foro da comarca de São Paulo/SP, ressalvado o direito do consumidor de propor a ação no foro do seu domicílio, conforme o Código de Defesa do Consumidor.",
        "15.4. Ao criar sua conta, você declara que leu, entendeu e concorda com estes termos.",
      ],
    },
  ],
};

export const PRIVACY = {
  title: "Política de Privacidade do FlashCardio",
  sections: [
    {
      title: "1. Quem somos",
      blocks: [
        "1.1. O controlador dos seus dados pessoais, isto é, quem decide como eles são tratados, é Rodrigo Aragão Andrade, CPF 10021813647, responsável pelo FlashCardio (www.flashcardiologia.com).",
        "1.2. Encarregado de dados (DPO) e canal para qualquer assunto de privacidade: Rodrigo Aragão Andrade, flashcardiologia@gmail.com.",
        "1.3. Esta política explica quais dados coletamos, para que usamos, com quem compartilhamos e quais são os seus direitos, conforme a Lei Geral de Proteção de Dados (Lei 13.709/2018, a LGPD). Ela complementa os Termos de Uso.",
      ],
    },
    {
      title: "2. Quais dados coletamos",
      blocks: [
        { sub: "Dados que você nos dá" },
        {
          list: [
            "Cadastro: nome, e-mail e senha. A senha é guardada de forma protegida (criptografada) e não conseguimos lê-la.",
            "Preferências: tema do app, formato da missão diária, se seu nome aparece no ranking e a frase de comemoração escolhida.",
            "Conteúdo que você cria: flashcards e anotações pessoais.",
            "Mensagens: relatos de problemas em questões ou flashcards e mensagens de contato que você enviar.",
            "Pagamento: o pagamento é feito por transferência bancária. Recebemos, pelo extrato, o nome, o valor e a data da transferência. Não guardamos dados de cartão.",
            "Assinatura: guardamos o plano contratado, a data e o valor do pagamento, a forma de pagamento, o identificador da transação (quando houver) e o período de acesso liberado.",
          ],
        },
        { sub: "Dados gerados pelo seu uso" },
        {
          list: [
            "Questões respondidas, acertos e erros, sessões de estudo salvas, flashcards vistos, favoritados ou descartados e missões diárias concluídas.",
            "Amigos adicionados e desafios enviados, recebidos e seus resultados.",
            "Estatísticas calculadas a partir disso (taxa de acerto, total respondido, desafios vencidos), usadas no ranking.",
          ],
        },
        { sub: "Dados técnicos" },
        {
          list: [
            "Aceite dos termos: no cadastro guardamos a versão dos textos aceitos, a data e a hora, o endereço IP, o aparelho e o navegador usados, o idioma e o fuso horário, como prova do seu consentimento.",
            "Se você ativar os lembretes, guardamos um código técnico que identifica o seu aparelho ou navegador para o envio das notificações.",
            "Registros técnicos de acesso, como endereço IP, data e hora, tipo de navegador e erros, gerados pelos servidores que hospedam o app.",
            "Dados guardados no seu próprio aparelho (armazenamento local do navegador) para manter você conectado e lembrar preferências.",
          ],
        },
      ],
    },
    {
      title: "3. Para que usamos os dados e em que base legal",
      blocks: [
        {
          table: {
            head: ["Finalidade", "Base legal (LGPD)"],
            rows: [
              ["Criar e manter sua conta, entregar questões, flashcards e missão diária", "Execução do contrato (art. 7º, V)"],
              ["Calcular suas estatísticas, ranking, amigos e desafios", "Execução do contrato (art. 7º, V)"],
              ["Enviar e-mails da conta: confirmação, recuperação de senha, avisos importantes", "Execução do contrato (art. 7º, V)"],
              ["Enviar lembretes por notificação (10h e 22h)", "Consentimento (art. 7º, I), que você pode retirar a qualquer momento"],
              ["Enviar e-mails promocionais, se existirem", "Consentimento (art. 7º, I)"],
              ["Responder reportes e mensagens, dar suporte", "Execução do contrato e legítimo interesse (art. 7º, V e IX)"],
              ["Manter a segurança, prevenir fraudes e uso indevido do ranking", "Legítimo interesse (art. 7º, IX)"],
              ["Guardar a prova do aceite dos termos", "Exercício regular de direitos (art. 7º, VI) e legítimo interesse (art. 7º, IX)"],
              ["Controlar quem tem assinatura ativa e liberar ou bloquear o acesso a questões e flashcards", "Execução do contrato (art. 7º, V)"],
              ["Registrar pagamentos e cumprir obrigações fiscais", "Obrigação legal (art. 7º, II)"],
              ["Melhorar o conteúdo a partir dos erros reportados", "Legítimo interesse (art. 7º, IX)"],
            ],
          },
        },
      ],
    },
    {
      title: "4. Ranking, amigos e o que outros usuários veem",
      blocks: [
        '4.1. No ranking aparecem, para outros usuários, o seu nome (ou "Anônimo", se você não permitir), sua frase de comemoração e suas estatísticas: taxa de acerto, questões respondidas, flashcards vistos e desafios vencidos.',
        '4.2. Você pode mudar isso a qualquer momento na tela da sua conta, em "Mostrar meu nome no ranking".',
        "4.3. Seus amigos veem o seu nome e os resultados dos desafios de que participaram com você.",
        "4.4. Seu e-mail não é exibido a outros usuários.",
      ],
    },
    {
      title: "5. Com quem compartilhamos",
      blocks: [
        "5.1. Não vendemos seus dados e não os usamos para publicidade de terceiros.",
        "5.2. Usamos prestadores que processam dados em nosso nome, só para operar o app:",
        {
          list: [
            "Supabase: banco de dados e autenticação (cadastro e login).",
            "Netlify: hospedagem do site e execução das tarefas automáticas, como os lembretes.",
            "Resend: envio dos e-mails da conta e dos avisos de reporte.",
            "Mercado Pago, quando o pagamento por ele estiver disponível: processamento do pagamento e confirmação da assinatura.",
            "Serviços de notificação do seu navegador ou aparelho (por exemplo, Apple, Google e Mozilla), que entregam os lembretes.",
          ],
        },
        "5.3. Podemos compartilhar dados com autoridades, quando a lei ou uma ordem judicial exigir, e para defender nossos direitos em processos.",
        "5.4. Alguns desses prestadores armazenam dados em servidores fora do Brasil. Nesses casos, a transferência segue a LGPD, com prestadores que adotam medidas de segurança e proteção de dados compatíveis.",
      ],
    },
    {
      title: "6. Cookies e armazenamento local",
      blocks: [
        "6.1. O app usa armazenamento local do navegador, de uso técnico, para manter você conectado e lembrar preferências como o tema.",
        "6.2. Não usamos cookies de publicidade nem ferramentas de análise de comportamento de terceiros. Se isso mudar, atualizaremos esta política e pediremos seu consentimento quando necessário.",
        "6.3. Você pode limpar esses dados nas configurações do navegador, mas será desconectado do app.",
      ],
    },
    {
      title: "7. Por quanto tempo guardamos os dados",
      blocks: [
        "7.1. Guardamos seus dados enquanto sua conta estiver ativa.",
        "7.2. Quando você excluir a conta, apagamos ou anonimizamos os dados pessoais, em até 30 dias. Dados que a lei nos obriga a manter, como registros de pagamento para fins fiscais, ficam guardados pelo prazo legal. O registro do aceite dos termos também pode ser mantido pelo prazo necessário para nos defender em eventuais disputas.",
        "7.3. Cópias de segurança podem manter dados por um período limitado, até serem substituídas.",
      ],
    },
    {
      title: "8. Segurança",
      blocks: [
        "8.1. Adotamos medidas técnicas para proteger seus dados, como conexão criptografada (HTTPS), senhas protegidas, regras de acesso no banco de dados para que cada usuário acesse apenas os seus dados e acesso restrito à administração do app.",
        "8.2. Nenhum sistema é totalmente seguro. Se houver um incidente que possa causar risco ou dano relevante a você, comunicaremos você e a Autoridade Nacional de Proteção de Dados (ANPD), conforme a lei.",
        "8.3. Sua parte: use uma senha forte, não a compartilhe e avise-nos se suspeitar de acesso indevido.",
      ],
    },
    {
      title: "9. Seus direitos",
      blocks: [
        "9.1. Pela LGPD (art. 18), você pode pedir, a qualquer momento:",
        {
          list: [
            "confirmação de que tratamos seus dados e acesso a eles;",
            "correção de dados incompletos, inexatos ou desatualizados;",
            "anonimização, bloqueio ou eliminação de dados desnecessários ou tratados em desconformidade com a lei;",
            "portabilidade dos dados;",
            "eliminação dos dados tratados com base no seu consentimento;",
            "informação sobre com quem compartilhamos os dados;",
            "informação sobre a possibilidade de não dar consentimento e suas consequências;",
            "revogação do consentimento.",
          ],
        },
        "9.2. Para exercer seus direitos, escreva para flashcardiologia@gmail.com, a partir do e-mail cadastrado, para confirmarmos que é você. Respondemos em até 15 dias.",
        "9.3. Você também pode alterar seu nome, ativar ou desativar os lembretes e escolher se aparece no ranking direto no app.",
        "9.4. Se achar que seus dados não foram tratados corretamente, você pode reclamar à Autoridade Nacional de Proteção de Dados (www.gov.br/anpd).",
      ],
    },
    {
      title: "10. Menores de idade",
      blocks: [
        "10.1. O FlashCardio é destinado a maiores de 18 anos. Não coletamos dados de menores de forma intencional. Se soubermos que uma conta pertence a um menor, ela poderá ser encerrada e os dados excluídos.",
      ],
    },
    {
      title: "11. Mudanças nesta política",
      blocks: [
        "11.1. Podemos atualizar esta política. Quando a mudança for relevante, avisaremos no app ou por e-mail com 15 dias de antecedência. A data da última atualização fica sempre no topo.",
      ],
    },
    {
      title: "12. Contato",
      blocks: ["Dúvidas, pedidos ou reclamações sobre privacidade: Rodrigo Aragão Andrade, flashcardiologia@gmail.com."],
    },
  ],
};
