import { pool } from "../db";

export async function getLocationOptions(): Promise<Location[]> {
  const query = `
    SELECT
      station_code as stationCode,
      city,
      state,
      country
    FROM
      location;
  `;

  const result = (await pool.query(query)) as Location[];

  return result;
}
