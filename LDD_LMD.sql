-- Olivier Nadeau, Yonah Lahlou, Ahmadou Ayande, ...
-- Définition de la base en LDD et LMD de SQL server/ORACLE

CREATE DATABASE Projet_Session_Centre_Aide;
USE Projet_Session_Centre_Aide;

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
    telephone VARCHAR(10) NOT NULL CHECK (LEN(telephone) = 10 AND telephone NOT LIKE '%[^0-9]%'),
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
    id_secteur INT NOT NULL,
    CONSTRAINT pk_benevole_id PRIMARY KEY (id),
    CONSTRAINT fk_benevole_id_secteur FOREIGN KEY (id_secteur) REFERENCES Secteur(id)
);

CREATE TABLE Unite(
    id INT,
    disponible BIT NOT NULL,
    id_benevole_1 INT NOT NULL,
    id_benevole_2 INT,
    id_secteur INT NOT NULL,
    CONSTRAINT pk_unite_id PRIMARY KEY (id),
    CONSTRAINT fk_unite_id_benevole_1 FOREIGN KEY (id_benevole_1) REFERENCES Benevole(id),
    CONSTRAINT fk_unite_id_benevole_2 FOREIGN KEY (id_benevole_2) REFERENCES Benevole(id),
    CONSTRAINT fk_unite_id_secteur FOREIGN KEY (id_secteur) REFERENCES Secteur(id)
);

CREATE TABLE Intervention(
    id INT,
    date_demande DATETIME NOT NULL,
    date_intervention DATETIME NOT NULL,
    type_aide VARCHAR(50) NOT NULL,
    statut VARCHAR(50) NOT NULL,
    id_usager INT,
    id_unite INT,
    id_secteur INT,
    CONSTRAINT pk_intervention_id PRIMARY KEY (id),
    CONSTRAINT fk_intervention_id_usager FOREIGN KEY (id_usager) REFERENCES Usager(id),
    CONSTRAINT fk_intervention_id_unite FOREIGN KEY (id_unite) REFERENCES Unite(id),
    CONSTRAINT fk_intervention_id_secteur FOREIGN KEY (id_secteur) REFERENCES Secteur(id)
);

CREATE TABLE Plainte(
    id INT,
    type VARCHAR(50) NOT NULL,
    description TEXT,
    id_intervention INT,
    CONSTRAINT pk_plainte_id PRIMARY KEY (id),
    CONSTRAINT fk_plainte_id_intervention FOREIGN KEY (id_intervention) REFERENCES Intervention(id)
);


-- Insertion des données : 

INSERT INTO Secteur VALUES
(1, 'Secteur 1'),
(2, 'Secteur 2'),
(3, 'Secteur 3'),
(4, 'Secteur 4'),
(5, 'Secteur 5');

