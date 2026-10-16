import { LegalDocument } from "@/components/screens/LegalDocument";
import { PRIVACY } from "@/lib/legal/content";

export const metadata = { title: "Política de Privacidade · FlashCardio" };

export default function PrivacidadePage() {
  return <LegalDocument doc={PRIVACY} other={{ href: "/termos", label: "Ler os Termos de Uso" }} />;
}
