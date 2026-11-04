"use client";

import { useId, useMemo, useState } from "react";
import { Check, ChevronDown, X } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { EXAMS, MAX_INSTITUTION_LEN, SPECIALTIES, isListedInstitution, searchInstitutions, wantsSpecialty } from "@/lib/data/cardioFormacao";

// Perguntas do cadastro: prova (TEC, R+ ou Ambos), especialidade (só para R+ e Ambos) e instituição (busca na lista ou texto livre).
// value = { exam, specialty, institution }; onChange recebe só o que mudou.
export function SignupGoalsFields({ value, onChange }) {
  const t = useT();
  const uid = useId();
  const labelStyle = { fontSize: 12.5, color: t.textMuted, fontWeight: 600 };
  const choiceStyle = (on) => ({
    padding: "10px 8px",
    borderRadius: 12,
    fontSize: 13.5,
    fontWeight: 600,
    fontFamily: "inherit",
    lineHeight: 1.25,
    cursor: "pointer",
    border: `1.5px solid ${on ? t.primary : t.border}`,
    background: on ? t.primarySoft : t.surfaceAlt,
    color: on ? t.primary : t.textMuted,
    transition: "all .15s ease",
  });
  const hint = EXAMS.find((e) => e.value === value.exam)?.hint;

  return (
    <div style={{ display: "flex", flexDirection: "column", gap: 12 }}>
      <div>
        <div id="goals-exam-label" style={labelStyle}>
          Qual prova você vai prestar?
        </div>
        <div role="radiogroup" aria-labelledby="goals-exam-label" style={{ display: "grid", gridTemplateColumns: "repeat(3, minmax(0, 1fr))", gap: 8, marginTop: 6 }}>
          {EXAMS.map((e) => {
            const on = value.exam === e.value;
            return (
              <button
                key={e.value}
                type="button"
                role="radio"
                aria-checked={on}
                onClick={() => onChange({ exam: e.value, specialty: wantsSpecialty(e.value) ? value.specialty : "" })}
                style={choiceStyle(on)}
              >
                {e.label}
              </button>
            );
          })}
        </div>
        {hint && <div style={{ fontSize: 12, color: t.textMuted, marginTop: 6 }}>{hint}</div>}
      </div>

      {wantsSpecialty(value.exam) && (
        <div>
          <label htmlFor={`${uid}-especialidade`} style={labelStyle}>
            Qual a especialidade do R+?
          </label>
          {/* Lista que abre ao tocar (no celular, o seletor do próprio aparelho). */}
          <div style={{ position: "relative", marginTop: 6 }}>
            <select
              id={`${uid}-especialidade`}
              value={value.specialty}
              onChange={(e) => onChange({ specialty: e.target.value })}
              style={{
                width: "100%",
                padding: "12px 40px 12px 14px",
                borderRadius: 12,
                border: `1px solid ${t.border}`,
                background: t.surfaceAlt,
                color: value.specialty ? t.text : t.textMuted,
                fontSize: 16,
                fontFamily: "inherit",
                boxSizing: "border-box",
                appearance: "none",
                WebkitAppearance: "none",
                cursor: "pointer",
              }}
            >
              <option value="" disabled>
                Selecione a especialidade
              </option>
              {SPECIALTIES.map((s) => (
                <option key={s.value} value={s.value} style={{ color: "#101B3D" }}>
                  {s.label}
                </option>
              ))}
            </select>
            <ChevronDown size={18} color={t.textMuted} aria-hidden="true" style={{ position: "absolute", right: 14, top: "50%", transform: "translateY(-50%)", pointerEvents: "none" }} />
          </div>
        </div>
      )}

      <InstitutionField value={value.institution} onChange={(institution) => onChange({ institution })} />
    </div>
  );
}

