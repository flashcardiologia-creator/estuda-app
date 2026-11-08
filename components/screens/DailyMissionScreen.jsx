"use client";

import { useEffect, useState } from "react";
import { Bandage, Brain, Check, ChevronLeft, Layers, ListChecks, Target } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { ExpandBox, PrimaryButton, Tag, Flame_ } from "@/components/ui/Primitives";
import { ForgettingCurve, REVISOES } from "@/components/screens/ForgettingCurve";
import { QuestionCard } from "@/components/screens/QuestionCard";
import { fetchFriendsMissionStatus, fetchFriendsStreaks } from "@/lib/data/friends";
import { getDailyMode, setDailyMode } from "@/lib/data/dailyMode";
import { msUntilNextDayBoundary, msSincePreviousDayBoundary, MISSION_GRACE_MS, formatCountdownClock } from "@/lib/util";

const FLASHCARD_FONT_SIZES = { sm: 16, md: 20, lg: 24 };

function formatGraceClock(ms) {
  const totalSeconds = Math.max(0, Math.ceil(ms / 1000));
  const m = Math.floor(totalSeconds / 60);
  const s = totalSeconds % 60;
  return `${m}:${String(s).padStart(2, "0")}`;
}

function MissionCountdown() {
  const t = useT();
  // Só serve pra forçar um re-render por segundo — os valores em si vêm
  // sempre do relógio real a cada render, não de um estado acumulado.
  const [, forceTick] = useState(0);

  useEffect(() => {
    const interval = setInterval(() => forceTick((n) => n + 1), 1000);
    return () => clearInterval(interval);
  }, []);

  const sincePrev = msSincePreviousDayBoundary();
  const inGrace = sincePrev < MISSION_GRACE_MS;
  const remaining = inGrace ? 0 : msUntilNextDayBoundary();
  const graceRemaining = inGrace ? MISSION_GRACE_MS - sincePrev : 0;

  return (
    <span style={{ fontSize: 13, fontWeight: 700, fontVariantNumeric: "tabular-nums" }}>
      <span style={{ color: t.textMuted }}>{formatCountdownClock(remaining)}</span>
      {inGrace && <span style={{ color: t.red, marginLeft: 5 }}>(+{formatGraceClock(graceRemaining)})</span>}
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
          <Target size={14} color={t.amber} /> Revisão {idx + 1} de {total}
        </span>
      </div>
      <div style={{ height: 4, background: t.border, margin: "14px 22px 0", borderRadius: 999 }}>
        <div style={{ height: 4, width: `${((idx + 1) / total) * 100}%`, background: t.amber, borderRadius: 999, transition: "width .2s" }} />
      </div>
      <div style={{ padding: 22 }}>{children}</div>
    </div>
  );
}

