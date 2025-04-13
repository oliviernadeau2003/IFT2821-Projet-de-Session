-- Olivier Nadeau, Yonah Lahlou, Ahmadou Ayande, ...
-- Ensemble des requêtes SQL (5 simples et 5 complexes) en plus de toutes requêtes additionnelles utilisées dans le projet

-- Requêtes Simples : 

-- R1 --------------------------------------
--   Afficher l'ensemble des usagers enregistrés dans la table Usager.
SELECT *
FROM Usager;



--R2----------------------------------------
--Afficher tous les bénévoles pour lesquels la colonne possede_voiture est vraie 
SELECT *
FROM Benevole
WHERE possede_voiture = 1;



--R3-----------------------------------------
--Afficher toutes les interventions dont le statut est « Terminé »
SELECT *
FROM Intervention
WHERE status = 'Terminé';



--R4-----------------------------------------
--Afficher toutes les plaintes dont le statut est « Ouvert »
SELECT *
FROM Plainte
WHERE statut = 'Ouvert';


--R5-------------------------------------------
--Affiche tous les détails des usagers, triés par ordre alphabétique de leur nom.
SELECT id, nom, prenom, telephone, courriel, adresse, id_secteur
FROM Usager
ORDER BY nom;






-- Requêtes Complexes : 

        ---r1 - Afficher les interventions dont l'usager et l'équipe proviennent de secteurs différents.
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


        --r2 -------------------------------------------------  
        -- Pour chaque intervention, 
        --afficher l'identifiant de l'intervention, la date d'intervention, le nom de l'usager, le secteur
        -- auquel l'usager appartient et les noms des bénévoles intervenants (le bénévole principal et, le cas échéant, le second).

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


    --r3  -----------------------------------------------------------
    /* Pour chaque intervention effectuée par une équipe de type « preformee », 
        afficher l'identifiant et la date de l'intervention, le nom de l'usager, le secteur d'affectation de l'équipe
        et le statut de disponibilité  */
        
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


    --R4 --------------------------------------------------------------
/*
    Pour chaque plainte en statut « Ouvert », 
    afficher l'identifiant et le type de la plainte, la date de signalement,
     l'identifiant de l'intervention associée, 
     le nom de l'usager ayant demandé l'intervention et 
     le secteur auquel cet usager appartient
*/
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


--R5------------------------------------------------------------------------

/*
    ici, on relie Benevole à Secteur puis on joint la table Equipe en vérifiant si le bénévole intervient comme premier ou second membre. 
    Apres, on joint Intervention pour compter l’ensemble des interventions dans lesquelles le bénévole a participé.
*/

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
