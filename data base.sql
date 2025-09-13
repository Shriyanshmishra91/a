-- question1Create a table called employees with the following structure? : emp_id (integer, should not be NULL and should be a primary key)Q : emp_name (text, should not be NULL)Q : age (integer, should have a check constraint to ensure the age is at least 18)Q : email (text, should be unique for each employee)Q : salary (decimal, with a default value of 30,000). Write the SQL query to create the above table with all constraints
use pw;
CREATE TABLE employees (
    emp_id INT NOT NULL PRIMARY KEY,
    emp_name VARCHAR (100) NOT NULL,
    age INT CHECK (age >= 18),
    email VARCHAR(100)  UNIQUE,
    salary INT DEFAULT 30000
);
-- question2Explain the purpose of constraints and how they help maintain data integrity in a database. Provide examples of common types of constraints.
-- answer 2Constraints are rules applied to table columns to enforce the validity, accuracy, and reliability of the data stored in a database.
-- They maintain data integrity by ensuring that only correct, consistent, and meaningful data can be inserted, updated, or deleted.

--  Without constraints, the database could easily become inconsistent or contain invalid data.
-- question3Why would you apply the NOT NULL constraint to a column? Can a primary key contain NULL values? Justify your answer.  
-- answer By default, columns in SQL can store NULL values (which means “unknown” or “missing” data).

-- Applying NOT NULL ensures that the column must always have a value.

--  Example

-- emp_name TEXT NOT NULL ensures that every employee must have a name.

-- Without it, someone could insert a record with no name, which would be meaningless.
--  ques 4 Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an example for both adding and removing a constraint.
-- synatx
ALTER TABLE table_name


-- Example: Add a UNIQUE constraint to the email column in the employees table:

-- ALTER TABLE employees
ADD CONSTRAINT unique_email UNIQUE (email);



  -- Example: Add a CHECK constraint to ensure salary is always above 10,000:

ALTER TABLE employees
ADD CONSTRAINT check_salary CHECK (salary >= 10000);


--  Example: Add a FOREIGN KEY constraint to link department_id to another table:

ALTER TABLE employees
ADD CONSTRAINT fk_dept FOREIGN KEY (department_id)
REFERENCES departments(dept_id);

## Removing (Dropping) a Constraiants

ALTER TABLE table_name
DROP CONSTRAINT constraint_name;
-- question5 Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints. Provide an example of an error message that might occur when violating a constraint.

-- Example: Remove the UNIQUE constraint on email:

ALTER TABLE employees
DROP CONSTRAINT unique_email;


--  Example: Remove the CHECK constraint on salary:

ALTER TABLE employees
DROP CONSTRAINT check_salary;
So, NOT NULL enforces data completeness and prevents missing values in important fields.

. Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints. Provide an example of an error message that might occur when violating a constraint.
INSERT INTO employees (emp_id, emp_name, age, email, salary)
VALUES (1, NULL, 25, 'test@example.com', 40000);



ERROR: null value in column "emp_name" violates not-null constraint
UNIQUE violation

sql
Copy code
INSERT INTO employees (emp_id, emp_name, age, email, salary)
VALUES (2, 'John', 30, 'test@example.com', 50000);(-- if  another row already has email = 'test@example.com');















































































--  Error:

-- sql

-- ERROR: duplicate key value violates unique constraint "unique_email"
-- CHECK violation

 -- sql

-- INSERT INTO employees (emp_id, emp_name, age, email, salary)
-- VALUES (3, 'Mike', 15, 'mike@example.com', 25000);
--  Error:


sql

ERROR: new row for relation "employees" violates check constraint "check_age"
FOREIGN KEY violation

sql
Copy code
INSERT INTO employees (emp_id, emp_name, age, email, salary, department_id)
VALUES (4, 'Sara', 28, 'sara@example.com', 30000, 999);
--  If department 999 doesn’t exist in departments table
-- Error:

-- pgsql
-- quest6   Modifying the products Table to Add Constraints

-- You initially created:

   -- product_id INT,
 --    product_name VARCHAR(50),
    CREATE TABLE products (
price DECIMAL(10, 2)
);


 -- ERROR: insert or update on table "employees" violates foreign key constraint "fk_dept"
 -- Add PRIMARY KEY constraint on product_id
ALTER TABLE products
ADD CONSTRAINT pk_product PRIMARY KEY (product_id);

-- Add DEFAULT constraint to price
ALTER TABLE products
ALTER COLUMN price SET DEFAULT 50.00;

create table student ( 
id INT PRIMARY KEY,
name varchar (50),  
age INT NOT NULL 
);  
-- Create Students Table
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50) NOT NULL,
    class_id INT
);

-- Create Classes Table
CREATE TABLE Classes (
    class_id INT PRIMARY KEY,
    class_name VARCHAR(50) NOT NULL
);

-- Insert sample data into Students
INSERT INTO Students (student_id, student_name, class_id) VALUES
(1, 'Alice', 101),
(2, 'Bob', 102),
(3, 'Charlie', 101);

-- Insert sample data into Classes
INSERT INTO Classes (class_id, class_name) VALUES
(101, 'Science'),
(102, 'Math');

-- Final Query to display Student with Class Name
SELECT s.student_id, s.student_name, c.class_name
FROM Students s
JOIN Classes c
ON s.class_id = c.class_id;
-- quesn9 
use pw;
cREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50) NOT NULL,
    class_id INT
);

--  Classes Table

CREATE TABLE Classes (
    class_id INT PRIMARY KEY,
    class_name VARCHAR(50) NOT NULL
);
 -- Insert Sample Data
use pw;
INSERT INTO Students (student_id, student_name, class_id)
VALUES 
(1, 'Alice', 101),
(2, 'Bob', 102),
(3, 'Charlie', 101);

INSERT INTO Classes (class_id, class_name)
VALUES
(101, 'Science'),
(102, 'Math');
-- Join Query (Answer Part)



SELECT s.student_id, s.student_name, c.class_name
FROM Students s
JOIN Classes c
ON s.class_id = c.class_id;

 -- question 9 given  the following tables:
 -- sale_id prodouct_id amount 
 -- sale id 1 (101) sale id2(102)  sale_id 103 
 -- amount 1=(500) amont 2(500) amount 2 is 700 amount 3 is(700)
 
 -- production id 1(700)laptop 
 -- product 2 iid(300) mobile
 
 -- write a qurey to find the total  sales amount for each  production using an  inner  join (sum) fouction.
 -- answer 
 use pw;
 SELECT .product_name, SUM(s.amount) AS total_sales
GROUP BY .product_name;
SELECT .product_name,
       SUM(s.amount) AS total_sales
FROM Sales s
INNER JOIN Products p
       ON s.product_id = .product_id
       
       -- question 10 given
       
       
       
       
       
       
-- -Identify the primary keys and foreign keys in maven movies db. Discuss the differences
-- Primary Key (PK): A column (or set of columns) that uniquely identifies each row in a table. Example: actor_id in actor table.

-- Foreign Key (FK): A column that creates a relationship between two tables by referencing a primary key. Example: film_id in inventory table (FK) → film_id in film table (PK).

     -- examples from Maven Movies DB:

actor → actor_id (PK)

film → film_id (PK)

customer → customer_id (PK), store_id (FK)

rental → rental_id (PK), customer_id (FK), inventory_id (FK)

payment → payment_id (PK), rental_id (FK), customer_id (FK), staff_id (FK)
-- question2List all details of actors
SELECT * FROM actor;
-- question3 -List all customer information from DB.
-- answer SELECT * FROM customer;
-- question4List different countries.
select* from differnt countries;

-- ques5  -Display all active customers.
 SELECT * FROM customer;
