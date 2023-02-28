CREATE DATABASE VeterinaryInc;

use VeterinaryInc;

create table Person (
idPerson int primary key identity(1,1) not null,
name varchar(50) not null,
lastname varchar(50) not null,
email varchar(100) not null,
phone bigint not null,
address varchar(100) not null,
token varchar(255),
confirmed bit default 1
);

create table Pet (
idPet int primary key identity(1,1) not null,
name varchar(50) not null,
age int not null,
idPerson int foreign key references Person(idPerson)
);

create table Service (
idService int primary key identity(1,1) not null,
description varchar(150) not null,
cost int not null
);

create table Pet_Service (
id_Pet_Service int primary key identity(1,1) not null,
idPet int foreign key references Pet(idPet),
idService int foreign key references Service(idService),
serviceDate date not null
);


-- BD REGISTROS --

INSERT INTO Person 
VALUES ('Felipe','Muñoz','felipe@gmail.com',3196284085,'Calle 70a #42-17',123123,1),
('Aleja','Sierra','aleja@gmail.com',6258469512,'Calle 50a #80-07',8453545,1),
('Melanni','Rodriguez','melanni@gmail.com',46128745315,'Cra 8 #07-17',9845784,1);

INSERT INTO Service 
VALUES ('Baño', 25000), ('Peluqueria', 50000), ('Revision medica', 70000),('Radiografia',250000);

INSERT INTO Pet
VALUES ('Dulce',5,1), ('Pedro',1,2), ('Sisy',1,2), ('Coco',1,3), ('Chorizo',3,2),
('Minigato1',1,1), ('Minigato2',1,2), ('Peluso',4,3), ('Pelusin',4,1), 
('Madrita',3,3), ('Tia negrita',3,3), ('Madrita 2',2,1);

INSERT INTO Pet_Service
VALUES (1,1,'2023-01-05'), (1,3,'2023-01-05'), (3,2,'2023-01-05'), (3,1,'2023-01-12'), (1,4,'2023-01-12'), (4,2,'2023-01-16'), 
(6,1,'2023-01-18'), (6,3,'2023-01-20'), (8,1,'2023-01-21'), (8,2,'2023-01-21'), (9,3,'2023-01-21'), (9,4,'2023-01-21');



-- STORED PROCEDURES--
CREATE PROCEDURE calculateTotalCosts
AS
BEGIN
SELECT description, SUM(cost) AS TotalService
FROM Service AS S
INNER JOIN Pet_Service AS PS ON S.idService = PS.idService
GROUP BY S.description
ORDER BY S.description
END

CREATE PROCEDURE serviceDetails 
AS
BEGIN
SELECT *
FROM Pet_Service as PS
INNER JOIN Pet as P ON PS.idPet = P.idPet
INNER JOIN Service as S ON PS.idService = S.idService
ORDER BY id_Pet_Service
END

CREATE PROCEDURE ownerId (@idPerson int)
AS
BEGIN
SELECT P.idPerson, P.name, P.lastname, PT.idPet, PT.name
FROM Pet AS PT
INNER JOIN Person AS P
ON PT.idPerson = P.idPerson
WHERE P.idPerson = @idPerson
ORDER BY PT.idPet
END

CREATE PROCEDURE owners
AS
BEGIN
SELECT P.idPerson, P.name, P.lastname, PT.idPet, PT.name
FROM PET AS PT
INNER JOIN Person AS P 
ON PT.idPerson = P.idPerson
ORDER BY P.idPerson
END

CREATE PROCEDURE costPerDate (@serviceDate date)
AS
BEGIN
  SELECT description, SUM(cost) AS TotalService
  FROM Service AS S
  INNER JOIN Pet_Service AS PS ON S.idService = PS.idService
  WHERE serviceDate = @serviceDate
  GROUP BY S.description
  ORDER BY S.description
END