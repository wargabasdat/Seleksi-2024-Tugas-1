import { type Location } from "@/types/location";
import { type ClassValue, clsx } from "clsx";
import { differenceInDays } from "date-fns";
import { twMerge } from "tailwind-merge";

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs));
}

/**
 * Converts type Location to a formatted string
 *
 * @param location
 * @returns
 */
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

/**
 * Format date to yyyy-MM-dd format in localtime
 *
 * @param date
 * @returns
 */
export function formateDateQuery(date: Date) {
  const d = new Date(date);
  const year = d.getFullYear();
  const month = String(d.getMonth() + 1).padStart(2, "0"); // month index starts from 0
  const day = String(d.getDate()).padStart(2, "0");

  return `${year}-${month}-${day}`;
}

/**
 * Format date according to min and max date
 *
 * @param date
 * @param minDate
 * @param maxDate
 *
 * @returns formatted date
 */
export function formatDateChart(date: Date, minDate: Date, maxDate: Date) {
  const d = new Date(date);
  const min = new Date(minDate);
  const max = new Date(maxDate);

  const delta = differenceInDays(max, min);
  if (delta < 5) {
    return d.toLocaleDateString("en-US", {
      month: "short",
      day: "numeric",
      year: "numeric",
      hour: "numeric",
      hour12: true,
      minute: "numeric",
    });
  } else {
    return d.toLocaleDateString("en-US", {
      month: "short",
      day: "numeric",
      year: "numeric",
    });
  }
}

export type FormatUnit = "celcius" | "percentage" | "kmph" | "inhg";
/**
 * Format temperature to to celcius
 *
 * @param temp
 * @returns formatted temperature
 */
export function formatTemperatureCelcius(temp: number, precision: number = 1) {
  return `${temp.toFixed(precision)}°C`;
}

/**
 * Formats humidity to percentage
 *
 * @param humidity
 * @returns formatted humidity
 */
export function formatHumidity(humidity: number, precision: number = 1) {
  return `${humidity.toFixed(precision)}%`;
}

/**
 * Format wind speed to km/h
 *
 * @param windSpeed
 * @returns formatted wind speed
 */
export function formatWindSpeedKmH(windSpeed: number, precision: number = 1) {
  return `${windSpeed.toFixed(precision)} km/h`;
}

/**
 * Format pressure to inHg
 *
 * @param pressure
 * @returns
 */
export function formatPressureInHg(pressure: number, precision: number = 1) {
  return `${pressure.toFixed(precision)} inHg`;
}

/**
 * Format mapper
 */
export function mapFormatter(formatUnit: FormatUnit) {
  switch (formatUnit) {
    case "celcius":
      return formatTemperatureCelcius;
    case "percentage":
      return formatHumidity;
    case "kmph":
      return formatWindSpeedKmH;
    case "inhg":
      return formatPressureInHg;
  }
}
