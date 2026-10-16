"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import { Lock, CreditCard, ShieldCheck } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { PrimaryButton, ScreenHeader } from "@/components/ui/Primitives";
import { PLANS, formatBRL } from "@/lib/billing";
import { canOpenModal, openCheckoutModal } from "@/lib/mpCheckout";

// Aviso de que o pagamento é feito pelo Mercado Pago, antes de a pessoa clicar em assinar.
// Logo oficial do Mercado Pago em public/mercadopago-logo.svg (baixada de mercadopago.com.br).
function MercadoPagoNotice({ t }) {
  return (
    <div style={{ border: `1px solid ${t.border}`, background: t.surfaceAlt, borderRadius: 14, padding: "14px 16px", marginBottom: 14 }}>
      <div style={{ display: "flex", alignItems: "center", gap: 12 }}>
        {/* eslint-disable-next-line @next/next/no-img-element */}
        <img
          src="/mercadopago-logo.svg"
          alt="Mercado Pago"
          onError={(e) => {
            e.currentTarget.style.display = "none";
          }}
          style={{ display: "block", height: 38, width: "auto", flexShrink: 0 }}
        />
        <div style={{ display: "flex", alignItems: "center", gap: 7, minWidth: 0, fontWeight: 700, fontSize: 14.5, lineHeight: 1.3, color: t.text }}>
          <ShieldCheck size={18} color={t.green} style={{ flexShrink: 0 }} />
          <span>Pagamento seguro pelo Mercado Pago</span>
        </div>
      </div>
      <div style={{ fontSize: 12.5, lineHeight: 1.5, color: t.textMuted, marginTop: 10 }}>
        Ao tocar em Assinar, a janela do Mercado Pago abre aqui mesmo para você pagar com Pix ou cartão. O FlashCardio não vê os dados do seu cartão.
      </div>
    </div>
  );
}

const fmtDate = (iso) => new Date(iso).toLocaleDateString("pt-BR");