INSERT INTO Usager VALUES
(1, 'Roux', 'Laura', '3215944719', 'laura.roux@gmail.ca', '58 rue Exemple', 3),
(2, 'Lefevre', 'Marie', '0539154525', 'marie.lefevre@gmail.ca', '76 rue Exemple', 5),
(3, 'Fontaine', 'Laura', '7609091297', 'laura.fontaine@gmail.ca', '92 rue Exemple', 3),
(4, 'Fontaine', 'Paul', '2742383161', 'paul.fontaine@gmail.com', '41 rue Exemple', 5),
(5, 'Garcia', 'Antoine', '7994079092', 'antoine.garcia@hotmail.com', '62 rue Exemple', 1),
(6, 'Fontaine', 'Marie', '2701834336', 'marie.fontaine@hotmail.com', '51 rue Exemple', 1),
(7, 'Lambert', 'Marie', '9765161886', 'marie.lambert@hotmail.com', '90 rue Exemple', 2),
(8, 'Moreau', 'Laura', '4826543540', 'laura.moreau@gmail.com', '33 rue Exemple', 5),
(9, 'Fontaine', 'Laura', '3848945281', 'laura.fontaine@gmail.ca', '55 rue Exemple', 4),
(10, 'Lefevre', 'Paul', '5501888901', 'paul.lefevre@hotmail.com', '55 rue Exemple', 5),
(11, 'Garcia', 'Luc', '2626896805', 'luc.garcia@hotmail.com', '14 rue Exemple', 4),
(12, 'Martin', 'Paul', '9144099431', 'paul.martin@gmail.ca', '38 rue Exemple', 3),
(13, 'Chevalier', 'Luc', '5072002823', 'luc.chevalier@gmail.com', '28 rue Exemple', 5),
(14, 'Lefevre', 'Laura', '6451162160', 'laura.lefevre@gmail.com', '42 rue Exemple', 5),
(15, 'Lefevre', 'Paul', '2821586495', 'paul.lefevre@gmail.ca', '15 rue Exemple', 5),
(16, 'Faure', 'Jean', '7298403114', 'jean.faure@gmail.com', '44 rue Exemple', 5),
(17, 'Moreau', 'Laura', '7539589106', 'laura.moreau@gmail.com', '62 rue Exemple', 5),
(18, 'Fontaine', 'Luc', '4376060256', 'luc.fontaine@hotmail.com', '60 rue Exemple', 5),
(19, 'Chevalier', 'Marie', '5285741094', 'marie.chevalier@hotmail.com', '100 rue Exemple', 2),
(20, 'Faure', 'Nicolas', '5333274875', 'nicolas.faure@gmail.com', '10 rue Exemple', 5),
(21, 'Lambert', 'Nicolas', '9665961234', 'nicolas.lambert@hotmail.com', '21 rue Exemple', 2),
(22, 'Dubois', 'Antoine', '6270563626', 'antoine.dubois@gmail.com', '51 rue Exemple', 2),
(23, 'Chevalier', 'Laura', '4671620773', 'laura.chevalier@hotmail.com', '21 rue Exemple', 5),
(24, 'Lefevre', 'Laura', '7481357711', 'laura.lefevre@hotmail.com', '70 rue Exemple', 2),
(25, 'Fontaine', 'Jean', '9225464693', 'jean.fontaine@gmail.com', '92 rue Exemple', 5),
(26, 'Chevalier', 'Antoine', '5833000330', 'antoine.chevalier@gmail.ca', '41 rue Exemple', 3),
(27, 'Lefevre', 'Laura', '2222899444', 'laura.lefevre@gmail.ca', '71 rue Exemple', 2),
(28, 'Roux', 'Nicolas', '8447576957', 'nicolas.roux@hotmail.com', '35 rue Exemple', 2),
(29, 'Moreau', 'Claire', '6369658269', 'claire.moreau@gmail.ca', '50 rue Exemple', 2),
(30, 'Chevalier', 'Laura', '1258545516', 'laura.chevalier@hotmail.com', '88 rue Exemple', 2),
(31, 'Moreau', 'Julie', '7972321979', 'julie.moreau@hotmail.com', '63 rue Exemple', 3),
(32, 'Martin', 'Sophie', '5157001248', 'sophie.martin@gmail.com', '30 rue Exemple', 2),
(33, 'Moreau', 'Jean', '9773097360', 'jean.moreau@gmail.com', '33 rue Exemple', 2),
(34, 'Martin', 'Jean', '6635070833', 'jean.martin@gmail.com', '96 rue Exemple', 5),
(35, 'Garcia', 'Nicolas', '1627663396', 'nicolas.garcia@gmail.ca', '23 rue Exemple', 5),
(36, 'Faure', 'Paul', '7504337674', 'paul.faure@hotmail.com', '9 rue Exemple', 5),
(37, 'Faure', 'Jean', '0500108280', 'jean.faure@gmail.com', '27 rue Exemple', 3),
(38, 'Fontaine', 'Jean', '0398249970', 'jean.fontaine@hotmail.com', '36 rue Exemple', 5),
(39, 'Faure', 'Marie', '9112909262', 'marie.faure@gmail.ca', '19 rue Exemple', 1),
(40, 'Moreau', 'Laura', '1163729080', 'laura.moreau@hotmail.com', '28 rue Exemple', 1),
(41, 'Roux', 'Luc', '2438855114', 'luc.roux@hotmail.com', '78 rue Exemple', 2),
(42, 'Faure', 'Julie', '7380257144', 'julie.faure@gmail.ca', '82 rue Exemple', 5),
(43, 'Roux', 'Marie', '6579052103', 'marie.roux@gmail.com', '90 rue Exemple', 4),
(44, 'Martin', 'Marie', '3798805416', 'marie.martin@gmail.ca', '5 rue Exemple', 1),
(45, 'Fontaine', 'Luc', '7902836614', 'luc.fontaine@gmail.ca', '2 rue Exemple', 3),
(46, 'Roux', 'Antoine', '6781743191', 'antoine.roux@gmail.ca', '100 rue Exemple', 2),
(47, 'Fontaine', 'Jean', '0521751124', 'jean.fontaine@hotmail.com', '67 rue Exemple', 5),
(48, 'Roux', 'Nicolas', '1931043410', 'nicolas.roux@gmail.ca', '47 rue Exemple', 4),
(49, 'Lefevre', 'Nicolas', '8292738400', 'nicolas.lefevre@gmail.com', '16 rue Exemple', 2),
(50, 'Chevalier', 'Marie', '7126642442', 'marie.chevalier@gmail.com', '88 rue Exemple', 5);

