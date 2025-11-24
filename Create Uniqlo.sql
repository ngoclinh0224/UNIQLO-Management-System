

-- create database Uniqlo --
CREATE DATABASE Uniqlo;

USE Uniqlo
--create table price --
CREATE TABLE price (
price_id nvarchar (255) NOT NULL PRIMARY KEY, 
original_price decimal(10,2),
discount_rate decimal(10,2),
selling_price decimal(10,2),
)



-- create table category --
CREATE TABLE category (
category_id nvarchar(255) NOT NULL PRIMARY KEY,
category_name nvarchar(255),
season nvarchar(255),
gender nvarchar(255),
)



-- create table customer --
CREATE TABLE customer (
customer_id nvarchar(255) NOT NULL PRIMARY KEY,
customer_name nvarchar(255),
customer_address nvarchar(255),
customer_phone nvarchar(255),
customer_email nvarchar(255),
loyalty_point int,
join_date date, 
)




-- create table manager --
CREATE TABLE manager(
manager_id nvarchar(255) NOT NULL PRIMARY KEY,
manager_name nvarchar(255),
manager_address nvarchar(255),
manager_email nvarchar(255),
)






-- create table supplier --
CREATE TABLE supplier(
supplier_id nvarchar(255) NOT NULL PRIMARY KEY,
supplier_name nvarchar(255),
supplier_address nvarchar(255),
supplier_phone nvarchar(255),
)






-- create table store --
CREATE TABLE store(
store_id nvarchar(255) NOT NULL PRIMARY KEY,
store_name nvarchar(255),
store_location nvarchar(255),
store_phone nvarchar(255),
manager_id nvarchar(255) FOREIGN KEY REFERENCES manager(manager_id),
)




-- create table product --
CREATE TABLE product (
product_id int NOT NULL PRIMARY KEY,
product_name nvarchar(255),
product_quantity int NOT NULL,
color nvarchar(255),
size nvarchar(255),
category_id nvarchar(255) FOREIGN KEY REFERENCES category(category_id),
price_id nvarchar(255) FOREIGN KEY REFERENCES price(price_id),
supplier_id nvarchar(255) FOREIGN KEY REFERENCES supplier(supplier_id),
)




-- create table inventory --
CREATE TABLE inventory(
inventory_id nvarchar(255) NOT NULL PRIMARY KEY,
store_id nvarchar(255) FOREIGN KEY REFERENCES store(store_id),
product_id int NOT NULL FOREIGN KEY REFERENCES product(product_id), 
inventory_quantity int NOT NULL,
)






-- create table sales --
CREATE TABLE sales(
sale_id nvarchar(255) NOT NULL PRIMARY KEY,
product_id INT NOT NULL FOREIGN KEY REFERENCES product(product_id),
unit_sold int NOT NULL,
sale_price decimal(10,2),
total_profit decimal(10,2),
sale_rank int NOT NULL,
)



-- create table bill --
CREATE TABLE bill(
bill_id nvarchar(255) NOT NULL PRIMARY KEY,
buying_date date NOT NULL,
product_id nvarchar(max) NOT NULL,
buying_quantity int NOT NULL,
total_price decimal(10,2),
customer_id nvarchar(255) FOREIGN KEY REFERENCES customer(customer_id),
pay_method nvarchar(255),
store_id nvarchar(255) FOREIGN KEY REFERENCES store(store_id),
)


