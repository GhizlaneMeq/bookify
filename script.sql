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