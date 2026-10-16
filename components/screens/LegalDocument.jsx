"use client";

import Link from "next/link";
import { useRouter } from "next/navigation";
import { ArrowLeft } from "lucide-react";
import { useT } from "@/components/theme/ThemeProvider";
import { LEGAL_UPDATED } from "@/lib/legal/content";

function Block({ block, t }) {
  if (typeof block === "string") {
    return <p style={{ margin: "0 0 12px", fontSize: 14.5, lineHeight: 1.65, color: t.text }}>{block}</p>;
  }
  if (block.sub) {
    return <p style={{ margin: "18px 0 8px", fontSize: 14.5, fontWeight: 700, color: t.text }}>{block.sub}</p>;
  }
  if (block.list) {
    return (
      <ul style={{ margin: "0 0 12px", paddingLeft: 22, display: "flex", flexDirection: "column", gap: 6 }}>
        {block.list.map((item, i) => (
          <li key={i} style={{ fontSize: 14.5, lineHeight: 1.6, color: t.text }}>
            {item}
          </li>
        ))}
      </ul>
    );
  }
  if (block.table) {
    const cell = { padding: "9px 10px", textAlign: "left", verticalAlign: "top", borderBottom: `1px solid ${t.border}`, fontSize: 13.5, lineHeight: 1.5 };
    return (
      <div style={{ overflowX: "auto", margin: "0 0 12px" }}>
        <table style={{ borderCollapse: "collapse", width: "100%", minWidth: 480, color: t.text }}>
          <thead>
            <tr>
              {block.table.head.map((h) => (
                <th key={h} style={{ ...cell, fontWeight: 700, color: t.textMuted }}>
                  {h}
                </th>
              ))}
            </tr>
          </thead>
          <tbody>
            {block.table.rows.map((row, i) => (
              <tr key={i}>
                {row.map((c, j) => (
                  <td key={j} style={cell}>
                    {c}
                  </td>
                ))}
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    );
  }
  return null;
}

// As seções de um texto jurídico (usado na página pública e na janela do cadastro).
export function LegalSections({ doc }) {
  const t = useT();
  return doc.sections.map((s) => (
    <section key={s.title} style={{ marginBottom: 22 }}>
      <h2 style={{ fontSize: 17, fontWeight: 700, color: t.text, margin: "0 0 10px" }}>{s.title}</h2>
      {s.blocks.map((b, i) => (
        <Block key={i} block={b} t={t} />
      ))}
    </section>
  ));
}

// Página pública (sem login) com um dos textos jurídicos.
export function LegalDocument({ doc, other }) {
  const t = useT();
  const router = useRouter();
  // Volta para a página de onde a pessoa veio; se abriu esta página direto, vai para o login.
  const voltar = () => {
    if (window.history.length > 1) router.back();
    else router.push("/login");
  };
  return (
    <div style={{ minHeight: "100dvh", background: t.bg, padding: "20px 18px 60px", boxSizing: "border-box" }}>
      <div style={{ maxWidth: 720, margin: "0 auto" }}>
        <button
          type="button"
          onClick={voltar}
          style={{ display: "inline-flex", alignItems: "center", gap: 6, background: "transparent", border: "none", cursor: "pointer", color: t.primary, fontSize: 13.5, fontWeight: 600, padding: "6px 0" }}
        >
          <ArrowLeft size={16} /> Voltar
        </button>
        <h1 style={{ fontSize: 24, fontWeight: 700, color: t.text, margin: "14px 0 4px" }}>{doc.title}</h1>
        <p style={{ margin: "0 0 22px", fontSize: 13, color: t.textMuted }}>Última atualização: {LEGAL_UPDATED}</p>
        <LegalSections doc={doc} />
        <div style={{ borderTop: `1px solid ${t.border}`, paddingTop: 14, marginTop: 28 }}>
          <Link href={other.href} style={{ color: t.primary, fontSize: 13.5, fontWeight: 600, textDecoration: "none" }}>
            {other.label}
          </Link>
        </div>
      </div>
    </div>
  );
}
