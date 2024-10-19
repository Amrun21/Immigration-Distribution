-- Total records and distinct countries in the dataset
SELECT 
    COUNT(*) AS total_records,
    COUNT(DISTINCT country) AS distinct_countries
FROM 
    immigration;

-- Changing data types to int
ALTER TABLE immigration
ALTER COLUMN arrivals INT

ALTER TABLE immigration
ALTER COLUMN arrivals_male INT

ALTER TABLE immigration
ALTER COLUMN arrivals_female INT

DELETE FROM immigration
WHERE country = 'ALL';

-- Total arrivals for each country
SELECT 
    country,
    SUM(arrivals) AS total_arrivals
FROM 
    immigration
GROUP BY 
    country
ORDER BY 
    total_arrivals DESC;

--Analyze monthly arrivals for all countries combined
SELECT 
    FORMAT(CONVERT(DATE, date), 'yyyy-MM') AS month,
    SUM(arrivals) AS total_arrivals
FROM 
    immigration
GROUP BY 
    FORMAT(CONVERT(DATE, date), 'yyyy-MM')
ORDER BY 
    month;

-- Yearly arrivals for all countries
SELECT 
    YEAR(CONVERT(DATE, date)) AS year,
    SUM(arrivals) AS total_arrivals
FROM 
    immigration
GROUP BY 
    YEAR(CONVERT(DATE, date))
ORDER BY 
    year;

-- Top 5 countries with the highest arrivals
SELECT TOP 5
    country,
    SUM(arrivals) AS total_arrivals
FROM 
    immigration
GROUP BY 
    country
ORDER BY 
    total_arrivals DESC;

-- Gender distribution of arrivals
SELECT 
    SUM(arrivals_male) AS total_male,
    SUM(arrivals_female) AS total_female,
    (CAST(SUM(arrivals_male) AS FLOAT) * 100 / NULLIF(SUM(arrivals), 0)) AS male_percentage,
    (CAST(SUM(arrivals_female) AS FLOAT) * 100 / NULLIF(SUM(arrivals), 0)) AS female_percentage
FROM 
    immigration;

-- Average monthly arrivals for each country
SELECT 
    country,
    AVG(monthly_arrivals) AS avg_monthly_arrivals
FROM (
    SELECT 
        country,
        FORMAT(CONVERT(DATE, date), 'yyyy-MM') AS month,
        SUM(arrivals) AS monthly_arrivals
    FROM 
        immigration
    GROUP BY 
        country, FORMAT(CONVERT(DATE, date), 'yyyy-MM')
) AS monthly_data
GROUP BY 
    country
ORDER BY avg_monthly_arrivals DESC

-- Create View for my visualisation
CREATE VIEW AvgMonthlyArrivals AS
SELECT 
    country,
    AVG(monthly_arrivals) AS avg_monthly_arrivals
FROM (
    SELECT 
        country,
        FORMAT(CONVERT(DATE, date), 'yyyy-MM') AS month,
        SUM(arrivals) AS monthly_arrivals
    FROM 
        immigration
    GROUP BY 
        country, FORMAT(CONVERT(DATE, date), 'yyyy-MM')
) AS monthly_data
GROUP BY 
    country;
