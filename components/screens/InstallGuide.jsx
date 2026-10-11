"use client";

import { useState } from "react";
import { ChevronLeft, Flame } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { Chip } from "@/components/ui/Primitives";

// Passo a passo para colocar o FlashCardio na tela inicial do celular, como se fosse um aplicativo.
// Cada passo tem uma ilustração do que a pessoa vai ver na tela (desenhada aqui em SVG).

const PHONE_W = 150;
const PHONE_H = 280;
const SCREEN = "#F2F2F7";
const INK = "#1C1C1E";
const SOFT = "#C7C7CC";

function Phone({ children, dark }) {
  return (
    <svg viewBox={`0 0 ${PHONE_W} ${PHONE_H}`} width={PHONE_W} height={PHONE_H} role="img" aria-hidden="true" style={{ display: "block", flexShrink: 0 }}>
      <rect x="1.5" y="1.5" width={PHONE_W - 3} height={PHONE_H - 3} rx="20" fill={dark ? "#0B1220" : SCREEN} stroke="#6B7280" strokeWidth="3" />
      <rect x="55" y="7" width="40" height="9" rx="4.5" fill="#111827" />
      {children}
    </svg>
  );
}

function Ring({ x, y, r = 14, color }) {
  return <circle cx={x} cy={y} r={r} fill="none" stroke={color} strokeWidth="3" />;
}

function ShareGlyph({ x, y, color = "#0A84FF" }) {
  return (
    <g transform={`translate(${x - 8} ${y - 9})`} stroke={color} strokeWidth="1.8" fill="none" strokeLinecap="round" strokeLinejoin="round">
      <path d="M4 7H3.5A1.5 1.5 0 0 0 2 8.5v8A1.5 1.5 0 0 0 3.5 18h9a1.5 1.5 0 0 0 1.5-1.5v-8A1.5 1.5 0 0 0 12.5 7H12" />
      <path d="M8 12V1.5M5 4.5 8 1.5l3 3" />
    </g>
  );
}

function AppIcon({ x, y, size = 30 }) {
  return (
    <g transform={`translate(${x} ${y})`}>
      <rect width={size} height={size} rx={size * 0.22} fill="#0F1830" />
      <g transform={`translate(${size * 0.2} ${size * 0.2}) scale(${(size * 0.6) / 24})`} fill="#F2A93B" stroke="#F2A93B" strokeWidth="1.2" strokeLinejoin="round">
        <path d="M8.5 14.5A2.5 2.5 0 0 0 11 12c0-1.38-.5-2-1-3-1.072-2.143-.224-4.054 2-6 .5 2.5 2 4.9 4 6.5 2 1.6 3 3.5 3 5.5a7 7 0 1 1-14 0c0-1.153.433-2.294 1-3a2.5 2.5 0 0 0 2.5 2.5z" />
      </g>
    </g>
  );
}

function SitePage({ y0 = 70 }) {
  return (
    <g>
      <rect x="12" y={y0} width="126" height="70" rx="8" fill="#0F1830" />
      <g transform={`translate(52 ${y0 + 14}) scale(1.1)`} fill="#F2A93B" stroke="#F2A93B" strokeWidth="1" strokeLinejoin="round">
        <path d="M8.5 14.5A2.5 2.5 0 0 0 11 12c0-1.38-.5-2-1-3-1.072-2.143-.224-4.054 2-6 .5 2.5 2 4.9 4 6.5 2 1.6 3 3.5 3 5.5a7 7 0 1 1-14 0c0-1.153.433-2.294 1-3a2.5 2.5 0 0 0 2.5 2.5z" />
      </g>
      <text x="75" y={y0 + 56} textAnchor="middle" fontSize="11" fontWeight="700" fill="#fff" fontFamily="system-ui, sans-serif">FlashCardio</text>
      <rect x="12" y={y0 + 80} width="126" height="12" rx="6" fill={SOFT} />
      <rect x="12" y={y0 + 98} width="90" height="12" rx="6" fill={SOFT} />
    </g>
  );
}

