# US Household Income Exploratory Data Analysis

# The two datasets to explore.
SELECT * 
FROM USHouseholdIncome;

SELECT * 
FROM ushouseholdincome_statistics;


# Evaluating at the state level, who has the most and least Land & Water.
SELECT state_name, SUM(ALand), SUM(AWater)
FROM USHouseholdIncome
GROUP BY state_name
ORDER BY 2 DESC
LIMIT 10;

# Using INNER JOIN to combine Income data with statistics data.
SELECT *
FROM USHouseholdIncome u
INNER JOIN ushouseholdincome_statistics us
	ON u.id = us.id;

# Fitlering data missing Mean data.
SELECT *
FROM USHouseholdIncome u
INNER JOIN ushouseholdincome_statistics us
	ON u.id = us.id
WHERE Mean <> 0;

# Aggregating data to see the average household & median income at the state level.
SELECT u.state_name, ROUND(AVG(mean),1), ROUND(AVG(median),1)
FROM USHouseholdIncome u
INNER JOIN ushouseholdincome_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.state_name
ORDER BY 3 ASC
LIMIT 10;

# Exploring the average income and median data.
SELECT type, ROUND(AVG(mean),1), ROUND(AVG(median),1)
FROM USHouseholdIncome u
INNER JOIN ushouseholdincome_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 20;

# Checking income by Type with GROUP BY.
# The data shows the 'Municipality' type was the highest due to its count, making it an outlier. While types like 'Urban' and 'Community' have dramatically lower average salaries.
SELECT type, COUNT(type), ROUND(AVG(mean),1), ROUND(AVG(median),1)
FROM USHouseholdIncome u
INNER JOIN ushouseholdincome_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY 1
ORDER BY 4 DESC
LIMIT 20;

# 'Puerto Rico' holds the lower end of average salaries.
SELECT *
FROM USHouseholdIncome
WHERE type = 'Community';

# Filtering out outliers to show higher volume types.
SELECT type, COUNT(type), ROUND(AVG(mean),1), ROUND(AVG(median),1)
FROM USHouseholdIncome u
INNER JOIN ushouseholdincome_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY 1
HAVING COUNT(type) > 100
LIMIT 20;

# A lot of the higher averages are coming out of the Northeast area while exploring the states and cities even further.
SELECT u.state_name, city, ROUND(AVG(mean),1)
FROM USHouseholdIncome u
JOIN ushouseholdincome_statistics us
	ON u.id = us.id
    GROUP BY u.state_name, city
    ORDER BY 3 DESC;



