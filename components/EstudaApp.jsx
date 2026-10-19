"use client";

import { useCallback, useEffect, useMemo, useRef, useState } from "react";
import { useRouter } from "next/navigation";
import { createClient } from "@/lib/supabase/client";
import { useT } from "@/components/theme/ThemeProvider";
import { Header } from "@/components/Header";
import { HomeScreen } from "@/components/screens/HomeScreen";
import { AccountScreen } from "@/components/screens/AccountScreen";
import { PushPrompt } from "@/components/screens/PushPrompt";
import { markPushPromptSeen, pushPromptSeen, shouldOfferPush } from "@/lib/push";
import { QuestionsFilterScreen } from "@/components/screens/QuestionsFilterScreen";
import { QuestionsSessionScreen } from "@/components/screens/QuestionsSessionScreen";
import { QuestionsResultsScreen } from "@/components/screens/QuestionsResultsScreen";
import { FlashcardsSelectScreen } from "@/components/screens/FlashcardsSelectScreen";
import { FlashcardsSessionScreen } from "@/components/screens/FlashcardsSessionScreen";
import { DailyMissionScreen, DailyDoneScreen } from "@/components/screens/DailyMissionScreen";
import { ChallengesScreen } from "@/components/screens/ChallengesScreen";
import { RankingScreen } from "@/components/screens/RankingScreen";
import { StatsScreen } from "@/components/screens/StatsScreen";
import { PaywallScreen } from "@/components/screens/PaywallScreen";
import { AdminStatsScreen } from "@/components/screens/AdminStatsScreen";
import { CouponOffer } from "@/components/screens/CouponOffer";
import { signOutAndLeave } from "@/lib/signOut";
import { fetchCouponOffer } from "@/lib/data/coupons";
import { PaymentReturn } from "@/components/screens/PaymentReturn";
import { ExpiryNotice } from "@/components/screens/ExpiryNotice";
import {
  ADMIN_DASHBOARD_EMAILS,
  EXPIRY_NOTICE_DAYS,
  FREE_CHALLENGES_PER_DAY,
  FREE_CHALLENGE_QUESTIONS,
  LOCKED_SCREENS,
  PAID_CHALLENGES_PER_DAY,
  PAID_CHALLENGE_QUESTIONS,
  calendarDaysLeft,
} from "@/lib/access";

import {
  fetchProfile,
  updateDisplayName,
  updateStatsVisibility,
  updateRankingVisibility,
  updateQuestionFontSize,
  updateFlashcardFontSize,
  resetStreak,
  fetchStats,
} from "@/lib/data/profile";
import { withRetry, withTimeout } from "@/lib/data/chunk";
import {
  fetchAllQuestions,
  fetchQuestionTexts,
  applyQuestionFilters,
  deriveFilterOptions,
  fetchOptionsForQuestions,
  fetchOptionsWithAnswerKey,
  fetchAttemptHistory,
  recordAnswer,
  fetchFavoriteIds,
  setFavorite,
} from "@/lib/data/questions";
import { fetchFlashcardCounts, fetchFlashcardsByTheme, fetchAllFlashcards, recordFlashcardView, sortLesson } from "@/lib/data/flashcards";
import {
  countAnswered,
  createQuestionSession,
  deleteQuestionSession,
  fetchQuestionSessionFull,
  fetchQuestionSessions,
  packProgress,
  saveQuestionSession,
  unpackProgress,
} from "@/lib/data/sessions";
import { createCustomFlashcard, deleteCustomForever, fetchTrash, restoreFromTrash, sendToTrash, setFlashcardFavorite } from "@/lib/data/personal";
import { DROPDOWN_ALL } from "@/components/ui/Primitives";
import { fetchDailyMissionItems, completeDailyMission, expireDailyMission } from "@/lib/data/mission";
import {
  fetchFriends,
  addFriendByName,
  addFriendById,
  fetchIncomingFriendRequests,
  respondToFriendRequest,
} from "@/lib/data/friends";
import { fetchChallenges } from "@/lib/data/challenges";
import { SwipeBack } from "@/components/SwipeBack";
import { shuffle, todayStr, msUntilNextDayBoundary, MISSION_GRACE_MS, effectiveStreak } from "@/lib/util";

const HIDDEN_HEADER_SCREENS = [
  "questions-session",
  "flashcards-session",
  "daily-session",
  "questions-results",
  "account",
  "stats",
  "ranking",
  "questions-filters",
  "flashcards-select",
  "challenges",
  "plans",
];

const nowMs = () => Date.now();

const DEFAULT_FILTERS = {
  temas: [],
  anos: [],
  instituicoes: [],
  favoritasOnly: false,
  modoProva: false,
  mostrarAntigas: false,
  cronometro: false,
  minutos: 20,
  quantidade: "Todas",
  fontSize: "md",
};

