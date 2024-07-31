import { WeatherData } from "./models/weather-data";
import { ScrapeLog } from "./models/log";
import { Location } from "./models/location";
import mariadb from "mariadb";
import fs from "fs";
import { pool } from "./lib/db";

/**
 * 1. Read json files from data scraping
 * 2. Insert data into database
 */
async function startSeed() {
  // Read json file
  const locations: Location[] = JSON.parse(
    fs.readFileSync("../../Data Scraping/data/locations.json", "utf8")
  );
  const scrapeLogs: ScrapeLog[] = JSON.parse(
    fs.readFileSync("../../Data Scraping/data/scrape-logs.json", "utf8")
  );
  const weatherData: WeatherData[] = JSON.parse(
    fs.readFileSync("../../Data Scraping/data/weather-data.json", "utf8")
  );

  let conn: mariadb.PoolConnection | null = null;
  try {
    // Get connection
    conn = await pool.getConnection();

    // RESET TABLES
    console.log("Resetting database");
    await conn.query("DELETE FROM weather;");
    await conn.query("DELETE FROM location;");
    await conn.query("DELETE FROM scrape_logs;");

    // INSERT DATA
    // Insert scrape logs
    console.log("Inserting scrape logs");
    for (const log of scrapeLogs) {
      await conn.query(
        "INSERT INTO scrape_logs (datetime, station_code, created_at, status, error) VALUES (?, ?, ?, ?, ?)",
        [
          new Date(log.logDateTime),
          log.scrapeStation,
          new Date(log.scrapeDateTime),
          log.status,
          log.error,
        ]
      );
    }
    console.log("Scrape logs inserted");

    // Insert locations
    console.log("Inserting locations");
    for (const loc of locations) {
      await conn.query(
        "INSERT INTO location (station_code, city, state, country) VALUES (?, ?, ?, ?)",
        [loc.airportCode, loc.city, loc.state, loc.country]
      );
    }
    console.log("Locations inserted");

    // Insert weather data
    console.log("Inserting weather data");
    for (const data of weatherData) {
      await conn.query(
        "INSERT INTO weather (station_code, datetime, temperature, dew_point, humidity, wind, wind_speed, wind_gust, pressure, precipitation, `condition`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
        [
          data.airportCode,
          new Date(data.datetime),
          data.temperature,
          data.dewPoint,
          data.humidity,
          data.wind,
          data.windSpeed,
          data.windGust,
          data.pressure,
          data.precipitation,
          data.condition,
        ]
      );
    }
    console.log("Weather data inserted");

    console.log("Seed completed");
  } catch (error) {
    console.error("Error seeding the database", error);
  } finally {
    // Release connection
    if (conn) await conn.end();

    // Close pool
    await pool.end();
  }
}

startSeed();