-- questio6  -List of all rental IDs for customer with ID 1.
SELECT rental_id 
FROM rental 
WHERE customerid 
-- question7 display all the file whose rental duration iis greater  than5
-- SELECT * FROM film WHERE rental_duration > 5; 
-- ques8  List the total number of films whose replacement cost is greater than $15 and less than $20.
 SELECT COUNT(*) AS total_films 
FROM film 
WHERE replacement_cost > 15 AND replacement_cost < 20;
-- question9   Display the count of unique first names of actors.

Display the first 10 records from the customer table .

11 --  Display the first 3 records from the customer table whose first name starts with ‘b’.
SELECT * FROM customer 
WHERE first_name LIKE 'B%' 
LIMIT 3;

-- 12  Display the names of the first 5 movies which are rated as ‘G’.
SELECT title 
FROM film 
WHERE rating = 'G' 
LIMIT 5;
-- 13Find all customers whose first name starts with "a".
SELECT * FROM customer 
WHERE first_name LIKE 'A%';
--  Find all customers whose first name ends with "a".
SELECT * FROM customer 
WHERE first_name LIKE '%a';
-- - Display the list of first 4 cities which start and end with ‘a’ .
SELECT city 
FROM city 
WHERE city LIKE 'A%a' 
LIMIT 4;
--  Find all customers whose first name have "NI" in any position.
SELECT * FROM customer 
WHERE first_name LIKE '%NI%';
-- Find all customers whose first name have "r" in the second position .
SELECT * FROM customer 
WHERE first_name LIKE '_r%';
--  Find all customers whose first name starts with "a" and are at least 5 characters in length.
SELECT * FROM customer 
WHERE first_name LIKE 'A%' AND LENGTH(first_name) >= 5;
-- Find all customers whose first name starts with "a" and ends with "o".
SELECT * FROM customer 
WHERE first_name LIKE 'A%o';SELECT * FROM customer 

--  Get the films with pg and pg-13 rating using IN operator.
-- SELECT * FROM film 
WHERE rating IN ('PG', 'PG-13');
--  Get the films with length between 50 to 100 using between operator.
SELECT * FROM film 
WHERE length BETWEEN 50 AND 100;
-- Get the top 50 actors using limit operator.
SELECT * FROM actor LIMIT 50;
--  Get the distinct film ids from inventory table.
-- gROUP BY p.product_name;
SELECT DISTINCT film_id 
FROM inventory;
-- uestion 1: 

Retrieve the total number of rentals made in the Sakila database.

Hint: Use the COUNT() function.

Retrieve the total number of rentals made in the Sakila database.

Hint: Use the COUNT() function.


Question 2:

Find the average rental duration (in days) of movies rented from the Sakila database.

Hint: Utilize the AVG() function.
SELECT AVG(rental_duration) AS avg_rental_duration
FROM film;

-- String Functions:

-- Question 3:

-- Display the first name and last name of customers in uppercase.
-- Hint: Use the UPPER () function.

SELECT UPPER(first_name) AS first_name_upper,
       UPPER(last_name) AS last_name_upper
FROM customer;


Extract the month from the rental date and display it alongside the rental ID.

Hint: Employ the MONTH() function.


GROUP BY:


Question 5:

Retrieve the count of rentals for each customer (display customer ID and the count of rentals).
SELECT customer_id,
       COUNT(rental_id) AS total_rentals
FROM rental
GROUP BY customer_id;


-- Question 6:

Find the total revenue generated by each store.
SELECT s.store_id,
       SUM(p.amount) AS total_revenue
FROM payment p
JOIN staff st ON p.staff_id = st.staff_id
JOIN store s ON st.store_id = s.store_id
GROUP BY s.store_id;



-- 
-- Determine the total number of rentals for each category of movies.


SELECT c.name AS category,
       COUNT(r.rental_id) AS total_rentals
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name;

-- Question 8:

-- ELECT l.name AS language,
      --  AVG(f.rental_rate) AS avg_rental_rate
