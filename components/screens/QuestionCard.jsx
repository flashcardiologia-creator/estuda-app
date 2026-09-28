"use client";

import { useEffect, useState } from "react";
import { Star, Check, X, ChevronDown, ChevronUp } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { Tag, PrimaryButton } from "@/components/ui/Primitives";

const FONT_SIZES = { sm: 14, md: 16.5, lg: 19 };

export function QuestionCard({
  q,
  options,
  filters,
  selected,
  onSelect,
  answered,
  answerResult,
  onResponder,
  responding,
  prefilled,
  onRetry,
  isFav,
  onToggleFav,
}) {
  const t = useT();
  const fontSize = FONT_SIZES[filters.fontSize] || FONT_SIZES.md;
  const [showFull, setShowFull] = useState(false);
  // Não reseta por questão de propósito: se a pessoa minimizar o comentário,
  // essa preferência continua valendo ao responder as próximas questões.
  const [commentOpen, setCommentOpen] = useState(true);

  useEffect(() => {
    setShowFull(false);
  }, [q.id]);

  return (
    <div>
      <div style={{ display: "flex", gap: 8, marginBottom: 14, flexWrap: "wrap", alignItems: "center" }}>
        <Tag>{q.ano}</Tag>
        <Tag>{q.instituicao}</Tag>
        <Tag>{q.tema}</Tag>
        {onToggleFav && (
          <button
            onClick={() => onToggleFav(q.id)}
            style={{ marginLeft: "auto", background: "transparent", border: "none", cursor: "pointer" }}
            title="Favoritar"
          >
            <Star size={19} color={isFav ? t.amber : t.textMuted} fill={isFav ? t.amber : "none"} />
          </button>
        )}
      </div>

      <div style={{ fontSize, fontWeight: 600, color: t.text, lineHeight: 1.5, marginBottom: q.imagem_url ? 14 : 20 }}>{q.enunciado}</div>

      {q.imagem_url && (
        <img
          src={q.imagem_url}
          alt="Imagem da questão"
          style={{ display: "block", maxWidth: "100%", borderRadius: 12, marginBottom: 20, border: `1px solid ${t.border}` }}
        />
      )}

      <div style={{ display: "flex", flexDirection: "column", gap: 10 }}>
        {options.map((op) => {
          const isSelected = selected === op.letra;
          let bg = t.surfaceAlt,
            border = t.border,
            color = t.text;
          if (answered && !filters.modoProva && answerResult) {
            if (op.letra === answerResult.correct_option) {
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
              disabled={answered}
              onClick={() => onSelect(op.letra)}
              style={{
                textAlign: "left",
                padding: "13px 16px",
                borderRadius: 12,
                border: `1.5px solid ${border}`,
                background: bg,
                color,
                cursor: answered ? "default" : "pointer",
                fontSize: fontSize - 2.5,
                fontWeight: 500,
                display: "flex",
                alignItems: "center",
                gap: 10,
                transition: "all .12s",
              }}
            >
              <span
                style={{
                  width: 22,
                  height: 22,
                  borderRadius: "50%",
                  border: `1.5px solid ${border}`,
                  flexShrink: 0,
                  display: "flex",
                  alignItems: "center",
                  justifyContent: "center",
                  fontSize: 11,
                  fontWeight: 700,
                }}
              >
                {op.letra.toUpperCase()}
              </span>
              {op.texto}
              {answered && !filters.modoProva && answerResult && (
                <span style={{ marginLeft: "auto", display: "flex", alignItems: "center", gap: 6, flexShrink: 0 }}>
                  {answerResult.optionStats?.[op.letra] && (
                    <span style={{ fontSize: 11, fontWeight: 700, color: t.textMuted }}>
                      {answerResult.optionStats[op.letra].pct}%
                    </span>
                  )}
                  {op.letra === answerResult.correct_option && <Check size={16} />}
                  {isSelected && op.letra !== answerResult.correct_option && <X size={16} />}
                </span>
              )}
            </button>
          );
        })}
      </div>

      {answered && !filters.modoProva && answerResult && (
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
            <div style={{ fontSize, color: t.textMuted, lineHeight: 1.5, whiteSpace: "pre-line" }}>
              {showFull && q.comentario_completo ? q.comentario_completo : answerResult.comentario || q.comentario}
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

      {answered && prefilled && onRetry && (
        <div style={{ marginTop: 14 }}>
          <PrimaryButton full variant="ghost" onClick={onRetry}>
            Responder novamente
          </PrimaryButton>
        </div>
      )}

      {!answered && selected && (
        <div style={{ marginTop: 18 }}>
          <PrimaryButton full onClick={onResponder} disabled={responding}>
            Responder
          </PrimaryButton>
        </div>
      )}
    </div>
  );
}
