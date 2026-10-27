"use client";

import { useCallback, useEffect, useState } from "react";
import { RefreshCw, ChevronDown, ChevronUp } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { ScreenHeader, PrimaryButton } from "@/components/ui/Primitives";
import { fetchAdminStats, fetchAdminExtra, fetchAdminAcessos } from "@/lib/data/adminStats";
import { formatBRL } from "@/lib/billing";

const nf = (n, digits = 0) => Number(n || 0).toLocaleString("pt-BR", { minimumFractionDigits: digits, maximumFractionDigits: digits });
// Número que pode faltar se o SQL do painel ainda não foi atualizado no banco: mostra "—" em vez de 0.
const show = (n) => (n == null ? "—" : nf(n));
const pct = (a, b, digits = 1) => (b ? `${nf((a / b) * 100, digits)}%` : "0%");
const compact = (n) => (n >= 10000 ? `${nf(n / 1000, 0)}k` : n >= 1000 ? `${nf(n / 1000, 1)}k` : String(n));

function Section({ title, children }) {
  const t = useT();
  return (
    <section style={{ marginTop: 22 }}>
      <h2 style={{ margin: "0 2px 10px", fontSize: 12, fontWeight: 700, letterSpacing: 0.5, textTransform: "uppercase", color: t.textMuted }}>{title}</h2>
      {children}
    </section>
  );
}

// Quais seções retráteis estão abertas. Fica fora do componente para valer também depois de abrir uma questão
// e voltar ao painel (a tela é montada de novo, mas a página não recarrega).
const openSections = {};

// Seção que abre e fecha ao tocar no título. Começa fechada. count = número mostrado ao lado do título.
function CollapsibleSection({ id, title, count, children }) {
  const t = useT();
  const [open, setOpen] = useState(!!openSections[id]);
  const toggle = () => {
    openSections[id] = !open;
    setOpen(!open);
  };
  return (
    <section style={{ marginTop: 22 }}>
      <button
        type="button"
        onClick={toggle}
        aria-expanded={open}
        style={{ display: "flex", alignItems: "center", gap: 8, width: "100%", margin: 0, padding: "11px 14px", background: t.surface, border: `1px solid ${t.border}`, borderRadius: 14, cursor: "pointer", textAlign: "left", color: t.text }}
      >
        <span style={{ flex: 1, minWidth: 0, fontSize: 12, fontWeight: 700, letterSpacing: 0.5, textTransform: "uppercase", color: t.textMuted }}>{title}</span>
        {count != null && (
          <span style={{ fontSize: 12, fontWeight: 800, color: t.primary, fontVariantNumeric: "tabular-nums", flexShrink: 0 }}>{count}</span>
        )}
        {open ? <ChevronUp size={16} color={t.textMuted} /> : <ChevronDown size={16} color={t.textMuted} />}
      </button>
      {open && <div style={{ marginTop: 10 }}>{children}</div>}
    </section>
  );
}

function Grid({ children, cols = 2 }) {
  return <div style={{ display: "grid", gridTemplateColumns: `repeat(${cols}, minmax(0, 1fr))`, gap: 10 }}>{children}</div>;
}

// wide = ocupa a linha toda (usado quando há uma explicação mais longa abaixo do número).
function Kpi({ label, value, sub, color, wide = false }) {
  const t = useT();
  return (
    <div style={{ background: t.surface, border: `1px solid ${t.border}`, borderRadius: 14, padding: "12px 14px", minWidth: 0, ...(wide ? { gridColumn: "1 / -1" } : {}) }}>
      <div style={{ fontSize: 11.5, color: t.textMuted, fontWeight: 600, lineHeight: 1.3 }}>{label}</div>
      <div style={{ fontSize: 24, fontWeight: 800, color: color || t.text, marginTop: 4, fontVariantNumeric: "tabular-nums", lineHeight: 1.1 }}>{value}</div>
      {sub && <div style={{ fontSize: 11.5, color: t.textMuted, marginTop: 4, lineHeight: 1.35 }}>{sub}</div>}
    </div>
  );
}

function ChartCard({ title, children, note }) {
  const t = useT();
  return (
    <div style={{ background: t.surface, border: `1px solid ${t.border}`, borderRadius: 14, padding: "14px 14px 10px", marginTop: 10 }}>
      <div style={{ fontSize: 13, fontWeight: 700, color: t.text, marginBottom: 8 }}>{title}</div>
      {children}
      {note && <div style={{ fontSize: 11.5, color: t.textMuted, marginTop: 6, lineHeight: 1.4 }}>{note}</div>}
    </div>
  );
}

// Barras dos últimos 14 dias (o dia de hoje fica mais forte). data = [{ d: "2026-10-18", n: 12 }].
function BarChart({ data, color, label }) {
  const t = useT();
  const W = 340;
  const H = 150;
  const padTop = 16;
  const padBottom = 22;
  const n = data.length;
  const max = Math.max(1, ...data.map((p) => p.n));
  const slot = W / n;
  const plotH = H - padTop - padBottom;
  return (
    <svg viewBox={`0 0 ${W} ${H}`} width="100%" role="img" aria-label={label} style={{ display: "block" }}>
      <line x1="0" x2={W} y1={H - padBottom} y2={H - padBottom} stroke={t.border} strokeWidth="1" />
      {data.map((p, i) => {
        const h = (plotH * p.n) / max;
        const x = i * slot + slot * 0.16;
        const y = H - padBottom - h;
        const isToday = i === n - 1;
        return (
          <g key={p.d}>
            <rect x={x} y={y} width={slot * 0.68} height={Math.max(h, p.n > 0 ? 2 : 0)} rx="3" fill={color} opacity={isToday ? 1 : 0.55} />
            {p.n > 0 && (
              <text x={i * slot + slot / 2} y={y - 4} textAnchor="middle" fontSize="9.5" fontWeight="700" fill={isToday ? t.text : t.textMuted}>
                {compact(p.n)}
              </text>
            )}
            <text x={i * slot + slot / 2} y={H - 7} textAnchor="middle" fontSize="9.5" fill={isToday ? t.text : t.textMuted} fontWeight={isToday ? 700 : 400}>
              {p.d.slice(8)}
            </text>
          </g>
        );
      })}
    </svg>
  );
}

