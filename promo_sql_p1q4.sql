-- Pivot 2025 monthly revenue per category into 12 columns.
-- Answer: (Oracle SQL) (or you could just do 12 case statements for each month). Selecting the category from the product table. We also need to extract the month from order_date from the orders table and select that as well. We also need to select the  revenue value we created from the order items table where we take order item quantity times order item price to get revenue. Again we need three tables for this problem: products, orders, and order items so we have to join them based on product_id on products and product_id on order items. Then order_id on order items table with order_id on orders table. A few filters we will want is that the orders need to be “completed” so we're going to assume that completed is the value we need for status on orders. Then we need to filter for just order_dates in the year 2025. After that we can use the pivot function to aggregate sum of revenue for each month number. Then order these by category.

select * from (
select p.category, EXTRACT(MONTH FROM o.order_date) AS month_num, oi.qty * oi.price AS revenue
from products p
join order_items oi ON p.product_id = oi.product_id
join orders o on oi.order_id = o.order_id
where o.status = 'completed'
and cast(o.order_date as date) between ‘2025-01-01’ and ‘2025-12-31’
)
PIVOT (
SUM(revenue) FOR month_num IN (1 AS jan, 2 AS feb, 3 AS mar, 4 AS apr, 5 AS may, 6 AS jun, 7 AS jul, 8 AS aug, 9 AS sep, 10 AS oct, 11 AS nov, 12 AS dec)
)
ORDER BY category;
