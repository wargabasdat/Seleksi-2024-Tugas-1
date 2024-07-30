import { type Location } from "@/types/location";
import { type ClassValue, clsx } from "clsx";
import { twMerge } from "tailwind-merge";

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs));
}

export function locationFormatter(location: Location) {
  const combined: string[] = [];
  if (location.city && location.city != "Unknown") {
    combined.push(location.city);
  }
  if (location.state && location.state != "Unknown") {
    combined.push(location.state);
  }
  if (location.country && location.country != "Unknown") {
    combined.push(location.country);
  }

  if (combined.length === 0) {
    return location.stationCode;
  }

  return combined.join(", ");
}

export function formateDateQuery(date: Date) {
  // yyyy-MM-dd in localtime
  const d = new Date(date);
  const year = d.getFullYear();
  const month = String(d.getMonth() + 1).padStart(2, "0"); // month index starts from 0
  const day = String(d.getDate()).padStart(2, "0");

  return `${year}-${month}-${day}`;
}
