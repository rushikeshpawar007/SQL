use great_learning;


## Numeric functions
select 5+7;

select 5*2;

select floor(5.7); # eleminates the decimal part

select ceil(8.9);
select ceil(8.3); # rounds to the next integer
select floor(8.9);

select greatest(5,3,9);  # largest value result
# for each student give the greatest score in test


select least(4,6,8,2,1);


select sin(90);  # angel is measured in radians

select abs(-5);

select 4 mod 3;

select 6 div 4;  # integer(floor) division
select 6/4;  #float division

select PI(), sqrt(9), rand(), pow(3,100);

select ln(10), log(100), log10(10), log2(8);

#### String functions

select ascii('A');
select char(65);
select char('121');
select char_length('great learning');
select length('great learning');
select concat('great', 'learning');
select concat('hello',concat('great_learning'));
select concat_ws('-','great','learning');

SELECT FORMAT(12332.2,0);
SELECT FORMAT(12332.5,0);
SELECT FORMAT(12332.2,2);
select left('agrhrtrt',1);
select insert("great learning", 7, 0, "is");
select insert("great learning", 7, 2, "is");
select instr("great learning", "earning");
select instr("great learning", "X");
select instr("great learning", "g");
select locate("earning","great learning");
select locate('x','ABC');
select substr("great learninig", 1,5);
## Display the output as "deepali@gmail.com" output should be "Deepali"


select lcase("ABCD");
select upper("great learning");
select replace("Data analysis","analysis", "science");
select trim("" from "Data Scientist");
select ltrim ("  data  ");
select rtrim ("  data  ");
select trim( " " from "    data  ");
# Date-time functions
select curdate(),curtime();

select now();
SELECT ADDDATE('2008-01-02', INTERVAL 31 DAY);
SELECT ADDDATE('2008-01-02', INTERVAL 1 month);
SELECT ADDDATE('2008-01-02', INTERVAL 2 year);

select year('2008-01-02');
select month('2008-01-02');
select day('2008-01-02');

select now();
select minute('22:40:51'), hour('22:40:51'), second('22:40:51');
select datediff(curdate(),'2008-01-02');  ## No of days
select dayname(curdate());




SELECT DATE_FORMAT("2017-06-5", "%M %d %Y");
SELECT DATE_FORMAT("2017-06-5", "%W %M %e %Y");

SELECT STR_TO_DATE('01,5,2013','%d,%m,%Y');
SELECT STR_TO_DATE('May 1, 2013','%M %d,%Y');  
SELECT STR_TO_DATE('09:30:17','%h:%i:%s');

desc property_price_train_new;

