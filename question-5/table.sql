create table book (
    isbn number(10) primary key,
    title varchar(20),
    author varchar(20),
    publisher varchar(10)
);

create table student (
    usn varchar(10) primary key,
    name_student varchar(10)    
);

create table borrow (
    isbn number(10) references book(isbn),
    usn varchar(10) references student(usn),
    dates date,
    primary key (isbn,usn)
);


insert into book values(1,'sports','B1','P1');
insert into book values(2,'database','B2','P2');
insert into book values(3,'sql','B3','P3');

insert into student values('IS031', 'Gaurav');
insert into student values('IS002', 'Aaryan');

insert into borrow values(1,'IS031','DEC-12-2020');
insert into borrow values(2,'IS002','DEC-15-2020');
insert into borrow values(3,'IS031','DEC-20-2020');


select name_student from student
where usn = (
    select usn from borrow
    where isbn = 1
);

< -- or -- >
select name_student from student
join borrow on borrow.usn = student.usn
where isbn = 1;

select name_student from student
where usn in (
    select usn from borrow
    join book on book.isbn = borrow.isbn
    where book.title = 'database'
);

select count(isbn), usn 
from borrow
group by usn;



declare
a number;
b number;
c number;
n number;
i number;
PROCEDURE fib(n in number) is
begin
a:=0;
b:=1;
dbms_output.put_line(a);
dbms_output.put_line(b);
for i in 1..n-2
loop
c:=a+b;
dbms_output.put_line(c);
a:=b;
b:=c;
end loop;
end;
begin
fib(8);
end;
/