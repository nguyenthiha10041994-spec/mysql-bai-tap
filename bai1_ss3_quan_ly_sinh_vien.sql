create database quan_ly_sinh_vien;
use quan_ly_sinh_vien;
create table classes(
c_id int auto_increment primary key,
c_name varchar(60) not null,
start_date datetime not null,
status bit 
);
create table students(
s_id int auto_increment primary key,
s_name varchar(30) not null,
address varchar(50),
phone varchar(20),
status bit,
c_id int not null,
foreign key(c_id) references classes(c_id)
);
create table subjects (
sub_id int not null auto_increment primary key,
sub_name varchar(30) not null,
credit tinyint not null default 1 check (credit >= 1),
status bit default 1
);
create table marks (
m_id int auto_increment primary key,
sub_id int not null,
s_id int not null,
mark float default 0 check (mark between 0 and 100),
exam_times tinyint default 1,
unique (sub_id, s_id),
foreign key (sub_id) references subjects(sub_id),
foreign key (s_id) references students(s_id)
);

insert into classes(c_name, start_date, status)
values("A1","2008-12-20",1),("A2","2008-12-22",1),("B3",current_date(),0);

insert into students(s_name, address, phone, status, c_id)
values ("Hung","Ha noi","0912113113",1,1),("Hoa","Hai phong",null,1,1),
("Manh","HCM","0123123123",0,2);

insert into subjects (sub_name, credit, status)
values('CF', 5, 1),('C', 6, 1),('HDJ', 5, 1),('RDBMS', 10, 1);

insert into marks (sub_id, s_id, mark, exam_times)
values(1, 1, 8, 1),(1, 2, 10, 2),(2, 1, 12, 1);
select*from students;

select *from students where status = 1;

select * from subjects where credit < 10;

select students.* from students
join classes on students.c_id = classes.c_id
where classes.c_name = "A1";

select students.s_name,subjects.sub_name,marks.mark
from marks
join students on marks.s_id = students.s_id
join subjects on marks.sub_id = subjects.sub_id
where subjects.sub_name = "CF";

select *from students where s_name like "h%";

select * from classes where month(start_date) = 12;

select * from subjects where credit between 3 and 5;

select students.s_name,subjects.sub_name,marks.mark
from marks
join students on marks.s_id = students.s_id
join subjects on marks.sub_id = subjects.sub_id
order by marks.mark desc, students.s_name asc;



























