"use client";

import { useEffect, useState } from "react";
import { X } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { PrimaryButton } from "@/components/ui/Primitives";
import { LegalSections } from "@/components/screens/LegalDocument";
import { LEGAL_UPDATED, PRIVACY, TERMS } from "@/lib/legal/content";

// Termos de Uso e Política de Privacidade numa janela por cima da tela atual. Ler os textos não tira
// a pessoa do cadastro, então nada do que ela já digitou se perde.
// initial: "termos" ou "privacidade". closeLabel: texto do botão de voltar.
export function LegalModal({ initial = "termos", onClose, closeLabel = "Voltar ao cadastro" }) {
  const t = useT();
  const [which, setWhich] = useState(initial);
  const doc = which === "privacidade" ? PRIVACY : TERMS;

  useEffect(() => {
    const onKey = (e) => {
      if (e.key === "Escape") onClose();
    };
    window.addEventListener("keydown", onKey);
    return () => window.removeEventListener("keydown", onKey);
  }, [onClose]);

  return (
    <div
      className="modal-overlay"
      onClick={onClose}
      style={{ position: "fixed", inset: 0, background: "rgba(0,0,0,0.6)", zIndex: 60, display: "flex", alignItems: "center", justifyContent: "center", padding: 14 }}
    >
      <div
        role="dialog"
        aria-modal="true"
        aria-label={doc.title}
        onClick={(e) => e.stopPropagation()}
        style={{
          background: t.surface,
          border: `1px solid ${t.border}`,
          borderRadius: 20,
          width: "100%",
          maxWidth: 560,
          maxHeight: "88dvh",
          display: "flex",
          flexDirection: "column",
          overflow: "hidden",
        }}
      >
        <div style={{ display: "flex", alignItems: "flex-start", justifyContent: "space-between", gap: 12, padding: "18px 20px 12px", borderBottom: `1px solid ${t.border}` }}>
          <div style={{ minWidth: 0 }}>
            <h2 style={{ margin: 0, fontSize: 17, fontWeight: 700, color: t.text, lineHeight: 1.3 }}>{doc.title}</h2>
            <div style={{ fontSize: 12, color: t.textMuted, marginTop: 3 }}>Última atualização: {LEGAL_UPDATED}</div>
          </div>
          <button
            type="button"
            onClick={onClose}
            aria-label="Fechar"
            style={{ width: 32, height: 32, flexShrink: 0, borderRadius: 10, border: `1px solid ${t.border}`, background: "transparent", color: t.textMuted, display: "flex", alignItems: "center", justifyContent: "center", cursor: "pointer" }}
          >
            <X size={16} />
          </button>
        </div>

        <div style={{ flex: 1, minHeight: 0, overflowY: "auto", padding: "16px 20px 6px" }}>
          <LegalSections doc={doc} />
        </div>

        <div style={{ display: "flex", flexDirection: "column", gap: 10, padding: "12px 20px 18px", borderTop: `1px solid ${t.border}` }}>
          <button
            type="button"
            onClick={() => setWhich(which === "termos" ? "privacidade" : "termos")}
            style={{ background: "transparent", border: "none", cursor: "pointer", color: t.primary, fontSize: 13.5, fontWeight: 600, padding: 0, textAlign: "left" }}
          >
            {which === "termos" ? "Ler a Política de Privacidade" : "Ler os Termos de Uso"}
          </button>
          <PrimaryButton full onClick={onClose}>
            {closeLabel}
          </PrimaryButton>
        </div>
      </div>
    </div>
  );
}
