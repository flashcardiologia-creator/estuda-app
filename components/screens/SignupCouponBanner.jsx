"use client";

import { useEffect, useState } from "react";
import { useT } from "@/components/theme/ThemeProvider";

// Mesma validade do cupom no banco (supabase/cupom_10diasgratis.sql: 02/12/2026 00:00 em Brasília). Depois disso o aviso some sozinho.
export const PROMO_UNTIL = new Date("2026-12-02T00:00:00-03:00").getTime();
// O contador começa quando a pessoa abre o site pela primeira vez e segue de onde parou nas visitas seguintes.
export const PROMO_DURATION_MS = (47 * 60 + 56) * 60 * 1000;
const START_KEY = "fc-promo-10dias-inicio";

// Momento em que o contador termina (ms). Grava o início na primeira visita; nunca passa da validade real do cupom.
export function promoDeadline() {
  let start = Date.now();
  try {
    const saved = Number(window.localStorage.getItem(START_KEY));
    if (saved > 0 && saved <= start) start = saved;
    else window.localStorage.setItem(START_KEY, String(start));
  } catch {
    // sem armazenamento: o contador recomeça a cada visita
  }
  return Math.min(start + PROMO_DURATION_MS, PROMO_UNTIL);
}

const two = (n) => String(n).padStart(2, "0");
const clock = (ms) => {
  const s = Math.max(0, Math.floor(ms / 1000));
  return `${two(Math.floor(s / 3600))}:${two(Math.floor((s % 3600) / 60))}:${two(s % 60)}`;
};

// Aviso no alto da tela de cadastro: "Crie sua conta GRÁTIS agora" e o contador.
// deadline: instante final do contador; initialRest: tempo que falta quando o aviso aparece (calculado fora, no mesmo instante).
export function SignupCouponBanner({ deadline, initialRest, onExpire }) {
  const t = useT();
  const [rest, setRest] = useState(initialRest);

  useEffect(() => {
    const id = setInterval(() => {
      const left = deadline - Date.now();
      if (left <= 0) {
        clearInterval(id);
        onExpire();
        return;
      }
      setRest(left);
    }, 1000);
    return () => clearInterval(id);
  }, [deadline, onExpire]);

  return (
    <div style={{ textAlign: "center", margin: "0 0 20px", padding: "12px 14px", borderRadius: 14, background: t.primarySoft, border: `1px solid ${t.primary}` }}>
      <div style={{ fontSize: 15, lineHeight: 1.45, fontWeight: 700, color: t.text }}>
        Crie sua conta <span style={{ color: t.primary }}>GRÁTIS</span> agora
      </div>
      <div role="timer" aria-label="Tempo restante da oferta" style={{ marginTop: 6, fontSize: 20, lineHeight: 1.1, fontWeight: 800, color: t.text, fontVariantNumeric: "tabular-nums", letterSpacing: 0.5 }}>
        {clock(rest)}
      </div>
    </div>
  );
}
