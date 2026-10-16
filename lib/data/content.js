// Quem não tem assinatura ativa não lê as tabelas de questões, alternativas e flashcards direto:
// o banco só entrega, por funções (RPC), o que faz parte da missão de hoje e dos desafios da pessoa
// (supabase/assinaturas_fase2.sql). Quem tem assinatura lê as tabelas como sempre.
//
// EstudaApp marca o cliente com `supabase.contentOpen` (true = assinante ou trava desligada).

export const isContentOpen = (supabase) => supabase.contentOpen !== false;

// A função ainda não existe no banco (o SQL da fase 2 não foi rodado): o chamador volta à leitura
// direta das tabelas, que continua liberada enquanto esse SQL não rodar.
export const rpcMissing = (error) =>
  !!error && /PGRST202|could not find the function|schema cache/i.test(`${error.code || ""} ${error.message || ""}`);

// Lê uma RPC que devolve lista, em páginas (o PostgREST corta a resposta em 1000 linhas).
// Devolve null se a função não existir.
export async function rpcAll(supabase, fn, args = {}, pageSize = 1000) {
  let all = [];
  for (let from = 0; ; from += pageSize) {
    const { data, error } = await supabase.rpc(fn, args).range(from, from + pageSize - 1);
    if (error) {
      if (rpcMissing(error)) return null;
      throw error;
    }
    all = all.concat(data);
    if (data.length < pageSize) return all;
  }
}
