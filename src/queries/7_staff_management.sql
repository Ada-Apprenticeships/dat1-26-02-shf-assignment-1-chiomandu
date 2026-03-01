.open fittrackpro.db
.mode column

-- 7.1 
SELECT staff_id, first_name, last_name,
position AS role
FROM staff
ORDER BY position, last_name, first_name;

-- 7.2 
SELECT 
s.staff_id AS trainer_id,
s.first_name || ' ' || s.last_name AS trainer_name,
COUNT(pt.session_id) AS session_count
FROM personal_training_sessions pt
JOIN staff AS s 
ON pt.staff_id = s.staff_id
WHERE s.position = 'Trainer'
AND DATE(pt.session_date)
BETWEEN DATE('now') AND DATE('now', '+30 days')
GROUP BY s.staff_id, s.first_name, s.last_name
HAVING COUNT(pt.session_id) >= 1
ORDER BY session_count DESC;
