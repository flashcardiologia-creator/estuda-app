"use client";

import { useState } from "react";
import { ChevronLeft, Target } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { PrimaryButton, Tag, Flame_ } from "@/components/ui/Primitives";
import { QuestionCard } from "@/components/screens/QuestionCard";

const dailyFilters = { fontSize: "md", modoProva: false, mostrarAntigas: false };

export function MissionShell({ idx, total, onNavigate, children }) {
  const t = useT();
  return (
    <div style={{ maxWidth: 620, margin: "0 auto", paddingBottom: 90 }}>
      <div style={{ display: "flex", alignItems: "center", justifyContent: "space-between", padding: "18px 22px 0" }}>
        <button
          onClick={() => onNavigate("home")}
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
          <ChevronLeft size={16} /> Sair
        </button>
        <span style={{ fontSize: 15, fontWeight: 700, color: t.text, display: "flex", alignItems: "center", gap: 6 }}>
          <Target size={14} color={t.amber} /> Missão {idx + 1} de {total}
        </span>
      </div>
      <div style={{ height: 4, background: t.border, margin: "14px 22px 0", borderRadius: 999 }}>
        <div style={{ height: 4, width: `${((idx + 1) / total) * 100}%`, background: t.amber, borderRadius: 999, transition: "width .2s" }} />
      </div>
      <div style={{ padding: 22 }}>{children}</div>
    </div>
  );
}

export function MissionNav({ canNext, idx, total, onNext, onFinish, color, finishing }) {
  const isLast = idx === total - 1;
  return (
    <div style={{ marginTop: 24 }}>
      {isLast ? (
        <PrimaryButton full disabled={!canNext || finishing} color={color} onClick={onFinish}>
          Concluir Missão
        </PrimaryButton>
      ) : (
        <PrimaryButton full disabled={!canNext} color={color} onClick={onNext}>
          Próxima
        </PrimaryButton>
      )}
    </div>
  );
}

export function DailyMissionScreen({
  items,
  optionsByQuestion,
  session,
  setSession,
  onAnswer,
  onFinishDaily,
  onNavigate,
  favorites,
  onToggleFav,
  history,
}) {
  const [responding, setResponding] = useState(false);
  const [finishing, setFinishing] = useState(false);
  const idx = session.index;
  const item = items[idx];
  const total = items.length;

  if (item.type === "question") {
    const q = item.data;
    const options = optionsByQuestion[q.id] || [];
    const answered = !!session.answers[q.id];
    const answerResult = session.answers[q.id];
    const selected = session.selected[q.id] || null;
    const selectOption = (letra) => {
      if (!answered) setSession((s) => ({ ...s, selected: { ...s.selected, [q.id]: letra } }));
    };
    const responder = async () => {
      setResponding(true);
      try {
        const result = await onAnswer(q.id, selected);
        setSession((s) => ({ ...s, answers: { ...s.answers, [q.id]: result } }));
      } finally {
        setResponding(false);
      }
    };
    const finish = async () => {
      setFinishing(true);
      try {
        await onFinishDaily();
      } finally {
        setFinishing(false);
      }
    };
    return (
      <MissionShell idx={idx} total={total} onNavigate={onNavigate}>
        <QuestionCard
          q={q}
          options={options}
          filters={dailyFilters}
          selected={selected}
          onSelect={selectOption}
          answered={answered}
          answerResult={answerResult}
          onResponder={responder}
          responding={responding}
          history={history[q.id]}
          isFav={favorites.includes(q.id)}
          onToggleFav={onToggleFav}
        />
        {answered && (
          <MissionNav
            canNext={answered}
            idx={idx}
            total={total}
            finishing={finishing}
            onNext={() => setSession((s) => ({ ...s, index: s.index + 1 }))}
            onFinish={finish}
          />
        )}
      </MissionShell>
    );
  }

  const card = item.data;
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
  const finishFlash = async () => {
    setFinishing(true);
    try {
      await onFinishDaily();
    } finally {
      setFinishing(false);
    }
  };

  return (
    <DailyFlashcard
      card={card}
      flipped={flipped}
      viewed={viewed}
      idx={idx}
      total={total}
      onFlip={flip}
      onNavigate={onNavigate}
      onNext={() => setSession((s) => ({ ...s, index: s.index + 1 }))}
      onFinish={finishFlash}
      finishing={finishing}
    />
  );
}

function DailyFlashcard({ card, flipped, viewed, idx, total, onFlip, onNavigate, onNext, onFinish, finishing }) {
  const t = useT();
  const answerBg = t.name === "light" ? "linear-gradient(135deg, #A9DDBD 0%, #C7C7CE 100%)" : "rgba(19,46,36,0.5)";
  const answerBorder = t.name === "light" ? "#16A34A" : "#2FB380";
  return (
    <MissionShell idx={idx} total={total} onNavigate={onNavigate}>
      <div
        onClick={onFlip}
        style={{
          cursor: "pointer",
          minHeight: 220,
          borderRadius: 20,
          border: `1.5px solid ${t.border}`,
          background: flipped ? answerBg : t.surface,
          display: "flex",
          flexDirection: "column",
          alignItems: "center",
          justifyContent: "center",
          textAlign: "center",
          padding: 26,
        }}
      >
        {flipped && <div style={{ fontWeight: 700, fontSize: 14, color: answerBorder, marginBottom: 12 }}>Resposta</div>}
        {!flipped && <Tag>{card.tema}</Tag>}
        <div style={{ fontWeight: 700, fontSize: 18, color: t.text, marginTop: flipped ? 0 : 16 }}>
          {flipped ? card.resposta : card.pergunta}
        </div>
        <div style={{ fontSize: 12.5, color: flipped ? answerBorder : t.primary, marginTop: 18, fontWeight: 600 }}>
          {flipped ? "Clique para ver a pergunta" : "Clique para ver a resposta"}
        </div>
      </div>
      <MissionNav canNext={viewed} idx={idx} total={total} color="#21512E" finishing={finishing} onNext={onNext} onFinish={onFinish} />
      {!viewed && (
        <div style={{ textAlign: "center", fontSize: 12, color: t.textMuted, marginTop: 10 }}>
          Veja a resposta para liberar o próximo cartão.
        </div>
      )}
    </MissionShell>
  );
}

export function DailyDoneScreen({ streak, onNavigate }) {
  const t = useT();
  return (
    <div style={{ maxWidth: 480, margin: "80px auto", textAlign: "center", padding: 22 }}>
      <Flame_ done size={54} />
      <h2 style={{ fontSize: 24, color: t.text, marginTop: 16 }}>Missão concluída!</h2>
      <p style={{ color: t.textMuted, fontSize: 14 }}>
        Você está numa sequência de <b style={{ color: t.green }}>{streak} dias</b>. Volte amanhã para manter a chama acesa.
      </p>
      <div style={{ marginTop: 20 }}>
        <PrimaryButton onClick={() => onNavigate("home")}>Voltar ao início</PrimaryButton>
      </div>
    </div>
  );
}
