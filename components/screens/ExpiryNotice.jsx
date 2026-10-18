"use client";

import { Flame } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { PrimaryButton } from "@/components/ui/Primitives";
import { PLAN_LABEL } from "@/lib/access";

// Aviso de vencimento: janela no estilo da tela de aceite dos termos, exibida ao abrir o app nos dias
// 7, 3, 1 e 0 antes de a assinatura acabar (uma vez por dia). days = dias de calendário que faltam.
export function ExpiryNotice({ access, days, onExtend, onLater }) {
  const t = useT();
  const today = days === 0;
  const title = today ? "Sua assinatura vence hoje" : days === 1 ? "Sua assinatura vence amanhã" : `Sua assinatura vence em ${days} dias`;
  const text = today
    ? "Hoje é o último dia do seu plano. Prolongue agora para continuar com Questões e Flashcards amanhã, sem perder nenhum dia."
    : "Prolongue agora e não perca nenhum dia: os dias novos entram depois do fim do plano atual. Depois de vencer, Questões e Flashcards ficam bloqueados.";
  const accent = today ? t.red : t.amber;
  const row = { display: "flex", justifyContent: "space-between", padding: "10px 14px", fontSize: 13.5 };

  return (
    <div
      className="modal-overlay"
      role="dialog"
      aria-modal="true"
      aria-label={title}
      style={{ position: "fixed", inset: 0, zIndex: 70, background: t.bg, display: "flex", alignItems: "center", justifyContent: "center", padding: 20 }}
    >
      <div style={{ width: "100%", maxWidth: 380, display: "flex", flexDirection: "column", alignItems: "center", gap: 22 }}>
        <div style={{ display: "flex", alignItems: "center", gap: 12 }}>
          <Flame size={38} color={t.amber} fill={t.amber} />
          <div style={{ fontSize: 30, fontWeight: 700, color: t.text }}>FlashCardio</div>
        </div>
        <div style={{ width: "100%", background: t.surface, border: `1px solid ${t.border}`, borderRadius: 20, padding: 28, boxSizing: "border-box" }}>
          <h2 style={{ fontSize: 18, fontWeight: 700, color: t.text, margin: "0 0 10px" }}>{title}</h2>
          <p style={{ fontSize: 13.5, lineHeight: 1.6, color: t.textMuted, margin: 0 }}>{text}</p>
          <div style={{ margin: "16px 0 18px", border: `1px solid ${t.border}`, background: t.surfaceAlt, borderRadius: 12, overflow: "hidden" }}>
            <div style={row}>
              <span style={{ color: t.textMuted }}>Plano atual</span>
              <b style={{ color: accent }}>{PLAN_LABEL[access.plan] || "Ativo"}</b>
            </div>
            <div style={{ ...row, borderTop: `1px solid ${t.border}` }}>
              <span style={{ color: t.textMuted }}>Vence em</span>
              <b style={{ color: accent }}>{new Date(access.expiresAt).toLocaleDateString("pt-BR")}</b>
            </div>
            <div style={{ ...row, borderTop: `1px solid ${t.border}` }}>
              <span style={{ color: t.textMuted }}>Restam</span>
              <b style={{ color: accent }}>{today ? "hoje" : days === 1 ? "1 dia" : `${days} dias`}</b>
            </div>
          </div>
          <PrimaryButton full onClick={onExtend}>
            Prolongar assinatura
          </PrimaryButton>
          <div style={{ textAlign: "center", marginTop: 14 }}>
            <button type="button" onClick={onLater} style={{ background: "transparent", border: "none", color: t.textMuted, fontSize: 13, cursor: "pointer" }}>
              Agora não
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}
