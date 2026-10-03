"use client";

import { useCallback, useEffect, useMemo, useRef, useState } from "react";
import { useRouter } from "next/navigation";
import { createClient } from "@/lib/supabase/client";
import { useT } from "@/components/theme/ThemeProvider";
import { Header } from "@/components/Header";
import { HomeScreen } from "@/components/screens/HomeScreen";
import { AccountScreen } from "@/components/screens/AccountScreen";
import { QuestionsFilterScreen } from "@/components/screens/QuestionsFilterScreen";
import { QuestionsSessionScreen } from "@/components/screens/QuestionsSessionScreen";
import { QuestionsResultsScreen } from "@/components/screens/QuestionsResultsScreen";
import { FlashcardsSelectScreen } from "@/components/screens/FlashcardsSelectScreen";
import { FlashcardsSessionScreen } from "@/components/screens/FlashcardsSessionScreen";
import { DailyMissionScreen, DailyDoneScreen } from "@/components/screens/DailyMissionScreen";
import { ChallengesScreen } from "@/components/screens/ChallengesScreen";
import { RankingScreen } from "@/components/screens/RankingScreen";
import { StatsScreen } from "@/components/screens/StatsScreen";

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
import {
  fetchAllQuestions,
  applyQuestionFilters,
  deriveFilterOptions,
  fetchOptionsForQuestions,
  fetchOptionsWithAnswerKey,
  fetchAttemptHistory,
  recordAnswer,
  fetchFavoriteIds,
  setFavorite,
} from "@/lib/data/questions";
import { fetchFlashcardThemeCounts, fetchFlashcardsByTheme, fetchAllFlashcards, recordFlashcardView } from "@/lib/data/flashcards";
import { DROPDOWN_ALL } from "@/components/ui/Primitives";
import { fetchDailyMissionItems, completeDailyMission, expireDailyMission } from "@/lib/data/mission";
import {
  fetchFriends,
  addFriendByName,
  fetchIncomingFriendRequests,
  respondToFriendRequest,
} from "@/lib/data/friends";
import { fetchChallenges } from "@/lib/data/challenges";
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
];

const DEFAULT_FILTERS = {
  temas: [],
  anos: [],
  instituicoes: [],
  favoritasOnly: false,
  modoProva: false,
  mostrarAntigas: false,
  cronometro: false,
  minutos: 20,
  fontSize: "md",
};

