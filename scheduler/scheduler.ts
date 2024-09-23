import schedule from "node-schedule";
import { dbQuery } from "./lib/db";
import { ScrapeLog } from "./models/log";
import { generateUserAgent, startDate, weatherStations } from "./lib/constants";
import { generateRandomDelay, generateScrapeURL } from "./lib/utils";
import { addDays, startOfDay } from "date-fns";
import { WeatherData } from "./models/weather-data";
import puppeteer from "puppeteer";
import Queue from "queue";
import { ScrapeStatus } from "./lib/enum";

/**
 * General algorithm:
 * 1. read scrape_logs from the database, get the latest success log for each station
 * 2. generate ids and dates to be scraped
 * 3. scrape data. if data > latest success log, insert to the database
 * 4. insert new data to the database (update scrape_logs and weather table)
 *
 */
async function funcJob() {
  console.log("====================================");
  console.log("Starting Job AT: " + new Date());

  // 1. read scrape_logs from the database, get the latest success log for each station
  const stationLatestScrapeMap = new Map<string, Date>();

  const eachStationLatestWeather = await dbQuery<WeatherData[]>(
    `
      SELECT
        station_code as airportCode,
        datetime as datetime
      FROM
        weather
      WHERE
        (station_code, datetime) IN (
          SELECT
            station_code,
            MAX(datetime)
          FROM 
            weather
          GROUP BY
            station_code
        );    
    `
  );
  eachStationLatestWeather.forEach((weather) => {
    stationLatestScrapeMap.set(weather.airportCode, new Date(weather.datetime));
  });

  // 2. generate ids and dates to be scraped
  // scrape id starts from the latest day (handle if some of the data from the day is already scraped) until today
  const scrapeToDo: Array<{
    station: string;
    date: Date;
    url: string;
  }> = [];

  for (const [station, lastScrapeDate] of stationLatestScrapeMap) {
    let start = startOfDay(lastScrapeDate);
    const end = startOfDay(new Date());

    let d = start;
    while (d <= end) {
      const date = d;
      const url = generateScrapeURL(station, date);
      scrapeToDo.push({ station, date, url });

      d = addDays(d, 1);

      console.log("Scrape to do: ", station, date, url);
    }
  }

  // 3. scrape data. if data > latest success log, insert to the database
  // location is not added because of json limit in github, so only updates day to day data
  const newWeatherData: WeatherData[] = [];
  const newScrapeLogs: ScrapeLog[] = [];

  // Launch the browser
  const browser = await puppeteer.launch({
    executablePath: "/usr/bin/chromium-browser",
    args: ["--no-sandbox", "--disable-setuid-sandbox"],
    timeout: 60000,
    protocolTimeout: 300000,
  });

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
        await page.goto(url, { timeout: 30000 });
        await page.waitForSelector(tableSelector, { timeout: 30000 });
      } catch (error) {
        // Store the log
        const errMessage = `Table not found for ${station} on ${date}`;

        console.error(errMessage);

        newScrapeLogs.push({
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
      // only if the data is newer than the latest success log
      const latestStationDate = stationLatestScrapeMap.get(station);
      if (latestStationDate && date > latestStationDate) {
        newWeatherData.push(...(weatherData ?? []));
      }

      // Store the log
      newScrapeLogs.push({
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

  // 4. insert new data to the database (update scrape_logs and weather table)
  console.log("Inserting scrape logs");
  for (const log of newScrapeLogs) {
    await dbQuery(
      "INSERT INTO scrape_logs (datetime, station_code, created_at, status, error) VALUES (?, ?, ?, ?, ?)",
      [
        new Date(log.scrapeDateTime),
        log.scrapeStation,
        new Date(log.logDateTime),
        log.status,
        log.error,
      ]
    );
  }
  console.log("Scrape logs inserted");

  // Insert weather data
  console.log("Inserting weather data");
  for (const data of newWeatherData) {
    await dbQuery(
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

  console.log("Job completed AT " + new Date());
  console.log("====================================");
}

// Railway cron job:
// The job schedule is configured from railway, not here
funcJob();

// Docker:
// // Run the job every 24 hour at 3 am and when the program starts
// // NOTE: PROGRAM MUST ALWAYS BE RUNNING
// const job = schedule.scheduleJob("0 3 * * *", funcJob);
// job.invoke();
