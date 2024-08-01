# WeatherWise.

<p align="center">
<img
  src="https://raw.githubusercontent.com/dewodt/Seleksi-2024-Tugas-1/main/Data%20Visualization/public/link-preview.jpg" alt="Weather Wise Logo"
  width="500">
</p>

## Description

Your interactive dashboard for comprehensive weather analytics. Explore historical data for any city, with customizable timeframes and detailed visualizations.

## Tools / Library Used

- [MariaDB](https://mariadb.org/) v10 (SQL Database, For you, M. 😀)
- [Next.js](https://nextjs.org/) v14.2.5 (Full-stack Framework)
- [TailwindCSS](https://tailwindcss.com/) (CSS library)
- [shadcn/ui](https://ui.shadcn.com/) (UI library)
- [docker](https://www.docker.com/) (Container)
- [date-fns](https://date-fns.org/) (Date utility)
- [zod](https://zod.dev/) (Validation utility)
- [recharts](https://recharts.org/en-US/) (Chart library)
- [puppeteer](https://pptr.dev/) (Scraping library)pu
- [queue](https://www.npmjs.com/package/queue) (Queue utility)
- [node-schedule](https://www.npmjs.com/package/node-schedule) (Scheduler in Node.js)

## How To Run

### With Docker (RECOMMENDED)

1. Make sure docker daemon is running.

2. Setup docker network.

   ```bash
   make init-network
   ```

   or (if you don't have a makefile)

   ```bash
   docker network create weather_app_network
   ```

3. Setup docker database.

   ```bash
   make run-db
   ```

   or (if you don't have a makefile)

   ```bash
   docker compose up --build db
   ```

   **NOTE:**

   - This will automatically fill the database with the dump from `./Data Storing/export/dump-seeded.sql`.

   - The database will be available at `PORT 3307` (host port) and `PORT 3306` (container port). Thus IF you want to connect to this database docker container from the CLI run

     ```bash
     mariadb -h localhost -P 3307 -u weather_app -p123456
     ```

4. Setup docker app.

   - For production (faster, no hot reload):

     ```bash
     make run-app-prod
     ```

     or (if you don't have a makefile)

     ```bash
     docker compose up --build app-prod
     ```

   - For development (much slower, but with hot reload):

     ```bash
     make run-app-dev
     ```

     or (if you don't have a makefile)

     ```bash
     docker compose up --build app-dev
     ```

5. Setup scheduler.

   ```bash
   make run-scheduler
   ```

   or (if you don't have a makefile)

   ```bash
   docker compose up --build scheduler
   ```

   **NOTE:**

   - The container must be kept on running for the scheduler to work continously.

6. Stopping the docker containers.

   ```bash
   make stop
   ```

   or (if you don't have a makefile)

   ```bash
   docker compose down
   ```

7. Resetting the docker container and volumes.

   ```bash
   make run-reset-db
   ```

   or (if you don't have a makefile)

   ```bash
   docker compose down -v
   sudo rm -rf ./db_data
   ```

### Without Docker (NOT RECOMMENDED)

1.  Make sure to have Node.js and MariaDB locally

2.  Create a local database `weather_app`, with a new user `weather_app` and password `123456` and load the dump data from `./Data Storing/export/dump-seeded.sql`.

3.  Setup app.

    1.  Go to `./Data Visualization` directory

        ```bash
        cd Data Visualization
        ```

    2.  Create `.env` file om `./Data Visualization/`

        ```bash
        # NON DOCKER USAGE
        DB_HOST=localhost
        DB_PORT=3306 # Your mariadb port
        DB_USER=weather_app
        DB_PASSWORD=123456
        DB_ROOT_PASSWORD=123456
        DB_DATABASE=weather_app
        ```

    3.  Install dependency

        ```bash
        npm install
        ```

    4.  For production,

        ```bash
        npm run build
        ```

        ```bash
        npm run start
        ```

    5.  For development,

        ```
        npm run dev
        ```

4.  Setup scheduler.

    1. Go to `./Scheduler/` directory

       ```bash
       cd Scheduler
       ```

    2. Create `.env` file om `./Scheduler/`

       ```bash
       # NON DOCKER USAGE
       DB_HOST=localhost
       DB_PORT=3306 # Your mariadb port
       DB_USER=weather_app
       DB_PASSWORD=123456
       DB_ROOT_PASSWORD=123456
       DB_DATABASE=weather_app
       ```

    3. Install dependency

       ```bash
       npm install
       ```

    4. Run the scheduler (must be kept on running)

       ```bash
       npx tsx scheduler.ts
       ```

### OTHERS

The scripts that are written in `./Data Scraping` was used to get the first version of the scraped data (stored in json `./Data Scraping/data`).
**NOTE: this script only updates the json files and is not containerized.** To run this script,

1. Go to `./Data Scraping/src` directory

   ```bash
   cd ./Data Scraping/src
   ```

2. Install dependency

   ```bash
   npm install
   ```

3. Run the script

   ```bash
   npx tsx scrape.ts
   ```

The scripts that are written in `./Data Storing` was used to insert the first scraped data from `./Data Scraping/data/*.json` into the database. **NOTE: this script is not containzerized.** To run this script,

1. Go to `./Data Storing/src` directory

   ```bash
   cd ./Data Storing/src
   ```

2. Install dependency

   ```bash
   npm install
   ```

3. Run the script

   ```bash
   npx tsx seed.ts
   ```

**NOTE: Overall, it is not recommended to use the two scripts above because it takes a long time to re-scrape all of the data. For updating the database with new data from the website, we recommend using `Scheduling` script.**

## Initial Data Scraping

The weather data is scraped from [https://www.wunderground.com](https://www.wunderground.com/history/) using puppeteer. Scraping is done using a job queue to prevent too many request error. Because of GitHub limitation file size of 100 MB (it won't let me upload beyond this, also tried git large file storage), I limitted the weather location to be scrape. General scraping algorithm:

1. Read previous scraping results.
2. Generate URLs to be scraped and push the to scraping queue.
3. Run the scraping queue.
4. Write data to the json files.

| ![Cached Scraping](<https://github.com/dewodt/Seleksi-2024-Tugas-1/blob/main/Data%20Scraping/screenshot/cached%20(previously%20scraped).jpeg?raw=true>) |
| :-----------------------------------------------------------------------------------------------------------------------------------------------------: |
|                                                                 Cached Scraping Result                                                                  |

| ![space-1.jpg](<https://github.com/dewodt/Seleksi-2024-Tugas-1/blob/main/Data%20Scraping/screenshot/not-cached%20(previously%20not%20scraped).jpeg?raw=true>) |
| :-----------------------------------------------------------------------------------------------------------------------------------------------------------: |
|                                                                       Uncached Scraping                                                                       |

## Data Storing

The ERD/relational design is quite simple since there isn't much entity in this topic.

| ![ERD Design](https://github.com/dewodt/Seleksi-2024-Tugas-1/blob/main/Data%20Storing/design/erd.png?raw=true) |
| :------------------------------------------------------------------------------------------------------------: |
|                                                   ERD Design                                                   |

| ![Relational Diagram Design](https://github.com/dewodt/Seleksi-2024-Tugas-1/blob/main/Data%20Storing/design/relational.png?raw=true) |
| :----------------------------------------------------------------------------------------------------------------------------------: |
|                                                      Relational Diagram Design                                                       |

Here is proof that the data was successfully inserted.

| ![location](https://github.com/dewodt/Seleksi-2024-Tugas-1/blob/main/Data%20Storing/screenshot/locations.png?raw=true) |
| :--------------------------------------------------------------------------------------------------------------------: |
|                                                       `location`                                                       |

| ![scrape_logs table](https://github.com/dewodt/Seleksi-2024-Tugas-1/blob/main/Data%20Storing/screenshot/scrape_logs.png?raw=true) |
| :-------------------------------------------------------------------------------------------------------------------------------: |
|                                                           `scrape_logs`                                                           |

| ![Weather table](https://github.com/dewodt/Seleksi-2024-Tugas-1/blob/main/Data%20Storing/screenshot/weather.png?raw=true) |
| :-----------------------------------------------------------------------------------------------------------------------: |
|                                                         `weather`                                                         |

## Data Visualization

Data visualization dashboard is made using Next.js. Here is a few screenshots of the application.

| ![Home Page](https://github.com/dewodt/Seleksi-2024-Tugas-1/blob/main/Data%20Visualization/public/ss-1.jpeg?raw=true) |
| :-------------------------------------------------------------------------------------------------------------------: |
|                                                       Home Page                                                       |

| ![Dashboard Part #1](https://github.com/dewodt/Seleksi-2024-Tugas-1/blob/main/Data%20Visualization/public/ss-2.jpeg?raw=true) |
| :---------------------------------------------------------------------------------------------------------------------------: |
|                                                       Dashboard Part #1                                                       |

| ![Dashboard Part #2](https://github.com/dewodt/Seleksi-2024-Tugas-1/blob/main/Data%20Visualization/public/ss-3.jpeg?raw=true) |
| :---------------------------------------------------------------------------------------------------------------------------: |
|                                                       Dashboard Part 2                                                        |

| ![Dashboard Part #3](https://github.com/dewodt/Seleksi-2024-Tugas-1/blob/main/Data%20Visualization/public/ss-4.jpeg?raw=true) |
| :---------------------------------------------------------------------------------------------------------------------------: |
|                                                       Dashboard Part 3                                                        |

| ![Dashboard Part #4](https://github.com/dewodt/Seleksi-2024-Tugas-1/blob/main/Data%20Visualization/public/ss-5.jpeg?raw=true) |
| :---------------------------------------------------------------------------------------------------------------------------: |
|                                                       Dashboard Part #4                                                       |

| ![Dashboard Part #5](https://github.com/dewodt/Seleksi-2024-Tugas-1/blob/main/Data%20Visualization/public/ss-6.jpeg?raw=true) |
| :---------------------------------------------------------------------------------------------------------------------------: |
|                                                       Dashboard Part #5                                                       |

## Scheduler

The scheduler is useful to update the database with new weather data from the [https://www.wunderground.com](https://www.wunderground.com/history/). **NOTE that the scheduler only updates the database, and do not update the json files in `./Data Scraping`.** General algorithm:

1. Read scrape_logs from the database and find the latest successfull scrape log for each station.
2. Generate the URLs to be scraped.
3. Scrape the new data.
4. Insert data to the database.

Here are a few screenshots of the Scheduler script.

| ![Scheduler Script Running](https://github.com/dewodt/Seleksi-2024-Tugas-1/blob/main/Scheduler/public/scheduler-running.jpeg?raw=true) |
| :------------------------------------------------------------------------------------------------------------------------------------: |
|                                                        Scheduler Script Running                                                        |

| ![Scraping Dates (Newest by scheduler script is at August 1st)](https://github.com/dewodt/Seleksi-2024-Tugas-1/blob/main/Scheduler/public/scrape-log-date-proof.jpeg?raw=true) |
| :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------: |
|                                                          Scraping Dates (Newest by scheduler script is at August 1st)                                                          |

## Reference

- [https://www.wunderground.com](https://www.wunderground.com/history/) (Weather data history source)

## Author

|   NIM    |        Nama         |
| :------: | :-----------------: |
| 13522011 | Dewantoro Triatmojo |
