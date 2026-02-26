-- Problem 1. Question 1.) Return the latest 10 completed orders in 2025, with customer full name and order total. 
-- Answer: (PostgreSQL) For this query we will need to grab order id, order_date, and total_amount from orders.Then we need the customers name so we will take the first name and last name from the customers table. We need the full name so we use the || ‘ ‘ || to concat these two values together and make a new value called customers_name. Since we are using two tables of orders and customers we need to join them together with customer_id on both tables. A few filters we will want is that the orders need to be “completed” so we're going to assume that completed is the value we need for status on orders. Then we need to filter for just order_dates in the year 2025. Then we want the 10 latest orders so we will order by order_date desc so we see the newest first. Then limiting by 10.

select o.order_id, o.order_date, c.first_name || ’ ’ || c.last_name as customers_name, o.total_amount 
from orders o 
join customers c on o.customer_id = c.customer_id
where o.status = 'completed'
and cast(o.order_date as date) between ‘2025-01-01’ and ‘2025-12-31’
order by o.order_date desc
limit 10; 
