.open fittrackpro.db
.mode column

-- 3.1 
SELECT equipment_id, name, next_maintenance_date,
FROM equipment
WHERE next_maintenance_data BETWEEN DATE('now') AND DATE ('now','+30 days');

-- 3.2 
SELECT equipment_type,
COUNT (*) AS count FROM equipment 
WHERE equipment_type IN ('Cardio','Strength')
GROUP BY equipment_type;

-- 3.3 
SELECT equipment_type,
AVG (julianday('now')- julianday(purchase_date)) AS avg_age_days
FROM equipment
GROUP BY equipment_type;