-- FROM film f
J-- OIN language l ON f.language_id = l.language_id
GROUP BY l.name;

-- Joins
-- Questions 9 -

-- Display the title of the movie, customer s first name, and last name who rented it.

-- Hint: Use JOIN between the film, inventory, rental, and customer tables.
SELECT f.title,
       c.first_name,
       c.last_name
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN customer c ON r.customer_id = c.customer_id;


--  Question 10:

-- 
--  t: Use JOIN between the film actor, film, and actor tables.
SELECT a.first_name,
       a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE f.title = 'Gone with the Wind';


-- questi10
-- Retrieve the customer names along with the total amount they've spent on rentals.

SELECT c.first_name,
       c.last_name,
       SUM(p.amount) AS total_spent
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;


-- Question 12:

-
-- Hint: JOIN customer, address, city, rental, inventory, and film tables, then use GROUP BY.
-- 
 SELECT ci.city,
       c.first_name,
       c.last_name,
       f.title
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE ci.city = 'London'
GROUP BY ci.city, c.first_name, c.last_name, f.title;
Question 13:

Display the top 5 rented movies along with the number of times they've been rented.

Hint: JOIN film, inventory, and rental tables, then use COUNT () and GROUP BY, and limit the results.
SELECT f.title,
       COUNT(r.rental_id) AS times_rented
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.title
ORDER BY times_rented DESC
LIMIT 5;



-- Question 14:

-- Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).

sELECT c.customer_id,
       c.first_name,
       c.last_name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN store s ON i.store_id = s.store_id
WHERE s.store_id IN (1, 2)
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT s.store_id) = 2;

Windows Function:

1. Rank the customers based on the total amount they've spent on rentals.
ELECT c.customer_id,
       c.first_name,
       c.last_name,
       SUM(p.amount) AS total_spent,
       RANK() OVER (ORDER BY SUM(p.amount) DESC) AS spending_rank
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY spending_rank;
-- 2. Calculate the cumulative revenue generated by each film over time.
SELECT f.title,
       r.rental_date,
       SUM(p.amount) OVER (
            PARTITION BY f.film_id
            ORDER BY r.rental_date
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
       ) AS cumulative_revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id;
-- 3 Determine the average rental duration for each film, considering films with similar lengths.
SELECT f.title,
       f.length,
       AVG(DATEDIFF(r.return_date, r.rental_date)) AS avg_rental_duration,
       AVG(AVG(DATEDIFF(r.return_date, r.rental_date))) 
           OVER (PARTITION BY f.length) AS avg_duration_for_length_group
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title, f.length;
-- 4. Identify the top 3 films in each category based on their rental counts.

SELECT c.name AS category,
       f.title,
       COUNT(r.rental_id) AS rental_count,
       RANK() OVER (PARTITION BY c.category_id ORDER BY COUNT(r.rental_id) DESC) AS rank_in_category
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.category_id, c.name, f.film_id, f.title
HAVING RANK() OVER (PARTITION BY c.category_id ORDER BY COUNT(r.rental_id) DESC) <= 3;
 -- 5 Calculate the difference in rental counts between each customer's total rentals and the average rentals across all customers.

WITH customer_rentals AS (
    SELECT customer_id,
           COUNT(rental_id) AS total_rentals
    FROM rental
    GROUP BY customer_id
),
avg_rentals AS (
    SELECT AVG(total_rentals) AS avg_rentals
    FROM customer_rentals
)
SELECT cr.customer_id,
       cr.total_rentals,
       ar.avg_rentals,
       cr.total_rentals - ar.avg_rentals AS difference_from_avg
FROM customer_rentals cr
CROSS JOIN avg_rentals ar;
6. Find the monthly revenue trend for the entire rental store over time.

Copy code
SELECT DATE_FORMAT(p.payment_date, '%Y-%m') AS month,
       SUM(p.amount) AS total_revenue
