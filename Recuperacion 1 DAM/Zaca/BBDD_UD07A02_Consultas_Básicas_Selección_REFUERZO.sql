/* 	Nuestro cliente, el VideoClub "Sakila", y en su nombre, el gerente de IT, nos pide que modelemos una serie de consultas contra la BD para facilitarles la explotación de los datos.
	
	Bajo cada requisito, debes incluir la consulta necesaria para satisfacer 
	las condiciones solicitadas por el cliente. 
	
	Recuerda usar mayúsculas para las palabras reservadas de SQL y minúsculas para los datos de usuario (nombre de tablas, campos, alias...)
	
	También es buena práctica incluir saltos de linea que separen las clausulas y operadores para visualizar correctamente las consultas. Por ejemplo:
		SELECT X,Y,Z
		FROM tabla1, tabla2
		WHERE condicion1
		AND condicion2
		GROUP BY X
		HAVING filtro
		ORDER BY asc/desc
		LIMIT n
		...;
*/

/* 3. Nombre y apellido de los actores que hayan participado en películas con rating 'PG'*/
USE SAKILA;
SELECT a.first_name, a.last_name, f.title, f.rating
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN actor a ON fa.actor_id = a.actor_id
WHERE f.rating = 'pg'
ORDER BY f.title;

/* 5. Nombre y apellido de los clientes junto con el título de la película y la categoría de aquellos que hayan alquilado una película con categoría 'Action' */
SELECT CONCAT(c.first_name,' ' , c.last_name) AS 'NOMBRE Y APELLIDO', f.title, cy.name AS 'CATEGORIA'
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON fc.film_id = f.film_id
JOIN category cy ON fc.category_id = cy.category_id
WHERE cy.name LIKE 'Action';

/* 6. Número de películas cuyo título tenga una 'a' en la 2ª posición */
SELECT COUNT(film_id)
FROM film
WHERE title LIKE '_A%';

/* 7. Importe mínimo de los alquileres de películas cuya duración de alquiler sea 3 días*/

/* 10. Suma de los importes de alquiler junto con el rating correspondiente agrupados por rating en orden descendente de importe*/

/* 13. importe total de pagos gestionados por empleados de la tienda store_id 1, junto con el nombre y apellido del empleado*/

/* 14. Media de importe de penalizaciones (coste por remplazo) de las películas en las que participe un actor cuyo nombre termine en 's' */

/* 18. Actores (nombre y apellido) sin repetir que participen en películas infantiles ordenados por apellido ascendentemente*/

