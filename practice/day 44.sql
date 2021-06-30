SELECT database();

CREATE database book_shop;

USE book_shop;

SELECT database();

show tables;

CREATE TABLE books 
	(
		book_id INT NOT NULL AUTO_INCREMENT,
		title VARCHAR(100),
		author_fname VARCHAR(100),
		author_lname VARCHAR(100),
		released_year INT,
		stock_quantity INT,
		pages INT,
		PRIMARY KEY(book_id)
	);

INSERT INTO books (title, author_fname, author_lname, released_year, stock_quantity, pages)
VALUES
('The Namesake', 'Jhumpa', 'Lahiri', 2003, 32, 291),
('Norse Mythology', 'Neil', 'Gaiman',2016, 43, 304),
('American Gods', 'Neil', 'Gaiman', 2001, 12, 465),
('Interpreter of Maladies', 'Jhumpa', 'Lahiri', 1996, 97, 198),
('A Hologram for the King: A Novel', 'Dave', 'Eggers', 2012, 154, 352),
('The Circle', 'Dave', 'Eggers', 2013, 26, 504),
('The Amazing Adventures of Kavalier & Clay', 'Michael', 'Chabon', 2000, 68, 634),
('Just Kids', 'Patti', 'Smith', 2010, 55, 304),
('A Heartbreaking Work of Staggering Genius', 'Dave', 'Eggers', 2001, 104, 437),
('Coraline', 'Neil', 'Gaiman', 2003, 100, 208),
('What We Talk About When We Talk About Love: Stories', 'Raymond', 'Carver', 1981, 23, 176),
("Where I'm Calling From: Selected Stories", 'Raymond', 'Carver', 1989, 12, 526),
('White Noise', 'Don', 'DeLillo', 1985, 49, 320),
('Cannery Row', 'John', 'Steinbeck', 1945, 95, 181),
('Oblivion: Stories', 'David', 'Foster Wallace', 2004, 172, 329),
('Consider the Lobster', 'David', 'Foster Wallace', 2005, 92, 343);

SELECT * FROM books;


SELECT CONCAT (author_fname, ' ', author_lname) AS full_name FROM books;

SELECT author_fname AS first, author_lname AS last, 
  CONCAT(author_fname, ' ', author_lname) AS full
FROM books;

SELECT author_fname AS first, author_lname AS last, 
  CONCAT(author_fname, ', ', author_lname) AS full
FROM books;

SELECT CONCAT(title, '-', author_fname, '-', author_lname) FROM books;

SELECT CONCAT_WS('-', title, author_fname,author_lname) FROM books;


SELECT SUBSTRING('Hello World', 1, 4);
 
SELECT SUBSTRING('Hello World', 7);
 
SELECT SUBSTRING('Hello World', 3, 8);
 
SELECT SUBSTRING('Hello World', 3);
 
SELECT SUBSTRING('Hello World', -3);
 
SELECT SUBSTRING('Hello World', -7);
 
SELECT title FROM books;
 
SELECT SUBSTRING("Where I'm Calling From: Selected Stories", 1, 10);
 
SELECT SUBSTRING(title, 1, 10) FROM books;
 
SELECT SUBSTRING(title, 1, 10) AS 'short title' FROM books;
 
SELECT SUBSTR(title, 1, 10) AS 'short title' FROM books;
 
SELECT CONCAT
    (
        SUBSTRING(title, 1, 10),
        '...'
    )
FROM books;

SELECT CONCAT
    (
        SUBSTRING(title, 1, 10),
        '...'
    ) AS 'short title'
FROM books;

SELECT REPLACE('Hello World', 'Hell', '%$#@');

SELECT REPLACE('Hello World', 'l', '7');
 
SELECT REPLACE('Hello World', 'o', '0');
 
SELECT REPLACE('HellO World', 'o', '*');
 
SELECT
  REPLACE('cheese bread coffee milk', ' ', ' and ');
 
SELECT REPLACE(title, 'e ', '3') FROM books;

SELECT
   CONCAT
   (
       SUBSTRING(title, 1, 10),
       '...'
   ) AS 'short title'
FROM books;

SELECT
    SUBSTRING(REPLACE(title, 'e', '3'), 1, 10)
FROM books;

SELECT
    SUBSTRING(REPLACE(title, 'e', '3'), 1, 10) AS 'weird string'
FROM books;

SELECT author_lname, CHAR_LENGTH(author_lname) As 'length' FROM books;

SELECT author_fname, CHAR_LENGTH(author_fname) AS 'length' FROM books;


SELECT CONCAT(author_lname, ' is ', CHAR_LENGTH(author_lname), ' ', 'charaacters long') FROM books;

SELECT CONCAT(author_fname, ' is ', CHAR_LENGTH(author_fname), ' ', 'CHARACTERS LONGS') FROM books;


SELECT UPPER(' hello world');

SELECT UPPER(title) AS 'SHORT TITLE' FROM books;

SELECT LOWER(author_fname) AS 'short_author' FROM books;

SELECT UPPER( REVERSE('Why does cat look at me with such hatred')); 

SELECT
replace(
concat('I', ' ', ' like' , ' ', 'cats'),
' ',
'-'
);

SELECT replace(title, ' ', '-') FROM books;


INSERT INTO books
    (title, author_fname, author_lname, released_year, stock_quantity, pages)
    VALUES ('10% Happier', 'Dan', 'Harris', 2014, 29, 256), 
           ('fake_book', 'Freida', 'Harris', 2001, 287, 428),
           ('Lincoln In The Bardo', 'George', 'Saunders', 2017, 1000, 367);
 
 
SELECT distinct author_lname FROM books;

SELECT released_year FROM books;

SELECT distinct released_year AS 'new' FROM  books;

SELECT author_fname, author_lname FROM books;

SELECT author_fname, author_lname FROM books;
 
SELECT DISTINCT CONCAT(author_fname,' ', author_lname) FROM books;
 
SELECT DISTINCT author_fname, author_lname FROM books;

SELECT author_lname FROM books ORDER BY author_lname;

SELECT title FROM books ORDER BY title;

select title FROM books ORDER BY title DESC;

SELECT released_year FROM books ORDER BY released_year;
SELECT released_year FROM books ORDER BY released_year desc;

SELECT title, author_fname, author_lname 
FROM books ORDER BY 2;
 
SELECT title, author_fname, author_lname 
FROM books ORDER BY 3;
 
SELECT title, author_fname, author_lname 
FROM books ORDER BY 1;
 
SELECT title, author_fname, author_lname 
FROM books ORDER BY 1 DESC;
 
SELECT author_lname, title
FROM books ORDER BY 2;


SELECT author_fname, author_lname FROM books ORDER BY author_lname, author_fname;

SELECT title from books LIMIT 3;

SELECT 
