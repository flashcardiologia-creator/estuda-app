"use client";

import { useEffect, useMemo, useState } from "react";
import { Plus, Trophy } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { ScreenHeader, Chip, PrimaryButton, Tag, EmptyState } from "@/components/ui/Primitives";
import { NewChallengeModal } from "@/components/screens/NewChallengeModal";
import { ChallengeAnswerFlow } from "@/components/screens/ChallengeAnswerFlow";
import { createChallenge } from "@/lib/data/challenges";
import { todayStr } from "@/lib/util";

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
  const [respondingId, setRespondingId] = useState(null);

  const pendentes = challenges.filter((c) => c.status === "pending");
  const concluidos = challenges.filter((c) => c.status === "completed");
  const dailyCount = useMemo(
    () => challenges.filter((c) => c.isMine && c.created_at.slice(0, 10) === todayStr()).length,
    [challenges]
  );
  const responding = challenges.find((c) => c.id === respondingId) || null;

  useEffect(() => {
    if (onAnsweringChange) onAnsweringChange(!!responding);
    return () => {
      if (onAnsweringChange) onAnsweringChange(false);
    };
  }, [responding, onAnsweringChange]);

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
          <PrimaryButton small disabled={dailyCount >= 5 || friends.length === 0} onClick={() => setShowNew(true)}>
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
                <div style={{ marginTop: 12, display: "flex", gap: 8, fontSize: 12 }}>
                  <span style={{ color: myDone ? t.green : t.textMuted }}>
                    Você: {myDone ? "respondido" : c.myAnswered > 0 ? `${c.myAnswered}/${c.qtd}` : "aguardando"}
                  </span>
                  <span style={{ color: theirDone ? t.green : t.textMuted }}>
                    {c.isMine ? c.toName : c.fromName}: {theirDone ? "respondido" : "aguardando"}
                  </span>
                </div>
                {!myDone && (
                  <div style={{ marginTop: 12 }}>
                    <PrimaryButton small onClick={() => setRespondingId(c.id)}>
                      {c.myAnswered > 0 ? "Continuar desafio" : "Responder desafio"}
                    </PrimaryButton>
                  </div>
                )}
                {myDone && !theirDone && (
                  <div style={{ marginTop: 12 }}>
                    <span style={{ fontSize: 12, color: t.textMuted, fontStyle: "italic" }}>
                      Aguardando {c.isMine ? c.toName : c.fromName} responder…
                    </span>
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
            const vencedor = sMine === sTheirs ? "Empate" : sMine > sTheirs ? "Você" : c.isMine ? c.toName : c.fromName;
            return (
              <div key={c.id} style={{ background: t.surface, border: `1px solid ${t.border}`, borderRadius: 14, padding: 16, marginBottom: 10 }}>
                <div style={{ fontWeight: 700, fontSize: 14.5, color: t.text }}>
                  {c.fromName} vs {c.toName}
                </div>
                <div style={{ fontSize: 12, color: t.textMuted, marginTop: 3 }}>
                  {c.tema} · {c.qtd} questões
                </div>
                <div style={{ display: "flex", gap: 16, marginTop: 10, fontSize: 13 }}>
                  <span style={{ color: t.text }}>
                    Você: {sMine}/{c.qtd}
                  </span>
                  <span style={{ color: t.text }}>
                    {c.isMine ? c.toName : c.fromName}: {sTheirs}/{c.qtd}
                  </span>
                </div>
                <div style={{ marginTop: 8, display: "flex", alignItems: "center", gap: 6 }}>
                  <Trophy size={14} color={t.amber} />
                  <span style={{ fontWeight: 700, fontSize: 13, color: t.amber }}>
                    {vencedor === "Empate" ? "Empate" : `${vencedor} venceu`}
                  </span>
                </div>
              </div>
            );
          })}
      </div>

      {showNew && <NewChallengeModal friends={friends} temas={temas} onCreate={criarDesafio} onClose={() => setShowNew(false)} />}
    </div>
  );
}
