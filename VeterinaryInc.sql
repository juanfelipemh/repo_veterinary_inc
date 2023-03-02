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
FROM service, pet_service
WHERE service.idService = pet_service.idService
GROUP BY service.description
ORDER BY service.description
END

CREATE PROCEDURE serviceDetails
AS
BEGIN
SELECT pet_service.idPetService, pet_service.serviceDate, pet.idPet, pet.name, service.description, service.cost, person.idPerson, person.name, person.lastname, person.phone
FROM pet_service
INNER JOIN pet
ON pet_service.idPet = pet.idPet
INNER JOIN service
ON pet_service.idService = service.idService
INNER JOIN person
ON pet.idPerson = person.idPerson
ORDER BY idPetService
END

CREATE PROCEDURE getPersonInformationById (@idPerson int)
AS
BEGIN
SELECT person.idPerson, person.name, person.lastname, pet.idPet, pet.name
FROM pet
INNER JOIN person
ON pet.idPerson = person.idPerson
WHERE person.idPerson = @idPerson
ORDER BY pet.idPet
END

CREATE PROCEDURE getAllInformationsOwners
AS
BEGIN
SELECT person.idPerson, person.name, person.lastname, pet.idPet, pet.name
FROM pet
INNER JOIN person
ON pet.idPerson = person.idPerson
ORDER BY person.idPerson
END

CREATE PROCEDURE costsPerDate (@serviceDate date)
AS
BEGIN
SELECT service.description, SUM(cost) AS totalService
FROM service, pet_service
WHERE service.idService = pet_service.idService AND serviceDate = @serviceDate
GROUP BY service.description
ORDER BY service.description
END