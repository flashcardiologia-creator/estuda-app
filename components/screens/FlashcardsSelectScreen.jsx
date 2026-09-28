"use client";

import { useMemo, useState } from "react";
import { BookOpen, Hash, RotateCw, Shuffle, Type } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { ScreenHeader, ExpandBox, Chip, Toggle, PrimaryButton } from "@/components/ui/Primitives";

const QTD_OPTIONS = [5, 10, 15, 20, 25, 50, "Todos"];
const TAMANHO_OPTIONS = [
  { value: "sm", label: "Pequeno" },
  { value: "md", label: "Médio" },
  { value: "lg", label: "Grande" },
];

export function FlashcardsSelectScreen({
  themeCounts,
  tamanho,
  onSetTamanho,
  onStart,
  onNavigate,
  hasSavedFlashSession,
  onContinueFlashcards,
}) {
  const t = useT();
  const temas = useMemo(() => Object.keys(themeCounts).sort(), [themeCounts]);
  const [tema, setTema] = useState(null);
  const [qtd, setQtd] = useState("Todos");
  const [aleatorio, setAleatorio] = useState(false);
  const [open, setOpen] = useState({});
  const toggle = (k) => setOpen((o) => ({ ...o, [k]: !o[k] }));

  const availableCount = tema ? themeCounts[tema] || 0 : 0;
  const sessionCount = tema ? Math.min(qtd === "Todos" ? availableCount : qtd, availableCount) : 0;

  return (
    <div style={{ maxWidth: 640, margin: "0 auto", paddingBottom: 90 }}>
      <ScreenHeader title="Flashcards" onBack={() => onNavigate("home")} />
      <div style={{ padding: "18px 22px" }}>
        <ExpandBox title="Tema" icon={<BookOpen size={17} color={t.primary} />} open={open.tema} onToggle={() => toggle("tema")}>
          <div style={{ display: "flex", flexWrap: "wrap", gap: 8 }}>
            {temas.map((tm) => (
              <Chip key={tm} active={tema === tm} onClick={() => setTema(tm)}>
                {tm}
              </Chip>
            ))}
          </div>
        </ExpandBox>

        <ExpandBox title="Quantidade" icon={<Hash size={17} color={t.primary} />} open={open.qtd} onToggle={() => toggle("qtd")}>
          <div style={{ display: "flex", flexWrap: "wrap", gap: 8 }}>
            {QTD_OPTIONS.map((o) => (
              <Chip key={o} active={qtd === o} onClick={() => setQtd(o)}>
                {o}
              </Chip>
            ))}
          </div>
        </ExpandBox>

        <ExpandBox
          title="Tamanho dos Flashcards"
          icon={<Type size={17} color={t.primary} />}
          open={open.tamanho}
          onToggle={() => toggle("tamanho")}
        >
          <div style={{ display: "flex", gap: 8 }}>
            {TAMANHO_OPTIONS.map((o) => (
              <Chip key={o.value} active={tamanho === o.value} onClick={() => onSetTamanho(o.value)}>
                {o.label}
              </Chip>
            ))}
          </div>
        </ExpandBox>

        <ExpandBox title="Aleatorizar" icon={<Shuffle size={17} color={t.primary} />} open={open.aleatorio} onToggle={() => toggle("aleatorio")}>
          <Toggle checked={aleatorio} onChange={setAleatorio} sub="Embaralha os cartões antes de iniciar" />
        </ExpandBox>

        <div style={{ marginTop: 20, display: "flex", flexDirection: "column", gap: 10 }}>
          <div style={{ fontSize: 12.5, color: t.textMuted, textAlign: "center" }}>
            {tema ? `${sessionCount} cartões nesta sessão` : "Selecione um tema"}
          </div>
          {hasSavedFlashSession && (
            <PrimaryButton full variant="ghost" color={t.name === "light" ? t.surface : undefined} onClick={onContinueFlashcards}>
              <RotateCw size={14} style={{ marginRight: 6, verticalAlign: -2 }} />
              Continuar Sessão
            </PrimaryButton>
          )}
          <PrimaryButton full disabled={!tema} onClick={() => onStart(tema, qtd, aleatorio, tamanho)}>
            Iniciar Flashcards
          </PrimaryButton>
        </div>
      </div>
    </div>
  );
}
