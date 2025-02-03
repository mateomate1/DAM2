-- Eliminar la base de datos si ya existe
DROP DATABASE IF EXISTS biblioteca_informe;

-- Crear la base de datos
CREATE DATABASE biblioteca_informe;

-- Usar la base de datos
USE biblioteca_informe;

-- Crear la tabla Autor
CREATE TABLE autor (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL
);

-- Crear la tabla Libro
CREATE TABLE libro (
    ISBN VARCHAR(20) PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    autor_id INT NOT NULL,
    ventas INT DEFAULT 0,
    FOREIGN KEY (autor_id) REFERENCES autor(id) ON DELETE CASCADE
);

-- Insertar datos de prueba en la tabla Autor
INSERT INTO autor (nombre, apellido) VALUES ('Gabriel', 'Garcia Marquez');
INSERT INTO autor (nombre, apellido) VALUES ('George', 'Orwell');
INSERT INTO autor (nombre, apellido) VALUES ('J.K.', 'Rowling');

-- Insertar datos de prueba en la tabla Libro
INSERT INTO libro (ISBN, titulo, autor_id, ventas) VALUES ('978-3-16-148410-0', 'Cien años de soledad', 1, 5000000);
INSERT INTO libro (ISBN, titulo, autor_id, ventas) VALUES ('978-0-452-28423-4', '1984', 2, 10000000);
INSERT INTO libro (ISBN, titulo, autor_id, ventas) VALUES ('978-0-7475-3269-9', 'Harry Potter y la piedra filosofal', 3, 120000000);
