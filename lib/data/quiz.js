// Quiz de boas-vindas (supabase/quiz_boas_vindas.sql). A tentativa fica gravada pelo IP no servidor (rota /auth/quiz),
// então atualizar a página não dá outra chance. Qualquer falha aqui é silenciosa: se o SQL ainda não foi rodado, ou a
// consulta falhar, o quiz simplesmente não aparece.

const SAVED_KEY = "fc-quiz-boas-vindas";

// { feito, id?, resultado?, quiz: { tabela, questoes: [{ slot, tema, ano, instituicao, enunciado, alternativas }] } }
// ou null quando o quiz não está disponível. feito = este IP já respondeu (então vem o resultado gravado).
export async function fetchQuizState() {
  try {
    const res = await fetch("/auth/quiz", { cache: "no-store" });
    if (!res.ok) return null;
    const data = await res.json();
    if (data?.erro || !data?.quiz?.questoes?.length) return null;
    return data;
  } catch {
    return null;
  }
}

// respostas: { [slot]: "A" }. Devolve { id, jaTinha, resultado } ou null. Se o IP já tinha tentativa, jaTinha = true e o
// resultado é o da tentativa antiga (as respostas novas são ignoradas).
// resultado: { acertos, total, dias, tabela, questoes: [{ slot, escolhida, correta, acertou, tema, instituicao, comentario,
// comentario_completo }] }
export async function submitQuiz(respostas) {
  try {
    const res = await fetch("/auth/quiz", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ respostas }),
    });
    if (!res.ok) return null;
    const data = await res.json();
    if (data?.erro || !data?.id || !data?.resultado) return null;
    return data;
  } catch {
    return null;
  }
}

const SAVED_EVENT = "fc-quiz-salvo";

// Guarda no navegador o número da tentativa e o resultado: o cadastro leva o número (quiz_id) e a tela mostra os dias garantidos.
export function saveQuiz(id, resultado) {
  try {
    window.localStorage.setItem(SAVED_KEY, JSON.stringify({ id, acertos: resultado.acertos, total: resultado.total, dias: resultado.dias }));
    window.dispatchEvent(new Event(SAVED_EVENT));
  } catch {
    // sem armazenamento: o quiz mostra o resultado gravado de novo na próxima visita
  }
}

// Leitura para useSyncExternalStore: o texto guardado ("" quando não há), e o aviso de mudança.
export function quizSnapshot() {
  try {
    return window.localStorage.getItem(SAVED_KEY) || "";
  } catch {
    return "";
  }
}
export function subscribeQuiz(onChange) {
  window.addEventListener(SAVED_EVENT, onChange);
  window.addEventListener("storage", onChange);
  return () => {
    window.removeEventListener(SAVED_EVENT, onChange);
    window.removeEventListener("storage", onChange);
  };
}

// { id, acertos, total, dias } ou null, a partir do texto guardado.
export function parseQuiz(raw) {
  try {
    const saved = JSON.parse(raw || "null");
    return saved?.id && Number.isFinite(saved.dias) ? saved : null;
  } catch {
    return null;
  }
}

// Depois do login: libera os dias do quiz respondido antes do cadastro. Devolve { status, acertos, dias, until } ou null.
// status: "ok" | "sem_quiz" | "ja_usado" | "conta_antiga" | "expirado"
export async function claimQuizReward(supabase) {
  try {
    const { data, error } = await supabase.rpc("quiz_boas_vindas_resgatar");
    const row = Array.isArray(data) ? data[0] : data;
    if (error || !row?.out_status) return null;
    return { status: row.out_status, acertos: row.out_acertos, dias: row.out_dias, until: row.out_expires_at };
  } catch {
    return null;
  }
}

// Tabela "acertos -> dias" para mostrar na tela: [{ acertos: 0, dias: 3 }, ...].
export function quizTable(tabela) {
  return (tabela || [3, 5, 7, 10]).map((dias, acertos) => ({ acertos, dias }));
}
