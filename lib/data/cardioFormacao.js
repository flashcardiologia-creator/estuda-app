// Perguntas do cadastro sobre a formação: qual prova a pessoa vai prestar, a especialidade (R+) e a instituição.
// As respostas viajam no cadastro (metadata do signUp) e o banco grava em public.user_goals (supabase/user_goals.sql).

export const EXAMS = [
  { value: "TEC", label: "TEC", hint: "Título de Especialista em Cardiologia" },
  { value: "R+", label: "R+" },
  { value: "AMBOS", label: "Ambos" },
];

// R+ e Ambos abrem a pergunta da especialidade.
export const wantsSpecialty = (exam) => exam === "R+" || exam === "AMBOS";

export const SPECIALTIES = [
  { value: "eletrofisiologia", label: "Eletrofisiologia" },
  { value: "hemodinamica", label: "Hemodinâmica" },
  { value: "ecocardiografia", label: "Ecocardiografia" },
  { value: "transplante", label: "Transplante" },
  { value: "cardioesporte", label: "Cardiologia do Esporte" },
  { value: "cardio_oncologia", label: "Cardio-oncologia" },
  { value: "cardiointensiva", label: "Cardiointensiva" },
  { value: "cardiogeriatria", label: "Cardiogeriatria" },
  { value: "outra", label: "Outra" },
];

export const MAX_INSTITUTION_LEN = 120;

