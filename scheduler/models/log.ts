/**
 * Model to store the logs of the scraping process
 * Usefull to keep track of the scraping process and to debug
 * And also to "Re-scrape" the data if the scraping process failed or new data is available
 *
 * @property {string} scrapeStation - The station that was scraped
 * @property {Date} scrapeDateTime - The date and time when the scraping was done
 * @property {Date} logDateTime - The date and time when the log was created
 * @property {"success" | "failed"} status - The status of the scraping process
 * @property {string} error - The error message if the scraping process failed
 */
export interface ScrapeLog {
  scrapeStation: string;
  scrapeDateTime: Date;
  logDateTime: Date;
  status: string;
  error?: string;
}
