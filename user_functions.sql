USE University;

DROP FUNCTION IF EXISTS averager;
DROP FUNCTION IF EXISTS getCityBySchoolId;

DELIMITER !!
CREATE FUNCTION averager()
RETURNS FLOAT
BEGIN
	RETURN (SELECT AVG(rate) FROM students);
END
!! DELIMITER ;


DELIMITER !!
CREATE FUNCTION getCityBySchoolId(schoolId INT)
RETURNS VARCHAR(45)
BEGIN
	RETURN (SELECT name from city where id = (select city_id from schools where id = schoolId));
END !!
DELIMITER ;


-- SELECT name, surname, averager()
-- FROM students;

SELECT name, director_surname, getCityBySchoolId(id)
FROM schools;