FROM payment p
GROUP BY DATE_FORMAT(p.payment_date, '%Y-%m')
ORDER BY month;
7. Identify the customers whose total spending on rentals falls within the top 20% of all customers.
sql
Copy code
WITH customer_spending AS (
    SELECT c.customer_id,
           c.first_name,
           c.last_name,
           SUM(p.amount) AS total_spent
    FROM customer c
    JOIN payment p ON c.customer_id = p.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
),
ranked AS (
    SELECT *,
           NTILE(5) OVER (ORDER BY total_spent DESC) AS spending_percentile
    FROM customer_spending
)
SELECT customer_id, first_name, last_name, total_spent
FROM ranked
WHERE spending_percentile = 1;
8. Calculate the running total of rentals per category, ordered by rental count.
sql
Copy code
WITH category_rentals AS (
    SELECT c.name AS category,
           COUNT(r.rental_id) AS total_rentals
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film f ON i.film_id = f.film_id
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    GROUP BY c.category_id, c.name
)
SELECT category,
       total_rentals,
       SUM(total_rentals) OVER (ORDER BY total_rentals DESC) AS running_total
FROM category_rentals
ORDER BY running_total;
9. Find the films that have been rented less than the average rental count for their respective categories.
sql
Copy code
WITH film_rentals AS (
    SELECT f.film_id,
           f.title,
           fc.category_id,
           COUNT(r.rental_id) AS rental_count
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film f ON i.film_id = f.film_id
    JOIN film_category fc ON f.film_id = fc.film_id
    GROUP BY f.film_id, f.title, fc.category_id
),
category_avg AS (
    SELECT category_id,
           AVG(rental_count) AS avg_rental_count
    FROM film_rentals
    GROUP BY category_id
)
SELECT fr.title,
       fr.rental_count,
       ca.avg_rental_count
FROM film_rentals fr
JOIN category_avg ca ON fr.category_id = ca.category_id
WHERE fr.rental_count < ca.avg_rental_count;
10. Identify the top 5 months with the highest revenue and display the revenue generated in each month.
sql
Copy code
SELECT DATE_FORMAT(payment_date, '%Y-%m') AS month,
       SUM(amount) AS total_revenue
FROM payment
GROUP BY DATE_FORMAT(payment_date, '%Y-%m')
ORDER BY total_revenue DESC
LIMIT 5;

across all customers.

Normalisation & CTE

— First Normal Form (1NF)

a. Identify a table that violates 1NF and how to normalize it

Example violating table (hypothetical):
Suppose we have a table named customer_denorm that stores multiple phone numbers and multiple emails in a single row, plus repeating rental info:

customer_denorm(
  customer_id,
  first_name,
  last_name,
  phones,        -- e.g. '999-111-2222,888-222-3333'  (repeating group)
  emails,        -- e.g. 'a@x.com;b@y.com'             (repeating group)
  rental_1_film, rental_1_date, rental_2_film, rental_2_date, ...
)


Why this violates 1NF:
1NF requires each column to hold atomic (indivisible) values and no repeating groups. phones, emails, and numbered rental columns break 1NF.

Normalization to 1NF (steps):

Eliminate repeating groups and multi-valued fields by moving them into separate rows/tables.

Create separate related tables for the repeating data:

Suggested normalized schema:

customer (
  customer_id PRIMARY KEY,
  first_name,
  last_name,
  -- other single-valued attributes
);


-- Now each phone and email is atomic and each rental is a separate row — compliant with 1NF.

--  Second Normal Form (2NF)

-- . Choose a table and determine whether it is in 2NF; if not, how to normalize

Candidate table: film_actor in Sakila has a composite primary key (film_id, actor_id). As-is in Sakila it is in 2NF because there are no non-key attributes that depend only on part of the composite key.

Hypothetical violation example:
If film_actor had extra columns that depend only on actor_id (not on the full composite key), e.g.:

film_actor(
  film_id,
  actor_id,
  actor_birthdate,   -- depends only on actor_id
  actor_nationality  -- depends only on actor_id
)
PRIMARY KEY (film_id, actor_id)


