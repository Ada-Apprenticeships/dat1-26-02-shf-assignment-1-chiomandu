.open fittrackpro.db
.mode column

-- 5.1 
SELECT 
    m.member_id, 
    m.first_name, 
    m.last_name, 
--Renames ms type to membership type
    ms.type AS membership_type, 
--Renames membership start date to join_date
    ms.start_date AS join_date
--Creates the alias
FROM members AS m 
JOIN memberships AS ms
    ON m.member_id = ms.member_id
--Filter only active memberships
WHERE ms.status = 'Active';

-- 5.2 
SELECT 
--Rename type to membership type
    ms.type AS membership_type,
    AVG (
        (julianday(a.check_out_time)-julianday(a.check_in_time))*1440
--julianday() converts datetime to a julian day 
--multiply by 1400 to convert the days to minutes
-- Renames the reuslts as 'duration_time'
 ) AS duration_time 
FROM attendance AS a
JOIN memberships AS ms
    ON a.member_id = ms.member_id
-- NOT NULL ensured only completed attendances are considered
WHERE a.check_out_time IS NOT NULL
GROUP BY ms.type;

-- 5.3 
SELECT 
    m.member_id,
    m.first_name,
    m.last_name,
    m.email,
    ms.end_date
FROM members AS m
JOIN memberships AS ms
--Join members with their memberships
    ON m.member_id= ms.member_id
--Extract the year specifically 2025 to filter 
WHERE strftime ('%Y', ms.end_date)= '2025'
--Orders results by membership end date chronologically
ORDER BY ms.end_date;

