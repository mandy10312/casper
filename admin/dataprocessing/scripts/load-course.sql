USE CASPER;

CREATE OR REPLACE VIEW COURSE_VIEW AS 
       SELECT Department, Course, CourseName FROM TEMP GROUP BY Department, Course;

INSERT INTO COURSE (Department, Number, Name)
SELECT Department, Course, CourseName FROM COURSE_VIEW
WHERE (Department, Course) NOT IN (SELECT Department, Number FROM COURSE);



