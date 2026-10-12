"use client";

import { useEffect, useMemo, useState } from "react";
import { Check, Clock, Plus, Trophy } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { ScreenHeader, Chip, PrimaryButton, Tag, EmptyState } from "@/components/ui/Primitives";
import { NewChallengeModal } from "@/components/screens/NewChallengeModal";
import { ChallengeAnswerFlow } from "@/components/screens/ChallengeAnswerFlow";
import { createChallenge } from "@/lib/data/challenges";
import { todayStr, dateStrAt } from "@/lib/util";

function challengeDone(answered, qtd) {
  return answered >= qtd;
}

// Aba selecionada: contorno e texto roxos, em negrito, sem preenchimento.
function tabStyle(t, active) {
  const base = { flex: 1, textAlign: "center" };
  if (active) {
    return { ...base, border: `2px solid ${t.primary}`, background: "transparent", color: t.primary, fontWeight: 800 };
  }
  return t.name === "light" ? { ...base, background: t.surface } : base;
}

function temaLabel(tema) {
  return tema === "Todos" ? "Todos os temas" : tema;
}

// Data em que o desafio foi criado, ex.: "07/10/2026".
function formatChallengeDate(iso) {
  return new Date(iso).toLocaleDateString("pt-BR");
}

const nowMs = () => Date.now();

// Tempo que falta, ex.: "2h 40min", "9h", "35 min". Acima de 12h fica neutro; até 12h, âmbar.
const URGENT_MS = 12 * 60 * 60 * 1000;

function formatTimeLeft(ms) {
  const totalMin = Math.max(0, Math.ceil(ms / 60000));
  const h = Math.floor(totalMin / 60);
  const m = totalMin % 60;
  if (h === 0) return `${m} min`;
  if (h >= 10 || m === 0) return `${h}h`;
  return `${h}h ${String(m).padStart(2, "0")}min`;
}

// "hoje, 09:12", "ontem, 21:40" ou "05/10, 18:30".
function formatWhen(iso) {
  const d = new Date(iso);
  const time = d.toLocaleTimeString("pt-BR", { hour: "2-digit", minute: "2-digit" });
  const dayKey = (x) => dateStrAt(x);
  if (dayKey(d) === todayStr()) return `hoje, ${time}`;
  if (dayKey(d) === dateStrAt(new Date(Date.now() - 24 * 60 * 60 * 1000))) return `ontem, ${time}`;
  return `${d.toLocaleDateString("pt-BR", { day: "2-digit", month: "2-digit" })}, ${time}`;
}

function joinNames(names) {
  if (names.length <= 1) return names[0] || "";
  return `${names.slice(0, -1).join(", ")} e ${names[names.length - 1]}`;
}

function SectionLabel({ children }) {
  const t = useT();
  return (
    <div style={{ fontSize: 11, color: t.textMuted, fontWeight: 700, letterSpacing: 0.5, textTransform: "uppercase", margin: "6px 2px 8px" }}>
      {children}
    </div>
  );
}

// Etiqueta com o tempo que falta: âmbar quando faltam 12h ou menos, neutra quando falta mais.
function TimeLeftTag({ expiresAt, urgent }) {
  const t = useT();
  const [, forceTick] = useState(0);
  useEffect(() => {
    const interval = setInterval(() => forceTick((n) => n + 1), 30 * 1000);
    return () => clearInterval(interval);
  }, []);
  const ms = new Date(expiresAt).getTime() - nowMs();
  return (
    <span
      style={{
        display: "inline-flex",
        alignItems: "center",
        gap: 4,
        whiteSpace: "nowrap",
        fontSize: 12,
        fontWeight: 700,
        padding: "4px 9px",
        borderRadius: 999,
        color: urgent ? t.amber : t.textMuted,
        background: urgent ? `${t.amber}2B` : t.surfaceAlt,
        border: urgent ? "none" : `1px solid ${t.border}`,
      }}
    >
      <Clock size={13} />
      {formatTimeLeft(ms)}
    </span>
  );
}

