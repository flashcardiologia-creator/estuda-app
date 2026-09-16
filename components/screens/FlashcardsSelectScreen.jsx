"use client";

import { useMemo, useState } from "react";
import { BookOpen } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { ScreenHeader, ExpandBox, Chip, Toggle, PrimaryButton } from "@/components/ui/Primitives";

export function FlashcardsSelectScreen({ themeCounts, onStart, onNavigate }) {
  const t = useT();
  const temas = useMemo(() => Object.keys(themeCounts).sort(), [themeCounts]);
  const [tema, setTema] = useState(null);
  const [open, setOpen] = useState(true);
  const [qtd, setQtd] = useState(10);
  const [aleatorio, setAleatorio] = useState(true);
  const options = [5, 10, 15, 20, 25, "Todos"];
  const availableCount = tema ? themeCounts[tema] || 0 : 0;

  return (
    <div style={{ maxWidth: 640, margin: "0 auto", paddingBottom: 90 }}>
      <ScreenHeader title="Flashcards" onBack={() => onNavigate("home")} />
      <div style={{ padding: "18px 22px" }}>
        <ExpandBox title="Tema" icon={<BookOpen size={17} color={t.primary} />} open={open} onToggle={() => setOpen(!open)}>
          <div style={{ display: "flex", flexDirection: "column", gap: 8 }}>
            {temas.map((tm) => (
              <button
                key={tm}
                onClick={() => setTema(tm)}
                style={{
                  textAlign: "left",
                  padding: "11px 14px",
                  borderRadius: 10,
                  cursor: "pointer",
                  border: `1.5px solid ${tema === tm ? t.primary : t.border}`,
                  background: tema === tm ? t.primarySoft : "transparent",
                  fontWeight: 600,
                  fontSize: 13.5,
                  color: tema === tm ? t.primary : t.text,
                  display: "flex",
                  justifyContent: "space-between",
                }}
              >
                {tm} <span style={{ fontSize: 12, color: t.textMuted }}>{themeCounts[tm]}</span>
              </button>
            ))}
          </div>
        </ExpandBox>

        <div style={{ marginBottom: 16 }}>
          <div style={{ fontSize: 13, fontWeight: 700, color: t.text, marginBottom: 10 }}>Quantidade</div>
          <div style={{ display: "flex", flexWrap: "wrap", gap: 8 }}>
            {options.map((o) => (
              <Chip key={o} active={qtd === o} onClick={() => setQtd(o)}>
                {o}
              </Chip>
            ))}
          </div>
        </div>

        <Toggle checked={aleatorio} onChange={setAleatorio} label="Aleatorizar ordem" sub="Embaralha os cartões antes de iniciar" />

        <div style={{ marginTop: 20 }}>
          <PrimaryButton full disabled={!tema} onClick={() => onStart(tema, qtd, aleatorio)}>
            Iniciar Flashcards
          </PrimaryButton>
          {tema && (
            <div style={{ textAlign: "center", fontSize: 12, color: t.textMuted, marginTop: 8 }}>
              {Math.min(qtd === "Todos" ? availableCount : qtd, availableCount)} cartões nesta sessão
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
