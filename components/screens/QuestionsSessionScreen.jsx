"use client";

import { useEffect, useRef, useState } from "react";
import { ChevronLeft, ChevronRight, Timer } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { PrimaryButton } from "@/components/ui/Primitives";
import { QuestionCard } from "@/components/screens/QuestionCard";

function formatClock(ms) {
  const totalSeconds = Math.max(0, Math.ceil(ms / 1000));
  const m = Math.floor(totalSeconds / 60);
  const s = totalSeconds % 60;
  return `${m}:${String(s).padStart(2, "0")}`;
}

export function QuestionsSessionScreen({
  session,
  setSession,
  questionsById,
  optionsByQuestion,
  filters,
  favorites,
  onToggleFav,
  onAnswer,
  onFinish,
  onBack,
}) {
  const t = useT();
  const [responding, setResponding] = useState(false);
  const timerActive = !!(session.startedAt && session.durationMs);
  const [remainingMs, setRemainingMs] = useState(
    timerActive ? session.startedAt + session.durationMs - Date.now() : null
  );
  const finishedByTimerRef = useRef(false);

  useEffect(() => {
    if (!timerActive) return;
    const tick = () => {
      const remaining = session.startedAt + session.durationMs - Date.now();
      setRemainingMs(remaining);
      if (remaining <= 0 && !finishedByTimerRef.current) {
        finishedByTimerRef.current = true;
        onFinish();
      }
    };
    tick();
    const interval = setInterval(tick, 1000);
    return () => clearInterval(interval);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [timerActive, session.startedAt, session.durationMs]);

  const total = session.ids.length;
  const idx = session.index;
  const qid = session.ids[idx];
  const q = questionsById[qid];
  const options = optionsByQuestion[qid] || [];
  const answered = !!session.answers[qid];
  const answerResult = session.answers[qid];
  const selected = session.selected[qid] || null;
  const prefilled = !!session.prefilled?.[qid];
  const isLast = idx === total - 1;

  if (!q) return null;

  const selectOption = (letra) => {
    if (answered) return;
    setSession((s) => ({ ...s, selected: { ...s.selected, [qid]: letra } }));
  };

  const responder = async () => {
    setResponding(true);
    try {
      const result = await onAnswer(qid, selected);
      setSession((s) => ({
        ...s,
        answers: { ...s.answers, [qid]: result },
        prefilled: { ...s.prefilled, [qid]: false },
      }));
    } finally {
      setResponding(false);
    }
  };

  const retry = () => {
    setSession((s) => {
      const selectedMap = { ...s.selected };
      const answersMap = { ...s.answers };
      delete selectedMap[qid];
      delete answersMap[qid];
      return { ...s, selected: selectedMap, answers: answersMap, prefilled: { ...s.prefilled, [qid]: false } };
    });
  };

  const go = (dir) => setSession((s) => ({ ...s, index: Math.min(total - 1, Math.max(0, s.index + dir)) }));

  return (
    <div style={{ maxWidth: 640, margin: "0 auto", paddingBottom: 90 }}>
      <div style={{ display: "flex", alignItems: "center", justifyContent: "space-between", padding: "18px 22px 0" }}>
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
            fontSize: 13.5,
            fontWeight: 600,
          }}
        >
          <ChevronLeft size={16} /> Voltar
        </button>
        <span style={{ fontSize: 15, fontWeight: 700, color: t.text }}>
          Questão {idx + 1} de {total}
        </span>
      </div>

      {timerActive && (
        <div style={{ display: "flex", justifyContent: "center", marginTop: 10 }}>
          <div
            style={{
              display: "flex",
              alignItems: "center",
              gap: 6,
              padding: "5px 12px",
              borderRadius: 999,
              background: remainingMs <= 60000 ? "rgba(229,72,77,0.14)" : t.surfaceAlt,
              border: `1px solid ${remainingMs <= 60000 ? t.red : t.border}`,
            }}
          >
            <Timer size={13} color={remainingMs <= 60000 ? t.red : t.textMuted} />
            <span
              style={{
                fontSize: 12.5,
                fontWeight: 700,
                color: remainingMs <= 60000 ? t.red : t.textMuted,
                fontVariantNumeric: "tabular-nums",
              }}
            >
              {formatClock(remainingMs)}
            </span>
          </div>
        </div>
      )}

      <div style={{ height: 4, background: t.border, margin: "14px 22px 0", borderRadius: 999 }}>
        <div style={{ height: 4, width: `${((idx + 1) / total) * 100}%`, background: t.primary, borderRadius: 999, transition: "width .2s" }} />
      </div>

      <div style={{ padding: "22px" }}>
        <QuestionCard
          q={q}
          options={options}
          filters={filters}
          selected={selected}
          onSelect={selectOption}
          answered={answered}
          answerResult={answerResult}
          onResponder={responder}
          responding={responding}
          prefilled={prefilled}
          onRetry={retry}
          isFav={favorites.includes(qid)}
          onToggleFav={onToggleFav}
        />

        <div style={{ display: "flex", gap: 10, marginTop: 26 }}>
          <div style={{ flex: 1 }}>
            <PrimaryButton full variant="ghost" disabled={idx === 0} onClick={() => go(-1)}>
              <ChevronLeft size={16} style={{ marginRight: 4 }} />
              Anterior
            </PrimaryButton>
          </div>
          <div style={{ flex: 1 }}>
            {isLast ? (
              <PrimaryButton full onClick={onFinish}>
                Finalizar
              </PrimaryButton>
            ) : (
              <PrimaryButton full onClick={() => go(1)}>
                Próxima
                <ChevronRight size={16} style={{ marginLeft: 4 }} />
              </PrimaryButton>
            )}
          </div>
        </div>
      </div>
    </div>
  );
}
