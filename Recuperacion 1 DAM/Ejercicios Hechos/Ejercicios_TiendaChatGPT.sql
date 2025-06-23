USE tienda;
-- LIKE  
# Ej1: Selecciona todos los clientes que vivan en ciudades que empiecen por 'M'
SELECT * 
FROM clientes
WHERE UPPER(ciudad) LIKE 'M%';

-- LIKE  
# Ej2: Muestra todos los productos cuyo nombre contiene la letra 'o'
SELECT *
FROM productos
WHERE UPPER(nombre) LIKE '%O%';

-- WHERE + BETWEEN  
# Ej3: Obtiene las ventas hechas en el mes de enero
SELECT * 
FROM ventas
WHERE month(fecha) = 1;

SELECT * 
FROM ventas
WHERE fecha BETWEEN '2024-01-01 ' AND '2024-01-31';

-- ORDER BY + LIMIT  
# Ej4: Muestra los 5 productos mas caros
SELECT * 
FROM productos
ORDER BY precio DESC
LIMIT 5;

-- ORDER BY + LIMIT  
# Ej5: Muestra los 3 clientes mas recientes ordenados alfabeticamente
SELECT c.id_cliente, c.nombre, c.ciudad
FROM clientes c
JOIN ventas v ON v.id_cliente = c.id_cliente
GROUP BY c.id_cliente
ORDER BY MAX(v.fecha) DESC, c.nombre ASC
LIMIT 3;
# Tener cuidado al ordenar y agrupar a la vez, hay que decirle q coja el maximo de ventas del cliente en este caso, sino no sabe con q sentencia de cliente quedarse y no usar valores de las 2 tablas si vamos a hacer group by

-- ORDER BY + LIMIT + LIKE  
# Ej6: Muestra los 2 productos mas baratos cuyo nombre empiece con 'T'
SELECT *
FROM productos 
WHERE UPPER(nombre) LIKE 'T%'
ORDER BY precio ASC
LIMIT 2;

-- GROUP BY + COUNT  
# Ej7: Cuenta cuantas ventas ha hecho cada cliente
SELECT c.nombre, COUNT(id_venta)
FROM clientes c, ventas v
WHERE c.id_cliente = v.id_cliente
GROUP BY  v.id_cliente;

SELECT c.nombre, COUNT(V.id_venta)
FROM clientes c
LEFT JOIN ventas v ON v.id_cliente = c.id_cliente
GROUP BY c.id_cliente;
#Importante usar GROUOP BY para usar la funcion COUNT()

-- GROUP BY + SUM  
# Ej8: Suma la cantidad total vendida por producto
SELECT p.nombre AS 'PRODUCTO', IFNULL(SUM(v.cantidad), 0) AS 'CANTIDAD'
FROM productoS p
LEFT JOIN ventas v ON p.id_producto = v.id_producto
GROUP BY p.id_producto;

-- GROUP BY + AVG  
# Ej9: Calcula el promedio de cantidad vendida por cada cliente
SELECT c.nombre, IFNULL(AVG(v.cantidad), 0)
FROM clientes c
LEFT JOIN ventas V ON c.id_cliente = v.id_cliente
GROUP BY c.id_cliente;

-- GROUP BY + COUNT(DISTINCT)  
# Ej10: Cuenta cuantos productos distintos ha comprado cada cliente
SELECT c.nombre, COUNT(DISTINCT v.id_producto)
FROM clientes c
LEFT JOIN ventas v ON c.id_cliente = v.id_cliente
GROUP BY c.id_cliente;

-- INNER JOIN  
# Ej11: Muestra el nombre del cliente, nombre del producto y cantidad de cada venta
SELECT c.nombre AS 'CLIENTE', p.nombre AS 'PRODUCTO', IFNULL(v.cantidad, 0) AS 'CANTIDAD'
FROM clientes c
CROSS JOIN productos p
LEFT JOIN ventas v ON c.id_cliente = v.id_cliente AND p.id_producto = v.id_producto
ORDER BY c.nombre; #No usar left con right join, usar cross join y unir con un left join, el left join aplicara sobre la cross join, si se usa left y right por separado, se quedara con el ultimo usado, por lo que no nos servira

SELECT c.nombre AS 'CLIENTE', p.nombre AS 'PRODUCTO', IFNULL(v.cantidad, 0) AS 'CANTIDAD'
FROM clientes c
LEFT JOIN productos p ON 1=1
LEFT JOIN ventas v ON v.id_cliente = c.id_cliente AND v.id_producto = p.id_producto

UNION

SELECT c.nombre AS 'CLIENTE', p.nombre AS 'PRODUCTO', IFNULL(v.cantidad, 0) AS 'CANTIDAD'
FROM productos p
LEFT JOIN clientes c ON 1=1
LEFT JOIN ventas v ON v.id_cliente = c.id_cliente AND v.id_producto = p.id_producto;

-- INNER JOIN  
# Ej12: Muestra todas las ventas junto con la ciudad del cliente
SELECT v.*, c.ciudad
FROM ventas v
JOIN clientes c ON c.id_cliente = v.id_cliente;

-- INNER JOIN + GROUP BY  
# Ej13: Muestra los productos que han sido vendidos al menos una vez
SELECT p.nombre
FROM productos p
JOIN ventas v ON p.id_producto = v.id_producto;

-- INNER JOIN + GROUP BY  
# Ej13.5: Muestra todos los productos y enseña la cantidad de ventas y la cantidad de clientes DISTINTOS que han comprado el producto
SELECT p.nombre, IFNULL(SUM(v.cantidad), 0) AS 'CANTIDAD VENDIDA', IFNULL(COUNT(DISTINCT id_cliente),0) AS 'COMPRADORES'
FROM productos p
LEFT JOIN ventas v ON p.id_producto = v.id_producto
GROUP BY p.id_producto;

