/*
============================================================
Analysis : Revenue Optimization

Business Objective:
Identify products contributing the highest share
of revenue and determine the products responsible
for 80% of total sales.

============================================================
*/

-- Sales Contribution
with total_revenue as(
	select p.product_name,
	round(sum(oi.quantity*oi.unit_price*(1-oi.discount/100)),2) as revenue
	from products p join order_items oi on p.product_id=oi.product_id
	group by p.product_name
)
select *, sum(revenue) over() as totals, round(revenue*100/sum(revenue) over(),2) as contribution
from total_revenue;

-- Pareto Analysis
with product_revenue as(
	select p.product_name,
	round(sum(oi.quantity*oi.unit_price*(1-oi.discount/100)),2) as revenue
	from products p join order_items oi on p.product_id=oi.product_id
	group by p.product_name
	
),
pareto as(
	select *, 
	sum(revenue) over() as total,
	sum(revenue) over(order by revenue desc) as running_revenue,
	round(sum(revenue) over(order by revenue desc)*100/sum(revenue) over(),2) as running_percentage
	from product_revenue
)

select *, case when running_percentage<=80 then 'TOP 80%'
				else 'Remaining 20%' end as pareto_group
from pareto;