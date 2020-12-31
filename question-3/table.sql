create table boat (
    bid number(10) primary key,
    bname varchar(20),
    colour varchar(10)
);

create table sailor (
    s_id number(10) primary key,
    sname varchar(20),
    age number(10)
);

create table reserves (
    bid number(10) references boat(bid),
    s_id number(10) references sailor(s_id),
    dayTime varchar(10),
    primary key(bid,s_id)
);

insert into boat values (1,'B1','red');
insert into boat values (2,'B2','blue');
insert into boat values (3,'B3','yellow');
insert into boat values (4,'B4','orange');

insert into sailor values (1,'S1',20);
insert into sailor values (2,'S2',30);
insert into sailor values (3,'S3',25);
insert into sailor values (4,'S4',40);

insert into reserves values(1,1,'Sunday');
insert into reserves values(2,1,'Monday');
insert into reserves values(3,2,'Sunday');
insert into reserves values(4,3,'Tuesday');
insert into reserves values(4,2,'Friday');
insert into reserves values(2,4,'Wednesday');
insert into reserves values(2,3,'Wednesday');
insert into reserves values(2,2,'Monday');


select bid from reserves
where s_id in (
    select s_id from sailor
    where sname = 'S2'
);
 
<-- or --> 

select bid from boat
where bid in (
    select bid from reserves
    join sailor on sailor.s_id = reserves.s_id
    where sailor.sname = 'S2'
);

< -- or -- >

select bid from reserves
join sailor on sailor.s_id = reserves.s_id
where sname = 'S2';

select b.bid from boat b 
where not exists (
    select s.s_id from sailor s
    where not exists (
        select r.s_id from reserves r 
        where r.bid = b.bid
        and r.s_id = s.s_id
    )
);

select count(bid) as count,s_id 
from reserves
group by s_id;


declare
	n number;
	i number;
	flag number;
 
begin
	i:=2;
	flag:=1;
	n:=&n;
 
	for i in 2..n/2
	loop
		if mod(n,i)=0
		then
			flag:=0;
			exit;
		end if;
	end loop;
 
	if flag=1
	then
		dbms_output.put_line('prime');
	else
		dbms_output.put_line('not prime');
	end if;
end;
/


