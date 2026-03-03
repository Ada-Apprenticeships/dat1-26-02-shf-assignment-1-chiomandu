.open fittrackpro.db
.mode column

-- 4.1 
SELECT 
    c.class_id, 
    c.name AS class_name,
    s.first_name AS instructor_name
FROM class_schedule AS cs
JOIN classes AS c
    ON cs.class_id = c.class_id
JOIN staff AS s
    ON cs.staff_id = s.staff_id;

-- 4.2 
SELECT 
    c.class_id, 
    c.name, 
    cs.start_time, 
    cs.end_time,
    c.capacity AS available_spots
FROM classes AS c 
JOIN class_schedule AS cs 
    ON c.class_id = cs.class_id
LEFT JOIN class_attendance AS a 
    ON cs.schedule_id = a.schedule_id
WHERE DATE (cs.start_time) = '2025-02-01'
GROUP BY cs.schedule_id;

-- 4.3 
INSERT INTO class_attendance(
    schedule_id, 
    member_id, 
    attendance_status
)
VALUES (
    1,
    11, 
    'Registered'
);

-- 4.4 
DELETE FROM class_attendance
WHERE member_id=3 
    AND schedule_id =7;


-- 4.5
SELECT 
    c.class_id, 
    c.name AS class_name, 
    COUNT(a.member_id) AS registration_count
FROM classes AS c 
JOIN class_schedule AS cs 
    ON c.class_id = cs.class_id
JOIN class_attendance AS a 
    ON cs.schedule_id = a.schedule_id
WHERE a.attendance_status = 'Registered'
GROUP BY 
    c.class_id, 
    c.name 
ORDER BY registration_count DESC 
LIMIT 3;

-- 4.6 
SELECT 
    AVG(class_count) AS average_classes_per_member 
FROM (
    SELECT 
        member_id, 
        COUNT(*)AS class_count
FROM class_attendance
GROUP BY member_id
);
