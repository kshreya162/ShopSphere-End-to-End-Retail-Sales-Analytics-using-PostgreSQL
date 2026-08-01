/*
============================================================
Analysis : RFM Customer Segmentation

Business Objective:
Segment customers based on Recency, Frequency,
and Monetary value to support customer retention
and targeted marketing strategies.

============================================================
*/

-- RFM Customer Segmentation
with details as(select c.customer_id,c.first_name, 
	current_date-max(o.order_date) as recency, 
	count(distinct o.order_id) as frequency, 
	round(sum(oi.quantity*oi.unit_price*(1-oi.discount/100))) as monetary 
from customers c left join orders o on c.customer_id=o.customer_id 
left join order_items oi on o.order_id=oi.order_id group by c.customer_id,c.first_name
), 
scores as(select *, 5-ntile(4) over (order by recency) as r_score, 
	5 - ntile(4) over (order by frequency desc) as f_score, 
	5 - ntile(4) over (order by monetary desc) as m_score from details
	) 
select *, case when R_score>=4 and f_score>=4 and m_score>=4 then 'Champions' 
			when r_score >=3 AND f_score >=3 then 'Loyal Customers' 
			when r_score <=2 AND f_score >=3 then 'At Risk' 
			when r_score =1 AND f_score =1 then 'Lost Customers' else 'Others' end as title from scores;