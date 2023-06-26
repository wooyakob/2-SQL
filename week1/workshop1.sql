SELECT pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE pg_stat_activity.datname = 'week1_workshop' AND pid <> pg_backend_pid();
DROP DATABASE IF EXISTS week1_workshop;
CREATE DATABASE week1_workshop;
\c week1_workshop

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET default_tablespace = '';
SET default_with_oids = false;

CREATE TABLE products (
    id SERIAL,
    name TEXT NOT NULL,
    discontinued BOOLEAN NOT NULL,
    supplier_id INT,
    category_id INT,
    PRIMARY KEY (id)
);

CREATE TABLE categories (
    id SERIAL,
    name TEXT UNIQUE NOT NULL,
    description TEXT,
    picture TEXT,
    PRIMARY KEY (id)
);

CREATE TABLE suppliers (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    company_name TEXT NOT NULL
);

CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    date DATE,
    customer_id INT NOT NULL,
    employee_id INT
);

CREATE TABLE order_details (
    product_id INT NOT NULL,
    order_id INT NOT NULL,
    quantity SMALLINT NOT NULL,
    discount NUMERIC NOT NULL,
    PRIMARY KEY (order_id, product_id)
);





---
--- Add foreign key constraints
---

-- PRODUCTS

ALTER TABLE products
ADD CONSTRAINT fk_products_categories 
FOREIGN KEY (category_id) 
REFERENCES categories (id);


-- TODO create more constraints here...

