"use client";

import * as React from "react";
import { Area, AreaChart, CartesianGrid, XAxis, YAxis } from "recharts";

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

export function CustomAreaChart({
  title,
  description,
  chartData,
  labelY,
  formatUnitY,
}: CustomLineChartProps) {
  const chartConfig = {
    y: {
      label: labelY,
      color: "hsl(var(--chart-1))",
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

  const isEmpty = chartData.length === 0;

  return (
    <Card className="col-span-2 shadow-md">
      <CardHeader className="flex flex-col items-stretch space-y-0 border-b p-0 lg:flex-row">
        <div className="flex flex-1 flex-col justify-center gap-1 px-6 py-5 lg:py-6">
          <CardTitle>{title}</CardTitle>
          <CardDescription>{description}</CardDescription>
        </div>
        <div className="flex">
          {/* Min */}
          <div className="flex flex-1 lg:flex-none flex-col justify-center gap-1 border-t px-6 py-4 text-left hover:bg-muted/50 lg:border-l lg:border-t-0 lg:px-8 lg:py-6">
            <span className="text-xs text-muted-foreground">Minimum</span>
            <span className="text-lg font-bold leading-none lg:text-3xl">
              {isEmpty ? "N/A" : formatterY(summary.minY)}
            </span>
          </div>

          {/* Avg */}
          <div className="flex flex-1 lg:flex-none flex-col justify-center gap-1 border-t px-6 py-4 text-left border-l hover:bg-muted/50 lg:border-l lg:border-t-0 lg:px-8 lg:py-6">
            <span className="text-xs text-muted-foreground">Average</span>
            <span className="text-lg font-bold leading-none lg:text-3xl">
              {isEmpty ? "N/A" : formatterY(summary.avgY)}
            </span>
          </div>

          {/* Max */}
          <div className="flex flex-1 lg:flex-none flex-col justify-center gap-1 border-t px-6 py-4 text-left border-l hover:bg-muted/50 lg:border-l lg:border-t-0 lg:px-8 lg:py-6">
            <span className="text-xs text-muted-foreground">Maximum</span>
            <span className="text-lg font-bold leading-none lg:text-3xl">
              {isEmpty ? "N/A" : formatterY(summary.maxY)}
            </span>
          </div>
        </div>
      </CardHeader>

      <CardContent className="px-2 pt-6 sm:p-6">
        {isEmpty ? (
          <div className="h-[300px] flex items-center justify-center">
            <p className="text-base text-muted-foreground">
              Data for this daterange & location is not available.
            </p>
          </div>
        ) : (
          <ChartContainer
            config={chartConfig}
            className="aspect-auto h-[300px] w-full"
          >
            <AreaChart data={chartData}>
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
                minTickGap={32}
              />

              <ChartTooltip
                cursor={false}
                content={
                  <ChartTooltipContent
                    className="w-[175px]"
                    indicator="dot"
                    nameKey="y"
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
              <Area
                dataKey="y"
                type="natural"
                fillOpacity={0.4}
                fill="var(--color-y)"
                stroke="var(--color-y)"
              />
            </AreaChart>
          </ChartContainer>
        )}
      </CardContent>
    </Card>
  );
}
