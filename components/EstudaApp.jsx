"use client";

import { useCallback, useEffect, useMemo, useState } from "react";
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

import { fetchProfile, updateDisplayName, fetchStats } from "@/lib/data/profile";
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
import { fetchFlashcardThemeCounts, fetchFlashcardsByTheme } from "@/lib/data/flashcards";
import { fetchDailyMissionItems, completeDailyMission } from "@/lib/data/mission";
import { fetchFriends, addFriendByName } from "@/lib/data/friends";
import { fetchChallenges } from "@/lib/data/challenges";
import { shuffle, todayStr } from "@/lib/util";

const HIDDEN_HEADER_SCREENS = ["questions-session", "flashcards-session", "daily-session", "questions-results"];

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

export function EstudaApp({ userId }) {
  const t = useT();
  const router = useRouter();
  const [supabase] = useState(() => createClient());

  const [screen, setScreen] = useState("home");
  const [loading, setLoading] = useState(true);
  const [profile, setProfile] = useState(null);
  const [allQuestions, setAllQuestions] = useState([]);
  const [favorites, setFavorites] = useState([]);
  const [friends, setFriends] = useState([]);
  const [stats, setStats] = useState({ answered: 0, accuracy: 0 });
  const [themeCounts, setThemeCounts] = useState({});
  const [challenges, setChallenges] = useState([]);
  const [challengeAnswering, setChallengeAnswering] = useState(false);
  const [history, setHistory] = useState({});

  const [filters, setFilters] = useState(DEFAULT_FILTERS);

  const [session, setSession] = useState(null);
  const [sessionQuestionsById, setSessionQuestionsById] = useState({});
  const [sessionOptionsByQuestion, setSessionOptionsByQuestion] = useState({});
  const [savedSession, setSavedSession] = useState(null);

  const [flashSession, setFlashSession] = useState(null);

  const [dailyItems, setDailyItems] = useState(null);
  const [dailyOptionsByQuestion, setDailyOptionsByQuestion] = useState({});
  const [dailySession, setDailySession] = useState(null);

  const missionDone = profile ? profile.last_mission_date === todayStr() : false;

  useEffect(() => {
    let cancelled = false;
    (async () => {
      const [profileData, questions, favIds, friendsData] = await Promise.all([
        fetchProfile(supabase, userId),
        fetchAllQuestions(supabase),
        fetchFavoriteIds(supabase, userId),
        fetchFriends(supabase, userId),
      ]);
      if (cancelled) return;
      setProfile(profileData);
      setAllQuestions(questions);
      setFavorites(favIds);
      setFriends(friendsData);
      setLoading(false);
    })();
    return () => {
      cancelled = true;
    };
  }, [supabase, userId]);

  useEffect(() => {
    if (screen === "account") {
      fetchStats(supabase, userId).then(setStats);
      fetchFriends(supabase, userId).then(setFriends);
    }
    if (screen === "challenges") {
      fetchChallenges(supabase, userId).then(setChallenges);
    }
    if (screen === "flashcards-select") {
      fetchFlashcardThemeCounts(supabase).then(setThemeCounts);
    }
  }, [screen, supabase, userId]);

  const refreshChallenges = useCallback(async () => {
    const data = await fetchChallenges(supabase, userId);
    setChallenges(data);
  }, [supabase, userId]);

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
    setSessionQuestionsById(Object.fromEntries(pool.map((q) => [q.id, q])));
    setSessionOptionsByQuestion(options);
    setHistory((h) => ({ ...h, ...hist }));
    setSession({
      ids,
      index: 0,
      selected: {},
      answers: {},
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
  const startFlashcards = async (tema, qtd, aleatorio) => {
    let pool = await fetchFlashcardsByTheme(supabase, tema);
    if (aleatorio) pool = shuffle(pool);
    if (qtd !== "Todos") pool = pool.slice(0, qtd);
    setFlashSession({
      ids: pool.map((f) => f.id),
      index: 0,
      flipped: {},
      viewed: {},
      cardsById: Object.fromEntries(pool.map((f) => [f.id, f])),
    });
    setScreen("flashcards-session");
  };

  /* ---- Missão diária ---- */
  const startDaily = async () => {
    if (missionDone) {
      setScreen("daily-done");
      return;
    }
    const { questions, flashcards } = await fetchDailyMissionItems(supabase, userId);
    const options = await fetchOptionsForQuestions(supabase, questions.map((q) => q.id));
    const items = [
      ...questions.map((q) => ({ type: "question", data: q })),
      ...flashcards.map((f) => ({ type: "flashcard", data: f })),
    ];
    setDailyItems(items);
    setDailyOptionsByQuestion(options);
    setDailySession({ index: 0, selected: {}, answers: {}, flipped: {}, viewed: {} });
    setScreen("daily-session");
  };

  const dailyAnswer = async (qid, selected) => {
    const result = await recordAnswer(supabase, qid, selected, true);
    return { selected, ...result };
  };

  const finishDaily = async () => {
    const { streak, last_mission_date } = await completeDailyMission(supabase);
    setProfile((p) => ({ ...p, streak, last_mission_date }));
    setScreen("daily-done");
  };

  /* ---- Conta ---- */
  const saveDisplayName = async (name) => {
    await updateDisplayName(supabase, userId, name);
    setProfile((p) => ({ ...p, name }));
  };

  const addFriend = async (name) => {
    const friend = await addFriendByName(supabase, userId, name);
    setFriends((f) => [...f, friend]);
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
        />
      )}

      {screen === "account" && (
        <AccountScreen
          profile={profile}
          stats={stats}
          friends={friends}
          onNavigate={setScreen}
          onSaveName={saveDisplayName}
          onAddFriend={addFriend}
          onSignOut={signOut}
        />
      )}

      {screen === "questions-filters" && (
        <QuestionsFilterScreen
          allQuestions={allQuestions}
          favorites={favorites}
          filters={filters}
          setFilters={setFilters}
          onStart={startQuestions}
          onContinue={continueQuestions}
          hasSavedSession={!!savedSession}
          onNavigate={setScreen}
        />
      )}

      {screen === "questions-session" && session && (
        <QuestionsSessionScreen
          session={session}
          setSession={setSession}
          questionsById={sessionQuestionsById}
          optionsByQuestion={sessionOptionsByQuestion}
          filters={filters}
          favorites={favorites}
          onToggleFav={toggleFav}
          history={history}
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
        <FlashcardsSelectScreen themeCounts={themeCounts} onStart={startFlashcards} onNavigate={setScreen} />
      )}

      {screen === "flashcards-session" && flashSession && (
        <FlashcardsSessionScreen session={flashSession} setSession={setFlashSession} onNavigate={setScreen} />
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
          history={history}
        />
      )}

      {screen === "daily-done" && <DailyDoneScreen streak={profile.streak} onNavigate={setScreen} />}

      {screen === "challenges" && (
        <ChallengesScreen
          supabase={supabase}
          userId={userId}
          friends={friends}
          challenges={challenges}
          temas={temas}
          onRefreshChallenges={refreshChallenges}
          onNavigate={setScreen}
          onAnsweringChange={setChallengeAnswering}
        />
      )}
    </div>
  );
}
