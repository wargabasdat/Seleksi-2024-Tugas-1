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
import { TProblemRating, TProblemTag } from "@/lib/types";
import {
  getProblemsDistributionByRating,
  getProblemsDistributionByTag,
} from "@/actions/actions";

const chartConfig = {
  views: {
    label: "Total Problems",
  },
  main: {
    color: "hsl(var(--chart-3))",
  },
} satisfies ChartConfig;

export function Chart2() {
  const [data, setData] = React.useState<TProblemTag[]>([]);

  React.useEffect(() => {
    async function set() {
      const res = await getProblemsDistributionByTag();
      setData(res);
    }
    set();
  }, []);

  return (
    <Card className="w-full">
      <CardHeader className="flex flex-col items-stretch space-y-0 border-b p-0 sm:flex-row">
        <div className="flex flex-1 flex-col justify-center gap-1 px-6 py-5 sm:py-6">
          <CardTitle>Problems Distribution by Tag</CardTitle>
          <CardDescription>
            Showing the total number of problems that contains a specific tag
          </CardDescription>
        </div>
        {/* <div className="flex">
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
        </div> */}
      </CardHeader>
      <CardContent className="px-2 sm:p-6">
        <ChartContainer config={chartConfig} className="aspect-auto h-[250px]">
          <BarChart
            accessibilityLayer
            data={data}
            margin={{
              left: 12,
              right: 12,
              bottom: 50,
            }}
          >
            <CartesianGrid vertical={false} />
            <XAxis
              dataKey="tag_name"
              tickLine={false}
              axisLine={false}
              tickMargin={30}
              minTickGap={32}
              tickFormatter={(value) => {
                return value;
              }}
              interval={0}
              angle={-45}
              fontSize={8}
              className="h-[250px]"
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
            <Bar dataKey={"count"} fill={`var(--color-main)`} />
          </BarChart>
        </ChartContainer>
      </CardContent>
      <CardFooter className="flex-col items-start gap-2 text-sm">
        <p>
          {" "}
          Insight: dari persebaran soal berdasarkan tag, dapat dilihat bahwa tag
          "math", "greedy","implementation" dan "dp" merupakan tag yang paling
          banyak digunakan dalam problemset di Codeforces. Artinya, suatu
          problem seringkali memiliki tag-tag tersebut.
        </p>
      </CardFooter>
    </Card>
  );
}
