"use client";

import NavBar from "@/components/ui/navbar";
import { ThemeProvider } from "next-themes";
import { usePathname } from "next/navigation";
import { useState, useEffect } from "react";

const BodyLayout = ({ children }: { children: React.ReactNode }) => {
  // Navbar State
  const [navBarExpanded, setNavBarExpanded] = useState(false);

  // Reset navbar everytime path changes
  const pathname = usePathname();
  useEffect(() => {
    setNavBarExpanded(false);
  }, [pathname]);

  return (
    <ThemeProvider attribute="class" defaultTheme="light">
      <body
        className={`font-inter flex min-h-screen flex-col bg-background ${
          navBarExpanded && "overflow-hidden"
        }`}
      >
        <NavBar
          navBarExpanded={navBarExpanded}
          setNavBarExpanded={setNavBarExpanded}
        />
        {children}
      </body>
    </ThemeProvider>
  );
};

export default BodyLayout;