// Tela exibida no lugar de Questões e Flashcards para quem não tem assinatura ativa.
export function PaywallScreen({ access, onBack }) {
  const t = useT();
  const router = useRouter();
  const [paying, setPaying] = useState(null);
  const [waiting, setWaiting] = useState(false);
  const [error, setError] = useState("");

  // Depois de abrir a janela do Mercado Pago, consulta o acesso a cada poucos segundos. Quando o
  // pagamento é aprovado, recarrega o app limpo (o conteúdo é lido de outro jeito para assinantes).
  useEffect(() => {
    if (!waiting) return;
    if (access.active) {
      window.location.replace("/");
      return;
    }
    let tries = 0;
    const timer = setInterval(() => {
      tries += 1;
      router.refresh();
      if (tries >= 45) {
        clearInterval(timer);
        setWaiting(false);
      }
    }, 4000);
    return () => clearInterval(timer);
  }, [waiting, access.active, router]);
  const section = { background: t.surface, border: `1px solid ${t.border}`, borderRadius: 16, padding: "16px 18px" };
  const label = { fontSize: 11, fontWeight: 700, letterSpacing: 0.5, textTransform: "uppercase", color: t.textMuted, marginBottom: 10 };

  const pay = async (planId) => {
    if (paying) return;
    setError("");
    setPaying(planId);
    try {
      const res = await fetch("/api/pagamento/criar", { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify({ plan: planId }) });
      const data = await res.json().catch(() => ({}));
      if (!res.ok || !data.url) throw new Error("falhou");
      // Preferência: janela do Mercado Pago aqui mesmo, sem sair do site nem abrir o app do Mercado Pago.
      if (canOpenModal() && data.id) {
        try {
          await openCheckoutModal(data.id);
          setPaying(null);
          setWaiting(true);
          return;
        } catch {
          // cai no redirecionamento abaixo
        }
      }
      window.location.assign(data.url);
    } catch {
      setError("Não foi possível abrir o pagamento agora. Tente de novo em instantes.");
      setPaying(null);
    }
  };

  return (
    <div style={{ maxWidth: 620, margin: "0 auto", paddingBottom: 80 }}>
      <ScreenHeader title="Assinatura" onBack={onBack} />
      <div style={{ padding: "18px 22px", display: "flex", flexDirection: "column", gap: 14 }}>
        <div style={{ padding: "6px 0 2px" }}>
          <div style={{ display: "flex", alignItems: "center", gap: 14 }}>
            <div
              style={{
                width: 48,
                height: 48,
                flexShrink: 0,
                borderRadius: "50%",
                background: t.primarySoft,
                display: "flex",
                alignItems: "center",
                justifyContent: "center",
              }}
            >
              <Lock size={22} color={t.primary} />
            </div>
            <h2 style={{ margin: 0, fontSize: 19, lineHeight: 1.3, fontWeight: 700, color: t.text }}>Conteúdo para assinante</h2>
          </div>
          {access.lastExpiredAt && (
            <p style={{ margin: "10px 0 0", fontSize: 14, lineHeight: 1.55, color: t.textMuted }}>
              Sua assinatura venceu em {fmtDate(access.lastExpiredAt)}. Renove para voltar a estudar sem limites.
            </p>
          )}
        </div>

        <div style={section}>
          <div style={label}>Escolha o plano</div>
          <MercadoPagoNotice t={t} />
          <div style={{ display: "flex", flexDirection: "column", gap: 12 }}>
            {Object.values(PLANS).map((p) => (
              <div key={p.id} style={{ border: `1px solid ${t.border}`, background: t.surfaceAlt, borderRadius: 14, padding: "14px 16px" }}>
                <div style={{ display: "flex", alignItems: "baseline", justifyContent: "space-between", gap: 10, flexWrap: "wrap" }}>
                  <span style={{ fontWeight: 700, fontSize: 16, color: t.text }}>{p.label}</span>
                  <span style={{ fontWeight: 800, fontSize: 18, color: t.text }}>{formatBRL(p.priceCents)}</span>
                </div>
                <div style={{ fontSize: 13, color: t.textMuted, margin: "4px 0 0", lineHeight: 1.5 }}>
                  {p.id === "anual" ? "Pagamento único de " : ""}
                  {p.id === "anual" ? formatBRL(p.priceCents) : ""}
                  {p.id === "anual" ? " · " : ""}
                  {p.days} dias de acesso, contados do dia do pagamento
                </div>
                {p.id === "anual" ? (
                  <div style={{ fontSize: 14.5, fontWeight: 800, color: t.primary, margin: "6px 0 12px" }}>
                    Equivale a {formatBRL(Math.round(p.priceCents / 12))} por mês
                  </div>
                ) : (
                  <div style={{ height: 12 }} />
                )}
                {/* Só o plano clicado fica ativo ("Abrindo pagamento…"); o outro fica desativado até abrir. */}
                <PrimaryButton full disabled={!!paying && paying !== p.id} onClick={() => pay(p.id)}>
                  <CreditCard size={15} style={{ marginRight: 7, verticalAlign: -3 }} />
                  {paying === p.id ? "Abrindo pagamento…" : `Assinar ${p.label.toLowerCase()}`}
                </PrimaryButton>
              </div>
            ))}
          </div>
          {error && <div style={{ fontSize: 12.5, color: t.red, marginTop: 12 }}>{error}</div>}
          {waiting && (
            <div style={{ fontSize: 13, lineHeight: 1.5, color: t.text, background: t.primarySoft, borderRadius: 10, padding: "10px 12px", marginTop: 12 }}>
              Janela do Mercado Pago aberta. Assim que o pagamento for aprovado, seu acesso é liberado sozinho.
            </div>
          )}
          <p style={{ margin: "12px 0 0", fontSize: 12.5, lineHeight: 1.5, color: t.textMuted }}>
            Pagamento por Pix ou cartão, pelo Mercado Pago. No cartão, o plano mensal é pago à vista e o anual pode ser parcelado em até{" "}
            {PLANS.anual.maxInstallments}x, com os juros do parcelamento mostrados antes de confirmar. O acesso é liberado automaticamente assim que
            o pagamento é aprovado. Não há renovação automática.
          </p>
        </div>
      </div>
    </div>
  );
}