INSERT INTO Benevole VALUES
(1, 'Lambert', 'Luc', '8703928091', 'luc.lambert@gmail.fr', '42 rue Exemple', 1, 3),
(2, 'Roux', 'Nicolas', '5866937525', 'nicolas.roux@gmail.com', '7 rue Exemple', 1, 3),
(3, 'Garcia', 'Nicolas', '9699724825', 'nicolas.garcia@gmail.com', '68 rue Exemple', 1, 2),
(4, 'Dubois', 'Nicolas', '4693954081', 'nicolas.dubois@gmail.com', '66 rue Exemple', 0, 3),
(5, 'Chevalier', 'Antoine', '1530332225', 'antoine.chevalier@gmail.fr', '89 rue Exemple', 0, 4),
(6, 'Garcia', 'Julie', '8138578819', 'julie.garcia@hotmail.com', '62 rue Exemple', 0, 4),
(7, 'Chevalier', 'Sophie', '5934440924', 'sophie.chevalier@hotmail.com', '41 rue Exemple', 0, 1),
(8, 'Lefevre', 'Paul', '5189537050', 'paul.lefevre@hotmail.com', '13 rue Exemple', 0, 3),
(9, 'Fontaine', 'Claire', '6365649976', 'claire.fontaine@gmail.com', '1 rue Exemple', 0, 3),
(10, 'Dubois', 'Claire', '1657260436', 'claire.dubois@gmail.fr', '92 rue Exemple', 0, 4),
(11, 'Lambert', 'Nicolas', '4011828544', 'nicolas.lambert@gmail.com', '76 rue Exemple', 1, 4),
(12, 'Faure', 'Antoine', '8432684757', 'antoine.faure@gmail.fr', '66 rue Exemple', 0, 3),
(13, 'Moreau', 'Claire', '5292790373', 'claire.moreau@hotmail.com', '4 rue Exemple', 0, 5),
(14, 'Fontaine', 'Sophie', '2109397211', 'sophie.fontaine@gmail.com', '42 rue Exemple', 0, 1),
(15, 'Martin', 'Antoine', '6422631671', 'antoine.martin@gmail.fr', '53 rue Exemple', 1, 1),
(16, 'Roux', 'Laura', '4627452134', 'laura.roux@hotmail.com', '68 rue Exemple', 1, 5),
(17, 'Faure', 'Marie', '8140992947', 'marie.faure@gmail.com', '95 rue Exemple', 0, 5),
(18, 'Lambert', 'Nicolas', '8030687406', 'nicolas.lambert@gmail.fr', '28 rue Exemple', 1, 3),
(19, 'Moreau', 'Claire', '8689163168', 'claire.moreau@gmail.fr', '83 rue Exemple', 1, 3),
(20, 'Fontaine', 'Jean', '5928629043', 'jean.fontaine@gmail.com', '59 rue Exemple', 1, 3),
(21, 'Lambert', 'Marie', '8962179372', 'marie.lambert@gmail.fr', '63 rue Exemple', 1, 4),
(22, 'Moreau', 'Sophie', '2793934771', 'sophie.moreau@gmail.fr', '45 rue Exemple', 0, 3),
(23, 'Roux', 'Luc', '1400104598', 'luc.roux@hotmail.com', '49 rue Exemple', 0, 3),
(24, 'Martin', 'Laura', '7692192645', 'laura.martin@gmail.fr', '23 rue Exemple', 1, 3),
(25, 'Faure', 'Sophie', '2386694179', 'sophie.faure@gmail.fr', '37 rue Exemple', 1, 5),
(26, 'Martin', 'Antoine', '9215374833', 'antoine.martin@gmail.com', '8 rue Exemple', 0, 2),
(27, 'Martin', 'Paul', '0536765965', 'paul.martin@hotmail.com', '85 rue Exemple', 0, 3),
(28, 'Lefevre', 'Nicolas', '2717785929', 'nicolas.lefevre@gmail.com', '38 rue Exemple', 0, 2),
(29, 'Moreau', 'Nicolas', '7305227845', 'nicolas.moreau@hotmail.com', '17 rue Exemple', 0, 1),
(30, 'Garcia', 'Laura', '5294908648', 'laura.garcia@hotmail.com', '64 rue Exemple', 0, 4),
(31, 'Lefevre', 'Laura', '6967837373', 'laura.lefevre@gmail.com', '64 rue Exemple', 0, 2),
(32, 'Dubois', 'Sophie', '8785234608', 'sophie.dubois@gmail.fr', '19 rue Exemple', 0, 4),
(33, 'Lambert', 'Jean', '8439543200', 'jean.lambert@gmail.fr', '34 rue Exemple', 0, 3),
(34, 'Dubois', 'Julie', '4002304149', 'julie.dubois@gmail.fr', '81 rue Exemple', 0, 4),
(35, 'Lambert', 'Paul', '2093307643', 'paul.lambert@hotmail.com', '71 rue Exemple', 0, 1),
(36, 'Fontaine', 'Luc', '6853609875', 'luc.fontaine@gmail.com', '86 rue Exemple', 1, 2),
(37, 'Lefevre', 'Marie', '9926873920', 'marie.lefevre@gmail.com', '65 rue Exemple', 1, 2),
(38, 'Dubois', 'Laura', '0452830175', 'laura.dubois@hotmail.com', '48 rue Exemple', 0, 5),
(39, 'Chevalier', 'Luc', '3335847646', 'luc.chevalier@gmail.com', '74 rue Exemple', 0, 1),
(40, 'Moreau', 'Antoine', '3708255953', 'antoine.moreau@hotmail.com', '41 rue Exemple', 1, 4),
(41, 'Lambert', 'Luc', '9481911309', 'luc.lambert@gmail.fr', '55 rue Exemple', 1, 4),
(42, 'Garcia', 'Nicolas', '4103565225', 'nicolas.garcia@hotmail.com', '51 rue Exemple', 1, 1),
(43, 'Lefevre', 'Julie', '6244145224', 'julie.lefevre@gmail.fr', '23 rue Exemple', 0, 3),
(44, 'Martin', 'Jean', '0499229321', 'jean.martin@hotmail.com', '15 rue Exemple', 1, 1),
(45, 'Garcia', 'Antoine', '1160962132', 'antoine.garcia@gmail.com', '19 rue Exemple', 1, 4),
(46, 'Dubois', 'Nicolas', '0988197687', 'nicolas.dubois@gmail.com', '46 rue Exemple', 0, 3),
(47, 'Lefevre', 'Antoine', '7340322078', 'antoine.lefevre@gmail.fr', '44 rue Exemple', 0, 5),
(48, 'Lambert', 'Marie', '4833335890', 'marie.lambert@hotmail.com', '32 rue Exemple', 0, 3),
(49, 'Faure', 'Sophie', '2136825242', 'sophie.faure@hotmail.com', '57 rue Exemple', 1, 5),
(50, 'Moreau', 'Claire', '7709335809', 'claire.moreau@gmail.com', '98 rue Exemple', 1, 1);