// Rosca com legenda. parts = [{ label, value, color }].
function Donut({ parts, centerLabel }) {
  const t = useT();
  const total = parts.reduce((s, p) => s + p.value, 0);
  const R = 15.9155; // circunferência = 100
  let acc = 0;
  return (
    <div style={{ display: "flex", alignItems: "center", gap: 18, flexWrap: "wrap" }}>
      <svg viewBox="0 0 42 42" width="132" height="132" role="img" aria-label="Distribuição dos usuários por plano" style={{ flexShrink: 0 }}>
        <circle cx="21" cy="21" r={R} fill="none" stroke={t.surfaceAlt} strokeWidth="6" />
        {total > 0 &&
          parts
            .filter((p) => p.value > 0)
            .map((p) => {
              const len = (p.value / total) * 100;
              const el = (
                <circle
                  key={p.label}
                  cx="21"
                  cy="21"
                  r={R}
                  fill="none"
                  stroke={p.color}
                  strokeWidth="6"
                  strokeDasharray={`${len} ${100 - len}`}
                  strokeDashoffset={25 - acc}
                />
              );
              acc += len;
              return el;
            })}
        <text x="21" y="21.5" textAnchor="middle" fontSize="7.5" fontWeight="800" fill={t.text}>
          {nf(total)}
        </text>
        <text x="21" y="27" textAnchor="middle" fontSize="3.4" fill={t.textMuted}>
          {centerLabel}
        </text>
      </svg>
      <div style={{ display: "flex", flexDirection: "column", gap: 8, minWidth: 0, flex: 1 }}>
        {parts.map((p) => (
          <div key={p.label} style={{ display: "flex", alignItems: "center", gap: 8, fontSize: 13, color: t.text }}>
            <span style={{ width: 10, height: 10, borderRadius: 3, background: p.color, flexShrink: 0 }} />
            <span style={{ flex: 1, minWidth: 0 }}>{p.label}</span>
            <b style={{ fontVariantNumeric: "tabular-nums" }}>{nf(p.value)}</b>
            <span style={{ color: t.textMuted, width: 52, textAlign: "right", fontVariantNumeric: "tabular-nums" }}>{pct(p.value, total)}</span>
          </div>
        ))}
      </div>
    </div>
  );
}

function hhmm(iso) {
  return new Date(iso).toLocaleTimeString("pt-BR", { hour: "2-digit", minute: "2-digit" });
}

// "21/10 às 14:05" no horário de Brasília.
function dataHora(iso) {
  const d = new Date(iso);
  const o = { timeZone: "America/Sao_Paulo" };
  const dia = d.toLocaleDateString("pt-BR", { ...o, day: "2-digit", month: "2-digit" });
  const hora = d.toLocaleTimeString("pt-BR", { ...o, hour: "2-digit", minute: "2-digit" });
  return `${dia} às ${hora}`;
}

const TABS = [
  { id: "usuarios", label: "Usuários" },
  { id: "assinantes", label: "Assinantes" },
  { id: "questoes", label: "Questões" },
  { id: "flashcards", label: "Flashcards" },
  { id: "desafios", label: "Desafios" },
  { id: "missao", label: "Missão diária" },
  { id: "acessos", label: "Acessos" },
];

// Abas do painel (mesmo estilo das abas de Desafios). Rolam de lado quando não cabem na tela.
function TabBar({ tab, onTab }) {
  const t = useT();
  return (
    <div role="tablist" aria-label="Seções do painel" style={{ display: "flex", gap: 8, overflowX: "auto", margin: "14px -22px 0", padding: "2px 22px 6px", scrollbarWidth: "none" }}>
      {TABS.map(({ id, label }) => {
        const on = tab === id;
        return (
          <button
            key={id}
            type="button"
            role="tab"
            aria-selected={on}
            onClick={() => onTab(id)}
            style={{
              flex: "none",
              height: 38,
              padding: "0 15px",
              borderRadius: 12,
              cursor: "pointer",
              fontSize: 13.5,
              fontWeight: 700,
              whiteSpace: "nowrap",
              background: on ? t.primarySoft : t.surface,
              border: `1px solid ${on ? t.primary : t.border}`,
              color: on ? (t.name === "dark" ? "#C4B5FF" : t.primary) : t.textMuted,
            }}
          >
            {label}
          </button>
        );
      })}
    </div>
  );
}

// Aviso quando a parte 2 do painel (painel_dados_extra.sql) ainda não foi rodada ou falhou.
function ExtraNotice({ extra }) {
  const t = useT();
  if (extra.status === "loading") return <div style={{ fontSize: 13, color: t.textMuted, padding: "6px 2px" }}>Carregando…</div>;
  return (
    <div style={{ background: t.surface, border: `1px solid ${t.border}`, borderRadius: 14, padding: 16, fontSize: 13.5, lineHeight: 1.5, color: t.textMuted }}>
      {extra.status === "missing"
        ? "Esta lista precisa do SQL painel_dados_extra.sql rodado no Supabase. Rode-o e toque em Atualizar."
        : "Não foi possível carregar esta lista agora. Toque em Atualizar para tentar de novo."}
    </div>
  );
}

// Aba Missão diária: quantas pessoas têm o lembrete por notificação ligado. n = { ativadas, desativadas, aparelhos, novas_7d }.
function NotificacoesResumo({ n }) {
  const t = useT();
  const total = n.ativadas + n.desativadas;
  return (
    <>
      <Grid>
        <Kpi label="Com notificação ativada" value={nf(n.ativadas)} color={t.green} sub={`${pct(n.ativadas, total)} dos usuários`} />
        <Kpi label="Com notificação desativada" value={nf(n.desativadas)} color={t.red} sub={`${pct(n.desativadas, total)} dos usuários`} />
        <Kpi label="Aparelhos cadastrados" value={nf(n.aparelhos)} sub={n.ativadas ? `${nf(n.aparelhos / n.ativadas, 1)} por pessoa` : undefined} />
        <Kpi label="Ativaram nos últimos 7 dias" value={nf(n.novas_7d)} color={t.primary} />
      </Grid>
      <div style={{ display: "flex", height: 10, borderRadius: 999, overflow: "hidden", background: t.surfaceAlt, marginTop: 12 }} role="img" aria-label={`${pct(n.ativadas, total)} com notificação ativada`}>
        <div style={{ width: `${total ? (n.ativadas / total) * 100 : 0}%`, background: t.green }} />
        <div style={{ width: `${total ? (n.desativadas / total) * 100 : 0}%`, background: t.red, opacity: 0.75 }} />
      </div>
      <div style={{ fontSize: 11.5, color: t.textMuted, marginTop: 8, lineHeight: 1.45 }}>
        Ativada = a pessoa ligou o lembrete em Minha Conta → Permissões em pelo menos um aparelho. Desativada = nunca ligou, desligou, ou o aparelho parou de receber. Não dá para separar quem bloqueou no navegador de quem nunca viu o convite. O Bot Braunwald fica fora da conta.
      </div>
    </>
  );
}

