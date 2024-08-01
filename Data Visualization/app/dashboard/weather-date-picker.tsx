"use client";

import { CalendarDatePicker } from "@/components/ui/date-picker";
import { useState } from "react";
import { DateRange } from "react-day-picker";
import { usePathname, useRouter, useSearchParams } from "next/navigation";
import { formateDateQuery } from "@/lib/utils";

export function WeatherDatePicker() {
  const pathname = usePathname();
  const router = useRouter();
  const searchParams = useSearchParams();

  // Get initial value (already validated in serverside)
  const startDateQuery = searchParams.get("startDate");
  const initialStardDate = startDateQuery
    ? new Date(startDateQuery)
    : undefined;
  const endDateQuery = searchParams.get("endDate");
  const initialEndDate = endDateQuery ? new Date(endDateQuery) : undefined;

  // Date range state
  const [selectedDateRange, setSelectedDateRange] = useState<DateRange>({
    from: initialStardDate,
    to: initialEndDate,
  });

  return (
    <CalendarDatePicker
      date={selectedDateRange}
      onDateSelect={(range) => {
        // Update state
        setSelectedDateRange(range);

        // Update URL
        const newSearchParams = new URLSearchParams(searchParams);
        newSearchParams.set("startDate", formateDateQuery(range.from));
        newSearchParams.set("endDate", formateDateQuery(range.to));
        const newURL = `${pathname}?${newSearchParams.toString()}`;
        router.push(newURL);
      }}
      variant="outline"
      className="w-full sm:w-80 justify-start font-normal"
    />
  );
}
