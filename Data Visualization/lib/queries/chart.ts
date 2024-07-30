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
// Group the data into 25 groups if there are more than 25 rows
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
          WHEN total_rows > 25 THEN CEIL(row_num / (total_rows / 25))
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
    temperatureData.push({ x: row.datetime, y: row.temperature });
    dewPointData.push({ x: row.datetime, y: row.dew_point });
    humidityData.push({ x: row.datetime, y: row.humidity });
    windSpeedData.push({ x: row.datetime, y: row.wind_speed });
    pressureData.push({ x: row.datetime, y: row.pressure });
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

// Get radar/pie chart data for wind direction
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
      datetime BETWEEN ? AND ?
    GROUP BY wind
    ORDER BY wind;
  `;

  const params = [filter.station, filter.startDate, filter.endDate];

  const result = await dbQuery<FreqChartData[]>(query, params);

  return result;
}

// Get radar/pie chart data for weather condition
export async function getFreqWeatherCondition(
  filter: QueryFilter
): Promise<FreqChartData[]> {
  const query = `
    SELECT
      \`condition\` as label,
      COUNT(*) as value
    FROM weather
    WHERE
      station_code = ? AND
      datetime BETWEEN ? AND ?
    GROUP BY \`condition\`
    ORDER BY \`condition\`;
  `;

  const params = [filter.station, filter.startDate, filter.endDate];

  const result = await dbQuery<FreqChartData[]>(query, params);

  return result;
}
