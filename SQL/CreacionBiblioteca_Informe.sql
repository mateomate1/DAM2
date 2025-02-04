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

-- Insertar más autores
INSERT INTO autor (nombre, apellido) VALUES ('Agatha', 'Christie');
INSERT INTO autor (nombre, apellido) VALUES ('Stephen', 'King');
INSERT INTO autor (nombre, apellido) VALUES ('Isaac', 'Asimov');
INSERT INTO autor (nombre, apellido) VALUES ('J.R.R.', 'Tolkien');
INSERT INTO autor (nombre, apellido) VALUES ('Haruki', 'Murakami');
INSERT INTO autor (nombre, apellido) VALUES ('Margaret', 'Atwood');
INSERT INTO autor (nombre, apellido) VALUES ('Philip', 'K. Dick');
INSERT INTO autor (nombre, apellido) VALUES ('Leo', 'Tolstoy');
INSERT INTO autor (nombre, apellido) VALUES ('Mark', 'Twain');
INSERT INTO autor (nombre, apellido) VALUES ('Ernest', 'Hemingway');

-- Insertar más libros
INSERT INTO libro (ISBN, titulo, autor_id, ventas) VALUES ('978-0-00-711935-6', 'Asesinato en el Orient Express', 4, 2000000);
INSERT INTO libro (ISBN, titulo, autor_id, ventas) VALUES ('978-0-385-12168-2', 'It', 5, 3000000);
INSERT INTO libro (ISBN, titulo, autor_id, ventas) VALUES ('978-0-553-29335-6', 'El resplandor', 5, 2500000);
INSERT INTO libro (ISBN, titulo, autor_id, ventas) VALUES ('978-0-553-80371-1', 'Cementerio de animales', 5, 2200000);
INSERT INTO libro (ISBN, titulo, autor_id, ventas) VALUES ('978-0-553-29336-3', 'Fundacion', 6, 1800000);
INSERT INTO libro (ISBN, titulo, autor_id, ventas) VALUES ('978-0-261-10235-4', 'El señor de los anillos', 7, 150000000);
INSERT INTO libro (ISBN, titulo, autor_id, ventas) VALUES ('978-0-14-312774-1', 'Kafka en la orilla', 8, 500000);
INSERT INTO libro (ISBN, titulo, autor_id, ventas) VALUES ('978-0-385-49081-8', 'El cuento de la criada', 9, 4000000);
INSERT INTO libro (ISBN, titulo, autor_id, ventas) VALUES ('978-0-547-92865-3', 'El hombre en el castillo', 10, 1700000);
INSERT INTO libro (ISBN, titulo, autor_id, ventas) VALUES ('978-0-19-953567-5', 'Guerra y paz', 11, 3600000);
INSERT INTO libro (ISBN, titulo, autor_id, ventas) VALUES ('978-0-14-143964-0', 'Las aventuras de Huckleberry Finn', 12, 2900000);
INSERT INTO libro (ISBN, titulo, autor_id, ventas) VALUES ('978-0-7432-7356-5', 'El viejo y el mar', 13, 2800000);

-- Libros adicionales compartiendo autores
INSERT INTO libro (ISBN, titulo, autor_id, ventas) VALUES ('978-0-00-712083-3', 'Diez negritos', 4, 1000000);
INSERT INTO libro (ISBN, titulo, autor_id, ventas) VALUES ('978-0-553-29338-7', 'Los propios dioses', 6, 1200000);
INSERT INTO libro (ISBN, titulo, autor_id, ventas) VALUES ('978-0-00-752749-5', 'Y no quedó ninguno', 4, 1300000);
INSERT INTO libro (ISBN, titulo, autor_id, ventas) VALUES ('978-0-553-29337-0', 'Yo, robot', 6, 900000);
INSERT INTO libro (ISBN, titulo, autor_id, ventas) VALUES ('978-0-261-10236-1', 'El hobbit', 7, 100000000);
INSERT INTO libro (ISBN, titulo, autor_id, ventas) VALUES ('978-0-06-091650-3', 'Crónica del pájaro que da cuerda al mundo', 8, 600000);
INSERT INTO libro (ISBN, titulo, autor_id, ventas) VALUES ('978-0-06-074918-2', 'Tokio Blues', 8, 1200000);
INSERT INTO libro (ISBN, titulo, autor_id, ventas) VALUES ('978-0-547-92864-6', 'Ubik', 10, 1100000);
INSERT INTO libro (ISBN, titulo, autor_id, ventas) VALUES ('978-0-452-28425-8', 'Rebelión en la granja', 2, 7500000);
INSERT INTO libro (ISBN, titulo, autor_id, ventas) VALUES ('978-0-7475-3270-5', 'Harry Potter y la cámara secreta', 3, 77000000);
INSERT INTO libro (ISBN, titulo, autor_id, ventas) VALUES ('978-0-7475-3271-2', 'Harry Potter y el prisionero de Azkaban', 3, 65000000);