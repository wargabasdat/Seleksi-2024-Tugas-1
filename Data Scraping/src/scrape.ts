import { ScrapeStatus } from "./lib/enum";
import { weatherStations, dateRange, generateUserAgent } from "./lib/constants";
import { generateRandomDelay, generateScrapeURL } from "./lib/utils";
import { addDays } from "date-fns";
import puppeteer from "puppeteer";
import { type WeatherData } from "./models/weather-data";
import { type Location } from "./models/location";
import { ScrapeLog } from "./models/log";
import fs from "fs";
import Queue from "queue";
import fastJson from "fast-json-stringify";

/**
 * General Scraping Algorithm:
 * 1. Scrape the data from the website
 * 2. Store the scraped data into a JSON file
 */
async function scrape() {
  // Store scrape result
  const scrapedWeatherData: WeatherData[] = [];
  const scrapedLocations: Location[] = [];
  const scrapeLogs: ScrapeLog[] = [];

  const scrapedStationSet = new Set<string>(); // station (for saving location)
  const scrapedStationDateSet = new Set<string>(); // station-date (for loading cache)

  // Scrape todos
  const scrapeToDo: Array<{
    station: string;
    date: Date;
    url: string;
  }> = [];

  // Read the previous logs and results
  try {
    const previousWeatherData = fs.readFileSync("../data/weather-data.json");
    const previousLocations = fs.readFileSync("../data/locations.json");
    const previousScrapeLogs = fs.readFileSync("../data/scrape-logs.json");

    // Parse the JSON string to JSON object
    const parsedWeatherData = JSON.parse(
      previousWeatherData.toString()
    ) as WeatherData[];
    const parsedLocations = JSON.parse(
      previousLocations.toString()
    ) as Location[];
    const parsedScrapeLogs = JSON.parse(
      previousScrapeLogs.toString()
    ) as ScrapeLog[];

    // Load previous weather data
    for (const weatherData of parsedWeatherData) {
      scrapedWeatherData.push(weatherData);
    }

    // load previous locations
    for (const location of parsedLocations) {
      scrapedLocations.push(location);
    }

    // load previous scrape logs
    for (const scrapeLog of parsedScrapeLogs) {
      scrapeLogs.push(scrapeLog);

      const datetime = new Date(scrapeLog.scrapeDateTime);
      const date = datetime.toISOString().split("T")[0];
      if (
        scrapeLog.status === ScrapeStatus.SUCCESS ||
        (scrapeLog.status === ScrapeStatus.ERROR &&
          scrapeLog.error?.includes("Table not found"))
      ) {
        scrapedStationSet.add(scrapeLog.scrapeStation);
        scrapedStationDateSet.add(`${scrapeLog.scrapeStation}-${date}`);
      }
    }
  } catch (err) {
    // An error occurred
    console.log("Error reading file: ", err);
  }

  // Generate the scrape todos
  for (const station of weatherStations) {
    const startDate = dateRange.start;
    const endDate = dateRange.end;

    let date = startDate;
    while (date <= endDate) {
      // Skip if already scraped
      const datestr = date.toISOString().split("T")[0];
      if (scrapedStationDateSet.has(`${station}-${datestr}`)) {
        console.log("Skipping (cached): ", station, date);
        date = addDays(date, 1);
        continue;
      }

      // Generate the URL
      const url = generateScrapeURL(station, date);

      // Add to list
      scrapeToDo.push({
        station,
        date,
        url,
      });

      // Increment the date by 1
      date = addDays(date, 1);
    }
  }

  // Launch the browser
  const browser = await puppeteer.launch();

  // Initialize queue to scrape
  const q = new Queue({ concurrency: 10 });

  // Scrape the data
  scrapeToDo.forEach(({ station, date, url }) => {
    q.push(async () => {
      // Generate a random delay
      await generateRandomDelay();

      // Log status starting
      console.log("Starting scrape: ", url);

      const tableSelector = "div.observation-table tbody";
      const page = await browser.newPage();

      // Set the user agent, so that the website thinks that the scraping is done by a real user
      const newUserAgent = generateUserAgent();
      await page.setUserAgent(newUserAgent);

      try {
        // Throws an error if the table is not found
        await page.goto(url, { timeout: 15000 });
        await page.waitForSelector(tableSelector, { timeout: 15000 });
      } catch (error) {
        // Store the log
        const errMessage = `Table not found for ${station} on ${date}`;

        console.error(errMessage);

        scrapeLogs.push({
          scrapeStation: station,
          scrapeDateTime: date,
          logDateTime: new Date(),
          status: ScrapeStatus.ERROR,
          error: errMessage,
        });

        await page.close();

        return;
      }

      // // DEBUG
      // page.on("console", (msg) => console.log("BROWSER LOG:", msg.text()));

      // Scrape location data
      const locationSelector = "h1";
      const locationData = await page.evaluate(
        (sel, scrapeStation) => {
          const baseLocation = {
            airportCode: scrapeStation,
            city: "Unknown",
            state: "Unknown",
            country: "Unknown",
          };

          const locationElement = document.querySelector(sel);
          if (!locationElement) return baseLocation;

          const h1Text = locationElement.textContent;
          if (!h1Text) return baseLocation;

          const cscJoined = h1Text.split(" Weather History")[0];
          const cscSep = cscJoined.split(", ");
          if (cscSep.length === 3) {
            // city, state, country
            baseLocation.city = cscSep[0];
            baseLocation.state = cscSep[1];
            baseLocation.country = cscSep[2];
          } else if (cscSep.length === 2) {
            // city, country
            baseLocation.city = cscSep[0];
            baseLocation.country = cscSep[1];
          } else {
            // city
            baseLocation.city = cscSep[0];
          }

          return baseLocation;
        },
        locationSelector,
        station
      );

      // Scrape weather data
      const weatherData = await page.evaluate(
        (sel, scrapeStation, scrapeDate) => {
          const tableBody = document.querySelector(sel);
          if (!tableBody) {
            return [];
          }

          const rows = tableBody.querySelectorAll("tr");
          if (!rows || rows.length === 0) {
            return [];
          }

          const data: WeatherData[] = [];

          for (const row of Array.from(rows)) {
            const cells = row.querySelectorAll("td");

            // Parse
            // Time (required)
            const rawTime = cells[0].textContent;
            if (!rawTime) return;
            const fullTime = rawTime.trim();
            const time = fullTime.split(" ")[0];
            const ampm = fullTime.split(" ")[1];
            const tempDate = new Date(scrapeDate);
            const year = tempDate.getFullYear();
            const month = tempDate.getMonth();
            const day = tempDate.getDate();
            const hour = Number(time.split(":")[0]) + (ampm === "PM" ? 12 : 0);
            const minute = Number(time.split(":")[1]);
            const tempDateTime = new Date(year, month, day, hour, minute);
            const parsedDateTime = tempDateTime.toISOString();
            // console.log(parsedDateTime);

            // Temperature (nullable)
            // in Celcius
            let parsedTemperature: number | null = null;
            const temperatureTD = cells[1];
            const temperatureSpan =
              temperatureTD.querySelector("span.wu-value");
            if (temperatureSpan && temperatureSpan.textContent) {
              const rawTemperature = temperatureSpan.textContent.trim();
              const fahrenheitTemperature = Number(rawTemperature);
              parsedTemperature = !isNaN(fahrenheitTemperature)
                ? (fahrenheitTemperature - 32) * (5 / 9)
                : null;
            }
            // console.log(parsedTemperature);

            // Dew Point (nullable)
            // in Celcius
            let parsedDewPoint: number | null = null;
            const dewPointTD = cells[2];
            const dewPointSpan = dewPointTD.querySelector("span.wu-value");
            if (dewPointSpan && dewPointSpan.textContent) {
              const rawDewPoint = dewPointSpan.textContent.trim();
              const fahrenheitDewPoint = Number(rawDewPoint);
              parsedDewPoint = !isNaN(fahrenheitDewPoint)
                ? (fahrenheitDewPoint - 32) * (5 / 9)
                : null;
            }
            // console.log(parsedDewPoint);

            // Humidity (nullable)
            // in %
            let parsedHumidity: number | null = null;
            const humidityTD = cells[3];
            const humiditySpan = humidityTD.querySelector("span.wu-value");
            if (humiditySpan && humiditySpan.textContent) {
              const rawHumidity = humiditySpan.textContent.trim();
              const percentageHumidity = Number(rawHumidity);
              parsedHumidity = !isNaN(percentageHumidity)
                ? percentageHumidity
                : null;
            }
            // console.log(parsedHumidity);

            // Wind (nullable)
            let parsedWind: string | null = null;
            const rawWind = cells[4].textContent;
            if (rawWind) {
              parsedWind = rawWind.trim();
            }

            // Wind Speed (nullable)
            // in km/h
            let parsedWindSpeed: number | null = null;
            const windSpeedTD = cells[5];
            const windSpeedSpan = windSpeedTD.querySelector("span.wu-value");
            if (windSpeedSpan && windSpeedSpan.textContent) {
              const rawWindSpeed = windSpeedSpan.textContent.trim();
              const mphWindSpeed = Number(rawWindSpeed);
              parsedWindSpeed = !isNaN(mphWindSpeed)
                ? mphWindSpeed * 1.60934
                : null;
            }

            // Wind Gust (nullable)
            // in km/h
            let parsedWindGust: number | null = null;
            const windGustTD = cells[6];
            const windGustSpan = windGustTD.querySelector("span.wu-value");
            if (windGustSpan && windGustSpan.textContent) {
              const rawWindGust = windGustSpan.textContent.trim();
              const mphWindGust = Number(rawWindGust);
              parsedWindGust = !isNaN(mphWindGust)
                ? mphWindGust * 1.60934
                : null;
            }

            // Pressure (nullable)
            // in hPa
            let parsedPressure: number | null = null;
            const pressureTD = cells[7];
            const pressureSpan = pressureTD.querySelector("span.wu-value");
            if (pressureSpan && pressureSpan.textContent) {
              const rawPressure = pressureSpan.textContent.trim();
              const inHgPressure = Number(rawPressure);
              parsedPressure = !isNaN(inHgPressure)
                ? inHgPressure * 33.8639
                : null;
            }

            // Precipitation (nullable)
            // in hPa
            let parsedPrecipitation: number | null = null;
            const precipitationTD = cells[8];
            const precipitationSpan =
              precipitationTD.querySelector("span.wu-value");
            if (precipitationSpan && precipitationSpan.textContent) {
              const rawPrecipitation = precipitationSpan.textContent.trim();
              const inHgPrecipitation = Number(rawPrecipitation);
              parsedPrecipitation = !isNaN(inHgPrecipitation)
                ? inHgPrecipitation * 33.8639
                : null;
            }

            // Condition (nullable)
            let parsedCondition: string | null = null;
            const rawCondition = cells[9].textContent;
            if (rawCondition) {
              parsedCondition = rawCondition.trim();
            }

            // Store the data
            data.push({
              airportCode: scrapeStation,
              datetime: parsedDateTime,
              temperature: parsedTemperature,
              dewPoint: parsedDewPoint,
              humidity: parsedHumidity,
              wind: parsedWind,
              windSpeed: parsedWindSpeed,
              windGust: parsedWindGust,
              pressure: parsedPressure,
              precipitation: parsedPrecipitation,
              condition: parsedCondition,
            });
          }

          return data;
        },
        tableSelector,
        station,
        date.toString() // Must be serialized to string
      );

      // Store the scraped data
      scrapedWeatherData.push(...(weatherData ?? []));

      // Store the location
      if (!scrapedStationSet.has(station)) {
        scrapedStationSet.add(station);
        scrapedLocations.push(locationData);
      }

      // Store the log
      scrapeLogs.push({
        scrapeStation: station,
        scrapeDateTime: date,
        logDateTime: new Date(),
        status: ScrapeStatus.SUCCESS,
      });

      // Close the page
      await page.close();

      // Log
      console.log("Finishing scrape: ", station, date, url);
    });
  });

  await q.start();

  await browser.close();

  // Write to json file
  try {
    // Minify weather data (because it's too large)
    const schema = {
      title: "WeatherData",
      type: "array",
      items: {
        type: "object",
        properties: {
          airportCode: { type: "string" },
          datetime: { type: "string" },
          temperature: { type: ["number", "null"] },
          dewPoint: { type: ["number", "null"] },
          humidity: { type: ["number", "null"] },
          wind: { type: ["string", "null"] },
          windSpeed: { type: ["number", "null"] },
          windGust: { type: ["number", "null"] },
          pressure: { type: ["number", "null"] },
          precipitation: { type: ["number", "null"] },
          condition: { type: ["string", "null"] },
        },
        required: ["airportCode", "datetime"],
      },
    };

    const stringify = fastJson(schema);

    // Weather data
    console.log("Writing weather data...");
    fs.writeFileSync(
      "../data/weather-data.json",
      stringify(scrapedWeatherData)
    );
    console.log("Weather data written successfully!");

    // Location data
    console.log("Writing location data...");
    fs.writeFileSync(
      "../data/locations.json",
      JSON.stringify(scrapedLocations, null, 2)
    );
    console.log("Location data written successfully!");

    // Scrape logs
    console.log("Writing scrape logs...");
    fs.writeFileSync(
      "../data/scrape-logs.json",
      JSON.stringify(scrapeLogs, null, 2)
    );
    console.log("Scrape logs written successfully!");
  } catch (err) {
    // An error occurred
    console.log("Error writing file: ", err);

    return;
  }
}

scrape();
