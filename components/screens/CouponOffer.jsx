"use client";

import { useState } from "react";
import { Flame, Gift, Check } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { PrimaryButton } from "@/components/ui/Primitives";
import { activateCoupon, dismissCouponOffer } from "@/lib/data/coupons";

const fmtDate = (iso) => new Date(iso).toLocaleDateString("pt-BR");

// Janela de boas-vindas para contas novas: "Deseja ativar o cupom?". Sim = ativa os dias de cortesia
// (uma vez por conta); Agora não = fecha e não volta (o cupom ainda pode ser digitado em Assinatura).
export function CouponOffer({ supabase, offer, onClose }) {
  const t = useT();
  const [busy, setBusy] = useState(false);
  const [result, setResult] = useState(null);

  const activate = async () => {
    if (busy) return;
    setBusy(true);
    const r = await activateCoupon(supabase, offer.code);
    if (r.status === "ok") {
      setResult({ ok: true, days: r.days, until: r.until });
      // Recarrega o app limpo para liberar Questões e Flashcards.
      setTimeout(() => window.location.replace("/"), 2400);
      return;
    }
    const messages = {
      ja_usado: "Este cupom já foi usado nesta conta.",
      expirado: "Este cupom expirou.",
      invalido: "Cupom inválido.",
    };
    setResult({ ok: false, text: messages[r.status] || "Não foi possível ativar agora. Tente de novo em instantes." });
    setBusy(false);
  };

  const later = async () => {
    onClose();
    await dismissCouponOffer(supabase, offer.code);
  };

  return (
    <div
      className="modal-overlay"
      role="dialog"
      aria-modal="true"
      aria-label="Cupom de boas-vindas"
      style={{ position: "fixed", inset: 0, zIndex: 80, background: t.bg, display: "flex", alignItems: "center", justifyContent: "center", padding: 20 }}
    >
      <div style={{ width: "100%", maxWidth: 380, display: "flex", flexDirection: "column", alignItems: "center", gap: 22 }}>
        <div style={{ display: "flex", alignItems: "center", gap: 12 }}>
          <Flame size={38} color={t.amber} fill={t.amber} />
          <div style={{ fontSize: 30, fontWeight: 700, color: t.text }}>FlashCardio</div>
        </div>
        <div style={{ width: "100%", background: t.surface, border: `1px solid ${t.border}`, borderRadius: 20, padding: 28, boxSizing: "border-box" }}>
          <div style={{ display: "flex", alignItems: "center", gap: 10, marginBottom: 10 }}>
            <span style={{ width: 38, height: 38, borderRadius: "50%", background: t.primarySoft, display: "flex", alignItems: "center", justifyContent: "center", flexShrink: 0 }}>
              <Gift size={19} color={t.primary} />
            </span>
            <h2 style={{ fontSize: 18, fontWeight: 700, color: t.text, margin: 0, lineHeight: 1.3 }}>Você ganhou um cupom!</h2>
          </div>

          {result?.ok ? (
            <div style={{ display: "flex", alignItems: "flex-start", gap: 10, background: "rgba(34,197,94,0.14)", borderRadius: 12, padding: "12px 14px", marginTop: 6 }}>
              <Check size={18} color={t.green} style={{ flexShrink: 0, marginTop: 1 }} />
              <div style={{ fontSize: 14, lineHeight: 1.5, color: t.text }}>
                Cupom ativado! Você tem <b>{result.days} dias</b> de acesso completo, até <b>{fmtDate(result.until)}</b>.
              </div>
            </div>
          ) : (
            <>
              <p style={{ fontSize: 13.5, lineHeight: 1.6, color: t.textMuted, margin: 0 }}>
                O cupom <b style={{ color: t.text }}>{offer.code}</b> dá <b style={{ color: t.text }}>{offer.days} dias</b> de acesso completo a Questões e Flashcards, contados a partir de agora.
                Ele só pode ser usado uma vez nesta conta. Deseja ativar?
              </p>
              {result && !result.ok && <div style={{ fontSize: 12.5, color: t.red, marginTop: 12 }}>{result.text}</div>}
              <div style={{ marginTop: 18 }}>
                <PrimaryButton full onClick={activate} disabled={busy}>
                  {busy ? "Ativando…" : "Sim, ativar cupom"}
                </PrimaryButton>
              </div>
              <div style={{ textAlign: "center", marginTop: 14 }}>
                <button type="button" onClick={later} disabled={busy} style={{ background: "transparent", border: "none", color: t.textMuted, fontSize: 13, cursor: "pointer" }}>
                  Agora não
                </button>
              </div>
            </>
          )}
        </div>
      </div>
    </div>
  );
}
