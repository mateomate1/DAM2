USE sakila;
/*
EJERCICIO 1
Desarrolla un procedimiento almacenado que muestre el importe total de alquileres 
de un cliente pasado como parametro. Para ello, utiliza un cursor que recorra 
todos los pagos realizados por dicho cliente y sume sus importes. 
Añade a continuacion la sentencia de invocacion del procedimiento. (6 puntos)
*/
DROP PROCEDURE total_alquileres;
DELIMITER $$
CREATE PROCEDURE total_alquileres(IN cliente_id SMALLINT)
BEGIN
	DECLARE total DECIMAL(5,2) DEFAULT 0;
    DECLARE temp DECIMAL(5,2) DEFAULT 0;
    DECLARE fin BOOLEAN DEFAULT FALSE;
	DECLARE cur CURSOR FOR 
		SELECT amount FROM payment WHERE customer_id = cliente_id;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = TRUE;
    OPEN cur;
	calculo : LOOP
		FETCH cur INTO temp;
		IF fin 
			THEN LEAVE calculo;
		END IF;
        SET total = total + temp;
	END LOOP;
    CLOSE cur;
    SELECT total;
END$$
DELIMITER ;
CALL total_alquileres(2);
SELECT sum(amount) from payment GROUP BY customer_id HAVING customer_id = 2;


/*
EJERCICIO 2
Desarrolla un disparador que permita tracear cuando alguien actualice el rental_rate 
(tarifa de alquiler) de una pelicula. Para ello, se debe registrar cada cambio en 
la tabla auditoria_peliculas (film_id, tarifa_original, tarifa_nueva, usuario, fecha_cambio). 
Asume que la tabla ya esta creada. (4 puntos)
*/

DELIMITER $$
CREATE TRIGGER auditoria_film
AFTER UPDATE ON film
FOR EACH ROW
BEGIN
	INSERT INTO auditoria_peliculas(film_id, tarifa_original, tarifa_nueva, usuario, fecha_cambio)
    VALUE (OLD.film_id, OLD.rental_rate, NEW.rental_rate, current_user(), now());
END $$
DELIMITER ;

DROP TRIGGER auditoria_film;

SELECT * from film;
SELECT * FROM sakila.auditoria_peliculas;
UPDATE film
SET rental_rate = rental_rate - 1
WHERE film_id = 1;

/*
EJERCICIO 3
Crea un procedimiento que, dado un nombre de ciudad como parametro, liste todos los 
clientes que residen en esa ciudad junto con su correo electronico y direccion completa. 
Utiliza una consulta con joins para obtener todos los datos requeridos. 
Añade la sentencia de invocacion. (5 puntos)
*/
USE SAKILA;
DELIMITER $$
CREATE PROCEDURE listar_clientes_x_ciudad (IN CIUDAD VARCHAR(100))
BEGIN
    SELECT cu.first_name as 'Nombre', cu.last_name as 'Apellido', cu.email as 'Correo Electronico', a.address as 'Direccion Completa'
    FROM city ci
    JOIN address a ON a.city_id = ci.city_id
    JOIN customer cu ON a.address_id = cu.address_id
    WHERE ci.city = CIUDAD;
END $$
DELIMITER ;
DROP PROCEDURE listar_clientes_x_ciudad;
CALL listar_clientes_x_ciudad('Aurora');

/*
EJERCICIO 4
Desarrolla un procedimiento almacenado que reciba una categoria de pelicula como parametro 
y devuelva el promedio de duracion (length) de todas las peliculas que pertenecen a dicha categoria. 
Utiliza una variable para almacenar el resultado y mostrala al final. 
Añade la sentencia de invocacion. (5 puntos)
*/

DROP PROCEDURE IF EXISTS duracion_x_categoria;
DELIMITER $$
CREATE PROCEDURE duracion_x_categoria(IN categoria VARCHAR(200))
BEGIN 
	DECLARE media DECIMAL(15,2) DEFAULT 0;
    SET media = ROUND((
    SELECT AVG(f.length)
    FROM film f
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    WHERE c.name = categoria),2);
    SELECT MEDIA;
END $$
DELIMITER ;
CALL duracion_x_categoria('Action');
/*
EJERCICIO 5
Crea un disparador que se dispare despues de eliminar un cliente de la tabla customer. 
Este trigger debera registrar en una tabla llamada clientes_eliminados 
(customer_id, nombre, apellido, email, fecha_baja) los datos del cliente eliminado. 
Asume que la tabla ya existe. (4 puntos)
*/
CREATE TABLE event_table (
  id INT AUTO_INCREMENT PRIMARY KEY,
  evento_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  mensaje VARCHAR(200)
);
#DROP TABLE event_table;

CREATE EVENT evento_empresa 
ON SCHEDULE AT '2025-06-12 13:25:00' DO 
	INSERT INTO event_table(mensaje) VALUE('PRUEBA DE FUNCIONAMIENTO');
DROP EVENT evento_empresa;
SET GLOBAL event_scheduler = 1;
SELECT * FROM INFORMATION_SCHEMA.EVENTS;
SHOW EVENTS;
SHOW VARIABLES LIKE 'event_scheduler';