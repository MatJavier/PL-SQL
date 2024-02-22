create table DEPARTMENTS(
    deptno number,
    nombre varchar2(50),
    location varchar2(70),
    constraint pk_departments primary key (deptno)
);

create table EMPLOYEES(
    empno number,
    name varchar2(50),
    job  varchar2(50),
    manager number,
    hiredate data,
    salary number(7,2),
    comission number(7,2),
    deptno number,
	constraint pk_employees primary key (empno),
    constraint fk_employees_depno foreign key (deptno)
    references departments (deptno)
);

/*
Trigger
*/

create or replace trigger  DEPARTMENTS_BIU
    before insert or update on DEPARTMENTS
    for each row
begin
    if inserting and :new.deptno is null then
        :new.deptno := to_number(sys_guid(), 
          'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX');
    end if;
end;
/

create or replace trigger EMPLOYEES_BIU
    before insert or update on EMPLOYEES
    for each row
begin
    if inserting and :new.empno is null then
        :new.empno := to_number(sys_guid(), 
            'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX');
    end if;
end;
/

/*
inset 
*/
insert into departments (name, location) values
 ('Finance','New York');

insert into departments (name, location) values
   ('Development','San Jose');


/* TEMAS:
Package en PLSQL
Store Procedure de mantenimiento
Librería DBMS_UTL_FILE ( manejo de archivos planos )
Librería : DBMS_LOB ( archivos binarios PDF )
Wrap : Ocultamiento de código
*/

/* Package en PLSQL */


/* PL-SQL */




  
