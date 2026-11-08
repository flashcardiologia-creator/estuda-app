"use client";

import { useT } from "@/components/theme/ThemeProvider";

// Curva do esquecimento de Ebbinghaus com as 4 revisões (20 min, 24 h, 7 dias, 30 dias). É uma ilustração do conceito, não dado
// de quem estuda. Posição no eixo do tempo (0 a 1) e % de retenção lidos do gráfico de referência: cada revisão devolve a
// memória a 100% e a curva seguinte cai mais devagar.
const T0 = 0.03, T1 = 0.26, T2 = 0.52, T3 = 0.85, TEND = 1;
const SEM = [[0, 85], [T0, 55], [T1, 20], [T2, 9], [T3, 4], [TEND, 3]];
export const REVISOES = [
  { n: "1ª", at: T0, from: 55, color: "#2FD34F", pts: [[T0, 100], [T1, 70], [T2, 50], [T3, 31], [TEND, 27]] },
  { n: "2ª", at: T1, from: 70, color: "#C451B3", pts: [[T1, 100], [T2, 77], [T3, 56], [TEND, 51]] },
  { n: "3ª", at: T2, from: 77, color: "#F59A1B", pts: [[T2, 100], [T3, 84], [TEND, 79]] },
  { n: "4ª", at: T3, from: 84, color: "#5B6BFF", pts: [[T3, 100], [TEND, 92]] },
];
const TICKS = [[T0, "20 min"], [T1, "24 h"], [T2, "7 dias"], [T3, "30 dias"]];

export function ForgettingCurve() {
  const t = useT();
  const W = 320, H = 214, L = 40, R = 12, TOP = 34, B = 50;
  const px = (f) => L + f * (W - L - R);
  const py = (r) => TOP + (1 - r / 100) * (H - TOP - B);
  const line = (pts) => pts.map(([f, r], i) => `${i ? "L" : "M"}${px(f).toFixed(1)} ${py(r).toFixed(1)}`).join(" ");
  return (
    <svg
      viewBox={`0 0 ${W} ${H}`}
      width="100%"
      role="img"
      aria-label="Curva do esquecimento de Ebbinghaus: sem revisão a retenção cai para perto de 20% em 24 horas; com revisões em 20 minutos, 24 horas, 7 dias e 30 dias, a memória volta a 100% e cai cada vez mais devagar"
      style={{ display: "block" }}
    >
      {[0, 20, 40, 60, 80, 100].map((r) => (
        <g key={r}>
          <line x1={L} x2={W - R} y1={py(r)} y2={py(r)} stroke={t.border} strokeWidth="1" strokeDasharray={r === 0 ? "" : "3 4"} opacity={r === 0 ? 1 : 0.8} />
          <text x={L - 5} y={py(r) + 3.5} textAnchor="end" fontSize="9" fill={t.textMuted}>{r}</text>
        </g>
      ))}
      <text transform={`translate(9 ${(py(100) + py(0)) / 2}) rotate(-90)`} textAnchor="middle" fontSize="9.5" fontWeight="700" fill={t.textMuted}>% de retenção</text>
      {TICKS.map(([f]) => (
        <line key={f} x1={px(f)} x2={px(f)} y1={py(100)} y2={py(0)} stroke={t.border} strokeWidth="1" opacity="0.7" />
      ))}
      <path d={line(SEM)} fill="none" stroke={t.red} strokeWidth="2.4" strokeLinejoin="round" strokeLinecap="round" />
      <circle cx={px(0)} cy={py(85)} r="3.3" fill={t.red} />
      {REVISOES.map((r) => (
        <g key={r.n}>
          <path d={line(r.pts)} fill="none" stroke={r.color} strokeWidth="2.2" strokeLinejoin="round" strokeLinecap="round" />
          <line x1={px(r.at)} x2={px(r.at)} y1={py(r.from)} y2={py(100)} stroke={r.color} strokeWidth="1.6" strokeDasharray="3 3" />
          <circle cx={px(r.at)} cy={py(r.from)} r="3.6" fill={r.color} stroke={t.surface} strokeWidth="1.2" />
          <circle cx={px(r.at)} cy={TOP - 17} r="10.5" fill={t.surface} stroke={r.color} strokeWidth="1.8" />
          <text x={px(r.at)} y={TOP - 13.5} textAnchor="middle" fontSize="10" fontWeight="800" fill={r.color}>{r.n}</text>
        </g>
      ))}
      <circle cx={px(TEND)} cy={py(92)} r="3.4" fill="#5B6BFF" />
      {TICKS.map(([f, label]) => (
        <text key={label} x={px(f)} y={H - 30} textAnchor="middle" fontSize="9" fontWeight="700" fill={t.textMuted}>{label}</text>
      ))}
      <text x={(px(0) + px(TEND)) / 2} y={H - 10} textAnchor="middle" fontSize="10.5" fontWeight="800" fill={t.textMuted}>Tempo</text>
    </svg>
  );
}
