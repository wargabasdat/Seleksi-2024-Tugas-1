"use client";

import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { locationFormatter } from "@/lib/utils";
import { type Location } from "@/types/location";
import { useRouter, usePathname, useSearchParams } from "next/navigation";

interface LocationSelectProps {
  options: Location[];
}

export function LocationSelect({ options }: LocationSelectProps) {
  const pathname = usePathname();
  const router = useRouter();
  const searchParams = useSearchParams();

  // Get initial value (already validated in serverside)
  const defaultValue = searchParams.get("station") || undefined;

  return (
    <Select
      defaultValue={defaultValue}
      onValueChange={(value) => {
        // Update URL
        const newSearchParams = new URLSearchParams(searchParams);
        newSearchParams.set("station", value);
        const newURL = `${pathname}?${newSearchParams.toString()}`;
        router.push(newURL);
      }}
    >
      <SelectTrigger className="w-full sm:w-80">
        <SelectValue placeholder="Select location" />
      </SelectTrigger>
      <SelectContent>
        {options.map((location) => (
          <SelectItem key={location.stationCode} value={location.stationCode}>
            {locationFormatter(location)}
          </SelectItem>
        ))}
      </SelectContent>
    </Select>
  );
}
