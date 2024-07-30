import { Button } from "@/components/ui/button";
import { ArrowRightCircle } from "lucide-react";
import type { Metadata } from "next";
import Image from "next/image";
import Link from "next/link";

export const metadata: Metadata = {
  title: "WeatherWise",
};

export default function Home() {
  return (
    <main className="flex flex-auto flex-col">
      {/* Hero Section */}
      <section className="flex min-h-[calc(100vh-90px)] w-full items-center justify-center px-6 py-16 sm:p-12 lg:p-24">
        <div className="flex max-w-6xl flex-col-reverse items-center gap-6 sm:flex-row lg:gap-16">
          {/* Hero Texts */}
          <div className="flex flex-col items-start gap-3 lg:gap-4">
            <h1 className="text-4xl font-bold lg:text-6xl">WeatherWise.</h1>
            <p className="text-base font-normal text-muted-foreground lg:text-xl">
              Your interactive dashboard for comprehensive weather analytics.
              Explore historical data for any city, with customizable timeframes
              and detailed visualizations.
            </p>
            <Link href="/dashboard">
              <Button tabIndex={-1} size="lg">
                Try Now
                <ArrowRightCircle className="ml-2 h-5 w-5" />
              </Button>
            </Link>
          </div>

          {/* Hero Image */}
          <Image
            src="/logo.png"
            alt="WeatherWise Logo"
            width={400}
            height={400}
            className="w-[240px] lg:w-80"
            priority
          />
        </div>
      </section>
    </main>
  );
}
