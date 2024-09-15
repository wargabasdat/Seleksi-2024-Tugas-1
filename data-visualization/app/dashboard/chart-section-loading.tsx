import { Skeleton } from "@/components/ui/skeleton";

export function ChartSectionLoading() {
  return (
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
  );
}
