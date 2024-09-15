export interface XYChartData<X, Y> {
  x: X;
  y: Y;
}

export type TimeSeriesChartData = XYChartData<string, number>; // Date must be in string for recharts to work

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