// Lista de pessoas com um número à direita. rows = [{ nome, email, n }]; right(row) devolve o texto do número.
function PeopleList({ rows, right, empty = "Ainda não há dados.", numbered = true }) {
  const t = useT();
  if (!rows.length) return <div style={{ fontSize: 13, color: t.textMuted, padding: "4px 2px" }}>{empty}</div>;
  return (
    <ol style={{ listStyle: "none", margin: 0, padding: 0, background: t.surface, border: `1px solid ${t.border}`, borderRadius: 14, overflow: "hidden" }}>
      {rows.map((r, i) => (
        <li key={`${r.email}-${i}`} style={{ display: "flex", alignItems: "center", gap: 12, padding: "11px 14px", borderTop: i ? `1px solid ${t.border}` : "none" }}>
          {numbered && (
            <span style={{ width: 22, fontSize: 13, fontWeight: 800, color: i < 3 ? t.amber : t.textMuted, fontVariantNumeric: "tabular-nums", textAlign: "center", flexShrink: 0 }}>{i + 1}</span>
          )}
          <div style={{ flex: 1, minWidth: 0 }}>
            <div style={{ fontSize: 13.5, fontWeight: 700, color: t.text, overflow: "hidden", textOverflow: "ellipsis", whiteSpace: "nowrap" }}>{r.nome || "(sem nome)"}</div>
            <div style={{ fontSize: 11.5, color: t.textMuted, overflow: "hidden", textOverflow: "ellipsis", whiteSpace: "nowrap" }}>{r.email}</div>
          </div>
          <div style={{ fontSize: 14, fontWeight: 800, color: t.text, fontVariantNumeric: "tabular-nums", textAlign: "right", flexShrink: 0 }}>{right(r)}</div>
        </li>
      ))}
    </ol>
  );
}

// Questões do ranking de erros/acertos. Tocar abre a questão sozinha, numa sessão temporária.
function QuestionRank({ rows, kind, onOpen, busyId }) {
  const t = useT();
  if (!rows.length) return <div style={{ fontSize: 13, color: t.textMuted, padding: "4px 2px" }}>Ainda não há respostas suficientes.</div>;
  const erros = kind === "erros";
  const color = erros ? t.red : t.green;
  return (
    <ol style={{ listStyle: "none", margin: 0, padding: 0, background: t.surface, border: `1px solid ${t.border}`, borderRadius: 14, overflow: "hidden" }}>
      {rows.map((r, i) => {
        const main = erros ? r.erros : r.acertos;
        const share = r.total ? Math.round((main / r.total) * 100) : 0;
        return (
          <li key={r.id} style={{ borderTop: i ? `1px solid ${t.border}` : "none" }}>
            <button
              type="button"
              onClick={() => onOpen(r.id)}
              disabled={busyId === r.id}
              style={{ display: "flex", alignItems: "flex-start", gap: 12, width: "100%", padding: "12px 14px", background: "transparent", border: "none", cursor: "pointer", textAlign: "left", color: t.text, opacity: busyId === r.id ? 0.6 : 1 }}
            >
              <span style={{ width: 22, fontSize: 13, fontWeight: 800, color: i < 3 ? t.amber : t.textMuted, fontVariantNumeric: "tabular-nums", textAlign: "center", flexShrink: 0, paddingTop: 1 }}>{i + 1}</span>
              <span style={{ flex: 1, minWidth: 0 }}>
                <span style={{ display: "block", fontSize: 11.5, color: t.textMuted, fontWeight: 600 }}>
                  {[r.tema, r.instituicao, r.ano].filter(Boolean).join(" · ")}
                </span>
                <span style={{ display: "-webkit-box", WebkitLineClamp: 2, WebkitBoxOrient: "vertical", overflow: "hidden", fontSize: 13.5, lineHeight: 1.4, marginTop: 2 }}>{r.enunciado || "(sem enunciado)"}</span>
              </span>
              <span style={{ textAlign: "right", flexShrink: 0 }}>
                <span style={{ display: "block", fontSize: 16, fontWeight: 800, color, fontVariantNumeric: "tabular-nums" }}>{nf(main)}</span>
                <span style={{ display: "block", fontSize: 11, color: t.textMuted, fontVariantNumeric: "tabular-nums" }}>
                  {share}% de {nf(r.total)}
                </span>
              </span>
            </button>
          </li>
        );
      })}
    </ol>
  );
}

const ACESSOS_ETAPAS = [
  ["tela", "Abriram a tela de entrada"],
  ["quiz_visto", "Viram o quiz"],
  ["quiz_inicio", "Começaram o quiz"],
  ["r1", "Responderam a questão 1"],
  ["r2", "Responderam a questão 2"],
  ["r3", "Responderam a questão 3"],
  ["quiz_fim", "Viram o resultado"],
  ["criar", "Clicaram em \"Criar minha conta\""],
  ["envio", "Enviaram o cadastro"],
  ["conta", "Criaram a conta"],
];

// Onde quem NÃO criou conta parou (a última etapa que alcançou).
const ACESSOS_PARARAM = [
  ["tela", "Só abriram a tela, sem ver o quiz"],
  ["intro", "Viram o quiz e não começaram"],
  ["q1", "Pararam na questão 1"],
  ["q2", "Pararam na questão 2"],
  ["q3", "Pararam na questão 3"],
  ["resultado", "Viram o resultado e não clicaram em Criar conta"],
  ["criar", "Clicaram em Criar conta e não enviaram o cadastro"],
  ["envio", "Enviaram o cadastro e não concluíram"],
];

const ACESSOS_TEMPO = [
  ["ate10", "Menos de 10 s"],
  ["de10a30", "10 a 30 s"],
  ["de30a60", "30 s a 1 min"],
  ["de1a3min", "1 a 3 min"],
  ["mais3min", "Mais de 3 min"],
];

// Duração em segundos -> "45 s" ou "2 min 10 s".
function dur(s) {
  if (s == null) return "—";
  const r = Math.round(s);
  return r < 60 ? `${r} s` : `${Math.floor(r / 60)} min ${r % 60} s`;
}

