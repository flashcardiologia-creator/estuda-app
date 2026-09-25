"use client";

import { useEffect, useMemo, useRef, useState } from "react";
import { BookOpen, ChevronDown, RotateCw } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { ScreenHeader, Toggle, PrimaryButton, SectionLabel } from "@/components/ui/Primitives";

export function FlashcardsSelectScreen({ themeCounts, onStart, onNavigate, hasSavedFlashSession, onContinueFlashcards }) {
  const t = useT();
  const temas = useMemo(() => Object.keys(themeCounts).sort(), [themeCounts]);
  const [tema, setTema] = useState(null);
  const [qtd, setQtd] = useState(10);
  const [aleatorio, setAleatorio] = useState(true);
  const [temaMenuOpen, setTemaMenuOpen] = useState(false);
  const temaFieldRef = useRef(null);
  const options = [5, 10, 15, 20, 25, "Todos"];
  const availableCount = tema ? themeCounts[tema] || 0 : 0;
  const sessionCount = tema ? Math.min(qtd === "Todos" ? availableCount : qtd, availableCount) : 0;

  useEffect(() => {
    if (!temaMenuOpen) return;
    const handleClickOutside = (e) => {
      if (temaFieldRef.current && !temaFieldRef.current.contains(e.target)) {
        setTemaMenuOpen(false);
      }
    };
    document.addEventListener("mousedown", handleClickOutside);
    return () => document.removeEventListener("mousedown", handleClickOutside);
  }, [temaMenuOpen]);

  return (
    <div style={{ maxWidth: 640, margin: "0 auto", paddingBottom: 90 }}>
      <ScreenHeader title="Flashcards" onBack={() => onNavigate("home")} />
      <div style={{ padding: "18px 22px" }}>
        <div style={{ background: t.surface, border: `1px solid ${t.border}`, borderRadius: 16, padding: 18, marginBottom: 16 }}>
          <div style={{ display: "flex", alignItems: "center", gap: 8, marginBottom: 12 }}>
            <BookOpen size={17} color={t.primary} />
            <span style={{ fontWeight: 700, fontSize: 15, color: t.text }}>Tema</span>
          </div>

          <div style={{ position: "relative" }} ref={temaFieldRef}>
            <button
              onClick={() => setTemaMenuOpen((v) => !v)}
              style={{
                width: "100%",
                display: "flex",
                alignItems: "center",
                gap: 10,
                padding: "11px 14px",
                borderRadius: 12,
                border: `1.5px solid ${temaMenuOpen ? t.primary : t.border}`,
                background: t.surfaceAlt,
                cursor: "pointer",
                textAlign: "left",
                boxSizing: "border-box",
              }}
            >
              {tema ? (
                <>
                  <span style={{ flex: 1, fontSize: 13.5, fontWeight: 600, color: t.text }}>{tema}</span>
                  <span
                    style={{
                      fontSize: 12,
                      fontWeight: 700,
                      color: t.textMuted,
                      background: t.surface,
                      padding: "2px 9px",
                      borderRadius: 999,
                    }}
                  >
                    {themeCounts[tema]}
                  </span>
                </>
              ) : (
                <span style={{ flex: 1, fontSize: 13.5, color: t.textMuted }}>Tema</span>
              )}
              <ChevronDown
                size={16}
                color={t.textMuted}
                style={{ transform: temaMenuOpen ? "rotate(180deg)" : "none", transition: "transform .15s", flexShrink: 0 }}
              />
            </button>

            {temaMenuOpen && (
              <div
                style={{
                  position: "absolute",
                  top: "calc(100% + 6px)",
                  left: 0,
                  right: 0,
                  zIndex: 5,
                  background: t.surface,
                  border: `1px solid ${t.border}`,
                  borderRadius: 12,
                  boxShadow: "0 10px 30px rgba(0,0,0,0.45)",
                  maxHeight: 260,
                  overflowY: "auto",
                  padding: 6,
                }}
              >
                {temas.map((tm) => {
                  const active = tema === tm;
                  return (
                    <button
                      key={tm}
                      onClick={() => {
                        setTema(tm);
                        setTemaMenuOpen(false);
                      }}
                      style={{
                        width: "100%",
                        display: "flex",
                        alignItems: "center",
                        gap: 10,
                        padding: "9px 10px",
                        borderRadius: 9,
                        border: "none",
                        background: active ? t.primarySoft : "transparent",
                        cursor: "pointer",
                        textAlign: "left",
                        boxSizing: "border-box",
                      }}
                    >
                      <span style={{ flex: 1, fontSize: 13.5, fontWeight: 600, color: active ? t.primary : t.text }}>{tm}</span>
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
            )}
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

          <Toggle checked={aleatorio} onChange={setAleatorio} label="Aleatorizar" sub="Embaralha os cartões antes de iniciar" />
        </div>

        <div style={{ marginTop: 18, display: "flex", flexDirection: "column", gap: 10 }}>
          {hasSavedFlashSession && (
            <PrimaryButton full variant="ghost" onClick={onContinueFlashcards}>
              <RotateCw size={14} style={{ marginRight: 6, verticalAlign: -2 }} />
              Continuar Sessão
            </PrimaryButton>
          )}
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
