"use client";

import { useMemo, useState } from "react";
import { BarChart3, BookOpen, Clock, Award, History, Timer, Type, Lock, RotateCw } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { ScreenHeader, ExpandBox, Chip, Toggle, PrimaryButton, DropdownList } from "@/components/ui/Primitives";
import { applyQuestionFilters, deriveFilterOptions, parseInstituicao } from "@/lib/data/questions";
import { MAX_SESSIONS } from "@/lib/data/sessions";

// "Válvula, Hipertensão +2" / "Todos os temas" quando todas as opções estavam marcadas.
function resumir(lista, totalOpcoes, rotuloTodos, max = 2) {
  const itens = lista || [];
  if (!itens.length) return "—";
  if (totalOpcoes && itens.length >= totalOpcoes) return rotuloTodos;
  const mostrados = itens.slice(0, max).join(", ");
  return itens.length > max ? `${mostrados} +${itens.length - max}` : mostrados;
}

function resumirAnos(lista, totalOpcoes) {
  const itens = [...(lista || [])].sort((a, b) => a - b);
  if (!itens.length) return "—";
  if (totalOpcoes && itens.length >= totalOpcoes) return "Todos os anos";
  return itens.length > 3 ? `${itens[0]}–${itens[itens.length - 1]} (${itens.length} anos)` : itens.join(", ");
}

function formatarData(iso) {
  const d = new Date(iso);
  return `${d.toLocaleDateString("pt-BR")} ${d.toLocaleTimeString("pt-BR", { hour: "2-digit", minute: "2-digit" })}`;
}

// "um tema e ano", "um ano e uma instituição", "um tema, ano e uma instituição":
// o artigo só se repete quando muda o gênero.
function juntarFaltando(itens) {
  const partes = itens.map((it, i) => {
    const artigo = it.fem ? "uma" : "um";
    const anterior = itens[i - 1];
    return i > 0 && anterior.fem === it.fem ? it.nome : `${artigo} ${it.nome}`;
  });
  return partes.length > 1 ? `${partes.slice(0, -1).join(", ")} e ${partes[partes.length - 1]}` : partes[0];
}

