"use client";

import { useEffect, useRef, useState } from "react";
import { ChevronLeft, ChevronRight, Timer } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { PrimaryButton } from "@/components/ui/Primitives";
import { QuestionCard } from "@/components/screens/QuestionCard";
import { ReportButton, ReportIssueModal } from "@/components/ui/ReportIssue";

function formatClock(ms) {
  const totalSeconds = Math.max(0, Math.ceil(ms / 1000));
  const m = Math.floor(totalSeconds / 60);
  const s = totalSeconds % 60;
  return `${m}:${String(s).padStart(2, "0")}`;
}

export function QuestionsSessionScreen({
  supabase,
  userId,
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
  const [finishing, setFinishing] = useState(false);
  const [showReport, setShowReport] = useState(false);
  const [dragNum, setDragNum] = useState(null);
  const barTrackRef = useRef(null);
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
  const struckLetras = session.struck?.[qid] || [];
  const isLast = idx === total - 1;

  if (!q) return null;

  const selectOption = (letra) => {
    if (answered) return;
    setSession((s) => ({ ...s, selected: { ...s.selected, [qid]: letra } }));
  };

  const toggleStruck = (letra) => {
    if (answered) return;
    setSession((s) => {
      const current = s.struck?.[qid] || [];
      const next = current.includes(letra) ? current.filter((l) => l !== letra) : [...current, letra];
      const nextSelected = next.includes(s.selected[qid]) ? { ...s.selected, [qid]: null } : s.selected;
      return { ...s, struck: { ...s.struck, [qid]: next }, selected: nextSelected };
    });
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

  const numberFromClientX = (clientX) => {
    const rect = barTrackRef.current.getBoundingClientRect();
    const ratio = Math.min(1, Math.max(0, (clientX - rect.left) / rect.width));
    return Math.min(total, Math.max(1, Math.round(ratio * total) || 1));
  };

  const handleBarPointerDown = (e) => {
    e.currentTarget.setPointerCapture(e.pointerId);
    setDragNum(numberFromClientX(e.clientX));
  };
  const handleBarPointerMove = (e) => {
    if (dragNum === null) return;
    setDragNum(numberFromClientX(e.clientX));
  };
  const handleBarPointerUp = () => {
    if (dragNum === null) return;
    const target = dragNum;
    setDragNum(null);
    setSession((s) => ({ ...s, index: target - 1 }));
  };

  const finish = async () => {
    setFinishing(true);
    try {
      await onFinish();
    } finally {
      setFinishing(false);
    }
  };

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
        <div style={{ display: "flex", alignItems: "center", gap: 10 }}>
          <span style={{ fontSize: 15, fontWeight: 700, color: t.text }}>
            Questão {idx + 1} de {total}
          </span>
          <ReportButton onClick={() => setShowReport(true)} />
        </div>
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

      <div
        ref={barTrackRef}
        onPointerDown={handleBarPointerDown}
        onPointerMove={handleBarPointerMove}
        onPointerUp={handleBarPointerUp}
        onPointerCancel={handleBarPointerUp}
        style={{ position: "relative", margin: "14px 22px 0", padding: "13px 0", cursor: "pointer", touchAction: "none" }}
      >
        <div style={{ height: 4, background: t.border, borderRadius: 999 }}>
          <div
            style={{
              height: 4,
              width: `${((dragNum ?? idx + 1) / total) * 100}%`,
              background: t.primary,
              borderRadius: 999,
              transition: dragNum === null ? "width .2s" : "none",
            }}
          />
        </div>
        <div
          style={{
            position: "absolute",
            top: "50%",
            left: `${((dragNum ?? idx + 1) / total) * 100}%`,
            transform: "translate(-50%, -50%)",
            width: 16,
            height: 16,
            borderRadius: "50%",
            background: t.primary,
            border: `2px solid ${t.bg}`,
            boxShadow: "0 1px 4px rgba(0,0,0,0.35)",
          }}
        />
        {dragNum !== null && (
          <div
            style={{
              position: "absolute",
              bottom: "100%",
              left: `${(dragNum / total) * 100}%`,
              transform: "translateX(-50%)",
              marginBottom: 6,
              background: t.primary,
              color: "#fff",
              fontSize: 12.5,
              fontWeight: 800,
              padding: "4px 10px",
              borderRadius: 8,
              whiteSpace: "nowrap",
              pointerEvents: "none",
            }}
          >
            {dragNum}
            <div
              style={{
                position: "absolute",
                top: "100%",
                left: "50%",
                transform: "translateX(-50%)",
                width: 0,
                height: 0,
                borderLeft: "5px solid transparent",
                borderRight: "5px solid transparent",
                borderTop: `5px solid ${t.primary}`,
              }}
            />
          </div>
        )}
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
          struckLetras={struckLetras}
          onToggleStruck={toggleStruck}
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
              <PrimaryButton full onClick={finish} disabled={responding || finishing}>
                Finalizar
              </PrimaryButton>
            ) : (
              <PrimaryButton full onClick={() => go(1)} disabled={responding}>
                Próxima
                <ChevronRight size={16} style={{ marginLeft: 4 }} />
              </PrimaryButton>
            )}
          </div>
        </div>
      </div>

      {showReport && (
        <ReportIssueModal
          supabase={supabase}
          userId={userId}
          itemType="question"
          itemId={qid}
          onClose={() => setShowReport(false)}
        />
      )}
    </div>
  );
}
