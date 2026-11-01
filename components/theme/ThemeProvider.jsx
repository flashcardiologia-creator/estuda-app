"use client";

import { createContext, useContext, useEffect, useState } from "react";
import { usePathname } from "next/navigation";
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

  // A tela de entrada (/login: boas-vindas, cadastro e login) fica sempre no tema claro, qualquer que seja o tema guardado.
  // Vem do endereço, então já sai certa do servidor (sem piscar o escuro) e não mexe no tema que a pessoa escolheu para o app.
  const pathname = usePathname();
  const forced = pathname === "/login" || pathname?.startsWith("/login/") ? "light" : null;
  const t = THEMES[forced ?? theme];

  useEffect(() => {
    const meta = document.querySelector('meta[name="theme-color"]');
    if (meta) meta.setAttribute("content", t.bg);
    // Sem isso, o "bounce" de overscroll (PWA/iOS) mostra o branco padrão do
    // documento por trás do app, mesmo no tema escuro.
    document.documentElement.style.backgroundColor = t.bg;
    document.body.style.backgroundColor = t.bg;
  }, [t.bg]);

  return (
    <ThemeControlCtx.Provider value={{ theme, setTheme }}>
      <ThemeCtx.Provider value={t}>
        <div
          style={{
            minHeight: "100vh",
            background: `radial-gradient(circle, ${t.border}55 1px, transparent 1px) 0 0/22px 22px, ${t.bg}`,
            paddingTop: "env(safe-area-inset-top)",
            paddingBottom: "env(safe-area-inset-bottom)",
          }}
        >
          <div className="app-zoom">{children}</div>
        </div>
      </ThemeCtx.Provider>
    </ThemeControlCtx.Provider>
  );
}
