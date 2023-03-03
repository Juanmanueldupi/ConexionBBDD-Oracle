CREATE TABLE Pais
(
NumCorrelativo_Pais INT,
Nombre_Pais VARCHAR2(60),
NumClubs INT,
NumParticipantes INT DEFAULT 10,
CONSTRAINT PK_Pais PRIMARY KEY(NumCorrelativo_Pais),
CONSTRAINT NumClubs CHECK (NumClubs BETWEEN 0 AND 50),
CONSTRAINT NumParticipantes CHECK (NumParticipantes > 0 AND NumParticipantes <= 50)
);

ALTER TABLE Pais ADD CONSTRAINT Nombre_Pais CHECK (REGEXP_LIKE (Nombre_Pais, '^[A-Z][a-z]*','c')); 

CREATE TABLE Participantes
(
NumAsociado INT PRIMARY KEY,
NumCorrelativo_Pais INT,
Nombre VARCHAR2(60) UNIQUE,
Telefono VARCHAR2(15),
Direccion VARCHAR2(60) NOT NULL,
FOREIGN KEY (NumCorrelativo_Pais) REFERENCES Pais(NumCorrelativo_Pais),
CONSTRAINT Telefono CHECK (REGEXP_LIKE (Telefono,'^\+[0-9]{4}[0-9]{8}')) 
);

CREATE TABLE Alojamiento
(
Fecha_Alojamiento DATE,
NumAsociado INT,
Codigo_Hotel INT,
CONSTRAINT PK_Alojamiento PRIMARY KEY(Fecha_Alojamiento,NumAsociado,Codigo_Hotel),
CONSTRAINT F_Alojamiento CHECK (to_char(Fecha_Alojamiento,'YYYY') > 2020),
CONSTRAINT NumAsociado_check CHECK (NumAsociado > 0),
CONSTRAINT Codigo_Hotel_check_alojamiento CHECK (Codigo_Hotel >= 1)
);

INSERT INTO Pais (NumCorrelativo_Pais,Nombre_Pais,NumClubs,NumParticipantes) VALUES (1, 'marruecos', 9, 11);
INSERT INTO Pais (NumCorrelativo_Pais,Nombre_Pais,NumClubs,NumParticipantes) VALUES (1, 'Marruecos', 9, 11);
INSERT INTO Pais (NumCorrelativo_Pais,Nombre_Pais,NumClubs,NumParticipantes) VALUES (2, 'España', 15, 30);
INSERT INTO Pais (NumCorrelativo_Pais,Nombre_Pais,NumClubs,NumParticipantes) VALUES (3, 'Peru', 4, 9);
INSERT INTO Pais (NumCorrelativo_Pais,Nombre_Pais,NumClubs,NumParticipantes) VALUES (4, 'Portugal', 14, 33);
INSERT INTO Pais (NumCorrelativo_Pais,Nombre_Pais,NumClubs,NumParticipantes) VALUES (5, 'Francia', 11, 35);
INSERT INTO Pais (NumCorrelativo_Pais,Nombre_Pais,NumClubs,NumParticipantes) VALUES (6, 'Mexico', 11, 35);
INSERT INTO Pais (NumCorrelativo_Pais,Nombre_Pais,NumClubs,NumParticipantes) VALUES (7, 'Guatemala', 2, 6);


INSERT INTO Participantes (NumAsociado,NumCorrelativo_Pais,Nombre,Telefono,Direccion) VALUES (1, 1, 'Moha Aoui', '1234656789876','C/Mezquita 3 2A 23432 Casa Blanca' );
INSERT INTO Participantes (NumAsociado,NumCorrelativo_Pais,Nombre,Telefono,Direccion) VALUES (1, 1, 'Moha Aoui', '+123465678987','C/Mezquita 3 2A 23432 Casa Blanca' );
INSERT INTO Participantes (NumAsociado,NumCorrelativo_Pais,Nombre,Telefono,Direccion) VALUES (2, 2, 'Pepe Perez', '+34678654543','');
INSERT INTO Participantes (NumAsociado,NumCorrelativo_Pais,Nombre,Telefono,Direccion) VALUES (2, 2, 'Pepe Perez', '+346786545435','C/Fresa 5 2A 42934 Madrid' );
INSERT INTO Participantes (NumAsociado,NumCorrelativo_Pais,Nombre,Telefono,Direccion) VALUES (3, 2, 'Maria Mora', '+534654365477','C/Puerro 1 4 64626 Caceres' );
INSERT INTO Participantes (NumAsociado,NumCorrelativo_Pais,Nombre,Telefono,Direccion) VALUES (4, 2, 'Angel Torres', '+346893648595','C/Atayalpo 26 41089 Sevilla' );



INSERT INTO Alojamiento (Fecha_Alojamiento,NumAsociado,Codigo_Hotel) VALUES (to_date('2015/7/15','YYYY/MM/DD'), 3, 1);
INSERT INTO Alojamiento (Fecha_Alojamiento,NumAsociado,Codigo_Hotel) VALUES (to_date('2021/7/15','YYYY/MM/DD'), 3, 0);
INSERT INTO Alojamiento (Fecha_Alojamiento,NumAsociado,Codigo_Hotel) VALUES (to_date('2021/7/15','YYYY/MM/DD'), 3, 1);