// Linhas com barra proporcional: rows = [{ label, n, sub? }]; base = valor que ocupa a barra inteira.
function BarRows({ rows, base, color }) {
  const t = useT();
  return (
    <div style={{ background: t.surface, border: `1px solid ${t.border}`, borderRadius: 14, padding: "6px 14px" }}>
      {rows.map((r, i) => (
        <div key={r.label} style={{ padding: "10px 0", borderTop: i ? `1px solid ${t.border}` : "none" }}>
          <div style={{ display: "flex", alignItems: "baseline", gap: 10 }}>
            <span style={{ flex: 1, minWidth: 0, fontSize: 13, color: t.text, lineHeight: 1.35 }}>{r.label}</span>
            <span style={{ fontSize: 14, fontWeight: 800, color: t.text, fontVariantNumeric: "tabular-nums", flexShrink: 0 }}>{nf(r.n)}</span>
          </div>
          <div style={{ height: 6, borderRadius: 3, background: t.surfaceAlt, marginTop: 6, overflow: "hidden" }}>
            <div style={{ width: `${base ? Math.min(100, (r.n / base) * 100) : 0}%`, height: "100%", borderRadius: 3, background: color }} />
          </div>
          {r.sub && <div style={{ fontSize: 11.5, color: t.textMuted, marginTop: 4 }}>{r.sub}</div>}
        </div>
      ))}
    </div>
  );
}

// Lista simples "nome — visitas — contas — taxa" (origem e aparelho).
function SourceRows({ rows, label }) {
  const t = useT();
  if (!rows.length) return <div style={{ fontSize: 13, color: t.textMuted, padding: "4px 2px" }}>Ainda não há visitas.</div>;
  return (
    <ol style={{ listStyle: "none", margin: 0, padding: 0, background: t.surface, border: `1px solid ${t.border}`, borderRadius: 14, overflow: "hidden" }}>
      {rows.map((r, i) => (
        <li key={label(r)} style={{ display: "flex", alignItems: "center", gap: 12, padding: "11px 14px", borderTop: i ? `1px solid ${t.border}` : "none" }}>
          <span style={{ flex: 1, minWidth: 0, fontSize: 13.5, fontWeight: 700, color: t.text, overflow: "hidden", textOverflow: "ellipsis", whiteSpace: "nowrap" }}>{label(r)}</span>
          <span style={{ textAlign: "right", flexShrink: 0 }}>
            <span style={{ display: "block", fontSize: 14, fontWeight: 800, color: t.text, fontVariantNumeric: "tabular-nums" }}>{nf(r.visitas)} {r.visitas === 1 ? "visita" : "visitas"}</span>
            <span style={{ display: "block", fontSize: 11.5, color: t.textMuted, fontVariantNumeric: "tabular-nums" }}>
              {nf(r.contas)} {r.contas === 1 ? "conta" : "contas"} · {pct(r.contas, r.visitas)}
            </span>
          </span>
        </li>
      ))}
    </ol>
  );
}

