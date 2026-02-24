.open fittrackpro.db
.mode column

-- 4.1 
SELECT c.class_id, c.class_name,i.instructor_name
FROM classes AS c
JOIN instructors AS i 
ON c.instructor_id = i.instructor_id;

-- 4.2 
SELECT class.id,name,start_time,end_time,available_spots
FROM classes
WHERE class_date = '2025-02-01';

-- 4.3 
INSERT INTO class_attendance(member_id, class_id, class_date)
VALUES (11,1,'2025-02-01');

-- 4.4 
DELETE FROM class_attendance
WHERE member_id=3 AND schedule_id =7;

-- 4.5
SELECT c.class_id, c.class_name, COUNT(a.attendance_id) AS registration_count
FROM classes AS c 
JOIN class.attendance AS a 
ON c.class_id = a.class_id
GROUP BY c.class_id, c.class_name 
ORDER BY registration_count DESC LIMIT 3;

-- 4.6 

