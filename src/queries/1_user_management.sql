.open fittrackpro.db
.mode column

-- 1.1
SELECT * FROM members

-- 1.2
UPDATE members
SET
phone_number='07000 100005',
email='emily.jones.updated@email.com'
WHERE member_id '5';

-- 1.3
SELECT COUNT * AS total_members
FROM members;

-- 1.4
SELECT 
m.member_id, m.first_name, m.last_name,
COUNT(ca.class_attendance_id) AS registration_count FROM member AS m 
LEFT JOIN class_attendance AS ca 


-- 1.5


-- 1.6