// Instituições com residência ou especialização (estágio) em cardiologia no Brasil: [nome, cidade, UF].
// ATENÇÃO: lista inicial, montada de memória com os principais serviços de formação em cardiologia (universitários, hospitais
// de referência e serviços de residência e estágio). NÃO foi conferida com a base oficial do MEC (SisCNRM) nem com a lista de
// serviços credenciados da SBC, porque este ambiente não alcançou esses sites. Quem não achar a sua digita o nome (o campo
// aceita texto livre) e o banco guarda se veio da lista ou não (user_goals.institution_listed), para a gente ver o que falta.
// Para corrigir ou ampliar a lista basta editar este arquivo: a busca e a gravação não dependem de mais nada.
export const INSTITUTIONS = [
  // São Paulo
  ["Instituto do Coração (InCor) – HC-FMUSP", "São Paulo", "SP"],
  ["Instituto Dante Pazzanese de Cardiologia", "São Paulo", "SP"],
  ["Hospital São Paulo – Unifesp (EPM)", "São Paulo", "SP"],
  ["Irmandade da Santa Casa de São Paulo (FCMSCSP)", "São Paulo", "SP"],
  ["Hospital do Servidor Público Estadual (IAMSPE)", "São Paulo", "SP"],
  ["Hospital Beneficência Portuguesa de São Paulo", "São Paulo", "SP"],
  ["Hospital Israelita Albert Einstein", "São Paulo", "SP"],
  ["Hospital Sírio-Libanês", "São Paulo", "SP"],
  ["Hospital do Coração (HCor)", "São Paulo", "SP"],
  ["Hospital Alemão Oswaldo Cruz", "São Paulo", "SP"],
  ["Hospital das Clínicas de Ribeirão Preto – FMRP-USP", "Ribeirão Preto", "SP"],
  ["Hospital de Clínicas da Unicamp", "Campinas", "SP"],
  ["Hospital das Clínicas de Botucatu – Unesp", "Botucatu", "SP"],
  ["Hospital de Base de São José do Rio Preto – FAMERP", "São José do Rio Preto", "SP"],
  ["Faculdade de Medicina de Marília (Famema)", "Marília", "SP"],
  ["Faculdade de Medicina do ABC (FMABC)", "Santo André", "SP"],
  // Rio de Janeiro
  ["Instituto Nacional de Cardiologia (INC)", "Rio de Janeiro", "RJ"],
  ["Instituto Estadual de Cardiologia Aloysio de Castro (IECAC)", "Rio de Janeiro", "RJ"],
  ["Hospital Universitário Clementino Fraga Filho – UFRJ", "Rio de Janeiro", "RJ"],
  ["Hospital Universitário Pedro Ernesto – UERJ", "Rio de Janeiro", "RJ"],
  ["Hospital Universitário Gaffrée e Guinle – UNIRIO", "Rio de Janeiro", "RJ"],
  ["Hospital Universitário Antônio Pedro – UFF", "Niterói", "RJ"],
  ["Hospital Federal dos Servidores do Estado", "Rio de Janeiro", "RJ"],
  ["Hospital Federal de Bonsucesso", "Rio de Janeiro", "RJ"],
  ["Hospital Naval Marcílio Dias", "Rio de Janeiro", "RJ"],
  ["Hospital Central do Exército", "Rio de Janeiro", "RJ"],
  ["Hospital Pró-Cardíaco", "Rio de Janeiro", "RJ"],
  ["Hospital Barra D'Or", "Rio de Janeiro", "RJ"],
  ["Santa Casa da Misericórdia do Rio de Janeiro", "Rio de Janeiro", "RJ"],
  // Minas Gerais
  ["Hospital das Clínicas da UFMG", "Belo Horizonte", "MG"],
  ["Santa Casa de Belo Horizonte", "Belo Horizonte", "MG"],
  ["Hospital Felício Rocho", "Belo Horizonte", "MG"],
  ["Hospital Biocor", "Nova Lima", "MG"],
  ["Hospital Universitário da UFJF", "Juiz de Fora", "MG"],
  ["Hospital das Clínicas da UFTM", "Uberaba", "MG"],
  ["Hospital de Clínicas da UFU", "Uberlândia", "MG"],
  // Espírito Santo
  ["Hospital Universitário Cassiano Antônio Moraes (HUCAM) – UFES", "Vitória", "ES"],
  ["Santa Casa de Misericórdia de Vitória (EMESCAM)", "Vitória", "ES"],
  // Rio Grande do Sul
  ["Instituto de Cardiologia do RS (Fundação Universitária de Cardiologia)", "Porto Alegre", "RS"],
  ["Hospital de Clínicas de Porto Alegre (HCPA)", "Porto Alegre", "RS"],
  ["Hospital São Lucas da PUCRS", "Porto Alegre", "RS"],
  ["Santa Casa de Misericórdia de Porto Alegre (ISCMPA)", "Porto Alegre", "RS"],
  ["Hospital Moinhos de Vento", "Porto Alegre", "RS"],
  ["Hospital Universitário de Santa Maria – UFSM", "Santa Maria", "RS"],
  // Paraná
  ["Hospital de Clínicas da UFPR", "Curitiba", "PR"],
  ["Hospital Universitário Evangélico Mackenzie", "Curitiba", "PR"],
  ["Hospital Universitário Cajuru – PUCPR", "Curitiba", "PR"],
  ["Hospital Santa Casa de Curitiba", "Curitiba", "PR"],
  ["Hospital Universitário de Londrina – UEL", "Londrina", "PR"],
  ["Hospital Universitário Regional de Maringá – UEM", "Maringá", "PR"],
  // Santa Catarina
  ["Instituto de Cardiologia de Santa Catarina", "São José", "SC"],
  ["Hospital Universitário Polydoro Ernani de São Thiago – UFSC", "Florianópolis", "SC"],
  ["Hospital Governador Celso Ramos", "Florianópolis", "SC"],
  // Distrito Federal
  ["Instituto de Cardiologia do Distrito Federal (ICDF)", "Brasília", "DF"],
  ["Hospital de Base do Distrito Federal", "Brasília", "DF"],
  ["Hospital Universitário de Brasília (HUB) – UnB", "Brasília", "DF"],
  ["Hospital das Forças Armadas (HFA)", "Brasília", "DF"],
  // Goiás, Mato Grosso, Mato Grosso do Sul
  ["Hospital das Clínicas da UFG", "Goiânia", "GO"],
  ["Hospital Universitário Júlio Müller – UFMT", "Cuiabá", "MT"],
  ["Hospital Universitário Maria Aparecida Pedrossian – UFMS", "Campo Grande", "MS"],
  ["Santa Casa de Campo Grande", "Campo Grande", "MS"],
  // Bahia
  ["Hospital Universitário Professor Edgard Santos – UFBA", "Salvador", "BA"],
  ["Hospital Ana Nery – UFBA", "Salvador", "BA"],
  ["Hospital Santa Izabel (Santa Casa da Bahia)", "Salvador", "BA"],
  ["Hospital Português da Bahia", "Salvador", "BA"],
  ["Hospital São Rafael", "Salvador", "BA"],
  ["Hospital Cárdio Pulmonar", "Salvador", "BA"],
  // Pernambuco
  ["Pronto Socorro Cardiológico de Pernambuco (PROCAPE) – UPE", "Recife", "PE"],
  ["Hospital das Clínicas da UFPE", "Recife", "PE"],
  ["Instituto de Medicina Integral Professor Fernando Figueira (IMIP)", "Recife", "PE"],
  ["Real Hospital Português de Beneficência", "Recife", "PE"],
  ["Hospital Universitário Oswaldo Cruz – UPE", "Recife", "PE"],
  // Ceará
  ["Hospital de Messejana Dr. Carlos Alberto Studart Gomes", "Fortaleza", "CE"],
  ["Hospital Universitário Walter Cantídio – UFC", "Fortaleza", "CE"],
  ["Hospital Geral de Fortaleza", "Fortaleza", "CE"],
  // Pará, Amazonas
  ["Hospital Universitário João de Barros Barreto – UFPA", "Belém", "PA"],
  ["Hospital Ophir Loyola", "Belém", "PA"],
  ["Fundação Santa Casa de Misericórdia do Pará", "Belém", "PA"],
  ["Hospital Beneficente Portuguesa de Belém", "Belém", "PA"],
  ["Hospital Universitário Getúlio Vargas – UFAM", "Manaus", "AM"],
  ["Fundação Hospital Adriano Jorge", "Manaus", "AM"],
  // Maranhão, Piauí
  ["Hospital Universitário da UFMA", "São Luís", "MA"],
  ["Hospital Getúlio Vargas", "Teresina", "PI"],
  ["Hospital Universitário da UFPI", "Teresina", "PI"],
  // Rio Grande do Norte, Paraíba
  ["Hospital Universitário Onofre Lopes – UFRN", "Natal", "RN"],
  ["Hospital Universitário Lauro Wanderley – UFPB", "João Pessoa", "PB"],
  ["Hospital Universitário Alcides Carneiro – UFCG", "Campina Grande", "PB"],
  // Alagoas, Sergipe
  ["Hospital Universitário Professor Alberto Antunes – UFAL", "Maceió", "AL"],
  ["Santa Casa de Misericórdia de Maceió", "Maceió", "AL"],
  ["Hospital Universitário de Sergipe – UFS", "Aracaju", "SE"],
  ["Hospital de Urgência de Sergipe (HUSE)", "Aracaju", "SE"],
];

