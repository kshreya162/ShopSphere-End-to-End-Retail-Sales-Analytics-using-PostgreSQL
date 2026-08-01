/*
============================================================
Analysis : Employee Performance

Business Objective:
Measure employee performance based on orders handled
and revenue generated.

============================================================
*/

-- Employee Performance
select e.employee_id,e.first_name, count(distinct o.order_id) as orders_handled,
	round(sum(oi.quantity*oi.unit_price*(1-oi.discount/100)),2) as revenue
from employees e left join orders o on e.employee_id=o.employee_id 
left join order_items oi on o.order_id=oi.order_id
group by e.employee_id,e.first_name
order by revenue desc;