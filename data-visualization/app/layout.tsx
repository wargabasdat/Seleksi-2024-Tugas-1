import { Inter } from "next/font/google";
import "./globals.css";
import BodyLayout from "./client-layout";

const inter = Inter({
  subsets: ["latin"],
  display: "swap",
  variable: "--font-inter",
});

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en" className={inter.variable}>
      <BodyLayout>{children}</BodyLayout>
    </html>
  );
}
