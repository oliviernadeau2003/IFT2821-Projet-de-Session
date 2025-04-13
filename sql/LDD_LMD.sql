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


-- Insertion des secteurs
INSERT INTO Secteur (id, nom) VALUES (1, 'Little Italy');
INSERT INTO Secteur (id, nom) VALUES (2, 'Chinatown');
INSERT INTO Secteur (id, nom) VALUES (3, 'Quartier Latin');
INSERT INTO Secteur (id, nom) VALUES (4, 'Downtown');
INSERT INTO Secteur (id, nom) VALUES (5, 'Petite France');
INSERT INTO Secteur (id, nom) VALUES (6, 'Old Port');
INSERT INTO Secteur (id, nom) VALUES (7, 'Kreuzberg');
INSERT INTO Secteur (id, nom) VALUES (8, 'Barrio Sur');
INSERT INTO Secteur (id, nom) VALUES (9, 'Little India');
INSERT INTO Secteur (id, nom) VALUES (10, 'Nihonmachi');
INSERT INTO Secteur (id, nom) VALUES (11, 'Souk District');
INSERT INTO Secteur (id, nom) VALUES (12, 'Little Moscow');
INSERT INTO Secteur (id, nom) VALUES (13, 'Nordic Quarter');
INSERT INTO Secteur (id, nom) VALUES (14, 'Little Havana');
INSERT INTO Secteur (id, nom) VALUES (15, 'Greek Agora');
INSERT INTO Secteur (id, nom) VALUES (16, 'Little Brazil');
INSERT INTO Secteur (id, nom) VALUES (17, 'Korean Town');
INSERT INTO Secteur (id, nom) VALUES (18, 'Little Morocco');
INSERT INTO Secteur (id, nom) VALUES (19, 'Thai District');
INSERT INTO Secteur (id, nom) VALUES (20, 'Little Israel');
INSERT INTO Secteur (id, nom) VALUES (21, 'Little Caribbean');
INSERT INTO Secteur (id, nom) VALUES (22, 'Little Switzerland');
INSERT INTO Secteur (id, nom) VALUES (23, 'Little Poland');
INSERT INTO Secteur (id, nom) VALUES (24, 'Little Portugal');
INSERT INTO Secteur (id, nom) VALUES (25, 'Little Philippines');
INSERT INTO Secteur (id, nom) VALUES (26, 'Little Ukraine');
INSERT INTO Secteur (id, nom) VALUES (27, 'Montmartre');
INSERT INTO Secteur (id, nom) VALUES (28, 'Friedrichshain');
INSERT INTO Secteur (id, nom) VALUES (29, 'El Raval');
INSERT INTO Secteur (id, nom) VALUES (30, 'Varanasi Quarter');
INSERT INTO Secteur (id, nom) VALUES (31, 'Shinjuku');
INSERT INTO Secteur (id, nom) VALUES (32, 'Medina');
INSERT INTO Secteur (id, nom) VALUES (33, 'Arbat Street');
INSERT INTO Secteur (id, nom) VALUES (34, 'Södermalm');
INSERT INTO Secteur (id, nom) VALUES (35, 'Vedado');
INSERT INTO Secteur (id, nom) VALUES (36, 'Plaka');
INSERT INTO Secteur (id, nom) VALUES (37, 'Copacabana');
INSERT INTO Secteur (id, nom) VALUES (38, 'Gangnam');
INSERT INTO Secteur (id, nom) VALUES (39, 'Fes El Bali');
INSERT INTO Secteur (id, nom) VALUES (40, 'Sukhumvit');
INSERT INTO Secteur (id, nom) VALUES (41, 'Tel Aviv Port');
INSERT INTO Secteur (id, nom) VALUES (42, 'Port of Spain');
INSERT INTO Secteur (id, nom) VALUES (43, 'Zurich Old Town');
INSERT INTO Secteur (id, nom) VALUES (44, 'Kazimierz');
INSERT INTO Secteur (id, nom) VALUES (45, 'Alfama');
INSERT INTO Secteur (id, nom) VALUES (46, 'Intramuros');
INSERT INTO Secteur (id, nom) VALUES (47, 'Maidan');
INSERT INTO Secteur (id, nom) VALUES (48, 'Pigalle');
INSERT INTO Secteur (id, nom) VALUES (49, 'Trastevere');
INSERT INTO Secteur (id, nom) VALUES (50, 'Sultanahmet');