INSERT INTO Unite VALUES
(1, 0, 21, 40, 5),
(2, 0, 31, 10, 4),
(3, 1, 4, 27, 1),
(4, 0, 14, 41, 1),
(5, 0, 44, 24, 4),
(6, 0, 49, 11, 4),
(7, 0, 5, 18, 1),
(8, 1, 17, 15, 2),
(9, 0, 30, 26, 1),
(10, 1, 9, 50, 3),
(11, 1, 21, 28, 3),
(12, 0, 17, 18, 2),
(13, 0, 34, 30, 2),
(14, 1, 46, 18, 5),
(15, 0, 16, 40, 2),
(16, 1, 8, 9, 5),
(17, 0, 11, 35, 5),
(18, 0, 40, 32, 1),
(19, 1, 3, 24, 4),
(20, 0, 14, 18, 5);

INSERT INTO Intervention VALUES
(1, '2025-01-06 17:11:36', '2025-01-08 17:11:36', 'Compagnie', 'Complétée', 9, 14, 2),
(2, '2024-07-10 17:11:36', '2024-07-17 17:11:36', 'Transport', 'En cours', 43, 4, 3),
(3, '2024-11-18 17:11:36', '2024-11-19 17:11:36', 'Transport', 'Complétée', 3, 10, 4),
(4, '2024-06-14 17:11:36', '2024-06-19 17:11:36', 'Transport', 'Annulée', 36, 12, 2),
(5, '2024-07-04 17:11:36', '2024-07-10 17:11:36', 'Transport', 'Annulée', 26, 9, 5),
(6, '2024-11-10 17:11:36', '2024-11-20 17:11:36', 'Courses', 'Annulée', 22, 17, 1),
(7, '2024-07-08 17:11:36', '2024-07-11 17:11:36', 'Transport', 'Complétée', 42, 11, 3),
(8, '2024-10-01 17:11:36', '2024-10-09 17:11:36', 'Transport', 'En cours', 50, 8, 3),
(9, '2024-12-16 17:11:36', '2024-12-22 17:11:36', 'Administratif', 'Annulée', 23, 19, 1),
(10, '2024-11-18 17:11:36', '2024-11-25 17:11:36', 'Courses', 'Complétée', 19, 12, 4),
(11, '2024-11-03 17:11:36', '2024-11-06 17:11:36', 'Transport', 'En attente', 34, 11, 3),
(12, '2024-06-26 17:11:36', '2024-07-01 17:11:36', 'Transport', 'Complétée', 16, 8, 1),
(13, '2024-09-23 17:11:36', '2024-09-28 17:11:36', 'Transport', 'Complétée', 43, 13, 4),
(14, '2024-09-14 17:11:36', '2024-09-24 17:11:36', 'Compagnie', 'Complétée', 41, 10, 5),
(15, '2024-08-19 17:11:36', '2024-08-29 17:11:36', 'Courses', 'Complétée', 10, 17, 3),
(16, '2024-05-16 17:11:36', '2024-05-20 17:11:36', 'Courses', 'En attente', 22, 4, 1),
(17, '2025-01-30 17:11:36', '2025-02-03 17:11:36', 'Jardinage', 'En attente', 43, 1, 1),
(18, '2025-03-28 17:11:36', '2025-04-07 17:11:36', 'Transport', 'Complétée', 13, 5, 3),
(19, '2025-02-04 17:11:36', '2025-02-12 17:11:36', 'Transport', 'En cours', 3, 15, 4),
(20, '2025-02-25 17:11:36', '2025-02-27 17:11:36', 'Compagnie', 'Complétée', 27, 19, 4),
(21, '2024-09-15 17:11:36', '2024-09-24 17:11:36', 'Administratif', 'En cours', 41, 17, 2),
(22, '2024-09-10 17:11:36', '2024-09-19 17:11:36', 'Jardinage', 'Annulée', 42, 7, 1),
(23, '2024-12-15 17:11:36', '2024-12-21 17:11:36', 'Compagnie', 'Annulée', 25, 12, 1),
(24, '2025-02-25 17:11:36', '2025-02-27 17:11:36', 'Compagnie', 'En cours', 33, 4, 2),
(25, '2025-03-15 17:11:36', '2025-03-21 17:11:36', 'Administratif', 'Annulée', 35, 16, 4),
(26, '2024-06-20 17:11:36', '2024-06-24 17:11:36', 'Administratif', 'Annulée', 46, 6, 1),
(27, '2024-09-06 17:11:36', '2024-09-08 17:11:36', 'Jardinage', 'En attente', 12, 8, 4),
(28, '2024-12-14 17:11:36', '2024-12-18 17:11:36', 'Jardinage', 'En attente', 3, 9, 2),
(29, '2025-02-23 17:11:36', '2025-02-26 17:11:36', 'Administratif', 'Annulée', 29, 8, 1),
(30, '2025-03-28 17:11:36', '2025-03-30 17:11:36', 'Compagnie', 'Annulée', 27, 16, 2),
(31, '2024-12-01 17:11:36', '2024-12-03 17:11:36', 'Transport', 'Annulée', 41, 17, 5),
(32, '2024-05-01 17:11:36', '2024-05-05 17:11:36', 'Transport', 'En cours', 11, 1, 5),
(33, '2024-04-18 17:11:36', '2024-04-23 17:11:36', 'Administratif', 'Annulée', 33, 10, 2),
(34, '2024-12-25 17:11:36', '2025-01-02 17:11:36', 'Administratif', 'Complétée', 35, 19, 3),
(35, '2024-10-04 17:11:36', '2024-10-10 17:11:36', 'Administratif', 'Complétée', 40, 12, 5),
(36, '2024-11-04 17:11:36', '2024-11-12 17:11:36', 'Administratif', 'En cours', 30, 14, 1),
(37, '2024-12-08 17:11:36', '2024-12-09 17:11:36', 'Transport', 'En cours', 24, 14, 3),
(38, '2024-10-23 17:11:36', '2024-10-27 17:11:36', 'Compagnie', 'En attente', 32, 13, 1),
(39, '2024-04-27 17:11:36', '2024-04-30 17:11:36', 'Jardinage', 'Annulée', 40, 4, 1),
(40, '2024-07-31 17:11:36', '2024-08-06 17:11:36', 'Administratif', 'Annulée', 38, 12, 2);

