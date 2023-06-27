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
    customer_id SERIAL PRIMARY KEY,
    company_name TEXT NOT NULL
);

CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    reports_to INT
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    date DATE,
    customer_id INT NOT NULL,
    employee_id INT
);

CREATE TABLE order_products (
    product_id INT NOT NULL,
    order_id INT NOT NULL,
    quantity SMALLINT NOT NULL,
    discount NUMERIC NOT NULL,
    PRIMARY KEY (order_id, product_id)
);

CREATE TABLE territories (
    id SERIAL PRIMARY KEY,
    description TEXT NOT NULL
);

CREATE TABLE employees_territories (
  employee_id INT NOT NULL,
  territory_id INT NOT NULL,
  PRIMARY KEY (employee_id, territory_id)
);

CREATE TABLE offices (
    id SERIAL PRIMARY KEY,
    address_line TEXT NOT NULL,
    territory_id INT NOT NULL
);

CREATE TABLE us_states (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    abbreviation CHAR(2) NOT NULL
);

--- Add foreign key constraints
ALTER TABLE orders
ADD CONSTRAINT fk_orders_customers
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id);

ALTER TABLE orders
ADD CONSTRAINT fk_orders_employees
FOREIGN KEY (employee_id)
REFERENCES employees(employee_id);

-- PRODUCTS

ALTER TABLE products
ADD CONSTRAINT fk_products_categories 
FOREIGN KEY (category_id) 
REFERENCES categories (id);

ALTER TABLE products
ADD CONSTRAINT fk_products_suppliers
FOREIGN KEY (supplier_id)
REFERENCES suppliers(id);


ALTER TABLE order_products
ADD CONSTRAINT fk_order_products_orders
FOREIGN KEY (order_id)
REFERENCES orders(id);

ALTER TABLE order_products
ADD CONSTRAINT fk_order_products_products
FOREIGN KEY (product_id)
REFERENCES products(id);


ALTER TABLE employees_territories
ADD CONSTRAINT fk_employees_territories_employees
FOREIGN KEY (employee_id)
REFERENCES employees(employee_id);

ALTER TABLE employees_territories
ADD CONSTRAINT fk_employees_territories_territories
FOREIGN KEY (territory_id)
REFERENCES territories(id);

ALTER TABLE offices
ADD CONSTRAINT fk_offices_territories
FOREIGN KEY (territory_id)
REFERENCES territories(id);

-- Bonus

ALTER TABLE employees
ADD CONSTRAINT fk_employees_reports_to
FOREIGN KEY (reports_to)
REFERENCES employees(employee_id);