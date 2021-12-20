use hr;

select * from employees;


show tables;


-- 2.
select e.first_name, e.last_name, salary
from employees e
join departments d
on e.department_id = d.department_id
where d.department_name = 'IT' ;

-- 3.

select first_name, last_name 
from employees e
join departments d
using (manager_id)
join locations l
on d.location_id = l.location_id
where manager_id is not null
and country_id <> 'US';



-- 4

select first_name, last_name
from employees
where employee_id in (select manager_id from employees);

-- 5.

select e1.first_name, e1.last_name, e1.salary
from employees e1 
where e1.salary > (select avg(salary) from employees e2);


-- 6.
-- my technique
select e1.first_name, e1.last_name, e1.salary
from employees e1
join jobs j
on e1.job_id = j.job_id
where e1.salary = j.min_salary;

-- w3resource
SELECT first_name, last_name, salary 
FROM employees 
WHERE employees.salary = (SELECT min_salary
FROM jobs
WHERE employees.job_id = jobs.job_id
order by min_salary desc);

-- 7 
select e.first_name, e.last_name, e.salary
from employees e
join departments d
on e.department_id = d.department_id
-- where e.salary > (select avg(e.salary) from employees )
where d.department_name = 'IT'
and e.salary > (select avg(e.salary) from employees );


-- below is the right answer
select first_name, last_name, salary
from employees
where department_id in
(select department_id from departments where department_name like 'IT%')
and salary > (select avg(salary) from employees);

-- 8. Write a query to find the name (first_name, last_name), 
-- and salary of the employees who earns more than the earning of Mr. Bell.

select first_name, last_name, salary
from employees
where salary > (select salary from employees where last_name = 'BELL')
order by salary desc;


-- 9. Write a query to find the name (first_name, last_name), and salary of the employees 
-- who earn the same salary as the minimum salary for all departments.

SELECT first_name, last_name, salary
FROM employees
WHERE salary = (SELECT MIN(salary) FROM employees);


-- 10. Write a query to find the name (first_name, last_name), and salary of the employees whose 
-- salary is greater than the average salary of all departments.


SELECT first_name, last_name, salary
FROM employees
WHERE salary > (SELECT avg(salary) FROM employees);



-- 11. Write a query to find the name (first_name, last_name) and salary of the employees who earn a salary 
-- that is higher than the salary of all the Shipping Clerk (JOB_ID = 'SH_CLERK'). Sort the results of the 
-- salary of the lowest to highest.


SELECT first_name, last_name, salary
from employees
where salary > ALL (select salary from employees where job_id = 'SH_CLERK');

-- 12. Write a query to find the name (first_name, last_name) of the employees who are not supervisors.

select e1.first_name, e1.last_name
from employees e1
where employee_id in (select manager_id from employees);



SELECT b.first_name,b.last_name 
FROM employees b 
WHERE NOT EXISTS (SELECT 'X' FROM employees a WHERE a.manager_id = b.employee_id);



SELECT 'X' FROM employees a, employees b WHERE a.manager_id = b.employee_id;



-- 13. From the following tables, write a SQL query to find those employees who joined on 1st January 1993 
-- and leave on or before 31 August 1997. Return job title, department name, employee name, and joining date of the job.


select d.department_name, e.first_name 
from employees e
join job_history j
on e.employee_id = j.employee_id
join departments d
on j.department_id = d.department_id
where j.start_date = '1993-01-01' 
and j.end_date = '1997-08-31';


select * 
from employees e
inner join job_history j
on e.employee_id = j.employee_id
where j.start_date = '1993-01-01'
and j.end_date = '1997-08-31';


SELECT job_title, department_name, first_name || ' ' || last_name AS Employee_name, start_date 
	FROM job_history 
		JOIN jobs USING (job_id) 
			JOIN departments USING (department_id) 
				JOIN  employees USING (employee_id) 
					WHERE start_date>='1993-01-01' AND start_date<='1997-08-31';
  
  
