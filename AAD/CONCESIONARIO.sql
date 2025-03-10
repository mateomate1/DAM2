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
('9101GHJ'),
('1122AAB'),
('3344CCD'),
('5566EFF'),
('7788GGH'),
('8899IIJ'),
('9900KKL'),
('2233MNO'),
('4455PQR'),
('6677STU'),
('8899VWX'),
('1011YZA'),
('1213BCD'),
('1415EFG'),
('1617HIJ'),
('1819KLM'),
('2021NOP'),
('2223QRS');

INSERT INTO vehiculos (matricula, modelo, color) VALUES
('1234FBC', 'Toyota Corolla', 'Rojo'),
('5678DYF', 'Toyota Corolla', 'Azul'),
('9101GHJ', 'Toyota Corolla', 'Negro'),
('1122AAB', 'Toyota Corolla', 'Blanco'),
('3344CCD', 'Honda Civic', 'Gris'),
('5566EFF', 'Honda Civic', 'Rojo'),
('7788GGH', 'Honda Civic', 'Negro'),
('8899IIJ', 'Honda Civic', 'Azul'),
('9900KKL', 'Ford Focus', 'Negro'),
('2233MNO', 'Ford Focus', 'Azul'),
('4455PQR', 'Ford Focus', 'Gris'),
('6677STU', 'Ford Focus', 'Blanco'),
('8899VWX', 'Ford Focus', 'Rojo'),
('1011YZA', 'Nissan Sentra', 'Verde'),
('1213BCD', 'Nissan Sentra', 'Blanco'),
('1415EFG', 'Nissan Sentra', 'Negro'),
('1617HIJ', 'Nissan Sentra', 'Azul'),
('1819KLM', 'Mazda 3', 'Gris'),
('2021NOP', 'Mazda 3', 'Rojo'),
('2223QRS', 'Mazda 3', 'Negro');