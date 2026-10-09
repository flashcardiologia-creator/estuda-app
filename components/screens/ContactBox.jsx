"use client";

import { useState } from "react";
import { MessageSquare, Check } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { ExpandBox, PrimaryButton, Chip } from "@/components/ui/Primitives";
import { CONTACT_MAX, sendContactMessage } from "@/lib/data/contact";

const ASSUNTOS = ["Dúvida", "Sugestão", "Problema", "Outro"];

export function ContactBox({ supabase, userId, userEmail }) {
  const t = useT();
  const [open, setOpen] = useState(false);
  const [assunto, setAssunto] = useState("Dúvida");
  const [mensagem, setMensagem] = useState("");
  const [sending, setSending] = useState(false);
  const [sent, setSent] = useState(false);
  const [error, setError] = useState("");

  const send = async () => {
    if (!mensagem.trim()) return;
    setSending(true);
    setError("");
    try {
      await sendContactMessage(supabase, userId, assunto, mensagem);
      setSent(true);
      setMensagem("");
    } catch (err) {
      setError(err.message || "Não foi possível enviar.");
    } finally {
      setSending(false);
    }
  };

  return (
    <ExpandBox title="Contato" icon={<MessageSquare size={17} color={t.primary} />} open={open} onToggle={() => setOpen((o) => !o)}>
      {sent ? (
        <div>
          <div style={{ display: "flex", alignItems: "center", gap: 8, fontSize: 14, fontWeight: 700, color: t.green, marginBottom: 8 }}>
            <Check size={16} /> Mensagem enviada!
          </div>
          <div style={{ fontSize: 13, color: t.textMuted, lineHeight: 1.6, marginBottom: 14 }}>
            Obrigado pelo contato. Se precisar de resposta, ela chega no seu e-mail{userEmail ? ` (${userEmail})` : ""}.
          </div>
          <PrimaryButton full variant="ghost" onClick={() => setSent(false)}>
            Enviar outra mensagem
          </PrimaryButton>
        </div>
      ) : (
        <>
          <div style={{ fontSize: 12.5, color: t.textMuted, marginBottom: 10 }}>Escolha o assunto e escreva sua mensagem.</div>
          <div style={{ display: "flex", flexWrap: "wrap", gap: 8, marginBottom: 12 }}>
            {ASSUNTOS.map((a) => (
              <Chip key={a} active={assunto === a} onClick={() => setAssunto(a)}>
                {a}
              </Chip>
            ))}
          </div>
          <textarea
            value={mensagem}
            onChange={(e) => setMensagem(e.target.value.slice(0, CONTACT_MAX))}
            rows={5}
            placeholder="Escreva aqui..."
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
          <div style={{ fontSize: 11.5, color: t.textMuted, textAlign: "right", marginTop: 4 }}>
            {mensagem.length}/{CONTACT_MAX}
          </div>
          {error && <div style={{ fontSize: 12.5, color: t.red, marginTop: 8 }}>{error}</div>}
          <div style={{ marginTop: 12 }}>
            <PrimaryButton full disabled={!mensagem.trim() || sending} onClick={send}>
              {sending ? "Enviando..." : "Enviar mensagem"}
            </PrimaryButton>
          </div>
        </>
      )}
    </ExpandBox>
  );
}
