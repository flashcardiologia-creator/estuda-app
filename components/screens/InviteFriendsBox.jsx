"use client";

import { useEffect, useState } from "react";
import { Check, Copy, Gift, MessageCircle, Share2 } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { ExpandBox } from "@/components/ui/Primitives";
import { REFERRAL_DAYS, cachedReferral, inviteMessage, inviteUrl, prefetchReferral } from "@/lib/data/referral";

const STATUS_TEXT = (item) => {
  if (item.status === "premiado") return `fechou o plano ${item.plan || ""}${item.days ? ` · +${item.days} dias` : ""}`.replace("  ", " ");
  if (item.status === "revertido") return "plano estornado";
  return "criou a conta";
};

// Caixa "Convidar amigos" da Minha Conta: link com o código de amigo, regras, totais e últimos convidados.
// Só continua aparecendo depois que o SQL supabase/convite_amigos.sql foi rodado (sem ele a função my_referral não existe).
// A caixa abre na hora: os dados vêm do cache (o app já os busca ao abrir) e são atualizados em seguida; se ainda não há nada,
// ela aparece com um indicador de carregamento em vez de surgir só depois da resposta do servidor.
export function InviteFriendsBox({ supabase, userId }) {
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

  return (
    <ExpandBox title="Convidar amigos" icon={<Gift size={17} color={t.primary} />} open={open} onToggle={() => setOpen((o) => !o)} badge={data.rewarded}>
      <p style={{ margin: "0 0 14px", fontSize: 13.5, lineHeight: 1.55, color: t.text }}>
        Convide um amigo pelo seu link. Quando ele fechar um plano, <strong>vocês dois ganham dias de acesso</strong>: <strong>{REFERRAL_DAYS.mensal} dias</strong> se ele assinar o mensal e <strong>{REFERRAL_DAYS.anual} dias</strong> se assinar o anual.
      </p>

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
          <div style={{ fontSize: 11, color: t.textMuted, marginTop: 2 }}>fecharam plano</div>
        </div>
        <div style={tile}>
          <div style={{ fontSize: 18, fontWeight: 800, color: t.green }}>+{data.days}</div>
          <div style={{ fontSize: 11, color: t.textMuted, marginTop: 2 }}>dias ganhos</div>
        </div>
      </div>

      {data.list?.length > 0 && (
        <ul style={{ listStyle: "none", margin: "14px 0 0", padding: 0, display: "flex", flexDirection: "column", gap: 6 }}>
          {data.list.map((item, i) => (
            <li key={`${item.name}-${i}`} style={{ display: "flex", alignItems: "baseline", justifyContent: "space-between", gap: 10, fontSize: 13, color: t.text }}>
              <span style={{ fontWeight: 700, minWidth: 0, overflow: "hidden", textOverflow: "ellipsis", whiteSpace: "nowrap" }}>{item.name}</span>
              <span style={{ color: item.status === "premiado" ? t.green : t.textMuted, fontSize: 12, flexShrink: 0 }}>{STATUS_TEXT(item)}</span>
            </li>
          ))}
        </ul>
      )}

      <p style={{ margin: "14px 0 0", fontSize: 11.5, lineHeight: 1.5, color: t.textMuted }}>
        Vale para quem criar a conta pelo seu link e fechar o primeiro plano pago. Os dias entram depois do fim do seu plano atual. Se o plano do amigo for estornado, os dias dos dois são desfeitos.
      </p>
    </ExpandBox>
  );
}
