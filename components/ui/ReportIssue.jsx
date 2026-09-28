"use client";

import { useState } from "react";
import { HelpCircle, X } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { PrimaryButton } from "@/components/ui/Primitives";
import { reportContentIssue } from "@/lib/data/reports";

const REASONS = [
  "Enunciado ou alternativas com erro",
  "Gabarito (resposta correta) errado",
  "Comentário/explicação errado ou confuso",
  "Imagem não aparece ou está errada",
  "Erro de português/digitação",
];

export function ReportButton({ onClick }) {
  const t = useT();
  return (
    <button
      onClick={onClick}
      title="Reportar um erro"
      style={{
        display: "flex",
        alignItems: "center",
        justifyContent: "center",
        width: 26,
        height: 26,
        borderRadius: "50%",
        background: "transparent",
        border: `1px solid ${t.border}`,
        color: t.textMuted,
        cursor: "pointer",
        flexShrink: 0,
        padding: 0,
      }}
    >
      <HelpCircle size={14} />
    </button>
  );
}

export function ReportIssueModal({ supabase, userId, itemType, itemId, onClose }) {
  const t = useT();
  const [reason, setReason] = useState(null);
  const [details, setDetails] = useState("");
  const [sending, setSending] = useState(false);
  const [sent, setSent] = useState(false);
  const [error, setError] = useState("");

  const submit = async () => {
    if (!reason) return;
    if (reason === "Outro" && !details.trim()) return;
    setSending(true);
    setError("");
    try {
      await reportContentIssue(supabase, userId, itemType, itemId, reason, details.trim());
      setSent(true);
      setTimeout(onClose, 1300);
    } catch (err) {
      setError(err.message || "Não foi possível enviar. Tente de novo.");
    } finally {
      setSending(false);
    }
  };

  const cancelSelection = () => {
    setReason(null);
    setDetails("");
    setError("");
  };

  return (
    <div
      style={{
        position: "fixed",
        inset: 0,
        background: "rgba(0,0,0,0.5)",
        display: "flex",
        alignItems: "center",
        justifyContent: "center",
        zIndex: 60,
        padding: 20,
      }}
    >
      <div style={{ background: t.surface, border: `1px solid ${t.border}`, borderRadius: 18, padding: 22, maxWidth: 400, width: "100%" }}>
        <div style={{ display: "flex", alignItems: "center", justifyContent: "space-between", marginBottom: 16 }}>
          <h3 style={{ fontSize: 16, color: t.text, margin: 0 }}>Reportar um erro</h3>
          <button onClick={onClose} style={{ background: "transparent", border: "none", cursor: "pointer", padding: 4 }}>
            <X size={18} color={t.textMuted} />
          </button>
        </div>

        {sent ? (
          <div style={{ fontSize: 13.5, color: t.green, textAlign: "center", padding: "20px 0" }}>
            Obrigado! Seu report foi enviado.
          </div>
        ) : (
          <>
            <div style={{ fontSize: 12.5, color: t.textMuted, marginBottom: 14 }}>
              O que está errado {itemType === "flashcard" ? "neste flashcard" : "nesta questão"}?
            </div>
            <div style={{ display: "flex", flexDirection: "column", gap: 8 }}>
              {[...REASONS, "Outro"].map((r) => (
                <button
                  key={r}
                  onClick={() => setReason(r)}
                  disabled={sending}
                  style={{
                    textAlign: "left",
                    padding: "10px 12px",
                    borderRadius: 10,
                    border: `1.5px solid ${reason === r ? t.primary : t.border}`,
                    background: reason === r ? t.primarySoft : t.surfaceAlt,
                    color: t.text,
                    fontSize: 13,
                    cursor: sending ? "default" : "pointer",
                  }}
                >
                  {r}
                </button>
              ))}
            </div>

            {reason && (
              <div style={{ marginTop: 12 }}>
                <textarea
                  value={details}
                  onChange={(e) => setDetails(e.target.value)}
                  placeholder={reason === "Outro" ? "Descreva o erro..." : "Descreva mais, se quiser (opcional)"}
                  rows={4}
                  autoFocus={reason === "Outro"}
                  style={{
                    width: "100%",
                    padding: 10,
                    borderRadius: 10,
                    border: `1px solid ${t.border}`,
                    background: t.surfaceAlt,
                    color: t.text,
                    fontSize: 16,
                    fontFamily: "inherit",
                    resize: "vertical",
                    boxSizing: "border-box",
                  }}
                />
              </div>
            )}

            {reason && (
              <div style={{ display: "flex", gap: 10, marginTop: 16 }}>
                <div style={{ flex: 1, minWidth: 0 }}>
                  <PrimaryButton full variant="ghost" disabled={sending} onClick={cancelSelection}>
                    Cancelar
                  </PrimaryButton>
                </div>
                <div style={{ flex: 1, minWidth: 0 }}>
                  <PrimaryButton
                    full
                    disabled={sending || (reason === "Outro" && !details.trim())}
                    onClick={submit}
                  >
                    Confirmar
                  </PrimaryButton>
                </div>
              </div>
            )}

            {error && <div style={{ fontSize: 12, color: t.red, marginTop: 10 }}>{error}</div>}
          </>
        )}
      </div>
    </div>
  );
}
