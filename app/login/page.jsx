"use client";

import { Suspense, useEffect, useState } from "react";
import { useRouter, useSearchParams } from "next/navigation";
import { Flame, Eye, EyeOff, Smartphone, ChevronLeft } from "lucide-react";
import { InstallGuide } from "@/components/screens/InstallGuide";
import { SwipeBack } from "@/components/SwipeBack";
import { createClient } from "@/lib/supabase/client";
import { useT } from "@/components/theme/ThemeProvider";
import { PrimaryButton } from "@/components/ui/Primitives";
import { updateDisplayName } from "@/lib/data/profile";
import { MAX_NAME_LEN, sanitizeName } from "@/lib/util";
import { sendTermsAcceptance } from "@/lib/legal/client";
import { LegalModal } from "@/components/screens/LegalModal";
import { LoginCouponPromo, PROMO_UNTIL, markPromoSeen, promoAlreadySeen } from "@/components/screens/LoginCouponPromo";

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
  // Voltou do pagamento sem estar logado neste navegador: avisa que o pagamento foi recebido.
  const paymentReturn = ["ok", "pendente"].includes(searchParams.get("pagamento") || "");
  // Link do e-mail/notificação de vencimento (/?prolongar=1): depois de entrar, abre a tela de assinatura.
  const afterLoginPath = searchParams.get("prolongar") === "1" ? "/?prolongar=1" : "/";
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
  const [showInstall, setShowInstall] = useState(false);
  const [acceptedTerms, setAcceptedTerms] = useState(false);
  // Termos / Política abrem numa janela por cima do cadastro: não saem da tela, então nada se perde.
  const [legal, setLegal] = useState(null);
  const openLegal = (e, which) => {
    e.preventDefault();
    e.stopPropagation();
    setLegal(which);
  };
  const legalLinkStyle = { background: "transparent", border: "none", padding: 0, font: "inherit", color: t.primary, fontWeight: 600, cursor: "pointer", textDecoration: "underline" };

  useEffect(() => {
    if (searchParams.get("error") === "link_invalido") {
      setError("Esse link de redefinição de senha é inválido ou expirou. Solicite um novo.");
    }
  }, [searchParams]);

  // Anúncio do cupom #10DIASGRATIS: aparece ao abrir o site (uma vez por visita) para quem ainda não entrou. Não aparece
  // quando a pessoa chegou por um link de redefinição de senha, de pagamento ou de renovação, nem depois da validade do cupom.
  const [promo, setPromo] = useState(false);
  const skipPromo = paymentReturn || !!searchParams.get("error") || searchParams.get("prolongar") === "1";
  useEffect(() => {
    if (skipPromo || Date.now() >= PROMO_UNTIL || promoAlreadySeen()) return undefined;
    let cancelled = false;
    let timer;
    // Se o IP de quem abriu o site já tem conta, o anúncio não aparece. Se a consulta falhar, ele aparece.
    fetch("/auth/promo", { cache: "no-store" })
      .then((r) => (r.ok ? r.json() : { mostrar: true }))
      .catch(() => ({ mostrar: true }))
      .then((r) => {
        if (cancelled) return;
        if (r?.mostrar === false) {
          markPromoSeen();
          return;
        }
        timer = setTimeout(() => setPromo(true), 300);
      });
    return () => {
      cancelled = true;
      clearTimeout(timer);
    };
  }, [skipPromo]);
  const closePromo = () => {
    markPromoSeen();
    setPromo(false);
  };
  const getCoupon = () => {
    closePromo();
    setMode("signup");
    setError("");
    setInfo("");
    setConfirmPassword("");
    setAcceptedTerms(false);
  };

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
        router.push(afterLoginPath);
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
        if (!acceptedTerms) {
          setError("Para criar a conta, aceite os Termos de Uso e a Política de Privacidade.");
          return;
        }
        const { data, error } = await supabase.auth.signUp({
          email,
          password,
          options: { data: { name: trimmedName } },
        });
        if (error) throw error;
        // Se o registro falhar, a tela de aceite após o login pede o aceite de novo.
        const accepting = data.user ? sendTermsAcceptance({ context: "signup", user: { id: data.user.id, email }, keepalive: true }) : null;
        if (data.session) {
          // Entra direto: o aceite precisa estar gravado antes de abrir o app (senão a tela de aceite aparece).
          await Promise.all([accepting, updateDisplayName(supabase, data.user.id, trimmedName)]);
          router.push(afterLoginPath);
          router.refresh();
        } else {
          // Precisa confirmar o e-mail: não há o que esperar, o aceite termina em segundo plano.
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
    <div id="swipe-root" className="login-screen" style={{ display: "flex", flexDirection: "column", alignItems: "center", justifyContent: "center", gap: 22, padding: 20, boxSizing: "border-box" }}>
      <SwipeBack rootId="swipe-root" />
      {/* Na tela "Baixar aplicativo" o botão Voltar (o mesmo das outras telas) fica no alto à esquerda, na linha do logo. */}
      <div style={showInstall ? { width: "100%", maxWidth: 440, display: "flex", alignItems: "center", gap: 12 } : undefined}>
        {showInstall && (
          <button
            type="button"
            onClick={() => setShowInstall(false)}
            style={{
              display: "flex",
              alignItems: "center",
              gap: 4,
              flexShrink: 0,
              background: "transparent",
              border: `1px solid ${t.border}`,
              borderRadius: 12,
              padding: "8px 14px",
              cursor: "pointer",
              color: t.text,
              fontSize: 13.5,
              fontWeight: 600,
            }}
          >
            <ChevronLeft size={16} /> Voltar
          </button>
        )}
        <div style={{ display: "flex", alignItems: "center", gap: showInstall ? 8 : 12, ...(showInstall ? { flex: 1, justifyContent: "center" } : {}) }}>
          <Flame size={showInstall ? 30 : 38} color={t.amber} fill={t.amber} />
          <h1 style={{ fontSize: showInstall ? 24 : 30, fontWeight: 700, color: t.text, margin: 0 }}>FlashCardio</h1>
        </div>
      </div>
      {showInstall ? (
        <InstallGuide onBack={() => setShowInstall(false)} />
      ) : (
      <div style={{ width: "100%", maxWidth: 380, background: t.surface, border: `1px solid ${t.border}`, borderRadius: 20, padding: 30 }}>
        {mode !== "login" && (
          <p style={{ fontSize: 13, color: t.textMuted, margin: "0 0 20px", textAlign: "center" }}>
            {mode === "signup" && "Crie sua conta agora"}
            {mode === "forgot" && "Informe seu e-mail para receber o link de redefinição"}
          </p>
        )}

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

          {mode === "signup" && (
            <label style={{ display: "flex", alignItems: "flex-start", gap: 10, fontSize: 12.5, lineHeight: 1.5, color: t.textMuted, cursor: "pointer" }}>
              <input
                type="checkbox"
                checked={acceptedTerms}
                onChange={(e) => setAcceptedTerms(e.target.checked)}
                style={{ width: 18, height: 18, marginTop: 1, flexShrink: 0, accentColor: t.primary }}
              />
              <span>
                Li e concordo com os{" "}
                <button type="button" onClick={(e) => openLegal(e, "termos")} style={legalLinkStyle}>
                  Termos de Uso
                </button>{" "}
                e a{" "}
                <button type="button" onClick={(e) => openLegal(e, "privacidade")} style={legalLinkStyle}>
                  Política de Privacidade
                </button>
                .
              </span>
            </label>
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
          {mode === "login" && paymentReturn && (
            <div style={{ fontSize: 12.5, lineHeight: 1.5, color: t.green }}>
              Pagamento recebido. Entre na sua conta: o acesso é liberado automaticamente assim que o pagamento é aprovado.
            </div>
          )}

          <div style={{ marginTop: 8 }}>
            <PrimaryButton full type="submit" disabled={loading}>
              {mode === "login" && (loading ? "Entrando…" : "Entrar")}
              {mode === "signup" && (loading ? "Criando conta…" : "Criar conta")}
              {mode === "forgot" && (loading ? "Enviando…" : "Enviar link de redefinição")}
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
                setAcceptedTerms(false);
              }}
              style={{ background: "transparent", border: "none", color: t.primary, fontSize: 13, fontWeight: 600, cursor: "pointer" }}
            >
              {mode === "login" ? "Não tem conta? Cadastre-se" : "Já tem conta? Entrar"}
            </button>
          )}
        </div>

        {mode !== "forgot" && (
          <div style={{ marginTop: 14 }}>
            <PrimaryButton full variant="ghost" color={t.name === "light" ? t.surface : undefined} onClick={() => setShowInstall(true)}>
              <Smartphone size={15} style={{ marginRight: 6, verticalAlign: -3 }} />
              Baixar aplicativo
            </PrimaryButton>
          </div>
        )}
      </div>
      )}
      {legal && <LegalModal initial={legal} onClose={() => setLegal(null)} closeLabel="Voltar ao cadastro" />}
      {promo && !showInstall && !legal && <LoginCouponPromo onGetCoupon={getCoupon} onClose={closePromo} />}
    </div>
  );
}
