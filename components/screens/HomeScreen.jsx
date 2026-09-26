"use client";

import { Flame, BookOpen, Rocket, Trophy, Swords } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { HomeBox } from "@/components/ui/Primitives";

function PendingChallengesBadge({ count, bg }) {
  return (
    <div
      style={{
        position: "absolute",
        top: -7,
        right: -7,
        minWidth: 24,
        height: 24,
        borderRadius: "50%",
        background: "#E5484D",
        color: "#fff",
        fontSize: 11.5,
        fontWeight: 700,
        display: "flex",
        alignItems: "center",
        justifyContent: "center",
        padding: "0 5px",
        border: `2px solid ${bg}`,
        boxShadow: "0 2px 6px rgba(0,0,0,0.35)",
      }}
    >
      {count > 99 ? "99+" : count}
    </div>
  );
}

export function HomeScreen({ name, onNavigate, missionDone, onOpenDaily, pendingChallengesCount = 0 }) {
  const t = useT();
  return (
    <div style={{ padding: "8px 20px 60px", maxWidth: 620, margin: "0 auto" }}>
      <h1 style={{ fontWeight: 700, fontSize: 20, color: t.text, margin: "18px 0 24px" }}>Bem-vindo, {name}!</h1>

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
        />
        <HomeBox icon={<BookOpen />} title="Questões" onClick={() => onNavigate("questions-filters")} accentColor="#3B82F6" />
        <HomeBox icon={<Rocket />} title="Flashcards" onClick={() => onNavigate("flashcards-select")} accentColor={t.amber} />
        <HomeBox icon={<Trophy />} title="Trials" locked accentColor="#C1443A" />
        <div style={{ position: "relative" }}>
          <HomeBox icon={<Swords />} title="Desafios" onClick={() => onNavigate("challenges")} accentColor="#9B6BFF" />
          {pendingChallengesCount > 0 && <PendingChallengesBadge count={pendingChallengesCount} bg={t.bg} />}
        </div>
      </div>
    </div>
  );
}
