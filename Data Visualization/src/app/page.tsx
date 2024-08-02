import { Chart1, ChartData } from "./chart1";
import { Button } from "@/components/ui/button";

export default async function Page() {
  const res = await fetch("http://localhost:3000/api/world")
  const data: any[] = await res.json()
  const chartData = data.map((d) => ({
    level: d.level_name.replace("World ", ""),
    item: d.total_items,
    enemy: d.total_enemies,
    obstacle: d.total_obstacles,
    power_up: d.total_power_ups,
  })) as ChartData[]

  return (
    <main className="p-4 flex gap-4 justify-center mt-8">
      <div className="h-full w-full px-72">
        {/* Navbar */}
        {/* <div className="w-72 flex flex-col gap-4">
          <Button className="w-full border border-zinc-700 rounded-xl bg-zinc-800 text-zinc-50 font-bold hover:bg-zinc-900">Main</Button>
        </div> */}

        {/* Chart */}
        <div className="w-full grid gap-4">
          <div className="w-full bg-zinc-900 p-4 rounded-2xl border border-zinc-800">
            <Chart1 chartData={chartData}/>
          </div>
          
        </div>
      </div>
    </main>
  );
}