import { Skeleton } from "@/components/ui/skeleton";

export default async function DashboardLoadingPage() {
  return (
    <main className="flex flex-auto justify-center px-5 py-12 lg:p-16">
      <div className="w-full max-w-7xl flex flex-col gap-8">
        <header className="flex flex-col lg:flex-row lg:justify-between gap-4">
          {/* Title */}
          <Skeleton className="h-9 lg:h-10 w-48 rounded-md" />

          {/* Filters */}
          <div className="flex flex-col sm:flex-row gap-4 lg:gap-4">
            {/* Location / Station */}
            <Skeleton className="w-full sm:w-80 h-10 rounded-md" />

            {/* Date Range With Presets */}
            <Skeleton className="w-full sm:w-80 h-10 rounded-md" />
          </div>
        </header>

        <section className="grid grid-cols-2 gap-4 lg:gap-6">
          {/* Temperature line chart */}
          <Skeleton className="h-[530px] sm:h-[510px] lg:h-[467px] xl:h-[455px] rounded-lg col-span-2" />

          {/* Humidity area chart */}
          <Skeleton className="h-[530px] sm:h-[510px] lg:h-[467px] xl:h-[455px] rounded-lg col-span-2" />

          {/* Pressure line chart */}
          <Skeleton className="h-[530px] sm:h-[510px] lg:h-[467px] xl:h-[455px] rounded-lg col-span-2" />

          {/* Wind speed line chart */}
          <Skeleton className="h-[530px] sm:h-[510px] lg:h-[467px] xl:h-[455px] rounded-lg col-span-2" />

          {/* Wind direction radar chart */}
          <Skeleton className="col-span-2 lg:col-span-1 rounded-lg h-[480px] sm:h-[500px] lg:h-[545px] xl:h-[525px]" />

          {/* Weather condition pie chart */}
          <Skeleton className="col-span-2 lg:col-span-1 rounded-lg h-[480px] sm:h-[500px] lg:h-[545px] xl:h-[525px]" />

          {/* Dew Point line chart */}
          <Skeleton className="h-[530px] sm:h-[510px] lg:h-[467px] xl:h-[455px] rounded-lg col-span-2" />
        </section>
      </div>
    </main>
  );
}
