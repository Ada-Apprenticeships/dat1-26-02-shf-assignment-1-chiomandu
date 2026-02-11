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
CHECK(date_of_birth GLOB '[1-2][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]'),
join_date TEXT NOT NULL
CHECK(join_date GLOB '[1-2][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]'),
emergency_contact_name TEXT NOT NULL,
emergency_contact_phone CHAR(12) NOT NULL CHECK (length(emergency_contact_phone)=12)
);

CREATE TABLE staff 
(
staff_id TEXT PRIMARY KEY,
first_name TEXT NOT NULL,
last_name TEXT NOT NULL,
email TEXT NOT NULL CHECK(email like '%@%'),
phone_number CHAR(12) NOT NULL
CHECK (length(phone_number)=12),
position TEXT NOT NULL 
CHECK (position IN('Trainer','Manager', 'Receptionist', 'Maintenance')),
hire_date TEXT NOT NULL 
CHECK (hire_date GLOB '[1-2][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]') ,
location_id TEXT NOT NULL,
FOREIGN KEY (location_id) REFERENCES locations(location_id)
);


CREATE TABLE equipment
(
equipment_id TEXT PRIMARY KEY,
name TEXT NOT NULL,
type TEXT NOT NULL
CHECK (type IN('Cardio', 'Strength')),
purchase_date TEXT NOT NULL
CHECK(purchase_date GLOB '[1-2][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]'),
last_maintenance_date TEXT
CHECK (last_maintenance_date GLOB '[1-2][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]'),
next_maintenance_date TEXT
CHECK (next_maintenance_date GLOB '[1-2][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]'),
location_id TEXT NOT NULL,
FOREIGN KEY (location_id) REFERENCES locations(location_id)
);


CREATE TABLE classes
(
class_id TEXT PRIMARY KEY,
name TEXT NOT NULL,
description TEXT,
capacity INTEGER NOT NULL CHECK (capacity > 0),
duration INTEGER NOT NULL CHECK (duration > 0),
location_id TEXT NOT NULL,
FOREIGN KEY (location_id) REFERENCES locations(location_id)
);


CREATE TABLE class_schedule
(
schedule_id TEXT PRIMARY KEY,
class_id TEXT NOT NULL,
staff_id TEXT NOT NULL,
start_time TEXT NOT NULL
CHECK(start_time GLOB '[1-2][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9] [0-2][0-9]:[0-5][0-9]:[0-5][0-9]'),
end_time TEXT NOT NULL
CHECK(end_time GLOB '[1-2][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9] [0-2][0-9]:[0-5][0-9]:[0-5][0-9]'),
FOREIGN KEY (class_id) REFERENCES classes(class_id),
FOREIGN KEY (staff_id) REFERENCES staff(staff_id) 
);


CREATE TABLE memberships 
(
membership_id TEXT PRIMARY KEY,
member_id TEXT NOT NULL,
type TEXT NOT NULL
CHECK(type IN ('Standard', 'Premium')),
start_date TEXT NOT NULL
CHECK(start_date GLOB '[1-2][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]'),
end_date TEXT NOT NULL
CHECK(end_date GLOB '[1-2][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]'),
status TEXT NOT NULL
CHECK (status IN ('Active','Inactive')),
FOREIGN KEY (member_id) REFERENCES members(member_id)
);


CREATE TABLE attendance 
(
attendance_id TEXT PRIMARY KEY,
member_id TEXT NOT NULL,
location_id TEXT NOT NULL,
check_in_time TEXT NOT NULL
CHECK(check_in_time GLOB '[1-2][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9] [0-2][0-9]:[0-5][0-9]:[0-5][0-9]'),
check_out_time TEXT 
CHECK(check_out_time GLOB '[1-2][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9] [0-2][0-9]:[0-5][0-9]:[0-5][0-9]'),
FOREIGN KEY (member_id) REFERENCES members(member_id),
FOREIGN KEY (location_id) REFERENCES locations(location_id)
);


CREATE TABLE class_attendance 
(
class_attendance_id TEXT PRIMARY KEY,
schedule_id TEXT NOT NULL,
member_id TEXT NOT NULL,
attendance_status TEXT NOT NULL 
CHECK(attendance_status IN ('Registered','Attended','Unattended')),
FOREIGN KEY (schedule_id) REFERENCES class_schedule(schedule_id),
FOREIGN KEY (member_id) REFERENCES members(member_id)
);


CREATE TABLE payments 
(
payment_id TEXT PRIMARY KEY,
member_id TEXT NOT NULL,
amount REAL NOT NULL
CHECK(amount > 0),
payment_date TEXT NOT NULL
CHECK(payment_date GLOB '[1-2][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9] [0-2][0-9]:[0-5][0-9]:[0-5][0-9]'),
payment_method TEXT NOT NULL
CHECK(payment_method IN ('Credit Card', 'Bank Transfer', 'PayPal', 'Cash')),
description TEXT,
FOREIGN KEY (member_id) REFERENCES members(member_id)
);


CREATE TABLE personal_training_sessions
(
session_id TEXT PRIMARY KEY,
member_id TEXT NOT NULL,
staff_id TEXT NOT NULL,
session_date TEXT NOT NULL
CHECK(session_date GLOB '[1-2][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]'),
start_time TEXT NOT NULL
CHECK(start_time GLOB '[0-2][0-9]:[0-5][0-9]:[0-5][0-9]'),
end_time TEXT NOT NULL
CHECK(end_time GLOB '[0-2][0-9]:[0-5][0-9]:[0-5][0-9]'),
notes TEXT,
FOREIGN KEY (member_id) REFERENCES members(member_id),
FOREIGN KEY (staff_id) REFERENCES staff(staff_id) 
);


CREATE TABLE member_health_metrics 
(
metric_id TEXT PRIMARY KEY,
member_id TEXT NOT NULL,
measurement_date TEXT NOT NULL
CHECK(measurement_date GLOB '[1-2][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]'),
weight REAL NOT NULL
CHECK(weight>0),
body_fat_percentage REAL
CHECK(body_fat_percentage >=0 AND body_fat_percentage <=100),
muscle_mass REAL 
CHECK(muscle_mass >= 0),
bmi REAL 
CHECK(bmi >0),
FOREIGN KEY (member_id) REFERENCES members(member_id)
);


CREATE TABLE equipment_maintenance_log
(
log_id TEXT PRIMARY KEY,
equipment_id TEXT NOT NULL,
maintenance_date TEXT NOT NULL
CHECK(maintenance_date GLOB '[1-2][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]' ),
description TEXT,
staff_id TEXT NOT NULL,
FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id),
FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);