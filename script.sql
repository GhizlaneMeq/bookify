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

INSERT INTO departements (nom) VALUES ('IT'), ('HR'), ('clients service'),('Marketing'),('Comptabilité');

INSERT INTO postes (nom) VALUES ('Manager'), ('Developer'), ('Designer');

INSERT INTO employees (nom, email, departement_id, poste_id) VALUES
('Ghizlane meqdar', 'ghizlanemeqdar@gmail.com', 1, 2),
('omar ennedi', 'omar.ennedi@gmail.com', 2, 3),
('mehdi erraji', 'mehdiErraji@gmail.com', 2, 3),
('adnan roujan', 'adnanroujan@gmail.com', 2, 3);

INSERT INTO salles (nom, capacite, departement_id) VALUES
('Meeting Room', 20, 1),
('Conference Room', 30, 2),
('Breaking code', 30, 1),
('Agora', 140, 3);

INSERT INTO equipements (nom, type) VALUES 
('Laptop', 'changeable'), 
('Projector', 'non changeable'),
('remote', 'changeable'),
('Table', 'non changeable'),
('HDMI', 'non changeable'),
('chaise','non changeable');

INSERT INTO reservations (date_debut, date_fin, employe_id, salle_id)
VALUES ('2023-11-20','2023-11-20',1,2),
('2023-11-21','2023-11-21',2,4),
('2023-12-22','2023-12-22',3,4),
('2023-11-23','2023-11-23',4,1),
('2024-01-01','2024-01-01',2,3);

-- affichage des données

select * from employees;
select * from reservations;

SELECT * FROM salles WHERE id =2 ;
SELECT * FROM employees LIMIT 2;
SELECT * FROM equipements WHERE type = 'changeable';
SELECT * FROM employees WHERE nom LIKE 'g%';
SELECT * FROM equipements WHERE nom IN ('Table', 'Laptop');

SELECT nom FROM salles WHERE capacite BETWEEN 20 AND 80;

SELECT SUM(capacite) FROM salles ;

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

SELECT * FROM reservations
WHERE date_debut BETWEEN '2023-11-21' AND '2023-11-24';

SELECT
    employees.id AS employee_id,
    employees.nom AS employee_name,
    COUNT(reservations.id) AS total_reservations
FROM employees
JOIN reservations ON employees.id = reservations.employe_id
GROUP BY employees.id
HAVING total_reservations > 1
ORDER BY total_reservations
DESC
    ;



-- modifier les donnée
UPDATE departements SET nom = 'Information Technology' WHERE id = 1;

UPDATE employees SET email = 'meq.ghizlane@example.com' WHERE id = 1;

ALTER TABLE employees
add COLUMN age int ;


