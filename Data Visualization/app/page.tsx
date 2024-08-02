import { getAllStocks } from "@/lib/queries";
import { Stock } from "@/lib/types/stock";
import MainTable from "./table";

export default async function Home() {
  const stocks = await getAllStocks();

  return (
    <main className="flex min-h-screen flex-col items-center justify-between p-16">
      <h1 className="text-5xl font-bold pb-10">
        Top 100 Companies by Market Cap
      </h1>
      <div className="flex flex-wrap gap-4 w-full">
        <MainTable stocks={stocks} />
      </div>
    </main>
  );
}