function ProgressRow({ name, status, statusColor, pct, barColor, strong }) {
  const t = useT();
  return (
    <div>
      <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", gap: 8, marginBottom: 4 }}>
        <span style={{ fontSize: 12.5, color: t.text, fontWeight: strong ? 700 : 500 }}>{name}</span>
        <span style={{ fontSize: 11.5, fontWeight: 700, color: statusColor, display: "inline-flex", alignItems: "center", gap: 3 }}>{status}</span>
      </div>
      <div style={{ height: 6, borderRadius: 999, background: t.surfaceAlt, boxShadow: `inset 0 0 0 1px ${t.border}`, overflow: "hidden" }}>
        <div style={{ width: `${pct}%`, height: "100%", borderRadius: 999, background: barColor, transition: "width .25s" }} />
      </div>
    </div>
  );
}

function PendingCard({ c, onRespond }) {
  const t = useT();
  const myDone = challengeDone(c.myAnswered, c.qtd);
  const myPct = myDone ? Math.round((c.myCorrect / c.qtd) * 100) : null;
  const urgent = !myDone && new Date(c.expires_at).getTime() - nowMs() <= URGENT_MS;
  // Você primeiro, depois os outros na ordem em que já vinham.
  const ordered = [...c.participants].sort((a, b) => Number(b.isMe) - Number(a.isMe));
  const others = c.participants.filter((p) => !p.isMe).map((p) => p.name);
  const who = c.isMine ? `Você desafiou ${joinNames(others)}` : `${c.fromName} te desafiou`;

  return (
    <div style={{ position: "relative", overflow: "hidden", background: t.surface, border: `1px solid ${t.border}`, borderRadius: 14, padding: "16px 16px 16px 18px", marginBottom: 10 }}>
      {urgent && <div style={{ position: "absolute", left: 0, top: 0, bottom: 0, width: 4, background: t.amber }} />}
      <div style={{ display: "flex", justifyContent: "space-between", alignItems: "flex-start", gap: 10 }}>
        <div style={{ minWidth: 0 }}>
          <div style={{ fontWeight: 700, fontSize: 14.5, color: t.text }}>
            {temaLabel(c.tema)} · <span style={{ color: t.primary }}>{c.qtd} questões</span>
          </div>
          <div style={{ fontSize: 12, color: t.textMuted, marginTop: 3, lineHeight: 1.4 }}>
            {who} · {formatWhen(c.created_at)}
          </div>
        </div>
        {myDone ? (
          <div style={{ textAlign: "right", flexShrink: 0 }}>
            <div style={{ fontWeight: 700, fontSize: 24, color: t.primary, lineHeight: 1 }}>{myPct}%</div>
            <div style={{ fontSize: 11, color: t.textMuted, marginTop: 2 }}>
              {c.myCorrect} acerto{c.myCorrect === 1 ? "" : "s"}
            </div>
          </div>
        ) : (
          <TimeLeftTag expiresAt={c.expires_at} urgent={urgent} />
        )}
      </div>

      <div style={{ display: "flex", flexDirection: "column", gap: 9, marginTop: 14 }}>
        {ordered.map((p) => {
          const done = challengeDone(p.answered, c.qtd);
          const started = p.answered > 0;
          const status = done ? (
            <>
              <Check size={13} /> Respondido
            </>
          ) : started ? (
            `${p.answered}/${c.qtd}`
          ) : p.isMe ? (
            "Ainda não começou"
          ) : (
            "Aguardando"
          );
          return (
            <ProgressRow
              key={p.id}
              name={p.isMe ? "Você" : p.name}
              strong={p.isMe}
              status={status}
              statusColor={done ? t.green : t.textMuted}
              pct={Math.min(100, Math.round((p.answered / c.qtd) * 100))}
              barColor={done ? t.green : p.isMe ? t.primary : t.textMuted}
            />
          );
        })}
      </div>

      {myDone ? (
        <div style={{ display: "flex", justifyContent: "flex-end", alignItems: "center", gap: 5, marginTop: 12, fontSize: 12, color: t.textMuted }}>
          <Clock size={13} /> Expira em {formatTimeLeft(new Date(c.expires_at).getTime() - nowMs())}
        </div>
      ) : (
        <div style={{ marginTop: 14 }}>
          <PrimaryButton small full onClick={onRespond}>
            {c.myAnswered > 0 ? "Continuar desafio" : "Responder desafio"}
          </PrimaryButton>
        </div>
      )}
    </div>
  );
}

