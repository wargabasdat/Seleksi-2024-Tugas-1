import fs from "fs";
import mariadb from "mariadb";

// Initialize connection instance
const pool = mariadb.createPool({
  database: "weather_app",
  host: "localhost",
  port: 3307,
  user: "weather_app",
  password: "123456",
});

/**
 * 1. Resets the database
 * 2. Migrates the schmea from ../export/schema.sql
 */
const migrate = async () => {
  let conn: mariadb.PoolConnection | null = null;

  try {
    console.log("Starting migration");

    // Get connection
    conn = await pool.getConnection();

    // Read file
    const sqlSchema = fs.readFileSync("../export/schema.sql", "utf8");
    const statements = sqlSchema.split(";").filter((stmt) => stmt.trim());

    for (const statement of statements) {
      // Execute statement
      await conn.query(statement);
    }

    console.log("Migration completed");
  } catch (error) {
    // Log error
    console.error("Error migrating the database", error);
  } finally {
    // Release connection
    if (conn) await conn.end();

    // Close pool
    await pool.end();
  }
};

migrate();
