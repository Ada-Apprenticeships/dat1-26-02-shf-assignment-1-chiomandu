.open fittrackpro.db
.mode column

-- 7.1 
SELECT 
    staff_id, 
    first_name, 
    last_name,
--Renames position to role
    position AS role
FROM staff
--Order by position, then last name alphabetically then first name 
ORDER BY position, last_name, first_name;

-- 7.2 
SELECT 
    s.staff_id AS trainer_id,
    s.first_name || ' ' || s.last_name AS trainer_name,
    COUNT(pt.session_id) AS session_count
FROM personal_training_sessions pt
JOIN staff AS s 
--Join to get trainer info
    ON pt.staff_id = s.staff_id
--Only include staff who are trainers
WHERE s.position = 'Trainer'
--Filters sessions in 30 day window
    AND DATE(pt.session_date) BETWEEN DATE('2025-01-20') 
    AND DATE('2025-01-20', '+30 days')
GROUP BY s.staff_id, s.first_name, s.last_name
--Include only trainers who have one or 1 sessions
HAVING COUNT(pt.session_id) >= 1
ORDER BY session_count DESC;
