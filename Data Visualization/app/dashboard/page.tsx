import { getLocationOptions } from "@/lib/queries/location";
import { filterQuerySchema } from "@/schema/filter";
import { Metadata } from "next";
import { LocationSelect } from "./location-select";
import { WeatherDatePicker } from "./weather-date-picker";
import { redirect } from "next/navigation";
import { ChartSection } from "./chart-section";
import { Suspense } from "react";
import { ChartSectionLoading } from "./chart-section-loading";
import { openGraphTemplate, twitterTemplate } from "@/lib/metadata";

export const metadata: Metadata = {
  title: "Dashboard | WeatherWise",
  openGraph: {
    ...openGraphTemplate,
    title: "Dashboard | WeatherWise",
  },
  twitter: {
    ...twitterTemplate,
    title: "Dashboard | WeatherWise",
  },
};

// Force dynamic
export const dynamic = "force-dynamic";

export default async function DashboardPage({
  searchParams,
}: {
  searchParams: { [key: string]: string };
}) {
  // Get location options
  const locationOptions = await getLocationOptions();

  // Parse query params
  // Serverside validation of query params
  const zodResult = await filterQuerySchema(locationOptions).safeParseAsync(
    searchParams
  );
  if (!zodResult.success) {
    if (
      zodResult.error.errors[0].path[0] === "startDate" ||
      zodResult.error.errors[0].path[0] === "endDate"
    ) {
      // Date range invalid
      const newSearchParams = new URLSearchParams(searchParams);
      newSearchParams.delete("startDate");
      newSearchParams.delete("endDate");
      const newURL = `/dashboard?${newSearchParams.toString()}`;
      redirect(newURL);
    } else if (zodResult.error.errors[0].path[0] === "station") {
      // Location invalid
      const newSearchParams = new URLSearchParams(searchParams);
      newSearchParams.delete("station");
      const newURL = `/dashboard?${newSearchParams.toString()}`;
      redirect(newURL);
    } else {
      // Other zod errors
      redirect("/dashboard");
    }
  }

  const queryFilter = zodResult.data;
  // Query date only stores the date (year, month date). Setup the time to 00:00:00
  if (queryFilter.startDate) {
    queryFilter.startDate.setHours(0, 0, 0, 0);
  }
  // Query date only stores the date (year, month date). Setup the time to 23:59:59
  if (queryFilter.endDate) {
    queryFilter.endDate.setHours(23, 59, 59, 999);
  }

  return (
    <main className="flex flex-auto justify-center px-5 py-12 lg:p-16">
      <div className="w-full max-w-7xl flex flex-col gap-8">
        <header className="flex flex-col lg:flex-row lg:justify-between gap-4">
          {/* Title */}
          <h1 className="font-bold text-3xl lg:text-4xl">Dashboard</h1>

          {/* Filters */}
          <div className="flex flex-col sm:flex-row gap-4 lg:gap-4">
            {/* Location / Station */}
            <LocationSelect options={locationOptions} />

            {/* Date Range With Presets */}
            <WeatherDatePicker />
          </div>
        </header>

        {/* Charts & Data */}
        {!queryFilter.station ||
        !queryFilter.startDate ||
        !queryFilter.endDate ? (
          <p className="text-base text-muted-foreground mt-5 lg:text-lg text-center">
            Select location & date to begin!
          </p>
        ) : (
          <Suspense fallback={<ChartSectionLoading />}>
            <ChartSection
              station={queryFilter.station}
              startDate={queryFilter.startDate}
              endDate={queryFilter.endDate}
            />
          </Suspense>
        )}
      </div>
    </main>
  );
}
