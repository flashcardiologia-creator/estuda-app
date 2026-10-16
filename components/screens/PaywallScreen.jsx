"use client";

import { Lock, Flame, Swords, BarChart3, Mail } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { PrimaryButton, ScreenHeader } from "@/components/ui/Primitives";

const CONTACT_EMAIL = "flashcardiologia@gmail.com";

const FREE_ITEMS = [
  { icon: Flame, text: "Missão diária" },
  { icon: Swords, text: "1 desafio por dia" },
  { icon: BarChart3, text: "Ranking e estatísticas" },
];

const PLANS = [
  { name: "Mensal", detail: "30 dias de acesso, contados do dia do pagamento" },
  { name: "Anual", detail: "365 dias de acesso, contados do dia do pagamento" },
];

const fmtDate = (iso) => new Date(iso).toLocaleDateString("pt-BR");

// Tela exibida no lugar de Questões e Flashcards para quem não tem assinatura ativa.
export function PaywallScreen({ access, onBack }) {
  const t = useT();
  const mailto = `mailto:${CONTACT_EMAIL}?subject=${encodeURIComponent("Assinatura FlashCardio")}`;
  const section = { background: t.surface, border: `1px solid ${t.border}`, borderRadius: 16, padding: "16px 18px" };
  const label = { fontSize: 11, fontWeight: 700, letterSpacing: 0.5, textTransform: "uppercase", color: t.textMuted, marginBottom: 10 };

  return (
    <div style={{ maxWidth: 620, margin: "0 auto", paddingBottom: 80 }}>
      <ScreenHeader title="Assinatura" onBack={onBack} />
      <div style={{ padding: "18px 22px", display: "flex", flexDirection: "column", gap: 14 }}>
        <div style={{ textAlign: "center", padding: "10px 0 4px" }}>
          <div
            style={{
              width: 54,
              height: 54,
              borderRadius: "50%",
              background: t.primarySoft,
              display: "inline-flex",
              alignItems: "center",
              justifyContent: "center",
              marginBottom: 12,
            }}
          >
            <Lock size={24} color={t.primary} />
          </div>
          <h2 style={{ margin: 0, fontSize: 20, fontWeight: 700, color: t.text }}>Questões e flashcards são para assinantes</h2>
          <p style={{ margin: "8px 0 0", fontSize: 14, lineHeight: 1.55, color: t.textMuted }}>
            {access.lastExpiredAt
              ? `Sua assinatura venceu em ${fmtDate(access.lastExpiredAt)}. Renove para voltar a estudar sem limites.`
              : "Assine para estudar com todo o banco de questões e flashcards."}
          </p>
        </div>

        <div style={section}>
          <div style={label}>Planos</div>
          <div style={{ display: "flex", flexDirection: "column", gap: 10 }}>
            {PLANS.map((p) => (
              <div key={p.name} style={{ display: "flex", flexDirection: "column", gap: 2 }}>
                <span style={{ fontWeight: 700, fontSize: 15, color: t.text }}>{p.name}</span>
                <span style={{ fontSize: 13, color: t.textMuted }}>{p.detail}</span>
              </div>
            ))}
          </div>
        </div>

        <div style={section}>
          <div style={label}>Continua livre para você</div>
          <div style={{ display: "flex", flexDirection: "column", gap: 9 }}>
            {FREE_ITEMS.map(({ icon: Icon, text }) => (
              <div key={text} style={{ display: "flex", alignItems: "center", gap: 10, fontSize: 14, color: t.text }}>
                <Icon size={17} color={t.primary} />
                {text}
              </div>
            ))}
          </div>
        </div>

        <div style={section}>
          <div style={label}>Como assinar</div>
          <p style={{ margin: "0 0 14px", fontSize: 14, lineHeight: 1.55, color: t.text }}>
            O pagamento é feito por transferência bancária. Escreva para o e-mail abaixo com o plano que você quer, e liberamos o acesso assim que o
            pagamento for confirmado.
          </p>
          <p style={{ margin: "0 0 14px", fontSize: 14, fontWeight: 700, color: t.text, overflowWrap: "anywhere", userSelect: "all" }}>{CONTACT_EMAIL}</p>
          <a href={mailto} style={{ textDecoration: "none" }}>
            <PrimaryButton full>
              <Mail size={15} style={{ marginRight: 7, verticalAlign: -3 }} />
              Pedir a assinatura por e-mail
            </PrimaryButton>
          </a>
        </div>

        <PrimaryButton full variant="ghost" onClick={onBack}>
          Voltar ao início
        </PrimaryButton>
      </div>
    </div>
  );
}
