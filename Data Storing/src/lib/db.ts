import mariadb from "mariadb";

export const pool = mariadb.createPool({
  database: "weather_app",
  host: "localhost",
  port: 3307,
  user: "weather_app",
  password: "123456",
});
