"use client";

import { useEffect, useState } from "react";
import { X, Check, ChevronDown } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { PrimaryButton } from "@/components/ui/Primitives";
import { submitQuiz, saveQuiz, quizTable } from "@/lib/data/quiz";
import { track } from "@/lib/data/visitTracking";

// Mesma validade do cupom no banco (supabase/cupom_10diasgratis.sql: 02/12/2026 00:00 em Brasília). Depois disso o quiz some sozinho.
export const PROMO_UNTIL = new Date("2026-12-02T00:00:00-03:00").getTime();
// O contador começa quando a pessoa abre o site pela primeira vez e segue de onde parou nas visitas seguintes.
const PROMO_DURATION_MS = (47 * 60 + 56) * 60 * 1000;
const START_KEY = "fc-promo-10dias-inicio";

// Momento em que o contador termina (ms). Grava o início na primeira visita; nunca passa da validade real do cupom.
export function promoDeadline() {
  let start = Date.now();
  try {
    const saved = Number(window.localStorage.getItem(START_KEY));
    if (saved > 0 && saved <= start) start = saved;
    else window.localStorage.setItem(START_KEY, String(start));
  } catch {
    // sem armazenamento: o contador recomeça a cada visita
  }
  return Math.min(start + PROMO_DURATION_MS, PROMO_UNTIL);
}

const two = (n) => String(n).padStart(2, "0");
const clock = (ms) => {
  const s = Math.max(0, Math.floor(ms / 1000));
  return `${two(Math.floor(s / 3600))}:${two(Math.floor((s % 3600) / 60))}:${two(s % 60)}`;
};

const plural = (n, one, many) => `${n} ${n === 1 ? one : many}`;
const sourceLabel = (instituicao) => (/^INCOR/.test(instituicao) ? "R+ INCOR" : /^DANTE/.test(instituicao) ? "DANTE" : instituicao);

