USE University;

/* STUDENT INTEGRITY */

DROP TRIGGER IF EXISTS studentCheckInsertFK;

DELIMITER !!
CREATE TRIGGER studentCheckInsertFK
BEFORE INSERT
ON students FOR EACH ROW
BEGIN
	IF (new.city_id NOT IN (SELECT id from city))
		THEN SIGNAL SQLSTATE "45000"
			SET MESSAGE_TEXT = "Check city for insert. FK trouble";
    END IF;
    
	IF (new.school_id NOT IN (SELECT id from schools))
		THEN SIGNAL SQLSTATE "45000"
			SET MESSAGE_TEXT = "Check school for insert. FK trouble";
    END IF;
	
    IF (new.group_id NOT IN (SELECT id from student_groups))
		THEN SIGNAL SQLSTATE "45000"
			SET MESSAGE_TEXT = "Check group for insert. FK trouble";
    END IF;	
    
END
!! DELIMITER ;

DROP TRIGGER IF EXISTS studentCheckUpdateFK;

DELIMITER !!
CREATE TRIGGER studentCheckUpdateFK
BEFORE UPDATE
ON students FOR EACH ROW
BEGIN
	IF (old.id != new.id AND old.id in (select id FROM students))
    		THEN SIGNAL SQLSTATE "45000"
			SET MESSAGE_TEXT = "Check index for update.";
    END IF;	
END
!! DELIMITER ;

DROP TRIGGER IF EXISTS studentCheckDeleteFK;

DELIMITER !!
CREATE TRIGGER studentCheckDeleteFK
BEFORE DELETE
ON students FOR EACH ROW
BEGIN
	IF (old.id IN (SELECT student_id FROM student_has_debt))
	THEN SIGNAL SQLSTATE "45000"
		SET MESSAGE_TEXT = "Student has debts. FK trouble";
	END IF;
END
!! DELIMITER ;

/* CITY INTEGRITY */

DROP TRIGGER IF EXISTS cityCheckInsertFK;

DELIMITER !!
CREATE TRIGGER cityCheckInsertFK
BEFORE INSERT
ON city FOR EACH ROW
BEGIN
	IF (new.region_id NOT IN (SELECT id from regions))
		THEN SIGNAL SQLSTATE "45000"
			SET MESSAGE_TEXT = "Check region for insert. FK trouble";
    END IF;
END
!! DELIMITER ;

DROP TRIGGER IF EXISTS cityCheckUpdateFK;

DELIMITER !!
CREATE TRIGGER cityCheckUpdateFK
BEFORE UPDATE
ON city FOR EACH ROW
BEGIN
	IF (old.id != new.id OR old.id not in (select id FROM regions))
    		THEN SIGNAL SQLSTATE "45000"
			SET MESSAGE_TEXT = "Check index for update.";
    END IF;	
END
!! DELIMITER ;

DROP TRIGGER IF EXISTS cityCheckDeleteFK;

DELIMITER !!
CREATE TRIGGER cityCheckDeleteFK
BEFORE DELETE
ON city FOR EACH ROW
BEGIN
	IF (old.id IN (SELECT city_id FROM schools))
	THEN SIGNAL SQLSTATE "45000"
		SET MESSAGE_TEXT = "It's school here. FK trouble";
	END IF;
	IF (old.id IN (SELECT city_id FROM students))
	THEN SIGNAL SQLSTATE "45000"
		SET MESSAGE_TEXT = "It's student here. FK trouble";
	END IF;	
END
!! DELIMITER ;

/* REGION INTEGRITY */


DROP TRIGGER IF EXISTS regionCheckUpdateFK;

DELIMITER !!
CREATE TRIGGER regionCheckUpdateFK
BEFORE UPDATE
ON regions FOR EACH ROW
BEGIN
	IF (old.id != new.id OR new.id not in (select id FROM regions))
    		THEN SIGNAL SQLSTATE "45000"
			SET MESSAGE_TEXT = "Check index for update.";
    END IF;	
END
!! DELIMITER ;

DROP TRIGGER IF EXISTS regionCheckDeleteFK;

DELIMITER !!
CREATE TRIGGER regionCheckDeleteFK
BEFORE DELETE
ON regions FOR EACH ROW
BEGIN
	IF (old.id IN (SELECT region_id FROM city))
	THEN SIGNAL SQLSTATE "45000"
		SET MESSAGE_TEXT = "It's city here. FK trouble";
	END IF;
END
!! DELIMITER ;

/* DEBT INTEGRITY */


DROP TRIGGER IF EXISTS debtCheckUpdateFK;

DELIMITER !!
CREATE TRIGGER debtCheckUpdateFK
BEFORE UPDATE
ON debts FOR EACH ROW
BEGIN
	IF (old.id != new.id AND old.id in (select id FROM debts))
    		THEN SIGNAL SQLSTATE "45000"
			SET MESSAGE_TEXT = "Check index for update.";
    END IF;	
END
!! DELIMITER ;

DROP TRIGGER IF EXISTS debtCheckDeleteFK;

DELIMITER !!
CREATE TRIGGER debtCheckDeleteFK
BEFORE DELETE
ON debts FOR EACH ROW
BEGIN
	IF (old.id IN (SELECT debt_id FROM student_has_debt))
	THEN SIGNAL SQLSTATE "45000"
		SET MESSAGE_TEXT = "Students have this debt. FK trouble";
	END IF;
END
!! DELIMITER ;


/* SCHOOL INTEGRITY */

DROP TRIGGER IF EXISTS schoolCheckInsertFK;

