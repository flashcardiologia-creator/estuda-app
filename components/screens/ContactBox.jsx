"use client";

import { useEffect, useRef, useState } from "react";
import { MessageSquare, Check } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { ExpandBox, PrimaryButton, Chip } from "@/components/ui/Primitives";
import { CONTACT_MAX, sendContactMessage } from "@/lib/data/contact";

const ASSUNTOS = ["Dúvida", "Sugestão", "Problema", "Comissão", "Outro"];

// "Comissão" é o pedido de saque dos pontos do Convidar amigos. O banco aceita só os assuntos antigos, então ele vai como "Outro" e a
// mensagem começa com SOLICITAÇÃO DE COMISSÃO (é o que aparece no e-mail de quem atende).
const PEDIDO_COMISSAO = "SOLICITAÇÃO DE COMISSÃO";

// preset: { message } quando a pessoa chega pelo botão "Solicitar saque" do Convidar amigos (abre já em Comissão, com o valor escrito).
export function ContactBox({ supabase, userId, preset }) {
  const t = useT();
  const [open, setOpen] = useState(!!preset);
  const [assunto, setAssunto] = useState(preset ? "Comissão" : "Dúvida");
  const [mensagem, setMensagem] = useState(preset?.message || "");
  const wrapRef = useRef(null);
  const presetRef = useRef(preset);
  useEffect(() => {
    if (presetRef.current) wrapRef.current?.scrollIntoView({ behavior: "smooth", block: "start" });
  }, []);
  const [sending, setSending] = useState(false);
  const [sent, setSent] = useState(false);
  const [error, setError] = useState("");

  const send = async () => {
    if (!mensagem.trim()) return;
    setSending(true);
    setError("");
    try {
      const comissao = assunto === "Comissão";
      const texto = comissao && !mensagem.trim().toUpperCase().startsWith(PEDIDO_COMISSAO) ? `${PEDIDO_COMISSAO}\n${mensagem.trim()}` : mensagem;
      await sendContactMessage(supabase, userId, comissao ? "Outro" : assunto, texto);
      setSent(true);
      setMensagem("");
    } catch (err) {
      setError(err.message || "Não foi possível enviar.");
    } finally {
      setSending(false);
    }
  };

  return (
    <div ref={wrapRef}>
      <ExpandBox title="Contato" icon={<MessageSquare size={17} color={t.primary} />} open={open} onToggle={() => setOpen((o) => !o)}>
        {sent ? (
          <div>
            <div style={{ display: "flex", alignItems: "center", gap: 8, fontSize: 14, fontWeight: 700, color: t.green, marginBottom: assunto === "Comissão" ? 6 : 14 }}>
              <Check size={16} /> {assunto === "Comissão" ? "Recebemos o seu pedido de comissão." : "Obrigado pelo contato."}
            </div>
            {assunto === "Comissão" && (
              <div style={{ fontSize: 12.5, color: t.textMuted, lineHeight: 1.5, marginBottom: 14 }}>
                Quando o saque for pago, ele aparece em vermelho na lista do Convidar amigos.
              </div>
            )}
            <PrimaryButton full variant="ghost" onClick={() => setSent(false)}>
              Enviar outra mensagem
            </PrimaryButton>
          </div>
        ) : (
          <>
            <div style={{ fontSize: 12.5, color: t.textMuted, marginBottom: 10 }}>
              {assunto === "Comissão" ? "Informe o valor e a sua chave PIX. Só os pontos já liberados (verdes) podem ser sacados." : "Escolha o assunto e escreva sua mensagem."}
            </div>
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
    </div>
  );
}
