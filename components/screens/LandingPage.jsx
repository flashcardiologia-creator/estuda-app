"use client";

import { useEffect, useRef, useState, useSyncExternalStore } from "react";
import { ArrowRight, BookOpen, ChartColumn, Check, ChevronDown, Flame, Gift, Layers, Repeat, Smartphone, Swords } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { PrimaryButton } from "@/components/ui/Primitives";
import { QuestionCard } from "@/components/screens/QuestionCard";
import { LoginQuizPromo } from "@/components/screens/LoginQuizPromo";
import { PLANS, formatBRL } from "@/lib/billing";
import { FREE_CHALLENGES_PER_DAY, PAID_CHALLENGES_PER_DAY } from "@/lib/access";

// Página de boas-vindas (quem abre o site sem conta). Em cima: cadastro ou entrada. Embaixo: tudo o que o app tem, o quiz
// dos dias grátis, o que é grátis e o que é assinatura, e as dúvidas mais comuns. Os textos de preço e limites vêm dos mesmos
// arquivos do resto do app (lib/billing.js e lib/access.js). O quiz só carrega quando a pessoa chega perto dele.

const MAX_W = 520;
const two = (n) => String(n).padStart(2, "0");
const clock = (ms) => {
  const s = Math.max(0, Math.floor(ms / 1000));
  return `${two(Math.floor(s / 3600))}:${two(Math.floor((s % 3600) / 60))}:${two(s % 60)}`;
};

const reducedQuery = "(prefers-reduced-motion: reduce)";
const subscribeReduced = (cb) => {
  const m = window.matchMedia?.(reducedQuery);
  m?.addEventListener?.("change", cb);
  return () => m?.removeEventListener?.("change", cb);
};
const reducedSnapshot = () => !!window.matchMedia?.(reducedQuery).matches;
const useReducedMotion = () => useSyncExternalStore(subscribeReduced, reducedSnapshot, () => false);

// true quando o elemento chega perto da tela (margem) e, se once, fica true para sempre. Recebe o próprio elemento (guardado
// com um ref de função), então funciona também quando ele só aparece depois.
function useNear(el, { margin = "240px", once = true } = {}) {
  const [near, setNear] = useState(false);
  useEffect(() => {
    if (!el) return undefined;
    if (typeof IntersectionObserver === "undefined") {
      // navegador sem IntersectionObserver: considera perto (no próximo ciclo)
      const id = setTimeout(() => setNear(true), 0);
      return () => clearTimeout(id);
    }
    const io = new IntersectionObserver(
      ([e]) => {
        if (e.isIntersecting) {
          setNear(true);
          if (once) io.disconnect();
        } else if (!once) {
          setNear(false);
        }
      },
      { rootMargin: margin },
    );
    io.observe(el);
    return () => io.disconnect();
  }, [el, margin, once]);
  return near;
}

