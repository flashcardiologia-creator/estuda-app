// O PostgREST recebe o `.in()` na URL: listas grandes (~900+ ids de questão)
// estouram o limite de tamanho e a consulta falha com 400 — sem mensagem, o
// botão "Iniciar Questões" parecia não fazer nada com todos os temas
// selecionados. Aqui a lista é dividida em lotes pequenos, executados em
// paralelo limitado, e os resultados são concatenados.
export const IN_CHUNK_SIZE = 200;

// Uma requisição travada (rede móvel ruim, lock de autenticação preso por outra
// aba) nunca resolve nem rejeita — sem prazo, a tela ficava em "Carregando…"
// para sempre. Estoura depois de `ms` para dar chance de tentar de novo.
export function withTimeout(promise, ms, label = "operação") {
  let timer;
  const timeout = new Promise((_, reject) => {
    timer = setTimeout(() => reject(new Error(`Tempo esgotado (${label})`)), ms);
  });
  return Promise.race([promise, timeout]).finally(() => clearTimeout(timer));
}

// Repete a chamada algumas vezes, com espera crescente, antes de desistir.
export async function withRetry(fn, tries = 3, baseDelayMs = 700) {
  let lastError;
  for (let attempt = 0; attempt < tries; attempt++) {
    try {
      return await fn(attempt);
    } catch (e) {
      lastError = e;
      if (attempt < tries - 1) await new Promise((r) => setTimeout(r, baseDelayMs * (attempt + 1)));
    }
  }
  throw lastError;
}

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
