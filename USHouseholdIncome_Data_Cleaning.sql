# US Household Income Data Cleaning

# The two tables being cleaned
SELECT * 
FROM USHouseholdIncome;

SELECT * 
FROM ushouseholdincome_statistics;

# Using COUNT to check how many rows in each respective table and check for missing imported data
SELECT COUNT(id)
FROM USHouseholdIncome; 

SELECT COUNT(id)
FROM ushouseholdincome_statistics;

# Checking for duplicates by id
SELECT id, COUNT(id)
FROM USHouseholdIncome
GROUP BY id
HAVING COUNT(id) > 1;


# Selecting duplicates by row_id with a subquery
SELECT *
FROM (
SELECT row_id, id,
ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) as row_num
FROM USHouseholdIncome
) as duplicates
WHERE row_num > 1
;

# Deleting duplicate rows
DELETE FROM USHouseholdIncome
WHERE row_id IN (
SELECT row_id 
FROM (
		SELECT row_id, id,
		ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) as row_num
		FROM USHouseholdIncome
		) as duplicates
WHERE row_num > 1)
;

# Checking for duplicate/misspelled state names
SELECT DISTINCT(state_name), COUNT(state_name)
FROM USHouseholdIncome
GROUP BY state_name
;

# Standardizing state names
UPDATE USHouseholdIncome
SET state_name = 'Georgia'
WHERE state_name = 'georia'
;

UPDATE USHouseholdIncome
SET state_name = 'Alabama'
WHERE state_name = 'alabama'
;

# Standardizing county
SELECT *
FROM USHouseholdIncome
WHERE county = 'Autauga County'
;

UPDATE USHouseholdIncome
SET place = 'Autaugaville'
WHERE county = 'Autauga County'
AND city = 'Vinemont';

# Standardizing type
SELECT type, COUNT(type)
FROM USHouseholdIncome
GROUP BY type;

UPDATE USHouseholdIncome
SET type = 'Borough'
WHERE type = 'Boroughs'
;

SELECT *
FROM USHouseholdIncome
;


