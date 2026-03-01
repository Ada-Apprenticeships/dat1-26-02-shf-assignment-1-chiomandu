.open fittrackpro.db
.mode column

-- 8.1 
SELECT 
pt.session_id,
m.first_name || ' ' || m.last_name AS member_name,
pt.session_date,
pt.start_time,
pt.end_time
FROM personal_training_sessions AS pt
JOIN staff AS s 
    ON pt.staff_id = s.staff_id
JOIN members AS m
    ON pt.member_id = m.member_id
WHERE s.first_name = 'Ivy'
  AND s.last_name = 'Irwin'
ORDER BY pt.session_date, pt.start_time;


