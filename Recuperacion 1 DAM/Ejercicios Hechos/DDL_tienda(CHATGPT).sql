-- Crear la base de datos
DROP DATABASE IF EXISTS TIENDA;
CREATE DATABASE IF NOT EXISTS tienda;
USE tienda;

-- Tabla de clientes
CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    ciudad VARCHAR(100)
);

-- Tabla de productos
CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    precio DECIMAL(10,2)
);

-- Tabla de ventas
CREATE TABLE ventas (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    id_producto INT,
    fecha DATE,
    cantidad INT,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- Insertar datos en clientes
INSERT INTO clientes (nombre, ciudad) VALUES 
('Ana', 'Madrid'),
('Pedro', 'Valencia'),
('Laura', 'Sevilla');

-- Insertar datos en productos
INSERT INTO productos (nombre, precio) VALUES 
('Teclado', 30.00),
('Raton', 20.00),
('Monitor', 150.00);

-- Insertar datos en ventas
INSERT INTO ventas (id_cliente, id_producto, fecha, cantidad) VALUES
(1, 1, '2024-01-10', 2),
(1, 2, '2024-01-11', 1),
(2, 3, '2024-02-01', 1);
