SELECT name, breed FROM cats;

SELECT name, age FROM cats WHERE breed = 'Tabby';

SELECT cat_id, age FROM cats WHERE cat_id = age;

SELECT * FROM cats WHERE cat_id = age;

SELECT cat_id AS ID, name FROM cats;

UPDATE cats SET breed = 'Shorthair' WHERE breed = 'Tabby';
UPDATE cats SET breed='Shorthair' WHERE breed='Tabby';
UPDATE cats SET age=14 WHERE name='Misty';

UPDATE cats SET name = 'jack' WHERE name = 'Jackson';

SELECT * FROM cats;

SELECT * FROM cats WHERE name='Ringo';

UPDATE cats SET breed='British Shorthair' WHERE name='Ringo';

SELECT * FROM cats WHERE name='Ringo';

SELECT * FROM cats;

SELECT * FROM cats WHERE breed='Maine Coon';

UPDATE cats SET age=12 WHERE breed='Maine Coon';
 
SELECT * FROM cats WHERE breed='Maine Coon';
