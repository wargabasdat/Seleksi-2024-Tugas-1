import {
  getFreqWeatherCondition,
  getFreqWindDirection,
  getXYChartData,
} from "@/lib/queries/chart";
import { getLocationOptions } from "@/lib/queries/location";
import { getAverageData } from "@/lib/queries/non-chart";
import { filterQuerySchema } from "@/schema/filter";
import { Metadata } from "next";
import { LocationSelect } from "./location-select";
import { WeatherDatePicker } from "./weather-date-picker";
import { redirect } from "next/navigation";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { QueryFilter } from "@/types/filter";
import {
  CircleGauge,
  Droplets,
  Thermometer,
  ThermometerSnowflake,
  Wind,
} from "lucide-react";
import {
  formatHumidity,
  formatPressureInHg,
  formatTemperatureCelcius,
  formatWindSpeedKmH,
} from "@/lib/utils";

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
    } else {
      // Other zod errors
      redirect("/dashboard");
    }
  }

  const queryFilter = zodResult.data;

  const isFilterEmpty =
    !queryFilter ||
    (queryFilter &&
      (!queryFilter.station || !queryFilter.startDate || !queryFilter.endDate));

  console.log(isFilterEmpty);

  const testQueryFilter: QueryFilter = {
    station: "WIHH",
    startDate: new Date("2024-01-01"),
    endDate: new Date("2024-04-31"),
  };

  // Get average data
  const averageData = await getAverageData(testQueryFilter);
  console.log(averageData);

  return (
    <main className="flex flex-auto justify-center px-5 py-12 lg:p-16">
      <div className="w-full max-w-7xl flex flex-col gap-8">
        <header className="flex flex-col lg:flex-row lg:justify-between gap-4">
          {/* Title */}
          <h1 className="font-bold text-3xl lg:text-4xl ">Dashboard</h1>

          {/* Filters */}
          <div className="flex flex-col sm:flex-row gap-4 lg:gap-4">
            {/* Location / Station */}
            <LocationSelect options={locationOptions} />

            {/* Date Range With Presets */}
            <WeatherDatePicker />
          </div>
        </header>

        {/* Non Charts (Number) */}
        <section className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
          {/* Average temperature */}
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">Temperature</CardTitle>
              <Thermometer className="size-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">
                {formatTemperatureCelcius(averageData.temperature)}
              </div>
              <p className="text-xs text-muted-foreground">Average value</p>
            </CardContent>
          </Card>

          {/* Average dew point*/}
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">Dew Point</CardTitle>
              <ThermometerSnowflake className="size-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">
                {formatTemperatureCelcius(averageData.dewPoint)}
              </div>
              <p className="text-xs text-muted-foreground">Average value</p>
            </CardContent>
          </Card>

          {/* Average humidity */}
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">Humidity</CardTitle>
              <Droplets className="size-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">
                {formatHumidity(averageData.humidity)}
              </div>
              <p className="text-xs text-muted-foreground">Average value</p>
            </CardContent>
          </Card>

          {/* Average wind_speed */}
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">Wind Speed</CardTitle>
              <Wind className="size-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">
                {formatWindSpeedKmH(averageData.windSpeed)}
              </div>
              <p className="text-xs text-muted-foreground">Average value</p>
            </CardContent>
          </Card>

          {/* Average pressure */}
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">Pressure</CardTitle>
              <CircleGauge className="size-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">
                {formatPressureInHg(averageData.pressure)}
              </div>
              <p className="text-xs text-muted-foreground">Average value</p>
            </CardContent>
          </Card>
        </section>

        {/* Charts */}
        <section>
          {/* Temperature line chart */}

          {/* Dew point line chart */}

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
