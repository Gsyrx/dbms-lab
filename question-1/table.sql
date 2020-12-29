create table employee (
    ssn varchar(10) primary key,
    e_name varchar(20),
    depno number(2),
    salary number(10)
);

create table projects (
    pno varchar(10) primary key,
    pdomain varchar(20)
);

create table workson (
    ssn varchar(10) references employee(ssn),
    pno varchar(10) references projects(pno),
    working_hours number(10),
    primary key (ssn,pno)
);

insert into employee values('E1','Gaurav',1,1000);
insert into employee values('E2','Akshat',1,1000);
insert into employee values('E3','Aman',2,2000);
insert into employee values('E4','Sounak',3,3000);
insert into employee values('E5','Aaryan',4,4000);

insert into projects values('P1','Cloud');
insert into projects values('P2','DB');

insert into workson values('E1','P1',1);
insert into workson values('E2','P2',2);
insert into workson values('E3','P1',3);
insert into workson values('E4','P2',4);
insert into workson values('E5','P1',5);

select ssn from workson
join projects on projects.pno = workson.pno
where pdomain = 'DB';

select depno,count(*) from employee
group by depno;

update workson set pno = 'P2'
where ssn = 'E1';


begin
update employee
set salary = salary + (0.15 * salary)
where depno = 1;
dbms_output.put_line('Number of employee whose salary was incremented ' || SQL % ROWCOUNT);
end;
/