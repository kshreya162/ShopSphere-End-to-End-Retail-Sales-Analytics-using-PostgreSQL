/*
============================================================
Analysis : Customer Analytics

Business Objective:
Analyze customer purchasing behavior to identify
high-value customers, evaluate purchase frequency,
and measure customer retention.

============================================================
*/

-- Top Customers
select c.customer_id,c.first_name, sum(oi.quantity) as quantity_purchased, 
	   round(sum(oi.quantity*oi.unit_price*(1-oi.discount/100)),2) as revenue
from customers c join orders o on c.customer_id=o.customer_id join
	order_items oi on o.order_id=oi.order_id
group by c.customer_id,c.first_name
order by revenue desc;


-- Customer Lifetime Value
select c.customer_id,c.First_name, count(distinct o.order_id) as total_orders,
	coalesce(round(sum(oi.quantity*oi.unit_price*(1-oi.discount/100)),2),0) as revenue
from customers c left join orders o on c.customer_id=o.customer_id
left join order_items oi on o.order_id=oi.order_id
group by c.customer_id,c.first_name
order by revenue desc;

-- Customer Ranking
with total_revenue as(
select c.customer_id,c.first_name,
	round(sum(oi.quantity*oi.unit_price*(1-oi.discount/100)),2) as revenue
from customers c join orders o on c.customer_id=o.customer_id
join order_items oi on o.order_id=oi.order_id
group by c.customer_id,c.first_name)
select *,
	dense_rank() over(order by revenue desc) as ranking
	from total_revenue;

-- Customer Purchase Gap Analysis
with previous as(select customer_id, order_date, 
lag(order_date) over(partition by customer_id order by order_date) as previous_order_date
from orders)
select *, coalesce(order_date-previous_order_date,0) as days_since_previous_order
from previous;

-- First & Last Purchase
select customer_id,order_date,
first_value(order_date) over(
	partition by customer_id order by order_date
	) as first_purchase,
last_value(order_date) over(
	partition by customer_id order by order_date rows between unbounded preceding and unbounded following
	) as last_purchase
from orders;

-- Customer Retention
with nexts as(select customer_id,order_date,
	lead(order_date) 
		over(partition by customer_id order by order_date) as next_date
from orders),
days_30 as(select *, next_date-order_date as days
from nexts)
select *, case when days<=30 then 'Yes'
		 else 'No' end as returned_within_30_days
from days_30;