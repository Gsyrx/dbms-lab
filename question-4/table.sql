create table part(
    pno number(10) primary key,
    pname varchar(20),
    colour varchar(10)
);

create table warehouse(
    wno number(20) primary key,
    wname varchar(10),
    address varchar(30)
);

create table shipment(
    pno number(10) references part(pno),
    wno number(20) references warehouse(wno),
    quantity number(10),
    dates date,
    primary key (pno,wno)
);

insert into part values(1,'nut','red');
insert into part values(2,'wire','blue');
insert into part values(3,'screw','yellow');
insert into part values(4,'wire','black');

insert into warehouse values(1,'W1','Delhi');
insert into warehouse values(2,'W2','Kolkata');
insert into warehouse values(3,'W3','Mumbai');
insert into warehouse values(4,'W4','Bangalore');

insert into shipment values(1,1,100,'DEC-05-2013');
insert into shipment values(2,1,200,'DEC-05-2013');
insert into shipment values(3,2,300,'NOV-10-2020');
insert into shipment values(4,3,400,'DEC-15-2017');
insert into shipment values(3,1,500,'JAN-01-2020');
insert into shipment values(3,3,200,'FEB-02-2020');
insert into shipment values(3,4,300,'MAR-20-2020');


select wname from warehouse
where wno in (
    select wno from shipment
    join part on part.pno = shipment.pno
    where part.colour = 'red'
);

select p.pno from part p 
where not exists (
    select w.wno from warehouse w
    where not exists(
        select s.wno from shipment s
        where s.pno = p.pno 
        and s.wno = w.wno
    )
);

select count(pno) ,wno
from shipment 
group by wno;

select * from warehouse
join shipment on shipment.wno = warehouse.wno
where quantity in (
    select max(quantity)
    from shipment
);

create table copy_part(
    pno number(10) primary key,
    pname varchar(20),
    colour varchar(10)
);

declare
cursor curr is 
select * from part;
counter int;
rows part%rowtype;
begin
open curr;
loop
fetch curr into rows;
exit when curr%notfound;
insert into copy_part values(rows.pno,rows.pname,rows.colour);
end loop;
counter:=curr%rowcount;
close curr;
dbms_output.put_line(counter||'rows inserted into the table copy_part1');
end;
/