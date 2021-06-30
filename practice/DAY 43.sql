create database Shirts;

use Shirts;

SELECT database();

CREATE table shirts (
shirt_id INT NOT NULL AUTO_INCREMENT,
article varchar(30) not null,
color varchar(30) not null,
shirt_size varchar(1) not null,
last_worn INT NOT NULL,
PRIMARY KEY (shirt_id)
);

DROP TABLE SHIRTS;
INSERT INTO shirts (article, color, shirt_size, last_worn) VALUES ('t-shirt', 'white', 'S', 10);
INSERT INTO shirts (article, color, shirt_size, last_worn) VALUES ('t-shirt', 'green', 'S', 10);
INSERT INTO shirts (article, color, shirt_size, last_worn) VALUES ('polo shirt', 'black', 'M', 10);
INSERT INTO shirts (article, color, shirt_size, last_worn) VALUES ('tank top', 'blue', 'S', 10);
INSERT INTO shirts (article, color, shirt_size, last_worn) VALUES ('t-shirt', 'pin', 'S', 10);
INSERT INTO shirts (article, color, shirt_size, last_worn) VALUES ('polo shirt', 'red', 'M', 10);
INSERT INTO shirts (article, color, shirt_size, last_worn) VALUES ('tank top', 'white', 'S', 10);
INSERT INTO shirts (article, color, shirt_size, last_worn) VALUES ('tank top', 'blue', 'M', 10);

SELECT * FROM shirts;

UPDATE shirts SET last_worn = 200 WHERE shirt_id = 2;
UPDATE shirts SET last_worn = 50 WHERE shirt_id = 4;
UPDATE shirts SET last_worn = 0 WHERE shirt_id = 5;
UPDATE shirts SET last_worn = 5 WHERE shirt_id = 6;
UPDATE shirts SET last_worn = 200 WHERE shirt_id = 7;
UPDATE shirts SET last_worn = 15 WHERE shirt_id = 8;

SELECT * FROM shirts;