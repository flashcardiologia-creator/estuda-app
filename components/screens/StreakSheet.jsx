"use client";

import { useEffect, useState } from "react";
import { X, Flame, Trophy, Bandage, ChevronDown } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { fetchFriendsStreaks } from "@/lib/data/friends";

const days = (n) => `${n} ${n === 1 ? "dia" : "dias"}`;

// Painel que abre ao tocar no foguinho: sequência atual, maior sequência, bandagem e a sequência dos amigos.
// streak = sequência atual já corrigida (effectiveStreak); profile traz best_streak e bandages; friends = [{ id, name }].
export function StreakSheet({ supabase, profile, streak, subscribed, friends, onClose }) {
  const t = useT();
  const bandages = profile.bandages || 0;
  const [explainOpen, setExplainOpen] = useState(false);
  const [friendsState, setFriendsState] = useState({ status: friends.length ? "loading" : "ok", list: [] });

  useEffect(() => {
    const onKey = (e) => e.key === "Escape" && onClose();
    window.addEventListener("keydown", onKey);
    return () => window.removeEventListener("keydown", onKey);
  }, [onClose]);

  useEffect(() => {
    if (!friends.length) return undefined;
    let cancelled = false;
    fetchFriendsStreaks(
      supabase,
      friends.map((f) => f.id)
    ).then((list) => {
      if (cancelled) return;
      // list = null: o SQL ainda não foi rodado; mostra os amigos sem número.
      setFriendsState(list ? { status: "ok", list } : { status: "missing", list: friends.map((f) => ({ id: f.id, name: f.name, streak: undefined, visible: true })) });
    });
    return () => {
      cancelled = true;
    };
  }, [supabase, friends]);

  const sorted = [...friendsState.list].sort((a, b) => (b.streak ?? -1) - (a.streak ?? -1) || a.name.localeCompare(b.name));

  const row = { display: "flex", alignItems: "center", gap: 12, padding: "13px 0" };
  const label = { flex: 1, fontSize: 14, color: t.text };
  const value = { fontSize: 14, fontWeight: 700, color: t.text, fontVariantNumeric: "tabular-nums" };

  return (
    <div
      onClick={(e) => e.target === e.currentTarget && onClose()}
      style={{ position: "fixed", inset: 0, zIndex: 60, background: t.name === "dark" ? "rgba(0,0,0,0.6)" : "rgba(24,20,48,0.38)", display: "flex", alignItems: "center", justifyContent: "center", padding: 20 }}
    >
      <div
        role="dialog"
        aria-modal="true"
        aria-labelledby="streak-title"
        className="fc-sheet"
        style={{ width: "100%", maxWidth: 400, maxHeight: "calc(100dvh - 40px)", overflowY: "auto", boxSizing: "border-box", background: t.surface, border: `1px solid ${t.border}`, borderRadius: 16, padding: "18px 20px 22px" }}
      >
        <div style={{ display: "flex", alignItems: "center", marginBottom: 2 }}>
          <h3 id="streak-title" style={{ flex: 1, margin: 0, fontSize: 17, fontWeight: 700, color: t.text }}>
            Sua sequência
          </h3>
          <button type="button" onClick={onClose} aria-label="Fechar" style={{ width: 44, height: 44, margin: "-8px -10px -8px 0", display: "flex", alignItems: "center", justifyContent: "center", background: "transparent", border: "none", borderRadius: 12, cursor: "pointer" }}>
            <X size={20} color={t.textMuted} />
          </button>
        </div>

        <div>
          <div style={row}>
            <Flame size={20} color={t.amber} fill={t.amber} />
            <span style={label}>Sequência atual</span>
            <span style={value}>{days(streak)}</span>
          </div>
          <div style={{ ...row, borderTop: `1px solid ${t.border}` }}>
            <Trophy size={20} color={t.amber} />
            <span style={label}>Maior sequência</span>
            <span style={value}>{days(profile.best_streak || 0)}</span>
          </div>
          {/* A explicação da bandagem só aparece ao tocar nesta linha. */}
          <button
            type="button"
            onClick={() => setExplainOpen((o) => !o)}
            aria-expanded={explainOpen}
            aria-controls="bandage-explain"
            style={{ ...row, width: "100%", boxSizing: "border-box", borderTop: `1px solid ${t.border}`, borderLeft: "none", borderRight: "none", borderBottom: "none", background: "transparent", cursor: "pointer", fontFamily: "inherit", textAlign: "left" }}
          >
            <Bandage size={20} color={bandages > 0 ? t.green : t.textMuted} />
            <span style={label}>Bandagens</span>
            <span style={{ ...value, color: bandages > 0 ? t.green : t.textMuted }}>{bandages} de 1</span>
            <ChevronDown size={16} color={t.textMuted} style={{ flexShrink: 0, transform: explainOpen ? "rotate(180deg)" : "none", transition: "transform .2s" }} />
          </button>
        </div>
        {explainOpen && (
          <p id="bandage-explain" style={{ margin: "2px 0 0", fontSize: 12.5, lineHeight: 1.55, color: t.textMuted }}>
            {subscribed
              ? "Acertando todas as questões da missão diária, você tem 50% de chance de ganhar uma bandagem. Se ficar um dia sem fazer a missão, ela salva sua sequência quando você voltar. Só cabe uma: com uma guardada, não há novo sorteio."
              : "As bandagens são para assinantes: quem assina ganha uma chance de bandagem a cada missão em que acerta todas as questões."}
          </p>
        )}

        <h4 style={{ margin: "22px 0 4px", fontSize: 13, fontWeight: 700, color: t.text }}>Sequência dos amigos</h4>
        {friends.length === 0 ? (
          <p style={{ margin: "6px 0 0", fontSize: 13, lineHeight: 1.5, color: t.textMuted }}>Adicione amigos em Minha Conta → Amigos para comparar as sequências.</p>
        ) : friendsState.status === "loading" ? (
          <p style={{ margin: "6px 0 0", fontSize: 13, color: t.textMuted }}>Carregando…</p>
        ) : (
          <ul style={{ listStyle: "none", margin: 0, padding: 0 }}>
            {sorted.map((f, i) => (
              <li key={f.id} style={{ ...row, borderTop: i ? `1px solid ${t.border}` : "none" }}>
                <span aria-hidden="true" style={{ width: 28, height: 28, borderRadius: "50%", background: t.primarySoft, color: t.primary, display: "flex", alignItems: "center", justifyContent: "center", fontSize: 12, fontWeight: 700, flexShrink: 0 }}>
                  {f.name[0]}
                </span>
                <span style={{ ...label, minWidth: 0, overflow: "hidden", textOverflow: "ellipsis", whiteSpace: "nowrap" }}>{f.name}</span>
                {f.streak == null ? (
                  <span style={{ fontSize: 12.5, color: t.textMuted }}>{f.visible === false ? "Oculta" : "—"}</span>
                ) : (
                  <span style={{ display: "flex", alignItems: "center", gap: 6, ...value }}>
                    <Flame size={15} color={f.done_today ? t.green : t.textMuted} fill={f.done_today ? t.green : "none"} />
                    {days(f.streak)}
                  </span>
                )}
              </li>
            ))}
          </ul>
        )}
      </div>
    </div>
  );
}
