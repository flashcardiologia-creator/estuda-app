"use client";

import { Crown } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { PLAN_LABEL } from "@/lib/access";

const MESES = ["jan", "fev", "mar", "abr", "mai", "jun", "jul", "ago", "set", "out", "nov", "dez"];

// "14 de nov de 2027" (sem o ponto que o navegador põe depois do mês abreviado).
const dataCurta = (iso) => {
  const d = new Date(iso);
  return `${d.getDate()} de ${MESES[d.getMonth()]} de ${d.getFullYear()}`;
};

// Cartão da assinatura ativa na Minha Conta (Cortesia, Mensal ou Anual): plano, situação, botão Prolongar, dias restantes e data final.
export function SubscriptionCard({ access, onProlongar }) {
  const t = useT();
  const days = access.daysLeft;
  return (
    <div style={{ padding: 14, borderRadius: 14, border: `1px solid ${t.primary}40`, background: t.primarySoft, boxSizing: "border-box" }}>
      <div style={{ display: "flex", alignItems: "center", justifyContent: "space-between", gap: 10 }}>
        <div style={{ display: "flex", alignItems: "center", gap: 12, minWidth: 0 }}>
          <div
            style={{
              width: 38,
              height: 38,
              borderRadius: 11,
              background: t.primarySoft,
              border: `1px solid ${t.primary}33`,
              display: "flex",
              alignItems: "center",
              justifyContent: "center",
              flexShrink: 0,
            }}
          >
            <Crown size={19} color={t.primary} />
          </div>
          <div style={{ minWidth: 0 }}>
            <div style={{ fontSize: 15.5, fontWeight: 700, color: t.text, lineHeight: 1.2 }}>{PLAN_LABEL[access.plan] || "Assinatura"}</div>
            <div style={{ display: "flex", alignItems: "center", gap: 6, marginTop: 4, fontSize: 12.5, fontWeight: 700, color: t.green }}>
              <span style={{ width: 7, height: 7, borderRadius: "50%", background: t.green, flexShrink: 0 }} />
              Ativa
            </div>
          </div>
        </div>
        <button
          type="button"
          onClick={onProlongar}
          style={{
            flexShrink: 0,
            padding: "8px 14px",
            borderRadius: 10,
            border: `1px solid ${t.primary}55`,
            background: t.primarySoft,
            color: t.primary,
            fontSize: 13,
            fontWeight: 700,
            fontFamily: "inherit",
            cursor: "pointer",
          }}
        >
          Prolongar
        </button>
      </div>

      {(days != null || access.expiresAt) && (
        <div style={{ marginTop: 14 }}>
          {days != null &&
            (days === 0 ? (
              <div style={{ fontSize: 16, fontWeight: 800, color: t.amber }}>Vence hoje</div>
            ) : (
              <div>
                <span style={{ fontSize: 24, fontWeight: 800, color: t.primary, lineHeight: 1 }}>{days}</span>{" "}
                <span style={{ fontSize: 14, color: t.textMuted }}>{days === 1 ? "dia restante" : "dias restantes"}</span>
              </div>
            ))}
          {access.expiresAt && <div style={{ fontSize: 12.5, color: t.textMuted, marginTop: days != null ? 6 : 0 }}>até {dataCurta(access.expiresAt)}</div>}
        </div>
      )}
    </div>
  );
}
