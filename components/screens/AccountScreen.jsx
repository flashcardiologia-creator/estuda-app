"use client";

import { useEffect, useState } from "react";
import { User, Users, Flame, BookOpen, Award, Plus, LogOut, Copy, Check, X, Trash2, Save } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { ScreenHeader, ExpandBox, PrimaryButton, Toggle } from "@/components/ui/Primitives";
import { MAX_NAME_LEN, sanitizeName } from "@/lib/util";
import { fetchFriendStats, removeFriend } from "@/lib/data/friends";

export function AccountScreen({
  supabase,
  userEmail,
  profile,
  stats,
  friends,
  incomingRequests,
  initialFocus,
  onFocusConsumed,
  onNavigate,
  onSaveName,
  onSaveStatsVisibility,
  onAddFriend,
  onRespondRequest,
  onRefreshFriends,
  onSignOut,
}) {
  const t = useT();
  const [name, setName] = useState(profile.name);
  const [savingName, setSavingName] = useState(false);
  const [savingVisibility, setSavingVisibility] = useState(false);
  const [newFriend, setNewFriend] = useState("");
  const [friendError, setFriendError] = useState("");
  const [friendInfo, setFriendInfo] = useState("");
  const [addingFriend, setAddingFriend] = useState(false);
  const [respondingId, setRespondingId] = useState(null);
  const [codeCopied, setCodeCopied] = useState(false);
  const [nameSaved, setNameSaved] = useState(false);
  const [viewingFriend, setViewingFriend] = useState(null);
  const [profileOpen, setProfileOpen] = useState(initialFocus !== "friends");
  const [friendsOpen, setFriendsOpen] = useState(true);

  useEffect(() => {
    if (initialFocus) onFocusConsumed?.();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const copyCode = async () => {
    try {
      await navigator.clipboard.writeText(profile.friend_code);
      setCodeCopied(true);
      setTimeout(() => setCodeCopied(false), 1500);
    } catch {
      // clipboard indisponível — ignora, o código já está visível na tela
    }
  };

  const toggleStatsVisibility = async (visible) => {
    setSavingVisibility(true);
    try {
      await onSaveStatsVisibility(visible);
    } finally {
      setSavingVisibility(false);
    }
  };

  const saveName = async () => {
    const v = sanitizeName(name).trim();
    if (!v) return;
    setSavingName(true);
    try {
      await onSaveName(v);
      setNameSaved(true);
      setTimeout(() => setNameSaved(false), 1500);
    } finally {
      setSavingName(false);
    }
  };

  const addFriend = async () => {
    const v = sanitizeName(newFriend).trim();
    if (!v) return;
    setAddingFriend(true);
    setFriendError("");
    setFriendInfo("");
    try {
      const result = await onAddFriend(v);
      setFriendInfo(
        result.status === "accepted"
          ? `Vocês agora são amigos!`
          : `Pedido de amizade enviado para ${result.friend.name}.`
      );
      setNewFriend("");
    } catch (err) {
      setFriendError(err.message || "Não foi possível adicionar.");
    } finally {
      setAddingFriend(false);
    }
  };

  const respondRequest = async (requesterId, accept) => {
    setRespondingId(requesterId);
    try {
      await onRespondRequest(requesterId, accept);
    } finally {
      setRespondingId(null);
    }
  };

  return (
    <div style={{ maxWidth: 640, margin: "0 auto", paddingBottom: 60 }}>
      <ScreenHeader title="Minha Conta" onBack={() => onNavigate("home")} />
      <div style={{ padding: "18px 22px" }}>
        <div style={{ display: "grid", gridTemplateColumns: "repeat(3, 1fr)", gap: 10, marginBottom: 24, marginTop: 20 }}>
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

        <ExpandBox title="Perfil" icon={<User size={17} color={t.primary} />} open={profileOpen} onToggle={() => setProfileOpen((o) => !o)}>
          <div style={{ display: "flex", alignItems: "center", gap: 8 }}>
            <label style={{ width: 48, flexShrink: 0, fontSize: 12.5, color: t.textMuted, fontWeight: 600 }}>Nome</label>
            <input
              value={name}
              maxLength={MAX_NAME_LEN}
              onChange={(e) => setName(sanitizeName(e.target.value))}
              style={{
                flex: 1,
                minWidth: 0,
                padding: "10px 12px",
                borderRadius: 10,
                border: `1px solid ${t.border}`,
                background: t.surfaceAlt,
                color: t.text,
                fontSize: 16,
                boxSizing: "border-box",
              }}
            />
            <button
              onClick={saveName}
              disabled={!name.trim() || savingName}
              title="Salvar nome"
              style={{
                display: "flex",
                alignItems: "center",
                gap: 6,
                background: "transparent",
                border: `1px solid ${t.border}`,
                borderRadius: 8,
                padding: "6px 10px",
                color: nameSaved ? t.green : t.textMuted,
                fontSize: 12,
                fontWeight: 600,
                cursor: !name.trim() || savingName ? "default" : "pointer",
                opacity: !name.trim() || savingName ? 0.6 : 1,
                flexShrink: 0,
              }}
            >
              {nameSaved ? <Check size={13} /> : <Save size={13} />}
              {nameSaved ? "Salvo" : "Salvar"}
            </button>
          </div>

          <div style={{ display: "flex", alignItems: "center", gap: 8, marginTop: 12 }}>
            <label style={{ width: 48, flexShrink: 0, fontSize: 12.5, color: t.textMuted, fontWeight: 600 }}>Email</label>
            <div
              style={{
                flex: 1,
                minWidth: 0,
                padding: "10px 12px",
                borderRadius: 10,
                border: `1px solid ${t.border}`,
                background: t.surfaceAlt,
                color: t.textMuted,
                fontSize: 14,
                boxSizing: "border-box",
              }}
            >
              {userEmail}
            </div>
          </div>

          <div style={{ marginTop: 16, paddingTop: 14, borderTop: `1px solid ${t.border}` }}>
            <Toggle
              checked={!!profile.stats_visible_to_friends}
              onChange={toggleStatsVisibility}
              label="Permitir que vejam suas estatísticas"
              labelStyle={{ fontSize: 12.5, color: t.textMuted, fontWeight: 600 }}
              sub={savingVisibility ? "Salvando…" : undefined}
              style={{ padding: "6px 0" }}
            />
          </div>
        </ExpandBox>

        <ExpandBox
          title="Amigos"
          icon={<Users size={17} color={t.primary} />}
          open={friendsOpen}
          onToggle={() => setFriendsOpen((o) => !o)}
          badge={friends.length}
        >
          <div
            style={{
              display: "flex",
              alignItems: "center",
              justifyContent: "space-between",
              gap: 8,
              background: t.surfaceAlt,
              border: `1px solid ${t.border}`,
              borderRadius: 10,
              padding: "10px 12px",
              marginBottom: 12,
            }}
          >
            <div style={{ display: "flex", alignItems: "center", gap: 8 }}>
              <span style={{ fontSize: 11, color: t.textMuted, fontWeight: 600 }}>Seu código</span>
              <span style={{ fontSize: 12.5, color: t.text, fontWeight: 700, letterSpacing: 0.5 }}>{profile.friend_code}</span>
            </div>
            <button
              onClick={copyCode}
              title="Copiar código"
              style={{
                display: "flex",
                alignItems: "center",
                gap: 6,
                background: "transparent",
                border: `1px solid ${t.border}`,
                borderRadius: 8,
                padding: "6px 10px",
                color: codeCopied ? t.green : t.textMuted,
                fontSize: 12,
                fontWeight: 600,
                cursor: "pointer",
              }}
            >
              {codeCopied ? <Check size={13} /> : <Copy size={13} />}
              {codeCopied ? "Copiado" : "Copiar"}
            </button>
          </div>
          <div style={{ display: "flex", gap: 8, marginBottom: 8 }}>
            <input
              value={newFriend}
              maxLength={MAX_NAME_LEN}
              onChange={(e) => setNewFriend(sanitizeName(e.target.value))}
              placeholder="Nome exato ou código do amigo"
              className="friend-search-input"
              style={{
                flex: 1,
                padding: "9px 12px",
                borderRadius: 10,
                border: `1px solid ${t.border}`,
                background: t.surfaceAlt,
                color: t.text,
                fontSize: 16,
              }}
            />
            <PrimaryButton small disabled={!newFriend.trim() || addingFriend} onClick={addFriend}>
              <Plus size={14} />
            </PrimaryButton>
          </div>
          {friendError && (
            <div style={{ fontSize: 12, color: t.red, marginBottom: 8 }}>{friendError}</div>
          )}
          {friendInfo && (
            <div style={{ fontSize: 12, color: t.green, marginBottom: 8 }}>{friendInfo}</div>
          )}

          {incomingRequests.length > 0 && (
            <div style={{ marginBottom: 14 }}>
              <div style={{ fontSize: 11, color: t.textMuted, fontWeight: 700, marginBottom: 8 }}>
                PEDIDOS RECEBIDOS
              </div>
              <div style={{ display: "flex", flexDirection: "column", gap: 8 }}>
                {incomingRequests.map((r) => (
                  <div
                    key={r.id}
                    style={{
                      display: "flex",
                      alignItems: "center",
                      gap: 8,
                      background: t.surfaceAlt,
                      border: `1px solid ${t.border}`,
                      borderRadius: 10,
                      padding: "8px 10px",
                    }}
                  >
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
                        flexShrink: 0,
                      }}
                    >
                      {r.name[0]}
                    </div>
                    <span style={{ fontSize: 13.5, color: t.text, flex: 1 }}>{r.name}</span>
                    <button
                      onClick={() => respondRequest(r.id, false)}
                      disabled={respondingId === r.id}
                      title="Recusar"
                      style={{
                        background: "transparent",
                        border: `1px solid ${t.border}`,
                        borderRadius: 8,
                        padding: "6px 8px",
                        cursor: "pointer",
                        color: t.textMuted,
                      }}
                    >
                      <X size={14} />
                    </button>
                    <button
                      onClick={() => respondRequest(r.id, true)}
                      disabled={respondingId === r.id}
                      title="Aceitar"
                      style={{
                        background: t.green,
                        border: "none",
                        borderRadius: 8,
                        padding: "6px 8px",
                        cursor: "pointer",
                        color: "#fff",
                        display: "flex",
                        alignItems: "center",
                      }}
                    >
                      <Check size={14} />
                    </button>
                  </div>
                ))}
              </div>
            </div>
          )}

          {friends.map((f) => (
            <button
              key={f.id}
              onClick={() => setViewingFriend(f)}
              style={{
                width: "100%",
                display: "flex",
                alignItems: "center",
                gap: 8,
                padding: "8px 0",
                borderTop: `1px solid ${t.border}`,
                borderLeft: "none",
                borderRight: "none",
                borderBottom: "none",
                background: "transparent",
                cursor: "pointer",
                textAlign: "left",
              }}
            >
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
                  flexShrink: 0,
                }}
              >
                {f.name[0]}
              </div>
              <span style={{ fontSize: 13.5, color: t.text }}>{f.name}</span>
            </button>
          ))}
        </ExpandBox>

        <div style={{ marginTop: 20 }}>
          <PrimaryButton full variant="ghost" onClick={onSignOut}>
            <LogOut size={15} style={{ marginRight: 6 }} /> Sair da conta
          </PrimaryButton>
        </div>
      </div>

      {viewingFriend && (
        <FriendDetailModal
          supabase={supabase}
          friend={viewingFriend}
          onClose={() => setViewingFriend(null)}
          onRemoved={async () => {
            setViewingFriend(null);
            await onRefreshFriends();
          }}
        />
      )}
    </div>
  );
}

