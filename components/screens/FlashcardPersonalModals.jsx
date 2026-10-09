"use client";

import { useEffect, useState } from "react";
import { Trash2, X, RotateCcw, Plus, Check } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { PrimaryButton, Tag } from "@/components/ui/Primitives";
import { MAX_PERGUNTA, MAX_RESPOSTA } from "@/lib/data/personal";

function ModalShell({ title, icon, onClose, children }) {
  const t = useT();
  return (
    <div style={{ position: "fixed", inset: 0, background: "rgba(0,0,0,0.55)", display: "flex", alignItems: "center", justifyContent: "center", zIndex: 60, padding: 20 }}>
      <div
        style={{
          background: t.surface,
          border: `1px solid ${t.border}`,
          borderRadius: 18,
          padding: 22,
          maxWidth: 460,
          width: "100%",
          maxHeight: "86vh",
          overflowY: "auto",
        }}
      >
        <div style={{ display: "flex", alignItems: "center", justifyContent: "space-between", marginBottom: 16 }}>
          <div style={{ display: "flex", alignItems: "center", gap: 10 }}>
            {icon}
            <h3 style={{ fontSize: 16.5, color: t.text, margin: 0 }}>{title}</h3>
          </div>
          <button onClick={onClose} aria-label="Fechar" style={{ background: "transparent", border: "none", cursor: "pointer", padding: 4 }}>
            <X size={18} color={t.textMuted} />
          </button>
        </div>
        {children}
      </div>
    </div>
  );
}

// Criar um flashcard próprio: tema + pergunta + resposta (sempre em maiúsculas). Só aparece para quem criou.
export function CreateFlashcardModal({ temas, onCreate, onClose }) {
  const t = useT();
  const [tema, setTema] = useState(temas[0] || "");
  const [pergunta, setPergunta] = useState("");
  const [resposta, setResposta] = useState("");
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState("");
  const [saved, setSaved] = useState(0);

  const fieldStyle = {
    width: "100%",
    padding: 10,
    borderRadius: 10,
    border: `1px solid ${t.border}`,
    background: t.surfaceAlt,
    color: t.text,
    fontSize: 16,
    fontFamily: "inherit",
    boxSizing: "border-box",
    textTransform: "uppercase",
  };
  const labelStyle = { fontSize: 12, fontWeight: 700, color: t.textMuted, marginBottom: 6, letterSpacing: 0.3 };
  const canSave = !!tema && pergunta.trim().length > 0 && resposta.trim().length > 0 && !saving;

  const save = async () => {
    setSaving(true);
    setError("");
    try {
      await onCreate({ tema, pergunta, resposta });
      setPergunta("");
      setResposta("");
      setSaved((n) => n + 1);
    } catch (err) {
      setError(err.message || "Não foi possível salvar.");
    } finally {
      setSaving(false);
    }
  };

  return (
    <ModalShell title="Criar flashcard" icon={<Plus size={18} color={t.primary} />} onClose={onClose}>
      <div style={{ marginBottom: 14 }}>
        <div style={labelStyle}>TEMA</div>
        <select value={tema} onChange={(e) => setTema(e.target.value)} style={{ ...fieldStyle, textTransform: "none" }}>
          {temas.map((x) => (
            <option key={x} value={x}>
              {x}
            </option>
          ))}
        </select>
      </div>
      <div style={{ marginBottom: 14 }}>
        <div style={labelStyle}>PERGUNTA</div>
        <textarea
          value={pergunta}
          onChange={(e) => setPergunta(e.target.value.toUpperCase().slice(0, MAX_PERGUNTA))}
          rows={3}
          placeholder="ESCREVA A PERGUNTA"
          style={{ ...fieldStyle, resize: "vertical" }}
        />
      </div>
      <div style={{ marginBottom: 14 }}>
        <div style={labelStyle}>RESPOSTA</div>
        <textarea
          value={resposta}
          onChange={(e) => setResposta(e.target.value.toUpperCase().slice(0, MAX_RESPOSTA))}
          rows={4}
          placeholder="ESCREVA A RESPOSTA"
          style={{ ...fieldStyle, resize: "vertical" }}
        />
      </div>
      <div style={{ fontSize: 12, color: t.textMuted, marginBottom: 12 }}>Só você vê os flashcards que criar.</div>
      {error && <div style={{ fontSize: 12.5, color: t.red, marginBottom: 10 }}>{error}</div>}
      {saved > 0 && !error && (
        <div style={{ display: "flex", alignItems: "center", gap: 6, fontSize: 12.5, color: t.green, marginBottom: 10 }}>
          <Check size={14} /> Flashcard salvo! Você pode criar outro ou fechar.
        </div>
      )}
      <div style={{ display: "flex", gap: 10 }}>
        <div style={{ flex: 1 }}>
          <PrimaryButton full variant="ghost" onClick={onClose}>
            Fechar
          </PrimaryButton>
        </div>
        <div style={{ flex: 1 }}>
          <PrimaryButton full disabled={!canSave} onClick={save}>
            {saving ? "Salvando..." : "Salvar"}
          </PrimaryButton>
        </div>
      </div>
    </ModalShell>
  );
}

