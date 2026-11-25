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

// Aba Acessos (função admin_acessos, supabase/acessos_visitantes.sql): funil, tempo, origem e aparelho de quem abre a
// tela de entrada e o quiz. dias = 7, 30 ou 90. Devolve null se o SQL ainda não foi rodado.
export async function fetchAdminAcessos(supabase, dias) {
  const { data, error } = await supabase.rpc("admin_acessos", { p_dias: dias });
  if (error) {
    if (/PGRST202|does not exist|schema cache/i.test(`${error.message || ""} ${error.code || ""}`)) return null;
    throw new Error("Não foi possível carregar os acessos agora.");
  }
  return data;
}

// Novos usuários por dia nos últimos N dias (função admin_novos_usuarios, supabase/painel_novos_usuarios.sql). O gráfico do
// painel mostra 14, 30 e 365 dias; o app busca 365 uma vez e recorta os 30 dias dela. Devolve null se o SQL ainda não foi rodado.
export async function fetchAdminNovosUsuarios(supabase, dias = 365) {
  const { data, error } = await supabase.rpc("admin_novos_usuarios", { p_dias: dias });
  if (error) {
    if (/PGRST202|does not exist|schema cache/i.test(`${error.message || ""} ${error.code || ""}`)) return null;
    throw new Error("Não foi possível carregar os novos usuários agora.");
  }
  return data;
}

// Aba Acessos > "De onde vêm" > Links de convite (função admin_acessos_convites, supabase/acessos_convites.sql): por pessoa que
// convidou, as visitas que abriram o link dela e as contas criadas por ele. dias = 1, 7, 30 ou 90. Devolve null se o SQL ainda não foi rodado.
export async function fetchAdminAcessosConvites(supabase, dias) {
  const { data, error } = await supabase.rpc("admin_acessos_convites", { p_dias: dias });
  if (error) {
    if (/PGRST202|does not exist|schema cache/i.test(`${error.message || ""} ${error.code || ""}`)) return null;
    throw new Error("Não foi possível carregar os links de convite agora.");
  }
  return data;
}

// Aba Tempo de uso (função admin_tempo_uso, supabase/painel_tempo_uso.sql): tempo de uso ESTIMADO pelas ações registradas (o app não
// mede o tempo de tela), com a média por usuário (hoje, mês e ano), o gráfico mensal e os usuários com mais uso.
// Devolve null se o SQL ainda não foi rodado.
export async function fetchAdminTempoUso(supabase) {
  const { data, error } = await supabase.rpc("admin_tempo_uso");
  if (error) {
    if (/PGRST202|does not exist|schema cache/i.test(`${error.message || ""} ${error.code || ""}`)) return null;
    throw new Error("Não foi possível carregar o tempo de uso agora.");
  }
  return data;
}

// Aba Assinantes (função admin_compras_resumo, supabase/painel_compras.sql): compras e receita nas últimas 24 h, 72 h, 30 dias,
// 365 dias e no total. Devolve null se o SQL ainda não foi rodado.
export async function fetchAdminComprasResumo(supabase) {
  const { data, error } = await supabase.rpc("admin_compras_resumo");
  if (error) {
    if (/PGRST202|does not exist|schema cache/i.test(`${error.message || ""} ${error.code || ""}`)) return null;
    throw new Error("Não foi possível carregar as compras agora.");
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

// Aba Comissão (função admin_comissoes, supabase/painel_comissao.sql): resumo geral do convite por pontos e o resumo de cada
// pessoa que convidou. Devolve null se o SQL ainda não foi rodado.
export async function fetchAdminComissoes(supabase) {
  const { data, error } = await supabase.rpc("admin_comissoes");
  if (error) {
    const msg = `${error.message || ""} ${error.code || ""}`;
    if (/PGRST202|does not exist|schema cache/i.test(msg)) return null;
    if (/forbidden/i.test(msg)) throw new Error("Esta conta não tem acesso ao painel.");
    throw new Error("Não foi possível carregar a comissão agora.");
  }
  return data;
}
