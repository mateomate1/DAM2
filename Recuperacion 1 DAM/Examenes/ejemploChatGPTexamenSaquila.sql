#Ejercicio 2
/* a
Sentencia SQL para obtener por cada película el número total de alquileres
 que ha tenido, siempre que el número de alquileres supere los 10. Queremos
 visualizar el código de la película y la cantidad total de alquileres.
*/
use sakila;
SELECT  f.film_id, COUNT(r.rental_id)
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
GROUP BY f.film_id
HAVING COUNT(r.rental_id) > 30;

/* b
Escribe una consulta SQL que obtenga los empleados que trabajan en la misma 
tienda que el gerente llamado 'Jon Stephens'. La consulta debe mostrar el nombre,
 apellido y el identificador de la tienda a la que pertenecen.
*/
SELECT CONCAT(s.first_name, s.last_name) AS 'Empleado', st.store_id
FROM store st
JOIN staff s ON s.store_id = st.store_id
WHERE st.store_id = (SELECT store_id FROM staff WHERE first_name = 'Jon' AND last_name = 'Stephens');

/* c
Sentencia SQL que permita obtener las películas que no han sido alquiladas.
Queremos visualizar el título de la película y su precio de renta.
*/
SELECT f.title, f.rental_rate AS 'precio'
FROM film f 
JOIN inventory i ON i.film_id = f.film_id
LEFT JOIN rental r ON r.inventory_id = i.inventory_id
WHERE r.rental_id IS NULL;

/* d
Sentencia SQL que permita obtener los empleados que trabajen en ciudades en las 
que también residen sus clientes. Queremos visualizar el código del empleado, la 
ciudad donde trabaja y la ciudad de residencia del cliente.
*/
SELECT e.staff_id AS Codigo_Empleado, a.city AS Ciudad_Empleado, c.city AS Ciudad_Cliente
FROM staff e
JOIN address ea ON e.address_id = ea.address_id
JOIN city a ON ea.city_id = a.city_id
JOIN customer cu ON cu.address_id = ea.address_id
JOIN address ca ON cu.address_id = ca.address_id
JOIN city c ON ca.city_id = c.city_id
WHERE a.city_id = c.city_id;

#Ejercicio 3
/* a
Sentencia SQL para agregar una nueva película con los siguientes datos:
CÓDIGO PELÍCULA | 5002
TÍTULO | CAMARA DIGITAL
PRECIO DE ALQUILER | 15.49
DURACIÓN | 120 (por ejemplo)
CLASIFICACIÓN | 'G' (por ejemplo)
*/
SELECT * FROM film;
INSERT INTO film(film_id, title, rental_rate, length, rating, language_id) 
VALUES(5002, 'La camara de los tesoros', 15.49, 120, 'G', 7);

/* b
 Sentencia SQL para eliminar los productos cuyo precio sea inferior a 10
 y cuyo stock sea mayor que 100.
*/
START TRANSACTION;
	DELETE FROM film 
    WHERE rental_rate < 10
    JOIN 
ROLLBACK;

/* c 
Sentencia SQL para asignar a todos los empleados cuyo nombre comience por 'M' y 
termine en 'o' y que trabajen en la oficina de 'Madrid', el puesto de 'Gerente'.
*/
/* d 
Crea una transacción que incluya las sentencias desarrolladas en los apartados a),
b) y c) y, después de la transacción, se reviertan todos los cambios realizados.
*/
#Ejercicio 4
/* a 
Desarrolla un procedimiento almacenado que muestre el total de ventas acumuladas para un 
cliente pasado como parámetro. El procedimiento debe utilizar un cursor que recorra las 
ventas de ese cliente. Incluye la sentencia para invocar el procedimiento.
*/
/* b 
Desarrolla un disparador que permita auditar los cambios en el campo precio de la tabla 
productos, registrando los cambios en una tabla de auditoría llamada auditoria_precio 
(incluyendo los campos: codigo_producto, precio_original, precio_nuevo, usuario, fecha).
*/