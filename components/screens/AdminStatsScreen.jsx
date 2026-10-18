"use client";

import { useCallback, useEffect, useState } from "react";
import { RefreshCw } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { ScreenHeader, PrimaryButton } from "@/components/ui/Primitives";
import { fetchAdminStats } from "@/lib/data/adminStats";
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

// Tela de números do app, só para a conta administradora (botão em Minha Conta).
export function AdminStatsScreen({ supabase, onBack }) {
  const t = useT();
  const [state, setState] = useState({ status: "loading", data: null, error: "" });

  const load = useCallback(async () => {
    try {
      const data = await fetchAdminStats(supabase);
      setState({ status: "ok", data, error: "" });
    } catch (err) {
      setState({ status: "error", data: null, error: err.message });
    }
  }, [supabase]);

  useEffect(() => {
    let cancelled = false;
    fetchAdminStats(supabase).then(
      (data) => !cancelled && setState({ status: "ok", data, error: "" }),
      (err) => !cancelled && setState({ status: "error", data: null, error: err.message })
    );
    return () => {
      cancelled = true;
    };
  }, [supabase]);

  const refresh = () => {
    setState((s) => ({ ...s, status: "loading" }));
    load();
  };

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

            <Section title="Assinantes">
              {(() => {
                const a = d.assinaturas;
                const pagantes = a.mensal + a.anual;
                const semPlano = Math.max(0, d.usuarios.total - a.ativos);
                return (
                  <>
                    <Grid>
                      <Kpi
                        wide
                        label="Assinantes ativos"
                        value={nf(a.ativos)}
                        color={t.green}
                        sub={
                          <>
                            Quem tem acesso valendo agora: plano <b>mensal</b>, <b>anual</b> ou <b>cortesia</b> (acesso gratuito, como os 30 dias e o cupom).
                            <br />
                            {nf(a.mensal)} mensal · {nf(a.anual)} anual · {nf(a.cortesia)} cortesia
                            <br />
                            {nf(pagantes)} pagantes (mensal + anual) · {pct(a.ativos, d.usuarios.total)} dos usuários com acesso
                          </>
                        }
                      />
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
                      <Kpi label="Missões concluídas hoje" value={nf(q.missoes_concluidas_hoje)} sub={`${pct(q.missoes_concluidas_hoje, d.usuarios.total)} dos usuários`} color={t.green} />
                      <Kpi label="Questões no banco" value={nf(d.conteudo.questoes)} sub={`${nf(d.conteudo.flashcards)} flashcards`} />
                    </Grid>
                    <ChartCard title="Questões respondidas por dia (14 dias)" note="Inclui as respostas dentro de desafios.">
                      <BarChart data={d.series.questoes} color={blue} label="Questões respondidas por dia" />
                    </ChartCard>
                  </>
                );
              })()}
            </Section>

            <Section title="Flashcards">
              <Grid>
                <Kpi label="Vistos hoje" value={nf(d.flashcards.hoje)} color={t.amber} />
                <Kpi label="Vistos em 7 dias" value={nf(d.flashcards.d7)} color={t.amber} sub={`Média: ${nf(d.flashcards.d7 / 7, 1)} por dia`} />
              </Grid>
              <ChartCard title="Flashcards vistos por dia (14 dias)">
                <BarChart data={d.series.flashcards} color={t.amber} label="Flashcards vistos por dia" />
              </ChartCard>
            </Section>

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
          </>
        )}
      </div>
    </div>
  );
}