Why this violates 2NF:
2NF requires that non-prime attributes are fully functionally dependent on the whole primary key. actor_birthdate depends on actor_id alone (partial dependency).

Steps to normalize to 2NF:

Remove attributes that depend only on actor_id.

Place actor-specific attributes into the actor table.

Normalized result:

-- film_actor remains as join table
film_actor (
  film_id,
  actor_id,
  PRIMARY KEY (film_id, actor_id)
);


--  — Third Normal Form (3NF)

a. Identify a table that violates 3NF, describe transitive dependencies, and how to normalize

Hypothetical denormalized customer_full table (violates 3NF):

customer_full(
  customer_id,
  first_name,
  last_name,
  address,      -- street
  city,         -- city name
  country,      -- country name
  postal_code,
  phone
)


Here city → country (or city has a dependency to country via city table). If country (and other city-level info) are stored in customer_full, this is a transitive dependency: customer_id → city and city → country, so customer_id → country transitively.

Why violates 3NF:
3NF requires no transitive dependencies: non-key attributes must depend only on the key, not on other non-key attributes.

Steps to normalize to 3NF:

Move city and country to their own tables and reference them by IDs.

Resulting normalized structure:

country(
  country_id PRimary 
)


Now customer attributes depend only on customer_id; city→country is represented by city.country_id (no transitive dependency in customer).

4 — Normalization process: unnormalized → 2NF (walk-through)

Starting unnormalized table (examples merged):

rental_raw(
  customer_name,
  customer_phone,
  film_titles,       -- 'A,B,C'
  film_lengths,      -- '90,120,90'
  payment_dates,     -- '2023-01-01,2023-01-05'
  amounts            -- '2.99,3.99'
)


Step 1 — 1NF:

Split multi-valued columns into separate rows. Create customer, film, rental, payment tables with one atomic value per field.

Step 2 — Identify keys & dependencies (to 2NF):

Suppose you create rental(customer_id, film_id, rental_date, return_date) with PK rental_id (single-column PK) — already avoids composite PK partial dependencies.

If instead rental used composite PK (customer_id, film_id), check whether non-key attributes depend on part of PK. If any non-key attribute depends only on film_id (e.g., length) or only on customer_id (e.g., customer_phone), they should be moved to film and customer respectively.

Step 3 — Create normalized tables:

customer(customer_id PK, first_name, last_name, phone, ...)
film(film_id PK, title, length, rental_rate, ...)
rental(rental_id PK, customer_id FK, film_id FK, rental_date, return_date)
payment(payment_id PK, customer_id FK, rental_id FK, amount, payment_date)


-- 
All non-key attributes in rental depend on its primary key (rental_id) or the entire composite key if you use composite keys; attributes specific to film or customer moved to their respective tables.

5 — - CTE Basics

a. Query using a CTE to retrieve distinct actor names and number of films they acted in

WITH actor_counts AS (
  SELECT actor_id, CONCAT(first_name, ' ', last_name) AS actor_name
  FROM actor
)
SELECT ac.actor_name,
       COUNT(fa.film_id) AS film_count
FROM actor_counts ac
JOIN film_actor fa ON ac.actor_id = fa.actor_id
GROUP BY ac.actor_id, ac.actor_name
ORDER BY film_count DESC;

-- 6  CTE with Joins

--  CTE combining film and language to show title, language, rental rate

WITH film_lang AS (
  SELECT f.film_id, f.title, l.name AS language, f.rental_rate
  FROM film f
  JOIN language l ON f.language_id = l.language_id
)
SELECT * FROM film_lang
ORDER BY title;

-- CTE for Aggregation

--  Total revenue per customer (sum of payments)

