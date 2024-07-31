import {
  getFreqWeatherCondition,
  getFreqWindDirection,
  getXYChartData,
} from "@/lib/queries/chart";
import { CustomAreaChart } from "./area-chart";
import { CustomLineChart } from "./line-chart";
import { CustomPieChart } from "./pie-chart";
import { CustomRadarChart } from "./radar-chart";
import { type QueryFilter } from "@/types/filter";

type ChartSectionProps = QueryFilter;

export async function ChartSection(queryFilter: ChartSectionProps) {
  const [weatherConditionData, windDirectionData, xyChartData] =
    await Promise.all([
      // Get frequency data
      getFreqWeatherCondition(queryFilter),
      getFreqWindDirection(queryFilter),

      // Time series data
      getXYChartData(queryFilter),

      // new Promise((resolve) => setTimeout(resolve, 10000)),
    ]);

  return (
    <section className="grid grid-cols-2 gap-4 lg:gap-6">
      {/* Temperature line chart */}
      <CustomLineChart
        title="Temperature"
        description="Temperature overtime in Celcius over the selected date and location."
        labelY="Temperature"
        formatUnitY="celcius"
        chartData={xyChartData.temperature}
        deltaDomainY={5}
      />

      {/* Humidity area chart */}
      <CustomAreaChart
        title="Humidity"
        description="Humidity in percentage over the selected date and location."
        labelY="Humidity"
        formatUnitY="percentage"
        chartData={xyChartData.humidity}
      />

      {/* Pressure line chart */}
      <CustomLineChart
        title="Pressure"
        description="Pressure in ″Hg over the selected date and location."
        labelY="Pressure"
        formatUnitY="inhg"
        chartData={xyChartData.pressure}
        deltaDomainY={50}
      />

      {/* Wind speed line chart */}
      <CustomLineChart
        title="Wind Speed"
        description="Wind speed in km/h over the selected date and location."
        labelY="Wind Speed"
        formatUnitY="kmph"
        chartData={xyChartData.windSpeed}
        deltaDomainY={5}
      />

      {/* Wind direction radar chart */}
      <CustomRadarChart
        title="Wind Direction"
        description="Wind direction distribution over the selected date and location."
        chartData={windDirectionData}
        freqLabel="%"
      />

      {/* Weather condition pie chart */}
      <CustomPieChart
        title="Weather Condition"
        description="Weather condition distribution over the selected date and location."
        chartData={weatherConditionData}
      />

      {/* Dew point line chart */}
      <CustomLineChart
        title="Dew Point"
        description="Dew point in Celcius over the selected date and location."
        labelY="Dew Point"
        formatUnitY="celcius"
        chartData={xyChartData.dewPoint}
        deltaDomainY={5}
      />
    </section>
  );
}
