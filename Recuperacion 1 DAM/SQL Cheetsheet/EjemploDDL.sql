-- Eliminar tabla en el caso de que si exista
DROP DATABASE IF EXISTS nombre_bd;

-- Creacion de la BDD incluyendo la clausula IF NOT EXISTS, el juego de caracteres y el cotejamiento
CREATE DATABASE IF NOT EXISTS nombre_bd CHARACTER SET UTF8mb4 COLLATE utf8mb4_0900_ai_ci; 

USE nombre_bd;

-- Creacion de una tabla
CREATE TABLE IF NOT EXISTS nombre_tabla(
	ID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    genero ENUM('M', 'F', 'N') DEFAULT 'N', 
    edad TINYINT CHECK (edad >= 18),
    fecha_alta TIMESTAMP NOT NULL DEFAULT current_timestamp, 
    aceptado char(1) CHECK('Y' OR 'N') DEFAULT 'N'
 );
 
DROP TABLE IF EXISTS nombre_tabla;

CREATE TABLE IF NOT EXISTS restricciones_metodo1(
	ID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    genero ENUM('M', 'F', 'N') DEFAULT 'N', 
    edad TINYINT CHECK (edad >= 18),
    fecha_alta TIMESTAMP NOT NULL DEFAULT current_timestamp, 
    aceptado char(1) CHECK('Y' OR 'N') DEFAULT 'N'
);

CREATE TABLE IF NOT EXISTS restricciones_metodo2(
	ID TINYINT UNSIGNED AUTO_INCREMENT,
    genero ENUM('M', 'F', 'N'),
    CONSTRAINT ai_pk_id PRIMARY KEY(ID)
);

CREATE TABLE IF NOT EXISTS restricciones(
	caracter_de_longitud_definida CHAR(50),
    caracter_de_longitud_limitada VARCHAR(50)
);

ALTER TABLE restricciones ADD INDEX idx_nombre(caracter_de_longitud_definida);
SHOW INDEXES FROM restricciones;

EXPLAIN SELECT * FROM restricciones;

CREATE USER 'mateo'@'localhost' IDENTIFIED BY 'password';
CREATE USER 'sonia'@'localhost' IDENTIFIED BY 'pass';

GRANT select, insert on nombre_bd.* to 'mateo'@'localhost';
REVOKE all on nombre_bd.* from 'mateo'@'localhost';

-- Vista de usuarios:
show databases;
use information_schema;
select * from USER_ATTRIBUTES;

-- Vista de usuarios y permisos: 
show databases;
use information_schema;
show tables;
select * 
from USER_ATTRIBUTES
join USER_PRIVILEGES;

select * from USER_PRIVILEGES;

SHOW GRANTS FOR 'mateo'@'localhost';
SHOW GRANTS FOR 'root'@'localhost';

select *
from mysql user;
