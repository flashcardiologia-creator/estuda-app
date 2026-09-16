"use client";

import { createContext, useContext, useEffect, useState } from "react";
import { THEMES } from "@/lib/theme";

const ThemeCtx = createContext(THEMES.dark);
const ThemeControlCtx = createContext({ theme: "dark", setTheme: () => {} });

export const useT = () => useContext(ThemeCtx);
export const useThemeControl = () => useContext(ThemeControlCtx);

const STORAGE_KEY = "estuda-theme";

export function ThemeProvider({ children }) {
  const [theme, setThemeState] = useState("dark");

  useEffect(() => {
    try {
      const saved = window.localStorage.getItem(STORAGE_KEY);
      if (saved === "light" || saved === "dark") setThemeState(saved);
    } catch {
      // ignore
    }
  }, []);

  const setTheme = (next) => {
    setThemeState(next);
    try {
      window.localStorage.setItem(STORAGE_KEY, next);
    } catch {
      // ignore
    }
  };

  const t = THEMES[theme];

  return (
    <ThemeControlCtx.Provider value={{ theme, setTheme }}>
      <ThemeCtx.Provider value={t}>
        <div
          style={{
            minHeight: "100vh",
            background: `radial-gradient(circle, ${t.border}55 1px, transparent 1px) 0 0/22px 22px, ${t.bg}`,
          }}
        >
          {children}
        </div>
      </ThemeCtx.Provider>
    </ThemeControlCtx.Provider>
  );
}