// Lixeira: flashcards que a pessoa mandou para o lixo; dá para restaurar (e apagar de vez os que ela mesma criou).
export function TrashModal({ onLoad, onRestore, onDeleteForever, onClose }) {
  const t = useT();
  const [cards, setCards] = useState(null);
  const [busyId, setBusyId] = useState(null);
  const [confirmId, setConfirmId] = useState(null);
  const [error, setError] = useState("");

  useEffect(() => {
    let cancelled = false;
    onLoad()
      .then((list) => {
        if (!cancelled) setCards(list);
      })
      .catch(() => {
        if (!cancelled) setCards([]);
      });
    return () => {
      cancelled = true;
    };
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const run = async (card, action) => {
    setBusyId(card.id);
    setError("");
    try {
      await action(card);
      setCards((list) => list.filter((c) => c.id !== card.id));
      setConfirmId(null);
    } catch (err) {
      setError(err.message || "Não foi possível concluir.");
    } finally {
      setBusyId(null);
    }
  };

  return (
    <ModalShell title="Lixeira" icon={<Trash2 size={18} color={t.red} />} onClose={onClose}>
      {error && <div style={{ fontSize: 12.5, color: t.red, marginBottom: 10 }}>{error}</div>}
      {cards === null && <div style={{ fontSize: 13, color: t.textMuted }}>Carregando…</div>}
      {cards && cards.length === 0 && (
        <div style={{ fontSize: 13, color: t.textMuted, lineHeight: 1.6 }}>
          A lixeira está vazia. Os flashcards que você mandar para a lixeira aparecem aqui e podem ser restaurados.
        </div>
      )}
      {cards && cards.length > 0 && (
        <div style={{ display: "flex", flexDirection: "column", gap: 10 }}>
          {cards.map((c) => (
            <div key={c.id} style={{ background: t.surfaceAlt, border: `1px solid ${t.border}`, borderRadius: 12, padding: "12px 14px" }}>
              <div style={{ display: "flex", gap: 8, marginBottom: 8, flexWrap: "wrap" }}>
                <Tag>{c.tema}</Tag>
                {c.custom && <Tag>Criado por você</Tag>}
              </div>
              <div style={{ fontSize: 13.5, fontWeight: 700, color: t.text, lineHeight: 1.4 }}>{c.pergunta}</div>
              <div style={{ fontSize: 12.5, color: t.textMuted, marginTop: 6, lineHeight: 1.5 }}>{c.resposta}</div>
              {confirmId === c.id ? (
                <div style={{ marginTop: 10 }}>
                  <div style={{ fontSize: 12.5, color: t.text, marginBottom: 8 }}>Apagar de vez? Não dá para desfazer.</div>
                  <div style={{ display: "flex", gap: 8 }}>
                    <div style={{ flex: 1 }}>
                      <PrimaryButton small full variant="ghost" disabled={busyId === c.id} onClick={() => setConfirmId(null)}>
                        Cancelar
                      </PrimaryButton>
                    </div>
                    <div style={{ flex: 1 }}>
                      <PrimaryButton small full color={t.red} disabled={busyId === c.id} onClick={() => run(c, onDeleteForever)}>
                        Apagar de vez
                      </PrimaryButton>
                    </div>
                  </div>
                </div>
              ) : (
                <div style={{ display: "flex", gap: 8, marginTop: 10 }}>
                  <div style={{ flex: 1 }}>
                    <PrimaryButton small full disabled={busyId === c.id} onClick={() => run(c, onRestore)}>
                      <RotateCcw size={13} style={{ marginRight: 5, verticalAlign: -2 }} />
                      Restaurar
                    </PrimaryButton>
                  </div>
                  {c.custom && (
                    <div style={{ flex: 1 }}>
                      <PrimaryButton small full variant="ghost" disabled={busyId === c.id} onClick={() => setConfirmId(c.id)}>
                        Apagar de vez
                      </PrimaryButton>
                    </div>
                  )}
                </div>
              )}
            </div>
          ))}
        </div>
      )}
      <div style={{ marginTop: 16 }}>
        <PrimaryButton full variant="ghost" onClick={onClose}>
          Fechar
        </PrimaryButton>
      </div>
    </ModalShell>
  );
}
