# World Life Expectancy Project Exploratory Data Analysis


SELECT * 
FROM world_life_expectancy
;

# Using MIN and MAX to see into countries life expectancy and how much have they progressed. Also, filtered out values with '0'.
SELECT Country, MIN(Lifeexpectancy), MAX(Lifeexpectancy),
ROUND(MAX(Lifeexpectancy) - MIN(Lifeexpectancy),1) AS Life_Increase_15_Years
FROM world_life_expectancy
GROUP BY Country
HAVING MIN(Lifeexpectancy) <> 0
AND MAX(Lifeexpectancy) <> 0
ORDER BY Life_Increase_15_Years DESC
;

# Evaluating the average life expectancy by year, filtering out values with '0'.
# This data shows the average life expectancy has grown by about 6 years in the world, as a whole.
SELECT Year , ROUND(AVG(Lifeexpectancy),2)
FROM world_life_expectancy
WHERE Lifeexpectancy <> 0
AND Lifeexpectancy<> 0
GROUP BY Year
ORDER BY Year
;

# Exploring the correlation between life expectancy and GDP.
# The data shows a mostly positive correlation between the two factors.
SELECT Country, ROUND(AVG(Lifeexpectancy),1) AS Life_Exp, ROUND(AVG(GDP),1) AS GDP
FROM world_life_expectancy
GROUP BY Country
HAVING Life_Exp > 0
AND GDP > 0
ORDER BY GDP DESC
;

# Using CASE statements to further show insights in correlation between life expectancy and GDP.
# Countries with lower GDP are shown to have almost a 10 year less life expectancy compared to countries with high GDP.
SELECT 
SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) High_GDP_Count,
AVG(CASE WHEN GDP >= 1500 THEN Lifeexpectancy ELSE NULL END) High_GDP_Count,
SUM(CASE WHEN GDP <= 1500 THEN 1 ELSE 0 END) Low_GDP_Count,
AVG(CASE WHEN GDP <= 1500 THEN Lifeexpectancy ELSE NULL END) Low_GDP_Count
FROM world_life_expectancy
;

SELECT * 
FROM world_life_expectancy
;

# Seeing correlation between a countries status and life expectancy.
SELECT Status, ROUND(AVG(Lifeexpectancy),1)
FROM world_life_expectancy
GROUP BY Status
;

# The data shows there are more 'Developing' countries than 'Developed', thus why the average for 'Developed' countries is higher.
SELECT Status, COUNT(DISTINCT Country), ROUND(AVG(Lifeexpectancy),1)
FROM world_life_expectancy
GROUP BY Status
;

# Comparing BMI and life expectancy
SELECT Country, ROUND(AVG(Lifeexpectancy),1) AS Life_Exp, ROUND(AVG(BMI),1) AS BMI
FROM world_life_expectancy
GROUP BY Country
HAVING Life_Exp > 0
AND BMI > 0
ORDER BY BMI DESC
;

# Exploring life expectancy and adult mortality rates 
SELECT Country, Year, Lifeexpectancy, AdultMortality,
SUM(AdultMortality) OVER(PARTITION BY Country ORDER BY Year) as Rolling_Total
FROM world_life_expectancy
WHERE Country LIKE '%United%'

;