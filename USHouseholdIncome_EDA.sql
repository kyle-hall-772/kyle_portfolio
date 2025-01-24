# US Household Income Exploratory Data Analysis

SELECT * 
FROM USHouseholdIncome;

SELECT * 
FROM ushouseholdincome_statistics;


SELECT state_name, SUM(ALand), SUM(AWater)
FROM USHouseholdIncome
GROUP BY state_name
ORDER BY 2 DESC
LIMIT 10;

SELECT *
FROM USHouseholdIncome u
INNER JOIN ushouseholdincome_statistics us
	ON u.id = us.id;

SELECT *
FROM USHouseholdIncome u
INNER JOIN ushouseholdincome_statistics us
	ON u.id = us.id
WHERE Mean <> 0;

SELECT u.state_name, ROUND(AVG(mean),1), ROUND(AVG(median),1)
FROM USHouseholdIncome u
INNER JOIN ushouseholdincome_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.state_name
ORDER BY 3 ASC
LIMIT 10;

SELECT type, ROUND(AVG(mean),1), ROUND(AVG(median),1)
FROM USHouseholdIncome u
INNER JOIN ushouseholdincome_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 20;

SELECT type, COUNT(type), ROUND(AVG(mean),1), ROUND(AVG(median),1)
FROM USHouseholdIncome u
INNER JOIN ushouseholdincome_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY 1
ORDER BY 4 DESC
LIMIT 20;

SELECT *
FROM USHouseholdIncome
WHERE type = 'Community';

SELECT type, COUNT(type), ROUND(AVG(mean),1), ROUND(AVG(median),1)
FROM USHouseholdIncome u
INNER JOIN ushouseholdincome_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY 1
HAVING COUNT(type) > 100
LIMIT 20;

SELECT u.state_name, city, ROUND(AVG(mean),1)
FROM USHouseholdIncome u
JOIN ushouseholdincome_statistics us
	ON u.id = us.id
    GROUP BY u.state_name, city
    ORDER BY 3 DESC;