// Anúncio do quiz na abertura do site: "Crie sua conta GRÁTIS", o contador e 3 questões que dão de 3 a 10 dias grátis.
// estado: { quiz, feito, id, resultado } de /auth/quiz. Quando este IP já respondeu (feito), abre direto no resultado gravado.
// deadline/initialRest: fim do contador e o que falta agora (calculados fora, no mesmo instante).
// onDone(resultado): a pessoa clicou em "Criar minha conta". onClose: fechou.
// inline: o quiz aparece dentro da página de boas-vindas (sem janela por cima, sem botão de fechar e sem o título "Crie sua
// conta GRÁTIS", que a própria seção já traz).
export function LoginQuizPromo({ estado, deadline, initialRest, onClose, onExpire, onDone, inline = false }) {
  const t = useT();
  const quiz = estado.quiz;
  const [rest, setRest] = useState(initialRest);
  const [step, setStep] = useState(estado.feito ? "resultado" : -1); // -1 abertura | 0..n-1 questões | "resultado"
  const [answers, setAnswers] = useState({});
  const [grading, setGrading] = useState(false);
  const [failed, setFailed] = useState(false);
  const [result, setResult] = useState(estado.feito ? estado.resultado : null);
  const [alreadyDone, setAlreadyDone] = useState(!!estado.feito); // este IP já tinha tentativa gravada
  const [open, setOpen] = useState({}); // questões abertas no resultado, por slot
  const [full, setFull] = useState({}); // questões com a resposta completa aberta, por slot

  // Contagem anônima (aba Acessos do painel de dados): o quiz apareceu para esta visita.
  useEffect(() => {
    track("quiz_visto", null, { once: true });
  }, []);

  useEffect(() => {
    const id = setInterval(() => {
      const left = deadline - Date.now();
      if (left <= 0) {
        clearInterval(id);
        onExpire();
        return;
      }
      setRest(left);
    }, 1000);
    return () => clearInterval(id);
  }, [deadline, onExpire]);

  const questions = quiz.questoes;
  const table = quizTable(quiz.tabela);
  const current = typeof step === "number" && step >= 0 ? questions[step] : null;
  const isLast = typeof step === "number" && step === questions.length - 1;
  const veil = t.name === "dark" ? "rgba(5,11,30,0.55)" : "rgba(30,26,60,0.35)";

  const finish = async () => {
    if (grading) return;
    setGrading(true);
    setFailed(false);
    const saved = await submitQuiz(answers);
    setGrading(false);
    if (!saved) {
      setFailed(true);
      return;
    }
    saveQuiz(saved.id, saved.resultado);
    track("quiz_fim");
    setAlreadyDone(saved.jaTinha);
    setResult(saved.resultado);
    setStep("resultado");
  };

  const next = () => {
    track("resposta", step + 1);
    if (isLast) finish();
    else setStep((s) => s + 1);
  };

  const toggle = (setter, slot) => setter((o) => ({ ...o, [slot]: !o[slot] }));
  // Onde a pessoa estava ao fechar: 0 = abertura, 1 a 3 = questão, 4 = resultado.
  const close = () => {
    track("quiz_fechado", step === -1 ? 0 : step === "resultado" ? 4 : step + 1);
    onClose();
  };
  const small = { fontSize: 12.5, color: t.textMuted, lineHeight: 1.5 };

  const outerProps = inline
    ? { role: "region", "aria-label": "Quiz de boas-vindas", style: { width: "100%" } }
    : {
        role: "dialog",
        "aria-modal": "true",
        "aria-label": "Crie sua conta grátis",
        style: { position: "fixed", inset: 0, zIndex: 80, background: veil, backdropFilter: "blur(3px)", WebkitBackdropFilter: "blur(3px)", display: "flex", alignItems: "center", justifyContent: "center", padding: 16 },
      };
  const innerStyle = inline
    ? { position: "relative", width: "100%", boxSizing: "border-box", background: t.surface, border: `1px solid ${t.border}`, borderRadius: 20, padding: "22px 18px 20px", boxShadow: "0 10px 36px rgba(0,0,0,0.22)" }
    : { position: "relative", width: "100%", maxWidth: 400, maxHeight: "calc(100dvh - 32px)", overflowY: "auto", boxSizing: "border-box", background: t.surface, border: `1px solid ${t.border}`, borderRadius: 20, padding: "26px 22px 22px", boxShadow: "0 18px 50px rgba(0,0,0,0.35)" };

  return (
    <div {...outerProps}>
      <div style={innerStyle}>
        {!inline && (
          <button type="button" onClick={close} aria-label="Fechar" style={{ position: "absolute", top: 8, right: 8, width: 36, height: 36, border: "none", background: "transparent", color: t.textMuted, borderRadius: "50%", cursor: "pointer", display: "flex", alignItems: "center", justifyContent: "center" }}>
            <X size={18} />
          </button>
        )}

        {step === -1 && (
          <div style={{ textAlign: "center" }}>
            {!inline && (
              <h2 style={{ fontSize: 22, lineHeight: 1.25, fontWeight: 800, color: t.text, margin: "0 18px" }}>
                Crie sua conta <span style={{ color: t.primary }}>GRÁTIS</span>
              </h2>
            )}
            <div role="timer" aria-label="Tempo restante da oferta" style={{ marginTop: inline ? 0 : 12, fontSize: 32, lineHeight: 1.1, fontWeight: 800, color: t.text, fontVariantNumeric: "tabular-nums", letterSpacing: 0.5 }}>
              {clock(rest)}
            </div>
            <p style={{ margin: "16px 0 0", fontSize: 15, lineHeight: 1.5, fontWeight: 600, color: t.text }}>Faça 3 questões e ganhe dias grátis</p>
            <div style={{ display: "grid", gridTemplateColumns: "repeat(4, 1fr)", gap: 8, marginTop: 14 }}>
              {table.map((row) => (
                <div key={row.acertos} style={{ background: t.surfaceAlt, border: `1px solid ${t.border}`, borderRadius: 12, padding: "9px 4px" }}>
                  <div style={{ fontSize: 18, fontWeight: 800, color: t.primary, lineHeight: 1.1 }}>{row.dias}</div>
                  <div style={{ fontSize: 11, color: t.textMuted, marginTop: 2 }}>dias</div>
                  <div style={{ fontSize: 11.5, color: t.text, marginTop: 6, fontWeight: 600 }}>{plural(row.acertos, "acerto", "acertos")}</div>
                </div>
              ))}
            </div>
            <p style={{ ...small, margin: "12px 0 0" }}>Os dias entram sozinhos quando você criar a conta. Não precisa de cupom. Só vale uma tentativa.</p>
            <div style={{ marginTop: 18 }}>
              <PrimaryButton
                full
                onClick={() => {
                  track("quiz_inicio");
                  setStep(0);
                }}
              >
                Começar
              </PrimaryButton>
            </div>
          </div>
        )}

        {current && (
          <div>
            <div style={{ display: "flex", alignItems: "center", justifyContent: "space-between", gap: 12, marginRight: 34 }}>
              <span style={{ fontSize: 12, fontWeight: 700, letterSpacing: 0.6, textTransform: "uppercase", color: t.textMuted }}>
                Questão {step + 1} de {questions.length}
              </span>
              <span role="timer" aria-label="Tempo restante da oferta" style={{ fontSize: 13, fontWeight: 700, color: t.text, fontVariantNumeric: "tabular-nums" }}>
                {clock(rest)}
              </span>
            </div>
            <div style={{ display: "flex", gap: 6, marginTop: 10 }}>
              {questions.map((q, i) => (
                <span key={q.slot} style={{ flex: 1, height: 4, borderRadius: 2, background: i <= step ? t.primary : t.border }} />
              ))}
            </div>
            <div style={{ ...small, marginTop: 14 }}>
              {sourceLabel(current.instituicao)} · {current.tema}
            </div>
            <p style={{ margin: "6px 0 14px", fontSize: 15, lineHeight: 1.55, color: t.text, fontWeight: 600 }}>{current.enunciado}</p>
            <div style={{ display: "flex", flexDirection: "column", gap: 8 }}>
              {current.alternativas.map((alt) => {
                const picked = answers[current.slot] === alt.letra;
                return (
                  <button
                    key={alt.letra}
                    type="button"
                    onClick={() => setAnswers((a) => ({ ...a, [current.slot]: alt.letra }))}
                    aria-pressed={picked}
                    style={{ display: "flex", gap: 10, alignItems: "flex-start", textAlign: "left", width: "100%", padding: "11px 12px", borderRadius: 12, border: `1px solid ${picked ? t.primary : t.border}`, background: picked ? t.primarySoft : t.surfaceAlt, color: t.text, fontSize: 14, lineHeight: 1.45, cursor: "pointer", fontFamily: "inherit" }}
                  >
                    <span style={{ fontWeight: 800, color: picked ? t.primary : t.textMuted, flexShrink: 0 }}>{alt.letra}</span>
                    <span>{alt.texto}</span>
                  </button>
                );
              })}
            </div>
            {failed && <div style={{ fontSize: 12.5, color: t.red, marginTop: 12 }}>Não foi possível corrigir agora. Toque de novo para tentar.</div>}
            <div style={{ marginTop: 16 }}>
              <PrimaryButton full onClick={next} disabled={!answers[current.slot] || grading}>
                {grading ? "Corrigindo…" : isLast ? "Ver resultado" : "Próxima"}
              </PrimaryButton>
            </div>
          </div>
        )}

        {step === "resultado" && result && (
          <div>
            <div style={{ textAlign: "center", margin: "0 18px" }}>
              <div style={{ fontSize: 13, color: t.textMuted, fontWeight: 600 }}>
                Você acertou {result.acertos} de {result.total}
              </div>
              <div style={{ fontSize: 30, lineHeight: 1.15, fontWeight: 800, color: t.text, marginTop: 4 }}>
                {result.dias} dias <span style={{ color: t.primary }}>GRÁTIS</span>
              </div>
            </div>

            <div style={{ marginTop: 16, border: `1px solid ${t.border}`, borderRadius: 12, overflow: "hidden" }}>
              {quizTable(result.tabela).map((row) => {
                const mine = row.acertos === Math.min(result.acertos, 3);
                return (
                  <div key={row.acertos} style={{ display: "flex", justifyContent: "space-between", alignItems: "center", padding: "9px 12px", fontSize: 13.5, background: mine ? t.primarySoft : "transparent", color: mine ? t.text : t.textMuted, fontWeight: mine ? 700 : 500, borderTop: row.acertos ? `1px solid ${t.border}` : "none" }}>
                    <span>{plural(row.acertos, "acerto", "acertos")}</span>
                    <span style={{ display: "flex", alignItems: "center", gap: 6 }}>
                      {plural(row.dias, "dia", "dias")}
                      {mine && <Check size={15} color={t.primary} />}
                    </span>
                  </div>
                );
              })}
            </div>
            <p style={{ ...small, margin: "8px 0 0" }}>
              {alreadyDone ? "Este acesso já respondeu o quiz, então o resultado está salvo e não dá para refazer. " : ""}
              Seu resultado foi {plural(result.acertos, "acerto", "acertos")}, por isso são {result.dias} dias. Eles entram sozinhos quando você criar a conta, sem cupom.
            </p>

            <div style={{ display: "flex", flexDirection: "column", gap: 8, marginTop: 14 }}>
              {result.questoes.map((q, i) => {
                const src = questions.find((x) => x.slot === q.slot);
                const isOpen = !!open[q.slot];
                const color = q.acertou ? t.green : t.red;
                return (
                  <div key={q.slot} style={{ borderRadius: 12, background: t.surfaceAlt, border: `1px solid ${t.border}`, overflow: "hidden" }}>
                    <button
                      type="button"
                      onClick={() => toggle(setOpen, q.slot)}
                      aria-expanded={isOpen}
                      style={{ display: "flex", alignItems: "center", gap: 8, width: "100%", padding: "11px 12px", background: "transparent", border: "none", color: t.text, fontFamily: "inherit", cursor: "pointer", textAlign: "left" }}
                    >
                      <span style={{ display: "flex", color, flexShrink: 0 }}>{q.acertou ? <Check size={16} /> : <X size={16} />}</span>
                      <span style={{ fontSize: 13.5, fontWeight: 700, flex: 1 }}>
                        Questão {i + 1} · <span style={{ color }}>{q.acertou ? "Acertou" : "Errou"}</span>
                        <span style={{ fontWeight: 500, color: t.textMuted, fontSize: 12 }}> · {sourceLabel(q.instituicao)}</span>
                      </span>
                      <ChevronDown size={18} color={t.textMuted} style={{ flexShrink: 0, transition: "transform .2s", transform: isOpen ? "rotate(180deg)" : "none" }} />
                    </button>

                    {isOpen && (
                      <div style={{ padding: "0 12px 12px", borderTop: `1px solid ${t.border}` }}>
                        {src && <p style={{ margin: "10px 0 8px", fontSize: 13.5, lineHeight: 1.5, fontWeight: 600, color: t.text }}>{src.enunciado}</p>}
                        {src && (
                          <div style={{ display: "flex", flexDirection: "column", gap: 6 }}>
                            {src.alternativas.map((alt) => {
                              const right = alt.letra === q.correta;
                              const wrongPick = alt.letra === q.escolhida && !right;
                              const tone = right ? t.green : wrongPick ? t.red : t.textMuted;
                              return (
                                <div key={alt.letra} style={{ display: "flex", gap: 8, padding: "7px 9px", borderRadius: 9, fontSize: 13, lineHeight: 1.45, border: `1px solid ${right || wrongPick ? tone : t.border}`, color: right || wrongPick ? t.text : t.textMuted }}>
                                  <b style={{ color: tone, flexShrink: 0 }}>{alt.letra}</b>
                                  <span style={{ flex: 1 }}>{alt.texto}</span>
                                  {(right || wrongPick) && (
                                    <span style={{ fontSize: 11, fontWeight: 700, color: tone, flexShrink: 0, alignSelf: "flex-start", textAlign: "right", textTransform: "uppercase", letterSpacing: 0.3 }}>
                                      {right ? "Resposta" : "Você marcou"}
                                      {right && alt.letra === q.escolhida && (
                                        <span style={{ display: "block", textTransform: "none", fontWeight: 600, letterSpacing: 0 }}>você marcou</span>
                                      )}
                                    </span>
                                  )}
                                </div>
                              );
                            })}
                          </div>
                        )}
                        {/* Com a resposta completa aberta, a resumida some (a completa já a contém); o botão volta para ela. */}
                        {q.comentario && !(full[q.slot] && q.comentario_completo) && <div style={{ ...small, marginTop: 10, color: t.textMuted, whiteSpace: "pre-line" }}>{q.comentario}</div>}
                        {q.comentario_completo && (
                          <>
                            {full[q.slot] && <div style={{ ...small, marginTop: 10, color: t.textMuted, whiteSpace: "pre-line" }}>{q.comentario_completo}</div>}
                            <button
                              type="button"
                              onClick={() => toggle(setFull, q.slot)}
                              style={{ marginTop: 10, background: "transparent", border: `1px solid ${t.border}`, borderRadius: 999, color: t.primary, fontSize: 12.5, fontWeight: 700, padding: "6px 12px", cursor: "pointer", fontFamily: "inherit" }}
                            >
                              {full[q.slot] ? "Ver resposta resumida" : "Ver resposta completa"}
                            </button>
                          </>
                        )}
                      </div>
                    )}
                  </div>
                );
              })}
            </div>

            <div style={{ marginTop: 16 }}>
              <PrimaryButton
                full
                onClick={() => {
                  track("criar_clique");
                  onDone(result);
                }}
              >
                Criar minha conta
              </PrimaryButton>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}
