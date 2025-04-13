--Transact-SQL : Implementation d'au moins un declencheur, une procedure stockee et une fonction

-- Declencheur -- 
CREATE TRIGGER VerifierTelephoneUsager
ON Usager
AFTER INSERT, UPDATE
AS
BEGIN
    IF UPDATE(telephone) OR EXISTS (SELECT * FROM inserted WHERE telephone IS NOT NULL)
    BEGIN
        IF EXISTS (
            SELECT *
            FROM inserted
            WHERE telephone IS NOT NULL
            AND (LEN(telephone) <> 10 OR telephone LIKE '%[^0-9]%')
        )
        BEGIN
            RAISERROR('Numero de telephone invalide. Doit etre 10 chiffres sans espaces', 16, 1)
            ROLLBACK TRANSACTION
        END
    END
END

GO

-- Procedure stockee -- 
CREATE PROCEDURE InsererUsager
    @id INT,
    @nom VARCHAR(25),
    @prenom VARCHAR(25),
    @telephone VARCHAR(10),
    @courriel VARCHAR(50),
    @adresse VARCHAR(50),
    @id_secteur INT
            AS
            BEGIN
                SET NOCOUNT ON;
                INSERT INTO Usager (id, nom, prenom, telephone, courriel, adresse, id_secteur)
                VALUES (@id, @nom, @prenom, @telephone, @courriel, @adresse, @id_secteur);
            END; 
GO 

-- Fonction -- 
CREATE FUNCTION NombreInterventionsParMois 
    (
        @Annee INT,
        @Mois INT
    )
    RETURNS INT
    AS
    BEGIN
        DECLARE @NombreInterventions INT;
        
        SELECT @NombreInterventions = COUNT(*)
        FROM Intervention
        WHERE YEAR(date_intervention) = @Annee
        AND MONTH(date_intervention) = @Mois;
        
        RETURN @NombreInterventions;
    END;

-- Curseur simple pour compter les benevoles par secteur
CREATE PROCEDURE CompterBenevoleParSecteur
AS
BEGIN
    DECLARE @id_secteur INT;
    DECLARE @nom_secteur VARCHAR(50);
    DECLARE @nombre_benevoles INT;
    
    -- Table temporaire pour stocker les resultats
    CREATE TABLE #ResultatsComptage (
        id_secteur INT,
        nom_secteur VARCHAR(50),
        nombre_benevoles INT
    );
    
    -- Curseur pour parcourir tous les secteurs
    DECLARE secteur_cursor CURSOR FOR
        SELECT id, nom FROM Secteur ORDER BY id;
    
    OPEN secteur_cursor;
    
    -- Recuperer le premier secteur
    FETCH NEXT FROM secteur_cursor INTO @id_secteur, @nom_secteur;
    
    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Compter les benevoles dans ce secteur
        SELECT @nombre_benevoles = COUNT(*)
        FROM Benevole
        WHERE id_secteur = @id_secteur;
        
        -- Inserer le resultat dans la table temporaire
        INSERT INTO #ResultatsComptage VALUES (@id_secteur, @nom_secteur, @nombre_benevoles);
        
        -- Passer au secteur suivant
        FETCH NEXT FROM secteur_cursor INTO @id_secteur, @nom_secteur;
    END
    
    -- Fermer et liberer le curseur
    CLOSE secteur_cursor;
    DEALLOCATE secteur_cursor;
    
    -- Afficher les resultats
    SELECT * FROM #ResultatsComptage ORDER BY nombre_benevoles DESC;
    
    -- Supprimer la table temporaire
    DROP TABLE #ResultatsComptage;
END;
GO
