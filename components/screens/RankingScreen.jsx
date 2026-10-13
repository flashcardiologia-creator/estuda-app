"use client";

import { useEffect, useMemo, useState } from "react";
import { Award, BookOpen, Rocket, Swords } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { ScreenHeader, Chip, EmptyState, PrimaryButton } from "@/components/ui/Primitives";
import { fetchLeaderboard } from "@/lib/data/leaderboard";
import { RANKING_PHRASES, updateRankingPhrase } from "@/lib/data/profile";

const TABS = [
  { key: "acertos", label: "Acertos", icon: Award, field: "accuracy", format: (v) => `${v}%` },
  { key: "desafios", label: "Desafios", icon: Swords, field: "challenge_wins", format: (v) => `${v} vitória${v === 1 ? "" : "s"}` },
  { key: "questoes", label: "Questões", icon: BookOpen, field: "answered", format: (v) => `${v} respondida${v === 1 ? "" : "s"}` },
  { key: "flashcards", label: "Flashcards", icon: Rocket, field: "flashcards_viewed", format: (v) => `${v} visto${v === 1 ? "" : "s"}` },
];

const MEDALS = ["🥇", "🥈", "🥉"];

function PhraseChip({ phrase, t }) {
  return (
    <span
      style={{
        display: "inline-block",
        marginLeft: 8,
        padding: "2px 8px",
        borderRadius: 999,
        fontSize: 11,
        fontWeight: 800,
        letterSpacing: 0.4,
        color: t.amber,
        background: `${t.amber}26`,
        verticalAlign: 1,
      }}
    >
      {phrase}
    </span>
  );
}

function RankRow({ r, rank, tab, config, t, onPickPhrase }) {
  return (
    <div
      onClick={r.is_me ? onPickPhrase : undefined}
      role={r.is_me ? "button" : undefined}
      style={{
        padding: "12px 14px",
        borderRadius: 14,
        marginBottom: 8,
        background: r.is_me ? t.primarySoft : t.surface,
        border: `1.5px solid ${r.is_me ? t.primary : t.border}`,
        cursor: r.is_me ? "pointer" : "default",
      }}
    >
      <div style={{ display: "flex", alignItems: "center", gap: 12 }}>
        <div style={{ width: 28, textAlign: "center", fontSize: 16, fontWeight: 800, color: t.textMuted, flexShrink: 0 }}>
          {MEDALS[rank - 1] || rank}
        </div>
        <div style={{ flex: 1, minWidth: 0 }}>
          <div style={{ fontSize: 14, fontWeight: 700, color: r.is_anonymous && !r.is_me ? t.textMuted : t.text }}>
            {r.name}
            {r.is_me ? " (você)" : ""}
            {r.phrase && <PhraseChip phrase={r.phrase} t={t} />}
          </div>
          {r.is_me && r.is_anonymous && (
            <div style={{ fontSize: 11.5, color: t.textMuted, marginTop: 2 }}>Os outros veem você como Anônimo</div>
          )}
          {r.is_me && (
            <div style={{ fontSize: 11.5, color: t.primary, marginTop: 2, fontWeight: 600 }}>
              {r.phrase ? "Toque para trocar sua frase" : "Toque para escolher uma frase de comemoração"}
            </div>
          )}
        </div>
        <div style={{ fontSize: 15, fontWeight: 800, color: t.primary }}>{config.format(r[config.field])}</div>
      </div>

      <div
        style={{
          display: "flex",
          flexWrap: "wrap",
          justifyContent: "space-between",
          gap: "6px 12px",
          marginTop: 10,
          paddingTop: 10,
          borderTop: `1px solid ${t.border}`,
        }}
      >
        {TABS.map((tb) => {
          const Icon = tb.icon;
          const active = tb.key === tab;
          return (
            <div
              key={tb.key}
              style={{
                display: "flex",
                alignItems: "center",
                gap: 4,
                fontSize: 11.5,
                fontWeight: active ? 800 : 600,
                color: active ? t.primary : t.textMuted,
                whiteSpace: "nowrap",
                flexShrink: 0,
              }}
            >
              <Icon size={12} style={{ flexShrink: 0 }} />
              {tb.format(r[tb.field])}
            </div>
          );
        })}
      </div>
    </div>
  );
}

