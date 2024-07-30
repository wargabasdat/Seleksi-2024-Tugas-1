"use client";

import { Button } from "./button";
import { Menu, X, Sun, MoonStar } from "lucide-react";
import { useTheme } from "next-themes";
import Image from "next/image";
import Link from "next/link";
import { usePathname } from "next/navigation";
import { useRef, useEffect } from "react";
import type { SetStateAction, Dispatch } from "react";

const NavBar = ({
  navBarExpanded,
  setNavBarExpanded,
}: {
  navBarExpanded: boolean;
  setNavBarExpanded: Dispatch<SetStateAction<boolean>>;
}) => {
  // List of paths
  const paths = [
    {
      name: "Dashboard",
      url: "/dashboard",
    },
  ];

  // Get current theme
  const { theme, setTheme } = useTheme();

  // Get pathname (NavBar.usePathname is for mocking in component tests)
  const pathname = usePathname();

  // Side Bar background ref
  const sideBarBgRef = useRef<HTMLDivElement>(null);

  // Close Navbar when user clicks on black background stuffs
  useEffect(() => {
    function handleClickOutside(event: MouseEvent) {
      // If Userclick is in the black background stuff
      if (
        sideBarBgRef.current &&
        sideBarBgRef.current.contains(event.target as Node)
      ) {
        setNavBarExpanded(false);
      }
    }
    // Bind the event listener
    document.addEventListener("mousedown", handleClickOutside);
    return () => {
      // Unbind the event listener on clean up
      document.removeEventListener("mousedown", handleClickOutside);
    };
  }, [setNavBarExpanded]);

  return (
    <header className="sticky left-0 right-0 top-0 z-40 flex h-[90px] w-full flex-row items-center justify-between border-b-2 border-b-border bg-background px-8 lg:px-16">
      {/* Logo Icon */}
      <Link
        tabIndex={1}
        href="/"
        className="flex flex-row items-center gap-2 font-inter text-xl font-medium"
      >
        <Image width={40} height={40} src="/logo.png" alt="Weather Wise Logo" />
        <span>WeatherWise</span>
      </Link>

      {/* Menu Icon Button */}
      <Button
        variant="ghost"
        size="icon"
        aria-label="Menu"
        className="lg:hidden"
        onClick={() => setNavBarExpanded(true)}
      >
        <Menu size={36} className="stroke-foreground" />
      </Button>

      <div
        className={`fixed right-0 top-0 z-10 flex h-full w-[230px] flex-col gap-6 border-l-2 border-l-border bg-background p-6 font-inter text-base duration-300 ease-in-out lg:static lg:h-auto lg:w-auto lg:translate-x-0 lg:flex-row-reverse lg:items-center lg:gap-12 lg:border-none lg:bg-transparent lg:p-0 lg:dark:bg-transparent xl:text-lg ${
          navBarExpanded ? "translate-x-0" : "translate-x-full"
        }`}
      >
        <div className="flex flex-row items-center justify-between">
          <div className="flex flex-row items-center gap-6">
            {/* Toggle Light/Dark mode */}
            <Button
              tabIndex={4}
              variant="outline"
              size="icon"
              aria-label="Toggle Light/Dark Mode"
              onClick={() => setTheme(theme === "dark" ? "light" : "dark")}
            >
              {theme === "dark" ? (
                <MoonStar className="h-6 w-6 stroke-primary" />
              ) : (
                <Sun className="h-6 w-6 stroke-primary" />
              )}
            </Button>
          </div>

          {/* Close Button */}
          <Button
            variant="ghost"
            size="icon"
            aria-label="Close NavBar"
            className="lg:hidden"
            onClick={() => setNavBarExpanded(false)}
          >
            <X size={36} className="stroke-foreground" />
          </Button>
        </div>

        {/* Path lists */}
        <nav>
          <ul className="flex flex-col lg:flex-row lg:gap-12">
            {paths.map((path, index) => {
              return (
                <li key={index} className="py-2">
                  <Link
                    tabIndex={index + 2}
                    href={path.url}
                    className={`${
                      pathname.startsWith(path.url)
                        ? "font-semibold text-foreground"
                        : "font-medium text-muted-foreground lg:hover:text-foreground"
                    }`}
                  >
                    {path.name}
                  </Link>
                </li>
              );
            })}
          </ul>
        </nav>
      </div>

      {/* Side bar opaque background */}
      {navBarExpanded && (
        <div
          ref={sideBarBgRef}
          className="fixed inset-0 z-0 h-full w-full bg-opacity-80 backdrop-blur-sm lg:hidden"
        />
      )}
    </header>
  );
};

export default NavBar;