export function QuestionsFilterScreen({
  allQuestions,
  favorites,
  filters,
  setFilters,
  onSetFontSize,
  onStart,
  onContinue,
  hasSavedSession,
  pastSessions = [],
  onResumeSession,
  onRedoSession,
  onOpenPerformance,
  onNavigate,
}) {
  const t = useT();
  const [open, setOpen] = useState({});
  const [openingId, setOpeningId] = useState(null);
  const [sessionError, setSessionError] = useState("");

  // Continua (redo = false) ou refaz (redo = true) uma sessão do histórico.
  const abrirSessao = async (row, redo) => {
    setOpeningId(row.id);
    setSessionError("");
    try {
      await (redo ? onRedoSession(row) : onResumeSession(row));
    } catch (err) {
      setSessionError(err.message || "Não foi possível abrir essa sessão.");
    } finally {
      setOpeningId(null);
    }
  };
  const { temas: TEMAS, anos, instituicoes } = useMemo(() => deriveFilterOptions(allQuestions), [allQuestions]);
  const toggle = (k) => setOpen((o) => ({ ...o, [k]: !o[k] }));

  const previewCount = useMemo(
    () => applyQuestionFilters(allQuestions, filters, favorites).length,
    [allQuestions, filters, favorites]
  );

  // Filtros obrigatórios que estão sem nenhuma seleção (ordem: tema, ano, instituição).
  const faltando = [
    filters.temas.length === 0 && { nome: "tema", fem: false },
    filters.anos.length === 0 && { nome: "ano", fem: false },
    filters.instituicoes.length === 0 && { nome: "instituição", fem: true },
  ].filter(Boolean);

  return (
    <div style={{ maxWidth: 640, margin: "0 auto", paddingBottom: 90 }}>
      <ScreenHeader title="Questões" onBack={() => onNavigate("home")} />
      <div style={{ padding: "18px 22px" }}>
        <ExpandBox title="Temas" icon={<BookOpen size={17} color={t.primary} />} open={open.temas} onToggle={() => toggle("temas")} badge={filters.temas.length}>
          <DropdownList
            options={TEMAS}
            selected={filters.temas}
            onChange={(temas) => setFilters((f) => ({ ...f, temas }))}
            multi
            allLabel="Todos"
          />
        </ExpandBox>

        <ExpandBox title="Anos" icon={<Clock size={17} color={t.primary} />} open={open.anos} onToggle={() => toggle("anos")} badge={filters.anos.length}>
          <DropdownList
            options={anos}
            selected={filters.anos}
            onChange={(anos) => setFilters((f) => ({ ...f, anos }))}
            multi
            allLabel="Todos"
          />
        </ExpandBox>

        <ExpandBox title="Instituições" icon={<Award size={17} color={t.primary} />} open={open.instituicoes} onToggle={() => toggle("instituicoes")} badge={filters.instituicoes.length}>
          <DropdownList
            options={instituicoes}
            selected={filters.instituicoes}
            onChange={(instituicoes) => setFilters((f) => ({ ...f, instituicoes }))}
            multi
            allLabel="Todos"
            groupBy={parseInstituicao}
          />
        </ExpandBox>

        <ExpandBox title="Cronômetro" icon={<Timer size={17} color={t.primary} />} open={open.cron} onToggle={() => toggle("cron")}>
          <Toggle
            checked={filters.cronometro}
            onChange={(v) => setFilters((f) => ({ ...f, cronometro: v }))}
            label="Ativar cronômetro"
            sub="Conta o tempo total da sessão"
          />
          {filters.cronometro && (
            <div style={{ display: "flex", alignItems: "center", gap: 8, marginTop: 6 }}>
              <span style={{ fontSize: 13, color: t.textMuted }}>Minutos:</span>
              <input
                type="number"
                min={1}
                value={filters.minutos}
                onChange={(e) => setFilters((f) => ({ ...f, minutos: Math.max(1, Number(e.target.value) || 1) }))}
                style={{ width: 70, padding: "6px 8px", borderRadius: 8, border: `1px solid ${t.border}`, background: t.surfaceAlt, color: t.text, fontSize: 16 }}
              />
            </div>
          )}
        </ExpandBox>

        <ExpandBox title="Tamanho da Letra" icon={<Type size={17} color={t.primary} />} open={open.fonte} onToggle={() => toggle("fonte")}>
          <div style={{ display: "flex", gap: 8 }}>
            {[["sm", "Pequena"], ["md", "Média"], ["lg", "Grande"]].map(([k, l]) => (
              <Chip key={k} active={filters.fontSize === k} onClick={() => onSetFontSize(k)}>
                {l}
              </Chip>
            ))}
          </div>
        </ExpandBox>

        <ExpandBox title="Modos" icon={<Lock size={17} color={t.primary} />} open={open.provas} onToggle={() => toggle("provas")}>
          <Toggle
            checked={filters.favoritasOnly}
            onChange={(v) => setFilters((f) => ({ ...f, favoritasOnly: v }))}
            label="Somente questões favoritas"
            sub={`${favorites.length} marcadas`}
          />
          <Toggle
            checked={filters.modoProva}
            onChange={(v) => setFilters((f) => ({ ...f, modoProva: v }))}
            label="Ativar Modo Prova"
            sub="Respostas só aparecem ao final, em uma revisão completa"
          />
          <Toggle
            checked={filters.mostrarAntigas}
            onChange={(v) => setFilters((f) => ({ ...f, mostrarAntigas: v }))}
            label="Mostrar Respostas Antigas"
            sub="Questões já respondidas abrem resolvidas, com sua resposta e o gabarito"
          />
        </ExpandBox>

        <ExpandBox
          title="Sessões Antigas"
          icon={<History size={17} color={t.primary} />}
          open={open.sessoes}
          onToggle={() => toggle("sessoes")}
          badge={pastSessions.length}
        >
          <PrimaryButton full variant="ghost" color={t.name === "light" ? t.surface : undefined} onClick={onOpenPerformance}>
            <BarChart3 size={14} style={{ marginRight: 6, verticalAlign: -2 }} />
            Desempenho
          </PrimaryButton>
          {sessionError && <div style={{ fontSize: 12, color: t.red, marginTop: 10 }}>{sessionError}</div>}
          {pastSessions.length === 0 ? (
            <div style={{ fontSize: 12.5, color: t.textMuted, marginTop: 12, lineHeight: 1.5 }}>
              Suas últimas {MAX_SESSIONS} sessões aparecem aqui, da mais nova para a mais antiga, para continuar ou refazer.
            </div>
          ) : (
            <div style={{ display: "flex", flexDirection: "column", gap: 10, marginTop: 12 }}>
              {pastSessions.map((s) => {
                const f = s.filters || {};
                const incompleta = !s.finished && s.answered < s.total;
                const busy = openingId === s.id;
                return (
                  <div
                    key={s.id}
                    style={{ background: t.surfaceAlt, border: `1px solid ${t.border}`, borderRadius: 12, padding: "12px 14px" }}
                  >
                    <div style={{ display: "flex", justifyContent: "space-between", alignItems: "flex-start", gap: 10 }}>
                      <div style={{ minWidth: 0 }}>
                        <div style={{ fontSize: 13.5, fontWeight: 700, color: t.text, lineHeight: 1.35 }}>
                          {resumir(f.temas, TEMAS.length, "Todos os temas")}
                        </div>
                        <div style={{ fontSize: 12, color: t.textMuted, marginTop: 3, lineHeight: 1.4 }}>
                          {resumir(f.instituicoes, instituicoes.length, "Todas as provas")} · {resumirAnos(f.anos, anos.length)}
                        </div>
                        <div style={{ fontSize: 11.5, color: t.textMuted, marginTop: 3 }}>{formatarData(s.updated_at)}</div>
                      </div>
                      <div style={{ textAlign: "right", flexShrink: 0 }}>
                        <div style={{ fontSize: 17, fontWeight: 800, color: t.primary, lineHeight: 1 }}>
                          {s.answered}/{s.total}
                        </div>
                        <div style={{ fontSize: 10.5, color: t.textMuted, marginTop: 3 }}>questões</div>
                      </div>
                    </div>
                    <div style={{ display: "flex", gap: 8, marginTop: 10 }}>
                      {incompleta && (
                        <div style={{ flex: 1 }}>
                          <PrimaryButton small full disabled={busy} onClick={() => abrirSessao(s, false)}>
                            {busy ? "Abrindo..." : "Continuar"}
                          </PrimaryButton>
                        </div>
                      )}
                      <div style={{ flex: 1 }}>
                        <PrimaryButton
                          small
                          full
                          variant="ghost"
                          color={t.name === "light" ? t.surface : undefined}
                          disabled={busy}
                          onClick={() => abrirSessao(s, true)}
                        >
                          Refazer
                        </PrimaryButton>
                      </div>
                    </div>
                  </div>
                );
              })}
            </div>
          )}
        </ExpandBox>

        <div style={{ marginTop: 20, display: "flex", flexDirection: "column", gap: 10 }}>
          <div style={{ fontSize: 12.5, color: t.textMuted, textAlign: "center" }}>
            {faltando.length ? `Selecione ao menos ${juntarFaltando(faltando)}` : `${previewCount} questões encontradas`}
          </div>
          {hasSavedSession && (
            <PrimaryButton full variant="ghost" color={t.name === "light" ? t.surface : undefined} onClick={onContinue}>
              <RotateCw size={14} style={{ marginRight: 6, verticalAlign: -2 }} />
              Continuar Sessão
            </PrimaryButton>
          )}
          <PrimaryButton full disabled={faltando.length > 0 || previewCount === 0} onClick={onStart}>
            Iniciar Questões
          </PrimaryButton>
        </div>
      </div>
    </div>
  );
}
