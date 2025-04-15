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


CREATE TABLE Unite(
    id INT,
    est_disponible BIT NOT NULL,
    id_benevole_1 INT NOT NULL,
    id_benevole_2 INT, 
    id_secteur INT NOT NULL,
    type_unite VARCHAR(20) NOT NULL CHECK (type_unite IN ('preformee', 'a_constituer')),
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
    duree INT NULL,
    id_usager INT,
    id_unite INT,
    id_secteur INT,
    CONSTRAINT pk_intervention_id PRIMARY KEY (id),
    CONSTRAINT fk_intervention_id_usager FOREIGN KEY (id_usager) REFERENCES Usager(id),
    CONSTRAINT fk_intervention_id_unite FOREIGN KEY (id_unite) REFERENCES Unite(id),
    CONSTRAINT fk_intervention_id_secteur FOREIGN KEY (id_secteur) REFERENCES Secteur(id),
    CONSTRAINT CHK_statut CHECK (statut IN ('Pas encore commence', 'En cours', 'Termine', 'Annule'))
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
INSERT INTO Secteur (id, nom) VALUES
(1, 'Little Italy'),
(2, 'Chinatown'),
(3, 'Quartier Latin'),
(4, 'Downtown'),
(5, 'Petite France'),
(6, 'Old Port'),
(7, 'Kreuzberg'),
(8, 'Barrio Sur'),
(9, 'Little India'),
(10, 'Nihonmachi'),
(11, 'Souk District'),
(12, 'Little Moscow'),
(13, 'Nordic Quarter'),
(14, 'Little Havana'),
(15, 'Greek Agora'),
(16, 'Little Brazil'),
(17, 'Korean Town'),
(18, 'Little Morocco'),
(19, 'Thai District'),
(20, 'Little Israel'),
(21, 'Little Caribbean'),
(22, 'Little Switzerland'),
(23, 'Little Poland'),
(24, 'Little Portugal'),
(25, 'Little Philippines'),
(26, 'Little Ukraine'),
(27, 'Montmartre'),
(28, 'Friedrichshain'),
(29, 'El Raval'),
(30, 'Varanasi Quarter'),
(31, 'Shinjuku'),
(32, 'Medina'),
(33, 'Arbat Street'),
(34, 'Södermalm'),
(35, 'Vedado'),
(36, 'Plaka'),
(37, 'Copacabana'),
(38, 'Gangnam'),
(39, 'Fes El Bali'),
(40, 'Sukhumvit'),
(41, 'Tel Aviv Port'),
(42, 'Port of Spain'),
(43, 'Zurich Old Town'),
(44, 'Kazimierz'),
(45, 'Alfama'),
(46, 'Intramuros'),
(47, 'Maidan'),
(48, 'Pigalle'),
(49, 'Trastevere'),
(50, 'Sultanahmet');


-- Insertion des benevoles
INSERT INTO Benevole (id, nom, prenom, telephone, courriel, adresse, possede_voiture, id_secteur) VALUES
(1, 'Garcia', 'Maria', '5141234501', 'maria.garcia@email.com', '123 Calle Mayor', 1, 1),
(2, 'Zhang', 'Wei', '5141234502', 'wei.zhang@email.com', '456 Nanjing Road', 0, 2),
(3, 'Dubois', 'Jean', '5141234503', 'jean.dubois@email.com', '789 Rue Saint-Denis', 1, 3),
(4, 'Smith', 'John', '5141234504', 'john.smith@email.com', '101 Main Street', 0, 4),
(5, 'Muller', 'Anna', '5141234505', 'anna.muller@email.com', '202 Alexanderplatz', 1, 5),
(6, 'Rossi', 'Marco', '5141234506', 'marco.rossi@email.com', '303 Via Roma', 0, 6),
(7, 'Kim', 'Soo-Jin', '5141234507', 'soojin.kim@email.com', '404 Gangnam Street', 1, 7),
(8, 'Rodriguez', 'Carlos', '5141234508', 'carlos.rodriguez@email.com', '505 Avenida Libertad', 0, 8),
(9, 'Patel', 'Raj', '5141234509', 'raj.patel@email.com', '606 Gandhi Road', 1, 9),
(10, 'Tanaka', 'Yuki', '5141234510', 'yuki.tanaka@email.com', '707 Sakura Avenue', 0, 10),
(11, 'Ahmed', 'Fatima', '5141234511', 'fatima.ahmed@email.com', '808 Al Nahda Street', 1, 11),
(12, 'Ivanov', 'Dmitri', '5141234512', 'dmitri.ivanov@email.com', '909 Nevsky Prospekt', 0, 12),
(13, 'Johansson', 'Erik', '5141234513', 'erik.johansson@email.com', '111 Kungsgatan', 1, 13),
(14, 'Hernandez', 'Lucia', '5141234514', 'lucia.hernandez@email.com', '222 Calle Ocho', 0, 14),
(15, 'Papadopoulos', 'Nikos', '5141234515', 'nikos.papadopoulos@email.com', '333 Athens Street', 1, 15),
(16, 'Silva', 'Paulo', '5141234516', 'paulo.silva@email.com', '444 Copacabana Avenue', 0, 16),
(17, 'Park', 'Min-Ji', '5141234517', 'minji.park@email.com', '555 Seoul Boulevard', 1, 17),
(18, 'Mohamad', 'Hassan', '5141234518', 'hassan.mohamad@email.com', '666 Casablanca Road', 0, 18),
(19, 'Suwanee', 'Chai', '5141234519', 'chai.suwanee@email.com', '777 Bangkok Lane', 1, 19),
(20, 'Cohen', 'David', '5141234520', 'david.cohen@email.com', '888 Tel Aviv Street', 0, 20),
(21, 'Johnson', 'Emily', '5141234521', 'emily.johnson@email.com', '121 Kingston Avenue', 1, 21),
(22, 'Weber', 'Hans', '5141234522', 'hans.weber@email.com', '232 Zurich Plaza', 0, 22),
(23, 'Nowak', 'Agnieszka', '5141234523', 'agnieszka.nowak@email.com', '343 Warsaw Street', 1, 23),
(24, 'Ferreira', 'Miguel', '5141234524', 'miguel.ferreira@email.com', '454 Lisbon Avenue', 0, 24),
(25, 'Santos', 'Maria', '5141234525', 'maria.santos@email.com', '565 Manila Road', 1, 25),
(26, 'Kovalenko', 'Olena', '5141234526', 'olena.kovalenko@email.com', '676 Kiev Street', 0, 26),
(27, 'Dupont', 'Sophie', '5141234527', 'sophie.dupont@email.com', '787 Rue Lepic', 1, 27),
(28, 'Fischer', 'Thomas', '5141234528', 'thomas.fischer@email.com', '898 Warschauer Strasse', 0, 28),
(29, 'Gonzalez', 'Javier', '5141234529', 'javier.gonzalez@email.com', '909 Rambla del Raval', 1, 29),
(30, 'Sharma', 'Priya', '5141234530', 'priya.sharma@email.com', '101 Ganges Road', 0, 30),
(31, 'Nakamura', 'Hiroshi', '5141234531', 'hiroshi.nakamura@email.com', '212 Kabukicho', 1, 31),
(32, 'El Mansouri', 'Yasmine', '5141234532', 'yasmine.elmansouri@email.com', '323 Medina Street', 0, 32),
(33, 'Petrov', 'Nikolai', '5141234533', 'nikolai.petrov@email.com', '434 Old Arbat', 1, 33),
(34, 'Lindholm', 'Astrid', '5141234534', 'astrid.lindholm@email.com', '545 Götgatan', 0, 34),
(35, 'Castro', 'Elena', '5141234535', 'elena.castro@email.com', '656 Calle 23', 1, 35),
(36, 'Andreou', 'Stefanos', '5141234536', 'stefanos.andreou@email.com', '767 Adrianou Street', 0, 36),
(37, 'Oliveira', 'Joao', '5141234537', 'joao.oliveira@email.com', '878 Avenida Atlantica', 1, 37),
(38, 'Choi', 'Ji-hoon', '5141234538', 'jihoon.choi@email.com', '989 Apgujeong Road', 0, 38),
(39, 'Benjelloun', 'Amal', '5141234539', 'amal.benjelloun@email.com', '111 Talaa Kebira', 1, 39),
(40, 'Chaiyasith', 'Apinya', '5141234540', 'apinya.chaiyasith@email.com', '222 Sukhumvit Soi 11', 0, 40),
(41, 'Levi', 'Rachel', '5141234541', 'rachel.levi@email.com', '333 Dizengoff Street', 1, 41),
(42, 'Williams', 'Michael', '5141234542', 'michael.williams@email.com', '444 Frederick Street', 0, 42),
(43, 'Keller', 'Sven', '5141234543', 'sven.keller@email.com', '555 Bahnhofstrasse', 1, 43),
(44, 'Kowalczyk', 'Marta', '5141234544', 'marta.kowalczyk@email.com', '666 Szeroka Street', 0, 44),
(45, 'Almeida', 'Tiago', '5141234545', 'tiago.almeida@email.com', '777 Rua da Alfandega', 1, 45),
(46, 'Reyes', 'Isabella', '5141234546', 'isabella.reyes@email.com', '888 General Luna Street', 0, 46),
(47, 'Shevchenko', 'Vadym', '5141234547', 'vadym.shevchenko@email.com', '999 Khreshchatyk Street', 1, 47),
(48, 'Moreau', 'Camille', '5141234548', 'camille.moreau@email.com', '123 Rue Lepic', 0, 48),
(49, 'Ricci', 'Valentina', '5141234549', 'valentina.ricci@email.com', '234 Via del Corso', 0, 49),
(50, 'Yilmaz', 'Mehmet', '5141234550', 'mehmet.yilmaz@email.com', '345 Istiklal Avenue', 1, 50);


-- Insertion des unites
INSERT INTO Unite (id, est_disponible, id_benevole_1, id_benevole_2, id_secteur, type_unite) VALUES 
(1, 1, 1, 2, 1, 'preformee'),
(2, 1, 3, 4, 2, 'preformee'),
(3, 0, 5, NULL, 3, 'a_constituer'),
(4, 1, 6, 7, 4, 'preformee'),
(5, 0, 8, NULL, 5, 'a_constituer'),
(6, 1, 9, 10, 6, 'preformee'),
(7, 1, 11, 12, 7, 'preformee'),
(8, 0, 13, NULL, 8, 'a_constituer'),
(9, 1, 14, 15, 9, 'preformee'),
(10, 0, 16, NULL, 10, 'a_constituer'),
(11, 1, 17, 18, 11, 'preformee'),
(12, 1, 19, 20, 12, 'preformee'),
(13, 0, 21, NULL, 13, 'a_constituer'),
(14, 1, 22, 23, 14, 'preformee'),
(15, 0, 24, NULL, 15, 'a_constituer'),
(16, 1, 25, 26, 16, 'preformee'),
(17, 1, 27, 28, 17, 'preformee'),
(18, 0, 29, NULL, 18, 'a_constituer'),
(19, 1, 30, 31, 19, 'preformee'),
(20, 0, 32, NULL, 20, 'a_constituer'),
(21, 1, 33, 34, 21, 'preformee'),
(22, 1, 35, 36, 22, 'preformee'),
(23, 0, 37, NULL, 23, 'a_constituer'),
(24, 1, 38, 39, 24, 'preformee'),
(25, 0, 40, NULL, 25, 'a_constituer'),
(26, 1, 41, 42, 26, 'preformee'),
(27, 1, 43, 44, 27, 'preformee'),
(28, 0, 45, NULL, 28, 'a_constituer'),
(29, 1, 46, 47, 29, 'preformee'),
(30, 0, 48, NULL, 30, 'a_constituer'),
(31, 1, 49, 50, 31, 'preformee'),
(32, 1, 1, 3, 32, 'preformee'),
(33, 0, 5, NULL, 33, 'a_constituer'),
(34, 1, 7, 9, 34, 'preformee'),
(35, 0, 11, NULL, 35, 'a_constituer'),
(36, 1, 13, 15, 36, 'preformee'),
(37, 1, 17, 19, 37, 'preformee'),
(38, 0, 21, NULL, 38, 'a_constituer'),
(39, 1, 23, 25, 39, 'preformee'),
(40, 0, 27, NULL, 40, 'a_constituer'),
(41, 1, 29, 31, 41, 'preformee'),
(42, 1, 33, 35, 42, 'preformee'),
(43, 0, 37, NULL, 43, 'a_constituer'),
(44, 1, 39, 41, 44, 'preformee'),
(45, 0, 43, NULL, 45, 'a_constituer'),
(46, 1, 45, 47, 46, 'preformee'),
(47, 1, 2, 4, 47, 'preformee'),
(48, 0, 6, NULL, 48, 'a_constituer'),
(49, 1, 8, 10, 49, 'preformee'),
(50, 0, 12, NULL, 50, 'a_constituer');

-- Insertion des Usagers
INSERT INTO Usager VALUES
(1, 'Garcia', 'Alejandro', '5141235001', 'alejandro.garcia@email.com', '100 Calle Principal', 1),
(2, 'Wang', 'Li', '5141235002', 'li.wang@email.com', '200 Nanjing Road', 2),
(3, 'Dupont', 'Marie', '5141235003', 'marie.dupont@email.com', '300 Rue de Rivoli', 3),
(4, 'Smith', 'Emma', '5141235004', 'emma.smith@email.com', '400 Baker Street', 4),
(5, 'Schmidt', 'Hans', '5141235005', 'hans.schmidt@email.com', '500 Berliner Strasse', 5),
(6, 'Bianchi', 'Giuseppe', '5141235006', 'giuseppe.bianchi@email.com', '600 Via Roma', 6),
(7, 'Lee', 'Min-Ho', '5141235007', 'minho.lee@email.com', '700 Gangnam Boulevard', 7),
(8, 'Fernandez', 'Carmen', '5141235008', 'carmen.fernandez@email.com', '800 Plaza Mayor', 8),
(9, 'Singh', 'Arjun', '5141235009', 'arjun.singh@email.com', '900 Gandhi Road', 9),
(10, 'Yamamoto', 'Haruki', '5141235010', 'haruki.yamamoto@email.com', '1000 Sakura Street', 10);

-- Note: D'autres usagers vont etre ajoutes avec la procedure T-SQL et le script ajout_usagers.py

-- Insertion des interventions
INSERT INTO Intervention (id, date_demande, date_intervention, type_aide, statut, duree, id_usager, id_unite, id_secteur) VALUES 
(11, '2025-04-01', '2025-04-03', 'Aide medicale', 'Termine', 60, 1, 1, 1),
(12, '2025-04-02', '2025-04-04', 'Livraison repas', 'Termine', 30, 2, 1, 2),
(13, '2025-04-03', '2025-04-05', 'Visite amicale', 'Annule', NULL, 3, 2, 1),
(14, '2025-04-04', '2025-04-06', 'Aide menage', 'Termine', 45, 4, 1, 3),
(15, '2025-04-05', '2025-04-08', 'Aide medicale', 'En cours', NULL, 5, 3, 2),
(16, '2025-04-06', '2025-04-09', 'Courses', 'Pas encore commence', NULL, 6, 2, 1),
(17, '2025-04-07', '2025-04-10', 'Aide menage', 'Termine', 60, 7, 2, 2),
(18, '2025-04-08', '2025-04-11', 'Visite amicale', 'En cours', NULL, 8, 1, 3),
(19, '2025-04-09', '2025-04-12', 'Courses', 'Annule', NULL, 9, 3, 1),
(20, '2025-04-10', '2025-04-13', 'Aide medicale', 'Termine', 90, 10, 1, 2),
(21, '2025-04-11', '2025-04-14', 'Livraison repas', 'Termine', 30, 9, 2, 1),
(22, '2025-04-12', '2025-04-15', 'Visite amicale', 'En cours', NULL, 8, 2, 3),
(23, '2025-04-13', '2025-04-16', 'Aide menage', 'Termine', 50, 7, 3, 2),
(24, '2025-04-14', '2025-04-17', 'Courses', 'Pas encore commence', NULL, 6, 1, 1),
(25, '2025-04-15', '2025-04-18', 'Aide medicale', 'Termine', 70, 5, 2, 3);

-- Insertion des plaintes
INSERT INTO Plainte (id, type, description, date_signalement, statut, date_resolution, resolution, id_intervention) VALUES
(11, 'Retard', 'L’intervenant est arrive en retard.', '2025-04-04', 'Resolu', '2025-04-05', 'Excuses presentees', 11),
(12, 'Comportement', 'Manque de politesse de l’intervenant.', '2025-04-05', 'En traitement', NULL, NULL, 12),
(13, 'Service incomplet', 'L’aide prevue n’a pas ete totalement effectuee.', '2025-04-06', 'Ouvert', NULL, NULL, 13),
(14, 'Retard', 'Intervention annulee sans prevenir.', '2025-04-07', 'Ferme', '2025-04-09', 'Plainte fermee après appel.', 14),
(15, 'Erreur', 'Mauvais jour d’intervention.', '2025-04-08', 'Resolu', '2025-04-10', 'Planning mis à jour', 15),
(16, 'Qualite', 'Travail mal effectue.', '2025-04-09', 'Ouvert', NULL, NULL, 16),
(17, 'Comportement', 'Propos inappropries.', '2025-04-10', 'En traitement', NULL, NULL, 17),
(18, 'Retard', '30 minutes de retard.', '2025-04-11', 'Resolu', '2025-04-12', 'Rappel des consignes fait.', 18),
(19, 'Service incomplet', 'Oubli de documents.', '2025-04-12', 'Ouvert', NULL, NULL, 19),
(20, 'Qualite', 'Travail bacle.', '2025-04-13', 'Ferme', '2025-04-14', 'Plainte non fondee.', 20),
(21, 'Retard', 'Intervenant absent.', '2025-04-14', 'En traitement', NULL, NULL, 21),
(22, 'Erreur', 'Intervention non demandee.', '2025-04-15', 'Ouvert', NULL, NULL, 22),
(23, 'Service incomplet', 'Duree trop courte.', '2025-04-16', 'Resolu', '2025-04-17', 'Correction faite.', 23),
(24, 'Comportement', 'Ton agressif.', '2025-04-17', 'Ferme', '2025-04-18', 'Sanction appliquee.', 24),
(25, 'Qualite', 'Resultat insatisfaisant.', '2025-04-18', 'Ouvert', NULL, NULL, 25);