INSERT INTO Plainte VALUES
(1, 'Erreur', 'Description de la plainte 1', 9),
(2, 'Erreur', 'Description de la plainte 2', 7),
(3, 'Comportement', 'Description de la plainte 3', 31),
(4, 'Erreur', 'Description de la plainte 4', 39),
(5, 'Autre', 'Description de la plainte 5', 37),
(6, 'Comportement', 'Description de la plainte 6', 8),
(7, 'Retard', 'Description de la plainte 7', 19),
(8, 'Comportement', 'Description de la plainte 8', 17),
(9, 'Autre', 'Description de la plainte 9', 10),
(10, 'Erreur', 'Description de la plainte 10', 12),
(11, 'Autre', 'Description de la plainte 11', 21),
(12, 'Erreur', 'Description de la plainte 12', 33),
(13, 'Retard', 'Description de la plainte 13', 22),
(14, 'Retard', 'Description de la plainte 14', 31),
(15, 'Autre', 'Description de la plainte 15', 14),
(16, 'Comportement', 'Description de la plainte 16', 1),
(17, 'Autre', 'Description de la plainte 17', 19),
(18, 'Comportement', 'Description de la plainte 18', 6),
(19, 'Retard', 'Description de la plainte 19', 26),
(20, 'Comportement', 'Description de la plainte 20', 8);