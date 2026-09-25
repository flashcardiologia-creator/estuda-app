import { Inter } from "next/font/google";
import "./globals.css";
import { ThemeProvider } from "@/components/theme/ThemeProvider";

const inter = Inter({
  variable: "--font-inter",
  subsets: ["latin"],
  weight: ["400", "500", "600", "700"],
});

export const metadata = {
  title: "FlashCardio",
  description: "Flashcards e questões para estudar todos os dias.",
  appleWebApp: {
    capable: true,
    title: "FlashCardio",
    statusBarStyle: "black-translucent",
  },
};

export const viewport = {
  themeColor: "#050B1E",
};

export default function RootLayout({ children }) {
  return (
    <html lang="pt-BR" className={inter.variable}>
      <body>
        <ThemeProvider>{children}</ThemeProvider>
      </body>
    </html>
  );
}
