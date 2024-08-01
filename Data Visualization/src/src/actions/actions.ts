"use server";

import pool from "@/lib/db";
import { TContestFrequency, TProblemRating, TProblemTag } from "@/lib/types";
import { ResultSetHeader, RowDataPacket } from "mysql2";

export async function getProblemsDistributionByRating(): Promise<
  TProblemRating[]
> {
  const [rows] = await pool.query(`
        SELECT rating, COUNT(*) as count
        FROM Problem
        GROUP BY rating
        ORDER BY rating
    `);

  // Transform the result set
  const transformedRows = (rows as TProblemRating[]).map((row) => {
    return {
      rating: row.rating === null ? "unrated" : String(row.rating),
      count: row.count,
    };
  });

  return transformedRows;
}

export async function getProblemsDistributionByTag(): Promise<TProblemTag[]> {
  const [rows] = await pool.query(`
        SELECT tag_name, COUNT(*) as count
        FROM ProblemTag
        GROUP BY tag_name
        ORDER BY count DESC
    `);

  return rows as TProblemTag[];
}

export async function getFrequencyOfEachContestType(): Promise<TContestFrequency> {
  type TResult = { count: number };

  const [rows1] = await pool.query<RowDataPacket[]>(`
  SELECT COUNT(*) as count
  FROM Contest
  WHERE name LIKE '%Div. 1%' OR name LIKE '%div. 1%'
`);

  const [rows2] = await pool.query<RowDataPacket[]>(`
  SELECT COUNT(*) as count
  FROM Contest
  WHERE name LIKE '%Div. 2%' OR name LIKE '%div. 2%'
`);

  const [rows3] = await pool.query<RowDataPacket[]>(`
  SELECT COUNT(*) as count
  FROM Contest
  WHERE name LIKE '%Div. 3%' OR name LIKE '%div. 3%'
`);

  const [rows4] = await pool.query<RowDataPacket[]>(`
  SELECT COUNT(*) as count
  FROM Contest
  WHERE name LIKE '%Div. 4%' OR name LIKE '%div. 4%'
`);

  const [rows5] = await pool.query<RowDataPacket[]>(`
  SELECT COUNT(*) as count
  FROM Contest
  WHERE name LIKE '%Global%' OR name LIKE '%global%'
`);

  const [rows6] = await pool.query<RowDataPacket[]>(`
  SELECT COUNT(*) as count
  FROM Contest
  WHERE name LIKE '%ICPC%' OR name LIKE '%icpc%'
`);

  const [rows7] = await pool.query<RowDataPacket[]>(` 
  SELECT COUNT(*) as count
  FROM Contest
  WHERE name NOT LIKE '%Div. 1%' AND name NOT LIKE '%div. 1%'
  AND name NOT LIKE '%Div. 2%' AND name NOT LIKE '%div. 2%'
  AND name NOT LIKE '%Div. 3%' AND name NOT LIKE '%div. 3%'
  AND name NOT LIKE '%Div. 4%' AND name NOT LIKE '%div. 4%'
  AND name NOT LIKE '%Global%' AND name NOT LIKE '%global%'
  AND name NOT LIKE '%ICPC%' AND name NOT LIKE '%icpc%'
`);

  const result = {
    "Div. 1": (rows1 as TResult[])[0].count,
    "Div. 2": (rows2 as TResult[])[0].count,
    "Div. 3": (rows3 as TResult[])[0].count,
    "Div. 4": (rows4 as TResult[])[0].count,
    Global: (rows5 as TResult[])[0].count,
    ICPC: (rows6 as TResult[])[0].count,
    Other: (rows7 as TResult[])[0].count,
  } as TContestFrequency;

  return result;
}
