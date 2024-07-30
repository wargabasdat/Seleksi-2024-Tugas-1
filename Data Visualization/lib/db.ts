import mariadb from "mariadb";

export async function dbQuery<T>(sql: string, params: any[] = []): Promise<T> {
  let conn;
  try {
    conn = await mariadb.createConnection({
      host: "localhost",
      port: 3307, // For docker mariadb, 3306 is used by local MySQL
      user: "weather_app",
      password: "123456",
      database: "weather_app",
    });
    const result = await conn.query(sql, params);
    return result;
  } catch (err) {
    console.error("Database query error:", err);
    throw err;
  } finally {
    if (conn) conn.end();
  }
}