export function ChallengesScreen({
  supabase,
  userId,
  friends,
  challenges,
  temas,
  onRefreshChallenges,
  onNavigate,
  onGoToAccountFriends,
  onAnsweringChange,
  fontSize,
}) {
  const t = useT();
  const [tab, setTab] = useState("pendentes");
  const [showNew, setShowNew] = useState(false);
  const [showNoFriends, setShowNoFriends] = useState(false);
  const [respondingId, setRespondingId] = useState(null);

  const pendentes = challenges.filter((c) => c.status === "pending");
  const byExpiry = (x, y) => new Date(x.expires_at) - new Date(y.expires_at);
  const esperandoVoce = pendentes.filter((c) => !challengeDone(c.myAnswered, c.qtd)).sort(byExpiry);
  const aguardando = pendentes.filter((c) => challengeDone(c.myAnswered, c.qtd)).sort(byExpiry);
  const concluidos = challenges.filter((c) => c.status === "completed");
  const dailyCount = useMemo(
    () => challenges.filter((c) => c.isMine && dateStrAt(new Date(c.created_at)) === todayStr()).length,
    [challenges]
  );
  const responding = challenges.find((c) => c.id === respondingId) || null;

  useEffect(() => {
    if (onAnsweringChange) onAnsweringChange(!!responding);
    return () => {
      if (onAnsweringChange) onAnsweringChange(false);
    };
  }, [responding, onAnsweringChange]);

  // Escuta em tempo real quando o amigo responde uma questão do desafio (challenge_answers)
  // ou quando o desafio muda de status (challenges vira "completed") — assim a lista
  // migra de Pendentes pra Concluídos sozinha, sem precisar recarregar a página.
  useEffect(() => {
    const channel = supabase
      .channel(`challenges-updates-${userId}`)
      .on("postgres_changes", { event: "*", schema: "public", table: "challenges" }, () => {
        onRefreshChallenges();
      })
      .on("postgres_changes", { event: "*", schema: "public", table: "challenge_answers" }, () => {
        onRefreshChallenges();
      })
      .subscribe();

    return () => {
      supabase.removeChannel(channel);
    };
  }, [supabase, userId, onRefreshChallenges]);

  const criarDesafio = async (friendIds, tema, qtd) => {
    const id = await createChallenge(supabase, friendIds, tema, qtd);
    await onRefreshChallenges();
    setShowNew(false);
    setRespondingId(id);
  };

  const finishResponding = async () => {
    setRespondingId(null);
    await onRefreshChallenges();
  };

  if (responding) {
    return (
      <ChallengeAnswerFlow
        supabase={supabase}
        userId={userId}
        challenge={responding}
        onFinish={finishResponding}
        onCancel={finishResponding}
        fontSize={fontSize}
      />
    );
  }

  return (
    <div style={{ maxWidth: 640, margin: "0 auto", paddingBottom: 80 }}>
      <ScreenHeader title="Desafios" onBack={() => onNavigate("home")} />
      <div style={{ padding: "18px 22px" }}>
        <div
          style={{
            display: "flex",
            alignItems: "center",
            justifyContent: "space-between",
            gap: 14,
            background: t.surface,
            border: `1px solid ${t.border}`,
            borderRadius: 16,
            padding: "14px 16px",
            marginBottom: 18,
          }}
        >
          <div style={{ minWidth: 0 }}>
            <div style={{ display: "flex", alignItems: "baseline", gap: 6, marginBottom: 9 }}>
              <span
                style={{
                  fontSize: 10.5,
                  color: t.textMuted,
                  fontWeight: 700,
                  letterSpacing: 0.5,
                  textTransform: "uppercase",
                }}
              >
                Desafios criados hoje
              </span>
              <span style={{ fontSize: 11.5, color: t.primary, fontWeight: 800 }}>{dailyCount}/5</span>
            </div>
            <div style={{ display: "flex", gap: 5 }}>
              {Array.from({ length: 5 }).map((_, i) => (
                <div
                  key={i}
                  style={{
                    width: 24,
                    height: 9,
                    borderRadius: 999,
                    background: i < dailyCount ? t.primary : t.surfaceAlt,
                    border: `1px solid ${i < dailyCount ? t.primary : t.border}`,
                    boxShadow: i < dailyCount ? `0 0 8px ${t.primary}88` : "none",
                    transition: "background .15s, box-shadow .15s",
                  }}
                />
              ))}
            </div>
          </div>
          <PrimaryButton
            small
            disabled={dailyCount >= 5}
            onClick={() => (friends.length === 0 ? setShowNoFriends(true) : setShowNew(true))}
          >
            <Plus size={14} style={{ marginRight: 5, verticalAlign: -2 }} />
            Novo Desafio
          </PrimaryButton>
        </div>

        <div style={{ display: "flex", gap: 8, marginBottom: 18 }}>
          <Chip active={tab === "pendentes"} onClick={() => setTab("pendentes")} style={tabStyle(t, tab === "pendentes")}>
            Pendentes ({pendentes.length})
          </Chip>
          <Chip active={tab === "concluidos"} onClick={() => setTab("concluidos")} style={tabStyle(t, tab === "concluidos")}>
            Concluídos ({concluidos.length})
          </Chip>
        </div>

        {tab === "pendentes" && pendentes.length === 0 && <EmptyState text="Nenhum desafio pendente. Chame um amigo para jogar!" />}
        {tab === "pendentes" && esperandoVoce.length > 0 && <SectionLabel>Esperando você</SectionLabel>}
        {tab === "pendentes" &&
          esperandoVoce.map((c) => <PendingCard key={c.id} c={c} onRespond={() => setRespondingId(c.id)} />)}
        {tab === "pendentes" && aguardando.length > 0 && <SectionLabel>Aguardando amigos</SectionLabel>}
        {tab === "pendentes" && aguardando.map((c) => <PendingCard key={c.id} c={c} onRespond={() => setRespondingId(c.id)} />)}

        {tab === "concluidos" && concluidos.length === 0 && <EmptyState text="Ainda não há desafios concluídos." />}
        {tab === "concluidos" &&
          concluidos.map((c) => {
            // vence quem fez estritamente mais acertos que todos os outros; empate no topo = "Empate"
            const topScore = Math.max(...c.participants.map((p) => p.correct));
            const topCount = c.participants.filter((p) => p.correct === topScore).length;
            const winnerP = topCount === 1 ? c.participants.find((p) => p.correct === topScore) : null;
            const vencedor = winnerP ? (winnerP.isMe ? "Você" : winnerP.name) : "Empate";
            const participants = [...c.participants]
              .sort((a, b) => b.correct - a.correct)
              .map((p) => ({
                name: p.isMe ? "Você" : p.name,
                pct: Math.round((p.correct / c.qtd) * 100),
                correct: p.correct,
                winner: winnerP ? p.id === winnerP.id : false,
              }));
            return (
              <div key={c.id} style={{ background: t.surface, border: `1px solid ${t.border}`, borderRadius: 14, padding: 16, marginBottom: 10 }}>
                <div style={{ display: "flex", justifyContent: "space-between", alignItems: "flex-start" }}>
                  <div>
                    <div style={{ fontWeight: 700, fontSize: 14.5, color: t.text }}>
                      {temaLabel(c.tema)} · <span style={{ color: t.primary }}>{c.qtd} questões</span>
                    </div>
                    <div style={{ fontSize: 12, color: t.textMuted, marginTop: 3 }}>{formatChallengeDate(c.created_at)}</div>
                  </div>
                  <div style={{ display: "flex", alignItems: "center", gap: 6 }}>
                    <Trophy size={16} color={t.amber} />
                    <span style={{ fontWeight: 700, fontSize: 13, color: t.amber }}>
                      {vencedor === "Empate" ? "Empate" : vencedor}
                    </span>
                  </div>
                </div>

                <div style={{ display: "flex", flexDirection: "column", gap: 6, marginTop: 12 }}>
                  {participants.map((p, i) => (
                    <div
                      key={`${p.name}-${i}`}
                      style={{
                        display: "flex",
                        alignItems: "center",
                        gap: 8,
                        background: t.surfaceAlt,
                        border: `1px solid ${t.border}`,
                        borderRadius: 10,
                        padding: "6px 10px",
                      }}
                    >
                      <div
                        style={{
                          width: 20,
                          height: 20,
                          borderRadius: "50%",
                          background: p.winner ? "rgba(47,179,128,0.18)" : t.primarySoft,
                          display: "flex",
                          alignItems: "center",
                          justifyContent: "center",
                          fontSize: 9.5,
                          fontWeight: 700,
                          color: p.winner ? t.green : t.primary,
                          flexShrink: 0,
                        }}
                      >
                        {p.name[0]}
                      </div>
                      <span style={{ flex: 1, fontSize: 12.5, color: t.text, fontWeight: 600 }}>{p.name}</span>
                      <span style={{ fontSize: 11, fontWeight: 700, color: p.winner ? t.green : t.textMuted }}>
                        {p.pct}% ({p.correct}/{c.qtd})
                      </span>
                    </div>
                  ))}
                </div>
              </div>
            );
          })}
      </div>

      {showNew && <NewChallengeModal friends={friends} temas={temas} onCreate={criarDesafio} onClose={() => setShowNew(false)} />}
      {showNoFriends && <NoFriendsModal onClose={() => setShowNoFriends(false)} onGoToAccount={onGoToAccountFriends} />}
    </div>
  );
}

