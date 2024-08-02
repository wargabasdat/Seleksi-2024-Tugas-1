import { pool } from "../db"

export async function GET() {
    try {
        const res = await pool.query(`
SELECT 
    l.id AS level_id,
    l.name AS level_name,
    COALESCE(SUM(li.count), 0) AS total_items,
    COALESCE(SUM(lp.count), 0) AS total_power_ups,
    COALESCE(SUM(le.count), 0) AS total_enemies,
    COALESCE(SUM(lo.count), 0) AS total_obstacles
FROM 
    level l
LEFT JOIN 
    level_item li ON l.id = li.level_id
LEFT JOIN 
    level_power_up lp ON l.id = lp.level_id
LEFT JOIN 
    level_enemy le ON l.id = le.level_id
LEFT JOIN 
    level_obstacle lo ON l.id = lo.level_id
GROUP BY 
    l.id, l.name
ORDER BY
    l.id ASC;
`)
        return Response.json(res.rows)
    } catch (err) {
        console.error(err)
        return Response.json(err)
    }
}