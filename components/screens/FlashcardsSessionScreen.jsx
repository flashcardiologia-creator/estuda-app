"use client";

import { useState } from "react";
import { ChevronLeft, Star, Trash2 } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { PrimaryButton, Tag } from "@/components/ui/Primitives";
import { ReportButton, ReportIssueModal } from "@/components/ui/ReportIssue";
import { ZoomableImage } from "@/components/ui/ImageZoom";

const FLASHCARD_FONT_SIZES = { sm: 16, md: 20, lg: 24 };
const STAR_COLOR = "#F5B50A";
const INCIDENCE = {
  1: { label: "Cai pouco", color: "#3DA5D9" },
  2: { label: "Cai com frequência", color: "#F5A524" },
  3: { label: "Cai muito", color: "#E5484D" },
};

// Barra de 3 espaços: quanto mais o assunto do card aparece nas questões do tema e nas provas
// em geral, mais espaços se enchem (e mais quente fica a cor).
function IncidenceBar({ level }) {
  const t = useT();
  const info = INCIDENCE[level];
  if (!info) return null;
  return (
    <div
      title={`Incidência em prova: ${info.label}`}
      aria-label={`Incidência em prova: ${info.label}`}
      style={{ display: "flex", flexDirection: "column", alignItems: "flex-end", gap: 4, flexShrink: 0 }}
    >
      <div style={{ display: "flex", gap: 3 }}>
        {[1, 2, 3].map((slot) => (
          <span
            key={slot}
            style={{
              width: 20,
              height: 7,
              borderRadius: 4,
              background: slot <= level ? info.color : "transparent",
              border: `1px solid ${slot <= level ? info.color : t.border}`,
              boxSizing: "border-box",
            }}
          />
        ))}
      </div>
      <span style={{ fontSize: 10.5, fontWeight: 700, color: info.color, letterSpacing: 0.3 }}>{info.label}</span>
    </div>
  );
}

// Imagem ilustrativa do card. Fica no verso (resposta) por padrão; cards cujo
// pergunta depende da imagem (ex.: "qual o diagnóstico deste ECG?") mostram
// a imagem nos dois lados. Se a imagem não carregar, some sem quebrar o card.
function CardImage({ card, flipped }) {
  const [failed, setFailed] = useState(false);
  if (!card.imagem_url || failed) return null;
  if (!flipped && card.imagem_lado !== "pergunta") return null;
  return (
    <div style={{ marginTop: 18, width: "100%" }}>
      <ZoomableImage
        src={card.imagem_url}
        alt=""
        loading="lazy"
        referrerPolicy="no-referrer"
        onError={() => setFailed(true)}
        wrapStyle={{ margin: "0 auto" }}
        style={{ display: "block", maxWidth: "100%", maxHeight: 280, borderRadius: 10, background: "#fff" }}
      />
      {card.imagem_credito && (
        <div style={{ fontSize: 10.5, color: "#8a8f98", marginTop: 6, textAlign: "center" }}>{card.imagem_credito}</div>
      )}
    </div>
  );
}

