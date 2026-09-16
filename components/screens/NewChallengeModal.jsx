"use client";

import { useState } from "react";
import { useT } from "@/components/theme/ThemeProvider";
import { Chip, PrimaryButton } from "@/components/ui/Primitives";

export function NewChallengeModal({ friends, temas, onCreate, onClose }) {
  const t = useT();
  const [friendId, setFriendId] = useState(friends[0]?.id || "");
  const [tema, setTema] = useState(temas[0] || "");
  const [qtd, setQtd] = useState(5);
  const [creating, setCreating] = useState(false);
  const [error, setError] = useState("");

  const criar = async () => {
    setCreating(true);
    setError("");
    try {
      await onCreate(friendId, tema, qtd);
    } catch (err) {
      setError(err.message || "Não foi possível criar o desafio.");
    } finally {
      setCreating(false);
    }
  };

  return (
    <div style={{ position: "fixed", inset: 0, background: "rgba(0,0,0,0.5)", display: "flex", alignItems: "center", justifyContent: "center", zIndex: 50, padding: 20 }}>
      <div style={{ background: t.surface, border: `1px solid ${t.border}`, borderRadius: 18, padding: 22, maxWidth: 380, width: "100%" }}>
        <h3 style={{ fontSize: 17, color: t.text, margin: "0 0 16px" }}>Novo Desafio</h3>

        <div style={{ marginBottom: 12 }}>
          <div style={{ fontSize: 12.5, color: t.textMuted, fontWeight: 600, marginBottom: 6 }}>Amigo</div>
          <div style={{ display: "flex", flexWrap: "wrap", gap: 6 }}>
            {friends.map((f) => (
              <Chip key={f.id} active={friendId === f.id} onClick={() => setFriendId(f.id)}>
                {f.name}
              </Chip>
            ))}
          </div>
        </div>
        <div style={{ marginBottom: 12 }}>
          <div style={{ fontSize: 12.5, color: t.textMuted, fontWeight: 600, marginBottom: 6 }}>Tema</div>
          <div style={{ display: "flex", flexWrap: "wrap", gap: 6 }}>
            {temas.map((tm) => (
              <Chip key={tm} active={tema === tm} onClick={() => setTema(tm)}>
                {tm}
              </Chip>
            ))}
          </div>
        </div>
        <div style={{ marginBottom: 20 }}>
          <div style={{ fontSize: 12.5, color: t.textMuted, fontWeight: 600, marginBottom: 6 }}>Questões</div>
          <div style={{ display: "flex", gap: 6 }}>
            {[5, 10].map((n) => (
              <Chip key={n} active={qtd === n} onClick={() => setQtd(n)}>
                {n}
              </Chip>
            ))}
          </div>
        </div>

        {error && <div style={{ fontSize: 12.5, color: t.red, marginBottom: 12 }}>{error}</div>}

        <div style={{ display: "flex", gap: 10 }}>
          <PrimaryButton variant="ghost" onClick={onClose}>
            Cancelar
          </PrimaryButton>
          <PrimaryButton disabled={!friendId || !tema || creating} onClick={criar}>
            Desafiar
          </PrimaryButton>
        </div>
      </div>
    </div>
  );
}
