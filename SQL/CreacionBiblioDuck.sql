-- Eliminacion de la BDD
DROP DATABASE IF EXISTS BiblioDuck;

-- Creacion de la base de datos
CREATE DATABASE BiblioDuck;

-- Uso de la base de datos
USE BiblioDuck;

-- Tabla de alumnos
CREATE TABLE Usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    password_key VARCHAR(255) NOT NULL,  -- Se cambió a 255 para adecuarlo a los hashes
    nombre VARCHAR(100),
    apellidos VARCHAR(100),
    email VARCHAR(150) UNIQUE,
    telefono VARCHAR(15),
    fecha_registro DATE DEFAULT(CURRENT_DATE)
);

-- Tabla de libros
CREATE TABLE Libros (
    id_libro INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    autor VARCHAR(150) NOT NULL,
    genero VARCHAR(50),
    anio_publicacion INT,  -- Cambié de YEAR a INT
    disponible BOOLEAN DEFAULT TRUE
);


-- Tabla de prestamos
CREATE TABLE Prestamos (
    id_prestamo INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_libro INT NOT NULL,
    fecha_prestamo DATE DEFAULT(CURRENT_DATE),
    fecha_devolucion DATE,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    FOREIGN KEY (id_libro) REFERENCES Libros(id_libro)
);

-- Insercion de datos en la tabla Usuario (con hash de contraseñas simuladas)
INSERT INTO Usuario (username, password_key, nombre, apellidos, email, telefono)
VALUES
('juanperez', 'juanperez', 'Juan', 'Perez', 'juan.perez@email.com', '123456789'),
('marialopez', 'marialopez', 'Maria', 'Lopez', 'maria.lopez@email.com', '987654321'),
('carlosgomez', 'carlosgomez', 'Carlos', 'Gomez', 'carlos.gomez@email.com', '567890123');

-- Insercion de datos en la tabla Libros
INSERT INTO Libros (titulo, autor, genero, anio_publicacion)
VALUES
('Cien Anos de Soledad', 'Gabriel Garcia Marquez', 'Novela', 1967),
('Don Quijote de la Mancha', 'Miguel de Cervantes', 'Novela', 1605),
('El Principito', 'Antoine de Saint-Exupery', 'Ficcion', 1943);

-- Insercion de datos en la tabla Prestamos
INSERT INTO Prestamos (id_usuario, id_libro, fecha_devolucion)
VALUES
(1, 2, '2025-01-20'),
(2, 3, '2025-01-25');


