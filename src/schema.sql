.open fittrackpro.db
.mode box


DROP TABLE IF EXISTS locations;
DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS staff;
DROP TABLE IF EXISTS equipment;
DROP TABLE IF EXISTS classes;
DROP TABLE IF EXISTS class_schedule;
DROP TABLE IF EXISTS memberships;
DROP TABLE IF EXISTS attendance;
DROP TABLE IF EXISTS class_attendance;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS personal_training_sessions;
DROP TABLE IF EXISTS member_health_metrics;
DROP TABLE IF EXISTS equipment_maintenance_log;

PRAGMA foreign_keys = ON;


CREATE TABLE locations
(
location_id TEXT NOT NULL PRIMARY KEY,
name TEXT NOT NULL,
address TEXT NOT NULL,
phone_number CHAR(12) NOT NULL CHECK (length(phone_number)=12),
email TEXT NOT NULL CHECK(email like '%@%'),
opening_hours TEXT
CHECK (opening_hours GLOB '[0-9][0-9]:[0-9][0-9]-[0-9][0-9]:[0-9][0-9]')
);

CREATE TABLE members
(
member_id TEXT PRIMARY KEY,
first_name TEXT NOT NULL,
last_name TEXT NOT NULL,
email TEXT NOT NULL CHECK(email like '%@%'),
phone_number CHAR(12) NOT NULL CHECK (length(phone_number)=12),
date_of_birth TEXT NOT NULL
CHECK(date_of_birth GLOB '[0-3][0-9]-[0-1][0-9]-[1-2][0-9][0-9][0-9]'),
join_date TEXT NOT NULL
CHECK(join_date GLOB '[1-2][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]'),
emergency_contact_name TEXT NOT NULL,
emergency_contact_phone CHAR(12) NOT NULL CHECK (length(emergency_contact_phone)=12)
);

CREATE TABLE staff 
(
staff_id TEXT PRIMARY KEY,
first_name TEXT,
last_name TEXT,
email TEXT,
phone_number TEXT,
position TEXT,
hire_date TEXT,
location_id TEXT,
FOREIGN KEY (location_id) REFERENCES locations(location_id)
);



CREATE TABLE equipment
(
equipment_id TEXT PRIMARY KEY,
name TEXT,
type TEXT,
purchase_date TEXT,
last_maintenance_date TEXT,
next_maintenance_date TEXT,
location_id TEXT,
FOREIGN KEY (location_id) REFERENCES locations(location_id)
);


CREATE TABLE classes
(
class_id TEXT PRIMARY KEY,
name TEXT,
description TEXT,
capacity TEXT,
duration TEXT,
location_id TEXT,
FOREIGN KEY (location_id) REFERENCES locations(location_id)
);


CREATE TABLE class_schedule
(
schedule_id TEXT PRIMARY KEY,
class_id TEXT,
staff_id TEXT,
start_time TEXT,
end_time TEXT,
FOREIGN KEY (class_id) REFERENCES classes(class_id),
FOREIGN KEY (staff_id) REFERENCES staff(staff_id) 
);


CREATE TABLE memberships 
(
membership_id TEXT PRIMARY KEY,
member_id TEXT,
type TEXT,
start_date TEXT,
end_date TEXT,
status TEXT,
FOREIGN KEY (member_id) REFERENCES members(member_id)
);


CREATE TABLE attendance 
(
attendance_id TEXT PRIMARY KEY,
member_id TEXT,
location_id TEXT,
check_in_time TEXT,
check_out_time TEXT,
FOREIGN KEY (member_id) REFERENCES members(member_id),
FOREIGN KEY (location_id) REFERENCES locations(location_id)
);


CREATE TABLE class_attendance 
(
class_attendance_id TEXT PRIMARY KEY,
schedule_id TEXT,
member_id TEXT,
attendance_status TEXT CHECK(attendance_status IN ('Registered','Attended','Unattended')),
FOREIGN KEY (schedule_id) REFERENCES class_schedule(schedule_id),
FOREIGN KEY (member_id) REFERENCES members(member_id)
);


CREATE TABLE payments 
(
payment_id TEXT PRIMARY KEY,
member_id TEXT,
amount TEXT,
payment_date TEXT,
payment_method TEXT,
description TEXT,
FOREIGN KEY (member_id) REFERENCES members(member_id)
);


CREATE TABLE personal_training_sessions
(
session_id TEXT PRIMARY KEY,
member_id TEXT,
staff_id TEXT,
session_date TEXT,
start_time TEXT,
end_time TEXT,
notes TEXT,
FOREIGN KEY (member_id) REFERENCES members(member_id),
FOREIGN KEY (staff_id) REFERENCES staff(staff_id) 
);


CREATE TABLE member_health_metrics 
(
metric_id TEXT PRIMARY KEY,
member_id TEXT,
measurement_date TEXT,
weight TEXT,
body_fat_percentage TEXT,
muscle_mass TEXT,
bmi TEXT,
FOREIGN KEY (member_id) REFERENCES members(member_id)
);


CREATE TABLE equipment_maintenance_log
(
log_id TEXT PRIMARY KEY,
equipment_id TEXT,
maintenance_date TEXT,
description TEXT,
staff_id TEXT,
FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id),
FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);