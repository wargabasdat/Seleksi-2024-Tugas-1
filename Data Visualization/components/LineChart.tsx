// components/LineChart.tsx
"use client";
import React from "react";
import { Line } from "react-chartjs-2";
import {
  Chart as ChartJS,
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  Title,
  Tooltip,
  Legend,
  ChartData,
} from "chart.js";

ChartJS.register(
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  Title,
  Tooltip,
  Legend
);

interface LineChartProps {
  data: {
    company_name: string;
    year: string;
    revenue: number;
    earning: number;
  }[];
}

const LineChart: React.FC<LineChartProps> = ({ data }) => {
  const years = data.map((item) => item.year);
  const revenues = data.map((item) => item.revenue);
  const earnings = data.map((item) => item.earning);

  const chartData: ChartData<"line"> = {
    labels: years,
    datasets: [
      {
        label: "Revenue",
        data: revenues,
        borderColor: "rgba(75, 192, 192, 1)",
        backgroundColor: "rgba(75, 192, 192, 0.2)",
        fill: false,
      },
      {
        label: "Earning",
        data: earnings,
        borderColor: "rgba(153, 102, 255, 1)",
        backgroundColor: "rgba(153, 102, 255, 0.2)",
        fill: false,
      },
    ],
  };

  return <Line data={chartData} />;
};

export default LineChart;
