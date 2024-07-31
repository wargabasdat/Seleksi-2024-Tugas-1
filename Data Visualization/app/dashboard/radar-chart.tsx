"use client";

import { TrendingUp } from "lucide-react";
import { PolarAngleAxis, PolarGrid, Radar, RadarChart } from "recharts";

import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";
import {
  ChartConfig,
  ChartContainer,
  ChartTooltip,
  ChartTooltipContent,
} from "@/components/ui/chart";
import { FreqChartData } from "@/types/chart";

interface CustomRadarChartProps {
  title: string;
  description: string;
  chartData: FreqChartData[];
  freqLabel: string;
}

export function CustomRadarChart({
  title,
  description,
  chartData,
  freqLabel,
}: CustomRadarChartProps) {
  const chartConfig = {
    value: {
      label: freqLabel,
      color: "hsl(var(--chart-1))",
    },
  } satisfies ChartConfig;

  return (
    <Card className="shadow-md col-span-2 lg:col-span-1">
      <CardHeader className="items-start pb-4">
        <CardTitle>{title}</CardTitle>
        <CardDescription>{description}</CardDescription>
      </CardHeader>
      <CardContent className="pb-1">
        <ChartContainer
          config={chartConfig}
          className="mx-auto aspect-square max-h-[350px]"
        >
          <RadarChart data={chartData}>
            <ChartTooltip cursor={false} content={<ChartTooltipContent />} />

            <PolarGrid gridType="circle" />

            <PolarAngleAxis dataKey="label" />

            <Radar
              dataKey="value"
              fillOpacity={0.5}
              fill="var(--color-value)"
              dot={{
                r: 4,
                fillOpacity: 1,
              }}
            />
          </RadarChart>
        </ChartContainer>
      </CardContent>
    </Card>
  );
}
