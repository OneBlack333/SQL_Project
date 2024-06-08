use pizza_project;
# Retrieve the total number of orders placed.
select count(distinct order_id) as order_placed from orders;

# Calculate the total revenue generated from pizza sales.
select round(sum(od.quantity * p.price),2) as revenue from order_details od join pizzas p 
on od.pizza_id = p.pizza_id;

# Identify the highest-priced pizza.

select pt.name,p.price from pizzas p join  pizza_types pt
on pt.pizza_type_id = p.pizza_type_id
order by price desc
limit 1;

# Identify the most common pizza size ordered.

select size,count(size) as most_common_pizza from pizzas
group by size
order by most_common_pizza desc
limit 1;

# List the top 5 most ordered pizza types along with their quantities.
select pt.name , count(od.quantity) as pizza_quantity from pizza_types pt join pizzas p
on pt.pizza_type_id = p.pizza_type_id
join order_details od on p.pizza_id = od.pizza_id
group by pt.name
order by pizza_quantity desc
limit 5;

# Find the total quantity of each pizza category ordered 
select pt.category,count(od.quantity) as Quantity  from pizza_types pt join pizzas p
on pt.pizza_type_id = p.pizza_type_id
join order_details od on p.pizza_id = od.pizza_id
group by pt.category;

# Determine the distribution of orders by hour of the day (at which time the orders are maximum 
# (for inventory management and resource allocation).
select hour(time) as 'Hour of the day', count(distinct order_id) as 'No_of_Orders'
from orders
group by hour(time)
order by No_of_Orders desc; 

# Find the category-wise distribution of pizzas (to understand customer behaviour).
select category,count(distinct pizza_type_id) as count_pizzas  from pizza_types 
group by category
order by count_pizzas;

# Group the orders by date and calculate the average number of pizzas ordered per day.
with cte as (
select  o.date as date ,sum(od.quantity) as count_1 from orders o join order_details od
on o.order_id = od.order_id
group by o.date
)
select avg(count_1) as avg_no_pizza  from cte;

# Calculate the percentage contribution of each pizza type to total revenue
# (to understand % of contribution of each pizza in the total revenue)

select pt.category, concat(cast((sum(p.price * od.quantity) / 
(select sum(p.price * od.quantity) from order_details od join pizzas p
on od.pizza_id = p.pizza_id)) * 100 as decimal(10,2)),'%') as revenue 
from pizza_types pt join pizzas p 
on p.pizza_type_id = pt.pizza_type_id
join order_details od 
on od.pizza_id = p.pizza_id
group by pt.category;

# Analyze the cumulative revenue generated over time.
with cte as (
select o.date as Date, cast(sum(od.quantity * p.price) as decimal(10,2)) as revenue from orders o join order_details od 
on  o.order_id = od.order_id
join pizzas p
on p.pizza_id = od.pizza_id
group by o.date)

select Date, revenue , sum(revenue) over (order by Date) as 'Cumulative Sum'  from cte;

# Determine the top 3 most ordered pizza types based on revenue for each pizza category 
# (In each category which pizza is the most selling)

select pt.name,round(sum(od.quantity * p.price),2) as revenue from order_details od join pizzas p 
on od.pizza_id = p.pizza_id
join pizza_types pt 
on pt.pizza_type_id = p.pizza_type_id
group by pt.name
order by round(sum(od.quantity * p.price),2) desc
limit 3;

