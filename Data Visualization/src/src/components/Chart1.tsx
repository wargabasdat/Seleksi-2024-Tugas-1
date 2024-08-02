"use client";

import * as React from "react";
import { Bar, BarChart, CartesianGrid, XAxis, YAxis } from "recharts";

import {
  Card,
  CardContent,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";
import {
  ChartConfig,
  ChartContainer,
  ChartTooltip,
  ChartTooltipContent,
} from "@/components/ui/chart";
import { TProblemRating } from "@/lib/types";
import { getProblemsDistributionByRating } from "@/actions/actions";

const chartConfig = {
  views: {
    label: "Total Problems",
  },
  lowerthan: {
    label: "< 2000",
    color: "hsl(var(--chart-1))",
  },
  geqthan: {
    label: "≥ 2000",
    color: "hsl(var(--chart-2))",
  },
} satisfies ChartConfig;

export function Chart1() {
  const [data, setData] = React.useState<{
    lowerthan: TProblemRating[];
    geqthan: TProblemRating[];
  }>({
    lowerthan: [],
    geqthan: [],
  });
  const [activeChart, setActiveChart] = React.useState("lowerthan");

  React.useEffect(() => {
    async function set() {
      const res = await getProblemsDistributionByRating();
      setData({
        lowerthan: res.filter(
          (row) => parseInt(row.rating) < 2000 || row.rating === "unrated"
        ),
        geqthan: res.filter((row) => parseInt(row.rating) >= 2000),
      });
    }
    set();
  }, []);

  const total = {
    lowerthan: data.lowerthan.reduce((acc, row) => acc + row.count, 0),
    geqthan: data.geqthan.reduce((acc, row) => acc + row.count, 0),
  };

  return (
    <Card className="w-full">
      <CardHeader className="flex flex-col items-stretch space-y-0 border-b p-0 sm:flex-row">
        <div className="flex flex-1 flex-col justify-center gap-1 px-6 py-5 sm:py-6">
          <CardTitle>Problem&apos;s Rating Distribution</CardTitle>
          <CardDescription>
            Showing the distribution of problems based on their rating in
          </CardDescription>
        </div>
        <div className="flex">
          {["lowerthan", "geqthan"].map((key) => {
            const chart = key as keyof typeof chartConfig;
            return (
              <button
                key={chart}
                data-active={activeChart === chart}
                className="relative z-30 flex flex-1 flex-col justify-center gap-1 border-t px-6 py-4 text-left even:border-l data-[active=true]:bg-muted/50 sm:border-l sm:border-t-0 sm:px-8 sm:py-6"
                onClick={() => setActiveChart(chart)}
              >
                <span className="text-xs text-muted-foreground">
                  {chartConfig[chart].label}
                </span>
                <span className="text-lg font-bold leading-none sm:text-3xl">
                  {total[key as keyof typeof total].toLocaleString()}
                </span>
              </button>
            );
          })}
        </div>
      </CardHeader>
      <CardContent className="px-2 sm:p-6">
        <ChartContainer config={chartConfig} className="aspect-auto h-[250px]">
          <BarChart
            accessibilityLayer
            data={data[activeChart as keyof typeof data]}
            margin={{
              left: 12,
              right: 12,
            }}
          >
            <CartesianGrid vertical={false} />
            <XAxis
              dataKey="rating"
              tickLine={false}
              axisLine={false}
              tickMargin={8}
              minTickGap={32}
              tickFormatter={(value) => {
                return value;
              }}
            />
            <YAxis
              tickLine={false}
              axisLine={false}
              tickMargin={8}
              tickFormatter={(value) => {
                return value;
              }}
            />
            <ChartTooltip
              content={
                <ChartTooltipContent
                  className="w-[150px]"
                  nameKey="views"
                  labelFormatter={(value) => {
                    return value;
                  }}
                />
              }
            />
            <Bar dataKey={"count"} fill={`var(--color-${activeChart})`} />
          </BarChart>
        </ChartContainer>
      </CardContent>
      <CardFooter className="flex-col items-start gap-2 text-sm">
        <p>
          {" "}
          Insight: dari distribusi rating problemset yang ada di CF, saya
          melihat bahwa jumlah problem dengan rating 900 s.d. 1900 hampir selalu
          konsisten naik, dan 2000 s.d. 3500 hampir selalu konsisten turun
        </p>
      </CardFooter>
    </Card>
  );
}