// ---------- iPhone (Safari)
function IosOpen({ color }) {
  return (
    <Phone>
      <rect x="10" y="28" width="130" height="20" rx="10" fill="#E5E5EA" />
      <text x="75" y="42" textAnchor="middle" fontSize="8.5" fill={INK} fontFamily="system-ui, sans-serif">flashcardio</text>
      <SitePage y0={62} />
      <rect x="10" y="236" width="130" height="34" rx="12" fill="#fff" />
      <Ring x={75} y={253} r={22} color={color} />
      <text x="75" y="256" textAnchor="middle" fontSize="8" fill={INK} fontFamily="system-ui, sans-serif">Safari</text>
    </Phone>
  );
}
function IosShare({ color }) {
  return (
    <Phone>
      <SitePage y0={50} />
      <rect x="6" y="232" width="138" height="42" rx="14" fill="#fff" />
      <path d="M22 253l-6 0M16 253l4-4M16 253l4 4" stroke={SOFT} strokeWidth="2" fill="none" strokeLinecap="round" />
      <ShareGlyph x={75} y={253} />
      <rect x="112" y="248" width="14" height="10" rx="2" fill="none" stroke={SOFT} strokeWidth="2" />
      <Ring x={75} y={253} r={17} color={color} />
    </Phone>
  );
}
function IosMenu({ color }) {
  const rows = ["Copiar", "Adicionar aos Favoritos", "Adicionar à Tela de Início", "Buscar na Página"];
  return (
    <Phone>
      <rect x="0" y="120" width={PHONE_W} height="160" rx="18" fill="#fff" />
      <rect x="62" y="126" width="26" height="4" rx="2" fill={SOFT} />
      {rows.map((r, i) => {
        const y = 140 + i * 31;
        const hot = i === 2;
        return (
          <g key={r}>
            {hot && <rect x="8" y={y - 4} width="134" height="28" rx="8" fill="#E8F1FF" />}
            <text x="16" y={y + 14} fontSize="9" fill={INK} fontWeight={hot ? 700 : 400} fontFamily="system-ui, sans-serif">{r}</text>
            <rect x="124" y={y + 5} width="12" height="12" rx="3" fill="none" stroke={hot ? "#0A84FF" : SOFT} strokeWidth="1.6" />
            {hot && <path d="M130 8.5v6M127 11.5h6" transform={`translate(0 ${y})`} stroke="#0A84FF" strokeWidth="1.6" strokeLinecap="round" />}
          </g>
        );
      })}
      <rect x="5" y={140 + 2 * 31 - 6} width="140" height="32" rx="10" fill="none" stroke={color} strokeWidth="3" />
    </Phone>
  );
}
function IosAdd({ color }) {
  return (
    <Phone>
      <rect x="0" y="40" width={PHONE_W} height="240" rx="18" fill="#fff" />
      <text x="14" y="62" fontSize="9" fill="#0A84FF" fontFamily="system-ui, sans-serif">Cancelar</text>
      <text x="136" y="62" textAnchor="end" fontSize="9" fontWeight="700" fill="#0A84FF" fontFamily="system-ui, sans-serif">Adicionar</text>
      <rect x="95" y="49" width="46" height="18" rx="9" fill="none" stroke={color} strokeWidth="3" />
      <rect x="10" y="80" width="130" height="50" rx="10" fill={SCREEN} />
      <AppIcon x={18} y={90} size={30} />
      <text x="58" y="108" fontSize="10" fontWeight="700" fill={INK} fontFamily="system-ui, sans-serif">FlashCardio</text>
      <text x="58" y="120" fontSize="7" fill="#8E8E93" fontFamily="system-ui, sans-serif">flashcardio</text>
    </Phone>
  );
}
function HomeDone() {
  const cells = [0, 1, 2, 3, 4, 5, 6, 7];
  return (
    <Phone dark>
      <rect x="1.5" y="1.5" width={PHONE_W - 3} height={PHONE_H - 3} rx="20" fill="url(#bgHome)" />
      <defs>
        <linearGradient id="bgHome" x1="0" y1="0" x2="1" y2="1">
          <stop offset="0" stopColor="#1E3A8A" />
          <stop offset="1" stopColor="#4C1D95" />
        </linearGradient>
      </defs>
      {cells.map((i) => {
        const col = i % 4, row = Math.floor(i / 4);
        const isApp = i === 5;
        return isApp ? (
          <g key={i}>
            <AppIcon x={14 + col * 33} y={36 + row * 46} size={26} />
            <text x={27 + col * 33} y={74 + row * 46} textAnchor="middle" fontSize="6.5" fill="#fff" fontFamily="system-ui, sans-serif">FlashCardio</text>
          </g>
        ) : (
          <rect key={i} x={14 + col * 33} y={36 + row * 46} width="26" height="26" rx="6" fill="rgba(255,255,255,0.22)" />
        );
      })}
      <rect x="14" y="236" width="122" height="30" rx="12" fill="rgba(255,255,255,0.22)" />
      <text x="75" y="160" textAnchor="middle" fontSize="9" fill="#fff" fontFamily="system-ui, sans-serif" fontWeight="700">
        Na tela inicial
      </text>
    </Phone>
  );
}

