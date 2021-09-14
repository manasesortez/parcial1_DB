CREATE DATABASE Ejercicio2_u20171110;

USE Ejercicio2_u20171110;

CREATE TABLE estudiantes(
    estudiantes_id INT CHECK (estudiantes_id > 0) NOT NULL IDENTITY,
    estudiantes_nombre VARCHAR(25) NOT NULL,
    estudiantes_apellidos VARCHAR(25) NOT NULL,
    estudiantes_direccion VARCHAR(50) NOT NULL,
    estudiantes_telefono VARCHAR(9) UNIQUE NOT NULL,
    PRIMARY KEY(estudiantes_id)
);

SET IDENTITY_INSERT dbo.estudiantes ON
INSERT INTO dbo.estudiantes
(estudiantes_nombre, estudiantes_apellidos, estudiantes_direccion, estudiantes_telefono)
VALUES
('Predo Alberto', 'Castro Martinez', 'Colonia Villa Hermosa', '2589-7954'),
('Julia Maria', 'Castaneda', 'Urbanizacion SuCasa', '2226-8958'),
('Edilberto', 'Mejia Castro', 'Colonis 5 de Novienbre', '2296-7415'),
('Karla Lisett', 'Perez Sanchez', '37 calle oriente colonia belgica', '7895-7547'),
('Saul Antonio', 'Bonill', 'Colonia El Mirador', '2369-9814'),
('Marcel Alejandra','Hernandez','Urbanizacion Loma Linda','2154-5285');
SET IDENTITY_INSERT dbo.estudiantes OFF

SELECT * FROM estudiantes;

CREATE TABLE materia(
    materia_id INT CHECK (materia_id > 0) NOT NULL IDENTITY(111,1),
    materia_nombre VARCHAR(30) CHECK (materia_nombre IN ('Introduccion a la Programacion','Redes de Area Local','Base de Datos','Matematica I', 'Expresion Oral y Escrita')) UNIQUE NOT NULL,
    PRIMARY KEY (materia_id)
);


SET IDENTITY_INSERT dbo.materia ON
INSERT INTO dbo.materia
(materia_nombre)
VALUES
('Introduccion a la Programacion'),
('Redes de Area Local'),
('Base de Datos'),
('Matematica I'),
('Expresion Oral y Escrita');
SET IDENTITY_INSERT dbo.materia OFF

SELECT  * FROM materia;

CREATE TABLE notas(
    notas_id INT CHECK (notas.notas_id > 0) NOT NULL IDENTITY,
    estudiantes_id INT NOT NULL,
    materia_id INT NOT NULL,
    notas_nota DECIMAL(10,2) CHECK (notas.notas_nota between 0 and  10)NOT NULL,
    PRIMARY KEY (notas_id),
    CONSTRAINT FK_EST_ID FOREIGN KEY (estudiantes_id) REFERENCES estudiantes(estudiantes_id) ON UPDATE CASCADE,
    CONSTRAINT FK_MAT_ID FOREIGN KEY (materia_id) REFERENCES materia(materia_id) ON UPDATE CASCADE
);

DROP TABLE notas;
SELECT * FROM notas;


SET IDENTITY_INSERT dbo.notas ON
INSERT INTO dbo.notas
(estudiantes_id, materia_id, notas_nota)
VALUES
(1, 111, 7),
(1, 112, 6.0),
(1, 113, 4),
(2, 111, 6),
(2, 113, 10),
(2, 112, 8.0),
(3, 112, 7.5),
(3, 111, 5.5),
(4, 113, 9.5),
(5, 111, 8.75),
(6, 111, 5.25);
SET IDENTITY_INSERT dbo.notas OFF

SELECT * FROM notas;