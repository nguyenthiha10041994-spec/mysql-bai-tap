create database demo;
use demo;
create table products(
p_id int auto_increment primary key,
p_code varchar(20) not null ,
p_name varchar(50) not null,
p_price decimal(10,2) not null,
p_amount int not null,
p_description text,
p_status bit 
);
-- thêm dữ liệu
insert into products
(p_code,p_name, p_price, p_amount, p_description, p_status)
values
('P001','Muối',10000,100,'Muối ăn',1),
('P002','Đường',20000,80,'Đường cát',1),
('P003','Nước mắm',35000,50,'Nước mắm chinsu',1),
('P004','Hạt nêm',45000,40,'Hạt nêm vị thịt',1),
('P005','Tiêu',30000,60,'Tiêu xay',1);
-- Bước 3
-- tạo unique index sử dụng cột productCode để tạo chỉ mục
create unique index idx_product_code
on products(p_code);
show index from products;

-- Tạo Composite Index sử dụng 2 cột productName và productPrice)
create index idx_name_price
on products(p_name, p_price);
show index from products;

-- Sử dụng câu lệnh EXPLAIN để biết được câu lệnh SQL của bạn thực thi như nào
explain select * from products where p_code = 'P001';
explain select * from products where p_name = 'Muối' and p_price = 10000;

/* So sánh câu truy vấn trước và sau khi tạo index
Trước khi index: mysql quét toàn bộ bảng (type = ALL).
Sau khi index: mysql sử dụng index (key = idx_product_code hoặc idx_name_price).
Truy vấn  nhanh hơn do số dòng cần đọc giảm.*/

-- Bước 4: Tạo view
create view view_products as
select p_code,p_name,p_price,p_status from products;
select * from view_products;

-- sửa đổi view
alter view view_products as
select p_code,p_name,p_price,p_amount,p_status from products;
select * from view_products;

-- xoá view
drop view view_products;

-- Bước 5:store procedure
-- 1. lấy tất cả sản phẩm
delimiter //
create procedure get_all_products()
begin
    select * from products;
end //
delimiter ;
call get_all_products();

-- 2. Thêm sản phẩm mới
delimiter //
create procedure add_product(
    in pcode varchar(20),
    in pname varchar(50),
    in pprice decimal(10,2),
    in pamount int,
    in pdescription text,
    in pstatus bit
)
begin
insert into products(p_code,p_name,p_price,p_amount,p_description,p_status)
    values(pcode,pname,pprice,pamount,pdescription,pstatus);
end //
delimiter ;
call add_product('P006','Bột ngọt',25000,70,'Bột ngọt Ajinomoto',1);

-- 3. Sửa sản phẩm theo id
delimiter //
create procedure update_product(
in pid int,
in pcode varchar(20),
in pname varchar(50),
in pprice decimal(10,2),
in pamount int,
in pdescription text,
in pstatus bit
)
begin
update products set
p_code = pcode,
p_name = pname,
p_price = pprice,
p_amount = pamount,
p_description = pdescription,
p_status = pstatus
where p_id = pid;
end //
delimiter ;
call update_product(1,'P001','Muối iốt',12000,150,'Muối iốt cao cấp',1);

-- 4. Xóa sản phẩm theo id
delimiter //
create procedure delete_product(in pid int)
begin
delete from products where p_id = pid;
end //
delimiter ;
call delete_product(6);










