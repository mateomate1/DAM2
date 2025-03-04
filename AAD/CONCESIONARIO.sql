DROP DATABASE IF EXISTS concesionario;
CREATE DATABASE concesionario CHARSET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE concesionario;

CREATE TABLE matriculas (
    matricula CHAR(7) PRIMARY KEY
);

CREATE TABLE vehiculos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    matricula CHAR(7),
    modelo VARCHAR(50),
    color VARCHAR(20),
    FOREIGN KEY (matricula) REFERENCES matriculas(matricula)
);

INSERT INTO matriculas (matricula) VALUES
('1234FBC'),
('5678DYF'),
('9101GHJ');

INSERT INTO vehiculos (matricula, modelo, color) VALUES
('1234FBC', 'Toyota', 'Rojo'),
('5678DYF', 'Honda Civic', 'Azul'),
('9101GHJ', 'Ford Focus', 'Negro');
