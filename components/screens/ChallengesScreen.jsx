"use client";

import { useEffect, useMemo, useState } from "react";
import { Plus, Trophy } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { ScreenHeader, Chip, PrimaryButton, Tag, EmptyState } from "@/components/ui/Primitives";
import { NewChallengeModal } from "@/components/screens/NewChallengeModal";
import { ChallengeAnswerFlow } from "@/components/screens/ChallengeAnswerFlow";
import { createChallenge } from "@/lib/data/challenges";
import { todayStr, dateStrAt } from "@/lib/util";

function challengeDone(answered, qtd) {
  return answered >= qtd;
}

export function ChallengesScreen({
  supabase,
  userId,
  friends,
  challenges,
  temas,
  onRefreshChallenges,
  onNavigate,
  onAnsweringChange,
}) {
  const t = useT();
  const [tab, setTab] = useState("pendentes");
  const [showNew, setShowNew] = useState(false);
  const [showNoFriends, setShowNoFriends] = useState(false);
  const [respondingId, setRespondingId] = useState(null);

  const pendentes = challenges.filter((c) => c.status === "pending");
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

  const criarDesafio = async (friendId, tema, qtd) => {
    const id = await createChallenge(supabase, friendId, tema, qtd);
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
      />
    );
  }

  return (
    <div style={{ maxWidth: 640, margin: "0 auto", paddingBottom: 80 }}>
      <ScreenHeader title="Desafios" onBack={() => onNavigate("home")} />
      <div style={{ padding: "18px 22px" }}>
        <div style={{ fontSize: 11.5, color: t.textMuted, marginBottom: 16, textAlign: "center" }}>
          {dailyCount}/5 desafios criados hoje
        </div>

        <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", gap: 8, marginBottom: 18 }}>
          <div style={{ display: "flex", gap: 8, overflowX: "auto", minWidth: 0 }}>
            <Chip active={tab === "pendentes"} onClick={() => setTab("pendentes")}>
              Pendentes ({pendentes.length})
            </Chip>
            <Chip active={tab === "concluidos"} onClick={() => setTab("concluidos")}>
              Concluídos ({concluidos.length})
            </Chip>
          </div>
          <PrimaryButton
            small
            disabled={dailyCount >= 5}
            onClick={() => (friends.length === 0 ? setShowNoFriends(true) : setShowNew(true))}
          >
            <Plus size={14} style={{ marginRight: 4 }} />
            Novo
          </PrimaryButton>
        </div>

        {tab === "pendentes" && pendentes.length === 0 && <EmptyState text="Nenhum desafio pendente. Chame um amigo para jogar!" />}
        {tab === "pendentes" &&
          pendentes.map((c) => {
            const myDone = challengeDone(c.myAnswered, c.qtd);
            const theirDone = challengeDone(c.theirAnswered, c.qtd);
            const myPct = myDone ? Math.round((c.myCorrect / c.qtd) * 100) : null;
            const theirName = c.isMine ? c.toName : c.fromName;
            const participants = [
              { name: "Você", done: myDone, answered: c.myAnswered },
              { name: theirName, done: theirDone, answered: c.theirAnswered },
            ];
            return (
              <div key={c.id} style={{ background: t.surface, border: `1px solid ${t.border}`, borderRadius: 14, padding: 16, marginBottom: 10 }}>
                <div style={{ display: "flex", justifyContent: "space-between", alignItems: "flex-start" }}>
                  <div>
                    <div style={{ fontWeight: 700, fontSize: 14.5, color: t.text }}>
                      {c.fromName} vs {c.toName}
                    </div>
                    <div style={{ fontSize: 12, color: t.textMuted, marginTop: 3 }}>
                      {c.tema} · {c.qtd} questões
                    </div>
                  </div>
                  {myDone ? (
                    <div style={{ textAlign: "right" }}>
                      <div style={{ fontWeight: 700, fontSize: 24, color: t.primary, lineHeight: 1 }}>{myPct}%</div>
                      <div style={{ fontSize: 11, color: t.textMuted, marginTop: 2 }}>
                        {c.myCorrect} acerto{c.myCorrect === 1 ? "" : "s"}
                      </div>
                    </div>
                  ) : (
                    <Tag>expira 48h</Tag>
                  )}
                </div>

                <div style={{ display: "flex", flexDirection: "column", gap: 6, marginTop: 12 }}>
                  {participants.map((p) => (
                    <div
                      key={p.name}
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
                          background: p.done ? "rgba(47,179,128,0.18)" : t.primarySoft,
                          display: "flex",
                          alignItems: "center",
                          justifyContent: "center",
                          fontSize: 9.5,
                          fontWeight: 700,
                          color: p.done ? t.green : t.primary,
                          flexShrink: 0,
                        }}
                      >
                        {p.name[0]}
                      </div>
                      <span style={{ flex: 1, fontSize: 12.5, color: t.text, fontWeight: 600 }}>{p.name}</span>
                      <span style={{ fontSize: 11, fontWeight: 700, color: p.done ? t.green : t.textMuted }}>
                        {p.done ? "Respondido" : p.answered > 0 ? `${p.answered}/${c.qtd}` : "Aguardando"}
                      </span>
                    </div>
                  ))}
                </div>

                {!myDone && (
                  <div style={{ marginTop: 12 }}>
                    <PrimaryButton small full onClick={() => setRespondingId(c.id)}>
                      {c.myAnswered > 0 ? "Continuar desafio" : "Responder desafio"}
                    </PrimaryButton>
                  </div>
                )}
              </div>
            );
          })}

        {tab === "concluidos" && concluidos.length === 0 && <EmptyState text="Ainda não há desafios concluídos." />}
        {tab === "concluidos" &&
          concluidos.map((c) => {
            const sMine = c.myCorrect,
              sTheirs = c.theirCorrect;
            const theirName = c.isMine ? c.toName : c.fromName;
            const myPct = Math.round((sMine / c.qtd) * 100);
            const theirPct = Math.round((sTheirs / c.qtd) * 100);
            const vencedor = sMine === sTheirs ? "Empate" : sMine > sTheirs ? "Você" : theirName;
            const participants = [
              { name: "Você", pct: myPct, correct: sMine, winner: vencedor === "Você" },
              { name: theirName, pct: theirPct, correct: sTheirs, winner: vencedor === theirName },
            ];
            return (
              <div key={c.id} style={{ background: t.surface, border: `1px solid ${t.border}`, borderRadius: 14, padding: 16, marginBottom: 10 }}>
                <div style={{ display: "flex", justifyContent: "space-between", alignItems: "flex-start" }}>
                  <div>
                    <div style={{ fontWeight: 700, fontSize: 14.5, color: t.text }}>
                      {c.fromName} vs {c.toName}
                    </div>
                    <div style={{ fontSize: 12, color: t.textMuted, marginTop: 3 }}>
                      {c.tema} · {c.qtd} questões
                    </div>
                  </div>
                  <div style={{ display: "flex", alignItems: "center", gap: 6 }}>
                    <Trophy size={16} color={t.amber} />
                    <span style={{ fontWeight: 700, fontSize: 13, color: t.amber }}>
                      {vencedor === "Empate" ? "Empate" : vencedor}
                    </span>
                  </div>
                </div>

                <div style={{ display: "flex", flexDirection: "column", gap: 6, marginTop: 12 }}>
                  {participants.map((p) => (
                    <div
                      key={p.name}
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
      {showNoFriends && <NoFriendsModal onClose={() => setShowNoFriends(false)} onGoToAccount={() => onNavigate("account")} />}
    </div>
  );
}

function NoFriendsModal({ onClose, onGoToAccount }) {
  const t = useT();
  return (
    <div style={{ position: "fixed", inset: 0, background: "rgba(0,0,0,0.5)", display: "flex", alignItems: "center", justifyContent: "center", zIndex: 50, padding: 20 }}>
      <div style={{ background: t.surface, border: `1px solid ${t.border}`, borderRadius: 18, padding: 22, maxWidth: 380, width: "100%" }}>
        <h3 style={{ fontSize: 17, color: t.text, margin: "0 0 12px" }}>Você ainda não tem amigos</h3>
        <p style={{ fontSize: 13.5, color: t.textMuted, lineHeight: 1.6, margin: "0 0 10px" }}>
          Por design, só dá pra criar um desafio depois de ter pelo menos um amigo.
        </p>
        <p style={{ fontSize: 13.5, color: t.textMuted, lineHeight: 1.6, margin: 0 }}>
          <b style={{ color: t.text }}>Como resolver:</b> vai em Minha Conta → seção &quot;Amigos&quot; → digita o
          nome de exibição de outra conta já cadastrada e clica em &quot;+&quot;. Só funciona com o nome exato de
          exibição de outro usuário que já existe no app (não é e-mail).
        </p>
        <div style={{ display: "flex", gap: 10, marginTop: 20 }}>
          <PrimaryButton variant="ghost" onClick={onClose}>
            Fechar
          </PrimaryButton>
          <PrimaryButton onClick={onGoToAccount}>Ir para Minha Conta</PrimaryButton>
        </div>
      </div>
    </div>
  );
}
