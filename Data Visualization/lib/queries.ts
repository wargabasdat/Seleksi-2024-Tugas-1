import pool from "./db";
import { Stock } from "./types/stock";

export async function getAllStocks(): Promise<Stock[]> {
  const [rows] = await pool.query<any>(
    "SELECT * FROM stock natural join company order by current_marketcap desc"
  );
  return rows;
}

export async function getCompanyCountries(): Promise<any> {
  const [rows] = await pool.query<any>(
    "SELECT country_name, count(*) as total from company group by country_name order by total desc"
  );

  return rows;
}

export async function getCompanyCategories(): Promise<any> {
  const [rows] = await pool.query<any>(
    "SELECT category_name, count(*) as total from stock natural join stock_category group by category_name order by total desc"
  );

  return rows;
}

export async function getAllStockCategory() {
  const [rows] = await pool.query<any>("SELECT * FROM stock_category");
  return rows;
}

export async function getStocksWithCategory(category: string) {
  const [rows] = await pool.query<any>(
    "SELECT * FROM stock natural join stock_category where category_name = ?",
    [category]
  );
  return rows;
}

export async function getCompanyPerformance(company: string) {
  const [rows] = await pool.query<any>(
    "SELECT * FROM company_performance where company_name = ?",
    [company]
  );
  return rows;
}

export async function getStockDetails(stock_code: string) {
  const [rows] = await pool.query<any>(
    "SELECT * FROM stock where stock_code = ?",
    [stock_code]
  );
  return rows;
}
