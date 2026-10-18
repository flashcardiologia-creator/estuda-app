"use client";

import { useEffect, useMemo, useState } from "react";
import { Award, BookOpen, Rocket, Swords } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { ScreenHeader, Chip, EmptyState } from "@/components/ui/Primitives";
import { fetchLeaderboard } from "@/lib/data/leaderboard";

// Ordem das abas: Acertos, Questões, Flashcards, Desafios.
const TABS = [
  { key: "acertos", label: "Acertos", icon: Award, field: "accuracy", format: (v) => `${v}%` },
  { key: "questoes", label: "Questões", icon: BookOpen, field: "answered", format: (v) => `${v} respondida${v === 1 ? "" : "s"}` },
  { key: "flashcards", label: "Flashcards", icon: Rocket, field: "flashcards_viewed", format: (v) => `${v} visto${v === 1 ? "" : "s"}` },
  { key: "desafios", label: "Desafios", icon: Swords, field: "challenge_wins", format: (v) => `${v} vitória${v === 1 ? "" : "s"}` },
];

// Acertos (%) só vale para quem respondeu MAIS de 50 questões: com poucas respostas, 100% de 3 questões
// passaria na frente de quem estuda de verdade.
const MIN_ANSWERED_FOR_ACCURACY = 50;

const MEDALS = ["🥇", "🥈", "🥉"];

function RankRow({ r, rank, tab, config, t }) {
  return (
    <div
      style={{
        padding: "12px 14px",
        borderRadius: 14,
        marginBottom: 8,
        background: r.is_me ? t.primarySoft : t.surface,
        border: `1.5px solid ${r.is_me ? t.primary : t.border}`,
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
          </div>
          {r.is_me && r.is_anonymous && (
            <div style={{ fontSize: 11.5, color: t.textMuted, marginTop: 2 }}>Os outros veem você como Anônimo</div>
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

// Seletor do canto superior direito: Global (todo mundo) ou Amigos (só quem é seu amigo e deixou o ranking liberado).
function ScopeToggle({ scope, onChange, t }) {
  const options = [
    { key: "global", label: "Global" },
    { key: "amigos", label: "Amigos" },
  ];
  return (
    <div role="group" aria-label="Quem aparece no ranking" style={{ display: "inline-flex", padding: 3, gap: 2, borderRadius: 999, background: t.surfaceAlt, border: `1px solid ${t.border}` }}>
      {options.map((o) => {
        const on = scope === o.key;
        return (
          <button
            key={o.key}
            type="button"
            aria-pressed={on}
            onClick={() => onChange(o.key)}
            style={{
              border: "none",
              cursor: "pointer",
              borderRadius: 999,
              padding: "5px 10px",
              fontSize: 12,
              fontWeight: 700,
              fontFamily: "inherit",
              color: on ? "#fff" : t.textMuted,
              background: on ? t.primary : "transparent",
            }}
          >
            {o.label}
          </button>
        );
      })}
    </div>
  );
}

export function RankingScreen({ supabase, userId, onNavigate, friends = [] }) {
  const t = useT();
  const [tab, setTab] = useState("acertos");
  const [scope, setScope] = useState("global");
  const [rows, setRows] = useState(null);
  const [loadError, setLoadError] = useState("");

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

  // Amigos: só entra quem é amigo E deixou o ranking liberado (quem está como "Anônimo" não manda o código
  // da pessoa, então não dá para reconhecer, e não aparece aqui). Você sempre aparece.
  const friendIds = useMemo(() => new Set(friends.map((f) => f.id)), [friends]);
  const myRow = rows?.find((r) => r.is_me) || null;

  const { top10, mePosition } = useMemo(() => {
    if (!rows) return { top10: [], mePosition: null };
    let pool = rows;
    if (scope === "amigos") pool = pool.filter((r) => r.is_me || (r.id && friendIds.has(r.id)));
    if (tab === "acertos") pool = pool.filter((r) => r.answered > MIN_ANSWERED_FOR_ACCURACY);
    const sorted = [...pool].sort((a, b) => b[config.field] - a[config.field]);
    const meIndex = sorted.findIndex((r) => r.is_me);
    return {
      top10: sorted.slice(0, 10),
      mePosition: meIndex >= 10 ? { rank: meIndex + 1, row: sorted[meIndex] } : null,
    };
  }, [rows, config.field, scope, tab, friendIds]);

  const needsMoreAnswers = tab === "acertos" && myRow && myRow.answered <= MIN_ANSWERED_FOR_ACCURACY;
  const onlyMe = scope === "amigos" && top10.length > 0 && top10.every((r) => r.is_me);

  return (
    <div style={{ maxWidth: 640, margin: "0 auto", paddingBottom: 90 }}>
      <ScreenHeader title="Ranking" onBack={() => onNavigate("account")} right={<ScopeToggle scope={scope} onChange={setScope} t={t} />} />
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

        {tab === "acertos" && (
          <div style={{ fontSize: 12, lineHeight: 1.5, color: t.textMuted, margin: "-6px 2px 14px" }}>
            Mínimo: mais de {MIN_ANSWERED_FOR_ACCURACY} questões respondidas.
            {needsMoreAnswers && (
              <b style={{ color: t.text }}> Você tem {myRow.answered}.</b>
            )}
          </div>
        )}
        {scope === "amigos" && (
          <div style={{ fontSize: 12, lineHeight: 1.5, color: t.textMuted, margin: tab === "acertos" ? "-8px 2px 14px" : "-6px 2px 14px" }}>
            Mostra você e os amigos que deixaram o ranking liberado.
            {onlyMe && " Nenhum amigo aparece aqui ainda."}
          </div>
        )}

        {loadError && <EmptyState text={loadError} />}
        {!loadError && !rows && <EmptyState text="Carregando…" />}

        {!loadError && rows && top10.length === 0 && (
          <EmptyState text={scope === "amigos" ? "Nenhum amigo no ranking ainda." : "Ainda não há ninguém no ranking."} />
        )}

        {!loadError &&
          rows &&
          top10.map((r, i) => (
            <RankRow key={r.id || `anonimo-${i}`} r={r} rank={i + 1} tab={tab} config={config} t={t} />
          ))}

        {mePosition && (
          <>
            <div style={{ textAlign: "center", color: t.textMuted, fontSize: 13, fontWeight: 700, margin: "10px 0" }}>
              ···
            </div>
            <RankRow r={mePosition.row} rank={mePosition.rank} tab={tab} config={config} t={t} />
          </>
        )}
      </div>
    </div>
  );
}