-- Insertion des benevoles
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (1, 'Garcia', 'Maria', '5141234501', 'maria.garcia@email.com', '123 Calle Mayor', 1, 1);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (2, 'Zhang', 'Wei', '5141234502', 'wei.zhang@email.com', '456 Nanjing Road', 0, 2);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (3, 'Dubois', 'Jean', '5141234503', 'jean.dubois@email.com', '789 Rue Saint-Denis', 1, 3);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (4, 'Smith', 'John', '5141234504', 'john.smith@email.com', '101 Main Street', 0, 4);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (5, 'Muller', 'Anna', '5141234505', 'anna.muller@email.com', '202 Alexanderplatz', 1, 5);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (6, 'Rossi', 'Marco', '5141234506', 'marco.rossi@email.com', '303 Via Roma', 0, 6);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (7, 'Kim', 'Soo-Jin', '5141234507', 'soojin.kim@email.com', '404 Gangnam Street', 1, 7);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (8, 'Rodriguez', 'Carlos', '5141234508', 'carlos.rodriguez@email.com', '505 Avenida Libertad', 0, 8);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (9, 'Patel', 'Raj', '5141234509', 'raj.patel@email.com', '606 Gandhi Road', 1, 9);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (10, 'Tanaka', 'Yuki', '5141234510', 'yuki.tanaka@email.com', '707 Sakura Avenue', 0, 10);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (11, 'Ahmed', 'Fatima', '5141234511', 'fatima.ahmed@email.com', '808 Al Nahda Street', 1, 11);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (12, 'Ivanov', 'Dmitri', '5141234512', 'dmitri.ivanov@email.com', '909 Nevsky Prospekt', 0, 12);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (13, 'Johansson', 'Erik', '5141234513', 'erik.johansson@email.com', '111 Kungsgatan', 1, 13);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (14, 'Hernandez', 'Lucia', '5141234514', 'lucia.hernandez@email.com', '222 Calle Ocho', 0, 14);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (15, 'Papadopoulos', 'Nikos', '5141234515', 'nikos.papadopoulos@email.com', '333 Athens Street', 1, 15);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (16, 'Silva', 'Paulo', '5141234516', 'paulo.silva@email.com', '444 Copacabana Avenue', 0, 16);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (17, 'Park', 'Min-Ji', '5141234517', 'minji.park@email.com', '555 Seoul Boulevard', 1, 17);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (18, 'Mohamad', 'Hassan', '5141234518', 'hassan.mohamad@email.com', '666 Casablanca Road', 0, 18);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (19, 'Suwanee', 'Chai', '5141234519', 'chai.suwanee@email.com', '777 Bangkok Lane', 1, 19);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (20, 'Cohen', 'David', '5141234520', 'david.cohen@email.com', '888 Tel Aviv Street', 0, 20);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (21, 'Johnson', 'Emily', '5141234521', 'emily.johnson@email.com', '121 Kingston Avenue', 1, 21);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (22, 'Weber', 'Hans', '5141234522', 'hans.weber@email.com', '232 Zurich Plaza', 0, 22);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (23, 'Nowak', 'Agnieszka', '5141234523', 'agnieszka.nowak@email.com', '343 Warsaw Street', 1, 23);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (24, 'Ferreira', 'Miguel', '5141234524', 'miguel.ferreira@email.com', '454 Lisbon Avenue', 0, 24);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (25, 'Santos', 'Maria', '5141234525', 'maria.santos@email.com', '565 Manila Road', 1, 25);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (26, 'Kovalenko', 'Olena', '5141234526', 'olena.kovalenko@email.com', '676 Kiev Street', 0, 26);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (27, 'Dupont', 'Sophie', '5141234527', 'sophie.dupont@email.com', '787 Rue Lepic', 1, 27);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (28, 'Fischer', 'Thomas', '5141234528', 'thomas.fischer@email.com', '898 Warschauer Strasse', 0, 28);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (29, 'Gonzalez', 'Javier', '5141234529', 'javier.gonzalez@email.com', '909 Rambla del Raval', 1, 29);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (30, 'Sharma', 'Priya', '5141234530', 'priya.sharma@email.com', '101 Ganges Road', 0, 30);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (31, 'Nakamura', 'Hiroshi', '5141234531', 'hiroshi.nakamura@email.com', '212 Kabukicho', 1, 31);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (32, 'El Mansouri', 'Yasmine', '5141234532', 'yasmine.elmansouri@email.com', '323 Medina Street', 0, 32);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (33, 'Petrov', 'Nikolai', '5141234533', 'nikolai.petrov@email.com', '434 Old Arbat', 1, 33);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (34, 'Lindholm', 'Astrid', '5141234534', 'astrid.lindholm@email.com', '545 Götgatan', 0, 34);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (35, 'Castro', 'Elena', '5141234535', 'elena.castro@email.com', '656 Calle 23', 1, 35);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (36, 'Andreou', 'Stefanos', '5141234536', 'stefanos.andreou@email.com', '767 Adrianou Street', 0, 36);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (37, 'Oliveira', 'Joao', '5141234537', 'joao.oliveira@email.com', '878 Avenida Atlantica', 1, 37);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (38, 'Choi', 'Ji-hoon', '5141234538', 'jihoon.choi@email.com', '989 Apgujeong Road', 0, 38);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (39, 'Benjelloun', 'Amal', '5141234539', 'amal.benjelloun@email.com', '111 Talaa Kebira', 1, 39);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (40, 'Chaiyasith', 'Apinya', '5141234540', 'apinya.chaiyasith@email.com', '222 Sukhumvit Soi 11', 0, 40);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (41, 'Levi', 'Rachel', '5141234541', 'rachel.levi@email.com', '333 Dizengoff Street', 1, 41);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (42, 'Williams', 'Michael', '5141234542', 'michael.williams@email.com', '444 Frederick Street', 0, 42);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (43, 'Keller', 'Sven', '5141234543', 'sven.keller@email.com', '555 Bahnhofstrasse', 1, 43);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (44, 'Kowalczyk', 'Marta', '5141234544', 'marta.kowalczyk@email.com', '666 Szeroka Street', 0, 44);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (45, 'Almeida', 'Tiago', '5141234545', 'tiago.almeida@email.com', '777 Rua da Alfandega', 1, 45);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (46, 'Reyes', 'Isabella', '5141234546', 'isabella.reyes@email.com', '888 General Luna Street', 0, 46);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (47, 'Shevchenko', 'Vadym', '5141234547', 'vadym.shevchenko@email.com', '999 Khreshchatyk Street', 1, 47);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (48, 'Moreau', 'Camille', '5141234548', 'camille.moreau@email.com', '123 Rue Lepic', 0, 48);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (49, 'Ricci', 'Valentina', '5141234549', 'valentina.ricci@email.com', '234 Via del Corso', 0, 49);
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) 
VALUES (50, 'Yilmaz', 'Mehmet', '5141234550', 'mehmet.yilmaz@email.com', '345 Istiklal Avenue', 1, 50);


