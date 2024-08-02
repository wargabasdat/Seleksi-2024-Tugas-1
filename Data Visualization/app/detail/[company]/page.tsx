import LineChart from "@/components/LineChart";
import { getCompanyPerformance } from "@/lib/queries";

const CompanyPage = async ({ params }: { params: { company: string } }) => {
  const data = await getCompanyPerformance(params.company);
  return (
    <main className="flex  flex-col items-center justify-between p-16">
      <h1 className="text-5xl font-bold pb-10">
        {params.company} performance details
      </h1>
      <div className="flex flex-col gap-4 w-full justify-center items-center">
        <LineChart data={data} />
      </div>
    </main>
  );
};

export default CompanyPage;
