"use client";

import { useEffect, useRef, useState } from "react";
import { User, Users, Flame, BookOpen, Award, Plus, LogOut, Copy, Check, X, Trash2, BarChart3, Trophy, Shield, KeyRound, Eye, EyeOff, ChevronRight, Swords, Rocket } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { ScreenHeader, ExpandBox, PrimaryButton, Toggle, Chip } from "@/components/ui/Primitives";
import { MAX_NAME_LEN, sanitizeName } from "@/lib/util";
import { fetchFriendComparison, removeFriend } from "@/lib/data/friends";

function PasswordField({ value, onChange, placeholder, visible, onToggleVisible }) {
  const t = useT();
  return (
    <div style={{ position: "relative" }}>
      <input
        type={visible ? "text" : "password"}
        placeholder={placeholder}
        autoComplete="new-password"
        value={value}
        onChange={onChange}
        className="password-field-input"
        style={{
          width: "100%",
          padding: "10px 40px 10px 12px",
          borderRadius: 10,
          border: `1px solid ${t.border}`,
          background: t.surface,
          color: t.text,
          fontSize: 16,
          boxSizing: "border-box",
        }}
      />
      <button
        type="button"
        onClick={onToggleVisible}
        title={visible ? "Ocultar senha" : "Mostrar senha"}
        style={{
          position: "absolute",
          right: 4,
          top: "50%",
          transform: "translateY(-50%)",
          background: "transparent",
          border: "none",
          cursor: "pointer",
          padding: 8,
          display: "flex",
          color: t.textMuted,
        }}
      >
        {visible ? <EyeOff size={16} /> : <Eye size={16} />}
      </button>
    </div>
  );
}

