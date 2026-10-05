"use client";

import { useState } from "react";
import { ChevronDown, ChevronUp } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { Tag, PrimaryButton } from "@/components/ui/Primitives";

export function QuestionsResultsScreen({ session, questionsById, optionsByQuestion, filters, onNavigate }) {
  const t = useT();
  const [expanded, setExpanded] = useState({});
  const total = session.ids.length;
  const answeredCount = Object.keys(session.answers).length;
  const correctCount = Object.values(session.answers).filter((a) => a.correct).length;
  const pctCompleted = Math.round((answeredCount / total) * 100);
  const pctCorrect = answeredCount ? Math.round((correctCount / answeredCount) * 100) : 0;

  return (
    <div style={{ maxWidth: 640, margin: "0 auto", paddingBottom: 60 }}>
      <div style={{ padding: "30px 22px" }}>
        <div style={{ textAlign: "center", marginBottom: 28 }}>
          <h2 style={{ fontSize: 24, color: t.text, margin: 0 }}>Sessão concluída!</h2>
        </div>

        <div style={{ display: "grid", gridTemplateColumns: "1fr 1fr", gap: 12, marginBottom: 30 }}>
          <div style={{ background: t.surface, border: `1px solid ${t.border}`, borderRadius: 16, padding: 18, textAlign: "center" }}>
            <div style={{ fontSize: 30, fontWeight: 700, color: t.primary }}>{pctCompleted}%</div>
            <div style={{ fontSize: 12.5, color: t.textMuted, marginTop: 4 }}>
              concluído ({answeredCount}/{total})
            </div>
          </div>
          <div style={{ background: t.surface, border: `1px solid ${t.border}`, borderRadius: 16, padding: 18, textAlign: "center" }}>
            <div style={{ fontSize: 30, fontWeight: 700, color: t.green }}>{pctCorrect}%</div>
            <div style={{ fontSize: 12.5, color: t.textMuted, marginTop: 4 }}>
              de acerto ({correctCount}/{answeredCount})
            </div>
          </div>
        </div>

        {filters.modoProva && (
          <div>
            <h3 style={{ fontSize: 16, color: t.text, marginBottom: 14 }}>Revisão completa</h3>
            <div style={{ display: "flex", flexDirection: "column", gap: 16 }}>
              {session.ids.map((qid) => {
                const q = questionsById[qid];
                const options = optionsByQuestion[qid] || [];
                const a = session.answers[qid];
                return (
                  <div key={qid} style={{ background: t.surface, border: `1px solid ${t.border}`, borderRadius: 14, padding: 16 }}>
                    <div style={{ display: "flex", gap: 6, marginBottom: 10 }}>
                      <Tag>{q.ano}</Tag>
                      <Tag>{q.instituicao}</Tag>
                      <Tag>{q.tema}</Tag>
                    </div>
                    <div style={{ fontWeight: 600, fontSize: 14.5, color: t.text, whiteSpace: "pre-line", marginBottom: q.imagem_url ? 8 : 10 }}>{q.enunciado}</div>
                    {q.imagem_url && (
                      <img
                        src={q.imagem_url}
                        alt="Imagem da questão"
                        style={{ display: "block", maxWidth: "100%", borderRadius: 10, marginBottom: 10, border: `1px solid ${t.border}` }}
                      />
                    )}
                    {options.map((op) => {
                      const isSel = a?.selected === op.letra;
                      const isCorrect = op.correta === true || (a && op.letra === a.correct_option);
                      let color = t.textMuted;
                      if (isCorrect) color = t.green;
                      else if (isSel) color = t.red;
                      const pct = a?.optionStats?.[op.letra]?.pct;
                      return (
                        <div
                          key={op.id}
                          style={{ fontSize: 13, color, padding: "4px 0", fontWeight: isCorrect || isSel ? 700 : 400, display: "flex", gap: 6 }}
                        >
                          <span>
                            {op.letra.toUpperCase()}) {op.texto} {isCorrect ? "✓" : isSel ? "✗" : ""}
                          </span>
                          {pct != null && <span style={{ marginLeft: "auto", color: t.textMuted, fontWeight: 700 }}>{pct}%</span>}
                        </div>
                      );
                    })}
                    <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginTop: 8, gap: 8 }}>
                      <div style={{ fontSize: 12.5, color: t.textMuted, fontStyle: "italic", whiteSpace: "pre-line" }}>
                        {expanded[qid] && q.comentario_completo ? q.comentario_completo : a?.comentario || q.comentario}
                      </div>
                      {q.comentario_completo && (
                        <button
                          onClick={() => setExpanded((e) => ({ ...e, [qid]: !e[qid] }))}
                          style={{
                            display: "flex",
                            alignItems: "center",
                            gap: 4,
                            background: t.surfaceAlt,
                            border: `1px solid ${t.border}`,
                            borderRadius: 8,
                            padding: "5px 10px",
                            fontSize: 11,
                            fontWeight: 700,
                            color: t.textMuted,
                            cursor: "pointer",
                            flexShrink: 0,
                            whiteSpace: "nowrap",
                            transition: "transform .1s, filter .15s",
                          }}
                          onMouseDown={(e) => (e.currentTarget.style.transform = "scale(0.95)")}
                          onMouseUp={(e) => (e.currentTarget.style.transform = "scale(1)")}
                          onMouseLeave={(e) => (e.currentTarget.style.transform = "scale(1)")}
                        >
                          {expanded[qid] ? <ChevronUp size={12} /> : <ChevronDown size={12} />}
                          {expanded[qid] ? "Resumida" : "Completa"}
                        </button>
                      )}
                    </div>
                  </div>
                );
              })}
            </div>
          </div>
        )}

        <div style={{ marginTop: 26 }}>
          <PrimaryButton full onClick={() => onNavigate("home")}>Voltar ao início</PrimaryButton>
        </div>
      </div>
    </div>
  );
}
