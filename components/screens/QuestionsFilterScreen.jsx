"use client";

import { useMemo, useState } from "react";
import { BookOpen, Clock, Award, Timer, Type, Star, Lock, RotateCw } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { ScreenHeader, ExpandBox, Chip, Toggle, PrimaryButton } from "@/components/ui/Primitives";
import { applyQuestionFilters, deriveFilterOptions } from "@/lib/data/questions";

export function QuestionsFilterScreen({
  allQuestions,
  favorites,
  filters,
  setFilters,
  onStart,
  onContinue,
  hasSavedSession,
  onNavigate,
}) {
  const t = useT();
  const [open, setOpen] = useState({ temas: true });
  const { temas: TEMAS, anos, instituicoes } = useMemo(() => deriveFilterOptions(allQuestions), [allQuestions]);
  const toggle = (k) => setOpen((o) => ({ ...o, [k]: !o[k] }));

  const toggleArr = (key, val) =>
    setFilters((f) => ({
      ...f,
      [key]: f[key].includes(val) ? f[key].filter((x) => x !== val) : [...f[key], val],
    }));

  const previewCount = useMemo(
    () => applyQuestionFilters(allQuestions, filters, favorites).length,
    [allQuestions, filters, favorites]
  );

  return (
    <div style={{ maxWidth: 640, margin: "0 auto", paddingBottom: 90 }}>
      <ScreenHeader title="Questões" onBack={() => onNavigate("home")} />
      <div style={{ padding: "18px 22px" }}>
        <ExpandBox title="Temas" icon={<BookOpen size={17} color={t.primary} />} open={open.temas} onToggle={() => toggle("temas")} badge={filters.temas.length}>
          <div style={{ display: "flex", flexWrap: "wrap", gap: 8 }}>
            {TEMAS.map((tm) => (
              <Chip key={tm} active={filters.temas.includes(tm)} onClick={() => toggleArr("temas", tm)}>
                {tm}
              </Chip>
            ))}
          </div>
        </ExpandBox>

        <ExpandBox title="Anos" icon={<Clock size={17} color={t.primary} />} open={open.anos} onToggle={() => toggle("anos")} badge={filters.anos.length}>
          <div style={{ display: "flex", flexWrap: "wrap", gap: 8 }}>
            {anos.map((a) => (
              <Chip key={a} active={filters.anos.includes(a)} onClick={() => toggleArr("anos", a)}>
                {a}
              </Chip>
            ))}
          </div>
        </ExpandBox>

        <ExpandBox title="Instituições" icon={<Award size={17} color={t.primary} />} open={open.instituicoes} onToggle={() => toggle("instituicoes")} badge={filters.instituicoes.length}>
          <div style={{ display: "flex", flexWrap: "wrap", gap: 8 }}>
            {instituicoes.map((i) => (
              <Chip key={i} active={filters.instituicoes.includes(i)} onClick={() => toggleArr("instituicoes", i)}>
                {i}
              </Chip>
            ))}
          </div>
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
              <Chip key={k} active={filters.fontSize === k} onClick={() => setFilters((f) => ({ ...f, fontSize: k }))}>
                {l}
              </Chip>
            ))}
          </div>
        </ExpandBox>

        <ExpandBox title="Favoritas" icon={<Star size={17} color={t.primary} />} open={open.fav} onToggle={() => toggle("fav")}>
          <Toggle
            checked={filters.favoritasOnly}
            onChange={(v) => setFilters((f) => ({ ...f, favoritasOnly: v }))}
            label="Somente questões favoritas"
            sub={`${favorites.length} marcadas`}
          />
        </ExpandBox>

        <ExpandBox title="Modo Prova" icon={<Lock size={17} color={t.primary} />} open={open.provas} onToggle={() => toggle("provas")}>
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

        <div style={{ marginTop: 20, display: "flex", flexDirection: "column", gap: 10 }}>
          <div style={{ fontSize: 12.5, color: t.textMuted, textAlign: "center" }}>{previewCount} questões encontradas</div>
          {hasSavedSession && (
            <PrimaryButton full variant="ghost" onClick={onContinue}>
              <RotateCw size={14} style={{ marginRight: 6, verticalAlign: -2 }} />
              Continuar Sessão
            </PrimaryButton>
          )}
          <PrimaryButton full disabled={previewCount === 0} onClick={onStart}>
            Iniciar Questões
          </PrimaryButton>
        </div>
      </div>
    </div>
  );
}
