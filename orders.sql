SELECT *
FROM [dbo].[SampleSuperstore]

SELECT TOP 5 *
FROM dbo.SampleSuperstore;

-- Data Cleaning
--Chacking  for null values
SELECT
    SUM(CASE WHEN Ship_Mode IS NULL THEN 1 ELSE 0 END) AS ShipMode_Null,
    SUM(CASE WHEN Segment IS NULL THEN 1 ELSE 0 END) AS Segment_Null,
    SUM(CASE WHEN Sales IS NULL THEN 1 ELSE 0 END) AS Sales_Null,
    SUM(CASE WHEN Profit IS NULL THEN 1 ELSE 0 END) AS Profit_Null
FROM dbo.SampleSuperstore;

-- Check for Duplicate Rows
SELECT
    Ship_Mode,
    Segment,
    Country,
    City,
    State,
    Postal_Code,
    Region,
    Category,
    Sub_Category,
    Sales,
    Quantity,
    Discount,
    Profit,
    COUNT(*) AS cnt
FROM dbo.SampleSuperstore
GROUP BY
    Ship_Mode,
    Segment,
    Country,
    City,
    State,
    Postal_Code,
    Region,
    Category,
    Sub_Category,
    Sales,
    Quantity,
    Discount,
    Profit
HAVING COUNT(*) > 1;

-- Total Records
SELECT COUNT(*) AS Total_Records
FROM dbo.SampleSuperstore;

-- Total Sales
SELECT SUM(Sales) AS Total_Sales    
FROM dbo.SampleSuperstore;

-- Total Profit
SELECT SUM(Profit) AS Total_Profit
FROM dbo.SampleSuperstore;

-- Profit_Margin_Percent
SELECT
    ROUND(SUM(Profit)/SUM(Sales)*100,2) AS Profit_Margin_Percent
FROM dbo.SampleSuperstore;

-- Sales by Region
SELECT
    Region,
    ROUND(SUM(Sales),2) AS Total_Sales
FROM dbo.SampleSuperstore
GROUP BY Region
ORDER BY Total_Sales DESC;


-- Profit by Region
SELECT
    Region,
    ROUND(SUM(Profit),2) AS Total_Profit
FROM dbo.SampleSuperstore
GROUP BY Region
ORDER BY Total_Profit DESC;

-- Sales by Category
SELECT
    Category,
    ROUND(SUM(Sales),2) AS Total_Sales
FROM dbo.SampleSuperstore
GROUP BY Category
ORDER BY Total_Sales DESC;

-- Profit by Category
SELECT
    Category,
    ROUND(SUM(Profit),2) AS Total_Profit
FROM dbo.SampleSuperstore
GROUP BY Category
ORDER BY Total_Profit DESC;


-- Sales by Sub-Category
SELECT
    Sub_Category,
    ROUND(SUM(Sales),2) AS Total_Sales
FROM dbo.SampleSuperstore
GROUP BY Sub_Category
ORDER BY Total_Sales DESC;

-- Profit by Sub-Category
SELECT
    Sub_Category,
    ROUND(SUM(Profit),2) AS Total_Profit
FROM dbo.SampleSuperstore
GROUP BY Sub_Category
ORDER BY Total_Profit DESC;

-- Loss-Making Sub-Categories
SELECT
    Sub_Category,
    ROUND(SUM(Profit),2) AS Total_Profit
FROM dbo.SampleSuperstore
GROUP BY Sub_Category
HAVING SUM(Profit) < 0
ORDER BY Total_Profit ASC;

-- cause of loss in sub-categories
SELECT
    Sub_Category,
    ROUND(SUM(Sales),2) AS Total_Sales,
    ROUND(SUM(Profit),2) AS Total_Profit,
    ROUND(SUM(Profit)/SUM(Sales)*100,2) AS Profit_Margin_Percent
FROM dbo.SampleSuperstore
GROUP BY Sub_Category
HAVING SUM(Profit) < 0
ORDER BY Profit_Margin_Percent ASC;

-- Impact of Discounts
SELECT
    Discount,
    ROUND(SUM(Sales),2) AS Total_Sales,
    ROUND(SUM(Profit),2) AS Total_Profit,
    ROUND(SUM(Profit)/SUM(Sales)*100,2) AS Profit_Margin_Percent
FROM dbo.SampleSuperstore
GROUP BY Discount

-- Customer Segments:
SELECT
    Segment,
    ROUND(SUM(Sales),2) AS Total_Sales,
    ROUND(SUM(Profit),2) AS Total_Profit,
    ROUND(SUM(Profit)/SUM(Sales)*100,2) AS Profit_Margin_Percent
FROM dbo.SampleSuperstore
GROUP BY Segment
ORDER BY Total_Sales DESC;

-- Which states within the Central region are responsible for its low profitability?

SELECT
    State,
    ROUND(SUM(Sales),2) AS Total_Sales,
    ROUND(SUM(Profit),2) AS Total_Profit,
    ROUND(SUM(Profit)/SUM(Sales)*100,2) AS Profit_Margin
FROM dbo.SampleSuperstore
WHERE Region = 'Central'
GROUP BY State
ORDER BY Total_Profit;

-- Does the choice of shipping mode impact profitability?
SELECT
    Ship_Mode,
    ROUND(SUM(Sales),2) AS Total_Sales,
    ROUND(SUM(Profit),2) AS Total_Profit,
    ROUND(SUM(Profit)/SUM(Sales)*100,2) AS Profit_Margin
FROM dbo.SampleSuperstore
GROUP BY Ship_Mode
ORDER BY Total_Profit DESC;