import BarChart from "@/components/BarChart";

import { getAllStocks, getCompanyCountries } from "@/lib/queries";
import { Stock } from "@/lib/types/stock";
import CountryTable from "./country-table";

export default async function Home() {
  const datas = await getCompanyCountries();
  const stocks = await getAllStocks();
  return (
    <main className="flex min-h-screen flex-col items-center justify-between p-16">
      <h1 className="text-5xl font-bold pb-10">Companies by Countries</h1>
      <div className="flex flex-col gap-4 w-full justify-center items-center">
        <section className="w-[50%]">
          <BarChart data={datas} />
        </section>

        <CountryTable stocks={stocks} countries={datas} />
      </div>
    </main>
  );
}