// Texto sem acento e em minúsculas, para a busca achar "sao paulo" em "São Paulo".
export const normalizeText = (s) =>
  String(s || "")
    .normalize("NFD")
    .replace(/[̀-ͯ]/g, "")
    .toLowerCase()
    .trim();

// O que fica gravado e aparece na lista: nome, cidade e UF (cidades repetem nomes como "Santa Casa").
export const institutionLabel = ([nome, cidade, uf]) => `${nome} — ${cidade}/${uf}`;

const INDEX = INSTITUTIONS.map((it) => ({ label: institutionLabel(it), haystack: normalizeText(`${it[0]} ${it[1]} ${it[2]}`) }));
const LABELS = new Set(INDEX.map((i) => i.label));

export const isListedInstitution = (text) => LABELS.has(text);

// Todas as palavras digitadas precisam aparecer (em qualquer ordem). Menos de 2 letras: sem sugestões.
export function searchInstitutions(query, limit = 12) {
  const words = normalizeText(query).split(/\s+/).filter(Boolean);
  if (!words.length || normalizeText(query).length < 2) return [];
  const out = [];
  for (const it of INDEX) {
    if (words.every((w) => it.haystack.includes(w))) {
      out.push(it.label);
      if (out.length >= limit) break;
    }
  }
  return out;
}

// Estado vazio das respostas.
export const EMPTY_GOALS = { exam: "", specialty: "", institution: "" };

// Mensagem de erro do que falta responder ("" quando está tudo certo). A instituição é opcional.
export function goalsError(g) {
  if (!g.exam) return "Escolha a prova que você vai prestar.";
  if (wantsSpecialty(g.exam) && !g.specialty) return "Escolha a especialidade do R+.";
  return "";
}

// O que vai junto com o cadastro (options.data do signUp). Só vão os campos que se aplicam à escolha feita.
export function goalsMetadata(g) {
  const institution = String(g.institution || "").trim().slice(0, MAX_INSTITUTION_LEN);
  return {
    prova: g.exam,
    ...(wantsSpecialty(g.exam) && g.specialty ? { especialidade: g.specialty } : {}),
    ...(institution ? { instituicao: institution, instituicao_da_lista: isListedInstitution(institution) } : {}),
  };
}
