"use client";

import { useEffect, useState } from "react";
import { X, Flame, Trophy, Bandage, ChevronDown } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { PrimaryButton } from "@/components/ui/Primitives";
import { fetchFriendsStreaks } from "@/lib/data/friends";

const days = (n) => `${n} ${n === 1 ? "dia" : "dias"}`;

// Painel que abre ao tocar no foguinho: sequência atual, maior sequência, bandagem e a sequência dos amigos.
// Mesmo layout da janela "Reportar um erro" (components/ui/ReportIssue.jsx).
// streak = sequência atual já corrigida (effectiveStreak); profile traz best_streak e bandages; friends = [{ id, name }].
// cachedStreaks = lista que o app já buscou antes de abrir o painel (ou null): aparece na hora e é atualizada em segundo plano;
// onLoaded guarda a lista nova para a próxima abertura.
export function StreakSheet({ supabase, profile, streak, subscribed, friends, cachedStreaks = null, onLoaded, onClose }) {
  const t = useT();
  const bandages = profile.bandages || 0;
  const [explainOpen, setExplainOpen] = useState(false);
  const [friendsState, setFriendsState] = useState(() => {
    if (cachedStreaks) return { status: "ok", list: cachedStreaks };
    return { status: friends.length ? "loading" : "ok", list: [] };
  });

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
      if (list) {
        setFriendsState({ status: "ok", list });
        onLoaded?.(list);
      } else {
        // list = null: o SQL ainda não foi rodado (ou a busca falhou); mantém o que já estava na tela, ou mostra os amigos sem número.
        setFriendsState((s) => (s.status === "ok" && s.list.length ? s : { status: "missing", list: friends.map((f) => ({ id: f.id, name: f.name, streak: undefined })) }));
      }
    });
    return () => {
      cancelled = true;
    };
    // onLoaded só guarda a lista; não precisa refazer a busca quando ele muda.
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [supabase, friends]);

  const friendIds = new Set(friends.map((f) => f.id));
  const sorted = friendsState.list.filter((f) => friendIds.has(f.id)).sort((a, b) => (b.streak ?? -1) - (a.streak ?? -1) || a.name.localeCompare(b.name));

  // Linha em cartão, igual às opções da janela de reporte.
  const card = { display: "flex", alignItems: "center", gap: 12, width: "100%", minHeight: 48, boxSizing: "border-box", padding: "10px 14px", borderRadius: 12, border: `1px solid ${t.border}`, background: t.surfaceAlt, color: t.text, fontSize: 14, lineHeight: 1.35, textAlign: "left", fontFamily: "inherit" };
  const value = { fontSize: 14, fontWeight: 700, color: t.text, fontVariantNumeric: "tabular-nums" };

  return (
    <div
      className="modal-overlay"
      onClick={(e) => e.target === e.currentTarget && onClose()}
      style={{
        position: "fixed",
        inset: 0,
        background: t.name === "dark" ? "rgba(5,11,30,0.62)" : "rgba(30,26,60,0.4)",
        backdropFilter: "blur(3px)",
        WebkitBackdropFilter: "blur(3px)",
        display: "flex",
        alignItems: "center",
        justifyContent: "center",
        zIndex: 60,
        padding: 20,
      }}
    >
      <div
        role="dialog"
        aria-modal="true"
        aria-labelledby="streak-title"
        className="fc-sheet"
        style={{ background: t.surface, border: `1px solid ${t.border}`, borderRadius: 20, padding: "20px 20px 22px", maxWidth: 400, width: "100%", boxSizing: "border-box", boxShadow: "0 18px 50px rgba(0,0,0,0.35)" }}
      >
        <div style={{ display: "flex", alignItems: "center", gap: 12 }}>
          <span style={{ width: 40, height: 40, borderRadius: 12, background: "rgba(242,169,59,0.16)", display: "flex", alignItems: "center", justifyContent: "center", flexShrink: 0 }}>
            <Flame size={19} color={t.amber} />
          </span>
          <div style={{ flex: 1, minWidth: 0 }}>
            <h3 id="streak-title" style={{ fontSize: 17, fontWeight: 700, color: t.text, margin: 0, lineHeight: 1.25 }}>
              Sua sequência
            </h3>
            <div style={{ fontSize: 12.5, color: t.textMuted, marginTop: 2 }}>Seus números e os dos seus amigos</div>
          </div>
          <button type="button" onClick={onClose} aria-label="Fechar" style={{ width: 36, height: 36, borderRadius: "50%", background: "transparent", border: "none", cursor: "pointer", display: "flex", alignItems: "center", justifyContent: "center", flexShrink: 0, marginRight: -6 }}>
            <X size={19} color={t.textMuted} />
          </button>
        </div>

        <div style={{ display: "flex", flexDirection: "column", gap: 8, marginTop: 16 }}>
          <div style={card}>
            <Flame size={20} color={t.amber} fill={t.amber} style={{ flexShrink: 0 }} />
            <span style={{ flex: 1 }}>Sequência atual</span>
            <span style={value}>{days(streak)}</span>
          </div>
          <div style={card}>
            <Trophy size={20} color={t.amber} style={{ flexShrink: 0 }} />
            <span style={{ flex: 1 }}>Maior sequência</span>
            <span style={value}>{days(profile.best_streak || 0)}</span>
          </div>
          {/* A explicação da bandagem só aparece ao tocar nesta linha. */}
          <button
            type="button"
            onClick={() => setExplainOpen((o) => !o)}
            aria-expanded={explainOpen}
            aria-controls="bandage-explain"
            style={{ ...card, cursor: "pointer", borderColor: explainOpen ? t.primary : t.border }}
          >
            <Bandage size={20} color={bandages > 0 ? t.green : t.textMuted} style={{ flexShrink: 0 }} />
            <span style={{ flex: 1 }}>Bandagens</span>
            <span style={{ ...value, color: bandages > 0 ? t.green : t.textMuted }}>{bandages} de 1</span>
            <ChevronDown size={16} color={t.textMuted} style={{ flexShrink: 0, transform: explainOpen ? "rotate(180deg)" : "none", transition: "transform .2s" }} />
          </button>
        </div>
        {explainOpen && (
          <p id="bandage-explain" style={{ margin: "10px 2px 0", fontSize: 12.5, lineHeight: 1.55, color: t.textMuted }}>
            {subscribed
              ? "Acertando todas as questões da missão diária, você tem 50% de chance de ganhar uma bandagem. Se ficar um dia sem fazer a missão, ela salva sua sequência quando você voltar. Só cabe uma: com uma guardada, não há novo sorteio."
              : "As bandagens são para assinantes: quem assina ganha uma chance de bandagem a cada missão em que acerta todas as questões."}
          </p>
        )}

        <div style={{ fontSize: 12, fontWeight: 700, color: t.textMuted, margin: "20px 2px 8px" }}>Sequência dos amigos</div>
        {friends.length === 0 ? (
          <p style={{ margin: "0 2px", fontSize: 13, lineHeight: 1.5, color: t.textMuted }}>Adicione amigos em Minha Conta → Amigos para comparar as sequências.</p>
        ) : friendsState.status === "loading" ? (
          <p style={{ margin: "0 2px", fontSize: 13, color: t.textMuted }}>Carregando…</p>
        ) : (
          <ul style={{ listStyle: "none", margin: 0, padding: 0, display: "flex", flexDirection: "column", gap: 8 }}>
            {sorted.map((f) => (
              <li key={f.id} style={card}>
                <span aria-hidden="true" style={{ width: 28, height: 28, borderRadius: "50%", background: t.primarySoft, color: t.primary, display: "flex", alignItems: "center", justifyContent: "center", fontSize: 12, fontWeight: 700, flexShrink: 0 }}>
                  {f.name[0]}
                </span>
                <span style={{ flex: 1, minWidth: 0, overflow: "hidden", textOverflow: "ellipsis", whiteSpace: "nowrap" }}>{f.name}</span>
                {f.streak == null ? (
                  <span style={{ fontSize: 12.5, color: t.textMuted }}>—</span>
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

        <div style={{ marginTop: 18 }}>
          <PrimaryButton full variant="ghost" onClick={onClose}>
            Fechar
          </PrimaryButton>
        </div>
      </div>
    </div>
  );
}
