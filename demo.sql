

show databases;
CREATE DATABASE DemoDatabase;


/* 
NOT NULL - Ensures that a column cannot have a NULL value
UNIQUE - Ensures that all values in a column are different
PRIMARY KEY - A combination of a NOT NULL and UNIQUE. Uniquely identifies each row in a table
FOREIGN KEY - Uniquely identifies a row/record in another table
CHECK - Ensures that all values in a column satisfies a specific condition
DEFAULT - Sets a default value for a column when no value is specified
INDEX - Used to create and retrieve data from the database very quickly
 */
CREATE TABLE Person (
  ID int NOT NULL,
  Name varchar(255) NOT NULL,
  Age int(4),
  Place varchar(255)
);



-- Insert single and multiple rows
INSERT INTO  Person(ID, Name, Age, Place) VALUES  (1, 'Niharika ', 21, 'Scotland');
INSERT INTO  Person(ID, Name, Age, Place, Movie) VALUES  (12, 'Bihan', 20, 'Everest' , 'Sherlock');
INSERT INTO  Person(ID, Name, Age, Place)
VALUES
  (16, 'Ashna', 20, 'India'),
  (32, 'Riya', 24, 'Mariana Trench');

SELECT  * FROM  Person;


-- DELETE FROM table_name WHERE condition;
DELETE FROM Person WHERE Place="Everest";
DELETE FROM Person WHERE ID=12;


-- Update Customer 
--  SYNTAX :  UPDATE <TableName> SET col1=val1, col2=val2 WHERE condition
UPDATE Person SET Name="Umuu" WHERE Place="India"; 



-- ADD / MODIFY / DELETE column to the exsisting table 
ALTER TABLE Person ADD Movie VARCHAR(50);
ALTER TABLE Person MODIFY Movie VARCHAR(60);
ALTER TABLE Person DROP Movie;




-- Drop/Delete the full exsisting TABLE
DROP TABLE Tablename;         /* Full table deleted,ALONG WITH THE Exsisting SCHEMA */
DROP TABLE TableName IF EXISTS;
TRUNCATE TABLE TableName;     /* All the rows will be deleted */



-- -----------------------------------------------------------------
SELECT Name FROM STUDENTS WHERE Marks > 75 ORDER BY RIGHT(Name,3) ASC , ID ASC  ; 
SELECT ROUND(LONG_W , 4)
FROM STATION
WHERE LAT_N < 137.2345
ORDER BY LAT_N DESC 
LIMIT 1 ;


-- WEATHER 20
SET @N := 0;
SELECT COUNT(*) FROM STATION INTO @TOTAL;
SELECT
    ROUND(AVG(A.LAT_N), 4)
FROM (SELECT @N := @N +1 AS ROW_ID, LAT_N FROM STATION ORDER BY LAT_N) A
WHERE
    CASE WHEN MOD(@TOTAL, 2) = 0 
            THEN A.ROW_ID IN (@TOTAL/2, (@TOTAL/2+1))
            ELSE A.ROW_ID = (@TOTAL+1)/2
    END
;


/* 
Syntax :

CASE
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    WHEN conditionN THEN resultN
    ELSE result
END;



IF(condition, value_if_true, value_if_false)
 */