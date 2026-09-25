"use client";

import { Sun, Moon, User } from "lucide-react";
import { useT, useThemeControl } from "@/components/theme/ThemeProvider";
import { Flame_ } from "@/components/ui/Primitives";

export function Header({ streak, onNavigate, missionDone }) {
  const t = useT();
  const { theme, setTheme } = useThemeControl();

  return (
    <div
      style={{
        display: "flex",
        alignItems: "center",
        justifyContent: "space-between",
        padding: "6px 24px 6px",
        background: "transparent",
      }}
    >
      <div
        style={{ display: "flex", alignItems: "center", gap: 8 }}
        title={missionDone ? "Missão de hoje concluída" : "Missão de hoje pendente"}
      >
        <Flame_ done={missionDone} size={26} />
        <span style={{ fontWeight: 700, fontSize: 19, color: t.text }}>{streak}</span>
      </div>

      <div style={{ display: "flex", alignItems: "center", gap: 10 }}>
        <button
          onClick={() => setTheme(theme === "dark" ? "light" : "dark")}
          title="Alternar tema claro/escuro"
          style={{
            width: 40,
            height: 40,
            borderRadius: "50%",
            border: "none",
            background: t.surfaceAlt,
            display: "flex",
            alignItems: "center",
            justifyContent: "center",
            cursor: "pointer",
          }}
        >
          {theme === "dark" ? <Sun size={18} color={t.text} /> : <Moon size={18} color={t.text} />}
        </button>

        <button
          onClick={() => onNavigate("account")}
          title="Minha Conta"
          style={{
            width: 40,
            height: 40,
            borderRadius: "50%",
            border: "none",
            background: t.surfaceAlt,
            display: "flex",
            alignItems: "center",
            justifyContent: "center",
            cursor: "pointer",
          }}
        >
          <User size={18} color={t.text} />
        </button>
      </div>
    </div>
  );
}
