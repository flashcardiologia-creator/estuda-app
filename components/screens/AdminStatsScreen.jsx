"use client";

import { useCallback, useEffect, useState } from "react";
import { RefreshCw, ChevronDown, ChevronUp, Copy, Check } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { ScreenHeader, PrimaryButton } from "@/components/ui/Primitives";
import { fetchAdminStats, fetchAdminExtra, fetchAdminAcessos, fetchAdminComissoes, fetchAdminNovosUsuarios, fetchAdminTempoUso, fetchAdminComprasResumo, fetchAdminAcessosConvites } from "@/lib/data/adminStats";
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

function ChartCard({ title, children, note, right = null }) {
  const t = useT();
  return (
    <div style={{ background: t.surface, border: `1px solid ${t.border}`, borderRadius: 14, padding: "14px 14px 10px", marginTop: 10 }}>
      <div style={{ display: "flex", alignItems: "center", justifyContent: "space-between", gap: 8, flexWrap: "wrap", marginBottom: 8 }}>
        <div style={{ fontSize: 13, fontWeight: 700, color: t.text }}>{title}</div>
        {right}
      </div>
      {children}
      {note && <div style={{ fontSize: 11.5, color: t.textMuted, marginTop: 6, lineHeight: 1.4 }}>{note}</div>}
    </div>
  );
}

// Barras (o último dia ou mês fica mais forte). data = [{ d: "2026-10-18", n: 12 }]. A legenda de baixo é o dia do mês, ou
// p.label quando existir (p.label = "" esconde a legenda daquela barra; usado nos 30 dias e nos meses do gráfico de 365 dias).
function BarChart({ data, color, label, format = compact }) {
  const t = useT();
  const W = 340;
  const H = 150;
  const padTop = 16;
  const padBottom = 22;
  const n = data.length;
  const max = Math.max(1, ...data.map((p) => p.n));
  const slot = W / n;
  const plotH = H - padTop - padBottom;
  const dense = slot < 18; // 30 barras ou mais: números menores e só nos picos
  return (
    <svg viewBox={`0 0 ${W} ${H}`} width="100%" role="img" aria-label={label} style={{ display: "block" }}>
      <line x1="0" x2={W} y1={H - padBottom} y2={H - padBottom} stroke={t.border} strokeWidth="1" />
      {data.map((p, i) => {
        const h = (plotH * p.n) / max;
        const x = i * slot + slot * 0.16;
        const y = H - padBottom - h;
        const isToday = i === n - 1;
        const legend = p.label ?? p.d.slice(8);
        return (
          <g key={p.d}>
            <rect x={x} y={y} width={slot * 0.68} height={Math.max(h, p.n > 0 ? 2 : 0)} rx="3" fill={color} opacity={isToday ? 1 : 0.55} />
            {p.n > 0 && (!dense || p.n === max || isToday) && (
              <text x={i * slot + slot / 2} y={y - 4} textAnchor="middle" fontSize={dense ? "8.5" : "9.5"} fontWeight="700" fill={isToday ? t.text : t.textMuted}>
                {format(p.n)}
              </text>
            )}
            {legend !== "" && (
              // legenda comprida (ex.: "23/11") na última barra: alinhada à direita para não sair do gráfico
              <text x={isToday && legend.length > 3 ? W : i * slot + slot / 2} y={H - 7} textAnchor={isToday && legend.length > 3 ? "end" : "middle"} fontSize={dense ? "8.5" : "9.5"} fill={isToday ? t.text : t.textMuted} fontWeight={isToday ? 700 : 400}>
                {legend}
              </text>
            )}
          </g>
        );
      })}
    </svg>
  );
}

const MESES_CURTOS = ["jan", "fev", "mar", "abr", "mai", "jun", "jul", "ago", "set", "out", "nov", "dez"];

// Botões de período do gráfico (14, 30 e 365 dias).
function PeriodChips({ value, onChange, options, label }) {
  const t = useT();
  return (
    <div role="group" aria-label={label} style={{ display: "flex", gap: 6 }}>
      {options.map((n) => {
        const on = value === n;
        return (
          <button
            key={n}
            type="button"
            onClick={() => onChange(n)}
            aria-pressed={on}
            style={{ height: 26, padding: "0 10px", borderRadius: 999, cursor: "pointer", fontSize: 11.5, fontWeight: 700, background: on ? t.primarySoft : "transparent", border: `1px solid ${on ? t.primary : t.border}`, color: on ? (t.name === "dark" ? "#C4B5FF" : t.primary) : t.textMuted }}
          >
            {n} dias
          </button>
        );
      })}
    </div>
  );
}

// Botões para escolher uma de duas ou mais visões da mesma lista. options = [{ id, label }].
function OptionChips({ value, onChange, options, label }) {
  const t = useT();
  return (
    <div role="group" aria-label={label} style={{ display: "flex", gap: 6, flexWrap: "wrap", marginBottom: 10 }}>
      {options.map((o) => {
        const on = value === o.id;
        return (
          <button
            key={o.id}
            type="button"
            onClick={() => onChange(o.id)}
            aria-pressed={on}
            style={{ height: 30, padding: "0 12px", borderRadius: 999, cursor: "pointer", fontSize: 12.5, fontWeight: 700, background: on ? t.primarySoft : "transparent", border: `1px solid ${on ? t.primary : t.border}`, color: on ? (t.name === "dark" ? "#C4B5FF" : t.primary) : t.textMuted }}
          >
            {o.label}
          </button>
        );
      })}
    </div>
  );
}

