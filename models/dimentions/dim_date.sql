{{ config(
    materialized='table'
) }}

WITH date_series AS (
    SELECT 
        CAST(DATEADD(DAY, number, '2020-01-01') AS DATE) AS full_date
    FROM master.dbo.spt_values
    WHERE type = 'P' AND number BETWEEN 0 AND 4017  -- ~11 years
),

date_parts AS (
    SELECT
        CONVERT(INT, FORMAT(full_date, 'yyyyMMdd')) AS date_key,
        full_date,
        DATEPART(WEEKDAY, full_date) AS day_of_week,
        DATENAME(WEEKDAY, full_date) AS day_name,
        DAY(full_date) AS day_of_month,
        DATEPART(DAYOFYEAR, full_date) AS day_of_year,
        DATEPART(WEEK, full_date) AS week_of_year,
        MONTH(full_date) AS month,
        DATENAME(MONTH, full_date) AS month_name,
        DATEPART(QUARTER, full_date) AS quarter,
        YEAR(full_date) AS year,
        CASE 
            WHEN DATEPART(WEEKDAY, full_date) IN (1, 7) THEN 1 
            ELSE 0 
        END AS is_weekend  -- BIT-compatible (1 or 0)
    FROM date_series
)

SELECT *
FROM date_parts
