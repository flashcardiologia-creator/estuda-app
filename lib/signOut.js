// Sai da conta e abre a tela de login.
// - scope "local": encerra só a sessão deste aparelho. O padrão do Supabase ("global") apaga TODAS as
//   sessões da conta, em todos os aparelhos: além de deslogar a pessoa de onde ela não pediu, fica
//   lento em contas com muitas sessões acumuladas (um logout da conta administradora levou ~1 s).
// - Depois do logout, a navegação é uma carga completa da página (em vez de router.push + router.refresh,
//   que buscavam a tela duas vezes): é mais rápida e ainda descarta da memória o que era da conta anterior.
export async function signOutAndLeave(supabase) {
  try {
    await supabase.auth.signOut({ scope: "local" });
  } catch {
    // mesmo sem rede, segue para o login
  }
  window.location.replace("/login");
}
