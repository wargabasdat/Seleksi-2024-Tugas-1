"use client";

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

  const isEmpty = chartData.length === 0;

  return (
    <Card className="shadow-md col-span-2 lg:col-span-1">
      <CardHeader className="items-start border-b">
        <CardTitle>{title}</CardTitle>
        <CardDescription>{description}</CardDescription>
      </CardHeader>
      <CardContent className="pt-6">
        {isEmpty ? (
          <div className="h-[350px] flex items-center justify-center">
            <p className="text-base text-muted-foreground">
              Data for this daterange & location is not available.
            </p>
          </div>
        ) : (
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
        )}
      </CardContent>
    </Card>
  );
}
