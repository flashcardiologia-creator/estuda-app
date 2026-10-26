"use client";

import { useMemo, useState } from "react";
import { ChevronDown } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { EmptyState } from "@/components/ui/Primitives";
import { deriveFilterOptions } from "@/lib/data/questions";

// Aba "Provas" das Estatísticas: escolhe a prova (instituição) e o ano em menus suspensos e mostra, numa tabela, como a prova
// se divide em temas: questões, % da prova e (com "Todos os anos") as questões de cada ano. Usa só as questões do banco.

const temaName = (tema) => (tema && tema !== "undefined" ? tema : "Sem tema");
const share = (n, total) => (total ? (n / total) * 100 : 0);
const shareLabel = (p) => (p > 0 && p < 1 ? "<1%" : `${Math.round(p)}%`);

function Select({ id, label, value, onChange, children, style }) {
  const t = useT();
  return (
    <div style={{ minWidth: 0, ...style }}>
      <label htmlFor={id} style={{ display: "block", fontSize: 11.5, fontWeight: 700, color: t.textMuted, marginBottom: 6 }}>
        {label}
      </label>
      <div style={{ position: "relative" }}>
        <select
          id={id}
          value={value}
          onChange={onChange}
          style={{
            width: "100%",
            boxSizing: "border-box",
            minHeight: 44,
            padding: "10px 36px 10px 14px",
            borderRadius: 12,
            border: `1px solid ${t.border}`,
            background: t.surfaceAlt,
            color: t.text,
            fontSize: 16,
            fontFamily: "inherit",
            fontWeight: 600,
            appearance: "none",
            WebkitAppearance: "none",
            cursor: "pointer",
            textOverflow: "ellipsis",
          }}
        >
          {children}
        </select>
        <ChevronDown size={16} color={t.textMuted} aria-hidden="true" style={{ position: "absolute", right: 13, top: "50%", transform: "translateY(-50%)", pointerEvents: "none" }} />
      </div>
    </div>
  );
}

