"use client";

import { ChevronLeft } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { PrimaryButton, Tag } from "@/components/ui/Primitives";

export function FlashcardsSessionScreen({ session, setSession, onNavigate }) {
  const t = useT();
  const total = session.ids.length;
  const idx = session.index;
  const card = session.cardsById[session.ids[idx]];
  const flipped = session.flipped[card.id] || false;
  const viewed = !!(session.viewed && session.viewed[card.id]);

  const flip = () =>
    setSession((s) => {
      const nextFlipped = !s.flipped[card.id];
      return {
        ...s,
        flipped: { ...s.flipped, [card.id]: nextFlipped },
        viewed: nextFlipped ? { ...s.viewed, [card.id]: true } : s.viewed,
      };
    });
  const go = (dir) =>
    setSession((s) => {
      const newIndex = Math.min(total - 1, Math.max(0, s.index + dir));
      const targetId = s.ids[newIndex];
      const flipped = dir < 0 ? { ...s.flipped, [targetId]: false } : s.flipped;
      return { ...s, index: newIndex, flipped };
    });

  const answerBg = t.name === "light" ? "linear-gradient(135deg, #A9DDBD 0%, #C7C7CE 100%)" : "rgba(19,46,36,0.5)";
  const answerBorder = t.name === "light" ? "#16A34A" : "#2FB380";

  return (
    <div style={{ maxWidth: 560, margin: "0 auto", paddingBottom: 90 }}>
      <div style={{ display: "flex", alignItems: "center", justifyContent: "space-between", padding: "18px 22px 0" }}>
        <button
          onClick={() => onNavigate("flashcards-select")}
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
            fontSize: 13.5,
            fontWeight: 600,
          }}
        >
          <ChevronLeft size={16} /> Voltar
        </button>
        <span style={{ fontSize: 15, fontWeight: 700, color: t.text }}>
          Flashcard {idx + 1} de {total}
        </span>
      </div>

      <div style={{ padding: "26px 22px 0" }}>
        <div
          onClick={flip}
          style={{
            cursor: "pointer",
            minHeight: 260,
            borderRadius: 20,
            border: `1.5px solid ${t.border}`,
            background: flipped ? answerBg : t.surface,
            display: "flex",
            flexDirection: "column",
            alignItems: "center",
            justifyContent: "center",
            textAlign: "center",
            padding: 30,
            transition: "background .2s, border-color .2s",
          }}
        >
          {flipped && <div style={{ fontWeight: 700, fontSize: 15, color: answerBorder, marginBottom: 14 }}>Resposta</div>}
          {!flipped && <Tag>{card.tema}</Tag>}
          <div style={{ fontWeight: 700, fontSize: 20, color: t.text, marginTop: flipped ? 0 : 18, lineHeight: 1.4 }}>
            {flipped ? card.resposta : card.pergunta}
          </div>
          <div style={{ fontSize: 13, color: flipped ? answerBorder : t.primary, marginTop: 22, fontWeight: 600 }}>
            {flipped ? "Clique para ver a pergunta" : "Clique para ver a resposta"}
          </div>
        </div>

        <div style={{ display: "flex", justifyContent: "space-between", gap: 10, marginTop: 24 }}>
          <PrimaryButton variant="ghost" disabled={idx === 0} onClick={() => go(-1)}>
            Anterior
          </PrimaryButton>
          {idx < total - 1 ? (
            <PrimaryButton disabled={!viewed} color="#21512E" onClick={() => go(1)}>
              Próximo
            </PrimaryButton>
          ) : (
            <PrimaryButton disabled={!viewed} color="#21512E" onClick={() => onNavigate("home")}>
              Concluir
            </PrimaryButton>
          )}
        </div>
      </div>
    </div>
  );
}
