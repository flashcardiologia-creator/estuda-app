"use client";

import { useState } from "react";
import { CircleQuestionMark, ChevronDown } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { ExpandBox } from "@/components/ui/Primitives";
import { PLANS, formatBRL } from "@/lib/billing";
import { FREE_CHALLENGES_PER_DAY, FREE_CHALLENGE_QUESTIONS, PAID_CHALLENGES_PER_DAY, PAID_CHALLENGE_QUESTIONS } from "@/lib/access";

// Perguntas frequentes. Preços e limites vêm dos mesmos arquivos que o resto do app (lib/billing.js e lib/access.js),
// então o texto acompanha qualquer mudança neles. Trocar a ordem ou o texto aqui não afeta mais nada.
function faqItems(B) {
  const { mensal, anual } = PLANS;
  return [
    {
      q: "O que é o FlashCardio?",
      a: (
        <>
          Um aplicativo para estudar cardiologia com <B>questões comentadas</B> de provas anteriores (TEC, residência R+ e outras), <B>flashcards</B>, missão diária, desafios com amigos e ranking.
        </>
      ),
    },
    {
      q: "O que posso usar sem assinatura?",
      a: (
        <>
          A <B>missão diária</B> (3 questões, sem flashcards), o ranking, as estatísticas, os amigos e {FREE_CHALLENGES_PER_DAY} desafio criado por dia com {FREE_CHALLENGE_QUESTIONS} questões. As telas de <B>Questões</B> e <B>Flashcards</B> ficam bloqueadas até você assinar ou usar dias grátis.
        </>
      ),
    },
    {
      q: "Como funciona a missão diária?",
      a: (
        <>
          Todo dia você recebe um conjunto de questões para resolver. Quem assina escolhe entre <B>10 questões</B> ou <B>5 questões + 5 flashcards</B> (a escolha vale a partir do dia seguinte). A sua <B>sequência</B> conta os dias seguidos em que você concluiu a missão. Para assinantes, as questões que você errou voltam na hora certa, pela curva de Ebbinghaus, para fixar o conteúdo.
        </>
      ),
    },
    {
      q: "O que é a bandagem da sequência?",
      a: (
        <>
          Se você <B>acertar todas as questões</B> da missão diária, tem <B>50% de chance</B> de ganhar uma bandagem. Ela <B>salva sua sequência</B> quando você passa um dia sem fazer a missão: ao voltar e concluir a missão seguinte, a sequência continua e a bandagem é gasta. Só cabe <B>uma</B> por vez (com uma guardada, não há novo sorteio), e ela cobre apenas um dia perdido. Para ver quantas bandagens você tem, toque no <B>foguinho</B> no alto da tela. As bandagens são para assinantes.
        </>
      ),
    },
    {
      q: "Quanto custa e como pago?",
      a: (
        <>
          <B>Mensal:</B> {formatBRL(mensal.priceCents)} por {mensal.days} dias. <B>Anual:</B> {formatBRL(anual.priceCents)} por {anual.days} dias, o que dá {formatBRL(Math.round(anual.priceCents / 12))} por mês. O pagamento é por <B>Pix ou cartão</B>, pelo Mercado Pago. O mensal é à vista; o anual pode ser parcelado em até {anual.maxInstallments}x, com os juros do parcelamento mostrados antes de você confirmar. <B>Não há renovação automática</B>: você só paga quando quiser.
        </>
      ),
    },
    {
      q: "Paguei e meu acesso não foi liberado. O que faço?",
      a: (
        <>
          O acesso é liberado sozinho assim que o pagamento é aprovado, em geral em poucos minutos. Feche e abra o aplicativo para atualizar. Se o Pix ainda estiver pendente, aguarde a confirmação do banco. Se passar de algumas horas, escreva pela aba <B>Contato</B> aqui embaixo informando o e-mail da conta e o comprovante.
        </>
      ),
    },
    {
      q: "Como renovo ou prolongo minha assinatura?",
      a: (
        <>
          Na tela <B>Assinatura</B>, escolha um plano. Os dias novos são <B>somados ao fim da assinatura atual</B>, então você não perde nenhum dia. O app avisa quando faltarem 7, 3 e 1 dia para vencer.
        </>
      ),
    },
    {
      q: "Minha assinatura venceu. Perco meu histórico?",
      a: (
        <>
          Não. Nada é apagado: suas respostas, estatísticas, favoritos e amigos continuam guardados, e sua sequência fica preservada. Ao renovar, você volta a estudar de onde parou.
        </>
      ),
    },
    {
      q: "Como ganho dias grátis ou uso um cupom?",
      a: (
        <>
          Quem cria a conta pelo quiz de boas-vindas ganha de <B>3 a 10 dias grátis</B>, conforme os acertos, liberados automaticamente. Um cupom é digitado na tela <B>Assinatura</B>, no campo &quot;Digite o cupom&quot;, e cada conta pode usá-lo uma vez.
        </>
      ),
    },
    {
      q: "Como adiciono amigos?",
      a: (
        <>
          Em <B>Minha Conta → Amigos</B>, digite o nome ou o <B>código de amigo</B> da pessoa. O seu código aparece no quadro tracejado, com o botão Copiar. O convite precisa ser aceito pelo outro lado.
        </>
      ),
    },
    {
      q: "O que meus amigos e o ranking mostram de mim?",
      a: (
        <>
          Em <B>Minha Conta → Permissões</B> você escolhe. Com &quot;Comparem estatísticas com você&quot; ligado, seus amigos veem sua sequência, questões respondidas e % de acerto. Com &quot;Mostrar meu nome no ranking&quot; desligado, você continua no ranking, mas aparece como <B>Anônimo</B>.
        </>
      ),
    },
    {
      q: "Como funcionam os desafios?",
      a: (
        <>
          Você escolhe amigos e um conjunto de questões, e todos respondem; vence quem acertar mais. Os desafios têm {FREE_CHALLENGE_QUESTIONS} questões ({PAID_CHALLENGE_QUESTIONS} só para assinantes). Sem assinatura você cria {FREE_CHALLENGES_PER_DAY} desafio por dia; com assinatura, até {PAID_CHALLENGES_PER_DAY}.
        </>
      ),
    },
    {
      q: "Achei um erro numa questão ou flashcard. Como aviso?",
      a: (
        <>
          Toque no botão <B>?</B> no canto da questão ou do flashcard, escolha o motivo e toque em <B>Enviar</B>. Se for pertinente, a resposta chega no seu e-mail.
        </>
      ),
    },
    {
      q: "Como instalo o app no celular?",
      a: (
        <>
          Na tela de entrada, toque em <B>Baixar aplicativo</B> e siga o passo a passo. No iPhone, abra no Safari e use Compartilhar → <B>Adicionar à Tela de Início</B>. No Android, use o Chrome e toque em <B>Instalar app</B> no menu.
        </>
      ),
    },
    {
      q: "Esqueci minha senha.",
      a: (
        <>
          Na tela de entrada, toque em <B>Esqueci minha senha</B> e informe seu e-mail: enviamos um link para criar uma nova. Se você ainda está dentro da conta, use <B>Minha Conta → Perfil → Trocar senha</B>.
        </>
      ),
    },
    {
      q: "Posso receber um lembrete da missão diária?",
      a: (
        <>
          Sim. Em <B>Minha Conta → Permissões</B>, ative o lembrete para receber uma notificação no aparelho. O aparelho precisa permitir notificações do FlashCardio.
        </>
      ),
    },
    {
      q: "Não achei minha dúvida. Como falo com vocês?",
      a: (
        <>
          Use a aba <B>Contato</B>, logo abaixo: escolha o assunto (dúvida, sugestão, problema ou outro) e escreva sua mensagem.
        </>
      ),
    },
  ];
}

