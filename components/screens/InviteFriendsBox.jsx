"use client";

import { useEffect, useState } from "react";
import { Check, Copy, Gift, MessageCircle, Share2 } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { ExpandBox, PrimaryButton } from "@/components/ui/Primitives";
import {
  REFERRAL_HOLD_DAYS,
  REFERRAL_INVITEE_DAYS,
  REFERRAL_MIN_REDEEM,
  REFERRAL_POINTS,
  cachedReferral,
  inviteMessage,
  inviteUrl,
  pointsToBrl,
  prefetchReferral,
  referralPending,
  referralPoints,
} from "@/lib/data/referral";

const dayMonth = (iso) => (iso ? new Date(iso).toLocaleDateString("pt-BR", { day: "2-digit", month: "2-digit" }) : "");

// Caixa "Convidar amigos" da Minha Conta: link com o código de amigo, regra de pontos, saldo, meta de saque e lista.
// Quem convida ganha pontos quando o amigo assina (10 no mensal, 100 no anual; 1 ponto = R$ 1,00). Os pontos de cada amigo ficam
// AMARELOS por 7 dias (prazo de estorno) e depois VERDES, liberados para saque; com 250 pontos liberados a pessoa pede o saque na aba
// Contato (onRequestPayout) e, quando o saque é pago, entra uma linha VERMELHA (-250). O amigo convidado ganha 7 dias de acesso.
// Só continua aparecendo depois que os SQLs supabase/convite_amigos.sql e supabase/convite_pontos.sql foram rodados.
// A caixa abre na hora: os dados vêm do cache (o app já os busca ao abrir) e são atualizados em seguida; se ainda não há nada,
// ela aparece com um indicador de carregamento em vez de surgir só depois da resposta do servidor.
export function InviteFriendsBox({ supabase, userId, onRequestPayout }) {
  const t = useT();
  const [data, setData] = useState(() => cachedReferral(userId));
  const [gone, setGone] = useState(false); // recurso inexistente ou falha sem nada guardado: a caixa some
  const [open, setOpen] = useState(false);
  const [copied, setCopied] = useState(false);

  useEffect(() => {
    let cancelled = false;
    prefetchReferral(supabase, userId)
      .then((d) => {
        if (cancelled) return;
        setData(d);
        setGone(!d);
      })
      .catch(() => {
        if (!cancelled) setGone((g) => g || !cachedReferral(userId));
      });
    return () => {
      cancelled = true;
    };
  }, [supabase, userId]);

  if (gone) return null;

  if (!data) {
    const bar = (w, h = 12) => <div style={{ width: w, height: h, borderRadius: 6, background: t.border, animation: "fc-pulse 1.2s ease-in-out infinite" }} />;
    return (
      <ExpandBox title="Convidar amigos" icon={<Gift size={17} color={t.primary} />} open={open} onToggle={() => setOpen((o) => !o)}>
        <div role="status" aria-label="Carregando seu link de convite" style={{ display: "flex", flexDirection: "column", gap: 10 }}>
          {bar("92%")}
          {bar("70%")}
          {bar("100%", 48)}
          {bar("100%", 38)}
        </div>
      </ExpandBox>
    );
  }

  const url = inviteUrl(window.location.origin, data.code);
  const message = inviteMessage(url);
  const canShare = typeof navigator !== "undefined" && typeof navigator.share === "function";

  const points = referralPoints(data);
  const pending = referralPending(data);
  const missing = Math.max(0, REFERRAL_MIN_REDEEM - points);
  const canRedeem = points >= REFERRAL_MIN_REDEEM;
  const pct = Math.min(100, Math.round((points / REFERRAL_MIN_REDEEM) * 100));

  // Convidados e saques na mesma lista, do mais novo para o mais antigo.
  const entries = [
    ...(data.list || []).map((item) => ({ kind: "convite", at: item.at, item })),
    ...(data.withdrawals || []).map((w) => ({ kind: "saque", at: w.at, w })),
  ].sort((a, b) => String(b.at || "").localeCompare(String(a.at || "")));

  const copy = async () => {
    try {
      await navigator.clipboard.writeText(url);
      setCopied(true);
      setTimeout(() => setCopied(false), 1800);
    } catch {
      window.prompt("Copie o link:", url);
    }
  };
  const share = async () => {
    try {
      await navigator.share({ title: "FlashCardio", text: message });
    } catch {
      // a pessoa fechou a janela de compartilhar
    }
  };

  const tile = { flex: 1, minWidth: 0, textAlign: "center", padding: "10px 6px", borderRadius: 12, background: t.surfaceAlt, border: `1px solid ${t.border}` };
  const action = { flex: 1, display: "flex", alignItems: "center", justifyContent: "center", gap: 6, padding: "10px 12px", borderRadius: 12, border: `1px solid ${t.border}`, background: t.surface, color: t.text, fontSize: 13, fontWeight: 700, cursor: "pointer", fontFamily: "inherit", textDecoration: "none" };
  const eyebrow = { fontSize: 10.5, color: t.primary, fontWeight: 700, letterSpacing: 0.5, textTransform: "uppercase" };
  const dot = (color) => <span style={{ display: "inline-block", width: 8, height: 8, borderRadius: "50%", background: color, marginRight: 5 }} />;

  // Cor, texto e pontos de cada convidado: amarelo = aguardando os 7 dias; verde = liberado; cinza = estornado.
  const inviteeLook = (item) => {
    const pts = item.points > 0 ? item.points : 0;
    if (item.status === "premiado" && pts > 0) {
      return item.released
        ? { color: t.green, sub: `assinou o ${item.plan || "plano"} · liberado`, right: `+${pts} pontos` }
        : { color: t.amber, sub: `assinou o ${item.plan || "plano"} · libera em ${dayMonth(item.release_at)}`, right: `+${pts} pontos` };
    }
    if (item.status === "premiado") return { color: t.text, sub: `assinou o plano ${item.plan || ""}`.trim(), right: "" };
    if (item.status === "revertido") return { color: t.textMuted, sub: "plano estornado", right: "" };
    return { color: t.text, sub: "criou a conta", right: "" };
  };

  return (
    <ExpandBox title="Convidar amigos" icon={<Gift size={17} color={t.primary} />} open={open} onToggle={() => setOpen((o) => !o)} badge={data.rewarded}>
      <p style={{ margin: "0 0 12px", fontSize: 13.5, lineHeight: 1.55, color: t.text }}>
        Convide um amigo pelo seu link. Quando ele <strong>assinar um plano</strong>, você <strong>ganha pontos que valem dinheiro</strong> (<strong>1 ponto = R$ 1,00</strong>). Seu amigo também ganha <strong>{REFERRAL_INVITEE_DAYS} dias</strong> de acesso.
      </p>

      <div style={{ display: "flex", gap: 8, marginBottom: 14 }}>
        <div style={{ ...tile, textAlign: "left", padding: "10px 12px" }}>
          <div style={{ fontSize: 11.5, color: t.textMuted }}>Assinatura mensal</div>
          <div style={{ fontSize: 17, fontWeight: 800, color: t.green, marginTop: 2 }}>+{REFERRAL_POINTS.mensal} pontos</div>
          <div style={{ fontSize: 11, color: t.textMuted, marginTop: 1 }}>{pointsToBrl(REFERRAL_POINTS.mensal)}</div>
        </div>
        <div style={{ ...tile, textAlign: "left", padding: "10px 12px" }}>
          <div style={{ fontSize: 11.5, color: t.textMuted }}>Assinatura anual</div>
          <div style={{ fontSize: 17, fontWeight: 800, color: t.green, marginTop: 2 }}>+{REFERRAL_POINTS.anual} pontos</div>
          <div style={{ fontSize: 11, color: t.textMuted, marginTop: 1 }}>{pointsToBrl(REFERRAL_POINTS.anual)}</div>
        </div>
      </div>

      <div style={{ padding: 14, borderRadius: 14, border: `1px solid ${t.primary}40`, background: t.primarySoft, marginBottom: 14 }}>
        <div style={{ display: "flex", alignItems: "baseline", justifyContent: "space-between", gap: 8 }}>
          <span style={eyebrow}>Liberados para saque</span>
          <span style={{ fontSize: 11.5, color: t.textMuted, whiteSpace: "nowrap" }}>mínimo {REFERRAL_MIN_REDEEM}</span>
        </div>
        <div style={{ marginTop: 6 }}>
          <span style={{ fontSize: 32, fontWeight: 800, color: t.text, lineHeight: 1 }}>{points}</span>{" "}
          <span style={{ fontSize: 14, color: t.textMuted }}>{points === 1 ? "ponto" : "pontos"} · {pointsToBrl(points)}</span>
        </div>
        {pending > 0 && (
          <div style={{ fontSize: 12.5, color: t.amber, fontWeight: 700, marginTop: 6 }}>
            + {pending} {pending === 1 ? "ponto aguardando" : "pontos aguardando"} ({REFERRAL_HOLD_DAYS} dias)
          </div>
        )}
        <div role="progressbar" aria-valuemin={0} aria-valuemax={REFERRAL_MIN_REDEEM} aria-valuenow={Math.min(points, REFERRAL_MIN_REDEEM)} aria-label="Progresso até o saque" style={{ height: 8, borderRadius: 999, background: t.border, overflow: "hidden", marginTop: 12 }}>
          <div style={{ width: `${pct}%`, height: "100%", borderRadius: 999, background: canRedeem ? t.green : t.primary, transition: "width .4s ease" }} />
        </div>
        <div style={{ fontSize: 12.5, marginTop: 8, lineHeight: 1.4, color: canRedeem ? t.green : t.textMuted, fontWeight: canRedeem ? 700 : 500 }}>
          {canRedeem ? `Você já pode sacar ${pointsToBrl(points)}.` : `Faltam ${missing} ${missing === 1 ? "ponto liberado" : "pontos liberados"} para poder sacar.`}
        </div>
        <div style={{ marginTop: 12 }}>
          <PrimaryButton full disabled={!canRedeem} onClick={() => onRequestPayout?.(points)} textColor={canRedeem ? undefined : t.textMuted}>
            {canRedeem ? `Solicitar saque de ${pointsToBrl(points)}` : "Solicitar saque"}
          </PrimaryButton>
        </div>
        {canRedeem && <div style={{ fontSize: 11.5, color: t.textMuted, marginTop: 8, textAlign: "center" }}>O pedido é feito na aba Contato, com a sua chave PIX.</div>}
      </div>

      <div style={{ display: "flex", alignItems: "center", justifyContent: "space-between", gap: 10, border: `1.5px dashed ${t.primary}`, borderRadius: 12, padding: "12px 14px", marginBottom: 10 }}>
        <div style={{ minWidth: 0 }}>
          <div style={{ fontSize: 8.5, color: t.primary, fontWeight: 700, letterSpacing: 0.5, textTransform: "uppercase", marginBottom: 3 }}>Seu link de convite</div>
          <div style={{ fontSize: 12.5, color: t.text, fontWeight: 700, wordBreak: "break-all", lineHeight: 1.35 }}>{url.replace(/^https?:\/\//, "")}</div>
        </div>
        <button
          type="button"
          onClick={copy}
          title="Copiar link"
          style={{ display: "flex", alignItems: "center", gap: 6, flexShrink: 0, background: copied ? "transparent" : t.surface, border: `1px solid ${copied ? t.green : t.border}`, borderRadius: 10, padding: "8px 12px", color: copied ? t.green : t.text, fontSize: 12.5, fontWeight: 700, cursor: "pointer", fontFamily: "inherit", transition: "all .15s ease" }}
        >
          {copied ? <Check size={14} /> : <Copy size={14} />}
          {copied ? "Copiado" : "Copiar"}
        </button>
      </div>

      <div style={{ display: "flex", gap: 8, marginBottom: 14 }}>
        <a href={`https://wa.me/?text=${encodeURIComponent(message)}`} target="_blank" rel="noopener noreferrer" style={action}>
          <MessageCircle size={15} color={t.green} />
          WhatsApp
        </a>
        {canShare && (
          <button type="button" onClick={share} style={action}>
            <Share2 size={15} color={t.primary} />
            Compartilhar
          </button>
        )}
      </div>

      <div style={{ display: "flex", gap: 8 }}>
        <div style={tile}>
          <div style={{ fontSize: 18, fontWeight: 800, color: t.text }}>{data.invited}</div>
          <div style={{ fontSize: 11, color: t.textMuted, marginTop: 2 }}>convidados</div>
        </div>
        <div style={tile}>
          <div style={{ fontSize: 18, fontWeight: 800, color: t.text }}>{data.rewarded}</div>
          <div style={{ fontSize: 11, color: t.textMuted, marginTop: 2 }}>assinaram</div>
        </div>
      </div>

      {entries.length > 0 && (
        <>
          <div style={{ display: "flex", flexWrap: "wrap", gap: "4px 14px", margin: "14px 0 10px", fontSize: 11, color: t.textMuted }}>
            <span>{dot(t.amber)}aguardando {REFERRAL_HOLD_DAYS} dias</span>
            <span>{dot(t.green)}liberado</span>
            <span>{dot(t.red)}saque</span>
          </div>
          <ul style={{ listStyle: "none", margin: 0, padding: 0, display: "flex", flexDirection: "column", gap: 10 }}>
            {entries.map((e, i) => {
              if (e.kind === "saque") {
                return (
                  <li key={`saque-${i}`} style={{ display: "flex", alignItems: "center", justifyContent: "space-between", gap: 10 }}>
                    <div style={{ minWidth: 0 }}>
                      <div style={{ fontSize: 13.5, fontWeight: 700, color: t.red }}>Saque</div>
                      <div style={{ fontSize: 12, color: t.textMuted, marginTop: 1 }}>pago em {dayMonth(e.w.at)}</div>
                    </div>
                    <span style={{ fontSize: 13.5, fontWeight: 800, color: t.red, flexShrink: 0 }}>-{e.w.points} pontos</span>
                  </li>
                );
              }
              const look = inviteeLook(e.item);
              return (
                <li key={`${e.item.name}-${i}`} style={{ display: "flex", alignItems: "center", justifyContent: "space-between", gap: 10 }}>
                  <div style={{ minWidth: 0 }}>
                    <div style={{ fontSize: 13.5, fontWeight: 700, color: look.color, overflow: "hidden", textOverflow: "ellipsis", whiteSpace: "nowrap" }}>{e.item.name}</div>
                    <div style={{ fontSize: 12, color: t.textMuted, marginTop: 1 }}>{look.sub}</div>
                  </div>
                  {look.right && <span style={{ fontSize: 13.5, fontWeight: 800, color: look.color, flexShrink: 0 }}>{look.right}</span>}
                </li>
              );
            })}
          </ul>
        </>
      )}

      <p style={{ margin: "14px 0 0", fontSize: 11.5, lineHeight: 1.5, color: t.textMuted }}>
        Vale para quem criar a conta pelo seu link e fechar o primeiro plano pago. Os pontos de cada amigo ficam aguardando {REFERRAL_HOLD_DAYS} dias, o prazo de estorno, e depois são liberados. Se o plano do amigo for estornado nesse prazo, os pontos são desfeitos.
      </p>
    </ExpandBox>
  );
}
