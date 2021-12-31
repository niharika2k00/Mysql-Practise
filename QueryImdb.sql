
CREATE DATABASE Imdb;
SHOW databases;
USE imdb;
SOURCE  C:\LOCAL_DRIVE_Niharika\SQL_Dbms\imdb.sql;
SHOW TABLES;
DESCRIBE directors_genres;
DESCRIBE movies;

SELECT * FROM actors;   /* Display the full table */



-- 12 rows from movies table contains only 2 mentioned columns
SELECT name,rankscore FROM movies LIMIT 20;  

-- Display 20 rows by removing the first 2 rows (FROM THE FIRST REMOVED)
SELECT name,rankscore FROM movies LIMIT 20 OFFSET 2;     



-- -----------------------------------------------------------------
-- KEYWORD ORDER BY ascending & descending order  ASC | DESC
-- -----------------------------------------------------------------
SELECT name,rankscore,year FROM movies ORDER BY name LIMIT 10;
SELECT name,id,year FROM movies ORDER BY year DESC LIMIT 10;



-- KEYWORD DISTINCT (unique name from the entire table)
SELECT DISTINCT genre FROM movies_genres;
SELECT DISTINCT first_name, last_name FROM directors ;



-- KEYWORD WHERE
/* 
            First      FROM 
            Second     WHERE
            Third      ORDER BY
 */
SELECT name,year,rankscore FROM movies WHERE rankscore>9.8 ;
SELECT  name,year,rankscore FROM movies WHERE rankscore > 9.8 ORDER BY rankscore DESC LIMIT 20;

-- # Comparison Operators: = , <> or != , < , <= , >, >= 
SELECT * FROM movies_genres WHERE genre = 'Comedy' ;
SELECT * FROM movies_genres WHERE genre != 'Horror' LIMIT 16;




-- # "=" doesnot work with NULL, will give you an empty result-set.
SELECT name,year,rankscore FROM movies WHERE rankscore = NULL;  /*  = NULL is not valid here, "=" doesnot work with NULL*/
SELECT name,year,rankscore FROM movies WHERE rankscore IS NULL LIMIT 14;
SELECT name,year,rankscore FROM movies WHERE rankscore IS NOT NULL LIMIT 14;  /*  != NULL */
 



-- # LOGICAL OPERATORS: AND, OR, NOT, ALL, ANY, BETWEEN, EXISTS, IN, LIKE, SOME
SELECT name,year,rankscore FROM movies WHERE rankscore>9 AND year>2000  LIMIT 15;
SELECT name,year,rankscore FROM movies  ORDER BY year  WHERE NOT year<=2000  LIMIT 20 ;     /* ascending */
SELECT name,year,rankscore FROM movies WHERE rankscore>9 OR year>2007;
SELECT name,year,rankscore FROM movies WHERE year BETWEEN 1999 AND 2000;
-- # lowvalue <= highvalue else you will get an empty result set
SELECT director_id, genre FROM directors_genres WHERE genre IN ('Comedy','Horror');  
-- # same as genre='Comedy' OR genre='Horror'




-- STRING COMPARE OPERATOR 
-- % => wildcard character to imply zero or more characters
/* 
        WHERE name LIKE 'Ver%'  ---> name starts with "Ver..."
        WHERE name LIKE '%ver'  ---> name ends with "...ver"
        WHERE name LIKE '%vis%'  ---> name contains "... vis ..."
         "_"                    --->  contains EXACTLY one character in that place

        * If we want to macth % or _, we should use the backslash as the escape character: \% and \_

        WHERE interests LIKE '%sports%' OR interests LIKE '%pub%'  --> FOR MULTIPLE STATRING CHARACTERS.
 */
 
SELECT name,year,rankscore FROM movies WHERE name LIKE 'Tis%'; 
SELECT first_name, last_name FROM actors WHERE first_name LIKE '%es';  
SELECT first_name, last_name FROM actors WHERE first_name LIKE '%es%';
SELECT  first_name, last_name FROM actors WHERE first_name LIKE 'Agn_s';
SELECT first_name, last_name FROM actors WHERE first_name LIKE 'Niha%' AND first_name NOT LIKE 'Li%';



-- -------------------------------------
--       Functions in Strings
-- -------------------------------------
/* 
   The RIGHT() ==> function extracts a number of characters from a string (starting from right).
                    Syntax : RIGHT (string, number_of_chars)
 */