// ---------- Android (Chrome)
function AndOpen({ color }) {
  return (
    <Phone>
      <rect x="0" y="22" width={PHONE_W} height="32" fill="#fff" />
      <rect x="10" y="28" width="104" height="20" rx="10" fill="#EEF0F3" />
      <text x="62" y="42" textAnchor="middle" fontSize="8.5" fill={INK} fontFamily="system-ui, sans-serif">flashcardio</text>
      <circle cx="128" cy="32" r="2" fill={INK} />
      <circle cx="128" cy="38" r="2" fill={INK} />
      <circle cx="128" cy="44" r="2" fill={INK} />
      <SitePage y0={68} />
      <rect x="8" y="26" width="108" height="24" rx="12" fill="none" stroke={color} strokeWidth="3" />
    </Phone>
  );
}
function AndMenuBtn({ color }) {
  return (
    <Phone>
      <rect x="0" y="22" width={PHONE_W} height="32" fill="#fff" />
      <rect x="10" y="28" width="100" height="20" rx="10" fill="#EEF0F3" />
      <circle cx="128" cy="32" r="2" fill={INK} />
      <circle cx="128" cy="38" r="2" fill={INK} />
      <circle cx="128" cy="44" r="2" fill={INK} />
      <Ring x={128} y={38} r={14} color={color} />
      <SitePage y0={68} />
    </Phone>
  );
}
function AndInstall({ color }) {
  const rows = ["Nova guia", "Histórico", "Instalar app", "Compartilhar…"];
  return (
    <Phone>
      <rect x="0" y="22" width={PHONE_W} height="32" fill="#fff" />
      <rect x="22" y="40" width="122" height="150" rx="10" fill="#fff" stroke="#D1D5DB" strokeWidth="1.5" />
      {rows.map((r, i) => {
        const y = 52 + i * 32;
        const hot = i === 2;
        return (
          <g key={r}>
            {hot && <rect x="26" y={y - 4} width="114" height="28" rx="6" fill="#E8F1FF" />}
            <text x="34" y={y + 14} fontSize="9" fill={INK} fontWeight={hot ? 700 : 400} fontFamily="system-ui, sans-serif">{r}</text>
          </g>
        );
      })}
      <rect x="25" y={52 + 2 * 32 - 7} width="118" height="32" rx="8" fill="none" stroke={color} strokeWidth="3" />
    </Phone>
  );
}
function AndConfirm({ color }) {
  return (
    <Phone>
      <rect x="0" y="0" width={PHONE_W} height={PHONE_H} rx="20" fill="rgba(0,0,0,0.35)" />
      <rect x="12" y="90" width="126" height="104" rx="16" fill="#fff" />
      <text x="24" y="112" fontSize="9.5" fontWeight="700" fill={INK} fontFamily="system-ui, sans-serif">Instalar app?</text>
      <AppIcon x={24} y={122} size={28} />
      <text x="58" y="140" fontSize="9" fontWeight="700" fill={INK} fontFamily="system-ui, sans-serif">FlashCardio</text>
      <text x="58" y="151" fontSize="6.5" fill="#6B7280" fontFamily="system-ui, sans-serif">flashcardio</text>
      <text x="62" y="182" fontSize="8.5" fill="#1A73E8" fontFamily="system-ui, sans-serif">Cancelar</text>
      <text x="124" y="182" textAnchor="end" fontSize="8.5" fontWeight="700" fill="#1A73E8" fontFamily="system-ui, sans-serif">Instalar</text>
      <rect x="86" y="168" width="48" height="20" rx="10" fill="none" stroke={color} strokeWidth="3" />
    </Phone>
  );
}

