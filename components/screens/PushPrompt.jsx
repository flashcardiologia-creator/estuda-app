"use client";

import { useState } from "react";
import { Bell } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { PrimaryButton } from "@/components/ui/Primitives";
import { enablePush } from "@/lib/push";

// Convite para ativar o lembrete da missão diária (primeira abertura do app e primeira missão concluída).
export function PushPrompt({ supabase, userId, onClose }) {
  const t = useT();
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState("");

  const activate = async () => {
    setBusy(true);
    setError("");
    try {
      await enablePush(supabase, userId);
      onClose();
    } catch (err) {
      setError(
        err.message === "denied"
          ? "As notificações estão bloqueadas neste aparelho. Dá para liberar depois nas configurações e ativar em Minha Conta → Permissões."
          : "Não foi possível ativar agora. Dá para tentar depois em Minha Conta → Permissões."
      );
      setBusy(false);
    }
  };

  return (
    <div style={{ position: "fixed", inset: 0, background: "rgba(0,0,0,0.55)", display: "flex", alignItems: "center", justifyContent: "center", zIndex: 70, padding: 20 }}>
      <div style={{ background: t.surface, border: `1px solid ${t.border}`, borderRadius: 18, padding: 22, maxWidth: 380, width: "100%" }}>
        <div style={{ display: "flex", alignItems: "center", gap: 10, marginBottom: 12 }}>
          <Bell size={20} color={t.amber} />
          <h3 style={{ fontSize: 16.5, color: t.text, margin: 0 }}>Lembrete da missão diária</h3>
        </div>
        <p style={{ fontSize: 13.5, color: t.textMuted, lineHeight: 1.6, margin: 0 }}>
          Quer receber um aviso às <b style={{ color: t.text }}>10h</b> e às <b style={{ color: t.text }}>22h</b>, com o tempo que falta, se você ainda não tiver feito a missão do dia? Dá para mudar isso depois em Minha Conta → Permissões.
        </p>
        {error && <div style={{ fontSize: 12.5, color: t.red, marginTop: 12, lineHeight: 1.5 }}>{error}</div>}
        <div style={{ display: "flex", gap: 10, marginTop: 20 }}>
          <div style={{ flex: 1 }}>
            <PrimaryButton full variant="ghost" disabled={busy} onClick={onClose}>
              {error ? "Fechar" : "Agora não"}
            </PrimaryButton>
          </div>
          {!error && (
            <div style={{ flex: 1 }}>
              <PrimaryButton full disabled={busy} onClick={activate}>
                {busy ? "Ativando…" : "Ativar lembrete"}
              </PrimaryButton>
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
