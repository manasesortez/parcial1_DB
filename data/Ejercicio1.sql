CREATE DATABASE Ejercicio1_u20171110;

USE Ejercicio1_u20171110;

CREATE TABLE estado(
   estado_id INT CHECK (estado_id > 0) NOT NULL IDENTITY,
   estado_estados VARCHAR(100) UNIQUE NOT NULL,
   PRIMARY KEY(estado_id)
);

SELECT * FROM estado;

SET IDENTITY_INSERT dbo.estado ON
INSERT INTO dbo.estado
(estado_estados)
VALUES
('Disponible'),
('Prestado'),
('Reservado'),
('Biblioteca UNIVO - Jaguar de Piedra'),
('Biblioteca UNIVO - Central');
SET IDENTITY_INSERT dbo.estado OFF

CREATE TABLE autor(
autor_id INT CHECK (autor_id > 0) NOT NULL IDENTITY,
autor_codigo INT NOT NULL,
autor_nombre VARCHAR(100) NOT NULL,
autor_nacionalidad VARCHAR(100) NOT NULL,
PRIMARY KEY(autor_codigo)
);

SELECT * FROM autor;

SET IDENTITY_INSERT dbo.autor ON
INSERT INTO dbo.autor
(autor_codigo, autor_nombre, autor_nacionalidad)
VALUES
(0234, 'Inés Posadas Gil', 'El Salvador'),
(1019, 'José Sánchez Pons', 'Guatemala'),
(2908, 'Miguel Gómez Sáez', 'España'),
(0089, 'Eva Santana Páez', 'Mexico'),
(0878, 'Juan Luis Blanco', 'Argentina');
SET IDENTITY_INSERT dbo.autor OFF

CREATE TABLE libro(
libro_id INT CHECK (libro.libro_id > 0) NOT NULL IDENTITY,
libro_isbn VARCHAR(100) NOT NULL,
libro_clasificacion VARCHAR(100) NOT NULL,
libro_titulo VARCHAR(100) NOT NULL,
libro_editorial VARCHAR(100) NOT NULL,
libro_paginas VARCHAR(10) NOT NULL,
autor_codigo INT NOT NULL,
PRIMARY KEY(libro_isbn),
CONSTRAINT FK_AUT_COD FOREIGN KEY (autor_codigo) REFERENCES autor(autor_codigo) ON UPDATE CASCADE
);

SELECT * FROM dbo.libro;

SET IDENTITY_INSERT dbo.libro ON
INSERT INTO libro(libro_isbn, libro_clasificacion, libro_titulo, libro_editorial, libro_paginas, autor_codigo)
VALUES
('42-117S', 'Libro 004.67 046 1997', 'Introduccion a Java', 'Caralt', '569 P.', 0234),
('31-765D', 'Libro 560.56 046 1999', 'Historia de la Psicologia', 'Andina', '456 P.', 1019),
('11-542G', 'Libro 967.08 046 1992', 'DMS-5', 'Florent', '1200 P.', 2908),
('34-907A', 'Libro 345.43 046 2002', 'Programacion DB en MySQL', 'Anaya', '129 P.', 0089),
('42-789A', 'Libro 345.09 046 2001', 'Aprendiendo HTML en 24 horas', 'Caralt', '389 P.', 0089);
SET IDENTITY_INSERT dbo.libro OFF

CREATE TABLE libroCopia(
libroCopia_id INT CHECK (libroCopia.libroCopia_id > 0) NOT NULL IDENTITY,
libroCopia_item VARCHAR(50) NOT NULL,
libro_isbn VARCHAR(100) NOT NULL,
estado_id INT NOT NULL,
PRIMARY KEY(libroCopia_item),
CONSTRAINT FK_LIB_ISB FOREIGN KEY (libro_isbn) REFERENCES dbo.libro(libro_isbn) ON UPDATE CASCADE,
CONSTRAINT FK_ESTA_ID FOREIGN KEY (estado_id) REFERENCES dbo.estado(estado_id) ON UPDATE CASCADE
);

SET IDENTITY_INSERT dbo.libroCopia ON
INSERT INTO libroCopia(libroCopia_item, libro_isbn, estado_id)
VALUES
('01-765D', '31-765D', 2),
('01-117S', '42-117S', 2),
('02-117S','42-117S', 1),
('01-907A', '34-907A', 2),
('06-789A', '42-789A', 4);
SET IDENTITY_INSERT dbo.libroCopia OFF

SELECT * FROM dbo.libroCopia;

CREATE TABLE usuario(
    usuario_id INT CHECK (usuario.usuario_id > 0) NOT NULL IDENTITY,
    usuario_carnet VARCHAR(50) NOT NULL,
    usario_nombre VARCHAR(50) NOT NULL,
    usuario_direccion VARCHAR(100) NOT NULL,
    usuario_telefono VARCHAR(15) NOT NULL,
    PRIMARY KEY(usuario_carnet),
);

SELECT * FROM usuario;

SET IDENTITY_INSERT dbo.usuario ON
INSERT INTO usuario(usuario_carnet, usario_nombre, usuario_direccion, usuario_telefono)
VALUES
('U20171110','Alberto Manases Turcios Ortez', '17 ave. norte colonia santa monica san miguel', '+503 2661-9023'),
('U20180898','Jose Ernesto Martinez Hernandez', '27 ave. sur colonia monte carlo san miguel', '+503 2661-9896'),
('U20171809','Manuel Enrique Ortega Pinto', '18 ave. sur colonia belen san miguel', '+503 2661-5634'),
('U20191234','Jose Emilio Cruz Rosales', '8 ave. norte  colonia prado san miguel', '+503 2661-5430'),
('U20152810','Miguel Jose Gonzales Ayala', 'calle principal residencial barcelona san miguel', '+503 2661-9482'),
('U20189010','Jose Maria Pineda Alvarenga', '9 ave. norte colonia belen san miguel', '+503 2661-9846');
SET IDENTITY_INSERT dbo.libroCopia OFF

SELECT * FROM DBO.usuario;

CREATE TABLE prestamo(
    prestamo_id INT CHECK (prestamo.prestamo_id > 0) NOT NULL IDENTITY,
    usuario_carnet VARCHAR(50) NOT NULL,
    libroCopia_item VARCHAR(50) NOT NULL,
    prestamo_fecha DATE NOT NULL,
    prestamo_devolucion DATE NOT NULL,
    PRIMARY KEY(prestamo_id),
    CONSTRAINT FK_LIB_ITEM FOREIGN KEY (libroCopia_item) REFERENCES libroCopia(libroCopia_item) ON UPDATE CASCADE,
    CONSTRAINT FK_USU_CAN FOREIGN KEY (usuario_carnet) REFERENCES dbo.usuario(usuario_carnet) ON UPDATE CASCADE
);

drop table dbo.prestamo;

SET IDENTITY_INSERT dbo.prestamo ON
INSERT INTO prestamo(usuario_carnet, libroCopia_item, prestamo_fecha, prestamo_devolucion)
VALUES
('U20171110','01-117S', GETDATE(), '2021-09-20'),
('U20180898','02-117S', GETDATE(), '2021-09-21'),
('U20171809','06-789A', GETDATE(), '2021-09-23'),
('U20191234','04-789A', GETDATE(), '2021-09-20'),
('U20152810','05-789A', GETDATE(), '2021-09-15');
SET IDENTITY_INSERT dbo.prestamo OFF

SELECT * FROM dbo.prestamo;