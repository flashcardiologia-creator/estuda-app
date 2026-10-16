"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Flame } from "lucide-react";
import { createClient } from "@/lib/supabase/client";
import { useT } from "@/components/theme/ThemeProvider";
import { PrimaryButton } from "@/components/ui/Primitives";
import { sendTermsAcceptance } from "@/lib/legal/client";
import { LegalModal } from "@/components/screens/LegalModal";

// Tela exibida depois do login a quem ainda não aceitou a versão atual dos Termos e da Política.
export function TermsGate({ returning }) {
  const t = useT();
  const router = useRouter();
  const [supabase] = useState(() => createClient());
  const [accepted, setAccepted] = useState(false);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");

  const confirm = async () => {
    setError("");
    if (!accepted) {
      setError("Para continuar, aceite os Termos de Uso e a Política de Privacidade.");
      return;
    }
    setLoading(true);
    const ok = await sendTermsAcceptance({ context: "gate" });
    if (!ok) {
      setLoading(false);
      setError("Não foi possível registrar o aceite agora. Verifique sua conexão e tente de novo.");
      return;
    }
    router.refresh();
  };

  const signOut = async () => {
    await supabase.auth.signOut();
    router.push("/login");
    router.refresh();
  };

  // Os textos abrem numa janela por cima desta tela (sem sair dela).
  const [legal, setLegal] = useState(null);
  const openLegal = (e, which) => {
    e.preventDefault();
    e.stopPropagation();
    setLegal(which);
  };
  const link = { background: "transparent", border: "none", padding: 0, font: "inherit", color: t.primary, fontWeight: 600, cursor: "pointer", textDecoration: "underline" };

  return (
    <div className="login-screen" style={{ display: "flex", flexDirection: "column", alignItems: "center", justifyContent: "center", gap: 22, padding: 20, boxSizing: "border-box" }}>
      <div style={{ display: "flex", alignItems: "center", gap: 12 }}>
        <Flame size={38} color={t.amber} fill={t.amber} />
        <h1 style={{ fontSize: 30, fontWeight: 700, color: t.text, margin: 0 }}>FlashCardio</h1>
      </div>
      <div style={{ width: "100%", maxWidth: 380, background: t.surface, border: `1px solid ${t.border}`, borderRadius: 20, padding: 30 }}>
        <h2 style={{ fontSize: 18, fontWeight: 700, color: t.text, margin: "0 0 10px" }}>
          {returning ? "Atualizamos nossos termos" : "Antes de continuar"}
        </h2>
        <p style={{ fontSize: 13.5, lineHeight: 1.6, color: t.textMuted, margin: "0 0 18px" }}>
          {returning
            ? "Leia a versão atual dos Termos de Uso e da Política de Privacidade e confirme que concorda para continuar usando o app."
            : "Para usar o FlashCardio, leia os Termos de Uso e a Política de Privacidade e confirme que concorda."}
        </p>
        <label style={{ display: "flex", alignItems: "flex-start", gap: 10, fontSize: 13, lineHeight: 1.5, color: t.textMuted, cursor: "pointer" }}>
          <input
            type="checkbox"
            checked={accepted}
            onChange={(e) => setAccepted(e.target.checked)}
            style={{ width: 18, height: 18, marginTop: 1, flexShrink: 0, accentColor: t.primary }}
          />
          <span>
            Li e concordo com os{" "}
            <button type="button" onClick={(e) => openLegal(e, "termos")} style={link}>
              Termos de Uso
            </button>{" "}
            e a{" "}
            <button type="button" onClick={(e) => openLegal(e, "privacidade")} style={link}>
              Política de Privacidade
            </button>
            .
          </span>
        </label>
        {error && <div style={{ fontSize: 12.5, color: t.red, marginTop: 12 }}>{error}</div>}
        <div style={{ marginTop: 18 }}>
          <PrimaryButton full onClick={confirm} disabled={loading}>
            Continuar
          </PrimaryButton>
        </div>
        <div style={{ textAlign: "center", marginTop: 14 }}>
          <button onClick={signOut} style={{ background: "transparent", border: "none", color: t.textMuted, fontSize: 13, cursor: "pointer" }}>
            Sair
          </button>
        </div>
      </div>
      {legal && <LegalModal initial={legal} onClose={() => setLegal(null)} closeLabel="Voltar" />}
    </div>
  );
}