export function FlashcardsSessionScreen({
  supabase,
  userId,
  session,
  setSession,
  onNavigate,
  onFinish,
  onView,
  onTrash,
  favorites,
  onToggleFavorite,
  fontSize,
}) {
  const t = useT();
  const [showReport, setShowReport] = useState(false);
  const [confirmTrash, setConfirmTrash] = useState(false);
  const [trashing, setTrashing] = useState(false);
  const [trashError, setTrashError] = useState("");
  const total = session.ids.length;
  const idx = session.index;
  const card = session.cardsById[session.ids[idx]];
  const flipped = session.flipped[card.id] || false;
  const viewed = !!(session.viewed && session.viewed[card.id]);
  const isFavorite = !!favorites?.has(card.id);
  const cardFontSize = FLASHCARD_FONT_SIZES[fontSize || session.fontSize] || FLASHCARD_FONT_SIZES.md;

  const flip = () => {
    const nextFlipped = !flipped;
    if (nextFlipped && !card.custom) onView?.(card.id);
    setSession((s) => ({
      ...s,
      flipped: { ...s.flipped, [card.id]: nextFlipped },
      viewed: nextFlipped ? { ...s.viewed, [card.id]: true } : s.viewed,
    }));
  };
  const go = (dir) =>
    setSession((s) => {
      const newIndex = Math.min(total - 1, Math.max(0, s.index + dir));
      const targetId = s.ids[newIndex];
      const flipped = dir < 0 ? { ...s.flipped, [targetId]: false } : s.flipped;
      return { ...s, index: newIndex, flipped };
    });

  // Manda o flashcard para a lixeira (só desta pessoa) depois da confirmação.
  const sendCardToTrash = async () => {
    setTrashing(true);
    setTrashError("");
    try {
      await onTrash(card);
      setConfirmTrash(false);
    } catch (err) {
      setTrashError(err.message || "Não foi possível mandar para a lixeira.");
    } finally {
      setTrashing(false);
    }
  };

  const answerBg = t.name === "light" ? "rgba(34,197,94,0.16)" : "rgba(19,46,36,0.5)";
  const answerBorder = t.name === "light" ? "#16A34A" : "#2FB380";

  return (
    <div style={{ maxWidth: 560, margin: "0 auto", paddingBottom: 90 }}>
      <div style={{ display: "flex", alignItems: "center", justifyContent: "space-between", padding: "18px 22px 0" }}>
        <button
          onClick={() => onNavigate("flashcards-select")}
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
            Flashcard {idx + 1} de {total}
          </span>
          {!card.custom && <ReportButton onClick={() => setShowReport(true)} />}
        </div>
      </div>

      <div style={{ padding: "26px 22px 0" }}>
        <div
          onClick={flip}
          style={{
            cursor: "pointer",
            borderRadius: 16,
            border: `1px solid ${t.border}`,
            background: t.surface,
            overflow: "hidden",
            transition: "border-color .2s",
          }}
        >
          <div
            style={{
              display: "flex",
              alignItems: "center",
              gap: 10,
              padding: "16px 18px",
              borderBottom: `1px solid ${t.border}`,
              background: flipped ? answerBg : "transparent",
              transition: "background .2s",
            }}
          >
            {flipped ? (
              <>
                <span style={{ fontWeight: 700, fontSize: 12.5, color: answerBorder, textTransform: "uppercase", letterSpacing: 0.5, flex: 1 }}>
                  Resposta
                </span>
                {onTrash && (
                  <button
                    onClick={(e) => {
                      e.stopPropagation();
                      setTrashError("");
                      setConfirmTrash(true);
                    }}
                    title="Mandar para a lixeira"
                    aria-label="Mandar para a lixeira"
                    style={{
                      display: "flex",
                      alignItems: "center",
                      justifyContent: "center",
                      width: 32,
                      height: 32,
                      borderRadius: 10,
                      border: `1px solid ${t.red}`,
                      background: "transparent",
                      color: t.red,
                      cursor: "pointer",
                      padding: 0,
                      flexShrink: 0,
                    }}
                  >
                    <Trash2 size={16} color="#E5484D" />
                  </button>
                )}
                {onToggleFavorite && (
                  <button
                    onClick={(e) => {
                      e.stopPropagation();
                      onToggleFavorite(card);
                    }}
                    title={isFavorite ? "Remover dos favoritos" : "Favoritar"}
                    aria-label={isFavorite ? "Remover dos favoritos" : "Favoritar"}
                    aria-pressed={!!isFavorite}
                    style={{
                      display: "flex",
                      alignItems: "center",
                      justifyContent: "center",
                      width: 32,
                      height: 32,
                      borderRadius: 10,
                      border: `1px solid ${isFavorite ? STAR_COLOR : t.border}`,
                      background: "transparent",
                      cursor: "pointer",
                      padding: 0,
                      flexShrink: 0,
                    }}
                  >
                    <Star size={17} color={isFavorite ? STAR_COLOR : t.textMuted} fill={isFavorite ? STAR_COLOR : "none"} />
                  </button>
                )}
              </>
            ) : (
              <>
                <Tag>{card.tema}</Tag>
                <span style={{ flex: 1 }} />
                <IncidenceBar level={card.incidencia} />
              </>
            )}
          </div>
          <div
            style={{
              minHeight: 220,
              display: "flex",
              flexDirection: "column",
              alignItems: "center",
              justifyContent: "center",
              textAlign: "center",
              padding: 30,
              background: flipped ? answerBg : "transparent",
              transition: "background .2s",
            }}
          >
            <div style={{ fontWeight: 700, fontSize: cardFontSize, color: t.text, lineHeight: 1.4 }}>
              {flipped ? card.resposta : card.pergunta}
            </div>
            <CardImage key={card.id} card={card} flipped={flipped} />
            <div style={{ fontSize: 13, color: flipped ? answerBorder : t.primary, marginTop: 22, fontWeight: 600 }}>
              {flipped ? "Clique para ver a pergunta" : "Clique para ver a resposta"}
            </div>
          </div>
        </div>

        <div style={{ display: "flex", justifyContent: "space-between", gap: 10, marginTop: 24 }}>
          <PrimaryButton variant="ghost" disabled={idx === 0} onClick={() => go(-1)}>
            Anterior
          </PrimaryButton>
          {idx < total - 1 ? (
            <PrimaryButton disabled={!viewed} color="#21512E" onClick={() => go(1)}>
              Próximo
            </PrimaryButton>
          ) : (
            <PrimaryButton disabled={!viewed} color="#21512E" onClick={onFinish}>
              Concluir
            </PrimaryButton>
          )}
        </div>
      </div>

      {showReport && (
        <ReportIssueModal
          supabase={supabase}
          userId={userId}
          itemType="flashcard"
          itemId={card.id}
          onClose={() => setShowReport(false)}
        />
      )}

      {confirmTrash && (
        <div
          className="modal-overlay" style={{ position: "fixed", inset: 0, background: "rgba(0,0,0,0.55)", display: "flex", alignItems: "center", justifyContent: "center", zIndex: 60, padding: 20 }}
        >
          <div style={{ background: t.surface, border: `1px solid ${t.border}`, borderRadius: 18, padding: 22, maxWidth: 380, width: "100%" }}>
            <div style={{ display: "flex", alignItems: "center", gap: 10, marginBottom: 12 }}>
              <Trash2 size={20} color="#E5484D" />
              <h3 style={{ fontSize: 16.5, color: t.text, margin: 0 }}>Mandar para a lixeira?</h3>
            </div>
            <p style={{ fontSize: 13.5, color: t.textMuted, lineHeight: 1.6, margin: 0 }}>
              Você acredita que este flashcard é desnecessário e quer mandá-lo para a lixeira? Ele deixa de aparecer só para você, e dá para
              restaurá-lo depois em <b style={{ color: t.text }}>Personalizado → Lixeira</b>.
            </p>
            {trashError && <div style={{ fontSize: 12.5, color: t.red, marginTop: 12 }}>{trashError}</div>}
            <div style={{ display: "flex", gap: 10, marginTop: 20 }}>
              <div style={{ flex: 1 }}>
                <PrimaryButton full variant="ghost" disabled={trashing} onClick={() => setConfirmTrash(false)}>
                  Cancelar
                </PrimaryButton>
              </div>
              <div style={{ flex: 1 }}>
                <PrimaryButton full disabled={trashing} color={t.red} onClick={sendCardToTrash}>
                  {trashing ? "Enviando..." : "Mandar para a lixeira"}
                </PrimaryButton>
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
