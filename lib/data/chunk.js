// O PostgREST recebe o `.in()` na URL: listas grandes (~900+ ids de questão)
// estouram o limite de tamanho e a consulta falha com 400 — sem mensagem, o
// botão "Iniciar Questões" parecia não fazer nada com todos os temas
// selecionados. Aqui a lista é dividida em lotes pequenos, executados em
// paralelo limitado, e os resultados são concatenados.
export const IN_CHUNK_SIZE = 200;

export async function inChunks(ids, fn, size = IN_CHUNK_SIZE, concurrency = 6) {
  const chunks = [];
  for (let i = 0; i < ids.length; i += size) chunks.push(ids.slice(i, i + size));
  const results = new Array(chunks.length);
  let next = 0;
  const worker = async () => {
    while (next < chunks.length) {
      const i = next++;
      results[i] = await fn(chunks[i]);
    }
  };
  await Promise.all(Array.from({ length: Math.min(concurrency, chunks.length) }, worker));
  return results.flat();
}