function NoFriendsModal({ onClose, onGoToAccount }) {
  const t = useT();
  return (
    <div style={{ position: "fixed", inset: 0, background: "rgba(0,0,0,0.5)", display: "flex", alignItems: "center", justifyContent: "center", zIndex: 50, padding: 20 }}>
      <div style={{ background: t.surface, border: `1px solid ${t.border}`, borderRadius: 18, padding: 22, maxWidth: 380, width: "100%" }}>
        <h3 style={{ fontSize: 17, color: t.text, margin: "0 0 12px" }}>Você ainda não tem amigos</h3>
        <p style={{ fontSize: 13.5, color: t.textMuted, lineHeight: 1.6, margin: 0 }}>
          <b style={{ color: t.text }}>Como resolver:</b> vai em Minha Conta → seção &quot;Amigos&quot; → digita o
          nome de exibição de outra conta já cadastrada e clica em &quot;+&quot;. Só funciona com o nome exato de
          exibição de outro usuário que já existe no app.
        </p>
        <div style={{ display: "flex", justifyContent: "center", gap: 10, marginTop: 20 }}>
          <PrimaryButton variant="ghost" onClick={onClose}>
            Fechar
          </PrimaryButton>
          <PrimaryButton onClick={onGoToAccount}>Ir para Minha Conta</PrimaryButton>
        </div>
      </div>
    </div>
  );
}
