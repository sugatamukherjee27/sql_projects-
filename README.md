# 🛒 E-Commerce Sales Analysis
This project presents a comprehensive analysis of an e-commerce company's sales data using SQL. The dataset consists of three primary components: customers, products, and invoices. It aims to extract insights into customer behavior, product performance, and revenue generation.

## 📂 Dataset Overview
The dataset includes:
- **customers.csv**: Contains unique customer IDs and their countries.
- **products.csv**: Lists product stock codes along with descriptions.
- **invoices.csv**: Transactional data with invoice numbers, customer IDs, quantities, unit prices, and stock codes.
- **ecomm_data.sql**: SQL schema and queries for creating and querying the database.

## 🧠 Objectives
- Analyze most sold and most profitable products.
- Identify top-spending customers and loyal buyers.
- Understand revenue trends and pricing dynamics.
- Explore purchasing patterns through advanced SQL queries.

## 🛠️ Technologies Used
- **SQL (SQLite/PostgreSQL)** – for querying data.
- **Python (optional)** – for additional visualization or transformation.
- **Pandas** – if required for CSV manipulation.
- **Jupyter Notebook** – for interactive exploration (optional).
- **VS Code / DB Browser** – for working with SQL and data.

## 🔍 Key SQL Queries
Here are some categories of queries included in the SQL script:

### ✅ Basic Queries
- List all customers, products, and invoices.
- Search invoices containing specific products.

### 📊 Intermediate Analysis
- Top products by quantity sold.
- Top products by revenue.
- Customer lifetime value.

### 📈 Advanced Insights
- Most loyal customers (most invoices).
- Customers who only bought one type of product.
- Invoice with highest revenue.

### 🪟 Window Functions
- Rank top products per customer.
- Running revenue total per customer.
- Track price changes of products over time.

### 🧱 CTEs (Common Table Expressions)
- High-spending customers.
- Average product prices.
- Product preferences per customer.
