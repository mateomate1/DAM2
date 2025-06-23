# Ej1: Crea un procedimiento `insertar_venta` que reciba id_cliente, id_producto, fecha y cantidad, e inserte una nueva venta.
DROP PROCEDURE IF EXISTS insertar_venta;
DELIMITER $$
CREATE PROCEDURE insertar_venta(IN cliente INT, IN producto INT, IN fecha DATE, IN cantidad INT)
BEGIN
	INSERT INTO ventas(id_cliente, id_producto, fecha, cantidad)
    VALUE(cliente, producto, fecha, cantidad);
END $$
DELIMITER ;
CALL insertar_venta(1, 2, '2024-06-01', 3);

# Ej2: Crea una funcion `total_gastado(cliente_id)` que devuelva el total gastado por un cliente (cantidad * precio).
DROP FUNCTION IF EXISTS total_gastado;
DELIMITER $$
CREATE FUNCTION total_gastado(cliente_id INT) 
RETURNS DECIMAL(15,2)
DETERMINISTIC
READS SQL DATA
BEGIN
	RETURN (
		SELECT IFNULL(SUM(v.cantidad * p.precio), 0)
        FROM ventas v
        JOIN productos p ON p.id_producto = v.id_producto
        WHERE v.id_cliente = cliente_id
        GROUP BY v.id_cliente);
END $$
DELIMITER ;

SELECT total_gastado(1);

# Ej3: Crea un trigger `before insert` en `ventas` que impida insertar ventas con cantidad menor o igual a 0.
DELIMITER $$
CREATE TRIGGER insercion_ventas_unsigned
BEFORE INSERT ON ventas
FOR EACH ROW
BEGIN
	IF NEW.cantidad <= 0
		THEN SIGNAL sqlstate '45000' set message_text = 'NO SE PUEDE INSERTAR VENTAS DE CANTIDADES NEGATIVAS';
	END IF;
END $$
DELIMITER ;
INSERT INTO ventas(id_cliente, id_producto, fecha, cantidad)
VALUE(3, 4, DATE(NOW()), 1);

# Ej4: Crea un procedimiento `mostrar_ventas_cliente(cliente_id)` que devuelva los nombres de los productos comprados y cantidad total por ese cliente.
DROP PROCEDURE mostrar_ventas_cliente;
DELIMITER $$
CREATE PROCEDURE mostrar_ventas_cliente(IN cliente_id INT)
BEGIN
	SELECT p.nombre AS 'PRODUCTO', IFNULL(SUM(v.cantidad), 0) AS 'CANTIDAD'
    FROM productos p
    JOIN ventas v ON v.id_producto = p.id_producto AND id_cliente = cliente_id
    GROUP BY p.id_producto;
END $$
DELIMITER ;
CALL mostrar_ventas_cliente(3);
# Ej5: Crea una tabla `log_ventas` y un trigger `after insert` que registre en ella la fecha, id_cliente e id_producto de cada venta.
CREATE TABLE log_ventas(
	fecha DATE,
    id_cliente INT,
    id_producto INT
);
DELIMITER $$
CREATE TRIGGER insercion_ventas
AFTER INSERT ON ventas
FOR EACH ROW
BEGIN
	INSERT INTO log_ventas(fecha, id_cliente, id_producto)
    VALUE(NEW.fecha, NEW.id_cliente, NEW.id_producto);
END $$
DELIMITER ;

# Ej6: Crea una funcion `producto_mas_vendido()` que devuelva el nombre del producto con mayor suma total de cantidades vendidas.
DELIMITER $$
CREATE FUNCTION producto_mas_vendido()
RETURNS varchar(100)
DETERMINISTIC
READS SQL DATA
BEGIN
	RETURN (
		SELECT p.nombre
		FROM productos p
        JOIN ventas v ON v.id_producto = p.id_producto
        GROUP BY p.id_producto
        ORDER BY SUM(v.cantidad) DESC
        LIMIT 1
        );
END $$
DELIMITER ;
SELECT producto_mas_vendido();

# Ej7: Crea un evento que cada dia a las 00:00 copie todas las filas de `ventas` en una tabla llamada `ventas_backup`.
DROP TABLE ventas_backup;
CREATE TABLE ventas_backup(
	id_venta int,
	id_cliente int ,
	id_producto int ,
	fecha date ,
	cantidad int,
    last_update timestamp default now(),
    PRIMARY KEY (id_venta)
);

DROP EVENT backup_ventas;
DELIMITER $$
CREATE EVENT backup_ventas ON SCHEDULE EVERY 1 MINUTE STARTS NOW()
DO
BEGIN 
	INSERT INTO ventas_backup
    SELECT *, now() FROM ventas;
END $$
DELIMITER ;

