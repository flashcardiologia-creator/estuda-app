"use client";

import { Suspense, useEffect, useState } from "react";
import { useRouter, useSearchParams } from "next/navigation";
import { Flame, Eye, EyeOff } from "lucide-react";
import { createClient } from "@/lib/supabase/client";
import { useT } from "@/components/theme/ThemeProvider";
import { PrimaryButton } from "@/components/ui/Primitives";
import { updateDisplayName } from "@/lib/data/profile";
import { MAX_NAME_LEN, sanitizeName } from "@/lib/util";

export default function LoginPage() {
  return (
    <Suspense fallback={null}>
      <LoginForm />
    </Suspense>
  );
}

function LoginForm() {
  const t = useT();
  const router = useRouter();
  const searchParams = useSearchParams();
  const supabase = createClient();

  const [mode, setMode] = useState("login");
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [showPassword, setShowPassword] = useState(false);
  const [showConfirmPassword, setShowConfirmPassword] = useState(false);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");
  const [info, setInfo] = useState("");

  useEffect(() => {
    if (searchParams.get("error") === "link_invalido") {
      setError("Esse link de redefinição de senha é inválido ou expirou. Solicite um novo.");
    }
  }, [searchParams]);

  const inputStyle = {
    width: "100%",
    padding: "12px 14px",
    borderRadius: 12,
    border: `1px solid ${t.border}`,
    background: t.surfaceAlt,
    color: t.text,
    fontSize: 16,
    boxSizing: "border-box",
  };

  const eyeButtonStyle = {
    position: "absolute",
    right: 12,
    top: "50%",
    transform: "translateY(-50%)",
    background: "transparent",
    border: "none",
    cursor: "pointer",
    display: "flex",
    color: t.textMuted,
  };

  const submit = async (e) => {
    e.preventDefault();
    setError("");
    setInfo("");
    setLoading(true);
    try {
      if (mode === "login") {
        const { error } = await supabase.auth.signInWithPassword({ email, password });
        if (error) throw error;
        router.push("/");
        router.refresh();
      } else if (mode === "signup") {
        const trimmedName = name.trim();
        if (!trimmedName) {
          setError("Informe um nome de usuário.");
          return;
        }
        if (password !== confirmPassword) {
          setError("As senhas não coincidem.");
          return;
        }
        const { data, error } = await supabase.auth.signUp({
          email,
          password,
          options: { data: { name: trimmedName } },
        });
        if (error) throw error;
        if (data.session) {
          await updateDisplayName(supabase, data.user.id, trimmedName);
          router.push("/");
          router.refresh();
        } else {
          setInfo("Conta criada! Verifique sua caixa de entrada para confirmar o e-mail antes de entrar.");
          setMode("login");
        }
      } else {
        const { error } = await supabase.auth.resetPasswordForEmail(email, {
          redirectTo: `${window.location.origin}/auth/confirm?next=/reset-password`,
        });
        if (error) throw error;
        setInfo("Se esse e-mail tiver uma conta, enviamos um link para redefinir a senha.");
      }
    } catch (err) {
      setError(err.message || "Algo deu errado.");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div style={{ minHeight: "100vh", display: "flex", alignItems: "center", justifyContent: "center", padding: 20 }}>
      <div style={{ width: "100%", maxWidth: 380, background: t.surface, border: `1px solid ${t.border}`, borderRadius: 20, padding: 30 }}>
        <div style={{ display: "flex", flexDirection: "column", alignItems: "center", marginBottom: 24 }}>
          <Flame size={34} color={t.amber} fill={t.amber} />
          <h1 style={{ fontSize: 22, fontWeight: 700, color: t.text, marginTop: 10 }}>FlashCardio</h1>
          {mode !== "login" && (
            <p style={{ fontSize: 13, color: t.textMuted, marginTop: 4, textAlign: "center" }}>
              {mode === "signup" && "Crie sua conta gratuita"}
              {mode === "forgot" && "Informe seu e-mail para receber o link de redefinição"}
            </p>
          )}
        </div>

        <form onSubmit={submit} style={{ display: "flex", flexDirection: "column", gap: 12 }}>
          {mode === "signup" && (
            <div>
              <label style={{ fontSize: 12.5, color: t.textMuted, fontWeight: 600 }}>Nome de usuário</label>
              <input
                type="text"
                required
                maxLength={MAX_NAME_LEN}
                autoComplete="nickname"
                value={name}
                onChange={(e) => setName(sanitizeName(e.target.value))}
                style={{ ...inputStyle, marginTop: 6 }}
              />
            </div>
          )}
          <div>
            <label style={{ fontSize: 12.5, color: t.textMuted, fontWeight: 600 }}>E-mail</label>
            <input
              type="email"
              required
              autoComplete="email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              style={{ ...inputStyle, marginTop: 6 }}
            />
          </div>
          {mode !== "forgot" && (
            <div>
              <label style={{ fontSize: 12.5, color: t.textMuted, fontWeight: 600 }}>Senha</label>
              <div style={{ position: "relative", marginTop: 6 }}>
                <input
                  type={showPassword ? "text" : "password"}
                  required
                  minLength={6}
                  autoComplete={mode === "login" ? "current-password" : "new-password"}
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  style={{ ...inputStyle, paddingRight: 44 }}
                />
                <button type="button" onClick={() => setShowPassword((v) => !v)} style={eyeButtonStyle} tabIndex={-1} aria-label={showPassword ? "Ocultar senha" : "Mostrar senha"}>
                  {showPassword ? <EyeOff size={18} /> : <Eye size={18} />}
                </button>
              </div>
            </div>
          )}
          {mode === "signup" && (
            <div>
              <label style={{ fontSize: 12.5, color: t.textMuted, fontWeight: 600 }}>Confirmar senha</label>
              <div style={{ position: "relative", marginTop: 6 }}>
                <input
                  type={showConfirmPassword ? "text" : "password"}
                  required
                  minLength={6}
                  autoComplete="new-password"
                  value={confirmPassword}
                  onChange={(e) => setConfirmPassword(e.target.value)}
                  style={{ ...inputStyle, paddingRight: 44 }}
                />
                <button type="button" onClick={() => setShowConfirmPassword((v) => !v)} style={eyeButtonStyle} tabIndex={-1} aria-label={showConfirmPassword ? "Ocultar senha" : "Mostrar senha"}>
                  {showConfirmPassword ? <EyeOff size={18} /> : <Eye size={18} />}
                </button>
              </div>
            </div>
          )}

          {mode === "login" && (
            <button
              type="button"
              onClick={() => {
                setMode("forgot");
                setError("");
                setInfo("");
              }}
              style={{ alignSelf: "flex-end", background: "transparent", border: "none", color: t.textMuted, fontSize: 12.5, cursor: "pointer" }}
            >
              Esqueci minha senha
            </button>
          )}

          {error && <div style={{ fontSize: 12.5, color: t.red }}>{error}</div>}
          {info && <div style={{ fontSize: 12.5, color: t.green }}>{info}</div>}

          <div style={{ marginTop: 8 }}>
            <PrimaryButton full type="submit" disabled={loading}>
              {mode === "login" && "Entrar"}
              {mode === "signup" && "Criar conta"}
              {mode === "forgot" && "Enviar link de redefinição"}
            </PrimaryButton>
          </div>
        </form>

        <div style={{ textAlign: "center", marginTop: 18 }}>
          {mode === "forgot" ? (
            <button
              onClick={() => {
                setMode("login");
                setError("");
                setInfo("");
              }}
              style={{ background: "transparent", border: "none", color: t.primary, fontSize: 13, fontWeight: 600, cursor: "pointer" }}
            >
              Voltar para entrar
            </button>
          ) : (
            <button
              onClick={() => {
                setMode(mode === "login" ? "signup" : "login");
                setError("");
                setInfo("");
                setConfirmPassword("");
              }}
              style={{ background: "transparent", border: "none", color: t.primary, fontSize: 13, fontWeight: 600, cursor: "pointer" }}
            >
              {mode === "login" ? "Não tem conta? Cadastre-se" : "Já tem conta? Entrar"}
            </button>
          )}
        </div>
      </div>
    </div>
  );
}
