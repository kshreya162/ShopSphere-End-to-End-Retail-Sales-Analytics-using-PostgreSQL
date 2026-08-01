# ShopSphere Retail Sales Analytics using PostgreSQL

## Business Problem

ShopSphere is a retail company that collects transactional data from customers, orders, products, payments, employees, suppliers, and returns.

Although large volumes of data are generated daily, the business lacks a centralized analytical process to answer important operational and strategic questions.

As a data analyst, the objective of this project is to transform raw transactional data into actionable business insights using SQL.

## Project Objectives

The analysis aims to:

- Monitor overall business performance through executive KPIs.
- Identify top-performing products and categories.
- Analyze customer purchasing behavior and lifetime value.
- Evaluate employee sales performance.
- Track monthly sales trends and revenue growth.
- Identify products contributing most to revenue.
- Segment customers for targeted marketing using RFM analysis.

## Database Overview

The project is built on a normalized relational database consisting of **10 interconnected tables** that simulate a real-world retail sales environment.

| Table | Description |
|--------|-------------|
| Customers | Customer information and demographics |
| Orders | Customer order records |
| Order_Items | Products included in each order |
| Products | Product catalog |
| Categories | Product categories |
| Employees | Employees responsible for processing orders |
| Suppliers | Supplier information |
| Payments | Payment details for orders |
| Returns | Returned products |
| Stores | Store information |

The tables are connected using **Primary Keys** and **Foreign Keys** to maintain referential integrity and accurately represent business relationships.

---
## Entity Relationship Diagram

<p align="center">
  <img src="Images/ER_Diagram.png" alt="ShopSphere ER Diagram" width="900">
</p>

---
## Technologies Used

- PostgreSQL
- pgAdmin 4
- SQL
- Git
- GitHub

---

## SQL Concepts Demonstrated

This project demonstrates practical usage of SQL for business analytics, including:

- Data Retrieval
- Filtering and Sorting
- Aggregate Functions
- GROUP BY and HAVING
- Joins
- Subqueries
- Common Table Expressions (CTEs)
- CASE Expressions
- COALESCE
- Date Functions
- Window Functions
- Ranking Functions
- Running Totals
- Rolling Averages
- LAG() and LEAD()
- FIRST_VALUE() and LAST_VALUE()
- Pareto (80/20) Analysis
- RFM Customer Segmentation

---

## Analytical Solutions

The project focuses on solving real business problems across multiple business domains.

### Executive Performance

- Monitored overall business performance using executive KPIs.
- Measured revenue, customer base, order volume, and returned items.

### Sales Analysis

- Analyzed revenue across different states.
- Identified monthly sales trends.
- Calculated cumulative revenue and month-over-month growth.

### Product Analysis

- Identified top-selling products.
- Evaluated category performance.
- Ranked the best-performing products within each category.
- Determined which products contribute to 80% of total revenue using Pareto analysis.

### Customer Analytics

- Identified high-value customers.
- Calculated Customer Lifetime Value (CLV).
- Ranked customers based on revenue contribution.
- Analyzed customer purchasing intervals and retention.
- Segmented customers using RFM analysis for targeted marketing strategies.

### Employee Performance

- Evaluated employee contribution based on revenue generated and orders handled.

---

## Business Value Delivered

The analysis provides actionable insights that can help business stakeholders:

- Monitor business performance through executive KPIs.
- Identify high-performing products and categories.
- Recognize the company's most valuable customers.
- Improve customer retention through behavioral analysis.
- Optimize marketing campaigns using RFM segmentation.
- Focus inventory planning on products driving the majority of revenue.
- Monitor sales growth and identify seasonal trends.
- Support strategic business decisions using data-driven insights.

---

## Repository Structure

```
ShopSphere-Retail-Sales-Analytics/
│
├── Database/
│   ├── Create_Tables.sql
│   ├── Insert_Data.sql
│
├── Business Analysis/
│   ├── Executive_Performance.sql
│   ├── Sales_Analysis.sql
│   ├── Customer_Analytics.sql
│   ├── Product_Analytics.sql
│   ├── Employee_Analytics.sql
│   ├── Revenue_Optimization.sql
│
├── Images/
│
└── README.md
```

---

## Future Enhancements

The project will be extended by:

- Developing an interactive Power BI dashboard.
- Performing exploratory data analysis using Python (Pandas & Matplotlib).
- Implementing SQL Views for reporting.
- Expanding the project into a complete end-to-end retail analytics solution.

---

## Author

**Shreya K**
