import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { EstudaApp } from "@/components/EstudaApp";

export default async function Page() {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();

  if (!user) redirect("/login");

  return <EstudaApp userId={user.id} userEmail={user.email} />;
}