// ---------- exemplo animado de questão ----------
// Questão de exemplo (escrita para esta página, não é de nenhuma prova). Mostra o que o app faz: riscar as improváveis,
// marcar a certa e ler o comentário curto e a resposta completa. Usa o mesmo cartão de questão do app.
const DEMO_COMENTARIO = "Angina, síncope e dispneia aos esforços, com pulso de ascensão lenta e baixa amplitude, B2 hipofonética e sopro sistólico ejetor de pico tardio, indicam estenose aórtica grave — alternativa D.";
const DEMO_Q = {
  id: "demo",
  ano: "Exemplo",
  instituicao: "FlashCardio",
  tema: "Válvula",
  enunciado: "Homem, 72 anos, com dispneia, angina e síncope aos esforços. Ao exame: pulso carotídeo de ascensão lenta e baixa amplitude, B2 hipofonética e sopro sistólico ejetor rude em foco aórtico, de pico tardio. Qual é o diagnóstico mais provável?",
  comentario: DEMO_COMENTARIO,
  comentario_completo: `${DEMO_COMENTARIO}\n\nPor que as outras alternativas estão incorretas:\n• A) Na insuficiência aórtica o sopro é diastólico e o pulso é amplo, em martelo d'água.\n• B) Na estenose mitral reumática há ruflar diastólico e B1 hiperfonética.\n• C) Na comunicação interatrial há desdobramento fixo de B2, sem esse pulso.`,
  imagem_url: null,
  comentario_imagem_url: null,
};
const DEMO_OPTS = [
  { id: "a", letra: "a", texto: "Insuficiência aórtica crônica grave." },
  { id: "b", letra: "b", texto: "Estenose mitral reumática." },
  { id: "c", letra: "c", texto: "Comunicação interatrial." },
  { id: "d", letra: "d", texto: "Estenose aórtica grave." },
];
const DEMO_RESULT = { selected: "d", correct: true, correct_option: "d", comentario: DEMO_COMENTARIO, annulled: false };
const DEMO_FILTERS = { fontSize: "md", modoProva: false };
const noop = () => {};
// passos do exemplo: 0 parado, 1-3 riscando A, B e C, 4 marcando a D, 5-7 respondida (comentário), 8 pausa
const DEMO_STRUCK = [[], ["a"], ["a", "b"], ["a", "b", "c"], ["a", "b", "c"], [], [], [], []];
const DEMO_LABELS = ["Risque as improváveis", "Marque a certa", "Leia o comentário"];
const demoLabel = (step) => (step <= 3 ? 0 : step === 4 ? 1 : 2);

function DemoCard({ step }) {
  const answered = step >= 5;
  return (
    <QuestionCard
      q={DEMO_Q}
      options={DEMO_OPTS}
      filters={DEMO_FILTERS}
      selected={step >= 4 ? "d" : null}
      onSelect={noop}
      answered={answered}
      answerResult={answered ? DEMO_RESULT : null}
      onResponder={noop}
      responding={false}
      struckLetras={DEMO_STRUCK[step] || []}
      onToggleStruck={noop}
    />
  );
}

function Demo() {
  const t = useT();
  const reduced = useReducedMotion();
  const [holder, setHolder] = useState(null);
  const visible = useNear(holder, { margin: "0px", once: false });
  const [step, setStep] = useState(0);
  const winRef = useRef(null);
  const innerRef = useRef(null);

  useEffect(() => {
    if (reduced || !visible) return undefined;
    const id = setInterval(() => setStep((s) => (s + 1) % 9), 1200);
    return () => clearInterval(id);
  }, [visible, reduced]);

  // Com "reduzir movimento" ligado, mostra direto o exemplo já respondido, sem animar.
  const shown = reduced ? 7 : step;
  const active = demoLabel(shown);

  // A "tela" tem altura fixa: quando o comentário aparece, o conteúdo rola até ele (como o aluno faria no celular).
  useEffect(() => {
    const w = winRef.current;
    const i = innerRef.current;
    if (!w || !i) return;
    const off = shown >= 5 ? Math.max(0, i.scrollHeight - w.clientHeight + 14) : 0;
    i.style.transform = `translateY(${-off}px)`;
  }, [shown]);

  return (
    <div ref={setHolder}>
      <div role="img" aria-label="Exemplo animado: o aluno risca as alternativas improváveis, marca a certa e lê o comentário da questão." style={{ background: t.surface, border: `1px solid ${t.border}`, borderRadius: 20, boxShadow: "0 14px 44px rgba(0,0,0,0.22)", pointerEvents: "none", userSelect: "none", overflow: "hidden" }}>
        <div ref={winRef} style={{ height: 560, overflow: "hidden", WebkitMaskImage: "linear-gradient(180deg, #000 90%, transparent)", maskImage: "linear-gradient(180deg, #000 90%, transparent)" }}>
          <div ref={innerRef} aria-hidden="true" style={{ padding: "18px 16px 20px", transition: reduced ? "none" : "transform .8s cubic-bezier(.3,.7,.2,1)" }}>
            <DemoCard step={shown} />
          </div>
        </div>
      </div>
      <ol style={{ listStyle: "none", margin: "14px 0 0", padding: 0, display: "flex", gap: 8, justifyContent: "center", flexWrap: "wrap" }}>
        {DEMO_LABELS.map((label, i) => (
          <li
            key={label}
            style={{ display: "flex", alignItems: "center", gap: 7, padding: "6px 12px 6px 7px", borderRadius: 999, fontSize: 12.5, fontWeight: 700, border: `1px solid ${i === active ? t.primary : t.border}`, background: i === active ? t.primarySoft : "transparent", color: i === active ? t.text : t.textMuted, transition: "all .2s" }}
          >
            <span style={{ width: 20, height: 20, borderRadius: "50%", background: i === active ? t.primary : t.border, color: i === active ? "#fff" : t.textMuted, display: "grid", placeItems: "center", fontSize: 11 }}>{i + 1}</span>
            {label}
          </li>
        ))}
      </ol>
    </div>
  );
}