function PhrasePicker({ current, saving, error, onChoose, onClose, t }) {
  return (
    <div
      onClick={onClose}
      className="modal-overlay" style={{ position: "fixed", inset: 0, background: "rgba(0,0,0,0.55)", display: "flex", alignItems: "center", justifyContent: "center", zIndex: 60, padding: 20 }}
    >
      <div
        onClick={(e) => e.stopPropagation()}
        style={{ background: t.surface, border: `1px solid ${t.border}`, borderRadius: 18, padding: 22, maxWidth: 400, width: "100%" }}
      >
        <h3 style={{ fontSize: 16.5, color: t.text, margin: "0 0 6px" }}>Sua frase no ranking</h3>
        <p style={{ fontSize: 13, color: t.textMuted, lineHeight: 1.5, margin: "0 0 16px" }}>
          Ela aparece ao lado do seu nome para todo mundo. Escolha uma para comemorar.
        </p>
        <div style={{ display: "flex", flexWrap: "wrap", gap: 8 }}>
          {RANKING_PHRASES.map((p) => (
            <Chip key={p} active={current === p} onClick={() => !saving && onChoose(p)}>
              {p}
            </Chip>
          ))}
        </div>
        {error && <div style={{ fontSize: 12.5, color: t.red, marginTop: 12, lineHeight: 1.5 }}>{error}</div>}
        <div style={{ display: "flex", gap: 10, marginTop: 18 }}>
          <div style={{ flex: 1 }}>
            <PrimaryButton full variant="ghost" disabled={saving} onClick={onClose}>
              Fechar
            </PrimaryButton>
          </div>
          {current && (
            <div style={{ flex: 1 }}>
              <PrimaryButton full variant="ghost" disabled={saving} onClick={() => onChoose(null)}>
                Tirar a frase
              </PrimaryButton>
            </div>
          )}
        </div>
      </div>
    </div>
  );
}

export function RankingScreen({ supabase, userId, onNavigate }) {
  const t = useT();
  const [tab, setTab] = useState("acertos");
  const [rows, setRows] = useState(null);
  const [loadError, setLoadError] = useState("");
  const [picking, setPicking] = useState(false);
  const [savingPhrase, setSavingPhrase] = useState(false);
  const [phraseError, setPhraseError] = useState("");

  const myPhrase = rows?.find((r) => r.is_me)?.phrase || null;
  const choosePhrase = async (phrase) => {
    setSavingPhrase(true);
    setPhraseError("");
    try {
      await updateRankingPhrase(supabase, userId, phrase);
      setRows((list) => list.map((r) => (r.is_me ? { ...r, phrase } : r)));
      setPicking(false);
    } catch {
      setPhraseError("Não foi possível salvar agora. Tente de novo.");
    } finally {
      setSavingPhrase(false);
    }
  };

  useEffect(() => {
    let cancelled = false;
    fetchLeaderboard(supabase)
      .then((data) => {
        if (!cancelled) setRows(data);
      })
      .catch((err) => {
        if (!cancelled) setLoadError(err.message || "Não foi possível carregar o ranking.");
      });
    return () => {
      cancelled = true;
    };
  }, [supabase]);

  const config = TABS.find((tb) => tb.key === tab);

  const { top10, mePosition } = useMemo(() => {
    if (!rows) return { top10: [], mePosition: null };
    const sorted = [...rows].sort((a, b) => b[config.field] - a[config.field]);
    const meIndex = sorted.findIndex((r) => r.is_me);
    return {
      top10: sorted.slice(0, 10),
      mePosition: meIndex >= 10 ? { rank: meIndex + 1, row: sorted[meIndex] } : null,
    };
  }, [rows, config.field]);

  return (
    <div style={{ maxWidth: 640, margin: "0 auto", paddingBottom: 90 }}>
      <ScreenHeader title="Ranking" onBack={() => onNavigate("account")} />
      <div style={{ padding: "18px 22px" }}>
        <div style={{ display: "flex", gap: 8, marginBottom: 18 }}>
          {TABS.map((tb) => (
            <Chip
              key={tb.key}
              active={tab === tb.key}
              onClick={() => setTab(tb.key)}
              style={{ flex: 1, minWidth: 0, padding: "7px 4px", textAlign: "center", ...(tab !== tb.key && t.name === "light" ? { background: t.surface } : {}) }}
            >
              {tb.label}
            </Chip>
          ))}
        </div>

        {loadError && <EmptyState text={loadError} />}
        {!loadError && !rows && <EmptyState text="Carregando…" />}

        {!loadError && rows && top10.length === 0 && (
          <EmptyState text="Ainda não há ninguém no ranking." />
        )}

        {!loadError &&
          rows &&
          top10.map((r, i) => (
            <RankRow key={r.id || `anonimo-${i}`} r={r} rank={i + 1} tab={tab} config={config} t={t} onPickPhrase={() => setPicking(true)} />
          ))}

        {mePosition && (
          <>
            <div style={{ textAlign: "center", color: t.textMuted, fontSize: 13, fontWeight: 700, margin: "10px 0" }}>
              ···
            </div>
            <RankRow r={mePosition.row} rank={mePosition.rank} tab={tab} config={config} t={t} onPickPhrase={() => setPicking(true)} />
          </>
        )}

        {picking && (
          <PhrasePicker
            current={myPhrase}
            saving={savingPhrase}
            error={phraseError}
            onChoose={choosePhrase}
            onClose={() => {
              setPicking(false);
              setPhraseError("");
            }}
            t={t}
          />
        )}
      </div>
    </div>
  );
}
