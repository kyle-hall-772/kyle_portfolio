# World Life Expectancy Project Data Cleaning

SELECT * 
FROM world_life_expectancy;

# Checking for duplicates by using CONCAT to create a unique id
SELECT Country, Year, CONCAT(Country, Year), COUNT(CONCAT(Country, Year))
FROM world_life_expectancy
GROUP BY Country, Year, CONCAT(Country, Year)
HAVING COUNT(CONCAT(Country, Year)) > 1;

# Using a subquery to identify duplicates
SELECT *
FROM (
SELECT row_id, CONCAT(Country, Year),
ROW_NUMBER() OVER(PARTITION BY CONCAT(Country, Year)) AS row_num
FROM world_life_expectancy
) as row_table
WHERE row_num > 1;

# Deleting the previously identified duplicates
DELETE FROM world_life_expectancy
WHERE 
	row_id IN (
	SELECT row_id
	FROM (
	SELECT row_id, CONCAT(Country, Year),
	ROW_NUMBER() OVER(PARTITION BY CONCAT(Country, Year)) AS row_num
	FROM world_life_expectancy
	) as row_table
WHERE row_num > 1
	);
    
# Checking for missing data in the 'status' column
SELECT * 
FROM world_life_expectancy
WHERE status = ''
;

SELECT DISTINCT(status)
FROM world_life_expectancy
WHERE status <> ''
;

SELECT DISTINCT(country)
FROM world_life_expectancy
WHERE status = 'Developing'
;


UPDATE world_life_expectancy
SET status = 'Developing'
WHERE country IN (SELECT DISTINCT(country)
				FROM world_life_expectancy
				WHERE status = 'Developing');

# Using JOIN to self join table to update missing data
UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.country = t2.country
SET t1.status = 'Developing'
WHERE t1.status = ''
AND t2.status <> ''
AND t2.status = 'Developing'
;

# Further updating missing data the did not the first time
SELECT * 
FROM world_life_expectancy
WHERE country = 'United States of America'
;

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.country = t2.country
SET t1.status = 'Developed'
WHERE t1.status = ''
AND t2.status <> ''
AND t2.status = 'Developed'
;

# Checking missing data in Lifeexpectancy column
SELECT *
FROM world_life_expectancy
WHERE `Lifeexpectancy` = ''
;

SELECT Country, Year, `Lifeexpectancy`
FROM world_life_expectancy
;

# Using a self joins and finding the average of the year before and after a specific missing value to populate it
SELECT t1.Country, t1.Year, t1.`Lifeexpectancy`,
 t2.Country, t2.Year, t2.`Lifeexpectancy`,
t3.Country, t3.Year, t3.`Lifeexpectancy`,
ROUND((t2.`Lifeexpectancy` + t3.`Lifeexpectancy`)/2,1)
FROM world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.country = t2.country
    AND t1.Year = t2.Year - 1
JOIN world_life_expectancy t3
	ON t1.country = t3.country
    AND t1.Year = t3.Year + 1
WHERE t1.`Lifeexpectancy` = ''
;

# Updating missing value
UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.country = t2.country
    AND t1.Year = t2.Year - 1
JOIN world_life_expectancy t3
	ON t1.country = t3.country
    AND t1.Year = t3.Year + 1
SET t1.`Lifeexpectancy` = ROUND((t2.`Lifeexpectancy` + t3.`Lifeexpectancy`)/2,1)
WHERE t1.`Lifeexpectancy` = ''
;

SELECT *
FROM world_life_expectancy
;