// Novos usuários por dia. 14 dias vêm junto com os dados do painel (serie14); 30 e 365 dias vêm da função admin_novos_usuarios
// (supabase/painel_novos_usuarios.sql), buscada uma vez ao escolher 30 ou 365 e de novo a cada "Atualizar" (refreshKey).
// 30 dias = uma barra por dia; 365 dias = uma barra por mês (365 barras não cabem), sendo o primeiro e o último mês parciais.
function NovosUsuariosChart({ supabase, serie14, color, refreshKey }) {
  const t = useT();
  const [dias, setDias] = useState(14);
  const key = String(refreshKey);
  const [res, setRes] = useState({ key: "", status: "loading", data: null });
  const need = dias !== 14 && res.key !== key;

  useEffect(() => {
    if (!need) return undefined;
    let cancelled = false;
    fetchAdminNovosUsuarios(supabase, 365).then(
      (data) => !cancelled && setRes({ key, status: data ? "ok" : "missing", data }),
      () => !cancelled && setRes({ key, status: "error", data: null })
    );
    return () => {
      cancelled = true;
    };
  }, [supabase, need, key]);

  const daily = dias !== 14 && res.key === key && res.status === "ok" && Array.isArray(res.data?.serie) ? res.data.serie : null;
  let bars = null;
  let title = "Novos usuários por dia (14 dias)";
  let note;
  if (dias === 14) {
    bars = serie14;
  } else if (daily && dias === 30) {
    const last = daily.slice(-30);
    // legenda "dd/mm" a cada 5 dias, contando de hoje para trás (hoje sempre aparece)
    bars = last.map((p, i) => ({ d: p.d, n: p.n, label: (last.length - 1 - i) % 5 === 0 ? `${p.d.slice(8)}/${p.d.slice(5, 7)}` : "" }));
    title = "Novos usuários por dia (30 dias)";
  } else if (daily && dias === 365) {
    const byMonth = new Map();
    for (const p of daily) byMonth.set(p.d.slice(0, 7), (byMonth.get(p.d.slice(0, 7)) || 0) + p.n);
    bars = [...byMonth].map(([m, n]) => ({ d: m, n, label: MESES_CURTOS[Number(m.slice(5, 7)) - 1] }));
    title = "Novos usuários por mês (365 dias)";
    const first = bars[0].d;
    const lastM = bars[bars.length - 1].d;
    note = `De ${MESES_CURTOS[Number(first.slice(5, 7)) - 1]}/${first.slice(0, 4)} a ${MESES_CURTOS[Number(lastM.slice(5, 7)) - 1]}/${lastM.slice(0, 4)}. O primeiro e o último mês estão incompletos.`;
  }
  const total = bars ? bars.reduce((s, p) => s + p.n, 0) : 0;
  const chips = <PeriodChips value={dias} onChange={setDias} options={[14, 30, 365]} label="Período do gráfico" />;

  const message = (text, color2 = t.textMuted) => <div style={{ fontSize: 13, lineHeight: 1.5, color: color2, padding: "34px 4px 40px", textAlign: "center" }}>{text}</div>;

  if (dias !== 14 && !daily) {
    return (
      <ChartCard title="Novos usuários" right={chips}>
        {res.key !== key && message("Carregando…")}
        {res.key === key && res.status === "missing" && message("Para ver 30 e 365 dias, rode o SQL painel_novos_usuarios.sql no Supabase e toque em Atualizar.")}
        {res.key === key && res.status === "error" && message("Não foi possível carregar agora. Toque em Atualizar para tentar de novo.", t.red)}
        {res.key === key && res.status === "ok" && message("Sem dados para este período.")}
      </ChartCard>
    );
  }

  return (
    <ChartCard title={title} right={chips} note={`${dias === 14 ? "Total nos 14 dias" : `Total nos ${dias} dias`}: ${nf(total)}${note ? `. ${note}` : ""}`}>
      <BarChart data={bars} color={color} label={title} />
    </ChartCard>
  );
}

