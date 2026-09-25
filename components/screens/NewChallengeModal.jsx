"use client";

import { useEffect, useRef, useState } from "react";
import { Swords, Users, BookOpen, ListChecks, X, ChevronDown } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { PrimaryButton, SectionLabel } from "@/components/ui/Primitives";

export function NewChallengeModal({ friends, temas, onCreate, onClose }) {
  const t = useT();
  const [friendId, setFriendId] = useState(friends[0]?.id || "");
  const [tema, setTema] = useState(temas[0] || "");
  const [qtd, setQtd] = useState(5);
  const [creating, setCreating] = useState(false);
  const [error, setError] = useState("");
  const [friendMenuOpen, setFriendMenuOpen] = useState(false);
  const friendFieldRef = useRef(null);

  const selectedFriend = friends.find((f) => f.id === friendId) || null;

  useEffect(() => {
    if (!friendMenuOpen) return;
    const handleClickOutside = (e) => {
      if (friendFieldRef.current && !friendFieldRef.current.contains(e.target)) {
        setFriendMenuOpen(false);
      }
    };
    document.addEventListener("mousedown", handleClickOutside);
    return () => document.removeEventListener("mousedown", handleClickOutside);
  }, [friendMenuOpen]);

  const criar = async () => {
    setCreating(true);
    setError("");
    try {
      await onCreate(friendId, tema, qtd);
    } catch (err) {
      setError(err.message || "Não foi possível criar o desafio.");
    } finally {
      setCreating(false);
    }
  };

  return (
    <div style={{ position: "fixed", inset: 0, background: "rgba(0,0,0,0.55)", display: "flex", alignItems: "center", justifyContent: "center", zIndex: 50, padding: 20 }}>
      <div style={{ background: t.surface, border: `1px solid ${t.border}`, borderRadius: 20, padding: 24, maxWidth: 400, width: "100%" }}>
        <div style={{ display: "flex", alignItems: "center", justifyContent: "space-between", marginBottom: 20 }}>
          <div style={{ display: "flex", alignItems: "center", gap: 10 }}>
            <div style={{ width: 34, height: 34, borderRadius: 10, background: t.primarySoft, display: "flex", alignItems: "center", justifyContent: "center", flexShrink: 0 }}>
              <Swords size={17} color={t.primary} />
            </div>
            <h3 style={{ fontSize: 17, fontWeight: 700, color: t.text, margin: 0 }}>Novo Desafio</h3>
          </div>
          <button
            onClick={onClose}
            aria-label="Fechar"
            style={{ width: 30, height: 30, borderRadius: 9, border: `1px solid ${t.border}`, background: "transparent", color: t.textMuted, display: "flex", alignItems: "center", justifyContent: "center", cursor: "pointer", flexShrink: 0 }}
          >
            <X size={15} />
          </button>
        </div>

        <div style={{ marginBottom: 18, position: "relative" }} ref={friendFieldRef}>
          <SectionLabel icon={<Users size={13} />}>Amigo</SectionLabel>
          <button
            onClick={() => setFriendMenuOpen((v) => !v)}
            style={{
              width: "100%",
              display: "flex",
              alignItems: "center",
              gap: 10,
              padding: "9px 12px",
              borderRadius: 12,
              border: `1.5px solid ${friendMenuOpen ? t.primary : t.border}`,
              background: t.surfaceAlt,
              cursor: "pointer",
              textAlign: "left",
              boxSizing: "border-box",
            }}
          >
            {selectedFriend ? (
              <>
                <div
                  style={{
                    width: 24,
                    height: 24,
                    borderRadius: "50%",
                    background: t.primarySoft,
                    display: "flex",
                    alignItems: "center",
                    justifyContent: "center",
                    fontSize: 11,
                    fontWeight: 700,
                    color: t.primary,
                    flexShrink: 0,
                  }}
                >
                  {selectedFriend.name[0]}
                </div>
                <span style={{ flex: 1, fontSize: 13.5, fontWeight: 600, color: t.text }}>{selectedFriend.name}</span>
              </>
            ) : (
              <span style={{ flex: 1, fontSize: 13.5, color: t.textMuted }}>Selecione um amigo</span>
            )}
            <ChevronDown
              size={16}
              color={t.textMuted}
              style={{ transform: friendMenuOpen ? "rotate(180deg)" : "none", transition: "transform .15s", flexShrink: 0 }}
            />
          </button>

          {friendMenuOpen && (
            <div
              style={{
                position: "absolute",
                top: "calc(100% + 6px)",
                left: 0,
                right: 0,
                zIndex: 5,
                background: t.surface,
                border: `1px solid ${t.border}`,
                borderRadius: 12,
                boxShadow: "0 10px 30px rgba(0,0,0,0.45)",
                maxHeight: 216,
                overflowY: "auto",
                padding: 6,
              }}
            >
              {friends.map((f) => {
                const active = friendId === f.id;
                return (
                  <button
                    key={f.id}
                    onClick={() => {
                      setFriendId(f.id);
                      setFriendMenuOpen(false);
                    }}
                    style={{
                      width: "100%",
                      display: "flex",
                      alignItems: "center",
                      gap: 10,
                      padding: "8px 10px",
                      borderRadius: 9,
                      border: "none",
                      background: active ? t.primarySoft : "transparent",
                      cursor: "pointer",
                      textAlign: "left",
                      boxSizing: "border-box",
                    }}
                  >
                    <div
                      style={{
                        width: 24,
                        height: 24,
                        borderRadius: "50%",
                        background: active ? "rgba(255,255,255,0.16)" : t.primarySoft,
                        display: "flex",
                        alignItems: "center",
                        justifyContent: "center",
                        fontSize: 11,
                        fontWeight: 700,
                        color: t.primary,
                        flexShrink: 0,
                      }}
                    >
                      {f.name[0]}
                    </div>
                    <span style={{ fontSize: 13.5, fontWeight: 600, color: active ? t.primary : t.text }}>{f.name}</span>
                  </button>
                );
              })}
            </div>
          )}
        </div>

        <div style={{ marginBottom: 18 }}>
          <SectionLabel icon={<BookOpen size={13} />}>Tema</SectionLabel>
          <div style={{ display: "grid", gridTemplateColumns: "1fr 1fr", gap: 6 }}>
            {temas.map((tm) => {
              const active = tema === tm;
              return (
                <button
                  key={tm}
                  onClick={() => setTema(tm)}
                  style={{
                    padding: "9px 10px",
                    borderRadius: 12,
                    border: `1.5px solid ${active ? t.primary : t.border}`,
                    background: active ? t.primarySoft : t.surfaceAlt,
                    color: active ? t.primary : t.text,
                    fontSize: 13,
                    fontWeight: 600,
                    cursor: "pointer",
                    textAlign: "center",
                    transition: "all .15s ease",
                  }}
                >
                  {tm}
                </button>
              );
            })}
          </div>
        </div>

        <div style={{ marginBottom: 22 }}>
          <SectionLabel icon={<ListChecks size={13} />}>Questões</SectionLabel>
          <div style={{ display: "grid", gridTemplateColumns: "1fr 1fr", gap: 8 }}>
            {[5, 10].map((n) => {
              const active = qtd === n;
              return (
                <button
                  key={n}
                  onClick={() => setQtd(n)}
                  style={{
                    padding: "12px 10px",
                    borderRadius: 12,
                    border: `1.5px solid ${active ? t.primary : t.border}`,
                    background: active ? t.primarySoft : t.surfaceAlt,
                    cursor: "pointer",
                    textAlign: "center",
                    transition: "all .15s ease",
                  }}
                >
                  <div style={{ fontSize: 20, fontWeight: 700, color: active ? t.primary : t.text, lineHeight: 1.1 }}>{n}</div>
                  <div style={{ fontSize: 11, color: active ? t.primary : t.textMuted, marginTop: 2 }}>questões</div>
                </button>
              );
            })}
          </div>
        </div>

        {error && <div style={{ fontSize: 12.5, color: t.red, marginBottom: 14 }}>{error}</div>}

        <div style={{ display: "flex", gap: 10 }}>
          <div style={{ flex: 1 }}>
            <PrimaryButton variant="ghost" full onClick={onClose}>
              Cancelar
            </PrimaryButton>
          </div>
          <div style={{ flex: 1 }}>
            <PrimaryButton full disabled={!friendId || !tema || creating} onClick={criar}>
              Desafiar
            </PrimaryButton>
          </div>
        </div>
      </div>
    </div>
  );
}
