"use client";

import { useEffect, useRef } from "react";
import { Gift, X, Check } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { PrimaryButton } from "@/components/ui/Primitives";

export const PROMO_CODE = "#10DIASGRATIS";
// Mesma validade do cupom no banco (supabase/cupom_10diasgratis.sql: 02/12/2026 00:00 em Brasília). Depois disso o anúncio some sozinho.
export const PROMO_UNTIL = new Date("2026-12-02T00:00:00-03:00").getTime();
const SESSION_KEY = "fc-promo-10dias-visto";

// Anúncio para quem ainda não tem conta (tela de entrar/cadastrar): aparece uma vez a cada abertura do site.
export function promoAlreadySeen() {
  try {
    return window.sessionStorage.getItem(SESSION_KEY) === "1";
  } catch {
    return false;
  }
}

export function markPromoSeen() {
  try {
    window.sessionStorage.setItem(SESSION_KEY, "1");
  } catch {
    // navegação privada: o anúncio pode voltar ao recarregar, sem problema
  }
}

export function LoginCouponPromo({ onGetCoupon, onClose }) {
  const t = useT();
  const buttonRef = useRef(null);

  useEffect(() => {
    buttonRef.current?.focus();
    const onKey = (e) => {
      if (e.key === "Escape") onClose();
    };
    window.addEventListener("keydown", onKey);
    return () => window.removeEventListener("keydown", onKey);
  }, [onClose]);

  const dim = t.name === "light" ? "rgba(30,26,60,0.5)" : "rgba(0,0,0,0.7)";
  const beneficios = ["Questões comentadas de provas de título e residência", "Flashcards para memorizar rápido", "Sem cartão de crédito para ativar"];

  return (
    <div
      className="modal-overlay"
      role="dialog"
      aria-modal="true"
      aria-labelledby="promo-titulo"
      onClick={onClose}
      style={{ position: "fixed", inset: 0, zIndex: 90, background: dim, display: "flex", alignItems: "center", justifyContent: "center", padding: 20, overflowY: "auto" }}
    >
      <div
        onClick={(e) => e.stopPropagation()}
        style={{ position: "relative", width: "100%", maxWidth: 360, background: t.surface, border: `1px solid ${t.border}`, borderRadius: 22, padding: "30px 26px 24px", boxSizing: "border-box", boxShadow: "0 20px 60px rgba(0,0,0,0.45)", textAlign: "center" }}
      >
        <button
          type="button"
          onClick={onClose}
          aria-label="Fechar anúncio"
          style={{ position: "absolute", top: 10, right: 10, width: 36, height: 36, display: "flex", alignItems: "center", justifyContent: "center", background: "transparent", border: "none", cursor: "pointer", color: t.textMuted, borderRadius: "50%" }}
        >
          <X size={18} />
        </button>

        <span style={{ display: "inline-flex", alignItems: "center", justifyContent: "center", width: 56, height: 56, borderRadius: "50%", background: t.primarySoft }}>
          <Gift size={28} color={t.primary} />
        </span>

        <div style={{ marginTop: 14 }}>
          <span style={{ display: "inline-block", fontSize: 11, fontWeight: 800, letterSpacing: 0.8, textTransform: "uppercase", color: t.amber, border: `1px solid ${t.amber}`, borderRadius: 999, padding: "3px 10px" }}>
            Cupom por tempo limitado
          </span>
        </div>

        <h2 id="promo-titulo" style={{ fontSize: 22, lineHeight: 1.25, fontWeight: 800, color: t.text, margin: "12px 0 8px" }}>
          Aproveite e teste grátis por 10 dias!
        </h2>
        <p style={{ fontSize: 14, lineHeight: 1.55, color: t.textMuted, margin: 0 }}>
          Crie sua conta e use o cupom abaixo para liberar o acesso completo.
        </p>

        <div
          style={{ margin: "16px auto 0", display: "inline-block", fontFamily: "ui-monospace, Consolas, monospace", fontSize: 20, fontWeight: 800, letterSpacing: 0.5, color: t.primary, background: t.primarySoft, border: `1.5px dashed ${t.primary}`, borderRadius: 12, padding: "10px 18px" }}
        >
          {PROMO_CODE}
        </div>

        <ul style={{ listStyle: "none", margin: "18px 0 0", padding: 0, display: "flex", flexDirection: "column", gap: 8, textAlign: "left" }}>
          {beneficios.map((b) => (
            <li key={b} style={{ display: "flex", alignItems: "flex-start", gap: 8, fontSize: 13, lineHeight: 1.45, color: t.text }}>
              <Check size={16} color={t.green} style={{ flexShrink: 0, marginTop: 1 }} />
              <span>{b}</span>
            </li>
          ))}
        </ul>

        <div ref={buttonRef} tabIndex={-1} style={{ marginTop: 22, outline: "none" }}>
          <PrimaryButton full onClick={onGetCoupon}>
            Pegar cupom
          </PrimaryButton>
        </div>
        <button type="button" onClick={onClose} style={{ marginTop: 12, background: "transparent", border: "none", color: t.textMuted, fontSize: 13, cursor: "pointer", padding: 8 }}>
          Agora não
        </button>
      </div>
    </div>
  );
}
