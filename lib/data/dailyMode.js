// Formato da missão diária que a pessoa escolheu (vale a partir do sorteio do dia seguinte):
//   "mix"       = 5 questões + 5 flashcards (padrão)
//   "questions" = 10 questões
// Guardado em profiles.daily_mode (supabase/add_daily_mode.sql). Enquanto o SQL não foi rodado, fica
// só neste aparelho (localStorage), para o app funcionar do mesmo jeito.
export const DAILY_MODES = ["mix", "questions"];

const localKey = (userId) => `flashcardio_daily_mode_${userId}`;

function readLocal(userId) {
  try {
    const v = localStorage.getItem(localKey(userId));
    return DAILY_MODES.includes(v) ? v : null;
  } catch {
    return null;
  }
}

function writeLocal(userId, mode) {
  try {
    localStorage.setItem(localKey(userId), mode);
  } catch {
    // sem armazenamento: vale só na conta
  }
}

export async function getDailyMode(supabase, userId) {
  const { data, error } = await supabase.from("profiles").select("daily_mode").eq("id", userId).single();
  if (!error && DAILY_MODES.includes(data?.daily_mode)) {
    writeLocal(userId, data.daily_mode);
    return data.daily_mode;
  }
  return readLocal(userId) || "mix";
}

// Devolve true se ficou salvo na conta (vale em todos os aparelhos); false se só neste aparelho.
export async function setDailyMode(supabase, userId, mode) {
  writeLocal(userId, mode);
  const { error } = await supabase.from("profiles").update({ daily_mode: mode }).eq("id", userId);
  return !error;
}
