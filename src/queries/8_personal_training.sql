.open fittrackpro.db
.mode column

-- 8.1 
SELECT 
    pt.session_id,
-- Combines member's first and last name into a single column
    m.first_name || ' ' || m.last_name AS member_name,
    pt.session_date,
    pt.start_time,
    pt.end_time
FROM personal_training_sessions AS pt
JOIN staff AS s 
    ON pt.staff_id = s.staff_id
JOIN members AS m
    ON pt.member_id = m.member_id
--Filter fir trainer  first and last name
WHERE s.first_name = 'Ivy'
  AND s.last_name = 'Irwin'
--Order sessions chronologically
ORDER BY pt.session_date, pt.start_time;


