import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { EstudaApp } from "@/components/EstudaApp";
import { TermsGate } from "@/components/screens/TermsGate";
import { LEGAL_VERSION, TERMS_GATE_ENABLED } from "@/lib/legal/content";
import { OPEN_ACCESS, parseAccess } from "@/lib/access";

export default async function Page({ searchParams }) {
  const { pagamento, prolongar } = await searchParams;
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();

  if (!user) redirect("/login");

  if (TERMS_GATE_ENABLED) {
    // Cada pessoa só enxerga os próprios registros (RLS). Se a consulta falhar (por exemplo, a
    // tabela ainda não existe), não bloqueamos o app.
    const { data: accepted, error } = await supabase
      .from("terms_acceptances")
      .select("id")
      .eq("user_id", user.id)
      .eq("terms_version", LEGAL_VERSION)
      .limit(1);
    if (!error && accepted.length === 0) {
      const { count } = await supabase.from("terms_acceptances").select("id", { count: "exact", head: true }).eq("user_id", user.id);
      return <TermsGate returning={(count ?? 0) > 0} />;
    }
  }

  // Situação da assinatura. Se a consulta falhar (por exemplo, o SQL ainda não foi rodado),
  // o app abre liberado em vez de travar todo mundo.
  const { data: accessRows, error: accessError } = await supabase.rpc("my_access");
  if (accessError) console.error("[acesso] my_access falhou:", accessError.message);
  const access = accessError ? OPEN_ACCESS : parseAccess(accessRows?.[0]);

  return <EstudaApp userId={user.id} userEmail={user.email} access={access} paymentReturn={typeof pagamento === "string" ? pagamento : null}
      openPlans={prolongar === "1"}
    />;
}
