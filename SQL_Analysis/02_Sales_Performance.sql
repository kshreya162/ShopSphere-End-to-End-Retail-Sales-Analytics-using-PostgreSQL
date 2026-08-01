/*
============================================================
Analysis : Sales Performance

Business Objective:
Analyze sales performance across different states and
track monthly revenue trends to support strategic
business decisions.

============================================================
*/

-- Revenue by State
select c.state, 
round(sum(oi.quantity*oi.unit_price*(1-oi.discount/100)),2) as revenue
from customers c join orders o on c.customer_id=o.customer_id
join order_items oi on o.order_id=oi.order_id 
group by c.state
order by revenue desc;


-- Monthly Sales Trend
select extract(year from o.order_date) as year,
	   extract(month from o.order_date) as month,
	   count(distinct o.order_id) as total_orders,
	   round(sum(oi.quantity*oi.unit_price*(1-oi.discount/100)),2) as revenue
from orders o join order_items oi on o.order_id=oi.order_id
group by year,month
order by year,month;