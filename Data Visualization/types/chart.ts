export interface XYChartData<X, Y> {
  x: X;
  y: Y;
}

export type TimeSeriesChartData = XYChartData<Date, number>;

export type NumberNumberChartData = XYChartData<number, number>;

export interface WeatherXYChartData {
  temperature: TimeSeriesChartData[];
  dewPoint: TimeSeriesChartData[];
  humidity: TimeSeriesChartData[];
  windSpeed: TimeSeriesChartData[];
  pressure: TimeSeriesChartData[];
  temperatureHumidity: NumberNumberChartData[];
}

export interface FreqChartData {
  label: string;
  value: number;
}
