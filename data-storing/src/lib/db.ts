import mariadb from "mariadb";

export const pool = mariadb.createPool({
  database: "weather-wise",
  host: "localhost",
  port: 3307,
  user: "weather-wise",
  password: "123456",
});
