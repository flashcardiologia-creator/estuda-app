"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import { useT } from "@/components/theme/ThemeProvider";

const MESSAGES = {
  ok: "Pagamento recebido. Estamos liberando o seu acesso…",
  pendente: "Pagamento em análise. Assim que for aprovado, o acesso é liberado sozinho.",
  erro: "O pagamento não foi concluído. Você pode tentar de novo na tela de assinatura.",
};

const fmtDate = (iso) => new Date(iso).toLocaleDateString("pt-BR");
const clearParam = () => window.history.replaceState(null, "", "/");

// Faixa exibida quando a pessoa volta do Mercado Pago (?pagamento=ok|pendente|erro).
// - Quem não tinha assinatura: consulta o acesso a cada poucos segundos e, quando libera, recarrega o
//   app limpo (o conteúdo é lido de outro jeito para quem assina).
// - Quem já assinava (prolongou): consulta até o vencimento mudar e mostra a nova data.
export function PaymentReturn({ status, active, expiresAt }) {
  const t = useT();
  const router = useRouter();
  const [startedInactive] = useState(!active);
  const [expiresAtOnReturn] = useState(expiresAt);
  const [hidden, setHidden] = useState(false);
  const renewal = active && !startedInactive;
  const extended = renewal && expiresAt !== expiresAtOnReturn;
  const message = MESSAGES[status];

  useEffect(() => {
    if (!message) return;
    if (active && startedInactive) {
      window.location.replace("/");
      return;
    }
    if (extended) {
      const timer = setTimeout(() => {
        clearParam();
        setHidden(true);
      }, 9000);
      return () => clearTimeout(timer);
    }
    if (status === "erro") return;
    let tries = 0;
    const timer = setInterval(() => {
      tries += 1;
      router.refresh();
      if (tries >= 25) {
        clearInterval(timer);
        if (renewal) {
          clearParam();
          setHidden(true);
        }
      }
    }, 4000);
    return () => clearInterval(timer);
  }, [message, status, active, startedInactive, renewal, extended, router]);

  if (!message || hidden) return null;
  if (active && !renewal) return null;

  let text = message;
  let background = status === "erro" ? t.red : t.primary;
  if (renewal && status !== "erro") {
    text = extended ? `Pagamento aprovado. Sua assinatura foi prolongada até ${fmtDate(expiresAt)}.` : "Pagamento recebido. Estamos prolongando a sua assinatura…";
    if (extended) background = t.green;
  }
  return (
    <div
      style={{
        position: "sticky",
        top: 0,
        zIndex: 50,
        background,
        color: "#fff",
        fontSize: 13.5,
        fontWeight: 600,
        textAlign: "center",
        padding: "10px 16px",
      }}
    >
      {text}
    </div>
  );
}
