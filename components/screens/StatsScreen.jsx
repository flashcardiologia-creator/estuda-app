"use client";

import { useEffect, useMemo, useState } from "react";
import { useT } from "@/components/theme/ThemeProvider";
import { ScreenHeader, Chip, EmptyState } from "@/components/ui/Primitives";
import { fetchFlashcardMeta } from "@/lib/data/flashcards";
import { fetchFullStats } from "@/lib/data/stats";
import { ExamStats } from "@/components/screens/ExamStats";

const STATS_TABS = [
  { id: "sua", label: "Sua Estatística" },
  { id: "provas", label: "Provas" },
];

function StatBar({ label, sublabel, pct, color, barBg }) {
  const t = useT();
  return (
    <div style={{ marginBottom: 12 }}>
      <div style={{ display: "flex", justifyContent: "space-between", alignItems: "baseline", marginBottom: 4 }}>
        <span style={{ fontSize: 12.5, color: t.text, fontWeight: 600 }}>{label}</span>
        <span style={{ fontSize: 11.5, color: t.textMuted }}>{sublabel}</span>
      </div>
      <div style={{ height: 8, background: barBg || t.border, borderRadius: 999, overflow: "hidden" }}>
        <div style={{ height: "100%", width: `${Math.max(0, Math.min(100, pct))}%`, background: color, borderRadius: 999 }} />
      </div>
    </div>
  );
}

function pctColor(pct, t) {
  if (pct < 30) return t.red;
  if (pct <= 70) return t.amber;
  return t.green;
}

