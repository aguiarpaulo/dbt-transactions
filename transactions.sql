--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;



SET default_tablespace = '';

SET default_with_oids = false;


---
--- drop tables
---


DROP TABLE IF EXISTS subproducts;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS transactions;

--
-- Name: categories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

-- Tabela de Produtos
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    product_category VARCHAR(100)
);

-- Tabela de Subprodutos
CREATE TABLE subproducts (
    subproduct_id SERIAL PRIMARY KEY,
    subproduct_name VARCHAR(100) NOT NULL,
    product_id INT REFERENCES products(product_id) ON DELETE CASCADE
);

-- Tabela de Clientes
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20)
);

-- Tabela de Transações
CREATE TABLE transactions (
    transaction_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id) ON DELETE CASCADE,
    subproduct_id INT REFERENCES subproducts(subproduct_id) ON DELETE CASCADE,
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10, 2) NOT NULL
);
-- Inserir dados na tabela de Produtos
INSERT INTO products (product_name, product_category) VALUES
('Laptop', 'Electronics'),
('Smartphone', 'Electronics'),
('Table', 'Furniture');

-- Inserir dados na tabela de Subprodutos
INSERT INTO subproducts (subproduct_name, product_id) VALUES
('Gaming Laptop', 1),
('Business Laptop', 1),
('Android Smartphone', 2),
('iOS Smartphone', 2),
('Wooden Table', 3);

-- Inserir dados na tabela de Clientes
INSERT INTO customers (customer_name, email, phone) VALUES
('John Doe', 'johndoe@example.com', '123-456-7890'),
('Jane Smith', 'janesmith@example.com', '987-654-3210'),
('Michael Johnson', 'michaelj@example.com', '555-555-5555');

-- Inserir dados na tabela de Transações
INSERT INTO transactions (customer_id, subproduct_id, amount) VALUES
(1, 1, 1200.50),
(1, 3, 700.00),
(2, 5, 350.75),
(3, 2, 900.00),
(2, 4, 999.99);

-- Inserir mais dados na tabela de Produtos
INSERT INTO products (product_name, product_category) VALUES
('Chair', 'Furniture'),
('Headphones', 'Electronics'),
('Watch', 'Accessories');

-- Inserir mais dados na tabela de Subprodutos
INSERT INTO subproducts (subproduct_name, product_id) VALUES
('Office Chair', 4),
('Gaming Chair', 4),
('Wireless Headphones', 5),
('Noise Cancelling Headphones', 5),
('Smart Watch', 6),
('Analog Watch', 6);

-- Inserir mais dados na tabela de Clientes
INSERT INTO customers (customer_name, email, phone) VALUES
('Emma Brown', 'emma.brown@example.com', '222-333-4444'),
('Liam Davis', 'liam.davis@example.com', '333-444-5555'),
('Olivia Miller', 'olivia.miller@example.com', '444-555-6666');

-- Inserir mais dados na tabela de Transações
INSERT INTO transactions (customer_id, subproduct_id, amount) VALUES
(1, 1, 1150.00),   -- John Doe compra Gaming Laptop
(1, 6, 50.00),     -- John Doe compra Analog Watch
(2, 4, 1050.50),   -- Jane Smith compra iOS Smartphone
(2, 10, 250.99),   -- Jane Smith compra Noise Cancelling Headphones
(3, 3, 650.00),    -- Michael Johnson compra Android Smartphone
(4, 7, 175.99),    -- Emma Brown compra Wireless Headphones
(4, 8, 120.75),    -- Emma Brown compra Noise Cancelling Headphones
(5, 5, 450.00),    -- Liam Davis compra Wooden Table
(5, 9, 300.50),    -- Liam Davis compra Smart Watch
(6, 2, 980.99),    -- Olivia Miller compra Business Laptop
(6, 7, 200.50),    -- Olivia Miller compra Wireless Headphones
(6, 11, 130.99);   -- Olivia Miller compra Office Chair