// ---------- blocos da página ----------
function Section({ id, eyebrow, title, intro, children, style }) {
  const t = useT();
  return (
    <section id={id} style={{ padding: "44px 0 4px", scrollMarginTop: 20, ...style }}>
      {eyebrow && <div style={{ fontSize: 12, fontWeight: 800, letterSpacing: 1.2, textTransform: "uppercase", color: t.primary, marginBottom: 10 }}>{eyebrow}</div>}
      <h2 style={{ margin: 0, fontSize: "clamp(24px, 6.4vw, 30px)", lineHeight: 1.15, letterSpacing: "-0.02em", fontWeight: 800, color: t.text, textWrap: "balance" }}>{title}</h2>
      {intro && <p style={{ margin: "12px 0 0", fontSize: 15.5, lineHeight: 1.6, color: t.textMuted }}>{intro}</p>}
      <div style={{ marginTop: 22 }}>{children}</div>
    </section>
  );
}

// Instituições das provas do banco de questões (as que já estão e as que entram em breve). Uma lista só: as etiquetas dos recursos
// e o texto das dúvidas saem dela, então ao entrar uma instituição nova basta acrescentá-la aqui.
const INSTITUICOES = ["TEC", "ENARE", "INCOR R+", "SUS-SP", "DANTE", "BP", "SIRIO", "SAMARITANO", "IAMSPE", "UNIFESP", "USP-RP"];
const listaPt = (xs) => (xs.length > 1 ? `${xs.slice(0, -1).join(", ")} e ${xs[xs.length - 1]}` : xs[0] || "");

function InstChips() {
  const t = useT();
  return (
    <ul aria-label="Instituições das provas" style={{ listStyle: "none", margin: "12px 0 0", padding: 0, display: "flex", flexWrap: "wrap", gap: 6 }}>
      {INSTITUICOES.map((nome) => (
        <li key={nome} style={{ fontSize: 11.5, fontWeight: 700, letterSpacing: 0.3, textTransform: "uppercase", color: t.textMuted, background: t.surfaceAlt, border: `1px solid ${t.border}`, padding: "4px 10px", borderRadius: 8 }}>
          {nome}
        </li>
      ))}
    </ul>
  );
}

const FEATURES = [
  { icon: BookOpen, title: "Questões comentadas", text: "Provas anteriores das principais instituições. Cada questão tem comentário curto e resposta completa. Filtre por tema, ano e instituição, use o cronômetro ou o modo prova.", extra: <InstChips /> },
  { icon: Layers, title: "Flashcards", text: "Cartões para revisar os conceitos que mais caem. Você também pode criar os seus." },
  { icon: Flame, title: "Missão diária e sequência", text: "Todo dia, um conjunto de questões. Conclua a missão e mantenha sua sequência de dias seguidos." },
  { icon: Repeat, title: "Revisão dos erros", text: "Para assinantes, as questões que você errou voltam na hora certa, pela curva de Ebbinghaus, para fixar o conteúdo." },
  { icon: Swords, title: "Desafios e ranking", text: "Desafie seus amigos com um conjunto de questões, veja quem acerta mais e suba no ranking." },
  { icon: ChartColumn, title: "Estatísticas", text: "Acompanhe seus acertos por tema e por prova para saber onde focar o estudo." },
];

