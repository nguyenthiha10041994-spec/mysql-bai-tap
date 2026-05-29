CREATE DATABASE quan_ly_ban_hang;
USE quan_ly_ban_hang;
create table customers (
c_id int primary key,
c_name varchar(50),
c_age int
);
create table orders(
o_id int primary key,
o_date date,
o_total_price double,
c_id int,
foreign key(c_id) references customers(c_id)
);
create table products (
p_id int primary key,
p_name varchar(50),
p_price double
);
create table order_details(
o_id int,
p_id int,
od_qty int,
primary key(o_id,p_id),
foreign key(o_id) references orders(o_id),
foreign key(p_id) references products(p_id)
);

insert into customers
values
(1,'Minh Quan',10),
(2,'Ngoc Oanh',20),
(3,'Hong Ha',50);
select * from customers;

insert into orders
values
(1,'2006-03-21',null,1),(2,'2006-03-23',null,2),(3,'2006-03-16',null,1);
select * from orders;

insert into products
values
(1,'May Giat',3),(2,'Tu Lanh',5),(3,'Dieu Hoa',7),(4,'Quat',1),(5,'Bep Dien',2);
select * from products;

insert into order_details
values
(1,1,3),(1,3,7),(1,4,2),(2,1,1),(3,1,8),(2,5,4),(2,3,3);
select * from order_details;

select o_id, o_date, o_total_price from orders;

select customers.c_name, products.p_name 
from customers
join orders on customers.c_id = orders.c_id
join order_details on orders.o_id = order_details.o_id
join products on order_details.p_id = products.p_id;

select c_name from customers
where c_id not in (select c_id from orders);

select orders.o_id,orders.o_date,
 sum(order_details.od_qty * products.p_price) as total_price
from orders
join order_details on orders.o_id = order_details.o_id
join products on order_details.p_id = products.p_id
group by orders.o_id, orders.o_date;


















