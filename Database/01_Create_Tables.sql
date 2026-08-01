/*
============================================================
Project : ShopSphere Retail Sales Analytics
Database: PostgreSQL

Description:
This script creates the database schema for the ShopSphere
Retail Sales Analytics project.

============================================================
*/

-- ============================================================
-- Categories
-- ============================================================

CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(50) UNIQUE NOT NULL
);

-- ============================================================
-- Customers
-- ============================================================

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender VARCHAR(10),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20) UNIQUE NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    join_date DATE DEFAULT CURRENT_DATE,

    CHECK (gender IN ('Male', 'Female', 'Others'))
);

-- ============================================================
-- Stores
-- ============================================================

CREATE TABLE stores (
    store_id SERIAL PRIMARY KEY,
    store_name VARCHAR(100) UNIQUE NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    opening_date DATE NOT NULL
);

-- ============================================================
-- Employees
-- ============================================================

CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20) UNIQUE NOT NULL,
    hire_date DATE NOT NULL,
    salary DECIMAL(10,2),
    store_id INT,

    FOREIGN KEY (store_id)
        REFERENCES stores(store_id),

    CHECK (salary > 0)
);

-- ============================================================
-- Suppliers
-- ============================================================

CREATE TABLE suppliers (
    supplier_id SERIAL PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL,
    contact_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20) UNIQUE NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL
);

-- ============================================================
-- Products
-- ============================================================

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category_id INT,
    supplier_id INT,
    unit_price DECIMAL(10,2),
    stock_quantity INT,
    launch_date DATE NOT NULL,
    discontinued BOOLEAN DEFAULT FALSE,

    FOREIGN KEY (category_id)
        REFERENCES categories(category_id),

    FOREIGN KEY (supplier_id)
        REFERENCES suppliers(supplier_id),

    CHECK (unit_price > 0),
    CHECK (stock_quantity >= 0)
);

-- ============================================================
-- Orders
-- ============================================================

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT,
    employee_id INT,
    store_id INT,
    order_date DATE DEFAULT CURRENT_DATE,
    order_status VARCHAR(20),

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    FOREIGN KEY (employee_id)
        REFERENCES employees(employee_id),

    FOREIGN KEY (store_id)
        REFERENCES stores(store_id),

    CHECK (
        order_status IN (
            'Pending',
            'Processing',
            'Shipped',
            'Delivered',
            'Cancelled'
        )
    )
);

-- ============================================================
-- Order Items
-- ============================================================

CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    discount DECIMAL(5,2) DEFAULT 0,

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    FOREIGN KEY (product_id)
        REFERENCES products(product_id),

    CHECK (quantity > 0),
    CHECK (unit_price > 0),
    CHECK (discount BETWEEN 0 AND 100)
);

-- ============================================================
-- Payments
-- ============================================================

CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    order_id INT,
    payment_date DATE,
    payment_method VARCHAR(30),
    payment_status VARCHAR(20),
    amount DECIMAL(10,2),

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    CHECK (amount > 0),

    CHECK (
        payment_method IN (
            'UPI',
            'Credit Card',
            'Debit Card',
            'Net Banking',
            'Cash'
        )
    ),

    CHECK (
        payment_status IN (
            'Pending',
            'Completed',
            'Failed',
            'Refunded'
        )
    )
);

-- ============================================================
-- Returns
-- ============================================================

CREATE TABLE returns (
    return_id SERIAL PRIMARY KEY,
    order_item_id INT,
    return_date DATE,
    return_reason VARCHAR(100),
    refund_amount DECIMAL(10,2),

    FOREIGN KEY (order_item_id)
        REFERENCES order_items(order_item_id),

    CHECK (refund_amount >= 0)
);