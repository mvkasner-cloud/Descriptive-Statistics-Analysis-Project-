--select * from [dbo].[delivery_data_problematic_SQL];

-- Creating a new table 'delivery_data_clean'
SELECT 
    Region,
    ProductCategory,
    TRY_CAST(DeliveryTime AS FLOAT) AS DeliveryTime
INTO delivery_data_clean
FROM [dbo].[delivery_data_problematic_SQL]
WHERE TRY_CAST(DeliveryTime AS FLOAT) IS NOT NULL;

--SELECT TOP 1 * FROM delivery_data_clean;


-- 1. General statistics for the DeliveryTime column
SELECT 
    COUNT(*) AS total_orders,
    MIN(DeliveryTime) AS min_time,
    MAX(DeliveryTime) AS max_time,
    AVG(DeliveryTime) AS avg_time,
    STDEV(DeliveryTime) AS std_dev,
    VAR(DeliveryTime) AS variance
FROM [dbo].[delivery_data_clean];


-- 2. Quartile values (Q1, Median, Q3) for DeliveryTime
SELECT 
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY DeliveryTime) OVER () AS Q1,
    PERCENTILE_CONT(0.5)  WITHIN GROUP (ORDER BY DeliveryTime) OVER () AS Median,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY DeliveryTime) OVER () AS Q3
FROM [dbo].[delivery_data_clean];


-- 3. Regional analysis: basic statistics by Region
SELECT 
    Region,
    COUNT(*) AS total_orders,
    MIN(DeliveryTime) AS min_time,
    MAX(DeliveryTime) AS max_time,
    AVG(DeliveryTime) AS avg_time,
    STDEV(DeliveryTime) AS std_dev
FROM [dbo].[delivery_data_clean]
GROUP BY Region
ORDER BY avg_time;


-- 4. Product category analysis: basic statistics by ProductCategory
SELECT 
    ProductCategory,
    COUNT(*) AS total_orders,
    MIN(DeliveryTime) AS min_time,
    MAX(DeliveryTime) AS max_time,
    AVG(DeliveryTime) AS avg_time,
    STDEV(DeliveryTime) AS std_dev
FROM [dbo].[delivery_data_clean]
GROUP BY ProductCategory
ORDER BY avg_time;



-- 5. Two-dimensional analysis Region × ProductCategory with SLA metric
SELECT 
    Region,
    ProductCategory,
    COUNT(*) AS total_orders,
    AVG(DeliveryTime) AS avg_time,
    MIN(DeliveryTime) AS min_time,
    MAX(DeliveryTime) AS max_time,
    SUM(CASE WHEN DeliveryTime < 7 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS SLA_percent
FROM [dbo].[delivery_data_clean]
GROUP BY Region, ProductCategory
ORDER BY Region, ProductCategory;

-- 6. Outlier detection based on IQR (Interquartile Range)
-- First, store Q1 and Q3 in variables
DECLARE @Q1 FLOAT, @Q3 FLOAT;

SELECT 
    @Q1 = PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY DeliveryTime) OVER (),
    @Q3 = PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY DeliveryTime) OVER ()
FROM [dbo].[delivery_data_clean];

-- Then use the IQR to filter out the outliers
SELECT *
FROM [dbo].[delivery_data_clean]
WHERE DeliveryTime < (@Q1 - 1.5 * (@Q3 - @Q1))
   OR DeliveryTime > (@Q3 + 1.5 * (@Q3 - @Q1));

-- create a new table for Tableau
SELECT * INTO delivery_data_export
FROM [dbo].[delivery_data_clean]
