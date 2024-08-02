import BarChart from "@/components/BarChart";

import {
  getAllStocks,
  getCompanyCategories,
  getCompanyCountries,
} from "@/lib/queries";
import CategoryTable from "./category-table";
import CategoryBarChart from "@/components/CategoryBarChart";

export default async function Home() {
  const datas = await getCompanyCategories();

  return (
    <main className="flex min-h-screen flex-col items-center justify-between p-16">
      <h1 className="text-5xl font-bold pb-10">Companies by Countries</h1>
      <div className="flex flex-col gap-4 w-full justify-center items-center">
        <section className="w-[50%]">
          <CategoryBarChart data={datas} />
        </section>

        <CategoryTable categories={datas} />
      </div>
    </main>
  );
}
