USE quan_ly_sinh_vien;
select * from subjects where credit = (select max(credit) from subjects);

select subjects.* from subjects
join marks on subjects.sub_id = marks.sub_id
where marks.mark = (select max(mark) from marks);

select students.*, avg(marks.mark) as dtb
from students
join marks on students.s_id = marks.s_id
group by students.s_id
order by dtb desc;