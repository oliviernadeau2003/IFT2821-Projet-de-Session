-- Olivier Nadeau, Yonah Lahlou, Ahmadou Ayande, ...
-- Definition de la base en LDD et LMD de SQL server/ORACLE

CREATE DATABASE Projet_Centre_Aide;
USE Projet_Centre_Aide;

-- Création des tables :

DROP TABLE IF EXISTS Plainte;
DROP TABLE IF EXISTS Intervention;
DROP TABLE IF EXISTS Unite;
DROP TABLE IF EXISTS Usager;
DROP TABLE IF EXISTS Benevole;
DROP TABLE IF EXISTS Secteur;


CREATE TABLE Secteur(
    id INT,
    nom VARCHAR(50) NOT NULL,
    CONSTRAINT pk_id_secteur PRIMARY KEY (id)
);


CREATE TABLE Usager(
    id INT,
    nom VARCHAR(25) NOT NULL,
    prenom VARCHAR(25) NOT NULL,
    telephone VARCHAR(10) NOT NULL,
    courriel VARCHAR(50) NOT NULL CHECK (courriel LIKE '_%@_%._%'),
    adresse VARCHAR(50) NOT NULL,
    id_secteur INT,
    CONSTRAINT pk_usager_id PRIMARY KEY (id),
    CONSTRAINT fk_usager_id_secteur FOREIGN KEY (id_secteur) REFERENCES Secteur(id)
);


CREATE TABLE Benevole(
    id INT,
    nom VARCHAR(25) NOT NULL,
    prenom VARCHAR(25) NOT NULL,
    telephone VARCHAR(10) NOT NULL CHECK (LEN(telephone) = 10 AND telephone NOT LIKE '%[^0-9]%'),
    courriel VARCHAR(50) NOT NULL CHECK (courriel LIKE '_%@_%._%'),
    adresse VARCHAR(50) NOT NULL,
    possede_voiture BIT NOT NULL,
    id_secteur INT,
    CONSTRAINT pk_benevole_id PRIMARY KEY (id),
    CONSTRAINT fk_benevole_id_secteur FOREIGN KEY (id_secteur) REFERENCES Secteur(id)
);


CREATE TABLE Equipe(
    id INT,
    est_disponible BIT NOT NULL,
    id_benevole_1 INT NOT NULL,
    id_benevole_2 INT, 
    id_secteur INT NOT NULL,
    type_equipe VARCHAR(20) NOT NULL CHECK (type_equipe IN ('preformee', 'a_constituer')),
    CONSTRAINT pk_equipe_id PRIMARY KEY (id),
    CONSTRAINT fk_equipe_id_benevole_1 FOREIGN KEY (id_benevole_1) REFERENCES Benevole(id),
    CONSTRAINT fk_equipe_id_benevole_2 FOREIGN KEY (id_benevole_2) REFERENCES Benevole(id),
    CONSTRAINT fk_equipe_id_secteur FOREIGN KEY (id_secteur) REFERENCES Secteur(id)
);


CREATE TABLE Intervention(
    id INT,
    date_demande DATETIME NOT NULL,
    date_intervention DATETIME NOT NULL,
    type_aide VARCHAR(50) NOT NULL,
    status VARCHAR(50) NOT NULL,
    duree INT NULL,
    id_usager INT,
    id_equipe INT,
    id_secteur INT,
    CONSTRAINT pk_intervention_id PRIMARY KEY (id),
    CONSTRAINT fk_intervention_id_usager FOREIGN KEY (id_usager) REFERENCES Usager(id),
    CONSTRAINT fk_intervention_id_equipe FOREIGN KEY (id_equipe) REFERENCES Equipe(id),
    CONSTRAINT fk_intervention_id_secteur FOREIGN KEY (id_secteur) REFERENCES Secteur(id),
    CONSTRAINT CHK_Status CHECK (status IN ('Pas encore commence', 'En cours', 'Termine', 'Annule'))
);

CREATE TABLE Plainte(
    id INT,
    type VARCHAR(50) NOT NULL,
    description VARCHAR(MAX),
    date_signalement DATETIME DEFAULT GETDATE() NOT NULL,
    statut VARCHAR(20) DEFAULT 'Ouvert' NOT NULL,
    date_resolution DATETIME NULL,
    resolution VARCHAR(MAX) NULL,
    id_intervention INT,
    CONSTRAINT pk_plainte_id PRIMARY KEY (id),
    CONSTRAINT fk_plainte_id_intervention FOREIGN KEY (id_intervention) REFERENCES Intervention(id),
    CONSTRAINT CHK_Statut_Plainte CHECK (statut IN ('Ouvert', 'En traitement', 'Resolu', 'Ferme'))
);


-- Insertion des données : 


