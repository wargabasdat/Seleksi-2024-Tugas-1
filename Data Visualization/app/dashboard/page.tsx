import {
  getFreqWeatherCondition,
  getFreqWindDirection,
  getXYChartData,
} from "@/lib/queries/chart";
import { getLocationOptions } from "@/lib/queries/location";
import { filterQuerySchema } from "@/schema/filter";
import { Metadata } from "next";
import { LocationSelect } from "./location-select";
import { WeatherDatePicker } from "./weather-date-picker";
import { redirect } from "next/navigation";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { QueryFilter } from "@/types/filter";
import { CustomLineChart } from "./line-chart";
import { CustomAreaChart } from "./area-chart";
import { CustomRadarChart } from "./radar-chart";

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
    startDate: new Date("2015-04-28"),
    endDate: new Date("2024-04-31"),
  };

  // Get frequency data
  const weatherConditionData = await getFreqWeatherCondition(testQueryFilter);
  const windDirectionData = await getFreqWindDirection(testQueryFilter);

  // Get XY chart data
  const xyChartData = await getXYChartData(testQueryFilter);

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
        <section className="grid grid-cols-2 gap-4 lg:gap-6">
          {/* Temperature line chart */}
          <CustomLineChart
            title="Temperature"
            description="Temperature overtime in Celcius over the selected daterange and location."
            labelY="Temperature"
            formatUnitY="celcius"
            chartData={xyChartData.temperature}
            deltaDomainY={5}
          />

          {/* Humidity area chart */}
          <CustomAreaChart
            title="Humidity"
            description="Humidity in percentage over the selected daterange and location."
            labelY="Humidity"
            formatUnitY="percentage"
            chartData={xyChartData.humidity}
          />

          {/* Pressure line chart */}
          <CustomLineChart
            title="Pressure"
            description="Pressure in ″Hg over the selected daterange and location."
            labelY="Pressure"
            formatUnitY="inhg"
            chartData={xyChartData.pressure}
            deltaDomainY={50}
          />

          {/* Wind speed line chart */}
          <CustomLineChart
            title="Wind Speed"
            description="Wind speed in km/h over the selected daterange and location."
            labelY="Wind Speed"
            formatUnitY="kmph"
            chartData={xyChartData.windSpeed}
            deltaDomainY={5}
          />

          {/* Wind direction radar chart */}
          <CustomRadarChart
            title="Wind Direction"
            description="Wind direction frequency over the selected daterange and location."
            chartData={windDirectionData}
            freqLabel="%"
          />

          {/* Weather condition pie chart */}
          <Card className="">
            <CardHeader>
              <CardTitle className="text-lg">Weather Condition</CardTitle>
            </CardHeader>
            <CardContent className="pl-2"></CardContent>
          </Card>

          {/* Dew point line chart */}
          <CustomLineChart
            title="Dew Point"
            description="Dew point in Celcius over the selected daterange and location."
            labelY="Dew Point"
            formatUnitY="celcius"
            chartData={xyChartData.dewPoint}
            deltaDomainY={5}
          />
        </section>
      </div>
    </main>
  );
}
