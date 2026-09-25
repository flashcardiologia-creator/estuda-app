"use client";

import { useEffect, useState } from "react";
import { ChevronLeft, Target } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { PrimaryButton, Tag, Flame_ } from "@/components/ui/Primitives";
import { QuestionCard } from "@/components/screens/QuestionCard";
import { fetchFriendsMissionStatus } from "@/lib/data/friends";
import { msUntilNextDayBoundary, formatCountdownClock } from "@/lib/util";

const dailyFilters = { fontSize: "md", modoProva: false, mostrarAntigas: false };

function MissionCountdown() {
  const [remaining, setRemaining] = useState(msUntilNextDayBoundary);

  useEffect(() => {
    const interval = setInterval(() => setRemaining(msUntilNextDayBoundary()), 1000);
    return () => clearInterval(interval);
  }, []);

  const t = useT();
  return (
    <span style={{ fontSize: 13, fontWeight: 700, color: t.textMuted, fontVariantNumeric: "tabular-nums" }}>
      {formatCountdownClock(remaining)}
    </span>
  );
}

export function MissionShell({ idx, total, onNavigate, children }) {
  const t = useT();
  return (
    <div style={{ maxWidth: 620, margin: "0 auto", paddingBottom: 90 }}>
      <div style={{ display: "grid", gridTemplateColumns: "1fr auto 1fr", alignItems: "center", padding: "18px 22px 0" }}>
        <button
          onClick={() => onNavigate("home")}
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
            fontSize: 13.5,
            fontWeight: 600,
          }}
        >
          <ChevronLeft size={16} /> Voltar
        </button>
        <MissionCountdown />
        <span
          style={{
            justifySelf: "end",
            fontSize: 15,
            fontWeight: 700,
            color: t.text,
            display: "flex",
            alignItems: "center",
            gap: 6,
          }}
        >
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
    </MissionShell>
  );
}

export function DailyDoneScreen({ supabase, streak, friends, onNavigate }) {
  const t = useT();
  const [friendsStatus, setFriendsStatus] = useState(null);

  useEffect(() => {
    if (!friends || !friends.length) {
      setFriendsStatus([]);
      return;
    }
    fetchFriendsMissionStatus(
      supabase,
      friends.map((f) => f.id)
    )
      .then(setFriendsStatus)
      .catch(() => setFriendsStatus([]));
  }, [supabase, friends]);

  return (
    <div style={{ maxWidth: 480, margin: "80px auto", textAlign: "center", padding: 22 }}>
      <Flame_ done size={54} />
      <h2 style={{ fontSize: 24, color: t.text, marginTop: 16 }}>Missão concluída!</h2>
      <p style={{ color: t.textMuted, fontSize: 14, marginTop: 14, lineHeight: 1.6 }}>
        Você está numa sequência de <b style={{ color: t.green }}>{streak} {streak === 1 ? "dia" : "dias"}</b>.
        <br />
        Volte amanhã para manter a chama acesa.
      </p>
      <div style={{ marginTop: 20 }}>
        <PrimaryButton onClick={() => onNavigate("home")}>Voltar ao início</PrimaryButton>
      </div>

      {friendsStatus && friendsStatus.length > 0 && (
        <div style={{ marginTop: 32, textAlign: "left" }}>
          <div style={{ fontSize: 12.5, fontWeight: 700, color: t.textMuted, marginBottom: 10, textAlign: "center" }}>
            SEUS AMIGOS
          </div>
          <div style={{ display: "flex", flexDirection: "column", gap: 8 }}>
            {friendsStatus.map((f) => {
              const shownStreak = f.done_today ? f.streak : 0;
              return (
                <div
                  key={f.id}
                  style={{
                    display: "flex",
                    alignItems: "center",
                    gap: 10,
                    background: t.surface,
                    border: `1px solid ${t.border}`,
                    borderRadius: 12,
                    padding: "10px 14px",
                  }}
                >
                  <Flame_ done={f.done_today} size={18} />
                  <div style={{ flex: 1 }}>
                    <div style={{ fontSize: 13.5, fontWeight: 600, color: t.text }}>{f.name}</div>
                    <div style={{ fontSize: 11.5, color: t.textMuted, marginTop: 1 }}>
                      Sequência de {shownStreak} {shownStreak === 1 ? "dia" : "dias"}
                    </div>
                  </div>
                  <span
                    style={{
                      fontSize: 11,
                      fontWeight: 700,
                      color: f.done_today ? t.green : t.red,
                    }}
                  >
                    {f.done_today ? "Concluída" : "Pendente"}
                  </span>
                </div>
              );
            })}
          </div>
        </div>
      )}
    </div>
  );
}