# Ej8: Crea un procedimiento `eliminar_cliente_seguro(cliente_id)` que elimine un cliente y todas sus ventas asociadas DE FORMA TRANSACCIONAL.
DELIMITER $$
CREATE PROCEDURE eliminar_cliente_seguro(IN cliente_id INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
		ROLLBACK;
    END;
    START TRANSACTION;
		DELETE FROM ventas
        WHERE id_cliente = cliente_id;
        
        DELETE FROM clientes
        WHERE id_cliente = cliente_id;
        
    COMMIT;
END $$
DELIMITER ;

CALL eliminar_cliente_seguro(4);

# Ej9: Crea un trigger que impida insertar una venta si la cantidad supera las 100 unidades.
DELIMITER $$
CREATE TRIGGER max_ventas
BEFORE INSERT ON ventas
FOR EACH ROW
BEGIN
	IF NEW.cantidad > 100 THEN 
		SIGNAL SQLSTATE '45000' SET message_text = 'VENTA CON DEMASIADAS UNIDADES';
    END IF;
END$$
DELIMITER ;

# Ej10: Crea un procedimiento que intente insertar una venta. Si ocurre un error (por clave foranea), registra el error en una tabla `errores_log`.
CREATE TABLE errores_log(
	id INT AUTO_INCREMENT,
    msg_error VARCHAR(400) NOT NULL,
    hora_error TIMESTAMP DEFAULT NOW(),
    PRIMARY KEY (ID)
);

DROP TRIGGER logger_ventas;
DELIMITER $$
CREATE TRIGGER logger_ventas
BEFORE INSERT ON ventas
FOR EACH ROW
BEGIN 
	DECLARE CONTINUE HANDLER FOR 1452
    BEGIN 
		DECLARE MENSAJE VARCHAR(200) DEFAULT 'NO SE PUDO INSERTAR EL VALOR POR UN ERROR CON LA CLAVE FORANEA';
        INSERT INTO errores_log(msg_error)
        VALUE(MENSAJE);
        SIGNAL SQLSTATE '45000' SET message_text = MENSAJE;
	END;
END $$
DELIMITER ;

INSERT INTO ventas(id_cliente, id_producto, fecha, cantidad)
VALUES (999, 999, CURDATE(), 1);


# Ej11: Crea un procedimiento que recorra todos los clientes con un cursor y guarde en una tabla auxiliar el total gastado por cada uno.
USE tienda;
CREATE TABLE gastos_clientes (
    id_cliente INT,
    gasto_total DECIMAL(15,2) DEFAULT 0,
    PRIMARY KEY (id_cliente),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

DROP PROCEDURE update_total_gastos;
DELIMITER $$
CREATE PROCEDURE update_total_gastos()
BEGIN
	DECLARE id INT DEFAULT 0;
	DECLARE FIN BOOLEAN DEFAULT FALSE;
    DECLARE cur CURSOR FOR SELECT id_cliente FROM clientes;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET FIN = TRUE;
    OPEN cur;
    TRUNCATE TABLE gastos_clientes;
    recorrido:LOOP
		FETCH cur INTO id;
		IF FIN 
			THEN LEAVE recorrido;
        END IF;
        
        INSERT INTO gastos_clientes(id_cliente, gasto_total)
        SELECT id, IFNULL(SUM(p.precio * v.cantidad), 0)
        FROM clientes c
        LEFT JOIN ventas V ON c.id_cliente = v.id_cliente
        LEFT JOIN productos p ON v.id_producto = p.id_producto
        WHERE c.id_cliente = id
        GROUP BY v.id_cliente;
        
    END LOOP;
    CLOSE cur;
END $$
DELIMITER ;

CALL update_total_gastos();

# Ej12: Crea una funcion `cantidad_total_producto(prod_id)` que devuelva la cantidad total vendida del producto indicado.
DROP FUNCTION cantidad_total_producto;
DELIMITER $$
CREATE FUNCTION cantidad_total_producto(prod_id INT) 
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
	DECLARE salida INT DEFAULT 0;
    SET salida = (
        SELECT IFNULL(SUM(v.cantidad), 0)
        FROM productos p
        LEFT JOIN ventas v ON p.id_producto = v.id_producto
        WHERE p.id_producto = prod_id
        GROUP BY p.id_producto
        );
	RETURN salida;
END $$
DELIMITER ;

SELECT cantidad_total_producto(2) AS 'RESULTADO';

# Ej13: Crea un evento semanal que reinicie una tabla `contador_ventas_semanal` a cero todos los lunes a las 00:00.
CREATE TABLE contador_ventas_semanal(
	total_dinero DECIMAL(15,2) DEFAULT 0
);

DROP EVENT reset_contador_ventas;
DELIMITER $$
CREATE EVENT reset_contador_ventas
ON SCHEDULE EVERY 1 WEEK STARTS '2025-06-16 00:00:00'
DO
BEGIN 
	UPDATE contador_ventas_semanal SET total_dinero = 0;
END $$
DELIMITER ;

# Ej14: Crea un trigger que verifique que existen los ids de cliente y producto antes de insertar una venta. Si no existen, lanza un error.
DROP TRIGGER verificar_insert_ventas;
DELIMITER $$
CREATE TRIGGER verificar_insert_ventas 
BEFORE INSERT ON ventas
FOR EACH ROW
BEGIN 
	DECLARE cliente BOOLEAN DEFAULT FALSE;
    DECLARE producto BOOLEAN DEFAULT FALSE;
    
    SET cliente = NOT EXISTS (SELECT id_cliente FROM clientes WHERE id_cliente = NEW .id_cliente);
    SET producto = NOT EXISTS (SELECT id_producto FROM productos WHERE id_producto = NEW .id_producto);
    
    IF cliente OR producto
    THEN SIGNAL SQLSTATE '45000' SET message_text = 'El cliente o producto no existen';
    END IF;
END $$
DELIMITER ;

INSERT INTO ventas(id_cliente, id_producto, fecha, cantidad)
VALUES (9999, 8888, CURDATE(), 1);


# Ej15: Crea un procedimiento que devuelva un ranking de clientes por total gastado, mostrando nombre y total.

