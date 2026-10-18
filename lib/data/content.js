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

// Busca todas as páginas de uma consulta (o PostgREST corta a resposta em 1000 linhas). As páginas vão em
// grupos paralelos (4 por vez): com ~3.000 linhas, em vez de 4 idas ao servidor em fila, é 1 só.
// fetchPage(de, ate) devolve a lista da página, ou null para abortar (ex.: a função não existe).
// A ordem é a das páginas, então a consulta precisa ter ORDER BY estável (as nossas têm).
export async function fetchAllPages(fetchPage, pageSize = 1000, parallel = 4) {
  let all = [];
  for (let from = 0; ; from += pageSize * parallel) {
    const pages = await Promise.all(
      Array.from({ length: parallel }, (_, i) => fetchPage(from + i * pageSize, from + (i + 1) * pageSize - 1))
    );
    for (const page of pages) {
      if (page === null) return null;
      all = all.concat(page);
      if (page.length < pageSize) return all;
    }
  }
}

// Lê uma RPC que devolve lista, em páginas. Devolve null se a função não existir.
export async function rpcAll(supabase, fn, args = {}, pageSize = 1000) {
  return fetchAllPages(async (from, to) => {
    const { data, error } = await supabase.rpc(fn, args).range(from, to);
    if (error) {
      if (rpcMissing(error)) return null;
      throw error;
    }
    return data;
  }, pageSize);
}
