import { webURL } from "../lib/constants";

/**
 * Generate the URL to scrape the data from
 *
 * @params stationCode: string
 * @params date: Date
 * @returns string
 */
export function generateScrapeURL(stationCode: string, date: Date) {
  // Format date to YYYY-MM-DD
  const formattedDate = date.toISOString().split("T")[0];

  return `${webURL}/history/daily/${stationCode}/date/${formattedDate}`;
}

/**
 * Generates a delay in milliseconds to mimic human behavior
 */
export function generateRandomDelay(
  min: number = 1000,
  max: number = 5000
): Promise<void> {
  const delay = Math.floor(Math.random() * (max - min + 1) + min);
  return new Promise((resolve) => setTimeout(resolve, delay));
}

// /**
//  * Converts from Fahrenheit to Celcius
//  *
//  * @param fahrenheit: number
//  */
// export function fahrenheitToCelcius(fahrenheit: number): number {
//   return (fahrenheit - 32) * (5 / 9);
// }

// /**
//  * Converts from mph to kmph
//  *
//  * @param mph: number
//  */
// export function mphToKmph(mph: number): number {
//   return mph * 1.60934;
// }

// /**
//  * Converts from inHg to hPa
//  */
// export function inHgToHpa(inHg: number): number {
//   return inHg * 33.8639;
// }
