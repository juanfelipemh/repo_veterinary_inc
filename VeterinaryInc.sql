CREATE DATABASE VeterinaryInc;

use VeterinaryInc;

create table person (
idd_person int primary key identity(1,1) not null,
name varchar(50) not null,
lastname varchar(50) not null,
email varchar(100) not null,
phone bigint not null,
address varchar(100) not null,
confirmed bit default 1
);

create table pet (
id_pet int primary key identity(1,1) not null,
name varchar(50) not null,
age int not null,
id_person int foreign key references person(id_person)
);

create table service (
id_service int primary key identity(1,1) not null,
description varchar(150) not null,
cost int not null
);

create table pet_service (
id_pet_service int primary key identity(1,1) not null,
id_pet int foreign key references pet(id_pet),
id_service int foreign key references Service(id_service),
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
SELECT description, SUM(cost) AS totalBilledByService
FROM service, pet_service
WHERE service.id_service = pet_service.id_service
GROUP BY service.description
ORDER BY service.description
END

CREATE PROCEDURE serviceDetails
AS
BEGIN
SELECT pet_service.id_pet_service, pet_service.serviceDate, pet.id_pet AS IdPet, pet.name AS petName, service.description AS ServiceDescription, service.cost AS ServiceCost, person.id_person, person.name AS personName, person.lastname AS personLastName, person.phone as phoneNumber
FROM pet_service
INNER JOIN pet
ON pet_service.id_pet = pet.id_pet
INNER JOIN service
ON pet_service.id_service = service.id_service
INNER JOIN person
ON pet.id_person = person.id_person
ORDER BY id_pet_service
END

CREATE PROCEDURE getPersonInformationById (@id_person int)
AS
BEGIN
SELECT person.id_person, person.name as personName, person.lastname AS personLastName, pet.id_pet, pet.name AS petName
FROM pet
INNER JOIN person
ON pet.id_person = person.id_person
WHERE person.id_person = @id_person
ORDER BY pet.id_pet
END

CREATE PROCEDURE getAllInformationsOwners
AS
BEGIN
SELECT person.id_person, person.name AS personName, person.lastname AS personLastName, pet.id_pet, pet.name AS petName
FROM pet
INNER JOIN person
ON pet.id_person = person.id_person
ORDER BY person.id_person
END

CREATE PROCEDURE costsPerDate (@serviceDate date)
AS
BEGIN
SELECT service.description, SUM(cost) AS totalByService
FROM service, pet_service
WHERE service.id_service = pet_service.id_service AND serviceDate = @serviceDate
GROUP BY service.description
ORDER BY service.description
END


-- INFORMATION AND STORED PROCEDURES IMPLEMENTED IN BACKEND_ARCHITECTURE --
INSERT INTO person 
VALUES ('Calle 70a #42-17',1,'felipe@gmail.com','Muñoz','Felipe',319628085),
('Calle 50a #42-17',1,'aleja@gmail.com','Sierra','Aleja',54846543),
('Cra 96 #42-17',0,'pitero@gmail.com','El gato','Pitero',84543543);


CREATE PROCEDURE getPersonInformation
AS
BEGIN
SELECT * FROM person
END

CREATE PROCEDURE addPerson(@address varchar(255), @confirmed bit, @email varchar(255), @lastname varchar(255), @name varchar(255), @phone bigint)
AS
INSERT INTO person
VALUES (@address, @confirmed, @email, @lastname, @name, @phone)
GO