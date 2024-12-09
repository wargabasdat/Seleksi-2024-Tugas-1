"use client";

import { Pie, PieChart } from "recharts";

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
  ChartLegend,
  ChartLegendContent,
} from "@/components/ui/chart";
import { FreqChartData } from "@/types/chart";

interface CustomPieChartProps {
  title: string;
  description: string;
  chartData: FreqChartData[];
}

export function CustomPieChart({
  title,
  description,
  chartData,
}: CustomPieChartProps) {
  const chartConfig = {} satisfies ChartConfig;
  chartData.forEach((data, index) => {
    Object.assign(chartConfig, {
      [data.label as any]: {
        label: data.label,
        color: `hsl(var(--chart-${index + 1}))`,
      },
    });
  });

  const chartDataWithFill = chartData.map((data, index) => ({
    ...data,
    fill: `hsl(var(--chart-${index + 1}))`,
  }));

  const isEmpty = chartData.length === 0;

  return (
    <Card className="shadow-md flex flex-col col-span-2 lg:col-span-1">
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
            className="mx-auto aspect-square max-h-[375px]"
          >
            <PieChart>
              <ChartTooltip
                content={
                  <ChartTooltipContent
                    nameKey="label"
                    className="w-[175px]"
                    hideLabel
                  />
                }
              />

              <Pie data={chartDataWithFill} dataKey="value" />

              <ChartLegend
                content={<ChartLegendContent nameKey="label" />}
                className="-translate-y-2 flex-wrap gap-2 [&>*]:basis-1/4 [&>*]:justify-center"
              />
            </PieChart>
          </ChartContainer>
        )}
      </CardContent>
    </Card>
  );
}
