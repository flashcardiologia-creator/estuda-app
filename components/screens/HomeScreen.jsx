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

// Botão Missão Diária: cor do ícone/texto (accent) e do fundo (hero) em cada tema e estado.
// Tema claro: vermelho carmim quando pendente e verde suave quando concluída.
const MISSION_TONES = {
  dark: { pending: { hero: "rgba(180,32,38,0.28)" }, done: { hero: "rgba(34,197,94,0.13)", accent: "#22C55E" } },
  light: { pending: { hero: "#EDB9C4", accent: "#B4173E" }, done: { hero: "#C2E5D0", accent: "#238B50" } },
};

export function HomeScreen({ name, onNavigate, missionDone, onOpenDaily, pendingChallengesCount = 0, locked = false }) {
  const t = useT();
  const tone = MISSION_TONES[t.name === "dark" ? "dark" : "light"][missionDone ? "done" : "pending"];
  const missionAccent = tone.accent || t.red; // no escuro, o vermelho pendente vem do tema
  return (
    <div className="home-fit" style={{ padding: "8px 20px var(--home-bottom, 60px)", maxWidth: 620, margin: "0 auto" }}>
      <h1 style={{ fontWeight: 700, fontSize: 20, color: t.text, margin: "var(--home-top, 18px) 0 var(--home-sub, 24px)" }}>Bem-vindo, {name}!</h1>

      <div style={{ display: "flex", flexDirection: "column", gap: "var(--home-gap, 14px)" }}>
        <HomeBox
          icon={<Flame fill={missionAccent} />}
          title="Missão Diária"
          onClick={onOpenDaily}
          heroBg={tone.hero}
          accentColor={missionAccent}
          statusText={missionDone ? (t.name === "dark" ? "✓ Concluída" : "Concluída") : "Não realizada"}
          statusColor={missionAccent}
        />
        <HomeBox icon={<BookOpen />} title="Questões" showLock={locked} onClick={() => onNavigate("questions-filters")} accentColor="#3B82F6" />
        <HomeBox icon={<Rocket />} title="Flashcards" showLock={locked} onClick={() => onNavigate("flashcards-select")} accentColor={t.amber} />
        <HomeBox icon={<Trophy />} title="Trials" locked accentColor="#C1443A" />
        <div style={{ position: "relative" }}>
          <HomeBox icon={<Swords />} title="Desafios" onClick={() => onNavigate("challenges")} accentColor="#9B6BFF" />
          {pendingChallengesCount > 0 && <PendingChallengesBadge count={pendingChallengesCount} bg={t.bg} />}
        </div>
      </div>
    </div>
  );
}