// Aba Acessos: quem abre a tela de entrada e o quiz (contagem anônima, supabase/acessos_visitantes.sql).
function AcessosTab({ supabase, refreshKey }) {
  const t = useT();
  const [dias, setDias] = useState(30);
  const key = `${dias}-${refreshKey}`;
  const [res, setRes] = useState({ key: "", status: "loading", data: null, error: "" });

  useEffect(() => {
    let cancelled = false;
    fetchAdminAcessos(supabase, dias).then(
      (data) => !cancelled && setRes({ key, status: data ? "ok" : "missing", data, error: "" }),
      (err) => !cancelled && setRes({ key, status: "error", data: null, error: err.message })
    );
    return () => {
      cancelled = true;
    };
  }, [supabase, dias, key]);

  const loading = res.key !== key;
  const a = !loading && res.status === "ok" ? res.data : null;
  const f = a?.funil;

  const chip = (n) => {
    const on = dias === n;
    return (
      <button
        key={n}
        type="button"
        onClick={() => setDias(n)}
        aria-pressed={on}
        style={{ height: 32, padding: "0 14px", borderRadius: 999, cursor: "pointer", fontSize: 12.5, fontWeight: 700, background: on ? t.primarySoft : t.surface, border: `1px solid ${on ? t.primary : t.border}`, color: on ? (t.name === "dark" ? "#C4B5FF" : t.primary) : t.textMuted }}
      >
        {n === 1 ? "Hoje" : `${n} dias`}
      </button>
    );
  };

  return (
    <>
      <Section title="Período">
        <div style={{ display: "flex", gap: 8 }}>{[1, 7, 30, 90].map(chip)}</div>
      </Section>

      {loading && <div style={{ fontSize: 13, color: t.textMuted, padding: "16px 2px" }}>Carregando…</div>}

      {!loading && res.status === "missing" && (
        <div style={{ background: t.surface, border: `1px solid ${t.border}`, borderRadius: 14, padding: 16, marginTop: 22, fontSize: 13.5, lineHeight: 1.5, color: t.textMuted }}>
          Esta aba precisa do SQL acessos_visitantes.sql rodado no Supabase. Rode-o e toque em Atualizar.
        </div>
      )}
      {!loading && res.status === "error" && (
        <div style={{ background: t.surface, border: `1px solid ${t.border}`, borderRadius: 14, padding: 16, marginTop: 22, fontSize: 13.5, lineHeight: 1.5, color: t.red }}>{res.error}</div>
      )}

      {a && (
        <>
          <Section title="Resumo">
            <Grid>
              <Kpi label="Visitas à tela de entrada" value={nf(f.tela)} color={blueAcessos} />
              <Kpi label="Criaram conta" value={nf(a.contas_reais ?? f.conta)} color={t.green} sub={a.contas_reais == null ? `${pct(f.conta, f.tela)} das visitas` : `${nf(f.conta)} no rastreio das visitas`} />
              <Kpi label="Viram o resultado do quiz" value={nf(f.quiz_fim)} sub={`${pct(f.quiz_fim, f.tela)} das visitas`} />
              <Kpi label="Tempo mediano na tela" value={dur(a.tempo_tela.mediana)} sub="Da abertura até sair" />
              <Kpi label="Entraram em conta que já tinham" value={nf(a.login)} />
              <Kpi label="Fecharam o quiz sem criar conta" value={nf(a.fecharam_quiz)} />
            </Grid>
          </Section>

          <Section title="Funil: onde as pessoas chegam">
            <BarRows
              base={f.tela}
              color={t.primary}
              rows={ACESSOS_ETAPAS.map(([k, label], i) => {
                const prev = i ? f[ACESSOS_ETAPAS[i - 1][0]] : null;
                return {
                  label,
                  n: f[k],
                  sub: i ? `${pct(f[k], f.tela)} das visitas · ${pct(f[k], prev)} da etapa anterior` : "Todas as visitas",
                };
              })}
            />
            <div style={{ fontSize: 11.5, color: t.textMuted, marginTop: 8, lineHeight: 1.45 }}>
              Quem já respondeu o quiz neste IP vê o resultado direto, então pode aparecer em etapas finais sem ter passado pelas questões. O funil só conta quem o navegador deixou rastrear: quem liga &quot;Não rastrear&quot; ou usa bloqueador cria conta e não aparece aqui. Por isso o total de contas criadas, no Resumo, vem direto do cadastro e pode ser maior que a última etapa.
            </div>
          </Section>

          <Section title="Onde pararam quem não criou conta">
            {(() => {
              const total = Object.values(a.pararam).reduce((s, n) => s + n, 0);
              return (
                <>
                  <BarRows base={total} color={t.red} rows={ACESSOS_PARARAM.map(([k, label]) => ({ label, n: a.pararam[k] || 0 }))} />
                  <div style={{ fontSize: 11.5, color: t.textMuted, marginTop: 8, lineHeight: 1.45 }}>
                    Conta {nf(total)} {total === 1 ? "visita" : "visitas"}; quem criou conta ou entrou numa conta existente fica de fora.
                  </div>
                </>
              );
            })()}
          </Section>

          <Section title="Tempo na tela">
            <BarRows base={f.tela} color={blueAcessos} rows={ACESSOS_TEMPO.map(([k, label]) => ({ label, n: a.tempo_tela[k] || 0 }))} />
            <div style={{ fontSize: 11.5, color: t.textMuted, marginTop: 8, lineHeight: 1.45 }}>
              Do primeiro ao último sinal da visita. Quem fecha o navegador sem avisar pode aparecer com menos tempo do que ficou de verdade.
            </div>
          </Section>

          <Section title="Tempo no quiz (mediana)">
            <Grid>
              <Kpi label="Questão 1" value={dur(a.tempos.q1)} />
              <Kpi label="Questão 2" value={dur(a.tempos.q2)} />
              <Kpi label="Questão 3" value={dur(a.tempos.q3)} />
              <Kpi label="Quiz inteiro" value={dur(a.tempos.quiz)} />
              <Kpi label="Da abertura até criar a conta" value={dur(a.tempos.ate_conta)} wide />
            </Grid>
          </Section>

          {dias > 1 && (
            <Section title="Visitas por dia (14 dias)">
              <ChartCard title="Visitas à tela de entrada">
                <BarChart data={a.por_dia.slice(-14).map((p) => ({ d: p.d, n: p.visitas }))} color={blueAcessos} label="Visitas por dia" />
              </ChartCard>
              <ChartCard title="Contas criadas">
                <BarChart data={a.por_dia.slice(-14).map((p) => ({ d: p.d, n: p.contas_reais ?? p.contas }))} color={t.green} label="Contas criadas por dia" />
              </ChartCard>
            </Section>
          )}

          <Section title="De onde vêm">
            <SourceRows rows={a.origens} label={(r) => (r.origem === "direto" ? "Direto (sem origem)" : r.origem)} />
            <div style={{ fontSize: 11.5, color: t.textMuted, marginTop: 8, lineHeight: 1.45 }}>
              O site de onde a pessoa chegou, ou o utm_source do link. Para separar campanhas, acrescente ao link do site algo como ?utm_source=instagram.
            </div>
          </Section>

          <Section title="Aparelho">
            <SourceRows rows={a.aparelhos} label={(r) => r.aparelho.charAt(0).toUpperCase() + r.aparelho.slice(1)} />
          </Section>

          <div style={{ fontSize: 11.5, color: t.textMuted, marginTop: 22, lineHeight: 1.5 }}>
            Contagem anônima própria: cada visita tem um código aleatório, sem IP, e-mail ou outro dado pessoal. Só enxerga a tela de entrada e o quiz, não o resto do site. Quem liga o &ldquo;Não rastrear&rdquo; do navegador não é contado. Dias no horário de Brasília.
          </div>
        </>
      )}
    </>
  );
}

const blueAcessos = "#3B82F6";

