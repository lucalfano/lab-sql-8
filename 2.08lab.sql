use sakila;
-- lab 2.08 
-- 1 Write a query to display for each store its store ID, city, and country.
select s.store_id, ci.city, co.country 
from sakila.store s 
join sakila.address a using(address_id)
join sakila.city ci using(city_id)
join sakila.country co using(country_id);

-- 2 Write a query to display how much business, in dollars, each store brought in.
select s.store_id, sum(p.amount) as 'revenue USD'
from sakila.payment p  
join sakila.staff s using(staff_id)
join sakila.rental r using(rental_id)
group by s.store_id;

-- 3 Which film categories are longest?
select c.name, avg(f.length) as 'avg_runtime'
from sakila.film f
join sakila.film_category fc using(film_id)
join sakila.category c using(category_id)
group by c.name
order by avg(f.length) desc; 

-- 4 Display the most frequently rented movies in descending order.
select f.title, count(r.rental_id) as 'rental_frequency'
from sakila.film f
join sakila.inventory i using(film_id)
join sakila.rental r using (inventory_id)
group by f.title
order by count(r.rental_id) desc;

-- 5 List the top five genres in gross revenue in descending order.
select c.name as 'Film', sum(p.amount) as 'Gross Revenue'
from sakila.category as c
join sakila.film_category as fc on fc.category_id = c.category_id
join sakila.inventory as i on i.film_id = fc.film_id
join sakila.rental as r on r.inventory_id = i.inventory_id
join sakila.payment as p on p.rental_id = r.rental_id
group by c.name
order by sum(p.amount) desc
limit 5;
    
-- 6 Is "Academy Dinosaur" available for rent from Store 1?
select film.film_id, film.title, store.store_id, inventory.inventory_id
from sakila.inventory 
join sakila.store using (store_id) 
join sakila.film using (film_id)
where film.title = 'Academy Dinosaur' and store.store_id = 1;


-- 7 Get all pairs of actors that worked together.
SELECT fa1.film_id, CONCAT(a1.first_name, ' ', a1.last_name), CONCAT(a2.first_name, ' ', a2.last_name)
FROM sakila.actor a1
INNER JOIN film_actor fa1 USING(actor_id)
INNER JOIN film_actor fa2 ON (fa1.film_id = fa2.film_id)
AND (fa1.actor_id != fa2.actor_id)
INNER JOIN actor a2 
ON a2.actor_id = fa2.actor_id;
-- 29k rows??????????
  