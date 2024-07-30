import { type QueryFilter } from "@/types/filter";
import { dbQuery } from "../db";
import { AverageWeatherData } from "@/types/non-chart";

interface QueryResult {
  avg_temperature: number;
  avg_dew_point: number;
  avg_humidity: number;
  avg_wind_speed: number;
  avg_pressure: number;
}

export async function getAverageData(
  filter: QueryFilter
): Promise<AverageWeatherData> {
  const query = `
    SELECT
      AVG(temperature) as 'avg_temperature',
      AVG(dew_point) as 'avg_dew_point',
      AVG(humidity) as 'avg_humidity',
      AVG(wind_speed) as 'avg_wind_speed',
      AVG(pressure) as 'avg_pressure'
    FROM weather
    WHERE
      station_code = ? AND
      datetime BETWEEN ? AND ?
  `;

  const params = [filter.station, filter.startDate, filter.endDate];

  const [result] = await dbQuery<QueryResult[]>(query, params);

  const averageWeatherData: AverageWeatherData = {
    temperature: result.avg_temperature,
    dewPoint: result.avg_dew_point,
    humidity: result.avg_humidity,
    windSpeed: result.avg_wind_speed,
    pressure: result.avg_pressure,
  };

  return averageWeatherData;
}
