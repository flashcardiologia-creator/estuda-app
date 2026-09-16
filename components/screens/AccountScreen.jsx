"use client";

import { useState } from "react";
import { User, Users, Flame, BookOpen, Award, Plus, LogOut } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { BackBar, ExpandBox, PrimaryButton, Chip } from "@/components/ui/Primitives";
import { MAX_NAME_LEN, sanitizeName } from "@/lib/util";

export function AccountScreen({
  profile,
  stats,
  friends,
  onNavigate,
  onSaveName,
  onAddFriend,
  onSignOut,
}) {
  const t = useT();
  const [name, setName] = useState(profile.name);
  const [savingName, setSavingName] = useState(false);
  const [newFriend, setNewFriend] = useState("");
  const [friendError, setFriendError] = useState("");
  const [addingFriend, setAddingFriend] = useState(false);

  const saveName = async () => {
    const v = sanitizeName(name);
    if (!v) return;
    setSavingName(true);
    try {
      await onSaveName(v);
    } finally {
      setSavingName(false);
    }
  };

  const addFriend = async () => {
    const v = sanitizeName(newFriend);
    if (!v) return;
    setAddingFriend(true);
    setFriendError("");
    try {
      await onAddFriend(v);
      setNewFriend("");
    } catch (err) {
      setFriendError(err.message || "Não foi possível adicionar.");
    } finally {
      setAddingFriend(false);
    }
  };

  return (
    <div style={{ maxWidth: 640, margin: "0 auto", paddingBottom: 60 }}>
      <BackBar onBack={() => onNavigate("home")} />
      <div style={{ padding: "18px 22px" }}>
        <h2 style={{ fontSize: 24, color: t.text, margin: "0 0 20px" }}>Minha Conta</h2>

        <div style={{ display: "grid", gridTemplateColumns: "repeat(3, 1fr)", gap: 10, marginBottom: 24 }}>
          {[
            { label: "Sequência", value: profile.streak, icon: <Flame size={16} color={t.amber} /> },
            { label: "Respondidas", value: stats.answered, icon: <BookOpen size={16} color={t.primary} /> },
            { label: "Acerto", value: `${stats.accuracy}%`, icon: <Award size={16} color={t.green} /> },
          ].map((s) => (
            <div key={s.label} style={{ background: t.surface, border: `1px solid ${t.border}`, borderRadius: 14, padding: 14 }}>
              <div style={{ display: "flex", alignItems: "center", gap: 6, marginBottom: 6 }}>
                {s.icon}
                <span style={{ fontSize: 11.5, color: t.textMuted, fontWeight: 600 }}>{s.label}</span>
              </div>
              <div style={{ fontSize: 20, fontWeight: 700, color: t.text }}>{s.value}</div>
            </div>
          ))}
        </div>

        <ExpandBox title="Perfil" icon={<User size={17} color={t.primary} />} open onToggle={() => {}}>
          <label style={{ fontSize: 12.5, color: t.textMuted, fontWeight: 600 }}>Nome de exibição</label>
          <input
            value={name}
            maxLength={MAX_NAME_LEN}
            onChange={(e) => setName(sanitizeName(e.target.value))}
            style={{
              width: "100%",
              marginTop: 6,
              padding: "10px 12px",
              borderRadius: 10,
              border: `1px solid ${t.border}`,
              background: t.surfaceAlt,
              color: t.text,
              fontSize: 14,
              boxSizing: "border-box",
            }}
          />
          <div style={{ marginTop: 12 }}>
            <PrimaryButton small disabled={!name.trim() || savingName} onClick={saveName}>
              Salvar
            </PrimaryButton>
          </div>
        </ExpandBox>

        <ExpandBox title="Amigos" icon={<Users size={17} color={t.primary} />} open onToggle={() => {}} badge={friends.length}>
          <div style={{ display: "flex", gap: 8, marginBottom: 8 }}>
            <input
              value={newFriend}
              maxLength={MAX_NAME_LEN}
              onChange={(e) => setNewFriend(sanitizeName(e.target.value))}
              placeholder="Nome do amigo"
              style={{
                flex: 1,
                padding: "9px 12px",
                borderRadius: 10,
                border: `1px solid ${t.border}`,
                background: t.surfaceAlt,
                color: t.text,
                fontSize: 13.5,
              }}
            />
            <PrimaryButton small disabled={!newFriend.trim() || addingFriend} onClick={addFriend}>
              <Plus size={14} />
            </PrimaryButton>
          </div>
          {friendError && (
            <div style={{ fontSize: 12, color: t.red, marginBottom: 8 }}>{friendError}</div>
          )}
          {friends.map((f) => (
            <div key={f.id} style={{ display: "flex", alignItems: "center", gap: 8, padding: "8px 0", borderTop: `1px solid ${t.border}` }}>
              <div
                style={{
                  width: 26,
                  height: 26,
                  borderRadius: "50%",
                  background: t.primarySoft,
                  display: "flex",
                  alignItems: "center",
                  justifyContent: "center",
                  fontSize: 11,
                  fontWeight: 700,
                  color: t.primary,
                }}
              >
                {f.name[0]}
              </div>
              <span style={{ fontSize: 13.5, color: t.text }}>{f.name}</span>
            </div>
          ))}
        </ExpandBox>

        <div style={{ marginTop: 20 }}>
          <PrimaryButton full variant="ghost" onClick={onSignOut}>
            <LogOut size={15} style={{ marginRight: 6 }} /> Sair da conta
          </PrimaryButton>
        </div>
      </div>
    </div>
  );
}
