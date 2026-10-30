"use client";

import { useEffect, useRef, useState } from "react";
import { useRouter } from "next/navigation";
import { Lock, CreditCard, ShieldCheck, Check } from "lucide-react";
import { PLAN_LABEL, extendedExpiry } from "@/lib/access";
import { createClient } from "@/lib/supabase/client";
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
  const [extended, setExtended] = useState(false);
  const [error, setError] = useState("");
  // Quem já assina vê o vencimento e pode prolongar; quem não assina vê os planos para assinar.
  const subscribed = access.active && !!access.expiresAt;
  const expiresAtWhenOpened = useRef(access.expiresAt);

  // Depois de abrir a janela do Mercado Pago, consulta o acesso a cada poucos segundos. Quem não
  // assinava recarrega o app limpo quando o pagamento é aprovado (o conteúdo é lido de outro jeito
  // para assinantes). Quem já assinava só espera o vencimento mudar.
  useEffect(() => {
    if (!waiting) return;
    if (subscribed) {
      if (access.expiresAt !== expiresAtWhenOpened.current) {
        setWaiting(false);
        setExtended(true);
        return;
      }
    } else if (access.active) {
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
  }, [waiting, subscribed, access.active, access.expiresAt, router]);
  // Cupom: o banco confere (existe, está no prazo, esta conta ainda não usou) e libera os dias de cortesia.
  const [coupon, setCoupon] = useState("");
  const [couponBusy, setCouponBusy] = useState(false);
  const [couponResult, setCouponResult] = useState(null);
  // Cupom de preço (supabase/cupom_preco.sql): { code, plan, priceCents }. Troca o valor do plano; o servidor confere de novo ao assinar.
  const [priceCoupon, setPriceCoupon] = useState(null);
  const PRICE_COUPON_MESSAGES = {
    expirado: "Este cupom expirou.",
    ja_usado: "Você já usou este cupom nesta conta.",
    esgotado: "Este cupom atingiu o limite de usos.",
    plano_incorreto: "Este cupom não vale para este plano.",
  };
  const removePriceCoupon = () => {
    setPriceCoupon(null);
    setCouponResult(null);
    setCoupon("");
  };
  const redeemCoupon = async (e) => {
    e.preventDefault();
    const code = coupon.trim();
    if (!code || couponBusy) return;
    setCouponBusy(true);
    setCouponResult(null);
    // Primeiro vê se é um cupom de preço. Se o código não é de preço (ou o SQL ainda não foi rodado), segue para o cupom de dias.
    const { data: priceData, error: priceError } = await createClient().rpc("check_price_coupon", { p_code: code });
    const priceRow = Array.isArray(priceData) ? priceData[0] : priceData;
    if (!priceError && priceRow && priceRow.out_status !== "invalido") {
      if (priceRow.out_status === "ok") {
        setPriceCoupon({ code: priceRow.out_code, plan: priceRow.out_plan, priceCents: priceRow.out_price_cents });
        setCouponResult({ ok: true, kind: "price" });
      } else {
        setCouponResult({ ok: false, text: PRICE_COUPON_MESSAGES[priceRow.out_status] || "Cupom inválido." });
      }
      setCouponBusy(false);
      return;
    }
    const { data, error: rpcError } = await createClient().rpc("redeem_coupon", { p_code: code });
    const row = Array.isArray(data) ? data[0] : data;
    if (rpcError || !row) {
      setCouponResult({ ok: false, text: "Não foi possível aplicar o cupom agora. Tente de novo em instantes." });
      setCouponBusy(false);
      return;
    }
    if (row.out_status === "ok") {
      setCouponResult({ ok: true, days: row.out_days, until: row.out_expires_at });
      // Recarrega o app limpo para liberar o conteúdo (quem já assinava volta a esta tela, já atualizada).
      setTimeout(() => window.location.replace(subscribed ? "/?prolongar=1" : "/"), 2200);
      return;
    }
    const messages = {
      invalido: "Cupom inválido. Confira o código e tente de novo.",
      expirado: "Este cupom expirou.",
      ja_usado: "Você já usou este cupom nesta conta.",
    };
    setCouponResult({ ok: false, text: messages[row.out_status] || "Cupom inválido." });
    setCouponBusy(false);
  };

  const section = { background: t.surface, border: `1px solid ${t.border}`, borderRadius: 16, padding: "16px 18px" };
  const label = { fontSize: 11, fontWeight: 700, letterSpacing: 0.5, textTransform: "uppercase", color: t.textMuted, marginBottom: 10 };

  const pay = async (planId) => {
    if (paying) return;
    setError("");
    setPaying(planId);
    try {
      const withCoupon = priceCoupon && priceCoupon.plan === planId;
      const res = await fetch("/api/pagamento/criar", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(withCoupon ? { plan: planId, coupon: priceCoupon.code } : { plan: planId }),
      });
      const data = await res.json().catch(() => ({}));
      if (data.error === "coupon") {
        // O servidor recusou o cupom (por exemplo, outro aparelho já usou): tira o preço novo e avisa.
        setPriceCoupon(null);
        setCouponResult({ ok: false, text: PRICE_COUPON_MESSAGES[data.status] || "Cupom inválido." });
        setPaying(null);
        return;
      }
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
        {subscribed ? (
          <div style={section}>
            <div style={{ display: "flex", alignItems: "center", gap: 12 }}>
              <div
                style={{ width: 44, height: 44, flexShrink: 0, borderRadius: "50%", background: "rgba(34,197,94,0.14)", display: "flex", alignItems: "center", justifyContent: "center" }}
              >
                <Check size={22} color={t.green} />
              </div>
              <div style={{ minWidth: 0 }}>
                <h2 style={{ margin: 0, fontSize: 17, fontWeight: 700, color: t.text }}>Assinatura ativa</h2>
                <div style={{ fontSize: 13, color: t.textMuted, marginTop: 2 }}>
                  Plano {PLAN_LABEL[access.plan] || ""} · vence em {fmtDate(access.expiresAt)}
                </div>
              </div>
            </div>
            <div style={{ height: 8, borderRadius: 999, background: t.surfaceAlt, margin: "14px 0 6px", overflow: "hidden" }}>
              <div
                style={{
                  height: "100%",
                  width: `${Math.min(100, Math.max(4, ((access.daysLeft ?? 0) / (access.plan === "anual" ? 365 : 30)) * 100))}%`,
                  background: (access.daysLeft ?? 0) <= 7 ? t.amber : t.green,
                  borderRadius: 999,
                }}
              />
            </div>
            <div style={{ display: "flex", justifyContent: "space-between", fontSize: 12, color: t.textMuted }}>
              <span>Restam</span>
              <b style={{ color: (access.daysLeft ?? 0) <= 7 ? t.amber : t.text }}>
                {access.daysLeft} {access.daysLeft === 1 ? "dia" : "dias"}
              </b>
            </div>
          </div>
        ) : (
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
              <h2 style={{ margin: 0, fontSize: 19, lineHeight: 1.3, fontWeight: 700, color: t.text }}>Conteúdo para assinantes</h2>
            </div>
            {access.lastExpiredAt && (
              <p style={{ margin: "10px 0 0", fontSize: 14, lineHeight: 1.55, color: t.textMuted }}>
                Sua assinatura venceu em {fmtDate(access.lastExpiredAt)}. Renove para voltar a estudar sem limites.
              </p>
            )}
          </div>
        )}

        <div style={section}>
          <div style={label}>{subscribed ? "Prolongar assinatura" : "Escolha o plano"}</div>
          {subscribed && (
            <p style={{ margin: "0 0 14px", fontSize: 13, lineHeight: 1.5, color: t.textMuted }}>
              Escolha um novo plano. Os dias novos são <b style={{ color: t.text }}>somados ao fim da sua assinatura atual</b>: você não perde nenhum dia.
            </p>
          )}
          <MercadoPagoNotice t={t} />
          <div style={{ display: "flex", flexDirection: "column", gap: 12 }}>
            {Object.values(PLANS).map((p) => (
              <div key={p.id} style={{ border: `1px solid ${t.border}`, background: t.surfaceAlt, borderRadius: 14, padding: "14px 16px" }}>
                <div style={{ display: "flex", alignItems: "baseline", justifyContent: "space-between", gap: 10, flexWrap: "wrap" }}>
                  <span style={{ fontWeight: 700, fontSize: 16, color: t.text }}>{p.label}</span>
                  <span style={{ fontWeight: 800, fontSize: 18, color: t.text }}>
                    {priceCoupon?.plan === p.id ? (
                      <>
                        <span style={{ fontWeight: 500, fontSize: 14, color: t.textMuted, textDecoration: "line-through", marginRight: 8 }}>{formatBRL(p.priceCents)}</span>
                        {formatBRL(priceCoupon.priceCents)}
                      </>
                    ) : p.id === "anual" ? (
                      `${formatBRL(Math.round(p.priceCents / 12))}/mês`
                    ) : (
                      formatBRL(p.priceCents)
                    )}
                  </span>
                </div>
                <div style={{ fontSize: 13, color: t.textMuted, margin: "4px 0 0", lineHeight: 1.5 }}>
                  {subscribed ? `+${p.days} dias de acesso` : `${p.days} dias de acesso`}
                </div>
                {p.id === "anual" ? (
                  <div style={{ fontSize: 14.5, fontWeight: 800, color: t.primary, margin: "6px 0 12px" }}>
                    Total de {formatBRL(p.priceCents)} em um único pagamento
                  </div>
                ) : (
                  <div style={{ height: 12 }} />
                )}
                {subscribed && (
                  <div style={{ fontSize: 13, margin: "-4px 0 12px", padding: "8px 10px", borderRadius: 10, background: t.primarySoft, color: t.text }}>
                    Novo vencimento: <b>{extendedExpiry(access.expiresAt, p.days).toLocaleDateString("pt-BR")}</b>
                  </div>
                )}
                {/* Só o plano clicado fica ativo ("Abrindo pagamento…"); o outro fica desativado até abrir. */}
                <PrimaryButton full disabled={!!paying && paying !== p.id} onClick={() => pay(p.id)}>
                  <CreditCard size={15} style={{ marginRight: 7, verticalAlign: -3 }} />
                  {paying === p.id
                    ? "Abrindo pagamento…"
                    : subscribed
                      ? `Prolongar ${p.days} dias`
                      : priceCoupon?.plan === p.id
                        ? `Assinar ${p.label.toLowerCase()} por ${formatBRL(priceCoupon.priceCents)}`
                        : `Assinar ${p.label.toLowerCase()}`}
                </PrimaryButton>
              </div>
            ))}
          </div>
          <form onSubmit={redeemCoupon} style={{ display: "flex", gap: 10, marginTop: 14 }}>
            <input
              type="text"
              value={coupon}
              onChange={(e) => setCoupon(e.target.value)}
              placeholder="Digite o cupom"
              aria-label="Código do cupom"
              autoCapitalize="characters"
              autoComplete="off"
              autoCorrect="off"
              spellCheck={false}
              disabled={couponBusy || couponResult?.ok}
              style={{
                flex: 1,
                minWidth: 0,
                padding: "12px 14px",
                borderRadius: 12,
                border: `1px solid ${t.border}`,
                background: t.surfaceAlt,
                color: t.text,
                fontSize: 16,
                boxSizing: "border-box",
              }}
            />
            <div style={{ flexShrink: 0 }}>
              <PrimaryButton type="submit" disabled={!coupon.trim() || couponBusy || couponResult?.ok}>
                {couponBusy && !couponResult ? "Aplicando…" : "Aplicar"}
              </PrimaryButton>
            </div>
          </form>
          {couponResult?.ok && couponResult.kind === "price" && priceCoupon && (
            <div style={{ fontSize: 13, lineHeight: 1.5, color: t.text, background: "rgba(34,197,94,0.14)", borderRadius: 10, padding: "10px 12px", marginTop: 12 }}>
              Cupom aplicado! O plano {PLANS[priceCoupon.plan].label.toLowerCase()} fica por <b>{formatBRL(priceCoupon.priceCents)}</b> (era {formatBRL(PLANS[priceCoupon.plan].priceCents)}). Toque em
              &quot;Assinar&quot; no plano para pagar com o desconto. Uso único por conta.{" "}
              <button
                type="button"
                onClick={removePriceCoupon}
                style={{ background: "transparent", border: "none", padding: 0, color: t.primary, fontWeight: 600, fontSize: 13, cursor: "pointer", textDecoration: "underline" }}
              >
                Remover
              </button>
            </div>
          )}
          {couponResult?.ok && couponResult.kind !== "price" && (
            <div style={{ fontSize: 13, lineHeight: 1.5, color: t.text, background: "rgba(34,197,94,0.14)", borderRadius: 10, padding: "10px 12px", marginTop: 12 }}>
              Cupom aplicado! Você ganhou <b>{couponResult.days} dias</b> de acesso, até <b>{fmtDate(couponResult.until)}</b>.
            </div>
          )}
          {couponResult && !couponResult.ok && <div style={{ fontSize: 12.5, color: t.red, marginTop: 12 }}>{couponResult.text}</div>}
          {error && <div style={{ fontSize: 12.5, color: t.red, marginTop: 12 }}>{error}</div>}
          {waiting && (
            <div style={{ fontSize: 13, lineHeight: 1.5, color: t.text, background: t.primarySoft, borderRadius: 10, padding: "10px 12px", marginTop: 12 }}>
              {subscribed
                ? "Janela do Mercado Pago aberta. Assim que o pagamento for aprovado, sua assinatura é prolongada sozinha."
                : "Janela do Mercado Pago aberta. Assim que o pagamento for aprovado, seu acesso é liberado sozinho."}
            </div>
          )}
          {extended && (
            <div style={{ fontSize: 13, lineHeight: 1.5, color: t.text, background: "rgba(34,197,94,0.14)", borderRadius: 10, padding: "10px 12px", marginTop: 12 }}>
              Pagamento aprovado. Sua assinatura foi prolongada até <b>{fmtDate(access.expiresAt)}</b>.
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
