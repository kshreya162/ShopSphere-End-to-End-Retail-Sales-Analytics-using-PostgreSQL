/*
============================================================
Analysis : Product Performance

Business Objective:
Evaluate product and category performance to identify
best-selling products and revenue-generating categories.

============================================================
*/

-- Top Selling Products
select p.product_id,p.product_name, sum(oi.quantity) as quantity_sold,
       round(sum(oi.quantity*oi.unit_price*(1-oi.discount/100)),2) as revenue
from products p join order_items oi on p.product_id=oi.product_id
group by p.product_id,p.product_name
order by quantity_sold desc;


-- Category Performance
select c.category_id,c.category_name, sum(oi.quantity) as products_sold,
	round(sum(oi.quantity*oi.unit_price*(1-oi.discount/100)),2) as revenue
from categories c join products p on c.category_id=p.category_id join
	order_items oi on p.product_id=oi.product_id
group by c.category_id,c.category_name
order by revenue desc;


-- Top 3 Products in Each Category
with total_revenue as(select c.category_name,p.product_name,
		round(sum(oi.quantity*oi.unit_price*(1-oi.discount/100)),2) as revenue
from categories c join products p on c.category_id=p.category_id join
	order_items oi on p.product_id=oi.product_id
group by c.category_name,p.product_name),
rankings as(select *,
	dense_rank() over(partition by category_name order by revenue desc) as ranking
	from total_revenue)
select * from rankings	
where ranking<=3;