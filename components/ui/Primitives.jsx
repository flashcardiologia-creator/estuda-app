"use client";

import React, { useEffect, useRef, useState } from "react";
import { Check, ChevronDown, ChevronLeft, Flame, Lock, Loader2 } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";

const FONT_BODY = "inherit";
const FONT_DISPLAY = "inherit";
const FONT_MONO = "inherit";

export function Chip({ active, onClick, children, disabled, style }) {
  const t = useT();
  return (
    <button
      onClick={disabled ? undefined : onClick}
      style={{
        fontFamily: FONT_BODY,
        padding: "7px 14px",
        borderRadius: 999,
        fontSize: 13,
        fontWeight: 600,
        border: `1.5px solid ${active ? t.primary : t.border}`,
        background: active ? t.primarySoft : "transparent",
        color: active ? t.primary : t.textMuted,
        cursor: disabled ? "default" : "pointer",
        opacity: disabled ? 0.5 : 1,
        transition: "all .15s ease",
        whiteSpace: "nowrap",
        ...style,
      }}
    >
      {children}
    </button>
  );
}

export function ExpandBox({ title, icon, open, onToggle, children, badge }) {
  const t = useT();
  return (
    <div
      style={{
        background: t.surface,
        border: `1px solid ${t.border}`,
        borderRadius: 16,
        overflow: "hidden",
        marginBottom: 12,
      }}
    >
      <button
        onClick={onToggle}
        style={{
          width: "100%",
          display: "flex",
          alignItems: "center",
          gap: 10,
          padding: "16px 18px",
          background: "transparent",
          border: "none",
          cursor: "pointer",
        }}
      >
        {icon}
        <span
          style={{
            fontFamily: FONT_DISPLAY,
            fontWeight: 600,
            fontSize: 15,
            color: t.text,
            flex: 1,
            textAlign: "left",
          }}
        >
          {title}
        </span>
        {badge != null && badge > 0 && (
          <span
            style={{
              fontFamily: FONT_MONO,
              fontSize: 11,
              background: t.primarySoft,
              color: t.primary,
              borderRadius: 999,
              padding: "2px 8px",
              fontWeight: 700,
            }}
          >
            {badge}
          </span>
        )}
        <ChevronDown
          size={18}
          color={t.textMuted}
          style={{ transform: open ? "rotate(180deg)" : "none", transition: "transform .2s" }}
        />
      </button>
      {open && <div style={{ padding: "0 18px 18px" }}>{children}</div>}
    </div>
  );
}

// Sentinela usada para representar "Todos" quando o Dropdown está em modo de
// seleção única (ex.: tema dos flashcards) — distingue de um valor real de
// opção, já que nenhum tema de verdade pode colidir com essa string.
export const DROPDOWN_ALL = "__ALL__";

