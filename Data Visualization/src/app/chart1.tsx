"use client"

import { Bar, BarChart, CartesianGrid, XAxis } from "recharts"

import {
  ChartConfig,
  ChartContainer,
  ChartLegend,
  ChartLegendContent,
  ChartTooltip,
  ChartTooltipContent,
} from "@/components/ui/chart"


const chartConfig = {
  item: {
    label: "Item",
    color: "#2563eb",
  },
  enemy: {
    label: "Enemy",
    color: "#60a5fa",
  },
  obstacle: {
    label: "Obstacle",
    color: "#93c5fd",
  },
  power_up: {
    label: "Power Up",
    color: "#c3dafe",
  },
} satisfies ChartConfig

export type ChartData = {
  level: string
  item: number
  enemy: number
  obstacle: number
  power_up: number
}

export async function Chart1({chartData}: {chartData: ChartData[]}) {
  return (
    <ChartContainer config={chartConfig} className="min-h-[200px] w-full">
      <BarChart accessibilityLayer data={chartData}>
        <CartesianGrid vertical={false} />
        <XAxis
          dataKey="level"
          tickLine={false}
          tickMargin={10}
          axisLine={false}
          tickFormatter={(value) => value.slice(0, 3)}
        />
        <ChartTooltip content={<ChartTooltipContent />} />
        <ChartLegend content={<ChartLegendContent />} />
        <Bar dataKey="item" fill="var(--color-item)" radius={4}/>
        <Bar dataKey="enemy" fill="var(--color-enemy)" radius={4} />
        <Bar dataKey="obstacle" fill="var(--color-obstacle)" radius={4} />
        <Bar dataKey="power_up" fill="var(--color-power_up)" radius={4} />
      </BarChart>
    </ChartContainer>
  )
}
