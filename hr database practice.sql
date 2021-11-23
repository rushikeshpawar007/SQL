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
WHERE employees.job_id = jobs.job_id);

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


