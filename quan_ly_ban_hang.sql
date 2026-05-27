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