export function AccountScreen({
  supabase,
  userId,
  userEmail,
  profile,
  stats,
  allQuestions,
  friends,
  incomingRequests,
  initialFocus,
  onFocusConsumed,
  onNavigate,
  onSaveName,
  onSaveStatsVisibility,
  onSaveRankingVisibility,
  onAddFriend,
  onRespondRequest,
  onRefreshFriends,
  onSignOut,
}) {
  const t = useT();
  const [name, setName] = useState(profile.name);
  const [nameEditing, setNameEditing] = useState(false);
  const nameInputRef = useRef(null);
  const [savingName, setSavingName] = useState(false);
  const [savingVisibility, setSavingVisibility] = useState(false);
  const [savingRankingVisibility, setSavingRankingVisibility] = useState(false);
  const [passwordFormOpen, setPasswordFormOpen] = useState(false);
  const [currentPassword, setCurrentPassword] = useState("");
  const [newPassword, setNewPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [showCurrentPassword, setShowCurrentPassword] = useState(false);
  const [showNewPassword, setShowNewPassword] = useState(false);
  const [showConfirmPassword, setShowConfirmPassword] = useState(false);
  const [changingPassword, setChangingPassword] = useState(false);
  const [passwordError, setPasswordError] = useState("");
  const [passwordSuccess, setPasswordSuccess] = useState(false);
  const [permissionsOpen, setPermissionsOpen] = useState(false);
  const [newFriend, setNewFriend] = useState("");
  const [friendError, setFriendError] = useState("");
  const [friendInfo, setFriendInfo] = useState("");
  const [addingFriend, setAddingFriend] = useState(false);
  const [respondingId, setRespondingId] = useState(null);
  const [codeCopied, setCodeCopied] = useState(false);
  const [nameSaved, setNameSaved] = useState(false);
  const [viewingFriend, setViewingFriend] = useState(null);
  const [profileOpen, setProfileOpen] = useState(false);
  const [friendsOpen, setFriendsOpen] = useState(initialFocus === "friends");

  useEffect(() => {
    if (initialFocus) onFocusConsumed?.();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  useEffect(() => {
    if (nameEditing) nameInputRef.current?.focus();
  }, [nameEditing]);

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

  const toggleRankingVisibility = async (visible) => {
    setSavingRankingVisibility(true);
    try {
      await onSaveRankingVisibility(visible);
    } finally {
      setSavingRankingVisibility(false);
    }
  };

  const changePassword = async () => {
    setPasswordError("");
    setPasswordSuccess(false);
    if (!currentPassword) {
      setPasswordError("Digite sua senha atual.");
      return;
    }
    if (newPassword.length < 6) {
      setPasswordError("A senha precisa ter pelo menos 6 caracteres.");
      return;
    }
    if (newPassword !== confirmPassword) {
      setPasswordError("As senhas não coincidem.");
      return;
    }
    setChangingPassword(true);
    try {
      const { error: signInError } = await supabase.auth.signInWithPassword({
        email: userEmail,
        password: currentPassword,
      });
      if (signInError) {
        setPasswordError("Senha atual incorreta.");
        return;
      }
      const { error } = await supabase.auth.updateUser({ password: newPassword });
      if (error) throw error;
      setPasswordSuccess(true);
      setCurrentPassword("");
      setNewPassword("");
      setConfirmPassword("");
    } catch (err) {
      setPasswordError(err.message || "Não foi possível trocar a senha.");
    } finally {
      setChangingPassword(false);
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
            { label: "Maior Sequência", value: profile.best_streak, icon: <Trophy size={16} color={t.amber} /> },
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

        <div style={{ display: "flex", gap: 8, marginBottom: 20, marginTop: -10 }}>
          <button
            onClick={() => onNavigate("stats")}
            style={{
              display: "flex",
              alignItems: "center",
              justifyContent: "center",
              gap: 6,
              flex: 1,
              background: t.name === "light" ? t.surface : "transparent",
              border: `1px solid ${t.border}`,
              borderRadius: 12,
              padding: "9px 12px",
              cursor: "pointer",
              color: t.primary,
              fontSize: 12.5,
              fontWeight: 600,
            }}
          >
            <BarChart3 size={14} /> Estatísticas
          </button>
          <button
            onClick={() => onNavigate("ranking")}
            style={{
              display: "flex",
              alignItems: "center",
              justifyContent: "center",
              gap: 6,
              flex: 1,
              background: t.name === "light" ? t.surface : "transparent",
              border: `1px solid ${t.border}`,
              borderRadius: 12,
              padding: "9px 12px",
              cursor: "pointer",
              color: t.primary,
              fontSize: 12.5,
              fontWeight: 600,
            }}
          >
            <Trophy size={14} /> Ranking
          </button>
        </div>

        <ExpandBox title="Perfil" icon={<User size={17} color={t.primary} />} open={profileOpen} onToggle={() => setProfileOpen((o) => !o)}>
          <div style={{ marginBottom: 14 }}>
            <label
              style={{
                display: "block",
                fontSize: 10.5,
                color: t.textMuted,
                fontWeight: 700,
                letterSpacing: 0.5,
                textTransform: "uppercase",
                marginBottom: 6,
              }}
            >
              Nome
            </label>
            <div style={{ display: "flex", alignItems: "center", gap: 8 }}>
              {nameEditing ? (
                <div
                  style={{
                    flex: 1,
                    minWidth: 0,
                    display: "flex",
                    alignItems: "center",
                    padding: "11px 13px",
                    borderRadius: 10,
                    border: `1px solid ${t.border}`,
                    background: t.surfaceAlt,
                    boxSizing: "border-box",
                    overflow: "hidden",
                  }}
                >
                  {/* font-size stays 16px (iOS auto-zooms focus below that); scale() shrinks it visually instead */}
                  <input
                    ref={nameInputRef}
                    value={name}
                    maxLength={MAX_NAME_LEN}
                    onChange={(e) => setName(sanitizeName(e.target.value))}
                    onBlur={() => setNameEditing(false)}
                    style={{
                      width: "114.29%",
                      border: "none",
                      outline: "none",
                      padding: 0,
                      margin: 0,
                      background: "transparent",
                      color: t.text,
                      fontSize: 16,
                      fontWeight: 600,
                      boxSizing: "border-box",
                      transform: "scale(0.875)",
                      transformOrigin: "left center",
                    }}
                  />
                </div>
              ) : (
                <button
                  type="button"
                  onClick={() => setNameEditing(true)}
                  style={{
                    flex: 1,
                    minWidth: 0,
                    textAlign: "left",
                    padding: "11px 13px",
                    borderRadius: 10,
                    border: `1px solid ${t.border}`,
                    background: t.surfaceAlt,
                    color: t.text,
                    fontSize: 14,
                    fontWeight: 600,
                    boxSizing: "border-box",
                    cursor: "text",
                  }}
                >
                  {name}
                </button>
              )}
              <PrimaryButton
                small
                onClick={saveName}
                disabled={!name.trim() || savingName}
                color={nameSaved ? t.green : undefined}
              >
                {nameSaved ? "Salvo" : "Salvar"}
              </PrimaryButton>
            </div>
          </div>

          <div style={{ marginBottom: 18 }}>
            <label
              style={{
                display: "block",
                fontSize: 10.5,
                color: t.textMuted,
                fontWeight: 700,
                letterSpacing: 0.5,
                textTransform: "uppercase",
                marginBottom: 6,
              }}
            >
              Email
            </label>
            <div
              style={{
                padding: "11px 13px",
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

          <div>
            <label
              style={{
                display: "block",
                fontSize: 10.5,
                color: t.textMuted,
                fontWeight: 700,
                letterSpacing: 0.5,
                textTransform: "uppercase",
                marginBottom: 6,
              }}
            >
              Senha
            </label>
            <div
              style={{
                padding: "12px 14px",
                borderRadius: 12,
                background: t.surfaceAlt,
                border: `1px solid ${t.border}`,
                display: "flex",
                flexDirection: "column",
                gap: 8,
              }}
            >
              {passwordFormOpen && (
                <>
                  <PasswordField
                    placeholder="Senha atual"
                    value={currentPassword}
                    onChange={(e) => setCurrentPassword(e.target.value)}
                    visible={showCurrentPassword}
                    onToggleVisible={() => setShowCurrentPassword((v) => !v)}
                  />
                  <PasswordField
                    placeholder="Nova senha"
                    value={newPassword}
                    onChange={(e) => setNewPassword(e.target.value)}
                    visible={showNewPassword}
                    onToggleVisible={() => setShowNewPassword((v) => !v)}
                  />
                  <PasswordField
                    placeholder="Confirmar nova senha"
                    value={confirmPassword}
                    onChange={(e) => setConfirmPassword(e.target.value)}
                    visible={showConfirmPassword}
                    onToggleVisible={() => setShowConfirmPassword((v) => !v)}
                  />
                  {passwordError && <div style={{ fontSize: 12, color: t.red }}>{passwordError}</div>}
                  {passwordSuccess && <div style={{ fontSize: 12, color: t.green }}>Senha alterada com sucesso.</div>}
                </>
              )}
              <PrimaryButton
                small
                onClick={() => (passwordFormOpen ? changePassword() : setPasswordFormOpen(true))}
                disabled={
                  passwordFormOpen &&
                  (!currentPassword || newPassword.length < 6 || newPassword !== confirmPassword || changingPassword)
                }
              >
                <KeyRound size={13} style={{ marginRight: 6, verticalAlign: -2 }} />
                Trocar senha
              </PrimaryButton>
            </div>
          </div>
        </ExpandBox>

        <ExpandBox
          title="Permissões"
          icon={<Shield size={17} color={t.primary} />}
          open={permissionsOpen}
          onToggle={() => setPermissionsOpen((o) => !o)}
        >
          <div
            style={{
              padding: "12px 14px",
              borderRadius: 12,
              background: t.surfaceAlt,
              border: `1px solid ${t.border}`,
              marginBottom: 12,
            }}
          >
            <Toggle
              checked={!!profile.stats_visible_to_friends}
              onChange={toggleStatsVisibility}
              label="Comparem estatísticas com você"
              labelStyle={{ fontSize: 13.5, color: t.text, fontWeight: 700 }}
              sub={
                savingVisibility
                  ? "Salvando…"
                  : "Amigos poderão ver sua sequência, questões respondidas e % de acerto"
              }
              style={{ padding: 0 }}
            />
          </div>

          <div
            style={{
              padding: "12px 14px",
              borderRadius: 12,
              background: t.surfaceAlt,
              border: `1px solid ${t.border}`,
            }}
          >
            <Toggle
              checked={!!profile.ranking_visible}
              onChange={toggleRankingVisibility}
              label="Aparecer no ranking"
              labelStyle={{ fontSize: 13.5, color: t.text, fontWeight: 700 }}
              sub={
                savingRankingVisibility
                  ? "Salvando…"
                  : "Seu nome e estatísticas aparecerão no ranking geral do app"
              }
              style={{ padding: 0 }}
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
              gap: 10,
              background: t.primarySoft,
              border: `1.5px dashed ${t.primary}`,
              borderRadius: 12,
              padding: "12px 14px",
              marginBottom: 14,
            }}
          >
            <div style={{ minWidth: 0 }}>
              <div
                style={{
                  fontSize: 8.5,
                  color: t.primary,
                  fontWeight: 700,
                  letterSpacing: 0.5,
                  textTransform: "uppercase",
                  marginBottom: 3,
                }}
              >
                Seu código de amigo
              </div>
              <div style={{ fontSize: 12, color: t.text, fontWeight: 800, letterSpacing: 1.5 }}>
                {profile.friend_code}
              </div>
            </div>
            <button
              onClick={copyCode}
              title="Copiar código"
              style={{
                display: "flex",
                alignItems: "center",
                gap: 6,
                background: codeCopied ? "transparent" : t.surface,
                border: `1px solid ${codeCopied ? t.green : t.border}`,
                borderRadius: 10,
                padding: "8px 12px",
                color: codeCopied ? t.green : t.text,
                fontSize: 12.5,
                fontWeight: 700,
                cursor: "pointer",
                flexShrink: 0,
                transition: "all .15s ease",
              }}
            >
              {codeCopied ? <Check size={14} /> : <Copy size={14} />}
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

          {friends.length > 0 && (
            <div style={{ fontSize: 11, color: t.textMuted, fontWeight: 700, marginTop: 16, marginBottom: 8 }}>
              SEUS AMIGOS
            </div>
          )}
          <div style={{ display: "flex", flexDirection: "column", gap: 8 }}>
            {friends.map((f) => (
              <button
                key={f.id}
                onClick={() => setViewingFriend(f)}
                style={{
                  width: "100%",
                  display: "flex",
                  alignItems: "center",
                  gap: 10,
                  padding: "10px 12px",
                  borderRadius: 12,
                  border: `1px solid ${t.border}`,
                  background: t.surfaceAlt,
                  cursor: "pointer",
                  textAlign: "left",
                  boxSizing: "border-box",
                }}
              >
                <div
                  style={{
                    width: 30,
                    height: 30,
                    borderRadius: "50%",
                    background: t.primarySoft,
                    display: "flex",
                    alignItems: "center",
                    justifyContent: "center",
                    fontSize: 12.5,
                    fontWeight: 700,
                    color: t.primary,
                    flexShrink: 0,
                  }}
                >
                  {f.name[0]}
                </div>
                <span style={{ fontSize: 13.5, fontWeight: 600, color: t.text, flex: 1 }}>{f.name}</span>
                <ChevronRight size={16} color={t.textMuted} style={{ flexShrink: 0 }} />
              </button>
            ))}
          </div>
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
  const [comparison, setComparison] = useState(null);
  const [loadError, setLoadError] = useState("");
  const [confirmingRemove, setConfirmingRemove] = useState(false);
  const [removing, setRemoving] = useState(false);

  useEffect(() => {
    fetchFriendComparison(supabase, friend.id)
      .then(setComparison)
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
      <div style={{ background: t.surface, border: `1px solid ${t.border}`, borderRadius: 18, padding: 22, maxWidth: 420, width: "100%" }}>
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

        {!loadError && !comparison && (
          <div style={{ fontSize: 13, color: t.textMuted, marginBottom: 16 }}>Carregando…</div>
        )}

        {comparison && (
          <div style={{ marginBottom: 20 }}>
            <div
              style={{
                display: "grid",
                gridTemplateColumns: "1fr 60px 60px",
                gap: 8,
                marginBottom: 8,
                paddingBottom: 8,
                borderBottom: `1px solid ${t.border}`,
              }}
            >
              <div />
              <div style={{ fontSize: 10.5, fontWeight: 700, color: t.textMuted, textAlign: "center" }}>Você</div>
              <div
                style={{
                  fontSize: 10.5,
                  fontWeight: 700,
                  color: t.textMuted,
                  textAlign: "center",
                  overflow: "hidden",
                  textOverflow: "ellipsis",
                  whiteSpace: "nowrap",
                }}
              >
                {comparison.friend_name}
              </div>
            </div>

            {[
              { key: "streak", label: "Sequência", icon: <Flame size={14} color={t.amber} />, my: comparison.my_streak, friend: comparison.friend_streak, format: (v) => v },
              { key: "bestStreak", label: "Maior Sequência", icon: <Trophy size={14} color={t.amber} />, my: comparison.my_best_streak, friend: comparison.friend_best_streak, format: (v) => v },
              { key: "answered", label: "Respondidas", icon: <BookOpen size={14} color={t.primary} />, my: comparison.my_answered, friend: comparison.friend_answered, format: (v) => v },
              { key: "accuracy", label: "Acerto", icon: <Award size={14} color={t.primary} />, my: comparison.my_accuracy, friend: comparison.friend_accuracy, format: (v) => `${v}%` },
              { key: "flashcards", label: "Flashcards vistos", icon: <Rocket size={14} color={t.green} />, my: comparison.my_flashcards_viewed, friend: comparison.friend_flashcards_viewed, format: (v) => v },
              { key: "challenges", label: "Desafios", icon: <Swords size={14} color={t.text} />, my: comparison.my_challenge_total, friend: comparison.friend_challenge_total, format: (v) => v },
              { key: "winPct", label: "Vitórias em desafios", icon: <Trophy size={14} color={t.text} />, my: comparison.my_challenge_win_pct, friend: comparison.friend_challenge_win_pct, format: (v) => `${v}%` },
            ].map((s) => {
              const friendKnown = comparison.friend_authorized && s.friend !== null;
              const myWins = friendKnown && s.my > s.friend;
              const friendWins = friendKnown && s.friend > s.my;
              return (
                <div
                  key={s.key}
                  style={{
                    display: "grid",
                    gridTemplateColumns: "1fr 60px 60px",
                    gap: 8,
                    alignItems: "center",
                    padding: "8px 0",
                    borderBottom: `1px solid ${t.border}`,
                  }}
                >
                  <div style={{ display: "flex", alignItems: "center", gap: 6, fontSize: 12, color: t.textMuted, fontWeight: 600 }}>
                    {s.icon}
                    {s.label}
                  </div>
                  <div
                    style={{
                      textAlign: "center",
                      fontSize: 14,
                      fontWeight: myWins ? 800 : 600,
                      color: myWins ? t.primary : t.text,
                    }}
                  >
                    {s.format(s.my)}
                  </div>
                  <div
                    style={{
                      textAlign: "center",
                      fontSize: friendKnown ? 14 : 10,
                      fontWeight: friendWins ? 800 : 600,
                      color: friendKnown ? (friendWins ? t.primary : t.text) : t.red,
                    }}
                  >
                    {friendKnown ? s.format(s.friend) : "—"}
                  </div>
                </div>
              );
            })}

            {!comparison.friend_authorized && (
              <div style={{ fontSize: 11.5, color: t.textMuted, textAlign: "center", marginTop: 10 }}>
                {friend.name} não autorizou compartilhar estatísticas com amigos.
              </div>
            )}
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