// Rosca com legenda. parts = [{ label, value, color }].
function Donut({ parts, centerLabel, ariaLabel = "Distribuição dos usuários por plano", showPct = true }) {
  const t = useT();
  const total = parts.reduce((s, p) => s + p.value, 0);
  const R = 15.9155; // circunferência = 100
  let acc = 0;
  return (
    <div style={{ display: "flex", alignItems: "center", gap: 18, flexWrap: "wrap" }}>
      <svg viewBox="0 0 42 42" width="132" height="132" role="img" aria-label={ariaLabel} style={{ flexShrink: 0 }}>
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
            {showPct && <span style={{ color: t.textMuted, width: 52, textAlign: "right", fontVariantNumeric: "tabular-nums" }}>{pct(p.value, total)}</span>}
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
  { id: "comissao", label: "Comissão" },
  { id: "questoes", label: "Questões" },
  { id: "flashcards", label: "Flashcards" },
  { id: "desafios", label: "Desafios" },
  { id: "missao", label: "Revisão diária" },
  { id: "tempo", label: "Tempo de uso" },
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

// Aba Comissão: convite por pontos (supabase/convite_pontos.sql e supabase/painel_comissao.sql). 1 ponto = R$ 1,00.
const brl = (n) => `R$ ${nf(n, 2)}`;
const diaMes = (iso) => (iso ? new Date(iso).toLocaleDateString("pt-BR", { timeZone: "America/Sao_Paulo", day: "2-digit", month: "2-digit" }) : "");

// Pedido de saque ainda sem pagamento registrado: existe pedido e ele é mais novo que o último saque pago (ou não houve saque).
const pedidoAberto = (p) => !!p.pedido && (!p.ultimo_saque || !p.pedido.em || new Date(p.pedido.em) > new Date(p.ultimo_saque));

export function ComissaoTab({ supabase, refreshKey }) {
  const t = useT();
  const key = String(refreshKey);
  const [res, setRes] = useState({ key: "", status: "loading", data: null, error: "" });
  const [filtro, setFiltro] = useState("todos");
  const [busca, setBusca] = useState("");
  const [aberta, setAberta] = useState(null);
  const [copiado, setCopiado] = useState("");

  useEffect(() => {
    let cancelled = false;
    fetchAdminComissoes(supabase).then(
      (data) => !cancelled && setRes({ key, status: data ? "ok" : "missing", data, error: "" }),
      (err) => !cancelled && setRes({ key, status: "error", data: null, error: err.message })
    );
    return () => {
      cancelled = true;
    };
  }, [supabase, key]);

  const loading = res.key !== key;
  const c = !loading && res.status === "ok" ? res.data : null;
  const g = c?.geral;
  const pessoas = c?.pessoas || [];

  const copiar = async (id, texto) => {
    try {
      await navigator.clipboard.writeText(texto);
      setCopiado(id);
      setTimeout(() => setCopiado(""), 1800);
    } catch {
      window.prompt("Copie o comando:", texto);
    }
  };

  const filtros = [
    { id: "todos", label: "Todas", n: pessoas.length, ok: () => true },
    { id: "sacar", label: "Podem sacar", n: pessoas.filter((p) => p.pode_sacar).length, ok: (p) => p.pode_sacar },
    { id: "pedido", label: "Pedidos abertos", n: pessoas.filter(pedidoAberto).length, ok: pedidoAberto },
    { id: "aguardando", label: "Aguardando", n: pessoas.filter((p) => p.aguardando > 0).length, ok: (p) => p.aguardando > 0 },
    { id: "sacaram", label: "Já sacaram", n: pessoas.filter((p) => p.saques_qtd > 0).length, ok: (p) => p.saques_qtd > 0 },
  ];
  const atual = filtros.find((f) => f.id === filtro) || filtros[0];
  const q = busca.trim().toLowerCase();
  const lista = pessoas.filter((p) => atual.ok(p) && (!q || `${p.nome} ${p.email}`.toLowerCase().includes(q)));

  const chip = (f) => {
    const on = filtro === f.id;
    return (
      <button
        key={f.id}
        type="button"
        onClick={() => setFiltro(f.id)}
        aria-pressed={on}
        style={{ height: 32, padding: "0 12px", borderRadius: 999, cursor: "pointer", fontSize: 12.5, fontWeight: 700, whiteSpace: "nowrap", flex: "none", background: on ? t.primarySoft : t.surface, border: `1px solid ${on ? t.primary : t.border}`, color: on ? (t.name === "dark" ? "#C4B5FF" : t.primary) : t.textMuted }}
      >
        {f.label} <span style={{ opacity: 0.75 }}>{f.n}</span>
      </button>
    );
  };

  // Mesma lógica de cores da tela da pessoa: amarelo = aguardando os 7 dias, verde = liberado, cinza = estornado.
  const look = (cv) => {
    const pts = cv.pontos > 0 ? cv.pontos : 0;
    if (cv.status === "premiado" && pts > 0) {
      return cv.liberado
        ? { cor: t.green, sub: `assinou o ${cv.plano || "plano"} · liberado`, right: `+${pts}` }
        : { cor: t.amber, sub: `assinou o ${cv.plano || "plano"} · libera em ${diaMes(cv.liberar_em)}`, right: `+${pts}` };
    }
    if (cv.status === "premiado") return { cor: t.text, sub: `assinou o ${cv.plano || "plano"} (antes dos pontos)`, right: "" };
    if (cv.status === "revertido") return { cor: t.textMuted, sub: "plano estornado", right: "" };
    return { cor: t.text, sub: "criou a conta", right: "" };
  };

  const card = { background: t.surface, border: `1px solid ${t.border}`, borderRadius: 14 };
  const mini = (label, value, color) => (
    <div style={{ ...card, background: t.surfaceAlt, padding: "9px 12px", minWidth: 0 }}>
      <div style={{ fontSize: 11, color: t.textMuted, fontWeight: 600 }}>{label}</div>
      <div style={{ fontSize: 16, fontWeight: 800, color: color || t.text, marginTop: 2, fontVariantNumeric: "tabular-nums" }}>{value}</div>
    </div>
  );

  return (
    <>
      {loading && <div style={{ fontSize: 13, color: t.textMuted, padding: "16px 2px" }}>Carregando…</div>}

      {!loading && res.status === "missing" && (
        <div style={{ ...card, padding: 16, marginTop: 22, fontSize: 13.5, lineHeight: 1.5, color: t.textMuted }}>
          Esta aba precisa dos SQLs convite_pontos.sql e painel_comissao.sql rodados no Supabase. Rode-os e toque em Atualizar.
        </div>
      )}
      {!loading && res.status === "error" && <div style={{ ...card, padding: 16, marginTop: 22, fontSize: 13.5, lineHeight: 1.5, color: t.red }}>{res.error}</div>}

      {g && (
        <>
          <Section title="Resumo geral">
            <Grid>
              <Kpi label="A pagar agora" value={brl(g.a_pagar)} color={t.green} sub={g.podem_sacar_qtd > 0 ? `${g.podem_sacar_qtd} ${g.podem_sacar_qtd === 1 ? "pessoa pode sacar" : "pessoas podem sacar"} (${brl(g.podem_sacar_valor)})` : "Ninguém chegou aos 250 pontos ainda"} wide />
              <Kpi label="Aguardando 7 dias" value={brl(g.aguardando)} color={t.amber} sub="ainda pode ser estornado" />
              <Kpi label="Já pago (saques)" value={brl(g.sacados)} color={t.red} sub={`${nf(g.saques_qtd)} ${g.saques_qtd === 1 ? "saque" : "saques"}`} />
              <Kpi label="Convites" value={nf(g.convites)} sub={`${nf(g.assinaram)} assinaram (${pct(g.assinaram, g.convites)}) · ${nf(g.estornados)} estornados`} />
              <Kpi label="Pessoas que convidaram" value={nf(g.pessoas)} sub={`${nf(g.mensal)} mensais · ${nf(g.anual)} anuais`} />
              <Kpi label="Pedidos de saque" value={nf(g.pedidos_qtd)} sub="feitos pela aba Contato" />
              <Kpi label="Pontos gerados" value={nf(g.pontos_ganhos)} sub={`= ${brl(g.pontos_ganhos)} (1 ponto = R$ 1,00)`} />
            </Grid>
            <ChartCard title="Para onde foram os pontos" note="Já pago + a pagar (liberado) + aguardando os 7 dias = pontos gerados. Pontos de convites estornados não entram.">
              <Donut
                centerLabel="pontos"
                showPct={false}
                ariaLabel="Divisão dos pontos entre já pagos, a pagar e aguardando"
                parts={[
                  { label: "Já pago", value: g.sacados, color: t.red },
                  { label: "A pagar agora", value: g.a_pagar, color: t.green },
                  { label: "Aguardando 7 dias", value: g.aguardando, color: t.amber },
                ]}
              />
            </ChartCard>
          </Section>

          <Section title="Resumo de cada pessoa">
            <div role="group" aria-label="Filtrar pessoas" style={{ display: "flex", gap: 8, overflowX: "auto", margin: "0 -22px", padding: "2px 22px 8px", scrollbarWidth: "none" }}>
              {filtros.map(chip)}
            </div>
            <input
              type="search"
              className="friend-search-input"
              value={busca}
              onChange={(e) => setBusca(e.target.value)}
              placeholder="Buscar por nome ou e-mail"
              aria-label="Buscar pessoa"
              style={{ width: "100%", boxSizing: "border-box", margin: "2px 0 10px", padding: "10px 12px", borderRadius: 12, border: `1px solid ${t.border}`, background: t.surfaceAlt, color: t.text, fontSize: 16, fontFamily: "inherit" }}
            />

            {!lista.length && <div style={{ fontSize: 13, color: t.textMuted, padding: "4px 2px" }}>{pessoas.length ? "Ninguém nesse filtro." : "Ainda ninguém convidou amigos."}</div>}

            <div style={{ display: "flex", flexDirection: "column", gap: 10 }}>
              {lista.map((p) => {
                const open = aberta === p.id;
                const pedido = pedidoAberto(p);
                const cmd = `select public.admin_registrar_saque('${String(p.email || "").replace(/'/g, "''")}', ${p.saldo});`;
                return (
                  <div key={p.id} style={{ ...card, overflow: "hidden" }}>
                    <button
                      type="button"
                      onClick={() => setAberta(open ? null : p.id)}
                      aria-expanded={open}
                      style={{ display: "flex", alignItems: "center", gap: 10, width: "100%", padding: "12px 14px", background: "transparent", border: "none", cursor: "pointer", textAlign: "left", fontFamily: "inherit" }}
                    >
                      <div style={{ flex: 1, minWidth: 0 }}>
                        <div style={{ fontSize: 14, fontWeight: 700, color: t.text, overflow: "hidden", textOverflow: "ellipsis", whiteSpace: "nowrap" }}>{p.nome}</div>
                        <div style={{ fontSize: 11.5, color: t.textMuted, overflow: "hidden", textOverflow: "ellipsis", whiteSpace: "nowrap" }}>{p.email}</div>
                        <div style={{ fontSize: 12, color: t.textMuted, marginTop: 4 }}>
                          {p.convidados} {p.convidados === 1 ? "convidado" : "convidados"} · {p.assinaram} {p.assinaram === 1 ? "assinou" : "assinaram"}
                          {p.estornados > 0 ? ` · ${p.estornados} estornado${p.estornados > 1 ? "s" : ""}` : ""}
                        </div>
                        {(p.pode_sacar || pedido) && (
                          <div style={{ display: "flex", gap: 6, marginTop: 6, flexWrap: "wrap" }}>
                            {p.pode_sacar && <span style={{ fontSize: 10.5, fontWeight: 800, color: t.green, border: `1px solid ${t.green}`, borderRadius: 999, padding: "1px 8px" }}>PODE SACAR</span>}
                            {pedido && <span style={{ fontSize: 10.5, fontWeight: 800, color: t.amber, border: `1px solid ${t.amber}`, borderRadius: 999, padding: "1px 8px" }}>PEDIU SAQUE</span>}
                          </div>
                        )}
                      </div>
                      <div style={{ textAlign: "right", flexShrink: 0 }}>
                        <div style={{ fontSize: 15, fontWeight: 800, color: p.saldo > 0 ? t.green : t.textMuted, fontVariantNumeric: "tabular-nums" }}>{brl(p.saldo)}</div>
                        <div style={{ fontSize: 11, color: t.textMuted }}>liberado</div>
                        {p.aguardando > 0 && <div style={{ fontSize: 11.5, fontWeight: 700, color: t.amber, marginTop: 3 }}>+{brl(p.aguardando)} aguardando</div>}
                      </div>
                      {open ? <ChevronUp size={16} color={t.textMuted} /> : <ChevronDown size={16} color={t.textMuted} />}
                    </button>

                    {open && (
                      <div style={{ padding: "0 14px 14px", borderTop: `1px solid ${t.border}` }}>
                        <div style={{ display: "grid", gridTemplateColumns: "repeat(2, minmax(0, 1fr))", gap: 8, marginTop: 12 }}>
                          {mini("Ganhos no total", brl(p.ganhos))}
                          {mini("Liberado agora", brl(p.saldo), t.green)}
                          {mini("Aguardando 7 dias", brl(p.aguardando), t.amber)}
                          {mini("Já sacou", brl(p.sacados), t.red)}
                        </div>

                        {p.pedido && (
                          <div style={{ marginTop: 12, padding: "10px 12px", borderRadius: 12, border: `1px solid ${pedido ? t.amber : t.border}`, background: t.surfaceAlt }}>
                            <div style={{ fontSize: 11, fontWeight: 800, letterSpacing: 0.4, textTransform: "uppercase", color: pedido ? t.amber : t.textMuted }}>
                              {pedido ? "Pedido de saque em aberto" : "Último pedido de saque (já pago)"}
                              {p.pedido.em ? ` · ${dataHora(p.pedido.em)}` : ""}
                            </div>
                            <div style={{ fontSize: 13, color: t.text, marginTop: 6, lineHeight: 1.45, whiteSpace: "pre-line", wordBreak: "break-word" }}>{p.pedido.mensagem}</div>
                          </div>
                        )}

                        {p.pode_sacar && (
                          <div style={{ marginTop: 12 }}>
                            <div style={{ fontSize: 12, color: t.textMuted, marginBottom: 6 }}>Depois de pagar o PIX, registre o saque no SQL Editor:</div>
                            <div style={{ display: "flex", alignItems: "center", gap: 8 }}>
                              <code style={{ flex: 1, minWidth: 0, fontSize: 11.5, padding: "8px 10px", borderRadius: 10, background: t.surfaceAlt, border: `1px solid ${t.border}`, color: t.text, wordBreak: "break-all" }}>{cmd}</code>
                              <button
                                type="button"
                                onClick={() => copiar(p.id, cmd)}
                                aria-label="Copiar comando"
                                style={{ display: "flex", alignItems: "center", gap: 5, flexShrink: 0, background: "transparent", border: `1px solid ${copiado === p.id ? t.green : t.border}`, color: copiado === p.id ? t.green : t.text, borderRadius: 10, padding: "8px 10px", fontSize: 12, fontWeight: 700, cursor: "pointer", fontFamily: "inherit" }}
                              >
                                {copiado === p.id ? <Check size={13} /> : <Copy size={13} />}
                                {copiado === p.id ? "Copiado" : "Copiar"}
                              </button>
                            </div>
                          </div>
                        )}

                        {(p.convites?.length > 0 || p.saques?.length > 0) && (
                          <ul style={{ listStyle: "none", margin: "14px 0 0", padding: 0, display: "flex", flexDirection: "column", gap: 9 }}>
                            {p.convites.map((cv, i) => {
                              const l = look(cv);
                              return (
                                <li key={`c-${i}`} style={{ display: "flex", alignItems: "center", justifyContent: "space-between", gap: 10 }}>
                                  <div style={{ minWidth: 0 }}>
                                    <div style={{ fontSize: 13, fontWeight: 700, color: l.cor, overflow: "hidden", textOverflow: "ellipsis", whiteSpace: "nowrap" }}>{cv.nome}</div>
                                    <div style={{ fontSize: 11.5, color: t.textMuted, overflow: "hidden", textOverflow: "ellipsis", whiteSpace: "nowrap" }}>
                                      {l.sub}
                                      {cv.email ? ` · ${cv.email}` : ""}
                                    </div>
                                  </div>
                                  {l.right && <span style={{ fontSize: 13, fontWeight: 800, color: l.cor, flexShrink: 0 }}>{l.right}</span>}
                                </li>
                              );
                            })}
                            {p.saques.map((s, i) => (
                              <li key={`s-${i}`} style={{ display: "flex", alignItems: "center", justifyContent: "space-between", gap: 10 }}>
                                <div>
                                  <div style={{ fontSize: 13, fontWeight: 700, color: t.red }}>Saque pago</div>
                                  <div style={{ fontSize: 11.5, color: t.textMuted }}>{dataHora(s.em)}</div>
                                </div>
                                <span style={{ fontSize: 13, fontWeight: 800, color: t.red }}>-{s.pontos}</span>
                              </li>
                            ))}
                          </ul>
                        )}
                      </div>
                    )}
                  </div>
                );
              })}
            </div>
            {pessoas.length >= 300 && <div style={{ fontSize: 11.5, color: t.textMuted, marginTop: 10 }}>Mostrando as 300 pessoas com mais saldo a pagar.</div>}
          </Section>
        </>
      )}
    </>
  );
}

// Compras e receita no topo da aba Assinantes (função admin_compras_resumo, supabase/painel_compras.sql): 24 h, 72 h, 30 dias, 365 dias e
// totais. Sem o SQL novo no banco, mostra os quatro números de antes (que vêm junto com os dados do painel) e avisa.
function ComprasResumo({ supabase, refreshKey, legado }) {
  const t = useT();
  const key = String(refreshKey);
  const [res, setRes] = useState({ key: "", status: "loading", data: null });

  useEffect(() => {
    let cancelled = false;
    fetchAdminComprasResumo(supabase).then(
      (data) => !cancelled && setRes({ key, status: data ? "ok" : "missing", data }),
      () => !cancelled && setRes({ key, status: "error", data: null })
    );
    return () => {
      cancelled = true;
    };
  }, [supabase, key]);

  const loading = res.key !== key;
  const c = !loading && res.status === "ok" ? res.data : null;
  const nota = { fontSize: 11.5, color: t.textMuted, marginTop: 8, lineHeight: 1.45 };
  const titulo = { fontSize: 12.5, fontWeight: 700, color: t.text, margin: "16px 0 8px" };

  if (!loading && !c) {
    return (
      <>
        <Grid>
          <Kpi label="Compras nas últimas 48 h" value={show(legado.compras_48h)} />
          <Kpi label="Compras nos últimos 7 dias" value={nf(legado.compras_7d)} />
          <Kpi label="Compras nos últimos 30 dias" value={nf(legado.compras_30d)} />
          <Kpi label="Receita dos últimos 30 dias" value={formatBRL(legado.receita_30d_centavos)} sub={`Total: ${formatBRL(legado.receita_total_centavos)}`} />
        </Grid>
        <div style={{ ...nota, color: res.status === "error" ? t.red : t.textMuted }}>
          {res.status === "missing"
            ? "Para ver compras e receita das últimas 24 h, 72 h e 365 dias e os totais, rode o SQL painel_compras.sql no Supabase e toque em Atualizar."
            : "Não foi possível carregar as compras agora. Toque em Atualizar para tentar de novo."}
        </div>
      </>
    );
  }

  const n = (x) => (c ? nf(x) : "—");
  const brl = (x) => (c ? formatBRL(x) : "—");
  return (
    <>
      <div style={{ ...titulo, marginTop: 2 }}>Compras</div>
      <Grid>
        <Kpi label="Nas últimas 24 h" value={n(c?.compras.h24)} />
        <Kpi label="Nas últimas 72 h" value={n(c?.compras.h72)} />
        <Kpi label="Nos últimos 30 dias" value={n(c?.compras.d30)} />
        <Kpi label="Nos últimos 365 dias" value={n(c?.compras.d365)} />
        <Kpi label="Totais" value={n(c?.compras.total)} wide />
      </Grid>
      <div style={titulo}>Receita</div>
      <Grid>
        <Kpi label="Nas últimas 24 h" value={brl(c?.receita_centavos.h24)} />
        <Kpi label="Nos últimos 30 dias" value={brl(c?.receita_centavos.d30)} />
        <Kpi label="Nos últimos 365 dias" value={brl(c?.receita_centavos.d365)} />
        <Kpi label="Totais" value={brl(c?.receita_centavos.total)} />
      </Grid>
      <div style={nota}>Só pagamentos aprovados de mensal e anual; cortesia e estornados não entram.</div>
    </>
  );
}

// Minutos em texto: "2,8 min" (abaixo de 10), "42 min", "1 h 05 min". Nulo vira "—".
function fmtMin(min) {
  if (min == null) return "—";
  const v = Number(min);
  if (v <= 0) return "0 min";
  if (v < 10) return `${nf(v, 1)} min`;
  const total = Math.round(v);
  if (total < 60) return `${total} min`;
  return `${Math.floor(total / 60)} h ${String(total % 60).padStart(2, "0")} min`;
}

// Aba Tempo de uso (supabase/painel_tempo_uso.sql). O app não mede o tempo de tela: o tempo é ESTIMADO pelas ações registradas
// (questão, flashcard, desafio, revisão diária), somando os intervalos entre ações seguidas; pausas longas não contam.
function TempoUsoTab({ supabase, refreshKey }) {
  const t = useT();
  const key = String(refreshKey);
  const [res, setRes] = useState({ key: "", status: "loading", data: null, error: "" });

  useEffect(() => {
    let cancelled = false;
    fetchAdminTempoUso(supabase).then(
      (data) => !cancelled && setRes({ key, status: data ? "ok" : "missing", data, error: "" }),
      (err) => !cancelled && setRes({ key, status: "error", data: null, error: err.message })
    );
    return () => {
      cancelled = true;
    };
  }, [supabase, key]);

  const loading = res.key !== key;
  const a = !loading && res.status === "ok" ? res.data : null;
  const box = { background: t.surface, border: `1px solid ${t.border}`, borderRadius: 14 };
  const usuariosTxt = (n) => `${nf(n)} ${n === 1 ? "usuário" : "usuários"}`;

  // uma pessoa com mais uso: e-mail em cima, números embaixo
  const person = (email, big, lines) => (
    <div style={{ ...box, padding: "13px 14px" }}>
      <div style={{ fontSize: 13.5, fontWeight: 700, color: t.text, overflow: "hidden", textOverflow: "ellipsis", whiteSpace: "nowrap" }}>{email || "(sem e-mail)"}</div>
      <div style={{ fontSize: 24, fontWeight: 800, color: t.green, marginTop: 6, fontVariantNumeric: "tabular-nums", lineHeight: 1.1 }}>{big}</div>
      {lines.map((l) => (
        <div key={l} style={{ fontSize: 12, color: t.textMuted, marginTop: 4, lineHeight: 1.4 }}>
          {l}
        </div>
      ))}
    </div>
  );

  const mesesBars = a ? a.meses.map((m) => ({ d: m.m, n: m.media_min, label: MESES_CURTOS[Number(m.m.slice(5, 7)) - 1] })) : [];

  return (
    <>
      {loading && <div style={{ fontSize: 13, color: t.textMuted, padding: "16px 2px" }}>Carregando…</div>}

      {!loading && res.status === "missing" && (
        <div style={{ ...box, padding: 16, marginTop: 22, fontSize: 13.5, lineHeight: 1.5, color: t.textMuted }}>
          Esta aba precisa do SQL painel_tempo_uso.sql rodado no Supabase. Rode-o e toque em Atualizar.
        </div>
      )}
      {!loading && res.status === "error" && <div style={{ ...box, padding: 16, marginTop: 22, fontSize: 13.5, lineHeight: 1.5, color: t.red }}>{res.error}</div>}

      {a && (
        <>
          <Section title="Média diária de uso por usuário">
            <Grid cols={3}>
              <Kpi label="Hoje" value={fmtMin(a.hoje.media_min)} sub={a.hoje.usuarios > 0 ? `${usuariosTxt(a.hoje.usuarios)} hoje` : "Ninguém usou ainda"} color={t.green} />
              <Kpi label="No mês" value={fmtMin(a.mes.media_min)} sub={a.mes.usuarios > 0 ? usuariosTxt(a.mes.usuarios) : "Sem uso"} color={t.green} />
              <Kpi label="No ano" value={fmtMin(a.ano.media_min)} sub={a.ano.usuarios > 0 ? usuariosTxt(a.ano.usuarios) : "Sem uso"} color={t.green} />
            </Grid>
            <div style={{ fontSize: 11.5, color: t.textMuted, marginTop: 8, lineHeight: 1.45 }}>
              Tempo médio por usuário que usou o app no dia (quem não usou não entra na conta). No mês e no ano, a média é por dia de uso de cada pessoa.
            </div>
            <ChartCard title="Média diária por mês (minutos por usuário)">
              <BarChart data={mesesBars} color={t.green} label="Média diária de uso por mês" format={(n) => nf(n, n < 10 ? 1 : 0)} />
            </ChartCard>
          </Section>

          <Section title="Usuário com mais uso hoje">
            {a.top_hoje ? person(a.top_hoje.email, fmtMin(a.top_hoje.minutos), ["Tempo de uso hoje"]) : <div style={{ ...box, padding: 14, fontSize: 13, color: t.textMuted }}>Ninguém usou o app hoje ainda.</div>}
          </Section>

          <Section title="Usuário com mais uso no mês">
            {a.top_mes ? (
              person(a.top_mes.email, fmtMin(a.top_mes.media_dia_mes_min), [
                `Média diária no mês: total de ${fmtMin(a.top_mes.minutos)} em ${nf(a.top_mes.dias_decorridos)} ${a.top_mes.dias_decorridos === 1 ? "dia" : "dias"} do mês.`,
                `Só nos dias em que usou (${nf(a.top_mes.dias_ativos)}): ${fmtMin(a.top_mes.media_dia_ativo_min)} por dia.`,
              ])
            ) : (
              <div style={{ ...box, padding: 14, fontSize: 13, color: t.textMuted }}>Ninguém usou o app neste mês ainda.</div>
            )}
          </Section>

          <div style={{ ...box, padding: "12px 14px", marginTop: 22, fontSize: 11.5, color: t.textMuted, lineHeight: 1.5 }}>
            <b style={{ color: t.text }}>Como o tempo é calculado.</b> O app não mede o tempo de tela. O tempo é estimado pelas ações registradas (questões respondidas, flashcards vistos, desafios e revisão diária): o intervalo entre duas ações seguidas conta quando é de até {nf(a.regras.pausa_min)} minutos; pausas maiores não contam, e uma ação sozinha vale {nf(a.regras.acao_isolada_seg)} segundos. Ler sem tocar em nada por mais tempo não aparece. Contas administradoras e bots ficam de fora. Dias no horário de Brasília.
          </div>
        </>
      )}
    </>
  );
}

// "De onde vêm" > Links de convite: por pessoa que convidou, as visitas que abriram o link dela e as contas criadas por ele.
function ConvitesOrigem({ state, loading }) {
  const t = useT();
  const box = { background: t.surface, border: `1px solid ${t.border}`, borderRadius: 14 };
  const nota = { fontSize: 11.5, color: t.textMuted, marginTop: 8, lineHeight: 1.45 };
  if (loading) return <div style={{ fontSize: 13, color: t.textMuted, padding: "6px 2px" }}>Carregando…</div>;
  if (state.status === "missing") {
    return <div style={{ ...box, padding: 14, fontSize: 13, lineHeight: 1.5, color: t.textMuted }}>Para ver os links de convite, rode o SQL acessos_convites.sql no Supabase e toque em Atualizar.</div>;
  }
  if (state.status === "error") {
    return <div style={{ ...box, padding: 14, fontSize: 13, lineHeight: 1.5, color: t.red }}>Não foi possível carregar os links de convite agora. Toque em Atualizar para tentar de novo.</div>;
  }
  const c = state.data;
  const lista = c.lista || [];
  return (
    <>
      <div style={{ fontSize: 12.5, color: t.text, lineHeight: 1.5, marginBottom: 10 }}>
        <b>{nf(c.visitas_convite)}</b> de {nf(c.visitas_total)} {c.visitas_total === 1 ? "visita veio" : "visitas vieram"} por link de convite ({pct(c.visitas_convite, c.visitas_total)}) e <b>{nf(c.contas_convite)}</b>{" "}
        {c.contas_convite === 1 ? "conta foi criada" : "contas foram criadas"} por convite no período.
      </div>
      {lista.length === 0 ? (
        <div style={{ fontSize: 13, color: t.textMuted, padding: "4px 2px" }}>Nenhum link de convite trouxe visitas nem contas neste período.</div>
      ) : (
        <ol style={{ listStyle: "none", margin: 0, padding: 0, ...box, overflow: "hidden" }}>
          {lista.map((r, i) => (
            <li key={r.codigo} style={{ display: "flex", alignItems: "center", gap: 12, padding: "11px 14px", borderTop: i ? `1px solid ${t.border}` : "none" }}>
              <span style={{ flex: 1, minWidth: 0 }}>
                <span style={{ display: "block", fontSize: 13.5, fontWeight: 700, color: t.text, overflow: "hidden", textOverflow: "ellipsis", whiteSpace: "nowrap" }}>{r.email ? r.nome : "Código sem dono"}</span>
                <span style={{ display: "block", fontSize: 11.5, color: t.textMuted, overflow: "hidden", textOverflow: "ellipsis", whiteSpace: "nowrap" }}>{r.email || `código ${r.codigo}`}</span>
              </span>
              <span style={{ textAlign: "right", flexShrink: 0 }}>
                <span style={{ display: "block", fontSize: 14, fontWeight: 800, color: t.text, fontVariantNumeric: "tabular-nums" }}>
                  {nf(r.visitas)} {r.visitas === 1 ? "visita" : "visitas"}
                </span>
                <span style={{ display: "block", fontSize: 11.5, color: t.textMuted, fontVariantNumeric: "tabular-nums" }}>
                  {nf(r.contas)} {r.contas === 1 ? "conta" : "contas"}
                </span>
              </span>
            </li>
          ))}
        </ol>
      )}
      <div style={nota}>
        Visitas: quem abriu o link de convite da pessoa; a contagem por link começa quando o app com essa novidade entra no ar. Contas: criadas pelo link da pessoa, vindas do cadastro (valem desde o começo dos convites). Para pontos e saques de cada pessoa, veja a aba Comissão.
      </div>
    </>
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

  // "De onde vêm": sites e campanhas (padrão) ou links de convite de outros usuários (supabase/acessos_convites.sql), buscados ao escolher.
  const [vista, setVista] = useState("sites");
  const [conv, setConv] = useState({ key: "", status: "loading", data: null });
  const needConv = vista === "convites" && conv.key !== key;
  useEffect(() => {
    if (!needConv) return undefined;
    let cancelled = false;
    fetchAdminAcessosConvites(supabase, dias).then(
      (data) => !cancelled && setConv({ key, status: data ? "ok" : "missing", data }),
      () => !cancelled && setConv({ key, status: "error", data: null })
    );
    return () => {
      cancelled = true;
    };
  }, [supabase, dias, key, needConv]);

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
            <OptionChips
              value={vista}
              onChange={setVista}
              label="Tipo de origem"
              options={[
                { id: "sites", label: "Sites e campanhas" },
                { id: "convites", label: "Links de convite" },
              ]}
            />
            {vista === "sites" ? (
              <>
                <SourceRows rows={a.origens} label={(r) => (r.origem === "direto" ? "Direto (sem origem)" : r.origem)} />
                <div style={{ fontSize: 11.5, color: t.textMuted, marginTop: 8, lineHeight: 1.45 }}>
                  O site de onde a pessoa chegou, ou o utm_source do link. Para separar campanhas, acrescente ao link do site algo como ?utm_source=instagram.
                </div>
              </>
            ) : (
              <ConvitesOrigem state={conv} loading={conv.key !== key} />
            )}
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
  // Sobe a cada "Atualizar" para a aba Acessos e o gráfico de novos usuários (que buscam os próprios dados) carregarem de novo.
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
              <NovosUsuariosChart supabase={supabase} serie14={d.series.novos} color={t.green} refreshKey={acessosKey} />
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
                    <Kpi label="Já usaram os dois" value={show(ex.temas.os_dois)} sub={ex.temas.os_dois == null ? undefined : pct(ex.temas.os_dois, d.usuarios.total)} />
                  </Grid>
                  <div style={{ fontSize: 11.5, color: t.textMuted, marginTop: 8, lineHeight: 1.45 }}>
                    Fundo escuro e claro: o tema que a conta usa hoje. &quot;Já usaram os dois&quot;: contas que já tiveram os dois fundos; o histórico começa quando o SQL foi rodado, então esse número tende a crescer.
                  </div>
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
                note="Ativo = respondeu questão (inclusive em desafio), viu flashcard, abriu a revisão diária ou criou desafio."
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
                    Entrou = respondeu questão, viu flashcard, abriu a revisão diária (acontece ao abrir o app) ou criou desafio. A hora é do último uso, no horário de Brasília.
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
                    <ComprasResumo supabase={supabase} refreshKey={acessosKey} legado={a} />
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
                      <Kpi label="Respondidas hoje" value={nf(q.hoje)} color={blue} sub={`${nf(q.diarias_hoje)} na revisão diária`} />
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
            <Section title="Revisão diária">
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
                        label="Revisões concluídas hoje"
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
                      title="Revisões concluídas por dia (14 dias)"
                      note="Concluída = respondeu todas as questões da revisão do dia (3 no plano gratuito). A revisão é sorteada quando a pessoa abre o app. Sequência ativa = concluiu a revisão hoje ou ontem."
                    >
                      <BarChart data={d.series.missoes || []} color={t.green} label="Revisões concluídas por dia" />
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
                <div style={{ fontSize: 11.5, color: t.textMuted, marginTop: 8, lineHeight: 1.45 }}>Sequência ativa = concluiu a revisão hoje ou ontem.</div>
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

            {tab === "comissao" && <ComissaoTab supabase={supabase} refreshKey={acessosKey} />}

            {tab === "tempo" && <TempoUsoTab supabase={supabase} refreshKey={acessosKey} />}

            {tab === "acessos" && <AcessosTab supabase={supabase} refreshKey={acessosKey} />}
          </>
        )}
      </div>
    </div>
  );
}
