// Envia o aceite dos termos ao servidor (rota /auth/aceite). O IP e o aparelho são lidos lá,
// dos cabeçalhos da requisição; daqui vão só dados auxiliares do navegador.
// context: "signup" (cadastro) ou "gate" (tela de aceite após o login). Sem sessão, informe `user`.
// Uma nova tentativa cobre falha de rede passageira. Devolve true se registrou (ou já estava registrado).
// keepalive: o envio continua mesmo se a página for fechada ou trocada logo em seguida (use quando não
// vamos esperar a resposta).
export async function sendTermsAcceptance({ context, user, keepalive = false }) {
  const body = JSON.stringify({
    context,
    userId: user?.id,
    email: user?.email,
    timezone: Intl.DateTimeFormat().resolvedOptions().timeZone,
    language: navigator.language,
    platform: navigator.userAgentData?.platform || navigator.platform,
    screen: `${window.screen.width}x${window.screen.height}`,
    displayMode: window.matchMedia("(display-mode: standalone)").matches ? "standalone" : "browser",
  });
  for (let attempt = 0; attempt < 2; attempt++) {
    try {
      const res = await fetch("/auth/aceite", { method: "POST", headers: { "Content-Type": "application/json" }, body, keepalive });
      // 404 = e-mail já cadastrado (o Supabase devolve um usuário "fantasma"): nada a registrar.
      if (res.ok || (context === "signup" && res.status === 404)) return true;
    } catch {}
  }
  return false;
}
