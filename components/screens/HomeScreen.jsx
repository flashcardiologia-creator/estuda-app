"use client";

import { useEffect, useState } from "react";
import { Flame, BookOpen, Rocket, Trophy, Swords, Clock } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { HomeBox } from "@/components/ui/Primitives";

// Missão vira às 18h de Brasília (21h UTC) — mesma regra de app_today()/todayStr().
const DAY_BOUNDARY_UTC_HOUR = 21;

function msUntilNextBoundary() {
  const now = new Date();
  const next = new Date(Date.UTC(now.getUTCFullYear(), now.getUTCMonth(), now.getUTCDate(), DAY_BOUNDARY_UTC_HOUR, 0, 0, 0));
  if (next.getTime() <= now.getTime()) next.setUTCDate(next.getUTCDate() + 1);
  return next.getTime() - now.getTime();
}

function formatCountdown(ms) {
  const totalSeconds = Math.max(0, Math.floor(ms / 1000));
  const h = Math.floor(totalSeconds / 3600);
  const m = Math.floor((totalSeconds % 3600) / 60);
  const s = totalSeconds % 60;
  return `${h}:${String(m).padStart(2, "0")}:${String(s).padStart(2, "0")}`;
}

function DailyMissionCountdown() {
  const [remaining, setRemaining] = useState(msUntilNextBoundary);

  useEffect(() => {
    const interval = setInterval(() => setRemaining(msUntilNextBoundary()), 1000);
    return () => clearInterval(interval);
  }, []);

  return (
    <div style={{ display: "flex", alignItems: "center", gap: 4 }}>
      <Clock size={11} color="#fff" />
      <span style={{ fontSize: 11, fontWeight: 700, color: "#fff", fontVariantNumeric: "tabular-nums" }}>
        {formatCountdown(remaining)}
      </span>
    </div>
  );
}

export function HomeScreen({ name, onNavigate, missionDone, onOpenDaily }) {
  const t = useT();
  return (
    <div style={{ padding: "8px 20px 60px", maxWidth: 620, margin: "0 auto" }}>
      <h1 style={{ fontWeight: 700, fontSize: 27, color: t.text, margin: "18px 0 24px" }}>Bem-vindo, {name}!</h1>

      <div style={{ display: "flex", flexDirection: "column", gap: 14 }}>
        <HomeBox
          icon={
            <Flame
              fill={missionDone ? (t.name === "dark" ? "#22C55E" : "#16A34A") : t.name === "dark" ? t.red : "#DC2626"}
            />
          }
          title="Missão Diária"
          onClick={onOpenDaily}
          heroBg={
            t.name === "dark"
              ? missionDone
                ? "rgba(34,197,94,0.13)"
                : "rgba(180,32,38,0.28)"
              : missionDone
              ? "linear-gradient(135deg, #A9DDBD 0%, #C7C7CE 100%)"
              : "linear-gradient(135deg, #E9AFB6 0%, #C7C7CE 100%)"
          }
          accentColor={missionDone ? (t.name === "dark" ? "#22C55E" : "#16A34A") : t.name === "dark" ? t.red : "#DC2626"}
          statusText={missionDone ? (t.name === "dark" ? "✓ Concluída" : "Concluída") : "Não realizada"}
          statusColor={missionDone ? (t.name === "dark" ? "#22C55E" : "#16A34A") : t.name === "dark" ? t.red : "#DC2626"}
          cornerBadge={!missionDone && <DailyMissionCountdown />}
        />
        <HomeBox icon={<BookOpen />} title="Questões" onClick={() => onNavigate("questions-filters")} accentColor="#3B82F6" />
        <HomeBox icon={<Rocket />} title="Flashcards" onClick={() => onNavigate("flashcards-select")} accentColor={t.amber} />
        <HomeBox icon={<Trophy />} title="Trials" locked accentColor="#C1443A" />
        <HomeBox icon={<Swords />} title="Desafios" onClick={() => onNavigate("challenges")} accentColor="#9B6BFF" />
      </div>
    </div>
  );
}
