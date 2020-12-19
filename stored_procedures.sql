USE University;

drop procedure if exists insert_into_students;

Delimiter !!
CREATE procedure insert_into_students(
  name varchar(45),
  surname varchar(45),
  patronim varchar(45),
  birth_date date,
  join_date date,
  student_card_number varchar(45),
  email varchar(45),
  group_id int,
  school_id int,
  city_id varchar(45)
)
BEGIN
	INSERT INTO students (
		name, surname, patronim, birth_date, join_date, student_card_number, email, group_id, school_id, city_id
    )
    values (
		name, surname, patronim, birth_date, join_date, student_card_number, email, group_id, school_id, city_id
    );
END
!! Delimiter ;


drop procedure if exists create_random_cities;

Delimiter !!
CREATE PROCEDURE create_random_cities()
BEGIN
	set @counter = 1;
	while @counter < 10 do
		INSERT INTO city (id, name) VALUES
		(@counter, CONCAT('Noname', @counter)); 
		SET @counter = @counter + 1;
    END WHILE;
END !! Delimiter ;



drop procedure if exists create_random_databases;

Delimiter !!
CREATE PROCEDURE create_random_databases()
BEGIN
	DECLARE done BOOL DEFAULT FALSE;
    DECLARE new_region VARCHAR(45);
	DECLARE regs CURSOR
		FOR SELECT name FROM regions;

    DECLARE CONTINUE HANDLER
		FOR NOT FOUND SET done = TRUE;
	
    OPEN regs;
    region_loop:
    LOOP
		FETCH regs INTO new_region;
        if done then leave region_loop;
        END IF;
        set @region_db := CONCAT('CREATE DATABASE IF NOT EXISTS ', new_region, ';');
        
        prepare query from @region_db;
        execute query;
        
        SET @table_count := 1;
        
        WHILE @table_count < rand() * 8 + 2 DO
			
			set @new_table = CONCAT( 'CREATE TABLE IF NOT EXISTS ', new_region, '.', new_region, @table_count, '( id INT, name VARCHAR(45));');
            SELECT @new_table;
            prepare new_table_query from @new_table;
            execute new_table_query;
            SET @table_count = @table_count + 1;
        END WHILE;
        
    END LOOP;
    CLOSE regs;
END
!! Delimiter ;