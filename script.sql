-- creation du base de donnée

CREATE DATABASE bookify;

--creation de tablaux

CREATE TABLE departements (
    id int PRIMARY key AUTO_INCREMENT,
    nom varchar(20)
);

CREATE TABLE postes (
    id int PRIMARY KEY AUTO_INCREMENT,
    nom varchar (20)
);

CREATE table employees (
    id int PRIMARY KEY AUTO_INCREMENT,
    nom varchar(15),
    email varchar (30),
    departement_id int,
    poste_id int,
    FOREIGN KEY(departement_id) REFERENCES departements(id),
    FOREIGN KEY (poste_id) REFERENCES postes(id)
);  

CREATE TABLE salles(
    id int PRIMARY KEY AUTO_INCREMENT,
    nom varchar(20),
    capacite int ,
    departement_id int,
    FOREIGN KEY (departement_id) REFERENCES departements (id)
);

CREATE TABLE equipements( id int PRIMARY KEY AUTO_INCREMENT, nom varchar(20), type ENUM('changeable','non changeable' ) );

CREATE TABLE equipements_salles(
    equipement_id INT,
    salle_id INT,
    FOREIGN KEY(equipement_id) REFERENCES equipements(id),
    FOREIGN KEY(salle_id) REFERENCES salles(id)
);


CREATE TABLE reservations(
    id int AUTO_INCREMENT PRIMARY KEY,
    date_debut date,
    date_fin date,
    employe_id INT,
    salle_id INT,
    FOREIGN KEY(employe_id) REFERENCES employees(id),
    FOREIGN KEY(salle_id) REFERENCES salles(id)
);


CREATE TABLE equipements_reservations( 
    equipement_id INT, 
    reservation_id INT, 
    FOREIGN KEY(equipement_id) REFERENCES equipements(id), 
    FOREIGN KEY(reservation_id) REFERENCES reservations(id) 
);

--contraint d'integrité

ALTER TABLE employees
ADD CONSTRAINT unique_email UNIQUE (email);

-- insertion des données 

INSERT INTO departements (nom) VALUES ('IT'), ('HR'), ('clients service');

INSERT INTO postes (nom) VALUES ('Manager'), ('Developer'), ('Designer');

INSERT INTO employees (nom, email, departement_id, poste_id) VALUES
('Ghizlane meqdar', 'ghizlanemeqdar@gmail.com', 1, 2),
('omar ennedi', 'omar.ennedi@gmail.com', 2, 3),
('mehdi erraji', 'mehdiErraji@gmail.com', 2, 3),
('adnan roujan', 'adnanroujan@gmail.com', 2, 3);

INSERT INTO salles (nom, capacite, departement_id) VALUES
('Meeting Room', 20, 1),
('Conference Room', 30, 2);

INSERT INTO equipements (nom, type) VALUES ('Laptop', 'changeable'), ('Projector', 'non changeable');

-- affichage des données

select * from employees;
select * from reservations;

SELECT * FROM salles WHERE id =2 ;
SELECT * FROM equipements WHERE type = 'changeable';

SELECT employees.nom AS employee_name, 
departements.nom AS department_name
FROM employees
INNER JOIN departements 
ON employees.departement_id = departements.id;

SELECT reservations.id AS reservation_id, 
salles.nom AS room_name
FROM reservations
INNER JOIN salles 
ON reservations.salle_id = salles.id;

