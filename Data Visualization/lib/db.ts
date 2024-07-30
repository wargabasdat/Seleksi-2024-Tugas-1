import mariadb from "mariadb";

export const pool = mariadb.createPool({
  host: "localhost",
  port: 3307, // For docker mariadb, 3306 is used by local MySQL
  user: "weather_app",
  password: "123456",
  database: "weather_app",
  connectionLimit: 5,
});
