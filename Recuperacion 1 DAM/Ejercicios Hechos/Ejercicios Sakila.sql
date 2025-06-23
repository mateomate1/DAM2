# Enlace a la pagina:
# https://www.discoduroderoer.es/ejercicios-propuestos-y-resueltos-sakila-mysql/

USE sakila;

# Ej 1 Actores que tienen de primer nombre ‘Scarlett’.

SELECT * 
FROM actor
WHERE first_name = 'Scarlett';

# Ej 2 Actores que tienen de apellido ‘Johansson’.

SELECT * 
FROM actor 
WHERE last_name = 'Johansson';

# Ej 3 Actores que contengan una ‘O’ en su nombre.

SELECT *
FROM actor 
WHERE first_name like '%o%';

# Ej 4 Actores que contengan una ‘O’ en su nombre y en una ‘A’ en su apellido.

SELECT *
FROM actor 
WHERE first_name like '%o%'
AND last_name LIKE '%a%';

# Ej 5 Actores que contengan dos ‘O’ en su nombre y en una ‘A’ en su apellido.

SELECT *
FROM actor 
WHERE first_name like '%o%o%'
AND last_name LIKE '%a%';

# Ej 6 Actores donde su tercera letra sea ‘B’.

SELECT *
FROM actor 
WHERE first_name like '__b%';

# Ej 7 Ciudades que empiezan por ‘a’.

SELECT * 
FROM city 
WHERE city LIKE 'a%';

# Ej 8 Ciudades que acaban por ‘s’.

SELECT * 
FROM city 
WHERE city LIKE '%s';

# Ej 9 Ciudades del country 61.

SELECT * 
FROM city 
WHERE country_id = 61;

# Ej 10 Ciudades del country ‘Spain’.

SELECT * 
FROM city 
WHERE country_id = (
	SELECT country_id
    FROM country
    WHERE country LIKE 'SPAIN'
    LIMIT 1
);

SELECT * 
FROM city ci
JOIN country co ON ci.country_id = co.country_id
WHERE co.country = 'SPAIN';

# Ej 11 Ciudades con nombres compuestos.

SELECT * 
FROM city
WHERE city LIKE '% %';

# Ej 12 Películas con una duración entre 80 y 100.

SELECT *
FROM film 
WHERE length between 80 and 100;

# Ej 13 Peliculas con un rental_rate entre 1 y 3.

SELECT * 
FROM film
WHERE rental_rate between 1 AND 3;

# Ej 14 Películas con un titulo de más de 12 letras.

SELECT * 
FROM film 
WHERE length(title) > 12;

# Ej 15 Peliculas con un rating de PG o G.

SELECT film_id, title, rating
FROM film
WHERE rating = 'PG' OR rating = 'G';

SELECT film_id, title, rating
FROM film
WHERE rating IN ('PG', 'G');

# Ej 16 Peliculas que no tengan un rating de NC-17.

SELECT film_id, title, rating
FROM film
WHERE rating NOT IN ('NC-17');


SELECT film_id, title, rating 
FROM film 
WHERE rating <> 'NC-17'; # <> es igual a usar != o not x=y

# Ej 17 Peliculas con un rating PG y duracion de más de 120.

SELECT film_id, title, rating, length 
FROM film f
WHERE rating = 'PG'
AND length > 120;

# Ej 18 ¿Cuantos actores hay?

SELECT COUNT(actor_id) AS 'numero de actores'
FROM actor;

# Ej 19 ¿Cuántas ciudades tiene el country ‘Spain’?

SELECT COUNT(city_id) AS 'Nº de ciudades'
FROM city 
WHERE country_id IN (
	SELECT country_id
    FROM country
    WHERE  country = 'Spain');

# Ej 20 ¿Cuántos countries hay que empiezan por ‘a’?

SELECT COUNT(country_id) AS 'Nº de paises'
FROM country 
WHERE country LIKE 'a%';


# Ej 21 Media de duración de peliculas con PG.

SELECT AVG(length) AS 'Media', rating
FROM film
WHERE rating = 'PG';

# Ej 21.1 Media de duración de peliculas segun su rating

SELECT AVG(length) AS 'Media', rating
FROM film
GROUP BY rating;

# Ej 22 Suma de rental_rate de todas las peliculas.

SELECT SUM(rental_rate)
FROM film;

# Ej 23 Pelicula con mayor duración.

SELECT *
FROM film
ORDER BY length DESC
LIMIT 1;

SELECT MAX(length) as mayor_duracion 
FROM film;

# Ej 24 Película con menor duración.

SELECT *
FROM film
ORDER BY length ASC
LIMIT 1;

SELECT MIN(length) as mayor_duracion 
FROM film;

# Ej 25 Mostrar las ciudades del country Spain (multitabla).

SELECT *
FROM city ci
JOIN country co ON co.country_id = ci.country_id
WHERE co.country = 'Spain';

SELECT co.country, c.city
FROM city c, country co
WHERE c.country_id = co.country_id
AND co.country = 'Spain';

# Ej 26 Mostrar el nombre de la película y el nombre de los actores.

SELECT  Ç

# Ej 27


# Ej 28


# Ej 29


# Ej 30


# Ej 31


# Ej 32







