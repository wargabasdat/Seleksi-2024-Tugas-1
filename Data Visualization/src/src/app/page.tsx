import { Chart1 } from "@/components/Chart1";
import { Chart2 } from "@/components/Chart2";
import { Chart3 } from "@/components/Chart3";

export default function Home() {
  return (
    <main className="flex min-h-screen flex-col items-center justify-between p-12 gap-8">
      <h1 className="text-6xl font-bold mb-12">
        Data Visualization of Codeforces
      </h1>
      <Chart1 />
      <Chart2 />
      <Chart3 />
    </main>
  );
}