export function Dropdown({
  options,
  selected,
  onChange,
  multi = false,
  allLabel = "Todos",
  placeholder = "Selecionar",
  // Alguns filtros (Anos, Instituições) tratam array vazio como "sem
  // restrição" — ou seja, vazio já significa "Todos" pro resto do app. Com
  // essa flag o dropdown mostra/trata esse estado como Todos em vez de pedir
  // pra selecionar algo.
  emptyMeansAll = false,
}) {
  const t = useT();
  const [open, setOpen] = useState(false);
  const ref = useRef(null);

  useEffect(() => {
    if (!open) return;
    function onDocClick(e) {
      if (ref.current && !ref.current.contains(e.target)) setOpen(false);
    }
    function onKey(e) {
      if (e.key === "Escape") setOpen(false);
    }
    document.addEventListener("mousedown", onDocClick);
    document.addEventListener("keydown", onKey);
    return () => {
      document.removeEventListener("mousedown", onDocClick);
      document.removeEventListener("keydown", onKey);
    };
  }, [open]);

  const emptyIsAll = multi && emptyMeansAll && selected.length === 0;
  const allSelected = multi
    ? options.length > 0 && (selected.length === options.length || emptyIsAll)
    : selected === DROPDOWN_ALL;

  const label = multi
    ? selected.length === 0
      ? emptyMeansAll
        ? allLabel
        : placeholder
      : allSelected
        ? allLabel
        : selected.length === 1
          ? selected[0]
          : `${selected.length} selecionados`
    : selected == null
      ? placeholder
      : allSelected
        ? allLabel
        : selected;

  const handleAll = () => {
    if (multi) {
      onChange(allSelected ? [] : [...options]);
    } else {
      onChange(DROPDOWN_ALL);
      setOpen(false);
    }
  };

  const handleOption = (opt) => {
    if (multi) {
      // Se vazio já significa "todos", marcar/desmarcar um item parte da
      // lista completa (não de um array vazio) — senão desmarcar um item
      // sozinho pareceria "adicionar" em vez de "excluir esse".
      const effective = emptyIsAll ? options : selected;
      onChange(effective.includes(opt) ? effective.filter((x) => x !== opt) : [...effective, opt]);
    } else {
      onChange(opt);
      setOpen(false);
    }
  };

  const isOptionActive = (opt) => (multi ? emptyIsAll || selected.includes(opt) : selected === opt);

  return (
    <div ref={ref} style={{ position: "relative" }}>
      <button
        onClick={() => setOpen((o) => !o)}
        style={{
          width: "100%",
          display: "flex",
          alignItems: "center",
          justifyContent: "space-between",
          gap: 10,
          padding: "12px 14px",
          borderRadius: 12,
          border: `1.5px solid ${open ? t.primary : t.border}`,
          background: t.surfaceAlt,
          color: t.text,
          fontFamily: FONT_BODY,
          fontSize: 14.5,
          fontWeight: 600,
          cursor: "pointer",
          textAlign: "left",
        }}
      >
        <span style={{ overflow: "hidden", textOverflow: "ellipsis", whiteSpace: "nowrap" }}>{label}</span>
        <ChevronDown
          size={17}
          color={t.textMuted}
          style={{ transform: open ? "rotate(180deg)" : "none", transition: "transform .15s", flexShrink: 0 }}
        />
      </button>
      {open && (
        <div
          className="dropdown-scroll"
          style={{
            position: "absolute",
            top: "calc(100% + 6px)",
            left: 0,
            right: 0,
            maxHeight: 280,
            overflowY: "scroll",
            background: t.surface,
            border: `1px solid ${t.border}`,
            borderRadius: 12,
            boxShadow: "0 8px 24px rgba(0,0,0,0.18)",
            zIndex: 20,
            padding: 6,
          }}
        >
          <DropdownItem label={allLabel} active={allSelected} multi={multi} onClick={handleAll} />
          {options.map((opt) => (
            <DropdownItem
              key={opt}
              label={opt}
              active={isOptionActive(opt)}
              multi={multi}
              onClick={() => handleOption(opt)}
            />
          ))}
        </div>
      )}
    </div>
  );
}

function DropdownItem({ label, active, multi, onClick }) {
  const t = useT();
  return (
    <button
      onClick={onClick}
      style={{
        width: "100%",
        display: "flex",
        alignItems: "center",
        gap: 10,
        padding: "10px 10px",
        borderRadius: 8,
        border: "none",
        background: active ? t.primarySoft : "transparent",
        color: active ? t.primary : t.text,
        fontFamily: FONT_BODY,
        fontSize: 14,
        fontWeight: active ? 700 : 500,
        cursor: "pointer",
        textAlign: "left",
      }}
    >
      {multi && (
        <span
          style={{
            width: 18,
            height: 18,
            borderRadius: 5,
            border: `1.5px solid ${active ? t.primary : t.border}`,
            background: active ? t.primary : "transparent",
            display: "flex",
            alignItems: "center",
            justifyContent: "center",
            flexShrink: 0,
          }}
        >
          {active && <Check size={12} color="#fff" strokeWidth={3} />}
        </span>
      )}
      <span style={{ flex: 1 }}>{label}</span>
    </button>
  );
}

