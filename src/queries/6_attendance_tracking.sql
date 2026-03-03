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
    'A' || strftime('%Y%m%d%H%M%S', CURRENT_TIMESTAMP),
--Generates a unique id with the timestamp
    '7', 
    '1', 
    CURRENT_TIMESTAMP,
    NULL
);

-- 6.2 
SELECT 
    DATE(check_in_time) AS visit_date,
--Extract only the date so its easier to read
    check_in_time,
    check_out_time
FROM attendance
-- Filter for that specific member
WHERE member_id = '5'
--Chronologically order visits
ORDER BY check_in_time;

-- 6.3 
SELECT
    CASE strftime('%w', check_in_time)
-- %W return day of week as 0 (Sunday) to 6 (Saturday)
        WHEN '0' THEN 'Sunday'
        WHEN '1' THEN 'Monday'
        WHEN '2' THEN 'Tuesday'
        WHEN '3' THEN 'Wednesday'
        WHEN '4' THEN 'Thursday'
        WHEN '5' THEN 'Friday'
        WHEN '6' THEN 'Saturday'
    END AS day_of_week,
--Count visits per day
    COUNT(*) AS visit_count
FROM attendance
GROUP BY strftime('%w', check_in_time)
--Group by numeric day of week
ORDER BY visit_count DESC
--Only return the day with most visits
LIMIT 1;

-- 6.4 
WITH RECURSIVE date_range AS (
    SELECT DATE(MIN(check_in_time)) AS visit_date
FROM attendance
UNION ALL
SELECT DATE(visit_date, '+1 day')
--Add one day iteratively
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
--Create all possible location and date combinations
CROSS JOIN date_range AS d
LEFT JOIN attendance AS a
        ON a.location_id = l.location_id
    AND DATE(a.check_in_time) = d.visit_date
--Count attendance per location per day
GROUP BY l.location_id, d.visit_date
)
SELECT 
    location_name,
    ROUND(AVG(daily_attendance), 2) AS avg_daily_attendance
FROM daily_counts
--Average daily attendance per location
GROUP BY location_id;
