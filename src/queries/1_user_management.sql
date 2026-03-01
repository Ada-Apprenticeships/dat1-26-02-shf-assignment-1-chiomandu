.open fittrackpro.db
.mode column

-- 1.1
SELECT * FROM members;

-- 1.2
UPDATE members
SET
phone_number='07000 100005',
email='emily.jones.updated@email.com'
WHERE member_id ='5';

-- 1.3
SELECT COUNT (*) FROM members AS total_members;

-- 1.4
SELECT m.member_id, m.first_name, m.last_name,
COUNT(ca.class_attendance_id) AS registration_count FROM members AS m 
LEFT JOIN class_attendance AS ca 
ON m.member_id= ca.member_id
AND ca.attendance_status= 'Registered'
GROUP BY m.member_id, m.first_name, m.last_name
ORDER BY registration_count DESC;

-- 1.5
SELECT m.member_id, m.first_name, m.last_name,
COUNT(ca.class_attendance_id) AS registration_count FROM members AS m 
LEFT JOIN class_attendance AS ca 
ON m.member_id= ca.member_id
AND ca.attendance_status= 'Registered'
GROUP BY m.member_id, m.first_name, m.last_name
ORDER BY registration_count ASC;


-- 1.6
SELECT 
    COUNT(*) AS two_classes
FROM (
    SELECT 
        member_id,
        COUNT(class_attendance_id) AS attended_count
    FROM class_attendance
    WHERE attendance_status = 'Attended'
    GROUP BY member_id
    HAVING COUNT(class_attendance_id) <= 2
) AS member_counts;