export function Toggle({ checked, onChange, label, sub, labelStyle, style }) {
  const t = useT();
  return (
    <div style={{ display: "flex", alignItems: "center", justifyContent: "space-between", padding: "10px 0", ...style }}>
      <div>
        {label && <div style={{ fontFamily: FONT_BODY, fontSize: 14, fontWeight: 600, color: t.text, ...labelStyle }}>{label}</div>}
        {sub && <div style={{ fontFamily: FONT_BODY, fontSize: 12, color: t.textMuted, marginTop: label ? 2 : 0 }}>{sub}</div>}
      </div>
      <button
        onClick={() => onChange(!checked)}
        style={{
          width: 44,
          height: 26,
          borderRadius: 999,
          border: "none",
          cursor: "pointer",
          position: "relative",
          background: checked ? t.primary : t.border,
          transition: "background .15s",
          flexShrink: 0,
        }}
      >
        <span
          style={{
            position: "absolute",
            top: 3,
            left: checked ? 21 : 3,
            width: 20,
            height: 20,
            borderRadius: "50%",
            background: "#fff",
            transition: "left .15s",
          }}
        />
      </button>
    </div>
  );
}

export function PrimaryButton({ children, onClick, disabled, full, small, variant = "primary", color, textColor, type }) {
  const t = useT();
  const bg = color || (variant === "primary" ? t.primary : variant === "ghost" ? "transparent" : t.green);
  return (
    <button
      type={type || "button"}
      onClick={onClick}
      disabled={disabled}
      style={{
        fontFamily: FONT_DISPLAY,
        fontWeight: 600,
        fontSize: small ? 13 : 15,
        padding: small ? "9px 16px" : "13px 22px",
        borderRadius: 12,
        background: disabled ? t.border : bg,
        color: textColor || (variant === "ghost" ? t.text : "#fff"),
        border: variant === "ghost" ? `1.5px solid ${t.border}` : "none",
        cursor: disabled ? "default" : "pointer",
        width: full ? "100%" : "auto",
        opacity: disabled ? 0.6 : 1,
        transition: "transform .1s, filter .15s",
        display: "inline-flex",
        alignItems: "center",
        justifyContent: "center",
        whiteSpace: "nowrap",
        flexShrink: 0,
      }}
      onMouseDown={(e) => !disabled && (e.currentTarget.style.transform = "scale(0.98)")}
      onMouseUp={(e) => (e.currentTarget.style.transform = "scale(1)")}
    >
      {children}
    </button>
  );
}

export function Tag({ children }) {
  const t = useT();
  return (
    <span
      style={{
        fontFamily: FONT_MONO,
        fontSize: 11,
        fontWeight: 700,
        letterSpacing: 0.3,
        color: t.textMuted,
        background: t.surfaceAlt,
        border: `1px solid ${t.border}`,
        padding: "4px 10px",
        borderRadius: 8,
        textTransform: "uppercase",
      }}
    >
      {children}
    </span>
  );
}

export function Flame_({ done, size = 18 }) {
  const t = useT();
  const color = done ? t.green : t.red;
  return (
    <span style={{ position: "relative", display: "inline-flex" }}>
      <Flame size={size} color={color} fill={color} style={{ filter: `drop-shadow(0 0 6px ${color}88)` }} />
    </span>
  );
}

export function BackBar({ label = "Voltar", onBack }) {
  const t = useT();
  return (
    <div style={{ padding: "18px 22px 0" }}>
      <button
        onClick={onBack}
        style={{
          display: "flex",
          alignItems: "center",
          gap: 4,
          background: "transparent",
          border: `1px solid ${t.border}`,
          borderRadius: 12,
          padding: "8px 14px",
          cursor: "pointer",
          color: t.text,
          fontFamily: FONT_BODY,
          fontSize: 13.5,
          fontWeight: 600,
        }}
      >
        <ChevronLeft size={16} /> {label}
      </button>
    </div>
  );
}

