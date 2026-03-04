.open fittrackpro.db
.mode column

-- 1.1: 
SELECT *
FROM members;

-- 1.2 
UPDATE members
SET phone_number='07000 100005',
email='emily.jones.updated@email.com'
--WHERE clause ensure only member with id 5 is updated
WHERE member_id = '5';

-- 1.3 Count the total number of members
SELECT COUNT(*) AS total_members
FROM members;

-- 1.4 List all the members with the number of classes they are registered to
SELECT 
    m.member_id, 
    m.first_name, 
    m.last_name,
    COUNT(ca.class_attendance_id) AS registration_count 
FROM members AS m 
--LEFT JOIN makes sure members with zero registration are included
LEFT JOIN class_attendance AS ca 
    ON m.member_id= ca.member_id
    AND ca.attendance_status = 'Registered'
GROUP BY 
    m.member_id,
    m.first_name, 
    m.last_name
-- Orders by highest registration count first
ORDER BY registration_count DESC;

-- 1.5 List all members with resigister count 
SELECT 
    m.member_id, 
    m.first_name, 
    m.last_name,
    COUNT(ca.class_attendance_id) AS registration_count 
FROM members AS m 
LEFT JOIN class_attendance AS ca 
    ON m.member_id= ca.member_id
    AND ca.attendance_status = 'Registered'
GROUP BY 
    m.member_id, 
    m.first_name, 
    m.last_name
-- Orders by the least registration count first
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
--Results only count people who attended 2 or less classes
    HAVING COUNT(class_attendance_id) <= 2
) AS member_counts;