const STEPS = {
  ios: [
    { title: "Abra no Safari", text: "Entre no endereço do FlashCardio usando o Safari, o navegador azul do iPhone. Em outros navegadores essa opção pode não aparecer.", Art: IosOpen },
    { title: "Toque em Compartilhar", text: "Na barra de baixo, toque no botão de compartilhar: um quadrado com uma seta para cima.", Art: IosShare },
    { title: "Adicionar à Tela de Início", text: "Role a lista para baixo e toque em “Adicionar à Tela de Início”. Se essa opção não aparecer de primeira, pode ser necessário tocar em “Ver Mais” no fim da lista.", Art: IosMenu },
    { title: "Confirme em Adicionar", text: "Se quiser, mude o nome. Depois toque em “Adicionar”, no canto superior direito.", Art: IosAdd },
    { title: "Pronto!", text: "O ícone do FlashCardio aparece na tela inicial. Abra por ele, como qualquer aplicativo, em tela cheia.", Art: HomeDone },
  ],
  android: [
    { title: "Abra no Chrome", text: "Entre no endereço do FlashCardio usando o Google Chrome.", Art: AndOpen },
    { title: "Toque nos três pontinhos", text: "No canto superior direito do Chrome, toque no menu de três pontinhos.", Art: AndMenuBtn },
    { title: "Instalar app", text: "Toque em “Instalar app”. Se esse nome não aparecer, use “Adicionar à tela inicial”.", Art: AndInstall },
    { title: "Confirme em Instalar", text: "Na janela que abrir, toque em “Instalar” (ou “Adicionar”).", Art: AndConfirm },
    { title: "Pronto!", text: "O ícone do FlashCardio aparece na tela inicial e na lista de aplicativos. Abra por ele, em tela cheia.", Art: HomeDone },
  ],
};

export function InstallGuide({ onBack }) {
  const t = useT();
  // Só monta depois do clique (no navegador), então pode ler o aparelho direto: abre já na aba
  // de quem está vendo (iPhone/iPad ou Android).
  const [os, setOs] = useState(() => {
    const ua = navigator.userAgent || "";
    return /iPhone|iPad|iPod/i.test(ua) || (/Macintosh/i.test(ua) && navigator.maxTouchPoints > 1) ? "ios" : "android";
  });
  const steps = STEPS[os];

  return (
    <div style={{ width: "100%", maxWidth: 440, background: t.surface, border: `1px solid ${t.border}`, borderRadius: 20, padding: "24px 22px" }}>
      <h2 style={{ fontSize: 19, fontWeight: 700, color: t.text, margin: "0 0 6px", textAlign: "center" }}>Baixar aplicativo</h2>
      <p style={{ fontSize: 13, color: t.textMuted, margin: "0 0 16px", textAlign: "center", lineHeight: 1.5 }}>
        Coloque o FlashCardio na tela inicial do celular e use como um aplicativo, sem baixar nada em loja.
      </p>

      <div style={{ display: "flex", justifyContent: "center", gap: 8, marginBottom: 18 }}>
        <Chip active={os === "android"} onClick={() => setOs("android")}>Android</Chip>
        <Chip active={os === "ios"} onClick={() => setOs("ios")}>iPhone (iOS)</Chip>
      </div>

      <div style={{ display: "flex", flexDirection: "column", gap: 16 }}>
        {steps.map((s, i) => (
          <div
            key={`${os}-${i}`}
            style={{ display: "flex", gap: 14, alignItems: "center", flexWrap: "wrap", justifyContent: "center", background: t.surfaceAlt, border: `1px solid ${t.border}`, borderRadius: 16, padding: 14 }}
          >
            <s.Art color={t.primary} />
            <div style={{ flex: "1 1 160px", minWidth: 0 }}>
              <div style={{ display: "flex", alignItems: "center", gap: 8, marginBottom: 6 }}>
                <span style={{ width: 24, height: 24, borderRadius: 12, background: t.primary, color: "#fff", fontSize: 13, fontWeight: 700, display: "flex", alignItems: "center", justifyContent: "center", flexShrink: 0 }}>
                  {i + 1}
                </span>
                <span style={{ fontSize: 14.5, fontWeight: 700, color: t.text }}>{s.title}</span>
              </div>
              <div style={{ fontSize: 13, color: t.textMuted, lineHeight: 1.55 }}>{s.text}</div>
            </div>
          </div>
        ))}
      </div>

      <div style={{ fontSize: 12, color: t.textMuted, textAlign: "center", marginTop: 16, lineHeight: 1.5 }}>
        <Flame size={12} color={t.amber} fill={t.amber} style={{ verticalAlign: -1, marginRight: 4 }} />
        As telas acima são ilustrações; o desenho do seu aparelho pode variar um pouco.
      </div>

      <div style={{ textAlign: "center", marginTop: 14 }}>
        <button
          onClick={onBack}
          style={{ background: "transparent", border: "none", color: t.primary, fontSize: 13, fontWeight: 600, cursor: "pointer", display: "inline-flex", alignItems: "center", gap: 4 }}
        >
          <ChevronLeft size={15} /> Voltar para entrar
        </button>
      </div>
    </div>
  );
}
