-- 1. List all customers who live in Texas (use JOINs)
SELECT customer.address_id, address.district
FROM address
INNER JOIN customer
ON customer.address_id = address.address_id
WHERE district = 'Texas'

-- 2. Get all payments above $6.99 with the Customer's Full Name
SELECT *
FROM customer
WHERE customer_id IN (SELECT customer_id
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 6.99
ORDER BY SUM (amount) DESC);

-- 3. Show all customers names who have made payments over $175(use subqueries)
SELECT *
FROM customer
WHERE customer_id IN (SELECT customer_id
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 175
ORDER BY SUM (amount) DESC);

-- 4. List all customers that live in Nepal (use the city table)
SELECT customer.first_name, customer.last_name, address.address, city.city, country.country
FROM customer
FULL JOIN address
ON address.address_id = customer.address_id
FULL JOIN city
ON city.city_id = address.city_id
FULL JOIN country
ON country.country_id = city.country_id
WHERE country.country = 'Nepal'

-- 5. Which staff member had the most transactions?
SELECT COUNT(rental.staff_id), staff.first_name, staff.last_name, COUNT(rental.rental_id)
FROM rental
FULL JOIN staff
ON staff.staff_id = rental.staff_id
GROUP BY rental.staff_id, staff.first_name, staff.last_name
ORDER BY COUNT(rental.rental_id)DESC LIMIT 1

-- 6. How many movies of each rating are there?
SELECT COUNT(film.rating), film.rating
FROM film
GROUP BY film.rating 
ORDER BY COUNT(film.rating) DESC 

-- 7.Show all customers who have made a single payment above $6.99 (Use Subqueries)
SELECT *
FROM customer
WHERE customer_id IN (SELECT customer_id
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 6.99
ORDER BY COUNT(amount) DESC LIMIT 1)

-- 8. How many free rentals did our stores give away?
SELECT COUNT(payment.amount), store.store_id
FROM store
FULL JOIN staff
ON store.store_id = staff.store_id
FULL JOIN payment
ON payment.staff_id = staff.staff_id
WHERE payment.amount = 0.00
GROUP BY payment.amount, store.store_id
ORDER BY COUNT(payment.amount) DESC