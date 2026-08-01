/*
============================================================
Project : ShopSphere Retail Sales Analytics

Analysis : Executive Performance

Business Objective:
Provide an executive dashboard by calculating the company's
key performance indicators (KPIs), including customers,
products, orders, revenue, and returns.

============================================================
*/

--Executive KPI dashboard

--Total Customers
select count(customer_id) as total_customers from customers;

--Total Products
select count(product_id) as total_products from products;

--Total Orders
select count(order_id) as total_orders from orders;

--Total Revenue
select round(sum(quantity*unit_price*(1-discount/100)),2) as total_revenue from order_items;

--Total Returned Items
select count(return_id) as total_returned_items from returns;