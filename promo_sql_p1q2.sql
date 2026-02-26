-- Problem 1 Q2.) Show categories with ≥ $1M revenue in 2025 (sum from order_items). 
-- Answer:  This query will use a few key functions like group by, having, sum, and order by. We first start by 
-- selecting the category from the product table. We also need to select the revenue value we can create from the 
-- order items table where we take order item quantity times order item price to get total revenue. We also need 
-- three tables for this problem: products, orders, and order items so we have to join them based on product_id 
-- on products and product_id on order items. Then order_id on order items table with order_id on orders table. 
-- A few filters we will want is that the orders need to be “completed” so we're going to assume that completed 
-- is the value we need for status on orders. Then we need to filter for just order_dates in the year 2025. Now 
-- we have the query set we want to group by product category since our main focus is the categories. Then following 
-- this use a having sum of total revenue greater than or equal to 1000000 since we can’t use a where statement for 
-- an aggregate function like sum. Then lastly having an order by statement on total_renenue and mark it with desc 
-- so we can see the highest first.

select p.category, sum(oi.qty * oi.price) as total_revenue
from products p
join order_items oi on p.product_id = oi.product_id
join orders o on oi.order_id = o.order_id
where o.status = 'completed'
and cast(o.order_date as date) between ‘2025-01-01’ and ‘2025-12-31’
group by p.category
having sum(oi.qty * oi.price) >= 1000000
order by total_revenue desc;

