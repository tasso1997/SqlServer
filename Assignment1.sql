create database assignment1

create schema sales

create schema production

create table sales.customers
(
customer_id int identity primary key,
first_name varchar(20) NOT NULL,
last_name varchar(20) NOT NULL,
phone_no numeric(10) NOT NULL,
email varchar(50) unique NOT NULL,
street varchar(20) NOT NULL,
city varchar(20) NOT NULL,
state varchar(20) NOT NULL,
zip_code numeric(10) NOT NULL

)

create table sales.store
(
store_id int primary key,
store_name varchar(20) NOT NULL,
phone numeric(10) NOT NULL,
email varchar(50) unique NOT NULL,
street varchar(20) NOT NULL,
city varchar(20) NOT NULL,
state varchar(20) NOT NULL,
zip_code numeric(10) NOT NULL
)

create table sales.staff
(
staff_id int identity primary key,
first_name varchar(20) NOT NULL,
last_name varchar(20) NOT NULL,
email varchar(50) unique NOT NULL,
phone numeric(10) NOT NULL,
active varchar(20) NOT NULL,
store_id int NOT NULL,
manager_id int NOT NULL,
constraint fk_store_staff foreign key(store_id)
references sales.store(store_id)
)
 
create table sales.orders
(
order_id int  primary key,
customer_id int NOT NULL ,
order_status varchar(20) NOT NULL,
order_date date NOT NULL,
required_date date NOT NULL,
shipped_date date NOT NULL,
staff_id int NOT NULL,
store_id int NOT NULL,
constraint fk_orders_customers foreign key(customer_id)
references sales.customers(customer_id),
constraint fk_orders_store foreign key(store_id)
references sales.store(store_id),
constraint fk_orders_staff foreign key(staff_id)
references sales.staff(staff_id)
)

create table sales.orders_items
(
order_id int  primary key,
item_id int NOT NULL,
product_id int NOT NULL,
quantity int check(quantity > 0) NOT NULL,
list_price int check(list_price > 0) NOT NULL,
discount int NOT NULL,
constraint fk_orders_item_product foreign key(product_id)
references production.products(product_id)
)


create table production.categories
(
category_id int primary key,
category_name varchar(20) NOT NULL
)

create table production.brands
(
brand_id int primary key,
brand_name varchar(20) NOT NULL
)

create table production.products
(
product_id int primary key,
product_name varchar(20) NOT NULL,
brand_id int NOT NULL,
category_id int NOT NULL,
model_year numeric(4) NOT NULL,
list_price int NOT NULL,
constraint fk_products_brand foreign key(brand_id)
references production.brands(brand_id),
constraint fk_products_categories foreign key(category_id)
references production.categories(category_id)
)

create table production_stocks
(
store_id int NOT NULL,
product_id int NOT NULL,
quantity int NOT NULL,
constraint fk_stock_product foreign key(store_id)
references sales.store(store_id),
constraint fk_stocks_product foreign key(product_id)
references production.products(product_id)
)

alter table sales.orders_items
add item_amount as ((quantity * list_price)-discount)

select * from sales.orders_items