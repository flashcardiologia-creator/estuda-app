// Abre o pagamento do Mercado Pago numa janela por cima do próprio site (Checkout Pro em modal),
// em vez de levar a pessoa para outra página ou para o app do Mercado Pago.
// Precisa da Public Key (pública, não é segredo) em NEXT_PUBLIC_MERCADOPAGO_PUBLIC_KEY.
// Sem ela, ou se a janela não abrir, quem chama usa o link de pagamento (redirecionamento).

const SDK_URL = "https://sdk.mercadopago.com/js/v2";
const PUBLIC_KEY = process.env.NEXT_PUBLIC_MERCADOPAGO_PUBLIC_KEY;

export const canOpenModal = () => !!PUBLIC_KEY;

let sdkPromise = null;
function loadSdk() {
  if (window.MercadoPago) return Promise.resolve();
  if (!sdkPromise) {
    sdkPromise = new Promise((resolve, reject) => {
      const script = document.createElement("script");
      script.src = SDK_URL;
      script.async = true;
      script.onload = () => resolve();
      script.onerror = () => {
        sdkPromise = null;
        reject(new Error("sdk"));
      };
      document.head.appendChild(script);
    });
  }
  return sdkPromise;
}

// Devolve depois de pedir a abertura da janela. Lança erro se não for possível.
export async function openCheckoutModal(preferenceId) {
  if (!PUBLIC_KEY) throw new Error("no_public_key");
  await loadSdk();
  const mp = new window.MercadoPago(PUBLIC_KEY, { locale: "pt-BR" });
  mp.checkout({ preference: { id: preferenceId }, autoOpen: true });
}
