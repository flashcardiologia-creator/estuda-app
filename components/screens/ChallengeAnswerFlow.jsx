"use client";

import { useEffect, useState } from "react";
import { ChevronLeft, ChevronRight } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { PrimaryButton } from "@/components/ui/Primitives";
import { QuestionCard } from "@/components/screens/QuestionCard";
import { fetchChallengeQuestions, fetchMyChallengeAnswers, recordChallengeAnswer } from "@/lib/data/challenges";
import { fetchOptionsForQuestions, fetchOptionsWithAnswerKey } from "@/lib/data/questions";

export function ChallengeAnswerFlow({ supabase, userId, challenge, onFinish, onCancel, fontSize }) {
  const t = useT();
  const filters = { fontSize: fontSize || "md", modoProva: false, mostrarAntigas: false };
  const [loading, setLoading] = useState(true);
  const [questions, setQuestions] = useState([]);
  const [optionsByQuestion, setOptionsByQuestion] = useState({});
  const [answeredMap, setAnsweredMap] = useState({});
  const [idx, setIdx] = useState(0);
  const [selected, setSelected] = useState(null);
  const [revealed, setRevealed] = useState(null);
  const [responding, setResponding] = useState(false);
  const [struck, setStruck] = useState([]);

  useEffect(() => {
    let cancelled = false;
    (async () => {
      const [qs, myAnswers] = await Promise.all([
        fetchChallengeQuestions(supabase, challenge.id),
        fetchMyChallengeAnswers(supabase, challenge.id, userId),
      ]);
      const options = await fetchOptionsForQuestions(supabase, qs.map((q) => q.id));
      // Pra questões já respondidas ao retomar o desafio, precisamos do
      // gabarito (só dessas, nunca das que ainda não foram respondidas) pra
      // exibir certo/errado corretamente ao reabrir.
      const answeredQuestionIds = myAnswers.map((a) => a.question_id);
      const answerKeyOptions = answeredQuestionIds.length
        ? await fetchOptionsWithAnswerKey(supabase, answeredQuestionIds)
        : {};
      if (cancelled) return;
      const answered = Object.fromEntries(
        myAnswers.map((a) => {
          const correctOption = answerKeyOptions[a.question_id]?.find((o) => o.correta)?.letra || null;
          return [a.question_id, { question_id: a.question_id, selected_option: a.selected_option, correct: a.correct, correct_option: correctOption }];
        })
      );
      setQuestions(qs);
      setOptionsByQuestion(options);
      setAnsweredMap(answered);
      setIdx(Math.min(myAnswers.length, qs.length - 1));
      setLoading(false);
    })();
    return () => {
      cancelled = true;
    };
  }, [supabase, challenge.id, userId]);

  useEffect(() => {
    setStruck([]);
  }, [idx]);

  if (loading) return null;

  const total = questions.length;
  const q = questions[idx];
  const options = optionsByQuestion[q.id] || [];
  const isLast = idx === total - 1;
  const already = answeredMap[q.id];

  const responder = async () => {
    setResponding(true);
    try {
      const result = await recordChallengeAnswer(supabase, challenge.id, q.id, selected);
      setAnsweredMap((m) => ({
        ...m,
        [q.id]: { question_id: q.id, selected_option: selected, correct: result.correct, correct_option: result.correct_option },
      }));
      setRevealed(result);
    } finally {
      setResponding(false);
    }
  };

  const avancar = () => {
    if (isLast) {
      onFinish();
      return;
    }
    setIdx((i) => i + 1);
    setSelected(null);
    setRevealed(null);
  };

  const toggleStruck = (letra) => {
    setStruck((prev) => {
      const next = prev.includes(letra) ? prev.filter((l) => l !== letra) : [...prev, letra];
      if (!prev.includes(letra) && selected === letra) setSelected(null);
      return next;
    });
  };

  const effectiveRevealed = revealed || already || null;
  const effectiveSelected = selected || already?.selected_option || null;

  return (
    <div style={{ maxWidth: 620, margin: "0 auto", paddingBottom: 80 }}>
      <div style={{ display: "flex", alignItems: "center", justifyContent: "space-between", padding: "18px 22px 0" }}>
        <button
          onClick={onCancel}
          style={{
            display: "flex",
            alignItems: "center",
            gap: 4,
            background: "transparent",
            border: `1px solid ${t.border}`,
            borderRadius: 12,
            padding: "8px 14px",
            cursor: "pointer",
            color: t.text,
            fontSize: 13.5,
            fontWeight: 600,
          }}
        >
          <ChevronLeft size={16} /> Voltar
        </button>
        <span style={{ fontSize: 15, fontWeight: 700, color: t.text }}>
          Desafio · {idx + 1} de {total}
        </span>
      </div>
      <div style={{ padding: 22 }}>
        <QuestionCard
          q={q}
          options={options}
          filters={filters}
          selected={effectiveSelected}
          onSelect={setSelected}
          answered={!!effectiveRevealed}
          answerResult={effectiveRevealed}
          onResponder={responder}
          responding={responding}
          struckLetras={struck}
          onToggleStruck={toggleStruck}
        />

        {effectiveRevealed && (
          <div style={{ marginTop: 22 }}>
            <PrimaryButton full onClick={avancar}>
              {isLast ? (
                "Finalizar Desafio"
              ) : (
                <>
                  Próxima
                  <ChevronRight size={16} style={{ marginLeft: 4 }} />
                </>
              )}
            </PrimaryButton>
          </div>
        )}
      </div>
    </div>
  );
}
