"use client";

import { Flame, Gift } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { PrimaryButton } from "@/components/ui/Primitives";
import { quizTable } from "@/lib/data/quiz";

const fmtDate = (iso) => new Date(iso).toLocaleDateString("pt-BR");
const plural = (n, one, many) => `${n} ${n === 1 ? one : many}`;

// Primeira abertura do app depois de criar a conta pelo quiz de boas-vindas: mostra os dias liberados e por quê.
export function QuizReward({ reward, onClose }) {
  const t = useT();
  const table = quizTable();
  const mine = Math.min(reward.acertos, 3);

  return (
    <div
      className="modal-overlay"
      role="dialog"
      aria-modal="true"
      aria-label="Dias grátis liberados"
      style={{ position: "fixed", inset: 0, zIndex: 80, background: t.bg, display: "flex", alignItems: "center", justifyContent: "center", padding: 20 }}
    >
      <div style={{ width: "100%", maxWidth: 380, display: "flex", flexDirection: "column", alignItems: "center", gap: 22 }}>
        <div style={{ display: "flex", alignItems: "center", gap: 12 }}>
          <Flame size={38} color={t.amber} fill={t.amber} />
          <div style={{ fontSize: 30, fontWeight: 700, color: t.text }}>FlashCardio</div>
        </div>
        <div style={{ width: "100%", background: t.surface, border: `1px solid ${t.border}`, borderRadius: 20, padding: 26, boxSizing: "border-box" }}>
          <div style={{ display: "flex", alignItems: "center", gap: 10, marginBottom: 10 }}>
            <span style={{ width: 38, height: 38, borderRadius: "50%", background: t.primarySoft, display: "flex", alignItems: "center", justifyContent: "center", flexShrink: 0 }}>
              <Gift size={19} color={t.primary} />
            </span>
            <h2 style={{ fontSize: 18, fontWeight: 700, color: t.text, margin: 0, lineHeight: 1.3 }}>
              Você ganhou {reward.dias} dias <span style={{ color: t.primary }}>GRÁTIS</span>!
            </h2>
          </div>
          <p style={{ fontSize: 13.5, lineHeight: 1.6, color: t.textMuted, margin: 0 }}>
            Você acertou <b style={{ color: t.text }}>{reward.acertos} de 3</b> questões do quiz de boas-vindas. Seu acesso completo a Questões e Flashcards vale até{" "}
            <b style={{ color: t.text }}>{fmtDate(reward.until)}</b>. Não precisa de cupom.
          </p>
          <div style={{ marginTop: 14, border: `1px solid ${t.border}`, borderRadius: 12, overflow: "hidden" }}>
            {table.map((row) => {
              const isMine = row.acertos === mine;
              return (
                <div key={row.acertos} style={{ display: "flex", justifyContent: "space-between", padding: "8px 12px", fontSize: 13, background: isMine ? t.primarySoft : "transparent", color: isMine ? t.text : t.textMuted, fontWeight: isMine ? 700 : 500, borderTop: row.acertos ? `1px solid ${t.border}` : "none" }}>
                  <span>{plural(row.acertos, "acerto", "acertos")}</span>
                  <span>{plural(row.dias, "dia", "dias")}</span>
                </div>
              );
            })}
          </div>
          <div style={{ marginTop: 18 }}>
            <PrimaryButton full onClick={onClose}>
              Começar a estudar
            </PrimaryButton>
          </div>
        </div>
      </div>
    </div>
  );
}
