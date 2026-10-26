"use client";

import { useEffect, useRef, useState } from "react";
import { X, Flag, Check, TriangleAlert } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { PrimaryButton } from "@/components/ui/Primitives";
import { reportContentIssue } from "@/lib/data/reports";

// O texto de cada motivo é o que vai para o banco (content_reports.reason): não mudar sem avisar quem lê os reportes.
const REASONS = [
  "Enunciado ou alternativas com erro",
  "Gabarito errado",
  "Comentário/explicação errado ou confuso",
  "Imagem não aparece ou está errada",
  "Erro de português/digitação",
  "Outro",
];

export function ReportButton({ onClick }) {
  const t = useT();
  return (
    <button
      onClick={onClick}
      title="Reportar um erro"
      aria-label="Reportar um erro"
      style={{
        display: "flex",
        alignItems: "center",
        justifyContent: "center",
        width: 28,
        height: 28,
        borderRadius: "50%",
        background: "transparent",
        border: `1px solid ${t.border}`,
        color: t.textMuted,
        cursor: "pointer",
        flexShrink: 0,
        padding: 0,
      }}
    >
      {/* "?" grande dentro do círculo do botão (antes era o ícone HelpCircle pequeno, que repetia o círculo). */}
      <span aria-hidden="true" style={{ fontSize: 16, fontWeight: 700, lineHeight: 1, marginTop: -1 }}>
        ?
      </span>
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
  const [focus, setFocus] = useState(false);
  const detailsRef = useRef(null);
  const closeTimer = useRef(null);

  const isOther = reason === "Outro";
  const canSend = !!reason && !(isOther && !details.trim());
  const what = itemType === "flashcard" ? "neste flashcard" : "nesta questão";

  // Esc fecha a janela (menos enquanto envia).
  useEffect(() => {
    const onKey = (e) => {
      if (e.key === "Escape" && !sending) onClose();
    };
    window.addEventListener("keydown", onKey);
    return () => window.removeEventListener("keydown", onKey);
  }, [sending, onClose]);

  useEffect(() => () => clearTimeout(closeTimer.current), []);

  // Ao escolher o motivo, o campo de detalhes aparece embaixo: leva a tela até ele.
  useEffect(() => {
    if (reason) detailsRef.current?.scrollIntoView({ block: "nearest", behavior: "smooth" });
  }, [reason]);

  const submit = async () => {
    if (!canSend || sending) return;
    setSending(true);
    setError("");
    try {
      await reportContentIssue(supabase, userId, itemType, itemId, reason, details.trim());
      setSent(true);
      closeTimer.current = setTimeout(onClose, 4000);
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
      className="modal-overlay"
      onClick={(e) => e.target === e.currentTarget && !sending && onClose()}
      style={{
        position: "fixed",
        inset: 0,
        background: t.name === "dark" ? "rgba(5,11,30,0.62)" : "rgba(30,26,60,0.4)",
        backdropFilter: "blur(3px)",
        WebkitBackdropFilter: "blur(3px)",
        display: "flex",
        alignItems: "center",
        justifyContent: "center",
        zIndex: 60,
        padding: 20,
      }}
    >
      <div
        role="dialog"
        aria-modal="true"
        aria-labelledby="report-title"
        className="fc-sheet"
        style={{ background: t.surface, border: `1px solid ${t.border}`, borderRadius: 20, padding: "20px 20px 22px", maxWidth: 400, width: "100%", boxSizing: "border-box", boxShadow: "0 18px 50px rgba(0,0,0,0.35)" }}
      >
        {sent ? (
          <div style={{ textAlign: "center", padding: "10px 4px 2px" }}>
            <span style={{ width: 60, height: 60, borderRadius: "50%", background: "rgba(34,197,94,0.14)", display: "inline-flex", alignItems: "center", justifyContent: "center" }}>
              <Check size={30} color={t.green} strokeWidth={2.6} />
            </span>
            <h3 id="report-title" style={{ fontSize: 18, fontWeight: 700, color: t.text, margin: "14px 0 6px" }}>
              Reporte enviado
            </h3>
            <p style={{ fontSize: 13.5, lineHeight: 1.55, color: t.textMuted, margin: 0 }}>
              Obrigado por ajudar a melhorar o FlashCardio. Se for pertinente, você receberá a resposta no seu e-mail.
            </p>
            <div style={{ marginTop: 18 }}>
              <PrimaryButton full variant="ghost" onClick={onClose}>
                Fechar
              </PrimaryButton>
            </div>
          </div>
        ) : (
          <>
            <div style={{ display: "flex", alignItems: "center", gap: 12 }}>
              <span style={{ width: 40, height: 40, borderRadius: 12, background: "rgba(242,169,59,0.16)", display: "flex", alignItems: "center", justifyContent: "center", flexShrink: 0 }}>
                <Flag size={19} color={t.amber} />
              </span>
              <div style={{ flex: 1, minWidth: 0 }}>
                <h3 id="report-title" style={{ fontSize: 17, fontWeight: 700, color: t.text, margin: 0, lineHeight: 1.25 }}>
                  Reportar um erro
                </h3>
                <div style={{ fontSize: 12.5, color: t.textMuted, marginTop: 2 }}>O que está errado {what}?</div>
              </div>
              <button
                onClick={onClose}
                disabled={sending}
                aria-label="Fechar"
                style={{ width: 36, height: 36, borderRadius: "50%", background: "transparent", border: "none", cursor: "pointer", display: "flex", alignItems: "center", justifyContent: "center", flexShrink: 0, marginRight: -6 }}
              >
                <X size={19} color={t.textMuted} />
              </button>
            </div>

            <div role="radiogroup" aria-label="Motivo do reporte" style={{ display: "flex", flexDirection: "column", gap: 8, marginTop: 16 }}>
              {REASONS.map((label) => {
                const on = reason === label;
                return (
                  <button
                    key={label}
                    type="button"
                    role="radio"
                    aria-checked={on}
                    onClick={() => setReason(label)}
                    disabled={sending}
                    style={{
                      display: "flex",
                      alignItems: "center",
                      gap: 12,
                      width: "100%",
                      minHeight: 48,
                      textAlign: "left",
                      padding: "10px 14px",
                      borderRadius: 12,
                      border: `1.5px solid ${on ? t.primary : t.border}`,
                      background: on ? t.primarySoft : t.surfaceAlt,
                      color: t.text,
                      fontSize: 13.5,
                      lineHeight: 1.35,
                      fontFamily: "inherit",
                      cursor: sending ? "default" : "pointer",
                      transition: "border-color .15s, background .15s",
                    }}
                  >
                    {/* Bola de seleção à esquerda (marcada = ponto roxo no centro), no lugar do ícone de cada motivo. */}
                    <span aria-hidden="true" style={{ width: 20, height: 20, borderRadius: "50%", border: `2px solid ${on ? t.primary : t.textMuted}`, display: "flex", alignItems: "center", justifyContent: "center", flexShrink: 0, boxSizing: "border-box" }}>
                      {on && <span style={{ width: 10, height: 10, borderRadius: "50%", background: t.primary }} />}
                    </span>
                    <span style={{ flex: 1, minWidth: 0, fontWeight: on ? 600 : 500 }}>{label}</span>
                  </button>
                );
              })}
            </div>

            {reason && (
              <div ref={detailsRef} style={{ marginTop: 14 }}>
                <label htmlFor="report-details" style={{ display: "flex", justifyContent: "space-between", fontSize: 12, fontWeight: 700, color: t.textMuted, marginBottom: 6 }}>
                  <span>Detalhes</span>
                  <span style={{ fontWeight: 500 }}>{isOther ? "Obrigatório" : "Opcional"}</span>
                </label>
                <textarea
                  id="report-details"
                  value={details}
                  onChange={(e) => setDetails(e.target.value)}
                  onFocus={() => setFocus(true)}
                  onBlur={() => setFocus(false)}
                  placeholder={isOther ? "Descreva o erro…" : "Conte mais para a gente corrigir mais rápido"}
                  rows={4}
                  autoFocus={isOther}
                  style={{
                    width: "100%",
                    padding: "11px 12px",
                    borderRadius: 12,
                    border: `1.5px solid ${focus ? t.primary : t.border}`,
                    background: t.surfaceAlt,
                    color: t.text,
                    fontSize: 16,
                    lineHeight: 1.45,
                    fontFamily: "inherit",
                    resize: "vertical",
                    boxSizing: "border-box",
                    outline: "none",
                    transition: "border-color .15s",
                  }}
                />
              </div>
            )}

            {error && (
              <div style={{ display: "flex", alignItems: "flex-start", gap: 8, fontSize: 12.5, lineHeight: 1.45, color: t.red, background: "rgba(229,72,77,0.12)", borderRadius: 10, padding: "9px 12px", marginTop: 12 }}>
                <TriangleAlert size={15} style={{ flexShrink: 0, marginTop: 1 }} />
                <span>{error}</span>
              </div>
            )}

            {reason && (
              <div style={{ display: "flex", gap: 10, marginTop: 16 }}>
                <div style={{ flex: 1, minWidth: 0 }}>
                  <PrimaryButton full variant="ghost" disabled={sending} onClick={cancelSelection}>
                    Voltar
                  </PrimaryButton>
                </div>
                <div style={{ flex: 1.4, minWidth: 0 }}>
                  <PrimaryButton full disabled={sending || !canSend} onClick={submit}>
                    {sending ? "Enviando…" : "Enviar"}
                  </PrimaryButton>
                </div>
              </div>
            )}
          </>
        )}
      </div>
    </div>
  );
}