WITH customer_revenue AS (
  SELECT customer_id,
         SUM(amount) AS total_revenue
  FROM payment
  GROUP BY customer_id
)
SELECT cr.customer_id, c.first_name, c.last_name, cr.total_revenue
FROM customer_revenue cr
JOIN customer c ON cr.customer_id = c.customer_id
ORDER BY cr.total_revenue DESC;

-- 8CTE with Window Functions

-- aUse a CTE + window function to rank films by rental duration (film.length)

WITH film_durations AS (
  SELECT film_id, title, length
  FROM film
)
SELECT film_id, title, length,
       RANK() OVER (ORDER BY length DESC) AS length_rank
FROM film_durations
ORDER BY length_rank;

--  — CTE and Filtering

--  List customers who have made more than two rentals, then join to get details

WITH frequent_customers AS (
  SELECT customer_id, COUNT(*) AS rental_count
  FROM rental
  GROUP BY customer_id
  HAVING COUNT(*) > 2
)
SELECT fc.customer_id, c.first_name, c.last_name, c.email, fc.rental_count
FROM frequent_customers fc
JOIN customer c ON fc.customer_id = c.customer_id
ORDER BY fc.rental_count DESC;
-- CTE for Date Calculations

--  Total number of rentals made each month (by rental_date)

WITH monthly_rentals AS (
  SELECT DATE_FORMAT(rental_date, '%Y-%m') AS month, COUNT(*) AS rentals
  FROM rental
  GROUP BY DATE_FORMAT(rental_date, '%Y-%m')
)
SELECT * FROM monthly_rentals
ORDER BY month;



-- 11 — CTE and Self-Join

-- a. Report pairs of actors who appeared together in the same film

WITH film_actors AS (
  SELECT film_id, actor_id
  FROM film_actor
)
SELECT fa1.film_id,
       a1.actor_id AS actor1_id, CONCAT(a1.first_name,' ',a1.last_name) AS actor1_name,
       a2.actor_id AS actor2_id, CONCAT(a2.first_name,' ',a2.last_name) AS actor2_name
FROM film_actors fa1
JOIN film_actors fa2 ON fa1.film_id = fa2.film_id
JOIN actor a1 ON fa1.actor_id = a1.actor_id
JOIN actor a2 ON fa2.actor_id = a2.actor_id
WHERE fa1.actor_id < fa2.actor_id   -- avoid duplicate symmetric pairs and self-pair
ORDER BY fa1.film_id, actor1_name, actor2_name;

-- 
a. Recursive CTE to find all staff who report (directly or indirectly) to a specific manager

WITH RECURSIVE staff_hierarchy AS (
  -- anchor member: the manager themself (optional) or immediate reports
  SELECT staff_id, first_name, last_name, reports_to
  FROM staff
  WHERE staff_id = 2   -- start manager id

  UNION ALL

  -- recursive member: find staff who report to someone already in hierarchy
  SELECT s.staff_id, s.first_name, s.last_name, s.reports_to
  FROM staff s
  JOIN staff_hierarchy sh ON s.reports_to = sh.staff_id
)
SELECT * FROM staff_hierarchy
WHERE staff_id <> 2; -- exclude the manager themself if you only want subordinates


-- If you want to pass the manager id as a parameter, replace 2 with the desired id or use a prepared statement.




WITH category_film_counts AS (
  SELECT c.category_id, c.name AS category, f.film_id, f.title,
         COUNT(r.rental_id) AS rental_count
  FROM film f
  JOIN film_category fc ON f.film_id = fc.film_id
  JOIN category c ON fc.category_id = c.category_id
  LEFT JOIN inventory i ON f.film_id = i.film_id
  LEFT JOIN rental r ON i.inventory_id = r.inventory_id
  GROUP BY c.category_id, c.name, f.film_id, f.title
)
SELECT category, title, rental_count
FROM (
  SELECT *,
         ROW_NUMBER() OVER (PARTITION BY category_id ORDER BY rental_count DESC) AS rn
  FROM category_film_counts
) t
WHERE rn <= 3
ORDER BY category, rental_count DESC;