export function StatsScreen({ supabase, userId, allQuestions, challenges, onNavigate }) {
  const t = useT();
  const [fullStats, setFullStats] = useState(null);
  const [loadError, setLoadError] = useState("");
  const [temaTab, setTemaTab] = useState("questoes");
  const [tab, setTab] = useState("sua");

  const questionsById = useMemo(() => Object.fromEntries(allQuestions.map((q) => [q.id, q])), [allQuestions]);

  const { desafiosGanhos, desafiosPct } = useMemo(() => {
    const concluidos = (challenges || []).filter((c) => c.status === "completed");
    const ganhos = concluidos.filter((c) => c.myCorrect > c.theirCorrect).length;
    const pct = concluidos.length ? Math.round((ganhos / concluidos.length) * 100) : 0;
    return { desafiosGanhos: ganhos, desafiosPct: pct };
  }, [challenges]);

  useEffect(() => {
    let cancelled = false;
    (async () => {
      try {
        // Uma busca só, leve (id e tema dos flashcards), em paralelo com as respostas e visualizações da pessoa.
        const data = await fetchFullStats(supabase, userId, questionsById, () => fetchFlashcardMeta(supabase));
        if (!cancelled) setFullStats(data);
      } catch (err) {
        if (!cancelled) setLoadError(err.message || "Não foi possível carregar as estatísticas.");
      }
    })();
    return () => {
      cancelled = true;
    };
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [supabase, userId]);

  return (
    <div style={{ maxWidth: 640, margin: "0 auto", paddingBottom: 90 }}>
      <ScreenHeader title="Estatísticas" onBack={() => onNavigate("account")} />
      <div style={{ padding: "18px 22px" }}>
        <div role="tablist" aria-label="Seções das estatísticas" style={{ display: "flex", borderBottom: `1px solid ${t.border}`, marginBottom: 18 }}>
          {STATS_TABS.map(({ id, label }) => {
            const on = tab === id;
            return (
              <button
                key={id}
                type="button"
                role="tab"
                aria-selected={on}
                onClick={() => setTab(id)}
                style={{ flex: 1, minHeight: 44, padding: "0 8px", background: "transparent", border: "none", borderBottom: `2px solid ${on ? t.primary : "transparent"}`, marginBottom: -1, cursor: "pointer", fontFamily: "inherit", fontSize: 14, fontWeight: 700, color: on ? t.primary : t.textMuted }}
              >
                {label}
              </button>
            );
          })}
        </div>

        {/* A aba Provas só usa as questões do banco (já carregadas), então não espera as estatísticas pessoais. */}
        {tab === "provas" && <ExamStats allQuestions={allQuestions} />}

        {tab === "sua" && loadError && <EmptyState text={loadError} />}
        {tab === "sua" && !loadError && !fullStats && <EmptyState text="Carregando…" />}

        {tab === "sua" && fullStats && (
          <>
            <div style={{ display: "grid", gridTemplateColumns: "repeat(2, 1fr)", gap: 10, marginBottom: 22 }}>
              {[
                { label: "Dias ativos", value: fullStats.activeDays, pct: fullStats.activeDaysPct },
                { label: "Desafios Ganhos", value: desafiosGanhos, pct: desafiosPct },
                { label: "Questões respondidas", value: fullStats.totalQuestions },
                { label: "Média de questões/dia", value: fullStats.avgQuestionsPerDay },
                { label: "Flashcards vistos", value: fullStats.totalFlashcards },
                { label: "Média de flashcards/dia", value: fullStats.avgFlashcardsPerDay },
              ].map((s) => (
                <div
                  key={s.label}
                  style={{
                    background: t.name === "light" ? t.surface : t.surfaceAlt,
                    border: `1px solid ${t.border}`,
                    borderRadius: 12,
                    padding: 12,
                  }}
                >
                  <div style={{ fontSize: 10.5, color: t.textMuted, fontWeight: 600, marginBottom: 4 }}>{s.label}</div>
                  <div style={{ fontSize: 18, fontWeight: 700, color: t.text }}>
                    {s.value}
                    {s.pct != null && (
                      <span style={{ color: t.text, fontSize: "0.75em", marginLeft: 10 }}>({s.pct}%)</span>
                    )}
                  </div>
                </div>
              ))}
            </div>

            <div style={{ display: "flex", gap: 8, marginBottom: 16 }}>
              <Chip
                active={temaTab === "questoes"}
                onClick={() => setTemaTab("questoes")}
                style={{ flex: 1, textAlign: "center", ...(temaTab !== "questoes" && t.name === "light" ? { background: t.surface } : {}) }}
              >
                Questões
              </Chip>
              <Chip
                active={temaTab === "acertos"}
                onClick={() => setTemaTab("acertos")}
                style={{ flex: 1, textAlign: "center", ...(temaTab !== "acertos" && t.name === "light" ? { background: t.surface } : {}) }}
              >
                Acertos
              </Chip>
              <Chip
                active={temaTab === "flashcards"}
                onClick={() => setTemaTab("flashcards")}
                style={{ flex: 1, textAlign: "center", ...(temaTab !== "flashcards" && t.name === "light" ? { background: t.surface } : {}) }}
              >
                Flashcards
              </Chip>
            </div>

            {temaTab === "questoes" && (
              <div>
                {fullStats.temaQuestionStats.length === 0 && (
                  <div style={{ fontSize: 12.5, color: t.textMuted }}>Nenhuma questão respondida ainda.</div>
                )}
                {[...fullStats.temaQuestionStats]
                  .sort((a, b) => b.pctAnswered - a.pctAnswered)
                  .map((s) => (
                    <StatBar
                      key={s.tema}
                      label={s.tema}
                      sublabel={`${s.distinctAnswered}/${s.available}`}
                      pct={s.pctAnswered}
                      color={t.primary}
                    />
                  ))}
              </div>
            )}

            {temaTab === "acertos" && (
              <div>
                {fullStats.temaQuestionStats.length === 0 && (
                  <div style={{ fontSize: 12.5, color: t.textMuted }}>Nenhuma questão respondida ainda.</div>
                )}
                {[...fullStats.temaQuestionStats]
                  .sort((a, b) => b.accuracy - a.accuracy)
                  .map((s) => (
                    <StatBar
                      key={s.tema}
                      label={s.tema}
                      sublabel={`${s.accuracy}% (${s.correct}/${s.total})`}
                      pct={s.accuracy}
                      color={s.accuracy >= 70 ? t.green : s.accuracy >= 40 ? t.amber : t.red}
                    />
                  ))}
              </div>
            )}

            {temaTab === "flashcards" && (
              <div>
                {fullStats.temaFlashcardStats.length === 0 && (
                  <div style={{ fontSize: 12.5, color: t.textMuted }}>Nenhum flashcard disponível ainda.</div>
                )}
                {fullStats.temaFlashcardStats.map((s) => (
                  <StatBar key={s.tema} label={s.tema} sublabel={`${s.viewed}/${s.total}`} pct={s.pct} color={t.primary} />
                ))}
              </div>
            )}
          </>
        )}
      </div>
    </div>
  );
}
