import { NextResponse } from "next/server";
import { createClient } from "@/lib/supabase/server";

// Troca um link de uso único (redefinição de senha ou entrada após o pagamento) por uma sessão.
export async function GET(request) {
  const { searchParams, origin } = new URL(request.url);
  const tokenHash = searchParams.get("token_hash");
  const type = searchParams.get("type");
  // Só caminhos do próprio site: nunca um endereço de fora.
  const rawNext = searchParams.get("next") || "/";
  const next = rawNext.startsWith("/") && !rawNext.startsWith("//") ? rawNext : "/";

  if (tokenHash && type) {
    const supabase = await createClient();
    const { error } = await supabase.auth.verifyOtp({ type, token_hash: tokenHash });
    if (!error) {
      return NextResponse.redirect(`${origin}${next}`);
    }
  }

  // Link de entrada do pagamento que já foi usado ou venceu: a pessoa entra com e-mail e senha, e a
  // tela de login avisa que o pagamento foi recebido.
  const pagamento = /[?&]pagamento=(ok|pendente)\b/.exec(next)?.[1];
  if (pagamento) return NextResponse.redirect(`${origin}/login?pagamento=${pagamento}`);

  return NextResponse.redirect(`${origin}/login?error=link_invalido`);
}
