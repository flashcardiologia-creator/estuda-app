import { LegalDocument } from "@/components/screens/LegalDocument";
import { TERMS } from "@/lib/legal/content";

export const metadata = { title: "Termos de Uso · FlashCardio" };

export default function TermosPage() {
  return <LegalDocument doc={TERMS} other={{ href: "/privacidade", label: "Ler a Política de Privacidade" }} />;
}