export function EstudaApp({ userId, userEmail }) {
  const t = useT();
  const router = useRouter();
  const [supabase] = useState(() => createClient());

  const [screen, setScreen] = useState("home");
  const [loading, setLoading] = useState(true);
  const [profile, setProfile] = useState(null);
  const [allQuestions, setAllQuestions] = useState([]);
  const [favorites, setFavorites] = useState([]);
  const [friends, setFriends] = useState([]);
  const [incomingRequests, setIncomingRequests] = useState([]);
  const [stats, setStats] = useState({ answered: 0, accuracy: 0 });
  const [themeCounts, setThemeCounts] = useState({});
  const [challenges, setChallenges] = useState([]);
  const [challengeAnswering, setChallengeAnswering] = useState(false);
  const [accountFocus, setAccountFocus] = useState(null);

  const [filters, setFilters] = useState(DEFAULT_FILTERS);
  const [flashcardFontSize, setFlashcardFontSize] = useState("md");

  const [session, setSession] = useState(null);
  const [sessionQuestionsById, setSessionQuestionsById] = useState({});
  const [sessionOptionsByQuestion, setSessionOptionsByQuestion] = useState({});
  const [savedSession, setSavedSession] = useState(null);

  const [flashSession, setFlashSession] = useState(null);

  const [dailyItems, setDailyItems] = useState(null);
  const [dailyOptionsByQuestion, setDailyOptionsByQuestion] = useState({});
  const [dailySession, setDailySession] = useState(null);
  const dailyPrefetchRef = useRef(null);

  const missionDone = profile ? profile.last_mission_date === todayStr() : false;

  // Monta a missão de hoje (questões + flashcards) assim que o app carrega, em segundo
  // plano — assim, ao clicar em "Missão Diária" ela já está pronta na hora. O mesmo
  // conjunto é reaproveitado se o usuário sair e voltar, sem sortear de novo.
  const prefetchDaily = useCallback(() => {
    if (dailyPrefetchRef.current) return dailyPrefetchRef.current;
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

  useEffect(() => {
    let cancelled = false;
    (async () => {
      let [profileData, questions, favIds, friendsData] = await Promise.all([
        fetchProfile(supabase, userId),
        fetchAllQuestions(supabase),
        fetchFavoriteIds(supabase, userId),
        fetchFriends(supabase),
      ]);
      if (cancelled) return;
      const correctedStreak = effectiveStreak(profileData.streak, profileData.last_mission_date);
      if (correctedStreak !== profileData.streak) {
        profileData = { ...profileData, streak: correctedStreak };
        resetStreak(supabase, userId).catch(() => {});
      }
      setProfile(profileData);
      setFilters((f) => ({ ...f, fontSize: profileData.question_font_size || "md" }));
      setFlashcardFontSize(profileData.flashcard_font_size || "md");
      setAllQuestions(questions);
      setFavorites(favIds);
      setFriends(friendsData);
      setLoading(false);
      // Não bloqueia o app: o balão de pendentes só precisa aparecer assim que chegar.
      fetchChallenges(supabase, userId).then((data) => {
        if (!cancelled) setChallenges(data);
      });
    })();
    return () => {
      cancelled = true;
    };
  }, [supabase, userId]);

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
    if (screen === "flashcards-select") {
      fetchFlashcardThemeCounts(supabase).then(setThemeCounts);
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
    const pool = applyQuestionFilters(allQuestions, filters, favorites);
    const ids = shuffle(pool).map((q) => q.id);
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

    setSessionQuestionsById(Object.fromEntries(pool.map((q) => [q.id, q])));
    setSessionOptionsByQuestion(options);
    setSession({
      ids,
      index: 0,
      selected: initialSelected,
      answers: initialAnswers,
      prefilled: initialPrefilled,
      struck: {},
      startedAt: filters.cronometro ? Date.now() : null,
      durationMs: filters.cronometro ? filters.minutos * 60 * 1000 : null,
    });
    setScreen("questions-session");
  };

  const continueQuestions = () => {
    if (!savedSession) return;
    setSession(savedSession.session);
    setSessionQuestionsById(savedSession.questionsById);
    setSessionOptionsByQuestion(savedSession.optionsByQuestion);
    setScreen("questions-session");
  };

  const backFromSession = () => {
    setSavedSession({ session, questionsById: sessionQuestionsById, optionsByQuestion: sessionOptionsByQuestion });
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
    setSavedSession(null);
    setScreen("questions-results");
  };

  /* ---- Flashcards ---- */
  const startFlashcards = async (tema, qtd, aleatorio, tamanho) => {
    let pool = tema === DROPDOWN_ALL ? await fetchAllFlashcards(supabase) : await fetchFlashcardsByTheme(supabase, tema);
    // Com "Todos" embaralha sempre, mesmo sem o toggle Aleatorizar — senão uma
    // quantidade limitada ficaria presa aos primeiros temas por ordem de id,
    // em vez de misturar.
    if (aleatorio || tema === DROPDOWN_ALL) pool = shuffle(pool);
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
    // Reaproveita o que já foi pré-carregado em segundo plano; só espera se o
    // usuário clicou antes desse carregamento terminar.
    if (!dailyItems) {
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
    setProfile((p) => ({ ...p, streak, last_mission_date }));
    // Limpa a sessão concluída — se não, um eventual desalinhamento no cálculo
    // de "hoje" (ex.: logo após mudar a virada do dia) deixaria a próxima
    // entrada na Missão Diária caindo de volta no último item já respondido.
    setDailySession(null);
    setDailyItems(null);
    setDailyOptionsByQuestion({});
    dailyPrefetchRef.current = null;
    setScreen("daily-done");
  };

  // Se a virada do dia acontece com a pessoa ainda dentro da missão (sem ter
  // concluído), fecha a missão, zera a streak e volta pra tela inicial —
  // perder o prazo quebra a sequência.
  const expireDaily = useCallback(async () => {
    try {
      const { streak } = await expireDailyMission(supabase);
      setProfile((p) => ({ ...p, streak }));
    } catch {
      // melhor deixar a streak como está do que travar o usuário na missão vencida
    }
    setDailySession(null);
    setDailyItems(null);
    setDailyOptionsByQuestion({});
    dailyPrefetchRef.current = null;
    setScreen("home");
  }, [supabase]);

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

  const addFriend = async (name) => {
    const result = await addFriendByName(supabase, name);
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

  const signOut = async () => {
    await supabase.auth.signOut();
    router.push("/login");
    router.refresh();
  };

  const temas = useMemo(() => deriveFilterOptions(allQuestions).temas, [allQuestions]);

  if (loading || !profile) {
    return (
      <div style={{ padding: 60, textAlign: "center", color: t.textMuted }}>Carregando…</div>
    );
  }

  const showHeader = !HIDDEN_HEADER_SCREENS.includes(screen) && !challengeAnswering;

  return (
    <div>
      {showHeader && <Header streak={profile.streak} onNavigate={setScreen} missionDone={missionDone} />}

      {screen === "home" && (
        <HomeScreen
          name={profile.name}
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
          initialFocus={accountFocus}
          onFocusConsumed={() => setAccountFocus(null)}
          onNavigate={setScreen}
          onSaveName={saveDisplayName}
          onSaveStatsVisibility={saveStatsVisibility}
          onSaveRankingVisibility={saveRankingVisibility}
          onAddFriend={addFriend}
          onRespondRequest={respondRequest}
          onRefreshFriends={refreshFriends}
          onSignOut={signOut}
        />
      )}

      {screen === "ranking" && <RankingScreen supabase={supabase} onNavigate={setScreen} />}

      {screen === "stats" && (
        <StatsScreen
          supabase={supabase}
          userId={userId}
          allQuestions={allQuestions}
          challenges={challenges}
          onNavigate={setScreen}
        />
      )}

      {screen === "questions-filters" && (
        <QuestionsFilterScreen
          allQuestions={allQuestions}
          favorites={favorites}
          filters={filters}
          setFilters={setFilters}
          onSetFontSize={saveQuestionFontSize}
          onStart={startQuestions}
          onContinue={continueQuestions}
          hasSavedSession={!!savedSession}
          onNavigate={setScreen}
        />
      )}

      {screen === "questions-session" && session && (
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

      {screen === "questions-results" && session && (
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

      {screen === "flashcards-select" && (
        <FlashcardsSelectScreen
          themeCounts={themeCounts}
          tamanho={flashcardFontSize}
          onSetTamanho={saveFlashcardFontSize}
          onStart={startFlashcards}
          onNavigate={setScreen}
          hasSavedFlashSession={!!flashSession}
          onContinueFlashcards={() => setScreen("flashcards-session")}
        />
      )}

      {screen === "flashcards-session" && flashSession && (
        <FlashcardsSessionScreen
          supabase={supabase}
          userId={userId}
          session={flashSession}
          setSession={setFlashSession}
          onNavigate={setScreen}
          onFinish={finishFlashcards}
          onView={viewFlashcard}
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
        <DailyDoneScreen supabase={supabase} streak={profile.streak} friends={friends} onNavigate={setScreen} />
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
          onAnsweringChange={setChallengeAnswering}
          fontSize={filters.fontSize}
        />
      )}
    </div>
  );
}
