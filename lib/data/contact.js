// Mensagem de contato (tela Minha Conta). Chega por e-mail via trigger do banco
// (supabase/add_contact_messages.sql), igual aos reportes de erro.
export const CONTACT_MAX = 2000;

export async function sendContactMessage(supabase, userId, assunto, mensagem) {
  const { error } = await supabase.from("contact_messages").insert({
    user_id: userId,
    assunto,
    mensagem: mensagem.trim().slice(0, CONTACT_MAX),
  });
  if (error) {
    if (/row-level security|violates/i.test(error.message || "")) {
      throw new Error("Você já enviou muitas mensagens hoje. Tente de novo amanhã.");
    }
    throw new Error("Não foi possível enviar agora. Tente de novo em instantes.");
  }
}
