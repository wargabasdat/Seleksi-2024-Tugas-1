"use client";

import { TrendingUp } from "lucide-react";
import { LabelList, Pie, PieChart } from "recharts";

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
import { TContestFrequency } from "@/lib/types";
import { useEffect, useState } from "react";
import { getFrequencyOfEachContestType } from "@/actions/actions";

const chartConfig = {
  visitors: {
    label: "Visitors",
  },
  chrome: {
    label: "Chrome",
    color: "hsl(var(--chart-1))",
  },
  safari: {
    label: "Safari",
    color: "hsl(var(--chart-2))",
  },
  firefox: {
    label: "Firefox",
    color: "hsl(var(--chart-3))",
  },
  edge: {
    label: "Edge",
    color: "hsl(var(--chart-4))",
  },
  other: {
    label: "Other",
    color: "hsl(var(--chart-5))",
  },
} satisfies ChartConfig;

type TDatum = {
  type: string;
  total: number;
  fill: string;
};

export function Chart3() {
  const [data, setData] = useState<TDatum[]>([]);
  useEffect(() => {
    async function get() {
      const res = await getFrequencyOfEachContestType();
      const data = Object.entries(res).map(([type, total], index) => ({
        type,
        total,
        fill: `hsl(var(--chart-${index + 1}))`,
      }));
      setData(data);
    }

    get();
  }, []);

  console.log(data);

  return (
    <Card className="flex flex-col">
      <CardHeader className="items-center pb-0">
        <CardTitle>Total Contest by Its Type</CardTitle>
      </CardHeader>
      <CardContent className="flex-1 pb-0">
        <ChartContainer
          config={chartConfig}
          className="mx-auto aspect-square max-h-[250px]"
        >
          <PieChart>
            <ChartTooltip
              cursor={false}
              content={<ChartTooltipContent hideLabel />}
            />
            <Pie data={data} dataKey="total" nameKey="type" stroke="0" />
          </PieChart>
        </ChartContainer>
      </CardContent>
      <CardFooter className="flex-col gap-2 text-sm ">
        <p className="inline-block">
          Insight: dari total yang melebihi jumlah contest yang telah
          diselenggarakan, maka terdapat suatu kontes yang tipenya adalah
          gabungan dari dua atau lebih tipe kontes berbeda. Cth: Div.1 + Div. 2
        </p>
      </CardFooter>
    </Card>
  );
}
