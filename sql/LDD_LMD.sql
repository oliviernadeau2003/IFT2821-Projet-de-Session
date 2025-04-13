-- Olivier Nadeau, Yonah Lahlou, Ahmadou Ayande, ...
-- Definition de la base en LDD et LMD de SQL server/ORACLE

CREATE DATABASE Projet_Centre_Aide;
USE Projet_Centre_Aide;

-- Creation des tables :

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


-- Insertion des donnees :
-- Insertion des donnees:

-- Insertion des secteurs
INSERT INTO Secteur (id, nom) VALUES (1, 'Centre-Ville');
INSERT INTO Secteur (id, nom) VALUES (2, 'Quartier Nord');
INSERT INTO Secteur (id, nom) VALUES (3, 'Quartier Sud');
INSERT INTO Secteur (id, nom) VALUES (4, 'Banlieue Est');
INSERT INTO Secteur (id, nom) VALUES (5, 'Banlieue Ouest');
INSERT INTO Secteur (id, nom) VALUES (6, 'Vieux-Port');
INSERT INTO Secteur (id, nom) VALUES (7, 'Zone Industrielle');
INSERT INTO Secteur (id, nom) VALUES (8, 'Campus Universitaire');
INSERT INTO Secteur (id, nom) VALUES (9, 'District Financier');
INSERT INTO Secteur (id, nom) VALUES (10, 'Zone Commerciale');

-- Insertion des benevoles
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (1, 'Martin', 'Julie', '4381234567', 'julie.martin@email.com', '890 Rue des Fleurs', 1, 2);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (2, 'Bouchard', 'Michel', '4382345678', 'michel.bouchard@email.com', '123 Avenue des Pins', 1, 1);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (3, 'Cote', 'Caroline', '4383456789', 'caroline.cote@email.com', '456 Boulevard des Erables', 0, 3);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (4, 'Gauthier', 'Philippe', '4384567890', 'philippe.gauthier@email.com', '789 Rue du Lac', 1, 4);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (5, 'Bergeron', 'Sylvie', '4385678901', 'sylvie.bergeron@email.com', '234 Avenue du Mont', 0, 5);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (6, 'Tremblay', 'Richard', '4386789012', 'richard.tremblay@email.com', '567 Rue Principale', 1, 6);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (7, 'Lavoie', 'Nathalie', '4387890123', 'nathalie.lavoie@email.com', '890 Avenue Centrale', 0, 7);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (8, 'Gagnon', 'Robert', '4388901234', 'robert.gagnon@email.com', '123 Rue des Ormes', 1, 8);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (9, 'Morin', 'Christine', '4389012345', 'christine.morin@email.com', '456 Avenue du Parc', 0, 9);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (10, 'Fortin', 'Jean', '4380123456', 'jean.fortin@email.com', '789 Boulevard Principal', 1, 10);

-- Insertion des equipes
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe)
VALUES (1, 1, 1, 2, 1, 'preformee');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe)
VALUES (2, 1, 3, 4, 2, 'preformee');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe)
VALUES (3, 0, 5, NULL, 3, 'a_constituer');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe)
VALUES (4, 1, 2, 5, 4, 'preformee');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe)
VALUES (5, 0, 4, NULL, 5, 'a_constituer');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe)
VALUES (6, 1, 6, 7, 6, 'preformee');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe)
VALUES (7, 1, 8, 9, 7, 'preformee');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe)
VALUES (8, 0, 10, NULL, 8, 'a_constituer');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe)
VALUES (9, 1, 3, 8, 9, 'preformee');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe)
VALUES (10, 0, 7, NULL, 10, 'a_constituer');

-- Note: Les usagers vont etre ajoutes avec la procedure T-SQL et le script ajout_usagers.py
