"use client";

import { useCallback, useEffect, useRef, useState } from "react";
import { createPortal } from "react-dom";
import { Minus, Plus, Maximize2, X, ZoomIn } from "lucide-react";

// Imagem que abre em tela cheia ao tocar/clicar, com zoom:
//  - celular: pinça com dois dedos, arrastar para mexer na imagem e toque duplo para ampliar/voltar;
//  - computador: roda do mouse (ou pinça do touchpad), botões + e − e duplo clique.
// Esc, o botão X ou um toque no fundo fecham.

const MIN = 1;
const MAX = 8;
const BTN = {
  width: 44,
  height: 44,
  borderRadius: 22,
  border: "1px solid rgba(255,255,255,0.28)",
  background: "rgba(20,24,40,0.78)",
  color: "#fff",
  display: "flex",
  alignItems: "center",
  justifyContent: "center",
  cursor: "pointer",
  padding: 0,
};

function Lightbox({ src, alt, referrerPolicy, onClose }) {
  const stageRef = useRef(null);
  const imgRef = useRef(null);
  const [view, setView] = useState({ s: 1, x: 0, y: 0 });
  const viewRef = useRef(view);
  const pointers = useRef(new Map());
  const gesture = useRef({ moved: false, startDist: 0, startScale: 1, lastTap: 0, tapX: 0, tapY: 0 });

  const commit = useCallback((next) => {
    const stage = stageRef.current;
    const img = imgRef.current;
    let { s, x, y } = next;
    s = Math.min(MAX, Math.max(MIN, s));
    if (stage && img) {
      // A imagem não pode sair da tela: se ela é menor que a janela num eixo, fica centralizada nele.
      const maxX = Math.max(0, (img.offsetWidth * s - stage.clientWidth) / 2);
      const maxY = Math.max(0, (img.offsetHeight * s - stage.clientHeight) / 2);
      x = Math.min(maxX, Math.max(-maxX, x));
      y = Math.min(maxY, Math.max(-maxY, y));
    }
    if (s === MIN) {
      x = 0;
      y = 0;
    }
    viewRef.current = { s, x, y };
    setView(viewRef.current);
  }, []);

  // Muda o zoom mantendo parado o ponto (cx, cy), dado em relação ao centro da janela.
  const zoomAt = useCallback(
    (factor, cx = 0, cy = 0) => {
      const v = viewRef.current;
      const s = Math.min(MAX, Math.max(MIN, v.s * factor));
      const k = s / v.s;
      commit({ s, x: cx - (cx - v.x) * k, y: cy - (cy - v.y) * k });
    },
    [commit]
  );

  const rel = (clientX, clientY) => {
    const r = stageRef.current.getBoundingClientRect();
    return { cx: clientX - (r.left + r.width / 2), cy: clientY - (r.top + r.height / 2) };
  };

  // Trava a rolagem da página atrás e fecha com Esc.
  useEffect(() => {
    const prev = document.body.style.overflow;
    document.body.style.overflow = "hidden";
    const onKey = (e) => {
      if (e.key === "Escape") onClose();
      else if (e.key === "+" || e.key === "=") zoomAt(1.4);
      else if (e.key === "-") zoomAt(1 / 1.4);
      else if (e.key === "0") commit({ s: 1, x: 0, y: 0 });
    };
    window.addEventListener("keydown", onKey);
    return () => {
      document.body.style.overflow = prev;
      window.removeEventListener("keydown", onKey);
    };
  }, [onClose, zoomAt, commit]);

  // A roda do mouse (e a pinça do touchpad) precisa de ouvinte não passivo para não rolar a página.
  useEffect(() => {
    const el = stageRef.current;
    if (!el) return undefined;
    const onWheel = (e) => {
      e.preventDefault();
      const { cx, cy } = rel(e.clientX, e.clientY);
      zoomAt(Math.exp(-e.deltaY * (e.ctrlKey ? 0.01 : 0.0018)), cx, cy);
    };
    el.addEventListener("wheel", onWheel, { passive: false });
    return () => el.removeEventListener("wheel", onWheel);
  }, [zoomAt]);

  const onPointerDown = (e) => {
    stageRef.current.setPointerCapture?.(e.pointerId);
    pointers.current.set(e.pointerId, { x: e.clientX, y: e.clientY });
    const g = gesture.current;
    if (pointers.current.size === 1) {
      g.moved = false;
      g.downX = e.clientX;
      g.downY = e.clientY;
    }
    if (pointers.current.size === 2) {
      const [a, b] = [...pointers.current.values()];
      g.startDist = Math.hypot(a.x - b.x, a.y - b.y) || 1;
      g.startScale = viewRef.current.s;
      g.moved = true;
    }
  };

  const onPointerMove = (e) => {
    const p = pointers.current.get(e.pointerId);
    if (!p) return;
    const g = gesture.current;
    const prev = { ...p };
    p.x = e.clientX;
    p.y = e.clientY;
    const v = viewRef.current;
    if (pointers.current.size >= 2) {
      const other = [...pointers.current.entries()].find(([id]) => id !== e.pointerId)[1];
      const dist = Math.hypot(p.x - other.x, p.y - other.y) || 1;
      const m1 = rel((p.x + other.x) / 2, (p.y + other.y) / 2);
      const m0 = rel((prev.x + other.x) / 2, (prev.y + other.y) / 2);
      const target = Math.min(MAX, Math.max(MIN, g.startScale * (dist / g.startDist)));
      const k = target / v.s;
      // Pinça: o ponto que estava entre os dedos continua entre os dedos, na nova escala.
      commit({ s: target, x: m1.cx - (m0.cx - v.x) * k, y: m1.cy - (m0.cy - v.y) * k });
      return;
    }
    if (Math.hypot(e.clientX - g.downX, e.clientY - g.downY) > 6) g.moved = true;
    if (v.s > 1) commit({ s: v.s, x: v.x + (e.clientX - prev.x), y: v.y + (e.clientY - prev.y) });
  };

  const onPointerUp = (e) => {
    const g = gesture.current;
    const had = pointers.current.has(e.pointerId);
    pointers.current.delete(e.pointerId);
    if (!had) return;
    if (pointers.current.size === 1) {
      // Soltou um dos dois dedos: o que ficou continua arrastando sem pulo.
      const rest = [...pointers.current.values()][0];
      g.downX = rest.x;
      g.downY = rest.y;
      return;
    }
    if (pointers.current.size > 0 || g.moved) return;
    // Toque ou clique sem arrastar.
    const now = e.timeStamp;
    const onImage = e.target === imgRef.current;
    if (now - g.lastTap < 320 && Math.hypot(e.clientX - g.tapX, e.clientY - g.tapY) < 30) {
      g.lastTap = 0;
      const { cx, cy } = rel(e.clientX, e.clientY);
      if (viewRef.current.s > 1.05) commit({ s: 1, x: 0, y: 0 });
      else zoomAt(2.5, cx, cy);
      return;
    }
    g.lastTap = now;
    g.tapX = e.clientX;
    g.tapY = e.clientY;
    if (!onImage) setTimeout(() => (gesture.current.lastTap === now ? onClose() : null), 330);
  };

  const pct = Math.round(view.s * 100);
  return createPortal(
    <div
      data-lightbox
      role="dialog"
      aria-modal="true"
      aria-label="Imagem ampliada"
      // O portal propaga eventos para os componentes de cima (ex.: o cartão que vira ao clicar): aqui eles morrem.
      onClick={(e) => e.stopPropagation()}
      onPointerDown={(e) => e.stopPropagation()}
      style={{ position: "fixed", inset: 0, zIndex: 300, background: "rgba(3,6,16,0.94)", userSelect: "none", WebkitUserSelect: "none" }}
    >
      <div
        ref={stageRef}
        onPointerDown={onPointerDown}
        onPointerMove={onPointerMove}
        onPointerUp={onPointerUp}
        onPointerCancel={onPointerUp}
        style={{ position: "absolute", inset: 0, display: "flex", alignItems: "center", justifyContent: "center", overflow: "hidden", touchAction: "none", cursor: view.s > 1 ? "grab" : "zoom-in" }}
      >
        {/* eslint-disable-next-line @next/next/no-img-element */}
        <img
          ref={imgRef}
          src={src}
          alt={alt}
          referrerPolicy={referrerPolicy}
          draggable={false}
          onLoad={() => commit(viewRef.current)}
          style={{
            maxWidth: "100%",
            maxHeight: "100%",
            objectFit: "contain",
            background: "#fff",
            transform: `translate(${view.x}px, ${view.y}px) scale(${view.s})`,
            transformOrigin: "center center",
            willChange: "transform",
          }}
        />
      </div>

      <button type="button" aria-label="Fechar imagem" onClick={onClose} style={{ ...BTN, position: "absolute", top: "max(14px, env(safe-area-inset-top))", right: 14 }}>
        <X size={22} />
      </button>

      <div
        style={{ position: "absolute", left: "50%", transform: "translateX(-50%)", bottom: "max(18px, env(safe-area-inset-bottom))", display: "flex", alignItems: "center", gap: 8 }}
        onPointerDown={(e) => e.stopPropagation()}
      >
        <button type="button" aria-label="Diminuir zoom" onClick={() => zoomAt(1 / 1.5)} disabled={view.s <= MIN} style={{ ...BTN, opacity: view.s <= MIN ? 0.45 : 1 }}>
          <Minus size={20} />
        </button>
        <span style={{ minWidth: 58, textAlign: "center", color: "#fff", fontSize: 13, fontWeight: 700, fontVariantNumeric: "tabular-nums" }}>{pct}%</span>
        <button type="button" aria-label="Aumentar zoom" onClick={() => zoomAt(1.5)} disabled={view.s >= MAX} style={{ ...BTN, opacity: view.s >= MAX ? 0.45 : 1 }}>
          <Plus size={20} />
        </button>
        <button type="button" aria-label="Ajustar à tela" title="Ajustar à tela" onClick={() => commit({ s: 1, x: 0, y: 0 })} disabled={view.s === MIN} style={{ ...BTN, opacity: view.s === MIN ? 0.45 : 1 }}>
          <Maximize2 size={18} />
        </button>
      </div>
    </div>,
    document.body
  );
}

