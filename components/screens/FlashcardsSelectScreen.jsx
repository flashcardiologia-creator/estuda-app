"use client";

import { useMemo, useState } from "react";
import { BookOpen } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { ScreenHeader, Toggle, PrimaryButton, SectionLabel } from "@/components/ui/Primitives";

export function FlashcardsSelectScreen({ themeCounts, onStart, onNavigate }) {
  const t = useT();
  const temas = useMemo(() => Object.keys(themeCounts).sort(), [themeCounts]);
  const [tema, setTema] = useState(null);
  const [qtd, setQtd] = useState(10);
  const [aleatorio, setAleatorio] = useState(true);
  const options = [5, 10, 15, 20, 25, "Todos"];
  const availableCount = tema ? themeCounts[tema] || 0 : 0;
  const sessionCount = tema ? Math.min(qtd === "Todos" ? availableCount : qtd, availableCount) : 0;

  return (
    <div style={{ maxWidth: 640, margin: "0 auto", paddingBottom: 90 }}>
      <ScreenHeader title="Flashcards" onBack={() => onNavigate("home")} />
      <div style={{ padding: "18px 22px" }}>
        <div style={{ background: t.surface, border: `1px solid ${t.border}`, borderRadius: 16, padding: 18, marginBottom: 16 }}>
          <div style={{ display: "flex", alignItems: "center", gap: 8, marginBottom: 12 }}>
            <BookOpen size={17} color={t.primary} />
            <span style={{ fontWeight: 700, fontSize: 15, color: t.text }}>Tema</span>
          </div>
          <div style={{ display: "flex", flexDirection: "column", gap: 8, maxHeight: 260, overflowY: "auto", paddingRight: 4 }}>
            {temas.map((tm) => {
              const active = tema === tm;
              return (
                <button
                  key={tm}
                  onClick={() => setTema(tm)}
                  style={{
                    textAlign: "left",
                    padding: "11px 14px",
                    borderRadius: 10,
                    cursor: "pointer",
                    border: `1.5px solid ${active ? t.primary : t.border}`,
                    background: active ? t.primarySoft : "transparent",
                    fontWeight: 600,
                    fontSize: 13.5,
                    color: active ? t.primary : t.text,
                    display: "flex",
                    alignItems: "center",
                    justifyContent: "space-between",
                    transition: "all .15s ease",
                  }}
                >
                  {tm}
                  <span
                    style={{
                      fontSize: 12,
                      fontWeight: 700,
                      color: active ? t.primary : t.textMuted,
                      background: active ? "rgba(255,255,255,0.14)" : t.surfaceAlt,
                      padding: "2px 9px",
                      borderRadius: 999,
                    }}
                  >
                    {themeCounts[tm]}
                  </span>
                </button>
              );
            })}
          </div>
        </div>

        <div style={{ background: t.surface, border: `1px solid ${t.border}`, borderRadius: 16, padding: 18 }}>
          <div style={{ marginBottom: 18 }}>
            <SectionLabel>Quantidade</SectionLabel>
            <div style={{ display: "grid", gridTemplateColumns: "repeat(3, 1fr)", gap: 8 }}>
              {options.map((o) => {
                const active = qtd === o;
                return (
                  <button
                    key={o}
                    onClick={() => setQtd(o)}
                    style={{
                      padding: "10px 6px",
                      borderRadius: 12,
                      border: `1.5px solid ${active ? t.primary : t.border}`,
                      background: active ? t.primarySoft : t.surfaceAlt,
                      color: active ? t.primary : t.text,
                      fontSize: 14,
                      fontWeight: 700,
                      cursor: "pointer",
                      textAlign: "center",
                      transition: "all .15s ease",
                    }}
                  >
                    {o}
                  </button>
                );
              })}
            </div>
          </div>

          <Toggle checked={aleatorio} onChange={setAleatorio} label="Aleatorizar ordem" sub="Embaralha os cartões antes de iniciar" />
        </div>

        <div style={{ marginTop: 18 }}>
          <PrimaryButton full disabled={!tema} onClick={() => onStart(tema, qtd, aleatorio)}>
            Iniciar Flashcards
          </PrimaryButton>
          {tema && (
            <div style={{ textAlign: "center", fontSize: 12, color: t.textMuted, marginTop: 8 }}>
              {sessionCount} cartões nesta sessão
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
