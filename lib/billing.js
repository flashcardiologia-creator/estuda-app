// Planos à venda. Os preços ficam aqui (e só aqui): o servidor sempre usa estes valores, nunca o
// que o navegador envia. Em centavos para não haver erro de arredondamento.
export const PLANS = {
  mensal: { id: "mensal", label: "Mensal", days: 30, priceCents: 9900 },
  anual: { id: "anual", label: "Anual", days: 365, priceCents: 46800 },
};

export const isPlan = (id) => typeof id === "string" && Object.prototype.hasOwnProperty.call(PLANS, id);

export const formatBRL = (cents) => (cents / 100).toLocaleString("pt-BR", { style: "currency", currency: "BRL" });

// Base da API do Mercado Pago. Só muda em teste (aponta para um servidor falso).
export const MP_API = process.env.MERCADOPAGO_API_BASE || "https://api.mercadopago.com";
