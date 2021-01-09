create table supplier (
    s_id number(10) primary key,
    sname varchar(10)
);

create table parts (
    pid number(10) primary key,
    pname varchar(20),
    colour varchar(10)
);

create table supply(
    s_id number(10) references supplier(s_id) on delete cascade,
    pid number(10) references parts(pid) on delete cascade,
    quantity number(10),
    primary key (s_id,pid)
);

insert into supplier values(1,'mi');
insert into supplier values(2,'oppo');
insert into supplier values(3,'redmi');
insert into supplier values(4,'realme');

insert into parts values(1,'cord','red');
insert into parts values(2,'nut','blue');
insert into parts values(3,'wire','yellow');

insert into supply values(1,2,10);
insert into supply values(2,1,20);
insert into supply values(3,1,40);
insert into supply values(4,2,20);
insert into supply values(1,3,20);

select pid from supply
join supplier on supplier.s_id = supply.s_id
where sname = 'oppo';

select sname from supplier
where s_id in (
    select s_id from supply
    join parts on parts.pid = supply.pid
    where pname = 'wire'
);

delete from parts
where colour = 'blue';


begin 
dbms_output.put_line('Total Supply : ');
dbms_output.put_line('s_id pid quantity ');
for i in (select * from supply) loop
    dbms_output.put_line(i.s_id || ' ' || i.pid || ' ' || i.quantity);
end loop;
update supply
set quantity = quantity + (0.05 * quantity);
end;
/



