use employee;

show tables;


drop database employee;


create database Employee;

use Employee;

create table Employee ( 
empid int,
empname varchar(225),
managerid int,
deptid int,
salary int,
DOB DATE);

show tables;

drop table Employee;

insert into Employee (
	empid,
    empname,
    managerid,
    deptid,
    salary,
    DOB) 
    values( 1, 'emp 1', 0, 1, 6000, '1982-08-06'),
		  (2,'emp 2', 0, 1, 6000, '1982-07-11'),
          (3, 'emp 3', 1, 1, 2000, '1983-11-21'),
          (13, 'emp 13', 2, 5, 2000, '1984-03-09'),
          (11, 'emp 11', 2, 1, 2000, '1989-07-23'),
          (9, 'emp 9', 1, 5, 3000, '1990-09-11'),
          (8, 'emp 8', 3, 1, 3500, '1990-05-15'),
          (7, 'emp 7', 2, 5, NULL, NULL),
          (3, 'emp 3', 1, 1, 2000, '1983-11-21');


CREATE table department (
deptid int,
deptname varchar(22));

insert into department (
	deptid,
    deptname)
    values(1, 'IT'), (2, 'Admin');

select * from Employee;

-- 1. Employee and Manager ID are in the same table; can you get manager names for employees?


 
SELECT e1.empid Employeeid, e1.empname Employee_name, e1.managerid manager_ID, e2.empname Manager_name
FROM Employee e1
JOIN Employee e2
ON e1.managerid = e2.empid;


-- 2.Can you get employee details whose department id in not valid or department id is not present in department table?

-- Using left join

select * 
from Employee e
left join department d
on e.deptid = d.deptid
where d.deptid is null;

-- using subquery not into

select *
from Employee e 
where e.deptid not in 
(select deptid 
from department);

-- NOTE -- NOT IN is the least recommended, considering the performance.


-- 3.can you get the list of employees with same salary?

-- using where clause
select distinct e1.empid, e1.empname, e1.salary 
from Employee e1, Employee e2
where e1.salary = e2.salary
AND e1.empid != e2.empid;

-- using inner join (self join) 
select distinct e1.empid, e1.empname, e1.salary 
from Employee e1
join Employee e2
ON e1.salary = e2.salary
AND e1.empid != e2.empid;


-- 4.how can you find the duplicate records in a table?

select empid, empname, salary, count(*) as cnt 
from Employee
group by empid, empname, salary
having count(*)>1;


-- 5. How can you delete duplicate records?
set rowcount 1
delete from Employee
where empid in (select empid
from Employee
group by empid, empname, salary
having count(*)>1)
set rowcount 0



-- Script to create the Product table and load data into it.

DROP TABLE product;
use employee;
CREATE TABLE product
( 
    product_category varchar(255),
    brand varchar(255),
    product_name varchar(255),
    price int
);

INSERT INTO product VALUES
('Phone', 'Apple', 'iPhone 12 Pro Max', 1300),
('Phone', 'Apple', 'iPhone 12 Pro', 1100),
('Phone', 'Apple', 'iPhone 12', 1000),
('Phone', 'Samsung', 'Galaxy Z Fold 3', 1800),
('Phone', 'Samsung', 'Galaxy Z Flip 3', 1000),
('Phone', 'Samsung', 'Galaxy Note 20', 1200),
('Phone', 'Samsung', 'Galaxy S21', 1000),
('Phone', 'OnePlus', 'OnePlus Nord', 300),
('Phone', 'OnePlus', 'OnePlus 9', 800),
('Phone', 'Google', 'Pixel 5', 600),
('Laptop', 'Apple', 'MacBook Pro 13', 2000),
('Laptop', 'Apple', 'MacBook Air', 1200),
('Laptop', 'Microsoft', 'Surface Laptop 4', 2100),
('Laptop', 'Dell', 'XPS 13', 2000),
('Laptop', 'Dell', 'XPS 15', 2300),
('Laptop', 'Dell', 'XPS 17', 2500),
('Earphone', 'Apple', 'AirPods Pro', 280),
('Earphone', 'Samsung', 'Galaxy Buds Pro', 220),
('Earphone', 'Samsung', 'Galaxy Buds Live', 170),
('Earphone', 'Sony', 'WF-1000XM4', 250),
('Headphone', 'Sony', 'WH-1000XM4', 400),
('Headphone', 'Apple', 'AirPods Max', 550),
('Headphone', 'Microsoft', 'Surface Headphones 2', 250),
('Smartwatch', 'Apple', 'Apple Watch Series 6', 1000),
('Smartwatch', 'Apple', 'Apple Watch SE', 400),
('Smartwatch', 'Samsung', 'Galaxy Watch 4', 600),
('Smartwatch', 'OnePlus', 'OnePlus Watch', 220);


use employee;
select *,
first_value(product_name) over(partition by product_category order by price desc) most_expensive_product from product;

select *,
first_value(product_name) over w as most_expensive_product,
nth_value(product_name, 2) over w as nth_expensive_product,
last_value(product_name) over(partition by product_category order by price desc
range between unbounded preceding and unbounded following) least_expensive_product from product

window w as (partition by product_category order by price desc);


-- NTILE

