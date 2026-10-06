"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import Link from "next/link";
import { KeyRound, Eye, EyeOff } from "lucide-react";
import { createClient } from "@/lib/supabase/client";
import { useT } from "@/components/theme/ThemeProvider";
import { PrimaryButton } from "@/components/ui/Primitives";

export default function ResetPasswordPage() {
  const t = useT();
  const router = useRouter();
  const [supabase] = useState(() => createClient());

  const [ready, setReady] = useState(false);
  const [linkInvalid, setLinkInvalid] = useState(false);
  const [password, setPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [showPassword, setShowPassword] = useState(false);
  const [showConfirmPassword, setShowConfirmPassword] = useState(false);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");
  const [done, setDone] = useState(false);

  useEffect(() => {
    // O código de recuperação já foi trocado por sessão em /auth/confirm —
    // aqui só confirmamos que a sessão existe antes de liberar o formulário.
    supabase.auth.getSession().then(({ data: { session } }) => {
      if (!session) setLinkInvalid(true);
      setReady(true);
    });
  }, [supabase]);

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
    if (password.length < 6) {
      setError("A senha precisa ter pelo menos 6 caracteres.");
      return;
    }
    if (password !== confirmPassword) {
      setError("As senhas não coincidem.");
      return;
    }
    setLoading(true);
    try {
      const { error } = await supabase.auth.updateUser({ password });
      if (error) throw error;
      setDone(true);
      setTimeout(() => {
        router.push("/");
        router.refresh();
      }, 1500);
    } catch (err) {
      setError(err.message || "Algo deu errado.");
    } finally {
      setLoading(false);
    }
  };

  if (!ready) return null;

  return (
    <div style={{ minHeight: "calc(100vh / var(--z, 1))", display: "flex", alignItems: "center", justifyContent: "center", padding: 20 }}>
      <div style={{ width: "100%", maxWidth: 380, background: t.surface, border: `1px solid ${t.border}`, borderRadius: 20, padding: 30 }}>
        <div style={{ display: "flex", flexDirection: "column", alignItems: "center", marginBottom: 24 }}>
          <KeyRound size={30} color={t.primary} />
          <h1 style={{ fontSize: 20, fontWeight: 700, color: t.text, marginTop: 10 }}>Nova senha</h1>
        </div>

        {linkInvalid ? (
          <div style={{ textAlign: "center" }}>
            <div style={{ fontSize: 13.5, color: t.red, marginBottom: 16 }}>
              Link inválido ou expirado. Solicite a recuperação de senha novamente.
            </div>
            <Link href="/login" style={{ color: t.primary, fontSize: 13, fontWeight: 600 }}>
              Voltar para entrar
            </Link>
          </div>
        ) : done ? (
          <div style={{ textAlign: "center", fontSize: 13.5, color: t.green }}>
            Senha alterada! Redirecionando…
          </div>
        ) : (
          <form onSubmit={submit} style={{ display: "flex", flexDirection: "column", gap: 12 }}>
            <div>
              <label style={{ fontSize: 12.5, color: t.textMuted, fontWeight: 600 }}>Nova senha</label>
              <div style={{ position: "relative", marginTop: 6 }}>
                <input
                  type={showPassword ? "text" : "password"}
                  required
                  minLength={6}
                  autoComplete="new-password"
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  style={{ ...inputStyle, paddingRight: 44 }}
                />
                <button type="button" onClick={() => setShowPassword((v) => !v)} style={eyeButtonStyle} tabIndex={-1} aria-label={showPassword ? "Ocultar senha" : "Mostrar senha"}>
                  {showPassword ? <EyeOff size={18} /> : <Eye size={18} />}
                </button>
              </div>
            </div>
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

            {error && <div style={{ fontSize: 12.5, color: t.red }}>{error}</div>}

            <div style={{ marginTop: 8 }}>
              <PrimaryButton full type="submit" disabled={loading}>
                Salvar nova senha
              </PrimaryButton>
            </div>
          </form>
        )}
      </div>
    </div>
  );
}
