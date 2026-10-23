"use client";

import { useMemo, useState } from "react";
import { BookOpen, Hash, Plus, RotateCw, Settings, Shuffle, Trash2, UserCog } from "lucide-react";
import { CreateFlashcardModal, TrashModal } from "@/components/screens/FlashcardPersonalModals";
import { useT } from "@/components/theme/ThemeProvider";
import { ScreenHeader, ExpandBox, Chip, Toggle, PrimaryButton, DropdownList, DROPDOWN_ALL } from "@/components/ui/Primitives";

const QTD_OPTIONS = [5, 10, 15, 20, 25, 50, "Todos"];
const TAMANHO_OPTIONS = [
  { value: "sm", label: "Pequena" },
  { value: "md", label: "Média" },
  { value: "lg", label: "Grande" },
];

export function FlashcardsSelectScreen({
  themeCounts,
  favoriteCounts = {},
  tamanho,
  onSetTamanho,
  onStart,
  onNavigate,
  hasSavedFlashSession,
  onContinueFlashcards,
  onCreateCustom,
  onLoadTrash,
  onRestore,
  onDeleteForever,
}) {
  const t = useT();
  const [showCreate, setShowCreate] = useState(false);
  const [showTrash, setShowTrash] = useState(false);
  const temas = useMemo(() => Object.keys(themeCounts).sort(), [themeCounts]);
  const [tema, setTema] = useState(null);
  const [qtd, setQtd] = useState("Todos");
  const [aleatorio, setAleatorio] = useState(false);
  const [favoritasOnly, setFavoritasOnly] = useState(false);
  const [open, setOpen] = useState({});
  const toggle = (k) => setOpen((o) => ({ ...o, [k]: !o[k] }));

  const totalFavorites = useMemo(() => Object.values(favoriteCounts).reduce((sum, n) => sum + n, 0), [favoriteCounts]);
  const countFor = (temaKey) => (favoritasOnly ? favoriteCounts[temaKey] || 0 : themeCounts[temaKey] || 0);
  const totalCount = favoritasOnly ? totalFavorites : Object.values(themeCounts).reduce((sum, n) => sum + n, 0);
  const availableCount = !tema ? 0 : tema === DROPDOWN_ALL ? totalCount : countFor(tema);
  const sessionCount = tema ? Math.min(qtd === "Todos" ? availableCount : qtd, availableCount) : 0;

  return (
    <div style={{ maxWidth: 640, margin: "0 auto", paddingBottom: 90 }}>
      <ScreenHeader title="Flashcards" onBack={() => onNavigate("home")} />
      <div style={{ padding: "18px 22px" }}>
        <ExpandBox title="Tema" icon={<BookOpen size={17} color={t.primary} />} open={open.tema} onToggle={() => toggle("tema")}>
          <DropdownList options={temas} selected={tema} onChange={setTema} allLabel="Todos" />
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

        <ExpandBox title="Aleatorizar" icon={<Shuffle size={17} color={t.primary} />} open={open.aleatorio} onToggle={() => toggle("aleatorio")}>
          <Toggle checked={aleatorio} onChange={setAleatorio} sub="Embaralha os cartões antes de iniciar" />
        </ExpandBox>

        <ExpandBox title="Configurações" icon={<Settings size={17} color={t.primary} />} open={open.config} onToggle={() => toggle("config")}>
          <Toggle
            checked={favoritasOnly}
            onChange={setFavoritasOnly}
            label="Somente flashcards favoritados"
            sub={`${totalFavorites} marcados`}
          />
          <div style={{ marginTop: 14, display: "flex", alignItems: "center", flexWrap: "wrap", gap: "8px 12px" }}>
            <span style={{ fontSize: 13, color: t.text, fontWeight: 600, whiteSpace: "nowrap" }}>Tamanho da letra</span>
            <div style={{ display: "flex", gap: 8 }}>
              {TAMANHO_OPTIONS.map((o) => (
                <Chip key={o.value} active={tamanho === o.value} onClick={() => onSetTamanho(o.value)}>
                  {o.label}
                </Chip>
              ))}
            </div>
          </div>
        </ExpandBox>

        <ExpandBox title="Personalizado" icon={<UserCog size={17} color={t.primary} />} open={open.personal} onToggle={() => toggle("personal")}>
          <div style={{ fontSize: 12, color: t.textMuted, marginBottom: 12, lineHeight: 1.5 }}>
            Os flashcards que você cria e os que manda para a lixeira valem só para a sua conta.
          </div>
          <div style={{ display: "flex", flexDirection: "column", gap: 10 }}>
            <PrimaryButton full onClick={() => setShowCreate(true)}>
              <Plus size={14} style={{ marginRight: 6, verticalAlign: -2 }} />
              Criar Flashcards
            </PrimaryButton>
            <PrimaryButton full variant="ghost" color={t.name === "light" ? t.surface : undefined} onClick={() => setShowTrash(true)}>
              <Trash2 size={14} style={{ marginRight: 6, verticalAlign: -2 }} />
              Lixeira
            </PrimaryButton>
          </div>
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
          <PrimaryButton full disabled={!tema || sessionCount === 0} onClick={() => onStart(tema, qtd, aleatorio, tamanho, favoritasOnly)}>
            Iniciar Flashcards
          </PrimaryButton>
        </div>
      </div>

      {showCreate && <CreateFlashcardModal temas={temas} onCreate={onCreateCustom} onClose={() => setShowCreate(false)} />}
      {showTrash && <TrashModal onLoad={onLoadTrash} onRestore={onRestore} onDeleteForever={onDeleteForever} onClose={() => setShowTrash(false)} />}
    </div>
  );
}
