.open fittrackpro.db
.mode column

-- 5.1 
SELECT m.member_id, m.first_name, m.last_name, 
ms.type AS membership_type, 
ms.start_date AS join_date
FROM members AS m 
JOIN memberships AS ms
ON m.member_id = ms.member_id
WHERE ms.status = 'Active';

-- 5.2 
SELECT ms.membership_type,
AVG ((julianday(gv.checkout_time)-julianday(gv.checkin_time))*1440) AS duration_time
FROM memberships AS gv
JOIN members AS m 
ON v.member_id = m.member_id
JOIN membership AS ms
ON m.member_id = ms.member_id
GROUP BY
ms.membership_type;

-- 5.3 
SELECT m.member_id,m.first_name,m.last_name,m.email,ms.end_date
FROM members AS m
JOIN memberships AS ms
ON m.member_id= ms.member_id
WHERE DATE (ms.end_date)BETWEEN DATE('now') AND DATE('now', '+1 year');
