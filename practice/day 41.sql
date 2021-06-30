create database dog_walking_a;
USE dog_walking_a;
 
SELECT database();

CREATE TABLE cats (
name varchar(100),
age int
);
INSERT INTO cats(name, age) VALUES ('Jetson', 7);

SHOW tables;

CREATE TABLE people (
first_name varchar(20),
last_name varchar(20),
age int
);

INSERT INTO people(first_name, last_name, age) VALUES ('Rushikesh', 'Pawar', 23);
INSERT INTO people(first_name, last_name, age) VALUES ('Vaibhav', 'Pawar', 27);

DESC people;

SELECT * from people;

CREATE TABLE unique_cats
  (
    cat_id INT NOT NULL,
    name VARCHAR(100),
    age INT,
    PRIMARY KEY (cat_id)
  );
  
DESC unique_cats;

INSERT INTO unique_cats(cat_id, name, age) VALUES(1, 'Fred', 23);
 
INSERT INTO unique_cats(cat_id, name, age) VALUES(2, 'Louise', 3);
 
INSERT INTO unique_cats(cat_id, name, age) VALUES(1, 'James', 3);

SELECT * FROM unique_cats;
CREATE TABLE unique_cats2 (
    cat_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100),
    age INT,
    PRIMARY KEY (cat_id)
);

INSERT INTO unique_cats2(name, age) VALUES('Skippy', 4);
INSERT INTO unique_cats2(name, age) VALUES('Jiff', 3);
INSERT INTO unique_cats2(name, age) VALUES('Jiff', 3);
INSERT INTO unique_cats2(name, age) VALUES('Jiff', 3);
INSERT INTO unique_cats2(name, age) VALUES('Skippy', 4);

SELECT * FROM unique_cats2;
