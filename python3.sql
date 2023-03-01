--Identificado como administrador en MariaDB

CREATE DATABASE Python3;

CREATE USER 'juanmad'@'%' IDENTIFIED BY 'juanmad';
GRANT ALL PRIVILEGES ON Python3.* TO 'juanmad'@'%';
FLUSH PRIVILEGES;

exit

mysql -u juanmad --password=juanmad

USE Python3

CREATE TABLE Pais
(
NumCorrelativo_Pais INT,
Nombre_Pais VARCHAR(60),
NumClubs INT,
NumParticipantes INT DEFAULT 10,
CONSTRAINT PK_Pais PRIMARY KEY(NumCorrelativo_Pais),
CONSTRAINT Nombre_Pais CHECK ( Nombre_Pais REGEXP BINARY '^[A-Z][a-z]'),
CONSTRAINT NumClubs CHECK (NumClubs BETWEEN 0 AND 50),
CONSTRAINT NumParticipantes CHECK (NumParticipantes > 0 AND NumParticipantes <= 50)
);

CREATE TABLE Participantes
(
NumAsociado INT PRIMARY KEY,
NumCorrelativo_Pais INT,
Nombre VARCHAR(60) UNIQUE,
Telefono VARCHAR(15),
Direccion VARCHAR(60) NOT NULL,
FOREIGN KEY (NumCorrelativo_Pais) REFERENCES Pais(NumCorrelativo_Pais)
);


CREATE TABLE Alojamiento
(
Fecha_Alojamiento DATE,
NumAsociado INT,
Codigo_Hotel INT,
CONSTRAINT PK_Alojamiento PRIMARY KEY(Fecha_Alojamiento,NumAsociado,Codigo_Hotel),
CONSTRAINT fk_Alojamiento FOREIGN KEY (NumAsociado) REFERENCES Participantes(NumAsociado),
CONSTRAINT NumAsociado_check CHECK (NumAsociado > 0),
CONSTRAINT Codigo_Hotel_check_alojamiento CHECK (Codigo_Hotel > 0)
);


INSERT INTO Pais (NumCorrelativo_Pais,Nombre_Pais,NumClubs,NumParticipantes) VALUES (1, 'Marruecos', 9, 11);
INSERT INTO Pais (NumCorrelativo_Pais,Nombre_Pais,NumClubs,NumParticipantes) VALUES (2, 'España', 15, 30);
INSERT INTO Pais (NumCorrelativo_Pais,Nombre_Pais,NumClubs,NumParticipantes) VALUES (3, 'Peru', 4, 9);
INSERT INTO Pais (NumCorrelativo_Pais,Nombre_Pais,NumClubs,NumParticipantes) VALUES (4, 'Portugal', 14, 33);
INSERT INTO Pais (NumCorrelativo_Pais,Nombre_Pais,NumClubs,NumParticipantes) VALUES (5, 'Francia', 11, 35);
INSERT INTO Pais (NumCorrelativo_Pais,Nombre_Pais,NumClubs,NumParticipantes) VALUES (6, 'Mexico', 11, 35);
INSERT INTO Pais (NumCorrelativo_Pais,Nombre_Pais,NumClubs,NumParticipantes) VALUES (7, 'Guatemala', 2, 6);

INSERT INTO Participantes (NumAsociado,NumCorrelativo_Pais,Nombre,Telefono,Direccion) VALUES (1, 1, 'Moha Aoui', '+1234656789876','C/Mezquita 3 2A 23432 Casa Blanca' );
INSERT INTO Participantes (NumAsociado,NumCorrelativo_Pais,Nombre,Telefono,Direccion) VALUES (2, 2, 'Pepe Perez', '+34678654543','C/Fresa 5 2A 42934 Madrid' );
INSERT INTO Participantes (NumAsociado,NumCorrelativo_Pais,Nombre,Telefono,Direccion) VALUES (3, 4, 'Maria Mora', '+34654365477','C/Puerro 1 4 64626 Caceres' );
INSERT INTO Participantes (NumAsociado,NumCorrelativo_Pais,Nombre,Telefono,Direccion) VALUES (4, 2, 'Angel Torres', '+34689364859','C/Atayalpo 26 41089 Sevilla' );

INSERT INTO Alojamiento (Fecha_Alojamiento,NumAsociado,Codigo_Hotel) VALUES ('2022-03-2', 3, 1);

commit;


Necesitamos saber los datos de los participantes según su país de origen, pide por teclado la inicial de un País y muestra el nombre y NumAsociado del participante, si hay varios paises indica el nombre del pais.

Corrupción en el torneo, tras descubrise varios casos de corruptelas los jugadores eliminados afectados vuelven al torneo, Introducido el nombre de un participante por pantalla actualiza la fecha del Alojamiento del mismo.


Para obtener la información de los participantes y cuántos países representan, podemos usar la cláusula GROUP BY para agrupar los participantes por país y contar el número de países diferentes representados. La consulta sería la siguiente:

SELECT P.Nombre, COUNT(DISTINCT PA.NumCorrelativo_Pais) AS 'Paises Representados'
FROM Participantes P
INNER JOIN Pais PA ON P.NumCorrelativo_Pais = PA.NumCorrelativo_Pais
GROUP BY P.Nombre;

Para listar los participantes en la competición con toda su información, podemos usar la siguiente consulta:

SELECT P.NumAsociado, P.Nombre, P.Telefono, P.Direccion, PA.Nombre_Pais, A.Fecha_Alojamiento, A.Codigo_Hotel
FROM Participantes P
INNER JOIN Pais PA ON P.NumCorrelativo_Pais = PA.NumCorrelativo_Pais
LEFT JOIN Alojamiento A ON P.NumAsociado = A.NumAsociado
ORDER BY PA.Nombre_Pais, P.Nombre;

Para contar cuántos países están representados, podemos agregar la cláusula COUNT(DISTINCT) a la primera consulta:

SELECT COUNT(DISTINCT PA.NumCorrelativo_Pais) AS 'Paises Representados'
FROM Participantes P
INNER JOIN Pais PA ON P.NumCorrelativo_Pais = PA.NumCorrelativo_Pais;