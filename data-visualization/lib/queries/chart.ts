import { QueryFilter } from "@/types/filter";
import { dbQuery } from "../db";
import {
  FreqChartData,
  NumberNumberChartData,
  TimeSeriesChartData,
  WeatherXYChartData,
} from "@/types/chart";

interface QueryResultXYChartData {
  datetime: Date;
  temperature: number;
  dew_point: number;
  humidity: number;
  wind_speed: number;
  pressure: number;
}

// Gets XY chart data for weather
//
// Group the data into 200 groups if there are more than 200 rows
export async function getXYChartData(
  filter: QueryFilter
): Promise<WeatherXYChartData> {
  const query = `
    WITH numbered_weather AS (
      SELECT
        *,
        ROW_NUMBER() OVER (ORDER BY datetime) AS row_num,
        COUNT(*) OVER() AS total_rows
      FROM weather
      WHERE
        station_code = ? AND
        datetime BETWEEN ? AND ?
    ),
    grouped_weather AS (
      SELECT
        *,
        CASE
          WHEN total_rows > 200 THEN CEIL(row_num / (total_rows / 200))
          ELSE row_num
        END AS group_num
      FROM numbered_weather
    )
    SELECT
      FROM_UNIXTIME(AVG(UNIX_TIMESTAMP(datetime))) AS datetime,
      AVG(temperature) AS temperature,
      AVG(dew_point) AS dew_point,
      AVG(humidity) AS humidity,
      AVG(wind_speed) AS wind_speed,
      AVG(pressure) AS pressure
    FROM grouped_weather
    GROUP BY group_num
    ORDER BY group_num;
  `;

  const params = [filter.station, filter.startDate, filter.endDate];

  const result = await dbQuery<QueryResultXYChartData[]>(query, params);

  // Map result to WeatherXYChartData
  const temperatureData: TimeSeriesChartData[] = [];
  const dewPointData: TimeSeriesChartData[] = [];
  const humidityData: TimeSeriesChartData[] = [];
  const windSpeedData: TimeSeriesChartData[] = [];
  const pressureData: TimeSeriesChartData[] = [];
  const temperatureHumidityData: NumberNumberChartData[] = [];

  result.forEach((row) => {
    temperatureData.push({ x: row.datetime.toUTCString(), y: row.temperature });
    dewPointData.push({ x: row.datetime.toUTCString(), y: row.dew_point });
    humidityData.push({ x: row.datetime.toUTCString(), y: row.humidity });
    windSpeedData.push({ x: row.datetime.toUTCString(), y: row.wind_speed });
    pressureData.push({ x: row.datetime.toUTCString(), y: row.pressure });
    temperatureHumidityData.push({ x: row.temperature, y: row.humidity });
  });

  const weatherXYChartData = {
    temperature: temperatureData,
    dewPoint: dewPointData,
    humidity: humidityData,
    windSpeed: windSpeedData,
    pressure: pressureData,
    temperatureHumidity: temperatureHumidityData,
  };

  return weatherXYChartData;
}

interface QueryResultWindDirectionData {
  label: string;
  value: bigint;
}

// Get radar/pie chart data for wind direction in percentage
export async function getFreqWindDirection(
  filter: QueryFilter
): Promise<FreqChartData[]> {
  const query = `
    SELECT
      wind as label,
      COUNT(*) as value
    FROM weather
    WHERE
      station_code = ? AND
      datetime BETWEEN ? AND ? AND
      wind IS NOT NULL AND
      wind <> 'VAR' AND
      wind <> 'CALM'
    GROUP BY wind
    ORDER BY wind;
  `;

  const params = [filter.station, filter.startDate, filter.endDate];

  const result = await dbQuery<QueryResultWindDirectionData[]>(query, params);

  let totalWind = 0;
  const windCountMap = new Map<string, number>();
  result.forEach((row) => {
    const parsed = Number(row.value);
    windCountMap.set(row.label, parsed);
    totalWind += parsed;
  });

  if (totalWind === 0) {
    return [];
  }

  // Create sorted wind directions
  const windDirections = [
    "N",
    "NNE",
    "NE",
    "ENE",
    "E",
    "ESE",
    "SE",
    "SSE",
    "S",
    "SSW",
    "SW",
    "WSW",
    "W",
    "WNW",
    "NW",
    "NNW",
  ];
  const sortedResult: FreqChartData[] = [];
  windDirections.forEach((direction) => {
    const val = windCountMap.get(direction);
    const percentage = val ? (100 * val) / totalWind : 0;
    sortedResult.push({
      label: direction,
      value: percentage,
    });
  });

  return sortedResult;
}

interface QueryResultFreqWeatherCondition {
  label: string;
  value: string;
}

// Get radar/pie chart data for weather condition (only top 8)
export async function getFreqWeatherCondition(
  filter: QueryFilter
): Promise<FreqChartData[]> {
  const query = `
    WITH ranked_counts AS (
      SELECT
        \`condition\`,
        COUNT(*) AS count,
        ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) AS rank
      FROM weather
      WHERE
        station_code = ? AND
        datetime BETWEEN ? AND ? AND
        \`condition\` IS NOT NULL AND
        \`condition\` <> 'N/A'
      GROUP BY \`condition\`
    )
    SELECT
      CASE
        WHEN rank < 5 THEN \`condition\`
        ELSE 'Other'
      END AS label,
      SUM(count) AS value
    FROM ranked_counts
    GROUP BY label
    ORDER BY value DESC;
`;

  const params = [filter.station, filter.startDate, filter.endDate];

  const result = await dbQuery<QueryResultFreqWeatherCondition[]>(
    query,
    params
  );

  const total = result.reduce((acc, curr) => acc + Number(curr.value), 0);

  const processed: FreqChartData[] = [];
  result.forEach((row) => {
    const parsedVal = Number(row.value);
    const percentage = (100 * parsedVal) / total;
    processed.push({
      label: row.label,
      value: percentage,
    });
  });

  return processed;
}
