// IP de quem abriu o site, lido dos cabeçalhos da requisição (nunca do navegador). Usado em /auth/promo, /auth/quiz e /auth/aceite.
//
// No Netlify a cadeia x-forwarded-for chega como "IP do visitante, IP de servidor, IP de servidor": os dois últimos itens são
// intermediários da AWS (conferido em terms_acceptances.ip_chain). Os cabeçalhos x-nf-client-connection-ip e x-real-ip trazem o
// primeiro intermediário, não o visitante, e por isso todo mundo parecia ter um dos poucos IPs de AWS.
// O visitante é o item que vem 2 antes do fim da cadeia. Contar do fim impede que um x-forwarded-for enviado pelo próprio
// navegador (que entra no começo da cadeia) escolha o IP. Sem cadeia, cai nos outros cabeçalhos.
const INTERMEDIARIOS = 2;

export function clientIp(headers) {
  const chain = (headers.get("x-forwarded-for") || "")
    .split(",")
    .map((s) => s.trim())
    .filter(Boolean);
  const fromChain = chain.length ? chain[Math.max(chain.length - 1 - INTERMEDIARIOS, 0)] : null;
  const fallback = headers.get("x-nf-client-connection-ip") || headers.get("x-real-ip");
  const ip = (fromChain || fallback || "").trim();
  // Só endereço IPv4/IPv6 (também protege a busca com like em /auth/promo).
  return /^[0-9a-fA-F:.]{2,64}$/.test(ip) ? ip : null;
}
