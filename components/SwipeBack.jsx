"use client";

import { useEffect } from "react";

// Voltar arrastando a tela para o lado, como em vários aplicativos: o dedo começa na borda esquerda
// e puxa para a direita. Em vez de duplicar a lógica de cada tela, o gesto aciona o botão "Voltar"
// que a própria tela já mostra (assim valem as mesmas regras, como a confirmação ao sair de uma sessão).
// Telas sem botão Voltar (o início) ignoram o gesto. Com uma janela (modal) aberta, também não faz nada.

const EDGE = 24; // o toque precisa começar a até 24 px da borda esquerda
const MIN_DRAG = 10; // arrasto mínimo antes de decidir se é um gesto horizontal

function findBackButton() {
  const found = [...document.querySelectorAll("button")].filter(
    (b) => !b.disabled && b.textContent.trim() === "Voltar" && b.getClientRects().length > 0
  );
  // Se houver mais de um (ex.: uma janela por cima da tela), vale o último, que é o de cima.
  return found.length ? found[found.length - 1] : null;
}

export function SwipeBack({ rootId }) {
  useEffect(() => {
    const reduced = window.matchMedia?.("(prefers-reduced-motion: reduce)").matches;
    let drag = null;

    const root = () => document.getElementById(rootId);
    const setX = (x, animate) => {
      const el = root();
      if (!el) return;
      el.style.transition = animate ? "transform .18s ease-out" : "none";
      el.style.transform = x ? `translateX(${x}px)` : "";
    };
    const clearRoot = () => {
      const el = root();
      if (!el) return;
      el.style.transition = "";
      el.style.transform = "";
    };

    const stop = () => {
      document.removeEventListener("touchmove", onMove);
      document.removeEventListener("touchend", onEnd);
      document.removeEventListener("touchcancel", onCancel);
      drag = null;
    };

    function onMove(e) {
      if (!drag) return;
      const t = e.touches[0];
      const dx = t.clientX - drag.x0;
      const dy = t.clientY - drag.y0;
      if (!drag.engaged) {
        if (Math.abs(dy) > MIN_DRAG && Math.abs(dy) > Math.abs(dx)) {
          stop();
          return;
        }
        if (dx > MIN_DRAG && dx > Math.abs(dy) * 1.5) drag.engaged = true;
        else return;
      }
      e.preventDefault();
      drag.dx = Math.max(0, dx);
      drag.last = { x: t.clientX, t: e.timeStamp, prevX: drag.last?.x ?? t.clientX, prevT: drag.last?.t ?? e.timeStamp };
      if (!reduced) setX(drag.dx, false);
    }

    function onEnd(e) {
      const d = drag;
      stop();
      if (!d || !d.engaged) return;
      const width = window.innerWidth;
      const dt = Math.max(1, (d.last?.t ?? 0) - (d.last?.prevT ?? 0));
      const speed = ((d.last?.x ?? 0) - (d.last?.prevX ?? 0)) / dt; // px por ms
      const go = d.dx > Math.min(110, width * 0.28) || speed > 0.6;
      if (!go) {
        setX(0, !reduced);
        setTimeout(clearRoot, 220);
        return;
      }
      const back = findBackButton();
      const finish = () => {
        clearRoot();
        back?.click();
      };
      if (reduced) finish();
      else {
        setX(width, true);
        setTimeout(finish, 170);
      }
    }

    function onCancel() {
      stop();
      setX(0, !reduced);
      setTimeout(clearRoot, 220);
    }

    function onStart(e) {
      if (e.touches.length !== 1) return;
      const t = e.touches[0];
      if (t.clientX > EDGE) return;
      if (document.querySelector(".modal-overlay")) return;
      if (!findBackButton()) return;
      drag = { x0: t.clientX, y0: t.clientY, dx: 0, engaged: false, last: null };
      // O ouvinte de movimento só existe durante um toque que começou na borda, para não atrapalhar a rolagem.
      document.addEventListener("touchmove", onMove, { passive: false });
      document.addEventListener("touchend", onEnd);
      document.addEventListener("touchcancel", onCancel);
    }

    document.addEventListener("touchstart", onStart, { passive: true });
    return () => {
      document.removeEventListener("touchstart", onStart);
      stop();
      clearRoot();
    };
  }, [rootId]);

  return null;
}
