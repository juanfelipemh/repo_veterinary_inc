CREATE DATABASE VeterinaryInc;

use VeterinaryInc;

create table person (
idPerson int primary key identity(1,1) not null,
name varchar(50) not null,
lastname varchar(50) not null,
email varchar(100) not null,
phone bigint not null,
address varchar(100) not null,
confirmed bit default 1
);

create table pet (
idPet int primary key identity(1,1) not null,
name varchar(50) not null,
age int not null,
idPerson int foreign key references Person(idPerson)
);

create table service (
idService int primary key identity(1,1) not null,
description varchar(150) not null,
cost int not null
);

create table pet_service (
idPetService int primary key identity(1,1) not null,
idPet int foreign key references Pet(idPet),
idService int foreign key references Service(idService),
serviceDate date not null
);


-- BD REGISTER --
INSERT INTO person 
VALUES ('Felipe','Muñoz','felipe@gmail.com',3196284085,'Calle 70a #42-17',1),
('Aleja','Sierra','aleja@gmail.com',6258469512,'Calle 50a #80-07',1),
('Melanni','Rodriguez','melanni@gmail.com',46128745315,'Cra 8 #07-17',0);

INSERT INTO service 
VALUES ('Baño', 25000), ('Peluqueria', 50000), ('Revision medica', 70000),('Radiografia',250000);

INSERT INTO pet
VALUES ('Dulce',5,1), ('Pedro',1,2), ('Sisy',1,2), ('Coco',1,3), ('Chorizo',3,2),
('Minigato1',1,1), ('Minigato2',1,2), ('Peluso',4,3), ('Pelusin',4,1), 
('Madrita',3,3), ('Tia negrita',3,3), ('Madrita 2',2,1);

INSERT INTO pet_service
VALUES (1,1,'2023-01-05'), (1,3,'2023-01-05'), (3,2,'2023-01-05'), (3,1,'2023-01-12'), (1,4,'2023-01-12'), (4,2,'2023-01-16'), 
(6,1,'2023-01-18'), (6,3,'2023-01-20'), (8,1,'2023-01-21'), (8,2,'2023-01-21'), (9,3,'2023-01-21'), (9,4,'2023-01-21');


-- STORED PROCEDURES--
CREATE PROCEDURE calculateAllTotalCosts
AS
BEGIN
SELECT description, SUM(cost) AS totalByService
FROM service AS s, pet_service AS ps
WHERE s.idService = ps.idService
GROUP BY s.description
ORDER BY s.description
END

CREATE PROCEDURE serviceDetails
AS
BEGIN
SELECT ps.idPetService, ps.serviceDate, p.idPet, p.name, s.description, s.cost, pr.idPerson, pr.name, pr.lastname, pr.phone
FROM pet_service as ps
INNER JOIN pet as p
ON ps.idPet = p.idPet
INNER JOIN service as s
ON ps.idService = s.idService
INNER JOIN person AS pr
ON p.idPerson = pr.idPerson
ORDER BY idPetService
END

CREATE PROCEDURE getPersonInformationById (@idPerson int)
AS
BEGIN
SELECT p.idPerson, p.name, p.lastname, pt.idPet, pt.name
FROM pet AS pt
INNER JOIN person AS p
ON pt.idPerson = p.idPerson
WHERE p.idPerson = @idPerson
ORDER BY pt.idPet
END

CREATE PROCEDURE ownersOfPets
AS
BEGIN
SELECT p.idPerson, p.name, p.lastname, pt.idPet, pt.name
FROM pet AS pt
INNER JOIN person AS p
ON pt.idPerson = p.idPerson
ORDER BY p.idPerson
END

CREATE PROCEDURE costsPerDate (@serviceDate date)
AS
BEGIN
SELECT description, SUM(cost) AS totalService
FROM service AS s
INNER JOIN pet_service AS ps 
ON s.idService = ps.idService
WHERE serviceDate = @serviceDate
GROUP BY s.description
ORDER BY s.description
END