function FeatureCard({ icon: Icon, title, text, extra }) {
  const t = useT();
  return (
    <div style={{ background: t.surface, border: `1px solid ${t.border}`, borderRadius: 16, padding: "16px 16px 18px", display: "flex", gap: 14 }}>
      <span style={{ flexShrink: 0, width: 42, height: 42, borderRadius: 12, background: t.primarySoft, color: t.primary, display: "grid", placeItems: "center" }}>
        <Icon size={21} />
      </span>
      <div>
        <h3 style={{ margin: 0, fontSize: 16.5, fontWeight: 700, color: t.text }}>{title}</h3>
        <p style={{ margin: "5px 0 0", fontSize: 14.5, lineHeight: 1.55, color: t.textMuted }}>{text}</p>
        {extra}
      </div>
    </div>
  );
}

function CheckList({ items, accent }) {
  const t = useT();
  return (
    <ul style={{ listStyle: "none", margin: 0, padding: 0, display: "flex", flexDirection: "column", gap: 10 }}>
      {items.map((it) => (
        <li key={it} style={{ display: "flex", gap: 10, alignItems: "flex-start", fontSize: 14.5, lineHeight: 1.5, color: t.text }}>
          <Check size={17} color={accent} style={{ flexShrink: 0, marginTop: 2 }} />
          <span>{it}</span>
        </li>
      ))}
    </ul>
  );
}

function PlansBlock() {
  const t = useT();
  const { mensal, anual } = PLANS;
  const card = { background: t.surface, border: `1px solid ${t.border}`, borderRadius: 18, padding: "20px 18px" };
  return (
    <div style={{ display: "flex", flexDirection: "column", gap: 14 }}>
      <div style={card}>
        <div style={{ fontSize: 12, fontWeight: 800, letterSpacing: 1, textTransform: "uppercase", color: t.textMuted }}>Grátis</div>
        <div style={{ fontSize: 22, fontWeight: 800, color: t.text, margin: "4px 0 14px" }}>Para começar</div>
        <CheckList
          accent={t.green}
          items={[
            "Missão diária com 3 questões e sequência",
            "Ranking, estatísticas e amigos",
            `${FREE_CHALLENGES_PER_DAY} desafio por dia`,
            "Dias grátis liberam Questões e Flashcards",
          ]}
        />
      </div>
      <div style={{ ...card, border: `1.5px solid ${t.primary}`, background: t.primarySoft }}>
        <div style={{ fontSize: 12, fontWeight: 800, letterSpacing: 1, textTransform: "uppercase", color: t.primary }}>Assinatura</div>
        <div style={{ fontSize: 22, fontWeight: 800, color: t.text, margin: "4px 0 14px" }}>Para estudar sem limite</div>
        <CheckList
          accent={t.primary}
          items={[
            "Telas de Questões e Flashcards liberadas",
            "Missão com 10 questões, ou 5 questões e 5 flashcards",
            "Revisão dos erros na hora certa",
            `Até ${PAID_CHALLENGES_PER_DAY} desafios por dia e bandagem para salvar a sequência`,
          ]}
        />
        <div style={{ display: "flex", gap: 10, marginTop: 18 }}>
          <div style={{ flex: 1, background: t.surface, border: `1px solid ${t.border}`, borderRadius: 14, padding: "12px 12px" }}>
            <div style={{ fontSize: 12, color: t.textMuted, fontWeight: 600 }}>Mensal</div>
            <div style={{ fontSize: 20, fontWeight: 800, color: t.text }}>{formatBRL(mensal.priceCents)}</div>
            <div style={{ fontSize: 12, color: t.textMuted }}>{mensal.days} dias</div>
          </div>
          <div style={{ flex: 1, background: t.surface, border: `1px solid ${t.border}`, borderRadius: 14, padding: "12px 12px" }}>
            <div style={{ fontSize: 12, color: t.textMuted, fontWeight: 600 }}>Anual</div>
            <div style={{ fontSize: 20, fontWeight: 800, color: t.text }}>{formatBRL(anual.priceCents)}</div>
            <div style={{ fontSize: 12, color: t.textMuted }}>{formatBRL(Math.round(anual.priceCents / 12))} por mês</div>
          </div>
        </div>
        <p style={{ margin: "12px 0 0", fontSize: 12.5, lineHeight: 1.5, color: t.textMuted }}>Pix ou cartão, pelo Mercado Pago. Sem renovação automática: você só paga quando quiser.</p>
      </div>
    </div>
  );
}