export function ScreenHeader({ title, onBack, label = "Voltar" }) {
  const t = useT();
  return (
    <div style={{ display: "grid", gridTemplateColumns: "1fr auto 1fr", alignItems: "center", padding: "18px 22px 0" }}>
      <button
        onClick={onBack}
        style={{
          justifySelf: "start",
          display: "flex",
          alignItems: "center",
          gap: 4,
          background: "transparent",
          border: `1px solid ${t.border}`,
          borderRadius: 12,
          padding: "8px 14px",
          cursor: "pointer",
          color: t.text,
          fontFamily: FONT_BODY,
          fontSize: 13.5,
          fontWeight: 600,
        }}
      >
        <ChevronLeft size={16} /> {label}
      </button>
      <span style={{ fontFamily: FONT_BODY, fontWeight: 700, fontSize: 20, color: t.text, whiteSpace: "nowrap" }}>
        {title}
      </span>
      <span />
    </div>
  );
}

export function HomeBox({ icon, title, onClick, accentColor, locked, loading, heroBg, statusText, statusColor }) {
  const t = useT();
  const grayBorder = t.name === "light" && !heroBg;
  const darkTitleOnHero = heroBg && t.name === "light";
  const disabled = locked || loading;
  return (
    <button
      onClick={disabled ? undefined : onClick}
      style={{
        width: "100%",
        minHeight: 118,
        boxSizing: "border-box",
        textAlign: "center",
        border: grayBorder ? "1px solid #D6D6DC" : locked ? `1px dashed ${t.border}` : "none",
        borderRadius: 20,
        padding: "20px 18px",
        cursor: disabled ? "default" : "pointer",
        background: heroBg || t.surface,
        opacity: locked ? 0.6 : loading ? 0.85 : 1,
        position: "relative",
        overflow: "hidden",
        display: "flex",
        flexDirection: "column",
        alignItems: "center",
        justifyContent: "center",
        gap: 10,
        transition: "filter .15s ease",
      }}
      onMouseEnter={(e) => !disabled && (e.currentTarget.style.filter = "brightness(1.08)")}
      onMouseLeave={(e) => (e.currentTarget.style.filter = "brightness(1)")}
    >
      {locked && (
        <div style={{ position: "absolute", top: 14, right: 16 }}>
          <Lock size={14} color={t.textMuted} />
        </div>
      )}
      {loading ? (
        <Loader2 className="spin" color={accentColor} size={26} strokeWidth={2} />
      ) : (
        React.cloneElement(icon, { color: accentColor, size: 26, strokeWidth: 2 })
      )}
      <span
        style={{
          fontFamily: FONT_DISPLAY,
          fontWeight: 700,
          fontSize: 16.5,
          color: darkTitleOnHero ? t.text : heroBg ? "#F4F2FF" : t.text,
        }}
      >
        {title}
      </span>
      {loading ? (
        <span style={{ fontFamily: FONT_BODY, fontWeight: 700, fontSize: 13, color: statusColor }}>Carregando…</span>
      ) : (
        statusText && (
          <span style={{ fontFamily: FONT_BODY, fontWeight: 700, fontSize: 13, color: statusColor }}>{statusText}</span>
        )
      )}
    </button>
  );
}

export function SectionLabel({ icon, children }) {
  const t = useT();
  return (
    <div style={{ display: "flex", alignItems: "center", gap: 6, fontSize: 12.5, color: t.textMuted, fontWeight: 700, marginBottom: 8, textTransform: "uppercase", letterSpacing: 0.3 }}>
      {icon}
      {children}
    </div>
  );
}

export function EmptyState({ text }) {
  const t = useT();
  return (
    <div style={{ textAlign: "center", padding: "30px 10px", fontFamily: FONT_BODY, fontSize: 13.5, color: t.textMuted }}>
      {text}
    </div>
  );
}