// Use no lugar do <img>. style e wrapStyle seguem como no <img> original; o clique/toque abre a imagem ampliada.
export function ZoomableImage({ src, alt = "", style, wrapStyle, loading, referrerPolicy, onError, hint = true }) {
  const [open, setOpen] = useState(false);
  const close = useCallback(() => setOpen(false), []);
  return (
    <>
      <span style={{ position: "relative", display: "block", width: "fit-content", maxWidth: "100%", ...wrapStyle }}>
        {/* eslint-disable-next-line @next/next/no-img-element */}
        <img
          src={src}
          alt={alt}
          loading={loading}
          referrerPolicy={referrerPolicy}
          onError={onError}
          draggable={false}
          onClick={(e) => {
            e.stopPropagation();
            setOpen(true);
          }}
          style={{ ...style, cursor: "zoom-in" }}
        />
        {hint && (
          <span
            aria-hidden="true"
            style={{ position: "absolute", right: 8, bottom: 8, width: 28, height: 28, borderRadius: 14, background: "rgba(20,24,40,0.72)", color: "#fff", display: "flex", alignItems: "center", justifyContent: "center", pointerEvents: "none" }}
          >
            <ZoomIn size={15} />
          </span>
        )}
      </span>
      {open && <Lightbox src={src} alt={alt} referrerPolicy={referrerPolicy} onClose={close} />}
    </>
  );
}