export function ExamStats({ allQuestions }) {
  const t = useT();

  // Provas que existem no banco (com pelo menos uma questão), na mesma ordem do filtro de Questões.
  const exams = useMemo(() => {
    const c = {};
    for (const q of allQuestions) c[q.instituicao] = (c[q.instituicao] || 0) + 1;
    return deriveFilterOptions(allQuestions).instituicoes.filter((i) => c[i]);
  }, [allQuestions]);

  const [pickedExam, setPickedExam] = useState(null);
  const [year, setYear] = useState("todos");
  const exam = pickedExam && exams.includes(pickedExam) ? pickedExam : exams[0] || null;

  const examQuestions = useMemo(() => allQuestions.filter((q) => q.instituicao === exam), [allQuestions, exam]);
  const years = useMemo(() => [...new Set(examQuestions.map((q) => q.ano))].sort((a, b) => b - a), [examQuestions]);
  const activeYear = year !== "todos" && years.includes(Number(year)) ? Number(year) : null;
  const scoped = useMemo(() => (activeYear == null ? examQuestions : examQuestions.filter((q) => q.ano === activeYear)), [examQuestions, activeYear]);

  // Uma linha por tema (do mais para o menos cobrado), com a contagem de cada ano.
  const { rows, yearCols } = useMemo(() => {
    const byTema = new Map();
    for (const q of scoped) {
      const name = temaName(q.tema);
      if (!byTema.has(name)) byTema.set(name, { tema: name, n: 0, perYear: {} });
      const r = byTema.get(name);
      r.n += 1;
      r.perYear[q.ano] = (r.perYear[q.ano] || 0) + 1;
    }
    const list = [...byTema.values()].map((r) => ({ ...r, pct: share(r.n, scoped.length) })).sort((a, b) => b.n - a.n || a.tema.localeCompare(b.tema));
    const cols = activeYear == null ? [...new Set(scoped.map((q) => q.ano))].sort((a, b) => a - b) : [];
    return { rows: list, yearCols: cols.length > 1 ? cols : [] };
  }, [scoped, activeYear]);

  if (!exam) return <EmptyState text="Ainda não há provas disponíveis." />;

  const examLabel = `${exam}${activeYear ? ` · ${activeYear}` : ""}`;
  const totalPerYear = (y) => scoped.filter((q) => q.ano === y).length;
  const cellBase = { padding: "11px 12px", textAlign: "right", borderTop: `1px solid ${t.border}`, fontVariantNumeric: "tabular-nums", whiteSpace: "nowrap" };
  const stickyHead = { position: "sticky", left: 0, zIndex: 1, background: t.surface };

  return (
    <div>
      {/* Filtros: uma linha só, acima da tabela. */}
      <div style={{ display: "grid", gridTemplateColumns: "minmax(0, 1fr)", gap: 10, marginBottom: 16 }}>
        <Select id="exam-select" label="Prova" value={exam} onChange={(e) => { setPickedExam(e.target.value); setYear("todos"); }}>
          {exams.map((e) => (
            <option key={e} value={e}>
              {e}
            </option>
          ))}
        </Select>
        {years.length > 1 && (
          <Select id="year-select" label="Ano" value={activeYear == null ? "todos" : String(activeYear)} onChange={(e) => setYear(e.target.value)} style={{ width: "50%", minWidth: 150 }}>
            <option value="todos">Todos</option>
            {years.map((y) => (
              <option key={y} value={y}>
                {y}
              </option>
            ))}
          </Select>
        )}
      </div>

      {rows.length === 0 ? (
        <EmptyState text="Esta prova ainda não tem questões." />
      ) : (
        <>
          <div style={{ overflowX: "auto", border: `1px solid ${t.border}`, borderRadius: 12, background: t.surface }}>
            <table aria-label={`Temas de ${examLabel}`} style={{ width: "100%", borderCollapse: "separate", borderSpacing: 0, fontSize: 13, color: t.text }}>
              <thead>
                <tr style={{ color: t.textMuted }}>
                  <th scope="col" style={{ ...stickyHead, padding: "11px 12px", textAlign: "left", fontWeight: 600, whiteSpace: "nowrap" }}>
                    Tema
                  </th>
                  <th scope="col" style={{ padding: "11px 12px", textAlign: "right", fontWeight: 600, whiteSpace: "nowrap" }}>
                    Questões
                  </th>
                  <th scope="col" style={{ padding: "11px 12px", textAlign: "right", fontWeight: 600, whiteSpace: "nowrap" }}>
                    % da prova
                  </th>
                  {yearCols.map((y) => (
                    <th key={y} scope="col" style={{ padding: "11px 12px", textAlign: "right", fontWeight: 600, whiteSpace: "nowrap", fontVariantNumeric: "tabular-nums" }}>
                      {y}
                    </th>
                  ))}
                </tr>
              </thead>
              <tbody>
                {rows.map((r) => (
                  <tr key={r.tema}>
                    <th scope="row" style={{ ...stickyHead, padding: "11px 12px", textAlign: "left", fontWeight: 700, borderTop: `1px solid ${t.border}`, minWidth: 150 }}>
                      {r.tema}
                    </th>
                    <td style={cellBase}>{r.n}</td>
                    <td style={cellBase}>{shareLabel(r.pct)}</td>
                    {yearCols.map((y) => (
                      <td key={y} style={{ ...cellBase, color: r.perYear[y] ? t.text : t.textMuted }}>
                        {r.perYear[y] || "—"}
                      </td>
                    ))}
                  </tr>
                ))}
              </tbody>
              <tfoot>
                <tr style={{ fontWeight: 700 }}>
                  <th scope="row" style={{ ...stickyHead, padding: "11px 12px", textAlign: "left", fontWeight: 700, borderTop: `1px solid ${t.border}` }}>
                    Total
                  </th>
                  <td style={cellBase}>{scoped.length}</td>
                  <td style={cellBase}>100%</td>
                  {yearCols.map((y) => (
                    <td key={y} style={cellBase}>
                      {totalPerYear(y)}
                    </td>
                  ))}
                </tr>
              </tfoot>
            </table>
          </div>
          <div style={{ fontSize: 11.5, color: t.textMuted, marginTop: 10, lineHeight: 1.5 }}>
            Do tema mais para o menos cobrado em {examLabel}.{yearCols.length > 0 ? " As colunas de ano mostram quantas questões de cada tema caíram em cada edição; role a tabela para o lado para ver todas." : ""}
          </div>
        </>
      )}
    </div>
  );
}
