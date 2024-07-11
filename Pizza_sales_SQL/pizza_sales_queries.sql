use db_pizza;
-- UPDATE pizza_sales
-- SET order_date = 
--     CASE 
--         WHEN order_date REGEXP '^[0-9]{2}-[0-9]{2}-[0-9]{4}$' THEN
--             CASE 
--                 WHEN CAST(SUBSTRING_INDEX(order_date, '-', 1) AS UNSIGNED) > 12 THEN
--                     DATE_FORMAT(STR_TO_DATE(order_date, '%d-%m-%Y'), '%Y-%m-%d')
--                 ELSE
--                     DATE_FORMAT(STR_TO_DATE(order_date, '%m-%d-%Y'), '%Y-%m-%d')
--             END
--         WHEN order_date REGEXP '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$' THEN
--             CASE 
--                 WHEN CAST(SUBSTRING_INDEX(order_date, '/', 1) AS UNSIGNED) > 12 THEN
--                     DATE_FORMAT(STR_TO_DATE(order_date, '%d/%m/%Y'), '%Y-%m-%d')
--                 ELSE
--                     DATE_FORMAT(STR_TO_DATE(order_date, '%m/%d/%Y'), '%Y-%m-%d')
--             END
--         ELSE order_date
--     END
-- WHERE order_date IS NOT NULL;

-- ALTER TABLE pizza_sales
-- MODIFY order_date date;


select * from pizza_sales;

-- total revenue
select round(sum(total_price),2) as Total_Revenue from pizza_sales;

-- Average Order Values
select round(sum(total_price) / count(distinct order_id),2) as Avg_Order_Value from pizza_sales;

-- Total Pizza Sold
select sum(quantity) as Total_Pizza_Sold  from pizza_sales;

-- Total Orders
select count(distinct order_id) as Total_Orders from pizza_sales;

-- Avg Pizzas Per Order
select round(sum(quantity) / count(distinct order_id),2) as Avg_Pizzas_per_Order from pizza_sales;

-- Total Trend for total orders:
select dayname(order_date) as order_day, count(distinct order_id) as Total_Orders from pizza_sales
group by 1;

-- Monthly trends for orders
select monthname(order_date) as Month_Name, count(distinct order_id) as Total_Orders from pizza_sales
group by 1
order by 2 desc;

-- Percentage of Sales by Pizza Category:
select pizza_category, round(sum(total_price),2) as Total_Sales,
round(sum(total_price) / (select sum(total_price) from pizza_sales) * 100,2) as 
PCT_Total_Sales
 from pizza_sales
group by 1;

-- Percentage of Sales By Pizza Size:
select pizza_size, round(sum(total_price),2) as Total_Sales, 
round(sum(total_price) / (select sum(total_price) from pizza_sales) * 100,2) as PS_Total_Sales
from pizza_sales
group by 1;

-- Total Pizzas Sold by Category:
SELECT pizza_category, SUM(quantity) as Total_Quantity_Sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC;
 
-- Top 5 Pizzas by Revenue:
select pizza_name, sum(total_price) as Total_Revenue  from pizza_sales 
group by 1
order by 2 desc
limit 5;

-- Bottom 5 Pizzas by Revenue:
select pizza_name, round(sum(total_price),2) as Total_Revenue  from pizza_sales 
group by 1
order by 2 
limit 5;

-- Top 5 Pizzas by Quantity
SELECT pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC
limit 5;

-- Bottom 5 Pizzas by Quantity
SELECT pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold
limit 5;

-- Top 5 Pizzas by Total Orders
SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC
limit 5;

-- Bottom 5 Pizzas by Total Orders
SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders limit 5




















































