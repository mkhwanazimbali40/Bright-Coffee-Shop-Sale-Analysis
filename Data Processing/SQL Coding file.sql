select * 
from workspace.default.bright_coffee_shop_analysis_case_study_1_1 
limit 100;

------------------------------------------------
-- 1. Checking the Date Range
-------------------------------------------------
-- They started collecting the data 2023-01-01
SELECT MIN(transaction_date) AS min_date 
FROM workspace.default.bright_coffee_shop_analysis_case_study_1_1;
-- the duration of the data is 6 months
--  They last collected the data 2023-06-30

SELECT MAX(transaction_date) AS latest_date 
FROM workspace.default.bright_coffee_shop_analysis_case_study_1_1;
-------------------------------------------------
-- 2. Checking the names of the different stores
------------------------------------------------
-- we have 3 stores and their names are Lower Manhattan, Hell's Kitchen, Astoria
SELECT DISTINCT store_location
FROM workspace.default.bright_coffee_shop_analysis_case_study_1_1;

SELECT COUNT(DISTINCT store_id) AS number_of_stores
FROM workspace.default.bright_coffee_shop_analysis_case_study_1_1;
-------------------------------------------------
-- 3. Checking products sold at our stores 
------------------------------------------------
SELECT DISTINCT product_category
FROM workspace.default.bright_coffee_shop_analysis_case_study_1_1;

SELECT DISTINCT product_detail
FROM workspace.default.bright_coffee_shop_analysis_case_study_1_1;

SELECT DISTINCT product_type
FROM workspace.default.bright_coffee_shop_analysis_case_study_1_1;

SELECT DISTINCT product_category AS category,
                product_detail AS product_name
FROM workspace.default.bright_coffee_shop_analysis_case_study_1_1;

-------------------------------------------------
-- 1. Checking product prices
------------------------------------------------
SELECT MIN(unit_price) AS lowest_price
FROM workspace.default.bright_coffee_shop_analysis_case_study_1_1;

SELECT MAX(unit_price) AS highest_price
FROM workspace.default.bright_coffee_shop_analysis_case_study_1_1;

------------------------------------------------
SELECT 
      COUNT(*) AS number_of_rows,
      COUNT(DISTINCT transaction_id) AS number_of_sales,
      COUNT(DISTINCT product_id) AS number_of_products,
      COUNT(DISTINCT store_id) AS number_of_stores
FROM workspace.default.bright_coffee_shop_analysis_case_study_1_1;
------------------------------------------------
SELECT *
FROM workspace.default.bright_coffee_shop_analysis_case_study_1_1
LIMIT 10;

SELECT transaction_id,
      transaction_date,
      Dayname(transaction_date) AS Day_name,
      Monthname(transaction_date) AS Month_name,
      transaction_qty*unit_price AS revenue_per_transaction
FROM workspace.default.bright_coffee_shop_analysis_case_study_1_1;
-----------------------------------------------------
SELECT COUNT(*)
FROM workspace.default.bright_coffee_shop_analysis_case_study_1_1;


SELECT 
-- Dates
      transaction_date,
      Dayname(transaction_date) AS Day_name,
      Monthname(transaction_date) AS Month_name,
      Dayofmonth(transaction_date) AS day_of_month,
    --  date_format(transaction_time, 'HH:mm:ss') AS purchase_time,

      CASE 
          WHEN Day_name IN ('Sun' , 'Sat') THEN 'weekend'
          ELSE 'weekday'
      END AS day_classification,



--date_format(transaction_time, 'HH:mm:ss') AS purchase_time,
      CASE 
          WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '00:00:00' AND '11:59:59' THEN '01. Morning'
          WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '12:00:00' AND '16:59:59' THEN '02. Afternoon'
          WHEN date_format(transaction_time, 'HH:mm:ss') >= '17:00:00' THEN '03. Evening'
          END AS time_buckets,

-- Counts
      COUNT(DISTINCT transaction_id) AS Number_of_sales,
      COUNT(DISTINCT product_id) AS Number_of_products,
      COUNT(DISTINCT store_id) AS Number_of_stores,

-- Revenue
      SUM(transaction_qty*unit_price) AS revenue_per_day,

      CASE
          WHEN revenue_per_day <=50 THEN '01. Low Spend'
          WHEN revenue_per_day BETWEEN 51 AND 100 THEN '02. Medium Spend'
          ELSE '03. High Spend'
      END AS spend_bucket,    

--Categorical columns
store_location,
product_category,
product_detail
FROM workspace.default.bright_coffee_shop_analysis_case_study_1_1
GROUP BY transaction_date,
         Day_name,
         store_location,
         product_category,
         product_detail,
         Month_name,
         time_buckets;
        

