use practice;

create table students (
id int not null auto_increment primary key,
first_name varchar (100)
);


create table papers (
title varchar(225) ,
grade varchar(225),
student_id int,
foreign key (student_id) references students(id)
);


INSERT INTO students (first_name) VALUES 
('Caleb'), ('Samantha'), ('Raj'), ('Carlos'), ('Lisa');

INSERT INTO papers (student_id, title, grade ) VALUES
(1, 'My First Book Report', 60),
(1, 'My Second Book Report', 75),
(2, 'Russian Lit Through The Ages', 94),
(2, 'De Montaigne and The Art of The Essay', 98),
(4, 'Borges and Magical Realism', 89);


select * from students;

select * from papers;

select first_name, title, grade 
from students left join papers 
on students.id = papers.student_id;

select first_name, title, grade 
from students right join papers 
on students.id = papers.student_id
order by grade desc;


select first_name, ifnull(title, 'Missing'), ifnull(grade, 0) 
from students left join papers 
on students.id = papers.student_id;




select first_name,  ifnull(avg(grade),0) as 'average grade'
from students left join papers 
on students.id = papers.student_id
group by id
order by avg(grade) desc;




select first_name,  ifnull(avg(grade),0) as 'average grade',
	case 
		when avg(grade) >= 75 then 'Passing'
		else 'Failing'
		end as passing_status
from students left join papers 
on students.id = papers.student_id
group by id
order by avg(grade) desc;


