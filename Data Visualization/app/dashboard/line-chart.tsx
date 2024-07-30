"use client";

import * as React from "react";
import { CartesianGrid, Line, LineChart, XAxis, YAxis } from "recharts";

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

import { formatDateChart, type FormatUnit, mapFormatter } from "@/lib/utils";
import { TimeSeriesChartData } from "@/types/chart";

interface CustomLineChartProps {
  title: string;
  description: string;
  chartData: TimeSeriesChartData[];
  labelY: string;
  formatUnitY: FormatUnit;
}

export function CustomLineChart({
  title,
  description,
  chartData,
  labelY,
  formatUnitY,
}: CustomLineChartProps) {
  const chartConfig = {
    tooltip: {
      label: labelY,
    },
  } satisfies ChartConfig;

  // Calculate summary data
  const summary = React.useMemo(
    () => ({
      minX: chartData.reduce(
        (acc, curr) => Math.min(acc, new Date(curr.x).getTime()),
        Infinity
      ),
      maxX: chartData.reduce(
        (acc, curr) => Math.max(acc, new Date(curr.x).getTime()),
        -Infinity
      ),
      minY: chartData.reduce((acc, curr) => Math.min(acc, curr.y), Infinity),
      maxY: chartData.reduce((acc, curr) => Math.max(acc, curr.y), -Infinity),
      avgY: chartData.reduce((acc, curr) => acc + curr.y, 0) / chartData.length,
    }),
    [chartData]
  );

  // Get formatter function
  const formatterY = mapFormatter(formatUnitY);

  return (
    <Card className="col-span-2">
      <CardHeader className="flex flex-col items-stretch space-y-0 border-b p-0 sm:flex-row">
        <div className="flex flex-1 flex-col justify-center gap-1 px-6 py-5 sm:py-6">
          <CardTitle>{title}</CardTitle>
          <CardDescription>{description}</CardDescription>
        </div>
        <div className="flex">
          {/* Min */}
          <div className="flex flex-1 flex-col justify-center gap-1 border-t px-6 py-4 text-left even:border-l data-[active=true]:bg-muted/50 sm:border-l sm:border-t-0 sm:px-8 sm:py-6">
            <span className="text-xs text-muted-foreground">Minimum</span>
            <span className="text-lg font-bold leading-none sm:text-3xl">
              {formatterY(summary.minY)}
            </span>
          </div>

          {/* Avg */}
          <div className="flex flex-1 flex-col justify-center gap-1 border-t px-6 py-4 text-left even:border-l data-[active=true]:bg-muted/50 sm:border-l sm:border-t-0 sm:px-8 sm:py-6">
            <span className="text-xs text-muted-foreground">Average</span>
            <span className="text-lg font-bold leading-none sm:text-3xl">
              {formatterY(summary.avgY)}
            </span>
          </div>

          {/* Max */}
          <div className="flex flex-1 flex-col justify-center gap-1 border-t px-6 py-4 text-left even:border-l data-[active=true]:bg-muted/50 sm:border-l sm:border-t-0 sm:px-8 sm:py-6">
            <span className="text-xs text-muted-foreground">Maximum</span>
            <span className="text-lg font-bold leading-none sm:text-3xl">
              {formatterY(summary.maxY)}
            </span>
          </div>
        </div>
      </CardHeader>

      <CardContent className="px-2 sm:p-6">
        <ChartContainer
          config={chartConfig}
          className="aspect-auto h-[250px] w-full"
        >
          <LineChart
            accessibilityLayer
            data={chartData}
            margin={{
              left: 12,
              right: 12,
            }}
          >
            <CartesianGrid vertical={false} />

            <XAxis
              dataKey="x"
              tickLine={false}
              axisLine={false}
              tickMargin={8}
              minTickGap={32}
              tickFormatter={(value) => {
                const date = new Date(value);
                return formatDateChart(
                  date,
                  new Date(summary.minX),
                  new Date(summary.maxX)
                );
              }}
            />

            <YAxis
              dataKey="y"
              tickLine={false}
              axisLine={false}
              tickMargin={8}
              tickFormatter={(value) => formatterY(value)}
            />

            <ChartTooltip
              content={
                <ChartTooltipContent
                  className="w-[175px]"
                  nameKey="tooltip"
                  labelFormatter={(value) => {
                    const date = new Date(value);
                    return formatDateChart(
                      date,
                      new Date(summary.minX),
                      new Date(summary.maxX)
                    );
                  }}
                />
              }
            />

            <Line dataKey={"y"} type="monotone" strokeWidth={2} dot={false} />
          </LineChart>
        </ChartContainer>
      </CardContent>
    </Card>
  );
}
