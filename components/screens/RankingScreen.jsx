"use client";

import { useEffect, useMemo, useState } from "react";
import { Award, BookOpen, Rocket, Swords } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { ScreenHeader, Chip, EmptyState } from "@/components/ui/Primitives";
import { fetchLeaderboard } from "@/lib/data/leaderboard";

const TABS = [
  { key: "acertos", label: "Acertos", icon: Award, field: "accuracy", format: (v) => `${v}%` },
  { key: "desafios", label: "Desafios", icon: Swords, field: "challenge_wins", format: (v) => `${v} vitória${v === 1 ? "" : "s"}` },
  { key: "questoes", label: "Questões", icon: BookOpen, field: "answered", format: (v) => `${v} respondida${v === 1 ? "" : "s"}` },
  { key: "flashcards", label: "Flashcards", icon: Rocket, field: "flashcards_viewed", format: (v) => `${v} visto${v === 1 ? "" : "s"}` },
];

const MEDALS = ["🥇", "🥈", "🥉"];

export function RankingScreen({ supabase, onNavigate }) {
  const t = useT();
  const [tab, setTab] = useState("acertos");
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

  const ranked = useMemo(() => {
    if (!rows) return [];
    return [...rows].sort((a, b) => b[config.field] - a[config.field]);
  }, [rows, config.field]);

  return (
    <div style={{ maxWidth: 640, margin: "0 auto", paddingBottom: 90 }}>
      <ScreenHeader title="Ranking" onBack={() => onNavigate("account")} />
      <div style={{ padding: "18px 22px" }}>
        <div style={{ display: "flex", gap: 8, marginBottom: 18 }}>
          {TABS.map((tb) => (
            <Chip key={tb.key} active={tab === tb.key} onClick={() => setTab(tb.key)} style={{ flex: 1, textAlign: "center" }}>
              {tb.label}
            </Chip>
          ))}
        </div>

        {loadError && <EmptyState text={loadError} />}
        {!loadError && !rows && <EmptyState text="Carregando…" />}

        {!loadError && rows && ranked.length === 0 && (
          <EmptyState text="Ninguém compartilhou estatísticas ainda." />
        )}

        {!loadError &&
          rows &&
          ranked.map((r, i) => (
            <div
              key={r.id}
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
                  {MEDALS[i] || i + 1}
                </div>
                <div style={{ flex: 1, fontSize: 14, fontWeight: 700, color: t.text }}>
                  {r.name}
                  {r.is_me ? " (você)" : ""}
                </div>
                <div style={{ fontSize: 15, fontWeight: 800, color: t.primary }}>{config.format(r[config.field])}</div>
              </div>

              <div
                style={{
                  display: "flex",
                  flexWrap: "wrap",
                  gap: 14,
                  marginTop: 10,
                  paddingTop: 10,
                  borderTop: `1px solid ${t.border}`,
                  marginLeft: 40,
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
                      }}
                    >
                      <Icon size={12} />
                      {tb.format(r[tb.field])}
                    </div>
                  );
                })}
              </div>
            </div>
          ))}
      </div>
    </div>
  );
}