// Busca na lista de instituições conforme a pessoa digita (sem acento, palavras em qualquer ordem). Se não achar, o texto digitado
// fica valendo do jeito que está.
function InstitutionField({ value, onChange }) {
  const t = useT();
  const uid = useId();
  const listId = `${uid}-lista`;
  const [open, setOpen] = useState(false);
  const [active, setActive] = useState(-1);
  const listed = isListedInstitution(value);
  const matches = useMemo(() => (listed ? [] : searchInstitutions(value)), [value, listed]);
  const showList = open && matches.length > 0;

  const pick = (label) => {
    onChange(label);
    setOpen(false);
    setActive(-1);
  };
  const type = (text) => {
    onChange(text.replace(/[<>]/g, "").slice(0, MAX_INSTITUTION_LEN));
    setOpen(true);
    setActive(-1);
  };
  const onKeyDown = (e) => {
    if (e.key === "ArrowDown" && matches.length) {
      e.preventDefault();
      setOpen(true);
      setActive((a) => (a + 1) % matches.length);
    } else if (e.key === "ArrowUp" && matches.length) {
      e.preventDefault();
      setOpen(true);
      setActive((a) => (a <= 0 ? matches.length - 1 : a - 1));
    } else if (e.key === "Enter" && showList && active >= 0) {
      e.preventDefault();
      pick(matches[active]);
    } else if (e.key === "Escape") {
      setOpen(false);
      setActive(-1);
    }
  };
  const split = (label) => {
    const i = label.lastIndexOf(" — ");
    return i < 0 ? [label, ""] : [label.slice(0, i), label.slice(i + 3)];
  };

  return (
    <div>
      <label htmlFor={`${uid}-campo`} style={{ fontSize: 12.5, color: t.textMuted, fontWeight: 600 }}>
        Instituição <span style={{ fontWeight: 400 }}>(opcional)</span>
      </label>
      <div style={{ fontSize: 12, color: t.textMuted, marginTop: 2 }}>Onde você faz ou pretende fazer residência ou especialização em cardiologia.</div>
      <div style={{ position: "relative", marginTop: 6 }}>
        <input
          id={`${uid}-campo`}
          type="text"
          role="combobox"
          aria-expanded={showList}
          aria-controls={listId}
          aria-autocomplete="list"
          aria-activedescendant={showList && active >= 0 ? `${uid}-op-${active}` : undefined}
          autoComplete="off"
          autoCorrect="off"
          spellCheck={false}
          maxLength={MAX_INSTITUTION_LEN}
          placeholder="Digite para buscar (ex.: InCor, Dante, Santa Casa)"
          value={value}
          onChange={(e) => type(e.target.value)}
          onFocus={() => setOpen(true)}
          onBlur={() => setOpen(false)}
          onKeyDown={onKeyDown}
          style={{
            width: "100%",
            padding: "12px 40px 12px 14px",
            borderRadius: 12,
            border: `1px solid ${t.border}`,
            background: t.surfaceAlt,
            color: t.text,
            fontSize: 16,
            boxSizing: "border-box",
          }}
        />
        {value && (
          <button
            type="button"
            aria-label="Limpar instituição"
            onMouseDown={(e) => e.preventDefault()}
            onClick={() => {
              onChange("");
              setActive(-1);
            }}
            style={{ position: "absolute", right: 10, top: "50%", transform: "translateY(-50%)", background: "transparent", border: "none", cursor: "pointer", display: "flex", color: t.textMuted, padding: 4 }}
          >
            <X size={16} />
          </button>
        )}
        {showList && (
          <ul
            id={listId}
            role="listbox"
            style={{
              position: "absolute",
              left: 0,
              right: 0,
              top: "calc(100% + 4px)",
              zIndex: 20,
              margin: 0,
              padding: 4,
              listStyle: "none",
              maxHeight: 240,
              overflowY: "auto",
              background: t.surface,
              border: `1px solid ${t.border}`,
              borderRadius: 12,
              boxShadow: "0 8px 24px rgba(0,0,0,.18)",
            }}
          >
            {matches.map((label, i) => {
              const [nome, onde] = split(label);
              return (
                <li
                  key={label}
                  id={`${uid}-op-${i}`}
                  role="option"
                  aria-selected={i === active}
                  // mousedown (e não click) para o campo não perder o foco antes da escolha
                  onMouseDown={(e) => {
                    e.preventDefault();
                    pick(label);
                  }}
                  onMouseEnter={() => setActive(i)}
                  style={{ padding: "9px 10px", borderRadius: 8, cursor: "pointer", background: i === active ? t.primarySoft : "transparent" }}
                >
                  <div style={{ fontSize: 13.5, fontWeight: 600, color: t.text, lineHeight: 1.3 }}>{nome}</div>
                  {onde && <div style={{ fontSize: 12, color: t.textMuted, marginTop: 1 }}>{onde}</div>}
                </li>
              );
            })}
          </ul>
        )}
      </div>
      {listed && (
        <div style={{ fontSize: 12, color: t.green, marginTop: 6, display: "flex", alignItems: "center", gap: 4 }}>
          <Check size={13} /> Instituição da lista
        </div>
      )}
      {!listed && value.trim().length >= 2 && matches.length === 0 && (
        <div style={{ fontSize: 12, color: t.textMuted, marginTop: 6 }}>Não está na lista? Tudo bem, vamos guardar do jeito que você digitou.</div>
      )}
    </div>
  );
}