export function MissionNav({ canNext, idx, total, onNext, onFinish, color, finishing, onPrev, hideNext }) {
  const isLast = idx === total - 1;
  return (
    <div style={{ marginTop: 24, display: "flex", alignItems: "center", gap: 10 }}>
      {/* Voltar a um exercício já feito: as questões respondidas aparecem só para ler, sem trocar a resposta. */}
      {onPrev && idx > 0 && (
        <PrimaryButton variant="ghost" onClick={onPrev}>
          <ChevronLeft size={16} style={{ marginRight: 2, marginLeft: -4 }} />
          Anterior
        </PrimaryButton>
      )}
      {!hideNext && (
        <div style={{ flex: 1, minWidth: 0 }}>
          {isLast ? (
            <PrimaryButton full disabled={!canNext || finishing} color={color} onClick={onFinish}>
              Concluir Revisão
            </PrimaryButton>
          ) : (
            <PrimaryButton full disabled={!canNext} color={color} onClick={onNext}>
              Próxima
            </PrimaryButton>
          )}
        </div>
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
  onView,
  questionFontSize,
  flashcardFontSize,
}) {
  const [responding, setResponding] = useState(false);
  const [finishing, setFinishing] = useState(false);
  const idx = session.index;
  const item = items[idx];
  const total = items.length;
  const goPrev = idx > 0 ? () => setSession((s) => ({ ...s, index: Math.max(0, s.index - 1) })) : undefined;
  const dailyFilters = { fontSize: questionFontSize || "md", modoProva: false, mostrarAntigas: false };

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
        {(answered || goPrev) && (
          <MissionNav
            canNext={answered}
            hideNext={!answered}
            idx={idx}
            total={total}
            finishing={finishing}
            onPrev={goPrev}
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
  const flip = () => {
    const nextFlipped = !flipped;
    if (nextFlipped) onView?.(card.id);
    setSession((s) => ({
      ...s,
      flipped: { ...s.flipped, [card.id]: nextFlipped },
      viewed: nextFlipped ? { ...s.viewed, [card.id]: true } : s.viewed,
    }));
  };
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
      onPrev={goPrev}
      onNext={() => setSession((s) => ({ ...s, index: s.index + 1 }))}
      onFinish={finishFlash}
      finishing={finishing}
      fontSize={flashcardFontSize}
    />
  );
}

function DailyFlashcard({ card, flipped, viewed, idx, total, onFlip, onNavigate, onPrev, onNext, onFinish, finishing, fontSize }) {
  const t = useT();
  const cardFontSize = FLASHCARD_FONT_SIZES[fontSize] || FLASHCARD_FONT_SIZES.md;
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
        <div style={{ fontWeight: 700, fontSize: cardFontSize, color: t.text, marginTop: flipped ? 0 : 16 }}>
          {flipped ? card.resposta : card.pergunta}
        </div>
        <div style={{ fontSize: 12.5, color: flipped ? answerBorder : t.primary, marginTop: 18, fontWeight: 600 }}>
          {flipped ? "Clique para ver a pergunta" : "Clique para ver a resposta"}
        </div>
      </div>
      <MissionNav canNext={viewed} idx={idx} total={total} color="#21512E" finishing={finishing} onPrev={onPrev} onNext={onNext} onFinish={onFinish} />
    </MissionShell>
  );
}

const MISSION_FORMATS = [
  { id: "mix", big: "5+5", title: "Questões + flashcards", sub: "5 de cada", Icon: Layers, gradient: "linear-gradient(135deg, #7C5CFC 0%, #4F46E5 100%)" },
  { id: "questions", big: "10", title: "Só questões", sub: "10 para revisar", Icon: ListChecks, gradient: "linear-gradient(135deg, #F2A93B 0%, #E5484D 100%)" },
];

// Box "Por que revisar na hora certa?": começa fechado e abre ao tocar. Explica a curva do esquecimento de Ebbinghaus,
// com o gráfico das revisões (ilustração).
function WhyReview() {
  const t = useT();
  const [open, setOpen] = useState(false);
  return (
    <div style={{ marginTop: 14, textAlign: "left" }}>
      <ExpandBox title="Por que revisar na hora certa?" icon={<Brain size={17} color={t.primary} />} open={open} onToggle={() => setOpen((o) => !o)}>
        <p style={{ fontSize: 12.5, lineHeight: 1.55, color: t.textMuted, margin: "0 0 10px" }}>
          Pela <b style={{ color: t.text }}>curva do esquecimento de Ebbinghaus</b>, sem revisão a memória despenca logo nas primeiras horas. Cada revisão na hora certa a leva de volta a 100%, e a curva seguinte cai cada vez mais devagar. Por isso a revisão traz as questões que você errou, na hora de revisar. Se faltar, completamos com outras que acertou ou ainda não realizou.
        </p>
        <ForgettingCurve />
        <div style={{ display: "flex", justifyContent: "center", flexWrap: "wrap", gap: "4px 16px", marginTop: 6, fontSize: 11, color: t.textMuted }}>
          <span style={{ display: "inline-flex", alignItems: "center", gap: 6 }}>
            <i style={{ width: 16, height: 0, borderTop: `2.5px solid ${t.red}` }} />
            Sem revisar
          </span>
          <span style={{ display: "inline-flex", alignItems: "center", gap: 6 }}>
            <span style={{ display: "inline-flex", gap: 2 }}>
              {REVISOES.map((r) => (
                <i key={r.n} style={{ width: 5, height: 5, borderRadius: 3, background: r.color }} />
              ))}
            </span>
            Com revisões
          </span>
        </div>
        <div style={{ fontSize: 10.5, color: t.textMuted, textAlign: "center", marginTop: 4, opacity: 0.85 }}>
          Ilustração: 1ª revisão em 20 min, 2ª em 24 h, 3ª em 7 dias e 4ª em 30 dias.
        </div>
      </ExpandBox>
    </div>
  );
}

// Escolha do formato da missão diária, na tela de conclusão. Vale a partir da missão de amanhã
// (a de hoje já foi sorteada) e continua até a pessoa trocar.
function MissionFormat({ supabase, userId }) {
  const t = useT();
  const [choice, setChoice] = useState(null);
  const [saved, setSaved] = useState(null); // null = nada salvo agora; true = salvo na conta; false = só neste aparelho

  useEffect(() => {
    let cancelled = false;
    getDailyMode(supabase, userId).then((mode) => {
      if (!cancelled) setChoice(mode);
    });
    return () => {
      cancelled = true;
    };
  }, [supabase, userId]);

  const pick = async (id) => {
    if (id === choice) return;
    setChoice(id);
    setSaved(await setDailyMode(supabase, userId, id));
  };

  return (
    <div style={{ marginTop: 16, textAlign: "left" }}>
      <p style={{ fontSize: 13, fontWeight: 700, color: t.amber, textAlign: "center", margin: "0 0 10px", lineHeight: 1.4 }}>
        A partir de amanhã, como você quer a sua revisão?
      </p>

      <div style={{ display: "grid", gridTemplateColumns: "1fr 1fr", gap: 10 }}>
        {MISSION_FORMATS.map(({ id, big, title, sub, Icon, gradient }) => {
          const selected = choice === id;
          return (
            <button
              key={id}
              onClick={() => pick(id)}
              aria-pressed={selected}
              style={{
                textAlign: "left",
                border: "none",
                borderRadius: 16,
                padding: 12,
                background: gradient,
                color: "#fff",
                cursor: "pointer",
                fontFamily: "inherit",
                opacity: choice && !selected ? 0.6 : 1,
                boxShadow: selected ? `0 0 0 2px ${t.bg}, 0 0 0 4px ${t.primary}, 0 8px 18px rgba(0,0,0,0.28)` : "0 5px 12px rgba(0,0,0,0.2)",
                transition: "opacity .15s, box-shadow .15s",
              }}
            >
              <span style={{ display: "flex", alignItems: "center", justifyContent: "space-between" }}>
                <span style={{ fontSize: 26, fontWeight: 800, letterSpacing: -0.5, lineHeight: 1 }}>{big}</span>
                {selected ? (
                  <span style={{ width: 22, height: 22, borderRadius: 11, background: "#fff", color: "#1a1a2e", display: "flex", alignItems: "center", justifyContent: "center" }}>
                    <Check size={14} strokeWidth={3} />
                  </span>
                ) : (
                  <Icon size={19} style={{ opacity: 0.85 }} />
                )}
              </span>
              <span style={{ display: "block", fontSize: 13.5, fontWeight: 700, marginTop: 8, lineHeight: 1.25 }}>{title}</span>
              <span style={{ display: "block", fontSize: 11.5, opacity: 0.88, marginTop: 2, lineHeight: 1.3 }}>{sub}</span>
            </button>
          );
        })}
      </div>

      {/* Só aparece depois de a pessoa trocar o formato: confirma que salvou (ou avisa que ficou só neste aparelho). */}
      {saved != null && (
        <div role="status" style={{ fontSize: 11.5, color: saved ? t.textMuted : t.red, textAlign: "center", marginTop: 8, lineHeight: 1.5 }}>
          {saved ? "Salvo!" : "Salvo só neste aparelho por enquanto. Vale a partir de amanhã."}
        </div>
      )}

      <WhyReview />
    </div>
  );
}

// Ao fim da missão no plano gratuito: o que muda com a assinatura, e o botão que leva à tela de planos.
function PlanComparison({ t, onSubscribe }) {
  const rows = [
    {
      title: "Dias seguidos",
      free: "Os dias de revisão não são contados.",
      paid: "Cada revisão conta e a sua sequência de dias cresce.",
    },
    {
      title: "Quais questões vêm",
      free: "Questões aleatórias do banco.",
      paid: "Revisão pela curva de Ebbinghaus: as questões que você errou voltam na revisão diária, no momento certo, para fixar o conteúdo.",
    },
    {
      title: "Tamanho da revisão",
      free: "3 questões, sem flashcards.",
      paid: "Até 10 questões, ou 5 questões + 5 flashcards.",
    },
  ];
  return (
    <div style={{ marginTop: 26, textAlign: "left", background: t.surface, border: `1px solid ${t.border}`, borderRadius: 18, padding: "18px 18px 20px" }}>
      <div style={{ fontSize: 16.5, fontWeight: 800, color: t.text, textAlign: "center" }}>Plano gratuito x Assinatura</div>
      <div style={{ fontSize: 12.5, color: t.textMuted, textAlign: "center", marginTop: 4 }}>Veja o que muda na revisão diária</div>
      <div style={{ display: "flex", flexDirection: "column", gap: 14, marginTop: 16 }}>
        {rows.map((r) => (
          <div key={r.title} style={{ background: t.surfaceAlt, border: `1px solid ${t.border}`, borderRadius: 14, padding: "12px 14px" }}>
            <div style={{ fontSize: 11, fontWeight: 800, letterSpacing: 0.5, textTransform: "uppercase", color: t.textMuted, marginBottom: 8 }}>{r.title}</div>
            <div style={{ display: "flex", gap: 8, fontSize: 13, lineHeight: 1.5, color: t.textMuted }}>
              <b style={{ flexShrink: 0, width: 76, color: t.textMuted }}>Gratuito</b>
              <span>{r.free}</span>
            </div>
            <div style={{ display: "flex", gap: 8, fontSize: 13, lineHeight: 1.5, color: t.text, marginTop: 8 }}>
              <b style={{ flexShrink: 0, width: 76, color: t.primary }}>Assinante</b>
              <span>{r.paid}</span>
            </div>
          </div>
        ))}
      </div>
      <div style={{ marginTop: 18 }}>
        <PrimaryButton full onClick={onSubscribe}>
          Assinar agora
        </PrimaryButton>
      </div>
    </div>
  );
}

export function DailyDoneScreen({ supabase, userId, streak, friends, onNavigate, canChooseFormat = true, reward = null }) {
  const t = useT();
  // Sem assinatura (não há formato para escolher): a sequência não conta dias e mostramos a comparação com o plano pago.
  const isFree = !canChooseFormat;
  const [friendsStatus, setFriendsStatus] = useState(null);

  useEffect(() => {
    if (!friends || !friends.length) {
      setFriendsStatus([]);
      return;
    }
    const ids = friends.map((f) => f.id);
    // get_friends_streaks já devolve a sequência vigente; se o SQL ainda não foi rodado, cai no RPC antigo.
    fetchFriendsStreaks(supabase, ids)
      .then((list) => list ?? fetchFriendsMissionStatus(supabase, ids).then((old) => old.map((f) => ({ ...f, streak: f.done_today ? f.streak : 0 }))))
      .then(setFriendsStatus)
      .catch(() => setFriendsStatus([]));
  }, [supabase, friends]);

  return (
    <div style={{ maxWidth: 480, margin: "0 auto 70px", textAlign: "center", padding: "6px 20px 22px" }}>
      <Flame_ done size={40} />
      <h2 style={{ fontSize: 22, color: t.text, marginTop: 8 }}>Revisão concluída!</h2>
      {isFree ? (
        <p style={{ color: t.textMuted, fontSize: 13.5, marginTop: 8, lineHeight: 1.5 }}>Volte amanhã para uma nova revisão.</p>
      ) : (
        <p style={{ color: t.textMuted, fontSize: 13.5, marginTop: 8, lineHeight: 1.5 }}>
          Você está numa sequência de <b style={{ color: t.green }}>{streak} {streak === 1 ? "dia" : "dias"}</b>.
          <br />
          Volte amanhã para manter a chama acesa.
        </p>
      )}
      {/* Bandagem da sequência: ganhou uma agora, ou uma bandagem cobriu o dia que a pessoa tinha perdido. */}
      {!isFree && reward?.used && (
        <p role="status" style={{ margin: "16px 0 0", padding: "10px 14px", borderRadius: 12, background: t.surface, border: `1px solid ${t.border}`, fontSize: 13.5, lineHeight: 1.5, color: t.text }}>
          <Bandage size={15} color={t.green} style={{ marginRight: 8, verticalAlign: -2 }} />
          Sua <b>bandagem</b> cobriu o dia que você perdeu: a sequência continuou.
        </p>
      )}
      {!isFree && reward?.earned && (
        <p role="status" style={{ margin: "12px 0 0", padding: "10px 14px", borderRadius: 12, background: t.primarySoft, border: `1px solid ${t.primary}`, fontSize: 13.5, lineHeight: 1.5, color: t.text }}>
          <Bandage size={15} color={t.primary} style={{ marginRight: 8, verticalAlign: -2 }} />
          Você acertou tudo e ganhou uma <b>bandagem</b>! Ela salva sua sequência se você ficar um dia sem fazer a revisão.
        </p>
      )}
      {/* Sem assinatura a revisão é sempre de 3 questões: não há formato para escolher. */}
      {canChooseFormat && <MissionFormat supabase={supabase} userId={userId} />}
      {isFree && <PlanComparison t={t} onSubscribe={() => onNavigate("plans")} />}
      <div style={{ marginTop: 16 }}>
        <PrimaryButton variant={isFree ? "ghost" : "primary"} onClick={() => onNavigate("home")}>Voltar ao início</PrimaryButton>
      </div>

      {friendsStatus && friendsStatus.length > 0 && (
        <div style={{ marginTop: 24, textAlign: "left" }}>
          <div style={{ fontSize: 12.5, fontWeight: 700, color: t.textMuted, marginBottom: 10, textAlign: "center" }}>
            SEUS AMIGOS
          </div>
          <div style={{ display: "flex", flexDirection: "column", gap: 8 }}>
            {friendsStatus.map((f) => {
              const shownStreak = f.streak ?? 0;
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
