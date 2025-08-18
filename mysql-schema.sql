-- MySQL schema for Pahana Edu
CREATE DATABASE IF NOT EXISTS pahana_edu DEFAULT CHARACTER SET utf8mb4;
USE pahana_edu;

-- Users (for login)
CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  role VARCHAR(20) NOT NULL DEFAULT 'USER'
);

-- Customers
CREATE TABLE IF NOT EXISTS customers (
  id INT AUTO_INCREMENT PRIMARY KEY,
  account_number VARCHAR(30) UNIQUE NOT NULL,
  name VARCHAR(100) NOT NULL,
  address VARCHAR(255) NOT NULL,
  phone VARCHAR(30) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Items (products in the bookshop)
CREATE TABLE IF NOT EXISTS items (
  id INT AUTO_INCREMENT PRIMARY KEY,
  sku VARCHAR(30) UNIQUE NOT NULL,
  name VARCHAR(100) NOT NULL,
  unit_price DECIMAL(10,2) NOT NULL,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Orders (bills)
CREATE TABLE IF NOT EXISTS orders (
  id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT NOT NULL,
  total DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (customer_id) REFERENCES customers(id)
);

-- Order line items
CREATE TABLE IF NOT EXISTS order_items (
  id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT NOT NULL,
  item_id INT NOT NULL,
  quantity INT NOT NULL,
  line_total DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (order_id) REFERENCES orders(id),
  FOREIGN KEY (item_id) REFERENCES items(id)
);

-- Seed admin user (password = admin123)
INSERT INTO users(username, password_hash, role)
VALUES ('admin', SHA2('admin123', 256), 'ADMIN')
ON DUPLICATE KEY UPDATE username = username;

-- Seed sample data
INSERT INTO customers(account_number, name, address, phone)
VALUES ('ACC-1001','Nimal Perera','Colombo 05','0771234567')
ON DUPLICATE KEY UPDATE account_number=account_number;

INSERT INTO items(sku, name, unit_price) VALUES
('BK-001','Java Basics', 2500.00),
('BK-002','Advanced Java', 3900.00),
('ST-001','Notebook A5', 350.00)
ON DUPLICATE KEY UPDATE sku = sku;
