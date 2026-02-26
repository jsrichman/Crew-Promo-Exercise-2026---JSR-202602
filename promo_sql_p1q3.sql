-- Problem 1 Q3.) For each category, list the top 3 products by revenue in 2025 (ties allowed). 
-- Answer: (Postgres) In this problem we will need to use two functions CTE and rank functions. We will wrap this 
-- query in a CTE in order to get the result we want. As for the query inside the wrap we start by selecting the 
-- category and product name from the product table. We also need to select the revenue value we created from the 
-- order items table where we take order item quantity times order item price to get revenue. Lastly, in order to 
-- get the top three ranked we need to use the rank function where rank over then partition by category (since 
-- we're splitting this by category for three products in each) then order by revenue which is again just quantity 
-- times price. Again we need three tables for this problem: products, orders, and order items so we have to join 
-- them based on product_id on products and product_id on order items. Then order_id on order items table with order_id 
-- on orders table. A few filters we will want is that the orders need to be “completed” so we're going to assume that 
-- completed is the value we need for status on orders. Then we need to filter for just order_dates in the year 2025. 
-- Then group by product category and product name. Now to round this out we need to make this a CTE to get the top 3 
-- so we do a with statement from our created ranked table as then wrap our query around in brackets. We then can 
-- select from this ranked table the product category, product name, total revenue, and rank. Where the filter just 
-- needs to be 3 or equal to three to get the top three including ties then order by category and rank.

WITH ranked AS (
select p.category, p.name, SUM(oi.qty * oi.price) AS total_revenue, 
RANK() OVER (PARTITION BY p.category ORDER BY SUM(oi.qty * oi.price) DESC) AS rnk
from products p
join order_items oi ON p.product_id = oi.product_id
join orders o ON oi.order_id = o.order_id
where o.status = 'completed'
and cast(o.order_date as date) between ‘2025-01-01’ and ‘2025-12-31’
group by p.category, p.name
)
select category, name, total_revenue, rnk
from ranked
where rnk <= 3
order by category, rnk;

