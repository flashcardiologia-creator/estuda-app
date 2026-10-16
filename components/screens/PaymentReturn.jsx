"use client";

import { useEffect, useRef } from "react";
import { useRouter } from "next/navigation";
import { useT } from "@/components/theme/ThemeProvider";

const MESSAGES = {
  ok: "Pagamento recebido. Estamos liberando o seu acesso…",
  pendente: "Pagamento em análise. Assim que for aprovado, o acesso é liberado sozinho.",
  erro: "O pagamento não foi concluído. Você pode tentar de novo na tela de assinatura.",
};

// Faixa exibida quando a pessoa volta do Mercado Pago (?pagamento=ok|pendente|erro). Enquanto o
// aviso do Mercado Pago não chega, consulta o acesso a cada poucos segundos; quando liberar,
// recarrega o app limpo, porque o conteúdo é lido de outro jeito para quem tem assinatura.
export function PaymentReturn({ status, active }) {
  const t = useT();
  const router = useRouter();
  const startedInactive = useRef(!active);
  const message = MESSAGES[status];

  useEffect(() => {
    if (!message) return;
    if (active) {
      if (startedInactive.current) window.location.replace("/");
      else window.history.replaceState(null, "", "/");
      return;
    }
    if (status === "erro") return;
    let tries = 0;
    const timer = setInterval(() => {
      tries += 1;
      router.refresh();
      if (tries >= 25) clearInterval(timer);
    }, 4000);
    return () => clearInterval(timer);
  }, [message, status, active, router]);

  if (!message || active) return null;
  return (
    <div
      style={{
        position: "sticky",
        top: 0,
        zIndex: 50,
        background: status === "erro" ? t.red : t.primary,
        color: "#fff",
        fontSize: 13.5,
        fontWeight: 600,
        textAlign: "center",
        padding: "10px 16px",
      }}
    >
      {message}
    </div>
  );
}