-- INNER JOIN + WHERE  
# Ej14: Lista los clientes que hayan comprado un "Teclado"
SELECT DISTINCT c.nombre
FROM clientes c
JOIN ventas v ON c.id_cliente = v.id_cliente
WHERE v.id_producto = (SELECT id_producto FROM productos WHERE nombre = 'Teclado' LIMIT 1);


-- JOIN + SUM  
# Ej15: Muestra el total gastado por cada cliente (precio * cantidad)
SELECT c.nombre AS 'CLIENTE', IFNULL(SUM(v.cantidad * p.precio), 0)
FROM clientes c
LEFT JOIN ventas v ON c.id_cliente = v.id_cliente
LEFT JOIN productos p ON p.id_producto = v.id_producto
GROUP BY c.id_cliente;

-- HAVING + COUNT  
# Ej16: Muestra los clientes que han hecho mas de 1 venta
SELECT DISTINCT c.nombre
FROM clientes c
LEFT JOIN ventas v ON c.id_cliente = v.id_cliente
GROUP BY C.id_cliente
HAVING COUNT(v.id_cliente) < 2;

-- HAVING + SUM  
# Ej17: Muestra los productos cuyo total de ventas supere los 100 euros
SELECT p.nombre AS 'Producto', SUM(p.precio * v.cantidad) AS 'Ventas'
FROM productos p, ventas v
WHERE v.id_producto = p.id_producto
GROUP BY p.id_producto
HAVING SUM(p.precio * v.cantidad) > 100;

-- HAVING + COUNT(DISTINCT)  
# Ej18: Muestra los clientes que han comprado al menos 2 productos distintos
SELECT c.nombre AS 'CLIENTE', COUNT(DISTINCT v.id_producto) AS productos_distintos
FROM clientes c
LEFT JOIN ventas v ON c.id_cliente = v.id_cliente
GROUP BY c.id_cliente
HAVING COUNT(DISTINCT v.id_producto) >=2;

-- DISTINCT  
# Ej19: Muestra todas las ciudades diferentes en la tabla clientes
SELECT DISTINCT ciudad FROM clientes;

-- BETWEEN  
# Ej20: Muestra todas las ventas donde la cantidad esta entre 1 y 3
SELECT *
FROM ventas
WHERE cantidad BETWEEN 1 AND 2;

-- BETWEEN  
# Ej21: Muestra los productos cuyo precio esta entre 10 y 50
SELECT nombre from productos where precio between 10 and 50;

-- IN  
# Ej22: Muestra los clientes con ID 1, 3 o 5 usando IN
SELECT nombre from clientes where id_cliente in (1,3,5);

-- IS NULL  
# Ej23: Muestra las ventas que tengan un valor NULL en cualquier campo
SELECT * 
FROM ventas
WHERE id_cliente IS NULL
   OR id_producto IS NULL
   OR fecha IS NULL
   OR cantidad IS NULL;

-- SUBQUERY + MAX  
# Ej24: Muestra el nombre del cliente que haya hecho la venta de mayor cantidad
SELECT c.nombre
FROM ventas v
JOIN clientes c ON v.id_cliente = c.id_cliente
WHERE v.cantidad = (
    SELECT MAX(cantidad)
    FROM ventas
);

-- SUBQUERY + NOT EXISTS  
# Ej25: Muestra los productos que no han sido vendidos nunca
SELECT p.nombre
FROM productos p
WHERE NOT EXISTS (
  SELECT 1
  FROM ventas v
  WHERE v.id_producto = p.id_producto
);


SELECT *
FROM productos p
WHERE P.id_producto NOT IN (SELECT id_producto FROM ventas);

SELECT p.nombre
FROM productos p
LEFT JOIN ventas v ON p.id_producto = v.id_producto
WHERE v.id_producto IS NULL;

-- SUBQUERY + NOT IN  
# Ej26: Muestra los clientes que no han hecho ninguna venta
SELECT nombre
FROM clientes
WHERE id_cliente NOT IN (
	SELECT id_cliente
    FROM ventas);

SELECT c.nombre
FROM clientes c
LEFT JOIN ventas v ON c.id_cliente = v.id_cliente
WHERE v.id_cliente IS NULL;

-- SUBQUERY + GROUP BY + ORDER BY + LIMIT  
# Ej27: Muestra el producto mas vendido (por suma de cantidades)
SELECT nombre
FROM productos
WHERE id_producto = (
	SELECT id_producto
    FROM ventas
    GROUP BY id_producto
    ORDER BY SUM(cantidad) DESC
    LIMIT 1);

-- SUBQUERY + GROUP BY + ORDER BY + LIMIT  
# Ej28: Muestra el cliente que mas ha gastado en total
SELECT nombre
FROM clientes
WHERE id_cliente = (
	SELECT v.id_cliente
    FROM ventas v
    JOIN productos p ON p.id_producto = v.id_producto
    GROUP BY id_cliente
    ORDER BY SUM(v.cantidad * p.precio) DESC
    LIMIT 1);

-- ORDER BY DESC  
# Ej29: Muestra las ventas ordenadas por fecha descendente
SELECT *
FROM ventas
ORDER BY fecha DESC;

-- CROSS JOIN  
# Ej30: Muestra las combinaciones posibles cliente-producto aunque no haya venta
SELECT *
FROM clientes c
CROSS JOIN productos p;
