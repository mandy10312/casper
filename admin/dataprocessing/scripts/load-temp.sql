USE CASPER;

-- clear the temp file

TRUNCATE TABLE TEMP;

-- Load the cumulative processed data

LOAD DATA LOCAL INFILE "./phase2/00temp.dat" REPLACE INTO TABLE TEMP FIELDS TERMINATED BY ',' 
(Year, Semester, Department, Course, Section, Regcode, CourseName, Instructor, Initials, SSN, LName, FName, Email, Grade);