export function FaqBox() {
  const t = useT();
  const [open, setOpen] = useState(false);
  const [current, setCurrent] = useState(null); // índice da pergunta aberta (uma por vez)
  // Termos em negrito ficam na cor principal do texto (o resto da resposta é mais discreto).
  const B = ({ children }) => <b style={{ color: t.text }}>{children}</b>;
  const items = faqItems(B);

  return (
    <ExpandBox title="Perguntas Frequentes" icon={<CircleQuestionMark size={17} color={t.primary} />} open={open} onToggle={() => setOpen((o) => !o)}>
      <div style={{ border: `1px solid ${t.border}`, borderRadius: 12, overflow: "hidden", background: t.surfaceAlt }}>
        {items.map((item, i) => {
          const on = current === i;
          return (
            <div key={item.q} style={{ borderTop: i ? `1px solid ${t.border}` : "none" }}>
              <button
                type="button"
                onClick={() => setCurrent(on ? null : i)}
                aria-expanded={on}
                style={{ display: "flex", alignItems: "center", gap: 10, width: "100%", padding: "13px 14px", background: "transparent", border: "none", cursor: "pointer", textAlign: "left", fontFamily: "inherit" }}
              >
                <span style={{ flex: 1, minWidth: 0, fontSize: 13.5, lineHeight: 1.4, fontWeight: on ? 700 : 600, color: on ? t.primary : t.text }}>{item.q}</span>
                <ChevronDown size={16} color={t.textMuted} style={{ flexShrink: 0, transform: on ? "rotate(180deg)" : "none", transition: "transform .2s" }} />
              </button>
              {on && <div style={{ padding: "0 14px 14px", fontSize: 13, lineHeight: 1.6, color: t.textMuted }}>{item.a}</div>}
            </div>
          );
        })}
      </div>
    </ExpandBox>
  );
}
