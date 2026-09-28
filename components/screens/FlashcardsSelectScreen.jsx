"use client";

import { useEffect, useMemo, useRef, useState } from "react";
import { BookOpen, ChevronDown, Hash, RotateCw, Type } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { ScreenHeader, Toggle, PrimaryButton } from "@/components/ui/Primitives";

function DropdownField({ icon, label, value, options, onChange, placeholder }) {
  const t = useT();
  const [open, setOpen] = useState(false);
  const fieldRef = useRef(null);
  const selected = options.find((o) => o.value === value);

  useEffect(() => {
    if (!open) return;
    const handleClickOutside = (e) => {
      if (fieldRef.current && !fieldRef.current.contains(e.target)) setOpen(false);
    };
    document.addEventListener("mousedown", handleClickOutside);
    return () => document.removeEventListener("mousedown", handleClickOutside);
  }, [open]);

  return (
    <div style={{ background: t.surface, border: `1px solid ${t.border}`, borderRadius: 16, padding: 18, marginBottom: 16 }}>
      <div style={{ display: "flex", alignItems: "center", gap: 8, marginBottom: 12 }}>
        {icon}
        <span style={{ fontWeight: 700, fontSize: 15, color: t.text }}>{label}</span>
      </div>

      <div style={{ position: "relative" }} ref={fieldRef}>
        <button
          onClick={() => setOpen((v) => !v)}
          style={{
            width: "100%",
            display: "flex",
            alignItems: "center",
            gap: 10,
            padding: "11px 14px",
            borderRadius: 12,
            border: `1.5px solid ${open ? t.primary : t.border}`,
            background: t.surfaceAlt,
            cursor: "pointer",
            textAlign: "left",
            boxSizing: "border-box",
          }}
        >
          {selected ? (
            <>
              <span style={{ flex: 1, fontSize: 13.5, fontWeight: 600, color: t.text }}>{selected.label}</span>
              {selected.badge != null && (
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
                  {selected.badge}
                </span>
              )}
            </>
          ) : (
            <span style={{ flex: 1, fontSize: 13.5, color: t.textMuted }}>{placeholder || label}</span>
          )}
          <ChevronDown
            size={16}
            color={t.textMuted}
            style={{ transform: open ? "rotate(180deg)" : "none", transition: "transform .15s", flexShrink: 0 }}
          />
        </button>

        {open && (
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
            {options.map((opt) => {
              const active = value === opt.value;
              return (
                <button
                  key={opt.value}
                  onClick={() => {
                    onChange(opt.value);
                    setOpen(false);
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
                  <span style={{ flex: 1, fontSize: 13.5, fontWeight: 600, color: active ? t.primary : t.text }}>{opt.label}</span>
                  {opt.badge != null && (
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
                      {opt.badge}
                    </span>
                  )}
                </button>
              );
            })}
          </div>
        )}
      </div>
    </div>
  );
}

const QTD_OPTIONS = [5, 10, 15, 20, 25, "Todos"];
const TAMANHO_OPTIONS = [
  { value: "sm", label: "Pequeno" },
  { value: "md", label: "Médio" },
  { value: "lg", label: "Grande" },
];

export function FlashcardsSelectScreen({ themeCounts, onStart, onNavigate, hasSavedFlashSession, onContinueFlashcards }) {
  const t = useT();
  const temas = useMemo(() => Object.keys(themeCounts).sort(), [themeCounts]);
  const [tema, setTema] = useState(null);
  const [qtd, setQtd] = useState(10);
  const [tamanho, setTamanho] = useState("md");
  const [aleatorio, setAleatorio] = useState(true);
  const availableCount = tema ? themeCounts[tema] || 0 : 0;
  const sessionCount = tema ? Math.min(qtd === "Todos" ? availableCount : qtd, availableCount) : 0;

  return (
    <div style={{ maxWidth: 640, margin: "0 auto", paddingBottom: 90 }}>
      <ScreenHeader title="Flashcards" onBack={() => onNavigate("home")} />
      <div style={{ padding: "18px 22px" }}>
        <DropdownField
          icon={<BookOpen size={17} color={t.primary} />}
          label="Tema"
          placeholder="Tema"
          value={tema}
          onChange={setTema}
          options={temas.map((tm) => ({ value: tm, label: tm, badge: themeCounts[tm] }))}
        />

        <DropdownField
          icon={<Hash size={17} color={t.primary} />}
          label="Quantidade"
          value={qtd}
          onChange={setQtd}
          options={QTD_OPTIONS.map((o) => ({ value: o, label: String(o) }))}
        />

        <DropdownField
          icon={<Type size={17} color={t.primary} />}
          label="Tamanho dos Flashcards"
          value={tamanho}
          onChange={setTamanho}
          options={TAMANHO_OPTIONS}
        />

        <div style={{ background: t.surface, border: `1px solid ${t.border}`, borderRadius: 16, padding: 18 }}>
          <Toggle checked={aleatorio} onChange={setAleatorio} label="Aleatorizar" sub="Embaralha os cartões antes de iniciar" />
        </div>

        <div style={{ marginTop: 18, display: "flex", flexDirection: "column", gap: 10 }}>
          {hasSavedFlashSession && (
            <PrimaryButton full variant="ghost" onClick={onContinueFlashcards}>
              <RotateCw size={14} style={{ marginRight: 6, verticalAlign: -2 }} />
              Continuar Sessão
            </PrimaryButton>
          )}
          <PrimaryButton full disabled={!tema} onClick={() => onStart(tema, qtd, aleatorio, tamanho)}>
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
