"use client";

import { useEffect, useState } from "react";
import { ChevronLeft, ChevronRight, Check, X, ChevronDown, ChevronUp } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { PrimaryButton, Tag } from "@/components/ui/Primitives";
import { fetchChallengeQuestions, fetchMyChallengeAnswers, recordChallengeAnswer } from "@/lib/data/challenges";
import { fetchOptionsForQuestions } from "@/lib/data/questions";

export function ChallengeAnswerFlow({ supabase, userId, challenge, onFinish, onCancel }) {
  const t = useT();
  const [loading, setLoading] = useState(true);
  const [questions, setQuestions] = useState([]);
  const [optionsByQuestion, setOptionsByQuestion] = useState({});
  const [answeredMap, setAnsweredMap] = useState({});
  const [idx, setIdx] = useState(0);
  const [selected, setSelected] = useState(null);
  const [revealed, setRevealed] = useState(null);
  const [responding, setResponding] = useState(false);
  const [showFull, setShowFull] = useState(false);
  // Não reseta ao avançar de propósito: se a pessoa minimizar o comentário,
  // essa preferência continua valendo ao responder as próximas questões.
  const [commentOpen, setCommentOpen] = useState(true);

  useEffect(() => {
    let cancelled = false;
    (async () => {
      const [qs, myAnswers] = await Promise.all([
        fetchChallengeQuestions(supabase, challenge.id),
        fetchMyChallengeAnswers(supabase, challenge.id, userId),
      ]);
      const options = await fetchOptionsForQuestions(supabase, qs.map((q) => q.id));
      if (cancelled) return;
      const answered = Object.fromEntries(myAnswers.map((a) => [a.question_id, a]));
      setQuestions(qs);
      setOptionsByQuestion(options);
      setAnsweredMap(answered);
      setIdx(Math.min(myAnswers.length, qs.length - 1));
      setLoading(false);
    })();
    return () => {
      cancelled = true;
    };
  }, [supabase, challenge.id, userId]);

  if (loading) return null;

  const total = questions.length;
  const q = questions[idx];
  const options = optionsByQuestion[q.id] || [];
  const isLast = idx === total - 1;
  const already = answeredMap[q.id];

  const responder = async () => {
    setResponding(true);
    try {
      const result = await recordChallengeAnswer(supabase, challenge.id, q.id, selected);
      setAnsweredMap((m) => ({ ...m, [q.id]: { question_id: q.id, selected_option: selected, correct: result.correct } }));
      setRevealed(result);
    } finally {
      setResponding(false);
    }
  };

  const avancar = () => {
    if (isLast) {
      onFinish();
      return;
    }
    setIdx((i) => i + 1);
    setSelected(null);
    setRevealed(null);
    setShowFull(false);
  };

  const effectiveRevealed = revealed || (already ? { correct: already.correct, correct_option: null, comentario: q.comentario } : null);
  const effectiveSelected = selected || already?.selected_option || null;

  return (
    <div style={{ maxWidth: 620, margin: "0 auto", paddingBottom: 80 }}>
      <div style={{ display: "flex", alignItems: "center", justifyContent: "space-between", padding: "18px 22px 0" }}>
        <button
          onClick={onCancel}
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
          Desafio · {idx + 1} de {total}
        </span>
      </div>
      <div style={{ padding: 22 }}>
        <div style={{ display: "flex", gap: 8, marginBottom: 14 }}>
          <Tag>{q.ano}</Tag>
          <Tag>{q.instituicao}</Tag>
          <Tag>{q.tema}</Tag>
        </div>
        <div style={{ fontWeight: 600, fontSize: 16, color: t.text, marginBottom: q.imagem_url ? 14 : 20, lineHeight: 1.5 }}>{q.enunciado}</div>

        {q.imagem_url && (
          <img
            src={q.imagem_url}
            alt="Imagem da questão"
            style={{ display: "block", maxWidth: "100%", borderRadius: 12, marginBottom: 20, border: `1px solid ${t.border}` }}
          />
        )}
        <div style={{ display: "flex", flexDirection: "column", gap: 10 }}>
          {options.map((op) => {
            const isSelected = effectiveSelected === op.letra;
            let bg = t.surfaceAlt,
              border = t.border,
              color = t.text;
            if (effectiveRevealed) {
              if (effectiveRevealed.correct_option ? op.letra === effectiveRevealed.correct_option : isSelected && effectiveRevealed.correct) {
                bg = "rgba(47,179,128,0.14)";
                border = t.green;
                color = t.green;
              } else if (isSelected) {
                bg = "rgba(229,72,77,0.14)";
                border = t.red;
                color = t.red;
              }
            } else if (isSelected) {
              bg = t.primarySoft;
              border = t.primary;
              color = t.primary;
            }
            return (
              <button
                key={op.id}
                disabled={!!effectiveRevealed}
                onClick={() => setSelected(op.letra)}
                style={{
                  textAlign: "left",
                  padding: "13px 16px",
                  borderRadius: 12,
                  cursor: effectiveRevealed ? "default" : "pointer",
                  border: `1.5px solid ${border}`,
                  background: bg,
                  color,
                  fontSize: 14,
                  display: "flex",
                  alignItems: "center",
                  gap: 10,
                }}
              >
                {op.letra.toUpperCase()}) {op.texto}
                {effectiveRevealed && (
                  <span style={{ marginLeft: "auto", display: "flex", alignItems: "center", gap: 6, flexShrink: 0 }}>
                    {effectiveRevealed.optionStats?.[op.letra] && (
                      <span style={{ fontSize: 11, fontWeight: 700, color: t.textMuted }}>
                        {effectiveRevealed.optionStats[op.letra].pct}%
                      </span>
                    )}
                    {effectiveRevealed.correct_option === op.letra && <Check size={16} />}
                    {isSelected && effectiveRevealed.correct_option && effectiveRevealed.correct_option !== op.letra && <X size={16} />}
                  </span>
                )}
              </button>
            );
          })}
        </div>

        {effectiveRevealed && (
          <div
            onClick={() => setCommentOpen((o) => !o)}
            style={{
              marginTop: 16,
              padding: 14,
              borderRadius: 12,
              background: t.surfaceAlt,
              border: `1px solid ${t.border}`,
              cursor: "pointer",
            }}
          >
            <div
              style={{
                display: "flex",
                justifyContent: "space-between",
                alignItems: "center",
                marginBottom: commentOpen ? 4 : 0,
                gap: 8,
              }}
            >
              <div style={{ display: "flex", alignItems: "center", gap: 4, fontSize: 12.5, fontWeight: 700, color: t.primary }}>
                {commentOpen ? <ChevronUp size={14} /> : <ChevronDown size={14} />}
                Comentário
              </div>
            </div>
            {commentOpen && (
              <div style={{ fontSize: 16, color: t.textMuted, lineHeight: 1.5, whiteSpace: "pre-line" }}>
                {showFull && q.comentario_completo ? q.comentario_completo : effectiveRevealed.comentario || q.comentario}
              </div>
            )}
            {commentOpen && !showFull && q.comentario_completo && (
              <div style={{ display: "flex", justifyContent: "flex-end", marginTop: 8 }}>
                <button
                  onClick={(e) => {
                    e.stopPropagation();
                    setShowFull(true);
                  }}
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
                  <ChevronDown size={12} />
                  Resposta completa
                </button>
              </div>
            )}
          </div>
        )}

        <div style={{ marginTop: 22 }}>
          {!effectiveRevealed ? (
            <PrimaryButton full disabled={!selected || responding} onClick={responder}>
              Responder
            </PrimaryButton>
          ) : (
            <PrimaryButton full onClick={avancar}>
              {isLast ? (
                "Finalizar Desafio"
              ) : (
                <>
                  Próxima
                  <ChevronRight size={16} style={{ marginLeft: 4 }} />
                </>
              )}
            </PrimaryButton>
          )}
        </div>
      </div>
    </div>
  );
}