export function EstudaApp({ userId, userEmail, access, paymentReturn, openPlans = false }) {
  const t = useT();
  const router = useRouter();
  const [supabase] = useState(() => {
    const client = createClient();
    // Sem assinatura ativa o app não lê as tabelas de questões/flashcards direto (ver lib/data/content.js).
    client.contentOpen = access.active;
    return client;
  });

  // /?prolongar=1 (link do e-mail e da notificação de vencimento) abre direto a tela de assinatura.
  const [screen, setScreen] = useState(openPlans ? "plans" : "home");
  const [loading, setLoading] = useState(true);
  const [loadError, setLoadError] = useState(false);
  const [loadAttempt, setLoadAttempt] = useState(0);
  const [pushPrompt, setPushPrompt] = useState(null);
  const [profile, setProfile] = useState(null);
  const [allQuestions, setAllQuestions] = useState([]);
  // Textos (enunciado/comentários) já baixados, por id; e a promessa do download
  // em segundo plano, para a sessão de questões esperar por ele se precisar.
  const textsRef = useRef({});
  const textsBgRef = useRef(null);
  const [favorites, setFavorites] = useState([]);
  const [friends, setFriends] = useState([]);
  const [incomingRequests, setIncomingRequests] = useState([]);
  const [stats, setStats] = useState({ answered: 0, accuracy: 0 });
  const [themeCounts, setThemeCounts] = useState({});
  const [favoriteCounts, setFavoriteCounts] = useState({});
  const [flashFavorites, setFlashFavorites] = useState(() => new Set());
  const [challenges, setChallenges] = useState([]);
  const [challengeAnswering, setChallengeAnswering] = useState(false);
  const [accountFocus, setAccountFocus] = useState(null);

  const [filters, setFilters] = useState(DEFAULT_FILTERS);
  const [flashcardFontSize, setFlashcardFontSize] = useState("md");

  const [session, setSession] = useState(null);
  const [sessionQuestionsById, setSessionQuestionsById] = useState({});
  const [sessionOptionsByQuestion, setSessionOptionsByQuestion] = useState({});
  const [savedSession, setSavedSession] = useState(null);
  // Sessões antigas (últimas 10, guardadas no banco) e o registro da sessão em andamento.
  const [pastSessions, setPastSessions] = useState([]);
  const sessionRecordRef = useRef(null);
  // Para onde o botão Voltar das Estatísticas leva (Minha Conta, ou Questões quando vem de "Desempenho").
  const [statsReturn, setStatsReturn] = useState("account");

  const [flashSession, setFlashSession] = useState(null);

  const [dailyItems, setDailyItems] = useState(null);
  const [dailyOptionsByQuestion, setDailyOptionsByQuestion] = useState({});
  const [dailySession, setDailySession] = useState(null);
  const dailyPrefetchRef = useRef(null);
  // Dia (virada à meia-noite de Brasília) a que pertence a missão guardada em
  // memória — serve pra descartá-la se o dia virar com a missão fechada.
  const dailyDateRef = useRef(null);

  const clearDaily = useCallback(() => {
    setDailySession(null);
    setDailyItems(null);
    setDailyOptionsByQuestion({});
    dailyPrefetchRef.current = null;
    dailyDateRef.current = null;
  }, []);

  const missionDone = profile ? profile.last_mission_date === todayStr() : false;

  // Monta a missão de hoje (questões + flashcards) assim que o app carrega, em segundo
  // plano — assim, ao clicar em "Missão Diária" ela já está pronta na hora. O mesmo
  // conjunto é reaproveitado se o usuário sair e voltar, sem sortear de novo.
  const prefetchDaily = useCallback(() => {
    if (dailyPrefetchRef.current) return dailyPrefetchRef.current;
    dailyDateRef.current = todayStr();
    const p = fetchDailyMissionItems(supabase, userId).then(({ questions, flashcards, options }) => {
      const items = [
        ...questions.map((q) => ({ type: "question", data: q })),
        ...flashcards.map((f) => ({ type: "flashcard", data: f })),
      ];
      setDailyItems(items);
      setDailyOptionsByQuestion(options);
      return items;
    });
    dailyPrefetchRef.current = p;
    return p;
  }, [supabase, userId]);

  useEffect(() => {
    if (profile && !missionDone) {
      prefetchDaily();
    }
  }, [profile, missionDone, prefetchDaily]);

  // Baixa os textos das questões `ids` que ainda não estão na memória e os
  // mescla em `allQuestions`. Em lotes pequenos, com nova tentativa.
  const hydrateTexts = useCallback(
    async (ids) => {
      const missing = ids.filter((id) => !textsRef.current[id]);
      if (!missing.length) return;
      const got = await fetchQuestionTexts(supabase, missing);
      Object.assign(textsRef.current, got);
      setAllQuestions((prev) => prev.map((q) => (got[q.id] ? { ...q, ...got[q.id] } : q)));
    },
    [supabase]
  );

  // Se o carregamento inicial falhar de vez, recarrega a página sozinho uma
  // vez (equivale a "fechar e abrir de novo", que resolvia) e, se persistir,
  // mostra uma tela com botão em vez de ficar eternamente em "Carregando…".
  const recoverFromLoadFailure = useCallback(() => {
    try {
      const last = Number(sessionStorage.getItem("estuda-auto-reload") || 0);
      if (Date.now() - last > 60000) {
        sessionStorage.setItem("estuda-auto-reload", String(Date.now()));
        window.location.reload();
        return;
      }
    } catch {
      // sessionStorage indisponível: cai direto na tela de erro
    }
    setLoadError(true);
  }, []);

  useEffect(() => {
    let cancelled = false;
    (async () => {
      let profileData, questions, favIds, friendsData;
      try {
        setLoadError(false);
        // Favoritas e amigos não são essenciais para abrir o app: se falharem, seguem vazios.
        [profileData, questions, favIds, friendsData] = await withRetry(
          () =>
            withTimeout(
              Promise.all([
                fetchProfile(supabase, userId),
                fetchAllQuestions(supabase),
                fetchFavoriteIds(supabase, userId).catch(() => []),
                fetchFriends(supabase).catch(() => []),
              ]),
              15000,
              "carregamento inicial"
            ),
          2
        );
      } catch {
        if (!cancelled) recoverFromLoadFailure();
        return;
      }
      if (cancelled) return;
      // Sem assinatura a sequência fica congelada: não soma nem zera. Ao assinar de novo, segue de onde parou.
      const correctedStreak = access.active ? effectiveStreak(profileData.streak, profileData.last_mission_date) : profileData.streak;
      if (correctedStreak !== profileData.streak) {
        profileData = { ...profileData, streak: correctedStreak };
        resetStreak(supabase, userId).catch(() => {});
      }
      setProfile(profileData);
      setFilters((f) => ({
        ...f,
        fontSize: profileData.question_font_size || "md",
        anos: deriveFilterOptions(questions).anos,
        instituicoes: deriveFilterOptions(questions).instituicoes,
      }));
      setFlashcardFontSize(profileData.flashcard_font_size || "md");
      setAllQuestions(questions);
      setFavorites(favIds);
      setFriends(friendsData);
      setLoading(false);
      // Não bloqueia o app: o balão de pendentes só precisa aparecer assim que chegar.
      fetchChallenges(supabase, userId)
        .then((data) => {
          if (!cancelled) setChallenges(data);
        })
        .catch(() => {});
      // Os textos longos das questões chegam em segundo plano, em lotes de 300. Sem assinatura não há
      // o que baixar: a missão e os desafios buscam só as questões deles.
      const ids = supabase.contentOpen === false ? [] : questions.map((q) => q.id);
      textsBgRef.current = (async () => {
        for (let i = 0; i < ids.length && !cancelled; i += 300) {
          try {
            await hydrateTexts(ids.slice(i, i + 300));
          } catch {
            // se um lote falhar, startQuestions baixa o que faltar na hora de iniciar
          }
        }
      })();
    })();
    return () => {
      cancelled = true;
    };
  }, [supabase, userId, loadAttempt, hydrateTexts, recoverFromLoadFailure, access.active]);

  // Toda tela nova (e cada questão/flashcard seguinte) abre do topo, e não na altura em que a anterior estava.
  const questionIndex = session?.index;
  const flashIndex = flashSession?.index;
  const dailyIndex = dailySession?.index;
  useEffect(() => {
    window.scrollTo({ top: 0, left: 0, behavior: "instant" });
  }, [screen, questionIndex, flashIndex, dailyIndex]);

  // Convite para ativar o lembrete da missão diária: só depois de concluir a primeira missão diária (não
  // ao abrir o app pela primeira vez). Aparece uma vez por pessoa e aparelho, e só se o lembrete ainda não
  // estiver ativado (nem bloqueado) neste aparelho.
  const offerPush = useCallback(
    async (kind) => {
      if (pushPromptSeen(userId, kind) || !(await shouldOfferPush())) return;
      markPushPromptSeen(userId, kind);
      setPushPrompt(kind);
    },
    [userId]
  );
  const appReady = !loading && !!profile;

  // Cupom de boas-vindas: conta criada depois da data de corte, que ainda não usou nem dispensou o cupom,
  // vê uma janela perguntando se quer ativá-lo (o banco decide: supabase/cupom_boas_vindas.sql).
  const [couponOffer, setCouponOffer] = useState(null);
  useEffect(() => {
    if (!appReady) return;
    let cancelled = false;
    fetchCouponOffer(supabase).then((offer) => {
      if (!cancelled && offer) setCouponOffer(offer);
    });
    return () => {
      cancelled = true;
    };
  }, [appReady, supabase, userId]);

  // Aviso de vencimento: ao abrir o app, nos dias 7, 3, 1 e 0 antes de a assinatura acabar, uma vez por dia.
  const [expiryDays, setExpiryDays] = useState(null);
  const expiresAt = access.active ? access.expiresAt : null;
  useEffect(() => {
    if (!appReady || !expiresAt || openPlans) return;
    let cancelled = false;
    (async () => {
      const days = calendarDaysLeft(expiresAt);
      if (!EXPIRY_NOTICE_DAYS.includes(days) || cancelled) return;
      const key = `flashcardio_expiry_notice_${userId}_${todayStr()}`;
      try {
        if (localStorage.getItem(key)) return;
      } catch {
        // sem armazenamento: mostra mesmo assim
      }
      setExpiryDays(days);
    })();
    return () => {
      cancelled = true;
    };
  }, [appReady, expiresAt, userId, openPlans]);
  const closeExpiryNotice = (goToPlans) => {
    try {
      localStorage.setItem(`flashcardio_expiry_notice_${userId}_${todayStr()}`, "1");
    } catch {
      // sem armazenamento: o aviso pode voltar na próxima abertura
    }
    setExpiryDays(null);
    if (goToPlans) setScreen("plans");
  };

  useEffect(() => {
    if (screen === "account") {
      fetchStats(supabase, userId).then(setStats);
      fetchFriends(supabase).then(setFriends);
      fetchIncomingFriendRequests(supabase).then(setIncomingRequests);
    }
    if (screen === "challenges") {
      fetchChallenges(supabase, userId).then(setChallenges);
      fetchFriends(supabase).then(setFriends);
    }
    if (screen === "questions-filters") {
      fetchQuestionSessions(supabase, userId).then(setPastSessions);
    }
    if (screen === "flashcards-select") {
      fetchFlashcardCounts(supabase, { trash: true, custom: true }).then(({ themeCounts, favoriteCounts, favorites }) => {
        setThemeCounts(themeCounts);
        setFavoriteCounts(favoriteCounts);
        setFlashFavorites(favorites);
      });
    }
  }, [screen, supabase, userId]);

  // Dificulta a cópia do conteúdo das questões/flashcards (proteção básica,
  // não é à prova de usuários avançados). Campos de formulário continuam
  // funcionando normalmente.
  useEffect(() => {
    const isFormField = (el) => el?.closest?.("input, textarea, [contenteditable='true']");
    const blockCopy = (e) => {
      if (isFormField(e.target)) return;
      e.preventDefault();
    };
    const blockContextMenu = (e) => {
      if (isFormField(e.target)) return;
      e.preventDefault();
    };
    document.addEventListener("copy", blockCopy);
    document.addEventListener("cut", blockCopy);
    document.addEventListener("contextmenu", blockContextMenu);
    return () => {
      document.removeEventListener("copy", blockCopy);
      document.removeEventListener("cut", blockCopy);
      document.removeEventListener("contextmenu", blockContextMenu);
    };
  }, []);

  const refreshChallenges = useCallback(async () => {
    const data = await fetchChallenges(supabase, userId);
    setChallenges(data);
  }, [supabase, userId]);

  const refreshFriends = useCallback(async () => {
    const [friendsData, requestsData] = await Promise.all([
      fetchFriends(supabase),
      fetchIncomingFriendRequests(supabase),
    ]);
    setFriends(friendsData);
    setIncomingRequests(requestsData);
  }, [supabase]);

  const toggleFav = useCallback(
    (qid) => {
      setFavorites((f) => {
        const isFav = f.includes(qid);
        setFavorite(supabase, userId, qid, !isFav).catch(() => {});
        return isFav ? f.filter((x) => x !== qid) : [...f, qid];
      });
    },
    [supabase, userId]
  );

  /* ---- Questões ---- */
  const startQuestions = async () => {
    // Sorteia primeiro e só depois corta na quantidade escolhida (5, 10, ... ou "Todas").
    const sorted = shuffle(applyQuestionFilters(allQuestions, filters, favorites));
    const filtered = Number.isInteger(filters.quantidade) ? sorted.slice(0, filters.quantidade) : sorted;
    // Garante os textos (enunciado/comentários) das questões escolhidas: espera o
    // download em segundo plano e baixa na hora só o que ainda faltar.
    if (textsBgRef.current) await textsBgRef.current;
    await hydrateTexts(filtered.map((q) => q.id));
    const pool = filtered.map((q) => (textsRef.current[q.id] ? { ...q, ...textsRef.current[q.id] } : q));
    const ids = pool.map((q) => q.id);
    const [options, hist] = await Promise.all([
      fetchOptionsForQuestions(supabase, ids),
      fetchAttemptHistory(supabase, userId, ids),
    ]);

    let initialSelected = {};
    let initialAnswers = {};
    let initialPrefilled = {};
    if (filters.mostrarAntigas) {
      const attemptedIds = ids.filter((id) => hist[id]?.length);
      if (attemptedIds.length) {
        const answerKeyOptions = await fetchOptionsWithAnswerKey(supabase, attemptedIds);
        for (const id of attemptedIds) {
          const correctOption = answerKeyOptions[id]?.find((o) => o.correta)?.letra;
          const lastAttempt = hist[id][hist[id].length - 1];
          if (correctOption && lastAttempt) {
            initialSelected[id] = lastAttempt.selected;
            initialAnswers[id] = { selected: lastAttempt.selected, correct: lastAttempt.correct, correct_option: correctOption };
            initialPrefilled[id] = true;
          }
        }
      }
    }

    const newSession = {
      ids,
      index: 0,
      selected: initialSelected,
      answers: initialAnswers,
      prefilled: initialPrefilled,
      struck: {},
      startedAt: filters.cronometro ? nowMs() : null,
      durationMs: filters.cronometro ? filters.minutos * 60 * 1000 : null,
    };
    setSessionQuestionsById(Object.fromEntries(pool.map((q) => [q.id, q])));
    setSessionOptionsByQuestion(options);
    setSession(newSession);
    startSessionRecord(ids, newSession);
    setScreen("questions-session");
  };

  // Cria o registro da sessão no histórico (as 10 últimas ficam guardadas). Se não
  // der para guardar (ex.: SQL ainda não rodado), a sessão segue normal, só sem histórico.
  const startSessionRecord = (ids, newSession) => {
    sessionRecordRef.current = null;
    createQuestionSession(supabase, userId, {
      filters,
      ids,
      progress: packProgress(newSession),
      answered: countAnswered(newSession),
    }).then((id) => {
      sessionRecordRef.current = id;
    });
  };

  const persistSession = useCallback(
    (s, finished = false) => {
      const id = sessionRecordRef.current;
      if (!id || !s) return;
      saveQuestionSession(supabase, id, { progress: packProgress(s), answered: countAnswered(s), finished });
    },
    [supabase]
  );

  // Salva o andamento da sessão aos poucos (depois de uma pausa nas ações).
  useEffect(() => {
    if (screen !== "questions-session" || !session) return;
    const timer = setTimeout(() => persistSession(session), 1200);
    return () => clearTimeout(timer);
  }, [screen, session, persistSession]);

  // Reabre uma sessão do histórico e continua de onde parou.
  const openStoredSession = async (row) => {
    const full = await fetchQuestionSessionFull(supabase, row.id);
    const known = new Set(allQuestions.map((q) => q.id));
    const ids = (full.question_ids || []).filter((id) => known.has(id));
    if (!ids.length) throw new Error("As questões dessa sessão não estão mais disponíveis.");
    if (textsBgRef.current) await textsBgRef.current;
    await hydrateTexts(ids);
    const byId = Object.fromEntries(allQuestions.map((q) => [q.id, q]));
    const pool = ids.map((id) => (textsRef.current[id] ? { ...byId[id], ...textsRef.current[id] } : byId[id]));
    const options = await fetchOptionsForQuestions(supabase, ids);
    const saved = full.filters || {};
    setFilters((f) => ({ ...f, modoProva: !!saved.modoProva, mostrarAntigas: !!saved.mostrarAntigas }));
    const restored = unpackProgress(full.progress, ids);
    setSessionQuestionsById(Object.fromEntries(pool.map((q) => [q.id, q])));
    setSessionOptionsByQuestion(options);
    setSession({
      ids,
      index: restored.index,
      selected: restored.selected,
      answers: restored.answers,
      prefilled: restored.prefilled,
      struck: restored.struck,
      startedAt: null,
      durationMs: null,
    });
    sessionRecordRef.current = full.id;
    setScreen("questions-session");
  };

  const deleteSession = async (row) => {
    await deleteQuestionSession(supabase, row.id);
    if (sessionRecordRef.current === row.id) sessionRecordRef.current = null;
    setPastSessions((list) => list.filter((s) => s.id !== row.id));
  };

  const continueQuestions = () => {
    if (!savedSession) return;
    sessionRecordRef.current = savedSession.recordId ?? null;
    setSession(savedSession.session);
    setSessionQuestionsById(savedSession.questionsById);
    setSessionOptionsByQuestion(savedSession.optionsByQuestion);
    setScreen("questions-session");
  };

  const backFromSession = () => {
    persistSession(session);
    setSavedSession({
      session,
      questionsById: sessionQuestionsById,
      optionsByQuestion: sessionOptionsByQuestion,
      recordId: sessionRecordRef.current,
    });
    setSession(null);
    setScreen("questions-filters");
  };

  const answerQuestion = async (qid, selected) => {
    const result = await recordAnswer(supabase, qid, selected, false);
    return { selected, ...result };
  };

  const finishQuestions = async () => {
    if (filters.modoProva) {
      const withKey = await fetchOptionsWithAnswerKey(supabase, session.ids);
      setSessionOptionsByQuestion(withKey);
    }
    persistSession(session, true);
    setSavedSession(null);
    setScreen("questions-results");
  };

  /* ---- Flashcards ---- */
  const startFlashcards = async (tema, qtd, aleatorio, tamanho, favoritasOnly = false) => {
    // Personalização: tira o que a pessoa mandou para a lixeira e inclui os flashcards que ela criou.
    const personal = { trash: true, custom: true };
    let pool =
      tema === DROPDOWN_ALL
        ? await fetchAllFlashcards(supabase, personal)
        : await fetchFlashcardsByTheme(supabase, tema, personal);
    if (favoritasOnly) pool = pool.filter((f) => flashFavorites.has(f.id));
    // Com "Todos" os temas e quantidade limitada, embaralha sempre (senão ficaria
    // presa aos primeiros temas). Nos demais casos, sem Aleatorizar, segue a ordem
    // de aula: por tema, na sequência didática (ordem).
    if (aleatorio || (tema === DROPDOWN_ALL && qtd !== "Todos")) pool = shuffle(pool);
    else pool = sortLesson(pool);
    if (qtd !== "Todos") pool = pool.slice(0, qtd);
    setFlashSession({
      ids: pool.map((f) => f.id),
      index: 0,
      flipped: {},
      viewed: {},
      cardsById: Object.fromEntries(pool.map((f) => [f.id, f])),
      fontSize: tamanho || "md",
    });
    setScreen("flashcards-session");
  };

  const finishFlashcards = () => {
    setFlashSession(null);
    setScreen("home");
  };

  // Recarrega as contagens por tema/favoritos (depois de criar, mandar para a lixeira ou restaurar).
  const refreshFlashcardCounts = useCallback(async () => {
    const { themeCounts, favoriteCounts, favorites } = await fetchFlashcardCounts(supabase, { trash: true, custom: true });
    setThemeCounts(themeCounts);
    setFavoriteCounts(favoriteCounts);
    setFlashFavorites(favorites);
  }, [supabase]);

  // Estrela do flashcard (só da própria pessoa): atualiza na hora e desfaz se der erro.
  const toggleFlashcardFavorite = async (card) => {
    const next = !flashFavorites.has(card.id);
    const apply = (on) => {
      setFlashFavorites((s) => {
        const copy = new Set(s);
        if (on) copy.add(card.id);
        else copy.delete(card.id);
        return copy;
      });
      setFavoriteCounts((c) => ({ ...c, [card.tema]: Math.max(0, (c[card.tema] || 0) + (on ? 1 : -1)) }));
    };
    apply(next);
    try {
      await setFlashcardFavorite(supabase, userId, card.id, next);
    } catch {
      apply(!next);
    }
  };

  const createCustomCard = async (data) => {
    const card = await createCustomFlashcard(supabase, userId, data);
    await refreshFlashcardCounts();
    return card;
  };

  const restoreCard = async (card) => {
    await restoreFromTrash(supabase, userId, card.id);
    await refreshFlashcardCounts();
  };

  const deleteCustomCardForever = async (card) => {
    await deleteCustomForever(supabase, userId, card.id);
    await refreshFlashcardCounts();
  };

  // Manda o flashcard atual para a lixeira (só dessa pessoa) e o tira da sessão em andamento.
  const trashCurrentFlashcard = async (card) => {
    await sendToTrash(supabase, userId, card);
    const remaining = flashSession.ids.filter((id) => id !== card.id);
    if (remaining.length === 0) {
      finishFlashcards();
      return;
    }
    setFlashSession((s) => {
      const ids = s.ids.filter((id) => id !== card.id);
      const removedAt = s.ids.indexOf(card.id);
      const index = Math.min(removedAt < s.index ? s.index - 1 : s.index, ids.length - 1);
      const { [card.id]: _f, ...flipped } = s.flipped;
      const { [card.id]: _c, ...cardsById } = s.cardsById;
      return { ...s, ids, index, flipped, cardsById };
    });
  };

  const viewFlashcard = useCallback(
    (flashcardId) => {
      recordFlashcardView(supabase, userId, flashcardId).catch(() => {});
    },
    [supabase, userId]
  );

  /* ---- Missão diária ---- */
  const startDaily = async () => {
    if (missionDone) {
      setScreen("daily-done");
      return;
    }
    // O dia virou com a missão fechada (fora da tela da missão): os "acréscimos"
    // só valem pra quem continua com ela aberta. Descarta a missão e a sessão
    // de ontem — vale a missão do dia novo.
    const stale = dailyDateRef.current !== null && dailyDateRef.current !== todayStr();
    if (stale) clearDaily();
    // Reaproveita o que já foi pré-carregado em segundo plano; só espera se o
    // usuário clicou antes desse carregamento terminar.
    if (stale || !dailyItems) {
      await prefetchDaily();
    }
    setDailySession((s) => s || { index: 0, selected: {}, answers: {}, flipped: {}, viewed: {} });
    setScreen("daily-session");
  };

  const dailyAnswer = async (qid, selected) => {
    const result = await recordAnswer(supabase, qid, selected, true);
    return { selected, ...result };
  };

  const finishDaily = async () => {
    const { streak, last_mission_date } = await completeDailyMission(supabase);
    setProfile((p) => ({ ...p, streak: access.active ? streak : p.streak, last_mission_date }));
    // Limpa a sessão concluída — se não, um eventual desalinhamento no cálculo
    // de "hoje" (ex.: logo após mudar a virada do dia) deixaria a próxima
    // entrada na Missão Diária caindo de volta no último item já respondido.
    clearDaily();
    setScreen("daily-done");
    offerPush("mission");
  };

  // Se a virada do dia acontece com a pessoa ainda dentro da missão (sem ter
  // concluído), fecha a missão, zera a streak e volta pra tela inicial —
  // perder o prazo quebra a sequência.
  const expireDaily = useCallback(async () => {
    try {
      const { streak } = await expireDailyMission(supabase);
      setProfile((p) => ({ ...p, streak: access.active ? streak : p.streak }));
    } catch {
      // melhor deixar a streak como está do que travar o usuário na missão vencida
    }
    clearDaily();
    setScreen("home");
  }, [supabase, clearDaily, access.active]);

  useEffect(() => {
    if (screen !== "daily-session") return;
    // Dá alguns minutos de tolerância após a virada do dia: se a pessoa já
    // estava respondendo a missão, ela pode terminar dentro desse prazo
    // sem perder a sequência. Só expira se passar desse tempo.
    const timer = setTimeout(expireDaily, msUntilNextDayBoundary() + MISSION_GRACE_MS);
    return () => clearTimeout(timer);
  }, [screen, expireDaily]);

  /* ---- Conta ---- */
  const saveDisplayName = async (name) => {
    await updateDisplayName(supabase, userId, name);
    setProfile((p) => ({ ...p, name }));
  };

  const saveStatsVisibility = async (visible) => {
    await updateStatsVisibility(supabase, userId, visible);
    setProfile((p) => ({ ...p, stats_visible_to_friends: visible }));
  };

  const saveRankingVisibility = async (visible) => {
    await updateRankingVisibility(supabase, userId, visible);
    setProfile((p) => ({ ...p, ranking_visible: visible }));
  };

  const saveQuestionFontSize = (size) => {
    setFilters((f) => ({ ...f, fontSize: size }));
    updateQuestionFontSize(supabase, userId, size).catch(() => {});
  };

  const saveFlashcardFontSize = (size) => {
    setFlashcardFontSize(size);
    updateFlashcardFontSize(supabase, userId, size).catch(() => {});
  };

  const addFriend = async (target) => {
    // target: texto digitado (nome exato ou código) ou { id, name } de uma sugestão
    const result = typeof target === "string" ? await addFriendByName(supabase, target) : await addFriendById(supabase, target);
    if (result.status === "accepted") {
      setFriends((f) => [...f, result.friend]);
    }
    return result;
  };

  const respondRequest = async (requesterId, accept) => {
    await respondToFriendRequest(supabase, requesterId, accept);
    await refreshFriends();
  };

  const goToAccountFriends = () => {
    setAccountFocus("friends");
    setScreen("account");
  };

  const signOut = () => signOutAndLeave(supabase);

  const temas = useMemo(() => deriveFilterOptions(allQuestions).temas, [allQuestions]);

  if (loadError) {
    return (
      <div style={{ padding: 60, textAlign: "center", color: t.textMuted }}>
        <div style={{ marginBottom: 16 }}>Não foi possível carregar. Confira sua conexão e tente de novo.</div>
        <button
          type="button"
          onClick={() => {
            setLoading(true);
            setLoadAttempt((n) => n + 1);
          }}
          style={{ padding: "12px 22px", fontSize: 15, fontWeight: 600, borderRadius: 10, border: `1px solid ${t.textMuted}`, background: "transparent", color: t.text, cursor: "pointer" }}
        >
          Tentar novamente
        </button>
      </div>
    );
  }

  if (loading || !profile) {
    return (
      <div style={{ padding: 60, textAlign: "center", color: t.textMuted }}>Carregando…</div>
    );
  }

  // Sem assinatura ativa, Questões e Flashcards mostram a tela de assinatura no lugar.
  // A Missão diária e os Desafios têm as próprias telas e continuam livres.
  const paywalled = !access.active && LOCKED_SCREENS.includes(screen);
  const showHeader = !HIDDEN_HEADER_SCREENS.includes(screen) && !challengeAnswering;
  return (
    <div id="swipe-root">
      <SwipeBack rootId="swipe-root" />
      {pushPrompt && <PushPrompt supabase={supabase} userId={userId} onClose={() => setPushPrompt(null)} />}
      <PaymentReturn status={paymentReturn} active={access.active} expiresAt={access.expiresAt} />
      {screen === "home" && couponOffer && <CouponOffer supabase={supabase} offer={couponOffer} onClose={() => setCouponOffer(null)} />}
      {screen === "home" && expiryDays !== null && (
        <ExpiryNotice access={access} days={expiryDays} onExtend={() => closeExpiryNotice(true)} onLater={() => closeExpiryNotice(false)} />
      )}
      {showHeader && <Header streak={profile.streak} onNavigate={setScreen} missionDone={missionDone} />}

      {(paywalled || screen === "plans") && <PaywallScreen access={access} onBack={() => setScreen("home")} />}

      {screen === "home" && (
        <HomeScreen
          name={profile.name}
          locked={!access.active}
          onNavigate={setScreen}
          missionDone={missionDone}
          onOpenDaily={() => (missionDone ? setScreen("daily-done") : startDaily())}
          pendingChallengesCount={challenges.filter((c) => c.status === "pending" && c.myAnswered < c.qtd).length}
        />
      )}

      {screen === "account" && (
        <AccountScreen
          supabase={supabase}
          userId={userId}
          userEmail={userEmail}
          profile={profile}
          stats={stats}
          allQuestions={allQuestions}
          friends={friends}
          incomingRequests={incomingRequests}
          access={access}
          initialFocus={accountFocus}
          onFocusConsumed={() => setAccountFocus(null)}
          onNavigate={(s) => {
            if (s === "stats") setStatsReturn("account");
            setScreen(s);
          }}
          onSaveName={saveDisplayName}
          onSaveStatsVisibility={saveStatsVisibility}
          onSaveRankingVisibility={saveRankingVisibility}
          onAddFriend={addFriend}
          onRespondRequest={respondRequest}
          onRefreshFriends={refreshFriends}
          onSignOut={signOut}
        />
      )}

      {screen === "ranking" && <RankingScreen supabase={supabase} userId={userId} onNavigate={setScreen} friends={friends} />}

      {screen === "admin-stats" && ADMIN_DASHBOARD_EMAILS.includes((userEmail || "").toLowerCase()) && (
        <AdminStatsScreen supabase={supabase} onBack={() => setScreen("account")} />
      )}

      {screen === "stats" && (
        <StatsScreen
          supabase={supabase}
          userId={userId}
          allQuestions={allQuestions}
          challenges={challenges}
          onNavigate={(s) => {
            // O botão Voltar das Estatísticas volta para onde a pessoa veio (Minha Conta ou Questões).
            const back = s === "account" ? statsReturn : s;
            setStatsReturn("account");
            setScreen(back);
          }}
        />
      )}

      {!paywalled && screen === "questions-filters" && (
        <QuestionsFilterScreen
          allQuestions={allQuestions}
          favorites={favorites}
          filters={filters}
          setFilters={setFilters}
          onSetFontSize={saveQuestionFontSize}
          onStart={startQuestions}
          onContinue={continueQuestions}
          hasSavedSession={!!savedSession}
          pastSessions={pastSessions}
          onResumeSession={openStoredSession}
          onDeleteSession={deleteSession}
          onNavigate={setScreen}
        />
      )}

      {!paywalled && screen === "questions-session" && session && (
        <QuestionsSessionScreen
          supabase={supabase}
          userId={userId}
          session={session}
          setSession={setSession}
          questionsById={sessionQuestionsById}
          optionsByQuestion={sessionOptionsByQuestion}
          filters={filters}
          favorites={favorites}
          onToggleFav={toggleFav}
          onAnswer={answerQuestion}
          onFinish={finishQuestions}
          onBack={backFromSession}
        />
      )}

      {!paywalled && screen === "questions-results" && session && (
        <QuestionsResultsScreen
          session={session}
          questionsById={sessionQuestionsById}
          optionsByQuestion={sessionOptionsByQuestion}
          filters={filters}
          onNavigate={(s) => {
            setSession(null);
            setScreen(s);
          }}
        />
      )}

      {!paywalled && screen === "flashcards-select" && (
        <FlashcardsSelectScreen
          themeCounts={themeCounts}
          favoriteCounts={favoriteCounts}
          tamanho={flashcardFontSize}
          onSetTamanho={saveFlashcardFontSize}
          onStart={startFlashcards}
          onNavigate={setScreen}
          hasSavedFlashSession={!!flashSession}
          onContinueFlashcards={() => setScreen("flashcards-session")}
          onCreateCustom={createCustomCard}
          onLoadTrash={() => fetchTrash(supabase, userId)}
          onRestore={restoreCard}
          onDeleteForever={deleteCustomCardForever}
        />
      )}

      {!paywalled && screen === "flashcards-session" && flashSession && (
        <FlashcardsSessionScreen
          supabase={supabase}
          userId={userId}
          session={flashSession}
          setSession={setFlashSession}
          onNavigate={setScreen}
          onFinish={finishFlashcards}
          onView={viewFlashcard}
          onTrash={trashCurrentFlashcard}
          favorites={flashFavorites}
          onToggleFavorite={toggleFlashcardFavorite}
          fontSize={flashcardFontSize}
        />
      )}

      {screen === "daily-session" && dailyItems && dailySession && (
        <DailyMissionScreen
          items={dailyItems}
          optionsByQuestion={dailyOptionsByQuestion}
          session={dailySession}
          setSession={setDailySession}
          onAnswer={dailyAnswer}
          onFinishDaily={finishDaily}
          onNavigate={setScreen}
          favorites={favorites}
          onToggleFav={toggleFav}
          onView={viewFlashcard}
          questionFontSize={filters.fontSize}
          flashcardFontSize={flashcardFontSize}
        />
      )}

      {screen === "daily-done" && (
        <DailyDoneScreen supabase={supabase} userId={userId} streak={profile.streak} friends={friends} onNavigate={setScreen} canChooseFormat={access.active} />
      )}

      {screen === "challenges" && (
        <ChallengesScreen
          supabase={supabase}
          userId={userId}
          friends={friends}
          challenges={challenges}
          temas={temas}
          onRefreshChallenges={refreshChallenges}
          onNavigate={setScreen}
          onGoToAccountFriends={goToAccountFriends}
          dailyLimit={access.active ? PAID_CHALLENGES_PER_DAY : FREE_CHALLENGES_PER_DAY}
          maxQuestions={access.active ? PAID_CHALLENGE_QUESTIONS : FREE_CHALLENGE_QUESTIONS}
          isFree={!access.active}
          onAnsweringChange={setChallengeAnswering}
          fontSize={filters.fontSize}
        />
      )}
    </div>
  );
}
