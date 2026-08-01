/*
============================================================
Analysis : Revenue Trend Analysis

Business Objective:
Monitor revenue trends over time using cumulative
revenue, growth analysis, and rolling averages.

============================================================
*/

-- Running Revenue
with total_revenue as(select extract(year from o.order_date) as year,
	   extract(month from o.order_date) as month,
	   round(sum(oi.quantity*oi.unit_price*(1-oi.discount/100)),2) as revenue
from orders o join order_items oi on o.order_id=oi.order_id
group by year,month)

select *,
sum(revenue) over(order by year,month) as running_revenue
from total_revenue;

-- Month-over-Month Growth
with total_revenue as(select extract(year from o.order_date) as year,
	   extract(month from o.order_date) as month,
	   round(sum(oi.quantity*oi.unit_price*(1-oi.discount/100)),2) as revenue
from orders o join order_items oi on o.order_id=oi.order_id
group by year,month)
select *, coalesce(lag(revenue) over(order by year,month),0) as previous_month,
coalesce(revenue-(lag(revenue) over(order by year,month)),0) as growth
from total_revenue;

-- Rolling 3-Month Average
with total_revenue as(select extract(year from o.order_date) as year,
	   extract(month from o.order_date) as month,
	   round(sum(oi.quantity*oi.unit_price*(1-oi.discount/100)),2) as revenue
from orders o join order_items oi on o.order_id=oi.order_id
group by year,month)

select *, 
round(avg(revenue) over(order by year,month rows between 2 preceding and current row),2) as average
from total_revenue;