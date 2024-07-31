import mariadb from "mariadb";

export async function dbQuery<T>(sql: string, params: any[] = []): Promise<T> {
  let conn;
  try {
    conn = await mariadb.createConnection({
      host: process.env.DB_HOST as string,
      port: Number(process.env.DB_PORT),
      user: process.env.DB_USER as string,
      password: process.env.DB_PASSWORD as string,
      database: process.env.DB_DATABASE as string,
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