function FriendDetailModal({ supabase, friend, onClose, onRemoved }) {
  const t = useT();
  const [friendStats, setFriendStats] = useState(null);
  const [loadError, setLoadError] = useState("");
  const [confirmingRemove, setConfirmingRemove] = useState(false);
  const [removing, setRemoving] = useState(false);

  useEffect(() => {
    fetchFriendStats(supabase, friend.id)
      .then(setFriendStats)
      .catch((err) => setLoadError(err.message || "Não foi possível carregar as estatísticas."));
  }, [supabase, friend.id]);

  const handleRemove = async () => {
    setRemoving(true);
    try {
      await removeFriend(supabase, friend.id);
      await onRemoved();
    } finally {
      setRemoving(false);
    }
  };

  return (
    <div style={{ position: "fixed", inset: 0, background: "rgba(0,0,0,0.5)", display: "flex", alignItems: "center", justifyContent: "center", zIndex: 50, padding: 20 }}>
      <div style={{ background: t.surface, border: `1px solid ${t.border}`, borderRadius: 18, padding: 22, maxWidth: 380, width: "100%" }}>
        <div style={{ display: "flex", alignItems: "center", justifyContent: "space-between", marginBottom: 18 }}>
          <div style={{ display: "flex", alignItems: "center", gap: 10 }}>
            <div
              style={{
                width: 36,
                height: 36,
                borderRadius: "50%",
                background: t.primarySoft,
                display: "flex",
                alignItems: "center",
                justifyContent: "center",
                fontSize: 14,
                fontWeight: 700,
                color: t.primary,
              }}
            >
              {friend.name[0]}
            </div>
            <h3 style={{ fontSize: 17, color: t.text, margin: 0 }}>{friend.name}</h3>
          </div>
          <button onClick={onClose} style={{ background: "transparent", border: "none", cursor: "pointer", padding: 4 }}>
            <X size={18} color={t.textMuted} />
          </button>
        </div>

        {loadError && <div style={{ fontSize: 13, color: t.red, marginBottom: 16 }}>{loadError}</div>}

        {!loadError && !friendStats && (
          <div style={{ fontSize: 13, color: t.textMuted, marginBottom: 16 }}>Carregando…</div>
        )}

        {friendStats && (
          <div style={{ display: "grid", gridTemplateColumns: "repeat(3, 1fr)", gap: 10, marginBottom: 20 }}>
            {[
              { label: "Sequência", value: friendStats.streak, icon: <Flame size={15} color={t.amber} /> },
              { label: "Respondidas", value: friendStats.answered, icon: <BookOpen size={15} color={t.primary} /> },
              { label: "Acerto", value: `${friendStats.accuracy}%`, icon: <Award size={15} color={t.green} /> },
            ].map((s) => (
              <div key={s.label} style={{ background: t.surfaceAlt, border: `1px solid ${t.border}`, borderRadius: 12, padding: 12 }}>
                <div style={{ display: "flex", alignItems: "center", gap: 5, marginBottom: 5 }}>
                  {s.icon}
                  <span style={{ fontSize: 10.5, color: t.textMuted, fontWeight: 600 }}>{s.label}</span>
                </div>
                {friendStats.authorized ? (
                  <div style={{ fontSize: 17, fontWeight: 700, color: t.text }}>{s.value}</div>
                ) : (
                  <div style={{ fontSize: 8.5, fontWeight: 700, color: t.red, whiteSpace: "nowrap" }}>Não autorizado</div>
                )}
              </div>
            ))}
          </div>
        )}

        {!confirmingRemove ? (
          <PrimaryButton full variant="ghost" onClick={() => setConfirmingRemove(true)}>
            <Trash2 size={14} style={{ marginRight: 6 }} /> Remover amigo
          </PrimaryButton>
        ) : (
          <div>
            <div style={{ fontSize: 12.5, color: t.textMuted, marginBottom: 10, textAlign: "center" }}>
              Remover {friend.name} da sua lista de amigos?
            </div>
            <div style={{ display: "flex", gap: 10, justifyContent: "center" }}>
              <PrimaryButton variant="ghost" onClick={() => setConfirmingRemove(false)}>
                Cancelar
              </PrimaryButton>
              <PrimaryButton color={t.red} disabled={removing} onClick={handleRemove}>
                Remover
              </PrimaryButton>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}
