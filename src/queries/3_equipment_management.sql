.open fittrackpro.db
.mode column

-- 3.1 
SELECT 
    equipment_id, 
    name, 
    next_maintenance_date
FROM equipment
WHERE next_maintenance_date
    BETWEEN DATE('2025-01-01')    
        AND DATE ('2025-01-01','+30 days')
ORDER BY next_maintenance_date;

-- 3.2 
SELECT 
    type,
    COUNT(*) AS count 
FROM equipment 
WHERE type IN ('Cardio','Strength')
GROUP BY type;

-- 3.3 
SELECT 
    type,
    AVG (julianday('now')- julianday(purchase_date)) AS avg_age_days
FROM equipment
GROUP BY type;