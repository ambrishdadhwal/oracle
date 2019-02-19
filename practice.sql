declare 
  username person.username%type; 
  email person.email%type; 
begin 
  SELECT username , email into username,email from person where id=1; 
  IF SQL%FOUND then 
    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT); 
  END IF; 
end;

-----explicit cursor
declare
  username person.username%type; 
  email person.email%type; 
  CURSOR cur IS SELECT username , email into username,email from person where id=1;
begin
  open cur;
    FETCH cur into username,email ;
    DBMS_OUTPUT.PUT_LINE(username||'  '||email); 
  close cur;
end;



----excplicit cursor with multiple rows.
declare
  CURSOR cur1 IS SELECT username , email  from person ;
  cur2 cur1%ROWTYPE;
begin
   open cur1;
   LOOP
     fetch cur1 into cur2;
     EXIT when cur1%NOTFOUND;
     DBMS_OUTPUT.PUT_LINE(cur2.username||'  '||cur2.email); 
   END LOOP;
   close cur1;
end;

SELECT table_name FROM user_tables
create table person(id integer primary key,username varchar2(255),email varchar2(255))

declare 
   id integer; 
   username varchar2(255); 
begin 
    for ii in 1..5 loop 
        insert into person values(ii,'user '||ii,'email '||ii);     
        commit; 
    end loop; 
end;


---------explicit for loops
declare
    CURSOR cur1 IS SELECT p.username ,CURSOR(select email from person where username =p.username)  from person p  ;
begin
    for cur2 in cur1
    loop
        DBMS_OUTPUT.PUT_LINE(cur2.username||'  '||cur2.email); 
    end loop;
end;


declare
  l_num PLS_INTEGER;
begin
    l_num :=1234567890123456;
    EXCEPTION
    WHEN others THEN
      dbms_output.put_line('sorry its error');
end;

----user defined exceptions
declare
    l_counter number;
    exe EXCEPTION;
begin
   l_counter := 100;
   IF l_counter < 101 THEN
      RAISE exe;
   END IF;
EXCEPTION when exe then
   dbms_output.put_line('number is not valid sorry!!!');
end;



create table person (id number primary key,username varchar2(255));
create table program (id number primary key,pname varchar2(255));

begin 
    for ii in 1..5 loop 
        insert into person values(ii,'program '||ii);     
        commit; 
    end loop; 
end;

select * from person;
select * from program;

select per.username,pro.pname from person per,program pro where per.id = person_id;
select per.username,listagg(pro.pname,',') WITHIN group (order by pro.pname) as programs from person per,program pro where per.id = pro.person_id(+) group by per.username;
DESCRIBE  program;
select  * from person offset 2 rows fetch next 2 rows only;

update program set person_id=1  where id=1;
update program set person_id=1  where id=2;
update program set person_id=2  where id=3;
update program set person_id=3  where id=4;

alter table program add person_id number;
alter table program add constraint person_id foreign key(person_id) references person(id);

create table emp (id number primary key,salary integer);

insert all into emp values(1,100),(2,125),(3,150),(4,200),(5,150)
INSERT ALL
  INTO emp (id,salary) VALUES (1, 100)
  INTO emp (id,salary) VALUES (2, 125)
  INTO emp (id,salary) VALUES (3, 150)
  INTO emp (id,salary) VALUES (4, 200)
  INTO emp (id,salary) VALUES (5, 150)
SELECT * FROM dual;


select * from emp order by salary desc;

select * from emp order by salary desc offset 1 rows fetch next 1 rows only;
select max(salary) from emp where salary not in (select max(salary) from emp);

with test as (select max(salary) as a from emp) select a from test where a not in (select max(salary) from emp);

select * from emp;
select * from department;

update emp set DEPTNO =2 where id in(2,5);
update emp set USERNAME='User 2' where id=2;
update emp set USERNAME='User 3' where id=3;
update emp set USERNAME='User 4' where id=4;
update emp set USERNAME='User 5' where id=5;

alter table emp add username varchar2(255) ;

create table department (id integer,dname varchar2(255));
insert all 
  Into department(id , dname) values(1,'Engineering') 
  Into department(id , dname) values(2,'Testing') 
  Into department(id , dname) values(3,'Management') 
  select * from dual;
  
  
alter table emp add deptno integer ;
insert INTO emp  VALUES (6, 1500,'Software Engineer','User 6', 1);

select deptno,job,sum(salary),count(*) from emp group by rollup(deptno,job) order by deptno;


--------------------------------------

----------------------------
create array type in oracle plsql
create or replace names as VARRAY(3) of varchar2(255);
declare
	type programs IS varray(3) of varchar2(20);
	type majors IS varray(3) of varchar2(20);
	pArray programs;
	mArray majors;
	total integer;
begin
	pArray := programs('math','history','geo');
	mArray := majors('major 1','major 2','major 3');
	total := pArray.count;
	for i in 1 .. total
	loop
		dbms_output.put_line('program is '||pArray(i)||' major is '||mArray(i));	
	end loop;
end;
--------------------------------
 -------create procedures 
create or replace procedure test
as 

begin
    dbms_output.put_line('here i am');

end ;

execute test;

--

create or replace procedure test(age IN number,age1 OUT number,age3 IN OUT number)
as 

begin
    select 1 into age1 from dual;
    select 10 into age3 from dual;
    --dbms_output.put_line('here i am-- '||age1);

end ;

declare
    x number;
    y number;
begin
    test(12,x,y);
    dbms_output.put_line('here i am-- '||x||'  '||y);
end;

-----------------------------------
 -------create function in oracle plsql
create or replace function test1 return varchar2 is 
  begin
        return 'ambrish';
  end;
  
  DECLARE 
   c varchar2(255);
  begin
        c :=test1();
        dbms_output.put_line('out put of function--- '|| test1());
  end;
  -----------------------------------
  implicit and explicit cursors
  
   ------------
  declare
        rowscount number;
  begin
        select count(*) into rowscount from tk_person;
        if sql%found THEN 
            rowscount := sql%rowcount;
        dbms_output.put_line(rowscount);
        end if;
  end;
  
  select * from tk_person;
  
  
  declare
    cursor person is select id,username from tk_person;
    id tk_person.id%type;
    username tk_person.username%type;
  begin
        open person;
          loop
               fetch person into id, username ;
               EXIT WHEN person%notfound; 
               dbms_output.put_line(id||'  '||username);
          end loop;
        close person;
  end;
  
  ----------------------
  records
  
  -------table based records
  
  declare
    personrec tk_person%rowtype;
  begin
        select id,username into personrec from tk_person where id=1;
         dbms_output.put_line(personrec.id||'  '||personrec.username);
  end;
  
  ----------------------
  
  -----query based
  declare
    cursor person is select id,username from tk_person;
    person_rec person%rowtype;
  begin
    open person ;
    loop
        fetch person into person_rec;
        exit when person%notfound;
         dbms_output.put_line(person_rec.id||'  '||person_rec.username);
    end loop;
    close person;
  end;
  
  
  ---------user defined records
  declare
    type person is record (id number, username varchar2(255));
    person1 person;
    person2 person;
  begin
        person1.id := 100;
        person1.username :='ambrish';
        
        person2.id := 100;
        person2.username :='ambrish';
        
        dbms_output.put_line(person2.id||'  '||person2.username);
  end;
