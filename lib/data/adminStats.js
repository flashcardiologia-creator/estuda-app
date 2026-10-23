// Números do painel de dados da conta administradora (função admin_stats, supabase/painel_dados_admin.sql).
// A função confere o e-mail no banco: qualquer outra conta recebe "forbidden".
export async function fetchAdminStats(supabase) {
  const { data, error } = await supabase.rpc("admin_stats");
  if (error) {
    const msg = `${error.message || ""} ${error.code || ""}`;
    if (/forbidden/i.test(msg)) throw new Error("Esta conta não tem acesso ao painel.");
    if (/PGRST202|does not exist|schema cache/i.test(msg)) {
      throw new Error("O painel ainda não foi ativado no banco. Rode o SQL do painel de dados no Supabase.");
    }
    throw new Error("Não foi possível carregar os dados agora. Tente de novo em instantes.");
  }
  return data;
}

// Parte 2 do painel (função admin_extra_stats, supabase/painel_dados_extra.sql): e-mails dos 5 últimos
// usuários e as questões com mais erros e mais acertos. Devolve null se o SQL ainda não foi rodado.
export async function fetchAdminExtra(supabase) {
  const { data, error } = await supabase.rpc("admin_extra_stats");
  if (error) {
    if (/PGRST202|does not exist|schema cache/i.test(`${error.message || ""} ${error.code || ""}`)) return null;
    throw new Error("Não foi possível carregar essa parte agora.");
  }
  return data;
}