// Tela de números do app, só para a conta administradora (botão em Minha Conta).
// tab/onTab: a aba aberta fica guardada fora da tela, para voltar nela depois de abrir uma questão.
// onOpenQuestion(id): abre a questão numa sessão temporária (não entra no histórico de sessões).
export function AdminStatsScreen({ supabase, onBack, tab: tabProp, onTab, onOpenQuestion }) {
  const t = useT();
  const [ownTab, setOwnTab] = useState("usuarios");
  const tab = tabProp || ownTab;
  const setTab = onTab || setOwnTab;
  const [state, setState] = useState({ status: "loading", data: null, error: "" });
  // Parte 2 do painel (e-mails, rankings). Separada para o painel continuar abrindo mesmo sem o SQL novo.
  const [extra, setExtra] = useState({ status: "loading", data: null });
  const [busyQuestion, setBusyQuestion] = useState(null);
  const [openError, setOpenError] = useState("");
  // Sobe a cada "Atualizar" para a aba Acessos (que busca os próprios dados) carregar de novo.
  const [acessosKey, setAcessosKey] = useState(0);

  const load = useCallback(async () => {
    const [main, more] = await Promise.allSettled([fetchAdminStats(supabase), fetchAdminExtra(supabase)]);
    setState(main.status === "fulfilled" ? { status: "ok", data: main.value, error: "" } : { status: "error", data: null, error: main.reason?.message || "Erro." });
    if (more.status === "rejected") setExtra({ status: "error", data: null });
    else setExtra(more.value ? { status: "ok", data: more.value } : { status: "missing", data: null });
  }, [supabase]);

  useEffect(() => {
    let cancelled = false;
    Promise.allSettled([fetchAdminStats(supabase), fetchAdminExtra(supabase)]).then(([main, more]) => {
      if (cancelled) return;
      setState(main.status === "fulfilled" ? { status: "ok", data: main.value, error: "" } : { status: "error", data: null, error: main.reason?.message || "Erro." });
      if (more.status === "rejected") setExtra({ status: "error", data: null });
      else setExtra(more.value ? { status: "ok", data: more.value } : { status: "missing", data: null });
    });
    return () => {
      cancelled = true;
    };
  }, [supabase]);

  const refresh = () => {
    setState((s) => ({ ...s, status: "loading" }));
    setExtra((e) => ({ ...e, status: e.data ? "ok" : "loading" }));
    setAcessosKey((k) => k + 1);
    load();
  };

  const openQuestion = async (id) => {
    if (!onOpenQuestion || busyQuestion) return;
    setOpenError("");
    setBusyQuestion(id);
    try {
      await onOpenQuestion(id);
    } catch (err) {
      setOpenError(err.message || "Não foi possível abrir a questão.");
      setBusyQuestion(null);
    }
  };
  const ex = extra.data;

  const blue = "#3B82F6";
  const purple = t.primary;
  const d = state.data;

  return (
    <div style={{ maxWidth: 620, margin: "0 auto", paddingBottom: 80 }}>
      <ScreenHeader title="Painel de dados" onBack={onBack} />
      <div style={{ padding: "12px 22px 0" }}>
        {state.status === "loading" && !d && <div style={{ textAlign: "center", color: t.textMuted, padding: "50px 0" }}>Carregando…</div>}

        {state.status === "error" && (
          <div style={{ background: t.surface, border: `1px solid ${t.border}`, borderRadius: 14, padding: 18, marginTop: 14 }}>
            <div style={{ color: t.red, fontSize: 14, lineHeight: 1.5, marginBottom: 14 }}>{state.error}</div>
            <PrimaryButton small onClick={refresh}>
              Tentar de novo
            </PrimaryButton>
          </div>
        )}

        {d && (
          <>
            <div style={{ display: "flex", alignItems: "center", justifyContent: "space-between", gap: 10, marginTop: 4 }}>
              <span style={{ fontSize: 12, color: t.textMuted }}>Atualizado às {hhmm(d.gerado_em)} · dias no horário de Brasília</span>
              <button
                type="button"
                onClick={refresh}
                disabled={state.status === "loading"}
                aria-label="Atualizar dados"
                style={{ display: "flex", alignItems: "center", gap: 5, background: "transparent", border: `1px solid ${t.border}`, color: t.primary, borderRadius: 999, padding: "6px 11px", fontSize: 12.5, fontWeight: 700, cursor: "pointer", flexShrink: 0 }}
              >
                <RefreshCw size={13} className={state.status === "loading" ? "spin" : undefined} /> Atualizar
              </button>
            </div>

            <TabBar tab={tab} onTab={setTab} />

            {tab === "usuarios" && (
              <>
            <Section title="Usuários">
              <Grid>
                <Kpi label="Total de usuários" value={nf(d.usuarios.total)} />
                <Kpi label="Novos nas últimas 24 h" value={nf(d.usuarios.novos_24h)} color={t.green} />
                <Kpi label="Novos nos últimos 7 dias" value={nf(d.usuarios.novos_7d)} color={t.green} />
                <Kpi label="Novos no último mês" value={show(d.usuarios.novos_30d)} color={t.green} />
              </Grid>
              <ChartCard title="Novos usuários por dia (14 dias)">
                <BarChart data={d.series.novos} color={t.green} label="Novos usuários por dia" />
              </ChartCard>
            </Section>

            <Section title="Últimos 5 usuários cadastrados">
              {ex ? (
                <div style={{ background: t.surface, border: `1px solid ${t.border}`, borderRadius: 14, overflow: "hidden" }}>
                  {ex.ultimos_usuarios.length === 0 && <div style={{ padding: 14, fontSize: 13, color: t.textMuted }}>Nenhum usuário ainda.</div>}
                  {ex.ultimos_usuarios.map((u, i) => (
                    <div key={`${u.email}-${i}`} style={{ display: "flex", alignItems: "center", justifyContent: "space-between", gap: 12, padding: "11px 14px", borderTop: i ? `1px solid ${t.border}` : "none" }}>
                      <span style={{ fontSize: 13.5, fontWeight: 600, color: t.text, minWidth: 0, overflow: "hidden", textOverflow: "ellipsis", whiteSpace: "nowrap" }}>{u.email || "(sem e-mail)"}</span>
                      <span style={{ fontSize: 11.5, color: t.textMuted, flexShrink: 0, fontVariantNumeric: "tabular-nums" }}>{dataHora(u.criado_em)}</span>
                    </div>
                  ))}
                </div>
              ) : (
                <ExtraNotice extra={extra} />
              )}
            </Section>

            <Section title="Tema do app (fundo)">
              {ex?.temas ? (
                <>
                  <Grid cols={3}>
                    <Kpi label="Fundo escuro" value={nf(ex.temas.escuro)} sub={pct(ex.temas.escuro, ex.temas.escuro + ex.temas.claro + ex.temas.sem_registro)} />
                    <Kpi label="Fundo claro" value={nf(ex.temas.claro)} sub={pct(ex.temas.claro, ex.temas.escuro + ex.temas.claro + ex.temas.sem_registro)} />
                    <Kpi label="Sem registro" value={nf(ex.temas.sem_registro)} sub="usam o padrão (escuro)" />
                  </Grid>
                  <div style={{ fontSize: 11.5, color: t.textMuted, marginTop: 8, lineHeight: 1.45 }}>
                    O tema é gravado na conta quando a pessoa abre o app e a cada troca no botão de sol/lua. Quem ainda não abriu o app depois da atualização aparece em &quot;Sem registro&quot;.
                  </div>
                  {ex.temas.os_dois != null && (
                    <>
                      <div style={{ fontSize: 12.5, fontWeight: 700, color: t.text, margin: "16px 0 8px" }}>Quem já experimentou</div>
                      <Grid cols={3}>
                        <Kpi label="Já usaram o escuro" value={nf(ex.temas.ja_usaram_escuro)} sub={pct(ex.temas.ja_usaram_escuro, d.usuarios.total)} />
                        <Kpi label="Já usaram o claro" value={nf(ex.temas.ja_usaram_claro)} sub={pct(ex.temas.ja_usaram_claro, d.usuarios.total)} />
                        <Kpi label="Experimentaram os dois" value={nf(ex.temas.os_dois)} sub={pct(ex.temas.os_dois, d.usuarios.total)} />
                      </Grid>
                      <div style={{ fontSize: 11.5, color: t.textMuted, marginTop: 8, lineHeight: 1.45 }}>
                        Conta quem já teve cada fundo na conta. O histórico começa quando o SQL foi rodado: quem trocou de tema antes disso aparece só com o tema que usa hoje, então &quot;os dois&quot; tende a crescer com o tempo.
                      </div>
                    </>
                  )}
                </>
              ) : (
                <ExtraNotice extra={ex ? { status: "missing" } : extra} />
              )}
            </Section>

            <Section title="Usuários ativos">
              <Grid>
                <Kpi
                  label="Usuários ativos agora"
                  value={show(d.ativos.agora)}
                  sub={d.ativos.agora == null ? undefined : `Nos últimos 15 min · ${pct(d.ativos.agora, d.usuarios.total)} dos usuários`}
                  color={purple}
                />
                <Kpi label="Ativos nas últimas 24 h" value={nf(d.ativos.h24)} sub={`${pct(d.ativos.h24, d.usuarios.total)} dos usuários`} color={purple} />
                <Kpi label="Ativos nos últimos 7 dias" value={nf(d.ativos.d7)} sub={`${pct(d.ativos.d7, d.usuarios.total)} dos usuários`} color={purple} />
                <Kpi label="Ativos nos últimos 30 dias" value={nf(d.ativos.d30)} sub={`${pct(d.ativos.d30, d.usuarios.total)} dos usuários`} color={purple} />
              </Grid>
              <ChartCard
                title="Usuários ativos por dia (14 dias)"
                note="Ativo = respondeu questão (inclusive em desafio), viu flashcard, abriu a missão diária ou criou desafio."
              >
                <BarChart data={d.series.ativos} color={purple} label="Usuários ativos por dia" />
              </ChartCard>
            </Section>

            <CollapsibleSection id="entraram24h" title="Entraram nas últimas 24 h" count={ex?.ativos_24h_total != null ? nf(ex.ativos_24h_total) : undefined}>
              {ex?.ativos_24h ? (
                <>
                  <PeopleList
                    rows={ex.ativos_24h}
                    right={(r) => dataHora(r.ultimo)}
                    empty="Ninguém usou o app nas últimas 24 h."
                    numbered={false}
                  />
                  <div style={{ fontSize: 11.5, color: t.textMuted, marginTop: 8, lineHeight: 1.45 }}>
                    Entrou = respondeu questão, viu flashcard, abriu a missão diária (acontece ao abrir o app) ou criou desafio. A hora é do último uso, no horário de Brasília.
                    {ex.ativos_24h_total > ex.ativos_24h.length ? ` Mostrando os ${ex.ativos_24h.length} mais recentes de ${nf(ex.ativos_24h_total)}.` : ""}
                  </div>
                </>
              ) : (
                <ExtraNotice extra={ex ? { status: "missing" } : extra} />
              )}
            </CollapsibleSection>
              </>
            )}

            {tab === "assinantes" && (
              <>
            <Section title="Assinantes">
              {(() => {
                const a = d.assinaturas;
                const semPlano = Math.max(0, d.usuarios.total - a.ativos);
                return (
                  <>
                    <Grid>
                      <Kpi label="Compras nas últimas 48 h" value={show(a.compras_48h)} />
                      <Kpi label="Compras nos últimos 7 dias" value={nf(a.compras_7d)} />
                      <Kpi label="Compras nos últimos 30 dias" value={nf(a.compras_30d)} />
                      <Kpi label="Receita dos últimos 30 dias" value={formatBRL(a.receita_30d_centavos)} sub={`Total: ${formatBRL(a.receita_total_centavos)}`} />
                    </Grid>
                    <ChartCard title="Usuários por plano" note="Cortesia = acesso gratuito (30 dias dados a todos, cupom). Não inclui as contas administradoras.">
                      <Donut
                        centerLabel="usuários"
                        parts={[
                          { label: "Mensal", value: a.mensal, color: purple },
                          { label: "Anual", value: a.anual, color: blue },
                          { label: "Cortesia", value: a.cortesia, color: t.amber },
                          { label: "Sem plano", value: semPlano, color: t.textMuted },
                        ]}
                      />
                    </ChartCard>
                  </>
                );
              })()}
            </Section>
              </>
            )}

            {tab === "questoes" && (
              <>
            <Section title="Questões">
              {(() => {
                const q = d.questoes;
                const total = Math.max(1, d.usuarios.total);
                return (
                  <>
                    <Grid>
                      <Kpi label="Respondidas hoje" value={nf(q.hoje)} color={blue} sub={`${nf(q.diarias_hoje)} na missão diária`} />
                      <Kpi label="Respondidas em 7 dias" value={nf(q.d7)} color={blue} sub={`Acerto: ${pct(q.acertos_d7, q.d7)}`} />
                      <Kpi
                        label="Média diária por usuário (7 dias)"
                        value={nf(q.d7 / 7 / total, 1)}
                        sub={`Hoje: ${nf(q.hoje / total, 1)} por usuário`}
                      />
                      <Kpi
                        label="Média diária por usuário ativo (7 dias)"
                        value={nf(q.d7 / 7 / Math.max(1, d.ativos.d7), 1)}
                        sub={`Hoje: ${nf(q.hoje / Math.max(1, d.ativos.hoje), 1)} por ativo`}
                      />
                      <Kpi wide label="Questões no banco" value={nf(d.conteudo.questoes)} sub={`${nf(d.conteudo.flashcards)} flashcards`} />
                    </Grid>
                    <ChartCard title="Questões respondidas por dia (14 dias)" note="Inclui as respostas dentro de desafios.">
                      <BarChart data={d.series.questoes} color={blue} label="Questões respondidas por dia" />
                    </ChartCard>
                  </>
                );
              })()}
            </Section>

            <CollapsibleSection id="topHoje" title="Usuários com mais questões hoje">
              {ex?.top_questoes_hoje ? (
                <>
                  <PeopleList rows={ex.top_questoes_hoje} right={(r) => nf(r.n)} empty="Ninguém respondeu questões hoje ainda." />
                  <div style={{ fontSize: 11.5, color: t.textMuted, marginTop: 8, lineHeight: 1.45 }}>
                    Mostra os 10 primeiros. Contam as respostas avulsas e as dentro de desafios, de hoje (desde a meia-noite, horário de Brasília). O Bot Braunwald fica fora da lista.
                  </div>
                </>
              ) : (
                <ExtraNotice extra={ex ? { status: "missing" } : extra} />
              )}
            </CollapsibleSection>

            <CollapsibleSection id="maisErros" title="Questões com mais erros">
              {ex ? <QuestionRank rows={ex.mais_erradas} kind="erros" onOpen={openQuestion} busyId={busyQuestion} /> : <ExtraNotice extra={extra} />}
              {openError && <div style={{ fontSize: 12.5, color: t.red, marginTop: 8 }}>{openError}</div>}
            </CollapsibleSection>

            <CollapsibleSection id="maisAcertos" title="Questões com mais acertos">
              {ex ? <QuestionRank rows={ex.mais_acertadas} kind="acertos" onOpen={openQuestion} busyId={busyQuestion} /> : <ExtraNotice extra={extra} />}
              {ex && (
                <div style={{ fontSize: 11.5, color: t.textMuted, marginTop: 8, lineHeight: 1.45 }}>
                  Contam as respostas avulsas e as de desafios, de todos os usuários. Toque numa questão para abri-la sozinha; essa sessão é temporária e não entra no histórico de sessões.
                </div>
              )}
              {openError && <div style={{ fontSize: 12.5, color: t.red, marginTop: 8 }}>{openError}</div>}
            </CollapsibleSection>
              </>
            )}

            {tab === "flashcards" && (
              <>
            <Section title="Flashcards">
              <Grid>
                <Kpi label="Vistos hoje" value={nf(d.flashcards.hoje)} color={t.amber} />
                <Kpi label="Vistos em 7 dias" value={nf(d.flashcards.d7)} color={t.amber} sub={`Média: ${nf(d.flashcards.d7 / 7, 1)} por dia`} />
              </Grid>
              <ChartCard title="Flashcards vistos por dia (14 dias)">
                <BarChart data={d.series.flashcards} color={t.amber} label="Flashcards vistos por dia" />
              </ChartCard>
            </Section>
              </>
            )}

            {tab === "desafios" && (
              <>
            <Section title="Desafios">
              <Grid>
                <Kpi label="Criados hoje" value={nf(d.desafios.hoje)} color="#9B6BFF" />
                <Kpi label="Criados em 7 dias" value={nf(d.desafios.d7)} color="#9B6BFF" />
                <Kpi label="Média de criados por dia (7 dias)" value={nf(d.desafios.d7 / 7, 1)} />
                <Kpi label="Total já criados" value={nf(d.desafios.total)} />
              </Grid>
              <ChartCard title="Desafios criados por dia (14 dias)">
                <BarChart data={d.series.desafios} color="#9B6BFF" label="Desafios criados por dia" />
              </ChartCard>
            </Section>

            <Section title="Quem mais lançou desafios">
              {ex ? <PeopleList rows={ex.desafios_lancados} right={(r) => nf(r.n)} /> : <ExtraNotice extra={extra} />}
            </Section>

            <Section title="Quem mais ganhou desafios">
              {ex ? <PeopleList rows={ex.desafios_ganhos} right={(r) => nf(r.n)} empty="Ainda não há desafios concluídos com vencedor." /> : <ExtraNotice extra={extra} />}
              {ex && (
                <div style={{ fontSize: 11.5, color: t.textMuted, marginTop: 8, lineHeight: 1.45 }}>
                  Vitória = desafio concluído em que a pessoa fez mais acertos que todos os outros (empate no topo não conta). O Bot Braunwald fica fora das listas.
                </div>
              )}
            </Section>
              </>
            )}

            {tab === "missao" && (
              <>
            <Section title="Missão diária">
              {(() => {
                const m = d.missao;
                if (!m) {
                  return (
                    <div style={{ background: t.surface, border: `1px solid ${t.border}`, borderRadius: 14, padding: 16, fontSize: 13.5, lineHeight: 1.5, color: t.textMuted }}>
                      Esta seção precisa do SQL do painel de dados atualizado no Supabase. Rode-o de novo e toque em Atualizar.
                    </div>
                  );
                }
                return (
                  <>
                    <Grid>
                      <Kpi
                        label="Missões concluídas hoje"
                        value={nf(m.concluidas_hoje)}
                        color={t.green}
                        sub={`${pct(m.concluidas_hoje, m.recebidas_hoje)} de quem abriu o app hoje (${nf(m.recebidas_hoje)})`}
                      />
                      <Kpi
                        label="Concluídas nos últimos 7 dias"
                        value={nf(m.concluidas_7d)}
                        color={t.green}
                        sub={`Média de ${nf(m.concluidas_7d / 7, 1)} por dia · ${pct(m.concluidas_7d, m.recebidas_7d)} das sorteadas`}
                      />
                      <Kpi label="Com sequência ativa" value={nf(m.sequencia_ativas)} sub={`${pct(m.sequencia_ativas, d.usuarios.total)} dos usuários`} color={t.amber} />
                      <Kpi label="Sequência média" value={`${nf(m.sequencia_media, 1)} dias`} sub={`Maior sequência: ${nf(m.sequencia_maxima)} dias`} color={t.amber} />
                    </Grid>
                    <ChartCard
                      title="Missões concluídas por dia (14 dias)"
                      note="Concluída = respondeu todas as questões da missão do dia (3 no plano gratuito). A missão é sorteada quando a pessoa abre o app. Sequência ativa = concluiu a missão hoje ou ontem."
                    >
                      <BarChart data={d.series.missoes || []} color={t.green} label="Missões concluídas por dia" />
                    </ChartCard>
                  </>
                );
              })()}
            </Section>

            <Section title="Lembretes por notificação">
              {ex?.notificacoes ? <NotificacoesResumo n={ex.notificacoes} /> : <ExtraNotice extra={ex ? { status: "missing" } : extra} />}
            </Section>

            <Section title="Maiores sequências atuais">
              {ex ? <PeopleList rows={ex.sequencias_atuais} right={(r) => `${nf(r.n)} ${r.n === 1 ? "dia" : "dias"}`} empty="Ninguém com sequência ativa agora." /> : <ExtraNotice extra={extra} />}
              {ex && (
                <div style={{ fontSize: 11.5, color: t.textMuted, marginTop: 8, lineHeight: 1.45 }}>Sequência ativa = concluiu a missão hoje ou ontem.</div>
              )}
            </Section>

            <Section title="Maiores sequências de todos os tempos">
              {ex ? (
                <PeopleList
                  rows={ex.sequencias_gerais}
                  right={(r) => (
                    <>
                      {nf(r.n)} {r.n === 1 ? "dia" : "dias"}
                      <span style={{ display: "block", fontSize: 11, fontWeight: 600, color: t.textMuted }}>{r.atual > 0 ? `atual: ${nf(r.atual)}` : "sem sequência agora"}</span>
                    </>
                  )}
                />
              ) : (
                <ExtraNotice extra={extra} />
              )}
            </Section>
              </>
            )}

            {tab === "acessos" && <AcessosTab supabase={supabase} refreshKey={acessosKey} />}
          </>
        )}
      </div>
    </div>
  );
}