function Faq({ items }) {
  const t = useT();
  return (
    <div className="lp-faq" style={{ display: "flex", flexDirection: "column", gap: 10 }}>
      {items.map(({ q, a }) => (
        <details key={q} style={{ background: t.surface, border: `1px solid ${t.border}`, borderRadius: 14 }}>
          <summary style={{ listStyle: "none", cursor: "pointer", display: "flex", alignItems: "center", justifyContent: "space-between", gap: 12, padding: "15px 16px", fontSize: 15, fontWeight: 700, color: t.text }}>
            {q}
            <ChevronDown className="lp-chev" size={18} color={t.textMuted} style={{ flexShrink: 0, transition: "transform .2s" }} />
          </summary>
          <p style={{ margin: 0, padding: "0 16px 16px", fontSize: 14.5, lineHeight: 1.6, color: t.textMuted }}>{a}</p>
        </details>
      ))}
    </div>
  );
}

export function LandingPage({ knownHere, offer, onExpire, onQuizDone, onSignup, onLogin, onInstall, onLegal }) {
  const t = useT();
  const reduced = useReducedMotion();
  const [rest, setRest] = useState(offer ? offer.rest : 0);
  const [quizHolder, setQuizHolder] = useState(null);
  const quizNear = useNear(quizHolder, { margin: "320px" });

  // Contador da oferta (o mesmo prazo do quiz). Ao zerar, a oferta some da página.
  useEffect(() => {
    if (!offer) return undefined;
    const id = setInterval(() => {
      const left = offer.deadline - Date.now();
      if (left <= 0) {
        clearInterval(id);
        onExpire();
        return;
      }
      setRest(left);
    }, 1000);
    return () => clearInterval(id);
  }, [offer, onExpire]);

  const goQuiz = () => {
    const el = document.getElementById("quiz");
    if (el) el.scrollIntoView({ behavior: reduced ? "auto" : "smooth", block: "start" });
  };

  const faq = [
    { q: "Preciso pagar para começar?", a: "Não. Criar a conta é grátis, e a missão diária, o ranking, as estatísticas e os amigos ficam liberados sem assinatura. Para usar as telas de Questões e Flashcards, você assina ou usa os dias grátis." },
    { q: "Como ganho dias grátis?", a: "Respondendo ao quiz de boas-vindas: 3 questões, de 3 a 10 dias grátis conforme os acertos, liberados sozinhos quando você cria a conta. Não precisa de cupom, e só vale uma tentativa por aparelho." },
    { q: "Quais provas tem no app?", a: `Questões de provas anteriores de ${listaPt(INSTITUICOES)}, com comentário curto e resposta completa. Você filtra por tema, ano e instituição.` },
    { q: "Como instalo no celular?", a: "O FlashCardio abre no navegador e também pode ser instalado como aplicativo, sem loja. Toque em Baixar aplicativo e siga o passo a passo para iPhone ou Android." },
    { q: "Tem renovação automática?", a: "Não. Você paga por Pix ou cartão quando quiser e os dias novos são somados ao fim da assinatura atual. O app avisa quando faltarem 7, 3 e 1 dia para vencer." },
  ];

  const rise = (delay) => (reduced ? undefined : { animation: `lp-rise .55s cubic-bezier(.2,.7,.2,1) ${delay}s both` });
  const primaryAction = knownHere ? onLogin : onSignup;
  const secondaryAction = knownHere ? onSignup : onLogin;
  const primaryLabel = knownHere ? "Entrar" : "Criar conta grátis";
  const secondaryLabel = knownHere ? "Criar conta grátis" : "Já tenho conta";
  const linkBtn = { background: "transparent", border: "none", padding: 0, font: "inherit", color: t.textMuted, cursor: "pointer", textDecoration: "underline", textUnderlineOffset: 3 };

  return (
    <div style={{ width: "100%", color: t.text, overflowX: "clip" }}>
      <header style={{ borderBottom: `1px solid ${t.border}` }}>
        <div style={{ maxWidth: MAX_W, margin: "0 auto", padding: "12px 20px", display: "flex", alignItems: "center", gap: 8 }}>
          <Flame size={26} color={t.amber} fill={t.amber} aria-hidden="true" />
          <span style={{ fontSize: 19, fontWeight: 800, letterSpacing: "-0.01em" }}>FlashCardio</span>
        </div>
      </header>

      <main style={{ maxWidth: MAX_W, margin: "0 auto", padding: "0 20px 36px" }}>
        {/* Topo: oferta, título e as duas portas de entrada (cadastro e login) */}
        <section style={{ position: "relative", padding: "30px 0 8px" }}>
          <div aria-hidden="true" style={{ position: "absolute", inset: "-90px -40px auto -40px", height: 380, background: `radial-gradient(420px 260px at 82% 8%, ${t.primary}38, transparent 70%), radial-gradient(360px 240px at 6% 30%, ${t.amber}1f, transparent 70%)`, pointerEvents: "none" }} />
          <div style={{ position: "relative" }}>
            <div style={rise(0)}>
              {offer ? (
                <button type="button" onClick={goQuiz} style={{ display: "inline-flex", alignItems: "center", gap: 8, padding: "7px 14px 7px 10px", borderRadius: 999, border: `1px solid ${t.amber}66`, background: `${t.amber}1a`, color: t.text, fontSize: 13, fontWeight: 700, cursor: "pointer", fontFamily: "inherit" }}>
                  <Gift size={16} color={t.amber} />
                  Até 10 dias grátis
                  <span style={{ color: t.textMuted, fontWeight: 600, fontVariantNumeric: "tabular-nums" }}>· termina em {clock(rest)}</span>
                </button>
              ) : (
                <span style={{ display: "inline-flex", alignItems: "center", gap: 8, padding: "7px 14px", borderRadius: 999, border: `1px solid ${t.border}`, background: t.surface, color: t.textMuted, fontSize: 13, fontWeight: 700 }}>
                  <span style={{ width: 7, height: 7, borderRadius: "50%", background: t.green }} />
                  Missão diária grátis
                </span>
              )}
            </div>
            <h1 style={{ margin: "18px 0 0", fontSize: "clamp(34px, 10vw, 46px)", lineHeight: 1.06, letterSpacing: "-0.035em", fontWeight: 800, color: t.text, ...rise(0.06) }}>
              Estude cardiologia
              <br />
              em <span style={{ color: t.amber }}>qualquer lugar</span>
            </h1>
            <p style={{ margin: "16px 0 0", fontSize: 16.5, lineHeight: 1.6, color: t.textMuted, ...rise(0.12) }}>
              Questões comentadas de provas anteriores, flashcards, missão diária e desafios com amigos. Tudo no celular, em poucos minutos por dia.
            </p>
            <div style={{ display: "flex", flexDirection: "column", gap: 10, marginTop: 24, ...rise(0.18) }}>
              <PrimaryButton full onClick={primaryAction}>
                {primaryLabel}
                <ArrowRight size={17} style={{ marginLeft: 8 }} />
              </PrimaryButton>
              <PrimaryButton full variant="ghost" color={t.name === "light" ? t.surface : undefined} onClick={secondaryAction}>
                {secondaryLabel}
              </PrimaryButton>
            </div>
            <p style={{ margin: "12px 0 0", fontSize: 12.5, color: t.textMuted, textAlign: "center", ...rise(0.22) }}>Sem cartão de crédito para começar.</p>
          </div>
        </section>

        <Section id="como-e" eyebrow="Veja na prática" title="Resolver uma questão no FlashCardio" style={{ paddingTop: 34 }}>
          <Demo />
        </Section>

        {offer && (
          <Section id="quiz" eyebrow="Oferta de boas-vindas" title="Pegue seus dias grátis" intro="Responda 3 questões e ganhe de 3 a 10 dias com Questões e Flashcards liberados. Sem cupom: os dias entram sozinhos quando você criar a conta.">
            <div ref={setQuizHolder} style={{ minHeight: 330 }}>
              {quizNear && <LoginQuizPromo inline estado={offer.estado} deadline={offer.deadline} initialRest={offer.rest} onClose={onExpire} onExpire={onExpire} onDone={onQuizDone} />}
            </div>
          </Section>
        )}

        <Section id="recursos" eyebrow="O que tem no app" title="Tudo para estudar cardiologia com constância">
          <div style={{ display: "flex", flexDirection: "column", gap: 12 }}>
            {FEATURES.map((f) => (
              <FeatureCard key={f.title} {...f} />
            ))}
          </div>
        </Section>

        <Section id="planos" eyebrow="Grátis e assinatura" title="Comece grátis. Assine quando quiser." intro="Você usa a missão diária e o que mais vier sem pagar nada. A assinatura libera o estudo completo.">
          <PlansBlock />
        </Section>

        <Section id="duvidas" eyebrow="Dúvidas" title="Perguntas frequentes">
          <Faq items={faq} />
        </Section>

        <Section id="comece" eyebrow="Comece em 1 minuto" title="Sua primeira missão é hoje.">
          <ol style={{ listStyle: "none", margin: 0, padding: 0, display: "flex", flexDirection: "column", gap: 12 }}>
            {["Crie a conta com nome, e-mail e senha.", "Faça a missão diária: 3 questões grátis.", "Mantenha a sequência e suba no ranking."].map((txt, i) => (
              <li key={txt} style={{ display: "flex", gap: 14, alignItems: "center", fontSize: 15.5, color: t.text }}>
                <span style={{ flexShrink: 0, width: 30, height: 30, borderRadius: "50%", background: t.primarySoft, color: t.primary, display: "grid", placeItems: "center", fontWeight: 800, fontSize: 14 }}>{i + 1}</span>
                {txt}
              </li>
            ))}
          </ol>
          <div style={{ display: "flex", flexDirection: "column", gap: 10, marginTop: 24 }}>
            <PrimaryButton full onClick={primaryAction}>
              {primaryLabel}
              <ArrowRight size={17} style={{ marginLeft: 8 }} />
            </PrimaryButton>
            <PrimaryButton full variant="ghost" color={t.name === "light" ? t.surface : undefined} onClick={secondaryAction}>
              {secondaryLabel}
            </PrimaryButton>
            <PrimaryButton full variant="ghost" color={t.name === "light" ? t.surface : undefined} onClick={onInstall}>
              <Smartphone size={15} style={{ marginRight: 6, verticalAlign: -3 }} />
              Baixar aplicativo
            </PrimaryButton>
          </div>
        </Section>
      </main>

      <footer style={{ borderTop: `1px solid ${t.border}`, padding: "22px 20px 30px" }}>
        <div style={{ maxWidth: MAX_W, margin: "0 auto", display: "flex", flexDirection: "column", gap: 10, alignItems: "center", textAlign: "center", fontSize: 13, color: t.textMuted }}>
          <div style={{ display: "flex", alignItems: "center", gap: 7, color: t.text, fontWeight: 800 }}>
            <Flame size={18} color={t.amber} fill={t.amber} aria-hidden="true" />
            FlashCardio
          </div>
          <div>Feito para quem estuda cardiologia.</div>
          <div style={{ display: "flex", gap: 18 }}>
            <button type="button" style={linkBtn} onClick={() => onLegal("termos")}>
              Termos de Uso
            </button>
            <button type="button" style={linkBtn} onClick={() => onLegal("privacidade")}>
              Política de Privacidade
            </button>
          </div>
        </div>
      </footer>
    </div>
  );
}