-- Insertion des equipes
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe) VALUES (1, 1, 1, 2, 1, 'preformee');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe) VALUES (2, 1, 3, 4, 2, 'preformee');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe) VALUES (3, 0, 5, NULL, 3, 'a_constituer');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe) VALUES (4, 1, 6, 7, 4, 'preformee');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe) VALUES (5, 0, 8, NULL, 5, 'a_constituer');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe) VALUES (6, 1, 9, 10, 6, 'preformee');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe) VALUES (7, 1, 11, 12, 7, 'preformee');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe) VALUES (8, 0, 13, NULL, 8, 'a_constituer');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe) VALUES (9, 1, 14, 15, 9, 'preformee');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe) VALUES (10, 0, 16, NULL, 10, 'a_constituer');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe) VALUES (11, 1, 17, 18, 11, 'preformee');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe) VALUES (12, 1, 19, 20, 12, 'preformee');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe) VALUES (13, 0, 21, NULL, 13, 'a_constituer');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe) VALUES (14, 1, 22, 23, 14, 'preformee');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe) VALUES (15, 0, 24, NULL, 15, 'a_constituer');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe) VALUES (16, 1, 25, 26, 16, 'preformee');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe) VALUES (17, 1, 27, 28, 17, 'preformee');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe) VALUES (18, 0, 29, NULL, 18, 'a_constituer');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe) VALUES (19, 1, 30, 31, 19, 'preformee');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe) VALUES (20, 0, 32, NULL, 20, 'a_constituer');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe) VALUES (21, 1, 33, 34, 21, 'preformee');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe) VALUES (22, 1, 35, 36, 22, 'preformee');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe) VALUES (23, 0, 37, NULL, 23, 'a_constituer');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe) VALUES (24, 1, 38, 39, 24, 'preformee');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe) VALUES (25, 0, 40, NULL, 25, 'a_constituer');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe) VALUES (26, 1, 41, 42, 26, 'preformee');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe) VALUES (27, 1, 43, 44, 27, 'preformee');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe) VALUES (28, 0, 45, NULL, 28, 'a_constituer');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe) VALUES (29, 1, 46, 47, 29, 'preformee');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe) VALUES (30, 0, 48, NULL, 30, 'a_constituer');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe) VALUES (31, 1, 49, 50, 31, 'preformee');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe) VALUES (32, 1, 1, 3, 32, 'preformee');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe) VALUES (33, 0, 5, NULL, 33, 'a_constituer');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe) VALUES (34, 1, 7, 9, 34, 'preformee');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe) VALUES (35, 0, 11, NULL, 35, 'a_constituer');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe) VALUES (36, 1, 13, 15, 36, 'preformee');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe) VALUES (37, 1, 17, 19, 37, 'preformee');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe) VALUES (38, 0, 21, NULL, 38, 'a_constituer');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe) VALUES (39, 1, 23, 25, 39, 'preformee');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe) VALUES (40, 0, 27, NULL, 40, 'a_constituer');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe) VALUES (41, 1, 29, 31, 41, 'preformee');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe) VALUES (42, 1, 33, 35, 42, 'preformee');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe) VALUES (43, 0, 37, NULL, 43, 'a_constituer');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe) VALUES (44, 1, 39, 41, 44, 'preformee');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe) VALUES (45, 0, 43, NULL, 45, 'a_constituer');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe) VALUES (46, 1, 45, 47, 46, 'preformee');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe) VALUES (47, 1, 2, 4, 47, 'preformee');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe) VALUES (48, 0, 6, NULL, 48, 'a_constituer');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe) VALUES (49, 1, 8, 10, 49, 'preformee');
INSERT INTO Equipe (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_equipe) VALUES (50, 0, 12, NULL, 50, 'a_constituer');

-- Note: Les usagers vont etre ajoutes avec la procedure T-SQL et le script ajout_usagers.py
