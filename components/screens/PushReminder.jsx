"use client";

import { useEffect, useState } from "react";
import { useT } from "@/components/theme/ThemeProvider";
import { Toggle } from "@/components/ui/Primitives";
import { disablePush, enablePush, isPushSubscribed, pushSupport, sendTestReminder } from "@/lib/push";

// Permissões > lembrete da missão diária por notificação (10h e 22h, se a missão ainda não foi feita).
export function PushReminder({ supabase, userId }) {
  const t = useT();
  const [support] = useState(() => pushSupport());
  const [on, setOn] = useState(false);
  const [busy, setBusy] = useState(false);
  const [message, setMessage] = useState("");
  const [testing, setTesting] = useState(false);
  const [testResult, setTestResult] = useState(null);

  useEffect(() => {
    let cancelled = false;
    isPushSubscribed()
      .then((v) => !cancelled && setOn(v))
      .catch(() => {});
    return () => {
      cancelled = true;
    };
  }, []);

  const change = async (next) => {
    setBusy(true);
    setMessage("");
    try {
      if (next) {
        await enablePush(supabase, userId);
        setOn(true);
      } else {
        await disablePush(supabase, userId);
        setOn(false);
      }
    } catch (err) {
      setOn(false);
      setMessage(
        err.message === "denied"
          ? "As notificações estão bloqueadas neste aparelho. Libere nas configurações do navegador ou do aplicativo e tente de novo."
          : "Não foi possível ativar agora. Tente novamente."
      );
    } finally {
      setBusy(false);
    }
  };

  const runTest = async () => {
    setTesting(true);
    setTestResult(null);
    try {
      const r = await sendTestReminder();
      setTestResult({ ok: true, text: `Lembrete enviado para ${r.sent} aparelho(s). Ele deve chegar em instantes.` });
    } catch (err) {
      setTestResult({ ok: false, text: err.message });
    } finally {
      setTesting(false);
    }
  };

  let sub = "Aviso às 10h e às 22h, com o tempo que falta, se você ainda não fez a missão diária";
  if (busy) sub = "Salvando…";
  else if (support === "ios-install") sub = "No iPhone, adicione o FlashCardio à tela inicial (Baixar aplicativo, na tela de login) e abra por ele para ativar";
  else if (support === "unsupported") sub = "Este navegador não permite notificações";

  return (
    <div
      style={{
        padding: "12px 14px",
        borderRadius: 12,
        background: t.surfaceAlt,
        border: `1px solid ${t.border}`,
        marginBottom: 12,
      }}
    >
      <Toggle
        checked={on}
        onChange={(v) => !busy && support === "ok" && change(v)}
        label="Lembrete da missão diária"
        labelStyle={{ fontSize: 13.5, color: t.text, fontWeight: 700 }}
        sub={sub}
        style={{ padding: 0, opacity: support === "ok" ? 1 : 0.6 }}
      />
      {on && (
        <button
          onClick={runTest}
          disabled={testing}
          style={{ marginTop: 10, background: "transparent", border: "none", padding: 0, color: t.primary, fontSize: 13, fontWeight: 600, cursor: "pointer" }}
        >
          {testing ? "Enviando…" : "Enviar um lembrete de teste agora"}
        </button>
      )}
      {testResult && <div style={{ fontSize: 12.5, color: testResult.ok ? t.green : t.red, marginTop: 8, lineHeight: 1.5 }}>{testResult.text}</div>}
      {message && <div style={{ fontSize: 12.5, color: t.red, marginTop: 8, lineHeight: 1.5 }}>{message}</div>}
    </div>
  );
}