-- https://www.geeksforgeeks.org/mysql-regular-expressions-regexp/
SELECT DISTINCT genre FROM movies_genres WHERE RIGHT(genre, 1) IN ('a','e','i','o','u');  --  Find the names that end with vowels.
SELECT DISTINCT CITY FROM STATION WHERE CITY REGEXP "[aiueo]$";  --  Find the names that end with vowels.
SELECT DISTINCT CITY FROM STATION WHERE CITY REGEXP '^[^aeiou]';  -- Not start with vowels
SELECT DISTINCT CITY FROM STATION WHERE CITY NOT REGEXP '[^aeiou]';   -- Not start with vowels

SELECT DISTINCT CITY FROM STATION WHERE  CITY RLIKE '^[aeiouAEIOU].*[aeiouAEIOU]$';  -- Have vowels in both first and last.
SELECT distinct CITY FROM STATION WHERE CITY LIKE '[^aeiou]%[^aeiou]';
SELECT DISTINCT CITY FROM STATION WHERE CITY NOT LIKE "[AEIOU]%";



SELECT * FROM movies
SELECT MIN(year) FROM movies ;
SELECT MAX(year) FROM movies;
SELECT COUNT(*) FROM movies;        /* number of rows */
SELECT COUNT(*) FROM movies where year>2000;
SELECT COUNT(year) FROM movies;
-- SELECT COUNT(CITY)  - COUNT (DISTINCT CITY) FROM STATION ;   Difference between 2 Counts 




SELECT year, COUNT(year) FROM movies GROUP BY year;
SELECT year, COUNT(year) FROM movies GROUP BY year ORDER BY year;
SELECT year, COUNT(year) year_count FROM movies GROUP BY year ORDER BY year_count;





--  HAVING AND GROUP BY 
/*  
       # CONDITIONS on groups using HAVING .... Order of execution:
1. GROUP BY to create groups
2. apply the AGGREGATE FUNCTION
3. Apply HAVING condition.

         * HAVING without GROUP BY is same as WHERE 
         * HAVING vs WHERE
         * WHERE is applied on individual rows while HAVING is applied on groups.
         * HAVING is applied after grouping while WHERE is used before grouping.
*/
SELECT year, COUNT(year) year_count FROM movies GROUP BY year HAVING year_count>1000;
SELECT name, year  FROM movies HAVING year>2006;
SELECT year, COUNT(year) year_count FROM movies WHERE rankscore>9 GROUP BY year HAVING year_count>20;




-- --------------------------------------------------------
--                     JOIN 
-- --------------------------------------------------------
/* 
  1) (INNER) JOIN:        INNER JOIN keyword selects all rows from both the tables as long as the condition satisfies.
  2) LEFT (OUTER) JOIN:   Returns all records from the LEFFT table, and the matched records from the right table
  3) RIGHT (OUTER) JOIN:  Returns all records from the RIGHT table, and the matched records from the left table
  4) FULL (OUTER) JOIN:   Returns all records when there is a match in either left or right table
   
  5) NATURAL JOIN : based on the Common Columns in the two tables with same attribute name and datatype. 
 */
SELECT m.name, g.genre from movies m  JOIN movies_genres g ON m.id=g.movie_id LIMIT 20;
SHOW TABLES;
DESCRIBE directors_genres;
SELECT * FROM movies_genres;
SELECT * FROM directors_genres NATURAL JOIN movies_directors;  /* Join both the Tables */


-- Where Clause use + Join use same result 
SELECT directors_genres.genre , directors_genres.director_id FROM  directors_genres , movies_directors WHERE directors_genres.director_id =  movies_directors.director_id;
SELECT dir.genre , dir.director_id FROM directors_genres dir JOIN  movies_directors mov ON directors_genres.director_id =  movies_directors.director_id;
SELECT  dir.genre , mov.director_id , dir.prob FROM  directors_genres dir INNER JOIN movies_directors mov ON dir.director_id =  mov.director_id;
SELECT actors.first_name , actors.last_name FROM actors LEFT JOIN directors ON actors.first_name = directors.first_name;
SELECT  dir.genre , dir.director_id , mov.movie_id  FROM  directors_genres dir LEFT JOIN movies_directors mov ON dir.director_id =  mov.director_id;





-- # List all actors in the movie Schindler's List

SELECT first_name, last_name from actors WHERE id IN ( SELECT actor_id from roles WHERE movie_id IN 
			(SELECT id FROM movies where name="'Schindler's List"));

/* 
# Syntax:
SELECT column_name [, column_name ]
FROM   table1 [, table2 ]
WHERE  column_name OPERATOR
   (SELECT column_name [, column_name ]
   FROM table1 [, table2 ]
   [WHERE])

 */
