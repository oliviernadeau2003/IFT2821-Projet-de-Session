-- Olivier Nadeau, Yonah Lahlou, Ahmadou Ayande, ...

-- REQUETES SIMPLES --
-- R1.1 : Afficher l'ensemble des usagers enregistres dans la table Usager.
SELECT *
FROM Usager;

--R1.2 : Afficher tous les benevoles pour lesquels la colonne possede_voiture est vraie 
SELECT *
FROM Benevole
WHERE possede_voiture = 1;

--R1.3 : Afficher toutes les interventions dont le statut est « Termine ».
SELECT *
FROM Intervention
WHERE status = 'Termine';

--R1.4 : Afficher toutes les plaintes dont le statut est « Ouvert ».
SELECT *
FROM Plainte
WHERE statut = 'Ouvert';

--R1.5 : Affiche tous les details des usagers, tries par ordre alphabetique de leur nom.
SELECT id, nom, prenom, telephone, courriel, adresse, id_secteur
FROM Usager
ORDER BY nom;

-- REQUETES COMPLEXES --
---R2.1 : Afficher les interventions dont l'usager et l'equipe proviennent de secteurs differents.
SELECT Intervention.id AS id_intervention,
       Usager.nom AS nom_usager,
       SecteurUsager.nom AS secteur_usager,
       SecteurEquipe.nom AS secteur_equipe
FROM Intervention
JOIN Usager ON Intervention.id_usager = Usager.id
JOIN Equipe ON Intervention.id_equipe = Equipe.id
JOIN Secteur AS SecteurUsager ON Usager.id_secteur = SecteurUsager.id
JOIN Secteur AS SecteurEquipe ON Equipe.id_secteur = SecteurEquipe.id
WHERE SecteurUsager.id <> SecteurEquipe.id;

--R2.2 Pour chaque intervention : 
    -- Afficher l'identifiant de l'intervention, la date d'intervention, le nom de l'usager, le secteur auquel l'usager appartient et les noms des benevoles intervenants (le benevole principal et, le cas echeant, le second).
SELECT Intervention.id AS id_intervention,
       Intervention.date_intervention,
       Usager.nom AS nom_usager,
       Secteur.nom AS secteur_usager,
       BenevolePrincipal.nom AS benevole_principal,
       BenevoleSecondaire.nom AS benevole_secondaire
FROM Intervention
JOIN Usager ON Intervention.id_usager = Usager.id
JOIN Secteur ON Usager.id_secteur = Secteur.id
JOIN Equipe ON Intervention.id_equipe = Equipe.id
JOIN Benevole AS BenevolePrincipal ON Equipe.id_benevole_1 = BenevolePrincipal.id
LEFT JOIN Benevole AS BenevoleSecondaire ON Equipe.id_benevole_2 = BenevoleSecondaire.id;

--R2.3 Pour chaque intervention effectuee par une equipe de type « preformee » :
    -- Afficher l'identifiant et la date de l'intervention, le nom de l'usager, le secteur d'affectation de l'equipe et le statut de disponibilie.
SELECT Intervention.id AS id_intervention,
       Intervention.date_intervention,
       Usager.nom AS nom_usager,
       SecteurEquipe.nom AS secteur_equipe,
       Equipe.type_equipe,
       Equipe.est_disponible
FROM Intervention
JOIN Usager ON Intervention.id_usager = Usager.id
JOIN Equipe ON Intervention.id_equipe = Equipe.id
JOIN Secteur AS SecteurEquipe ON Equipe.id_secteur = SecteurEquipe.id
WHERE Equipe.type_equipe = 'preformee';

--R2.4 Pour chaque plainte en statut « Ouvert » :
    -- Afficher l'identifiant et le type de la plainte, la date de signalement, l'identifiant de l'intervention associee, le nom de l'usager ayant demande l'intervention et le secteur auquel cet usager appartient.
SELECT Plainte.id AS id_plainte,
       Plainte.type AS type_plainte,
       Plainte.date_signalement,
       Intervention.id AS id_intervention,
       Usager.nom AS nom_usager,
       SecteurUsager.nom AS secteur_usager
FROM Plainte
JOIN Intervention ON Plainte.id_intervention = Intervention.id
JOIN Usager ON Intervention.id_usager = Usager.id
JOIN Secteur AS SecteurUsager ON Usager.id_secteur = SecteurUsager.id
WHERE Plainte.statut = 'Ouvert';

--R2.5 : Ici, on relie Benevole au Secteur puis on joint la table Equipe en verifiant si le benevole intervient comme premier ou second membre. Apres, on joint Intervention pour compter l’ensemble des interventions dans lesquelles le benevole a participe.
SELECT 
    Benevole.id AS id_benevole,
    Benevole.nom AS nom_benevole,
    SecteurBenevole.nom AS secteur,
    COUNT(Intervention.id) AS nb_interventions
FROM Benevole
JOIN Secteur AS SecteurBenevole ON Benevole.id_secteur = SecteurBenevole.id
JOIN Equipe ON (Benevole.id = Equipe.id_benevole_1 OR Benevole.id = Equipe.id_benevole_2)
JOIN Intervention ON Equipe.id = Intervention.id_equipe
GROUP BY Benevole.id, Benevole.nom, SecteurBenevole.nom;
