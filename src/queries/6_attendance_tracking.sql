.open fittrackpro.db
.mode column

-- 6.1 
INSERT INTO attendance (
    attendance_id, 
    member_id, 
    location_id, 
    check_in_time, 
    check_out_time)
VALUES (
    'A' || strftime('%Y%m%d%H%M%S', '2025-02-14 16:30:00'), 
    '7', 
    '1', 
    '2025-02-14 16:30:00', 
    NULL
);

-- 6.2 
SELECT 
    DATE(check_in_time) AS visit_date,
    check_in_time,
    check_out_time
FROM attendance
WHERE member_id = '5'
ORDER BY check_in_time;

-- 6.3 
SELECT
    CASE strftime('%w', check_in_time)
        WHEN '0' THEN 'Sunday'
        WHEN '1' THEN 'Monday'
        WHEN '2' THEN 'Tuesday'
        WHEN '3' THEN 'Wednesday'
        WHEN '4' THEN 'Thursday'
        WHEN '5' THEN 'Friday'
        WHEN '6' THEN 'Saturday'
    END AS day_of_week,
    COUNT(*) AS visit_count
FROM attendance
GROUP BY strftime('%w', check_in_time)
ORDER BY visit_count DESC
LIMIT 1;

-- 6.4 
WITH RECURSIVE date_range AS (
    SELECT DATE(MIN(check_in_time)) AS visit_date
FROM attendance
UNION ALL
SELECT DATE(visit_date, '+1 day')
FROM date_range
WHERE visit_date < (SELECT DATE(MAX(check_in_time)) FROM attendance)
),
daily_counts AS (
    SELECT 
        l.location_id,
        l.name AS location_name,
        d.visit_date,
        COUNT(a.attendance_id) AS daily_attendance
FROM locations l
CROSS JOIN date_range d
LEFT JOIN attendance a
        ON a.location_id = l.location_id
    AND DATE(a.check_in_time) = d.visit_date
GROUP BY l.location_id, d.visit_date
)
SELECT 
    location_name,
    ROUND(AVG(daily_attendance), 2) AS avg_daily_attendance
FROM daily_counts
GROUP BY location_id;
