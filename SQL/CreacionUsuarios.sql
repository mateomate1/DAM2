
DROP DATABASE IF EXISTS UsuariosDB;

CREATE DATABASE UsuariosDB;

USE UsuariosDB;

CREATE TABLE Usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    passkey VARCHAR(255) NOT NULL,
    nivel INT NOT NULL DEFAULT 0,
    fecha_alta TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO Usuarios (username, passkey, nivel) VALUES
('admin', 'claveadmin123', 10),
('editor', 'claveeditor456', 5),
('usuario1', 'claveusuario789', 1),
('prueba2', 'claveprueba123', 3),
('demo3', 'claveprueba456', 2),
('superuser', 'superclave789', 9),
('visitante', 'clavevisitante', 0),
('tester', 'testclave321', 4),
('moderador', 'modclave987', 7),
('invitado', 'claveinvitado', 0);
