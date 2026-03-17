import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "DevFlow Atlas",
  description: "Manual-first operating graph for indie software businesses",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  );
}
