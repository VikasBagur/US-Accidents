USE learning

--#1 Which US state has the highest number of accidents (Point No 1 under insights and recommendation in read me file)
SELECT State,  COUNT(ID) No_of_accidents
FROM US_Accidents
GROUP BY State
ORDER BY 2 DESC

--#2 Which state has most accidents with Severity 3 and 4 (Not included in the images)
WITH Severe as
(
SELECT State, COUNT(*) as Accidents_with_Severity_3or4
FROM US_Accidents
GROUP BY State, Severity
HAVING Severity IN ('3','4')
)
SELECT State, SUM(Accidents_with_Severity_3or4) as No_of_accidents
FROM Severe
GROUP BY State
ORDER BY No_of_accidents DESC

--#3 Percentage of accidents with severity 3 & 4 in each state compared to all the accidents in the US with severity 3 & 4 (Point No 2)
WITH threeandfour AS
(
SELECT State, Severity, COUNT(*) as No_of_accidents
FROM US_Accidents
GROUP BY Severity, State
HAVING Severity IN ('3','4')
)
SELECT State, SUM(No_of_accidents) as Accident_count 
INTO #Severe
FROM threeandfour
GROUP BY State
ORDER BY Accident_count DESC

WITH total as
(
SELECT CAST(SUM(Accident_count) as int) as total_accidents
FROM #Severe
)
SELECT State, Accident_count, CAST(CAST(Accident_count as int) * 100.0 / total.total_accidents as DECIMAL(14,2)) as percentage_of_accidents
FROM #Severe
CROSS JOIN total
ORDER BY percentage_of_accidents DESC

--#4 Description and count of accidents with severity 3 and 4 in CA. (Point No 3)

With Describe as(
SELECT Description, Severity, State, count(*) as No_of_accidents
FROM US_Accidents
Group by Description, Severity, State
HAVING Severity IN ('3','4')
AND State = 'CA'
)
SELECT Top 10 State, Description, SUM(No_of_accidents) as Accident_count
FROM Describe
GROUP BY Description, State
ORDER BY Accident_count DESC, State ASC

--#5 Next we have to find the time at which most accidents occur with severity 3 and 4 (Point No 4)
WITH CTE1 AS
(
SELECT Severity, State, DATEPART(HOUR, Time) as hour_of_day, COUNT(*) as No_of_accidents
FROM US_Accidents
GROUP BY DATEPART(HOUR, Time), State, Severity
HAVING Severity IN ('3','4')
)
SELECT State, 
CASE
	WHEN CAST(hour_of_day as int) - 12 > 0 THEN CONCAT((CAST(hour_of_day as int) - 12), ' ','PM')
	WHEN CAST(hour_of_day as int) - 12 = -12 THEN '12 AM'
	WHEN CAST(hour_of_day as int) - 12 < 0 THEN CONCAT(hour_of_day,' ', 'AM')
	WHEN CAST(hour_of_day as int) - 12 = 0 THEN CONCAT(hour_of_day ,' ', 'PM')
END as hour_of_day, 
SUM(No_of_accidents) as Accident_count  
FROM CTE1
GROUP BY hour_of_day, State
HAVING State = 'CA'
ORDER BY Accident_count DESC

--#6 At what time of day does 'At I-605 - Accident' occur most (Point No 5)
WITH Describe AS
(
SELECT CASE
	WHEN CAST(DATEPART(HOUR, Time) as int) - 12 > 0 THEN CONCAT((CAST(DATEPART(HOUR, Time) as int) - 12), ' ','PM')
	WHEN CAST(DATEPART(HOUR, Time) as int) - 12 = -12 THEN '12 AM'
	WHEN CAST(DATEPART(HOUR, Time) as int) - 12 < 0 THEN CONCAT(DATEPART(HOUR, Time),' ', 'AM')
	WHEN CAST(DATEPART(HOUR, Time) as int) - 12 = 0 THEN CONCAT(DATEPART(HOUR, Time) ,' ', 'PM')
END as hour_of_day, 
Description, State, Severity
FROM US_Accidents
WHERE Severity IN ('3','4')
AND State = 'CA'
)
SELECT Description, hour_of_day, COUNT(Description) as No_of_occurances
FROM Describe
GROUP BY hour_of_day, Description
HAVING Description = 'At I-605 - Accident.'
--HAVING hour_of_day IN ('10 AM','7 AM','8 AM','9 AM','3 PM','4 PM','5 PM','6 PM')
ORDER BY No_of_occurances DESC

--#7 Find the description and count of accident with Severity 3 and 4 during the hours of commute. (Point No 6)
WITH time_of_day AS
(
SELECT CASE
	WHEN CAST(DATEPART(HOUR, Time) as int) - 12 > 0 THEN CONCAT((CAST(DATEPART(HOUR, Time) as int) - 12), ' ','PM')
	WHEN CAST(DATEPART(HOUR, Time) as int) - 12 = -12 THEN '12 AM'
	WHEN CAST(DATEPART(HOUR, Time) as int) - 12 < 0 THEN CONCAT(DATEPART(HOUR, Time),' ', 'AM')
	WHEN CAST(DATEPART(HOUR, Time) as int) - 12 = 0 THEN CONCAT(DATEPART(HOUR, Time) ,' ', 'PM')
END as hour_of_day, 
Description, State, Severity
FROM US_Accidents
WHERE Severity IN ('3','4')
AND State = 'CA'
)
SELECT TOP 10 hour_of_day, Description, COUNT(Description) as No_of_occurances
FROM time_of_day
GROUP BY Description, hour_of_day
HAVING hour_of_day IN ('6 AM','7 AM','8 AM','9 AM','2 PM','3 PM','4 PM','5 PM','6 PM')
ORDER BY No_of_occurances DESC


