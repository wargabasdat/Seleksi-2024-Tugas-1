/**
 * Weather data model interface
 *
 * @property datetime: Date in UTC
 * @property temperature: Temperature in Celcius
 * @property dewPoint: Dew point in Celcius
 * @property humidity: Humidity in percentage
 * @property wind: Wind direction
 * @property windSpeed: Wind speed in km/h
 * @property windGust: Wind gust in km/h
 * @property pressure: Pressure in inHg
 * @property precipitation: Precipitation in inHg
 */
export interface WeatherData {
  airportCode: string;
  datetime: string;
  temperature: number | null;
  dewPoint: number | null;
  humidity: number | null;
  wind: string | null;
  windSpeed: number | null;
  windGust: number | null;
  pressure: number | null;
  precipitation: number | null;
  condition: string | null;
}
