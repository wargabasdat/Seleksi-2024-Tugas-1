import {
  getFreqWeatherCondition,
  getFreqWindDirection,
  getXYChartData,
} from "@/lib/queries/chart";
import { getLocationOptions } from "@/lib/queries/location";
import { getAverageData } from "@/lib/queries/non-chart";
import { filterQuerySchema } from "@/schema/filter";
import { QueryFilter } from "@/types/filter";
import { Metadata } from "next";
import { LocationSelect } from "./location-select";
import { WeatherDatePicker } from "./weather-date-picker";
import { redirect } from "next/navigation";

export const metadata: Metadata = {
  title: "Dashboard | Weather Wise",
};

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
    }
  }

  const filterQuery = zodResult.data;

  const isFilterEmpty =
    !filterQuery ||
    (filterQuery &&
      (!filterQuery.station || !filterQuery.startDate || !filterQuery.endDate));

  console.log(isFilterEmpty);

  return (
    <main className="flex flex-auto justify-center px-5 py-12 lg:p-16">
      <div className="w-full max-w-7xl">
        <header>
          {/* Title */}
          <h1 className="font-bold text-3xl lg:text-4xl">Dashboard</h1>

          {/* Filters */}
          <div>
            {/* Date Range With Presets */}
            <WeatherDatePicker />

            {/* Location / Station */}
            <LocationSelect options={locationOptions} />
          </div>
        </header>

        {/* Non Charts (Number) */}
        <section>
          {/* Average temperature */}

          {/* Average dew point*/}

          {/* Average humidity */}

          {/* Average win_speed */}

          {/* Average pressure */}
        </section>

        {/* Charts */}
        <section>
          {/* Temperature & Dew point line chart */}

          {/* Humidity area chart */}

          {/* Wind speed vs overtime */}

          {/* Wind directory radar/pie chart */}

          {/* Pressure line chart */}

          {/* Temperatrue vs Humididty */}

          {/* Weather condition radar/pie chart */}
        </section>
      </div>
    </main>
  );
}
