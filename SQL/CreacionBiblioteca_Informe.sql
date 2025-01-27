drop database IF EXISTS biblioteca_informe;
create database biblioteca_informe;
use biblioteca_informe;
CREATE TABLE Libros (
    ISBN VARCHAR(20) PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL
);
INSERT INTO Libros (ISBN, titulo) VALUES 
('978-3-16-148410-0', 'El principito'),
('978-0-7432-7356-5', 'Cien años de soledad');
