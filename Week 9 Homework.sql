USE sakila;

-- 1a
SELECT first_name, last_name
From actor;

-- 1b
SELECT CONCAT(first_name,' ', last_name)AS 'Actor Name'
FROM actor;

-- 2a
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = "Joe";

-- 2b
Select actor_id, first_name, last_name
FROM actor
WHERE last_name = "%gen%";

-- 2c
SELECT last_name, first_name
FROM actor
WHERE last_name = "%li%";

-- 2d
SELECT country_id, country
FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

-- 3a
ALTER TABLE actor
add description blob;

-- 3b
ALTER TABLE actor
DROP column description;

-- 4a 
SELECT last_name, count(last_name)
  FROM actor
 GROUP BY last_name ;
 
-- 4b
SELECT last_name, count(last_name)
  FROM actor 
  GROUP BY last_name
 having count(last_name)>= 2 ;
 
-- 4c
UPDATE actor 
SET first_name = 'HARPO'
WHERE first_name = 'GROUCHO' AND last_name = 'WILLIAMS';

-- 4d
UPDATE actor 
SET first_name = 'GROUCHO'
WHERE first_name = 'HARPO';

-- 5a
SHOW CREATE TABLE address;

-- 6a
SELECT staff.first_name, staff.last_name, address.address
FROM staff
INNER JOIN address ON
staff.address_id=address.address_id;

-- 6b
Select staff.first_name , staff.last_name, SUM(payment.amount)
AS Playment_Total
from payment
INNER JOIN staff ON
staff.staff_id= payment.staff_id
Group by staff.staff_id;

-- 6c
select film.title, COUNT(film_actor.actor_id) AS Number_of_Actors
from film
Inner Join film_actor ON
film_actor.film_id = film.film_id
Group by film.title;

-- 6d
select film.title , count(inventory.film_id) As Number_of_Copies
from inventory
Inner JOIN film ON
film.film_id = inventory.film_id
where inventory.film_id = 439 ;

-- 6e
Select customer.first_name, customer.last_name, SUM(payment.amount) AS "Total Amount Paid"
from payment
INNER JOIN customer ON
customer.customer_id = payment.customer_id
Group by payment.customer_id 
order by customer.last_name ASC;

-- 7a 
SELECT title FROM film
WHERE title like "K%" or title like "Q%" and language_id in
(
 SELECT language_id
  FROM film
  WHERE language_id=1
) ;  
    
-- 7b

SELECT CONCAT(first_name,' ', last_name)AS 'Actor Names'
from actor
where actor_id IN
(select actor_id
from film_actor
where film_id = 17) ;

-- 7c
select c.first_name as "First Name", c.last_name as "Last Name", c.email as "Email Address"
from customer c
INNER JOIN address a ON c.address_id = a.address_id
INNER JOIN city ct ON a.city_id = ct.city_id
INNER JOIN country cn ON ct.country_id = cn.country_id
where cn.country_id= 20;

-- 7d 
select title as "Family Movies"
from film
where film_id in
(
select film_id 
from film_category 
where category_id in
(
select category_id
from category
where category_id= 8)
);

-- 7e
select f.title as "Movie Title", count(r.inventory_id) as Frequency
from film f
Inner JOIN inventory i ON f.film_id = i.film_id
INNER JOIN rental r ON r.inventory_id = i.inventory_id
group by r.inventory_id
order by Frequency desc ; 

-- 7f
Select s.store_id AS "Store Number" , sum(p.amount) as "Total Business ($)"
from store s
INNER JOIN staff st ON s.store_id = st.store_id
Inner JOIN payment p ON p.staff_id = st.staff_id
group by st.store_id;

-- 7g
Select s.store_id as "Store Number",c.city as "City", cn.country as "Country" 
from store s
INNER JOIN address a ON a.address_id = s.address_id
INNER JOIN city c ON a.city_id = c.city_id
INNER JOIN country cn ON c.country_id = cn.country_id
group by s.store_id;

-- 7h 
select c.name as Genre, sum(p.amount) as Revenue
from category c
INNER JOIN film_category fm ON fm.category_id = c.category_id
INNER JOIN inventory i ON fm.film_id = i.film_id
INNER JOIN rental r ON i.inventory_id = r.inventory_id
INNER JOIN payment p ON r.rental_id = p.rental_id
group by Genre
order by Revenue desc;  

-- 8a 
CREATE VIEW Genre_Revenue AS
select c.name as Genre, sum(p.amount) as Revenue
from category c
INNER JOIN film_category fm ON fm.category_id = c.category_id
INNER JOIN inventory i ON fm.film_id = i.film_id
INNER JOIN rental r ON i.inventory_id = r.inventory_id
INNER JOIN payment p ON r.rental_id = p.rental_id
group by Genre
order by Revenue desc;  

-- 8b
SELECT * FROM Genre_Revenue; 

-- 8c
Drop view Genre_Revenue;
