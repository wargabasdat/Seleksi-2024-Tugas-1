export interface Weather {
  stationCode: string;
  datetime: Date;
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
