// Flashcards personalizados (só da própria pessoa): criar os seus e mandar cards para a lixeira.
// Tabelas user_flashcards e user_flashcard_trash (supabase/add_personal_flashcards.sql).
// Se o SQL ainda não foi rodado, tudo aqui falha em silêncio e o app funciona sem personalização.
import { inChunks } from "./chunk";

export const MAX_PERGUNTA = 300;
export const MAX_RESPOSTA = 700;

// Cards na lixeira + cards criados pela pessoa (o RLS já limita às linhas dela).
export async function fetchPersonalState(supabase) {
  const [trash, custom] = await Promise.all([
    supabase.from("user_flashcard_trash").select("flashcard_id"),
    supabase.from("user_flashcards").select("id, tema, pergunta, resposta, created_at").order("created_at"),
  ]);
  return {
    trashed: new Set(trash.error ? [] : (trash.data || []).map((r) => r.flashcard_id)),
    custom: custom.error ? [] : (custom.data || []).map((c) => ({ ...c, custom: true })),
  };
}

export async function createCustomFlashcard(supabase, userId, { tema, pergunta, resposta }) {
  const row = {
    user_id: userId,
    tema,
    pergunta: pergunta.trim().toUpperCase().slice(0, MAX_PERGUNTA),
    resposta: resposta.trim().toUpperCase().slice(0, MAX_RESPOSTA),
  };
  const { data, error } = await supabase.from("user_flashcards").insert(row).select("id, tema, pergunta, resposta, created_at").single();
  if (error) throw new Error("Não foi possível salvar o flashcard. Confira se o SQL de personalização já foi rodado.");
  return { ...data, custom: true };
}

export async function sendToTrash(supabase, userId, card) {
  const { error } = await supabase
    .from("user_flashcard_trash")
    .upsert({ user_id: userId, flashcard_id: card.id, origem: card.custom ? "meu" : "banco", deleted_at: new Date().toISOString() });
  if (error) throw new Error("Não foi possível mandar para a lixeira.");
}

export async function restoreFromTrash(supabase, userId, flashcardId) {
  const { error } = await supabase.from("user_flashcard_trash").delete().eq("user_id", userId).eq("flashcard_id", flashcardId);
  if (error) throw new Error("Não foi possível restaurar o flashcard.");
}

// Apaga de vez um flashcard criado pela própria pessoa (e tira da lixeira).
export async function deleteCustomForever(supabase, userId, flashcardId) {
  const { error } = await supabase.from("user_flashcards").delete().eq("id", flashcardId).eq("user_id", userId);
  if (error) throw new Error("Não foi possível apagar o flashcard.");
  await supabase.from("user_flashcard_trash").delete().eq("user_id", userId).eq("flashcard_id", flashcardId);
}

// Lixeira com o conteúdo dos cards, do mais recente para o mais antigo.
export async function fetchTrash(supabase, userId) {
  const { data: rows, error } = await supabase
    .from("user_flashcard_trash")
    .select("flashcard_id, origem, deleted_at")
    .eq("user_id", userId)
    .order("deleted_at", { ascending: false });
  if (error || !rows?.length) return [];
  const bankIds = rows.filter((r) => r.origem !== "meu").map((r) => r.flashcard_id);
  const mineIds = rows.filter((r) => r.origem === "meu").map((r) => r.flashcard_id);
  const [bank, mine] = await Promise.all([
    bankIds.length
      ? inChunks(bankIds, async (chunk) => {
          const { data } = await supabase.from("flashcards").select("id, tema, pergunta, resposta").in("id", chunk);
          return data || [];
        })
      : [],
    mineIds.length
      ? inChunks(mineIds, async (chunk) => {
          const { data } = await supabase.from("user_flashcards").select("id, tema, pergunta, resposta").in("id", chunk);
          return data || [];
        })
      : [],
  ]);
  const byId = {};
  bank.forEach((c) => (byId[c.id] = { ...c, custom: false }));
  mine.forEach((c) => (byId[c.id] = { ...c, custom: true }));
  return rows.map((r) => (byId[r.flashcard_id] ? { ...byId[r.flashcard_id], deleted_at: r.deleted_at } : null)).filter(Boolean);
}
