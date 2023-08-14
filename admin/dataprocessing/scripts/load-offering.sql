USE CASPER;

CREATE OR REPLACE VIEW OFFERING_VIEW AS 
       SELECT Department, Course, Section, Year, Semester, Instructor from TEMP GROUP BY Department, Course, Section, Year, Semester;

INSERT INTO OFFERING (Course_ID, Section, Year, Semester, Prof_ID)
SELECT COURSE.ID, OFFERING_VIEW.Section, OFFERING_VIEW.Year, OFFERING_VIEW.Semester, PROF.ID
FROM OFFERING_VIEW, COURSE, PROF
WHERE (OFFERING_VIEW.Department=COURSE.Department AND
       OFFERING_VIEW.Course=COURSE.Number AND
       OFFERING_VIEW.Instructor=PROF.Name AND
       (COURSE.ID, OFFERING_VIEW.Section, OFFERING_VIEW.Year, OFFERING_VIEW.Semester) NOT IN (SELECT Course_ID, Section, Year, Semester FROM OFFERING));



UPDATE 
OFFERING
INNER JOIN COURSE ON OFFERING.Course_ID=COURSE.ID
INNER JOIN PROF 
INNER JOIN OFFERING_VIEW ON (OFFERING_VIEW.Department=COURSE.Department AND
                             OFFERING_VIEW.Course=COURSE.Number AND
                             OFFERING_VIEW.Section=OFFERING.Section AND
                             OFFERING_VIEW.Year=OFFERING.Year AND
                             OFFERING_VIEW.Semester=OFFERING.Semester AND
                             OFFERING_VIEW.Instructor=PROF.Name)
SET OFFERING.Prof_ID=PROF.ID; 
