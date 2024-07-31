import UserAgent from "user-agents";

/**
 * Website URL to be scraped
 */
export const webURL = "https://www.wunderground.com";

/**
 * Weather stations code to be scraped (generally located in airports)
 */
export const weatherStations = [
  "WIHH", // Jakarta
  "WIII", // Banten
  "WICC", // Bandung
  "WADD", // Bali
];

/**
 * startDate range to be scrape
 *
 */
export const startDate = new Date("2014-07-1");

/**
 * User agents to be used in scraping so that the website thinks that the scraping is done by a real user
 */
export function generateUserAgent() {
  return new UserAgent().toString();
}