DELIMITER !!
CREATE TRIGGER schoolCheckInsertFK
BEFORE INSERT
ON schools FOR EACH ROW
BEGIN
	IF (new.city_id NOT IN (SELECT id from city))
		THEN SIGNAL SQLSTATE "45000"
			SET MESSAGE_TEXT = "Check city for insert. FK trouble";
    END IF;
END
!! DELIMITER ;

DROP TRIGGER IF EXISTS schoolCheckUpdateFK;

DELIMITER !!
CREATE TRIGGER schoolCheckUpdateFK
BEFORE UPDATE
ON schools FOR EACH ROW
BEGIN
	IF (old.id != new.id AND old.id in (select id FROM schools))
    		THEN SIGNAL SQLSTATE "45000"
			SET MESSAGE_TEXT = "Check index for update.";
    END IF;	
END
!! DELIMITER ;

DROP TRIGGER IF EXISTS schoolCheckDeleteFK;

DELIMITER !!
CREATE TRIGGER schoolCheckDeleteFK
BEFORE DELETE
ON schools FOR EACH ROW
BEGIN
	IF (old.id IN (SELECT school_id FROM students))
	THEN SIGNAL SQLSTATE "45000"
		SET MESSAGE_TEXT = "Student has debts. FK trouble";
	END IF;
END
!! DELIMITER ;

/* STUDENT_DEBT INTEGRITY */

DROP TRIGGER IF EXISTS studentDebtCheckInsertFK;

DELIMITER !!
CREATE TRIGGER studentDebtCheckInsertFK
BEFORE INSERT
ON student_has_debt FOR EACH ROW
BEGIN
	IF (new.student_id NOT IN (SELECT id from students))
		THEN SIGNAL SQLSTATE "45000"
			SET MESSAGE_TEXT = "Check student for insert. FK trouble";
    END IF;
	IF (new.debt_id NOT IN (SELECT id from debts))
		THEN SIGNAL SQLSTATE "45000"
			SET MESSAGE_TEXT = "Check debt for insert. FK trouble";
    END IF;
END
!! DELIMITER ;

DROP TRIGGER IF EXISTS studentDebtCheckUpdateFK;

DELIMITER !!
CREATE TRIGGER studentDebtCheckUpdateFK
BEFORE UPDATE
ON student_has_debt FOR EACH ROW
BEGIN
	IF (old.id != new.id AND old.id in (select id FROM student_has_debt))
    		THEN SIGNAL SQLSTATE "45000"
			SET MESSAGE_TEXT = "Check index for update.";
    END IF;	
END
!! DELIMITER ;

/* GROUP INTEGRITY */


!! DELIMITER ;

DROP TRIGGER IF EXISTS groupCheckUpdateFK;

DELIMITER !!
CREATE TRIGGER groupCheckUpdateFK
BEFORE UPDATE
ON student_groups FOR EACH ROW
BEGIN
	IF (old.id != new.id AND old.id in (select id FROM student_groups))
    		THEN SIGNAL SQLSTATE "45000"
			SET MESSAGE_TEXT = "Check index for update.";
    END IF;	
END
!! DELIMITER ;

DROP TRIGGER IF EXISTS groupCheckDeleteFK;

DELIMITER !!
CREATE TRIGGER groupCheckDeleteFK
BEFORE DELETE
ON student_groups FOR EACH ROW
BEGIN
	IF (old.id IN (SELECT group_id FROM students))
	THEN SIGNAL SQLSTATE "45000"
		SET MESSAGE_TEXT = "Students. FK trouble";
	END IF;
END
!! DELIMITER ;


/* TASK 2 */

DROP TRIGGER IF EXISTS schoolCheckPhone;
DELIMITER !!
CREATE TRIGGER schoolCheckPhone
BEFORE INSERT 
ON schools FOR EACH ROW
BEGIN
	IF (new.phone not RLIKE("(.d*3).d*3-.d*2-.d*2"))
	THEN SIGNAL SQLSTATE "45000"
		SET MESSAGE_TEXT = "UKRTELEKOM DOES NOT SUPPORT. Phone trouble";
	END IF;
END !! DELIMITER ;

DROP TRIGGER IF EXISTS schoolCheckPhoneUpd;
DELIMITER !!
CREATE TRIGGER schoolCheckPhoneUpd
BEFORE UPDATE
ON schools FOR EACH ROW
BEGIN
	IF (new.phone not RLIKE("^(/d*3)/d*3-/d*2-/d*2"))
	THEN SIGNAL SQLSTATE "45000"
		SET MESSAGE_TEXT = "UKRTELEKOM DOES NOT SUPPORT. Phone trouble";
	END IF;
END !! DELIMITER ;

/* TASK 3 */
DROP TRIGGER IF EXISTS studentWorkName;
DELIMITER !!
CREATE TRIGGER studentWorkName
BEFORE INSERT
ON students FOR EACH ROW
BEGIN
	IF (new.name not in ('Світлана', 'Петро', 'Оля', 'Тарас', 'Василь', 'Антон'))
	THEN SIGNAL SQLSTATE "45000"
		SET MESSAGE_TEXT = "BURGOIS NAME";
	END IF;
END !! DELIMITER ;

/* TASK 4 */

DROP TRIGGER IF EXISTS cityCreateLog;
DELIMITER !!

CREATE TRIGGER cityCreateLog
AFTER INSERT
ON city FOR EACH ROW
BEGIN
	INSERT INTO city_journal (name, timestamp) VALUES (new.name, current_timestamp());
END !! DELIMITER ;
