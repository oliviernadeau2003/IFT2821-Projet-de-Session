--  4. Transact-SQL (15%)


        -- Implantation d'au moins un déclencheur, une procédure stockée, une fonction

            -- Declencheur-----------------------------------------
CREATE TRIGGER TR_VerifierVoitureDansEquipe
ON Equipe
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT e.id
        FROM inserted e
        LEFT JOIN Benevole b1 ON e.id_benevole_1 = b1.id
        LEFT JOIN Benevole b2 ON e.id_benevole_2 = b2.id
        WHERE (b1.possede_voiture = 0 OR b1.possede_voiture IS NULL)
          AND (b2.possede_voiture = 0 OR b2.possede_voiture IS NULL)
    )
    BEGIN
        ROLLBACK TRANSACTION
        RAISERROR('Chaque équipe doit avoir au moins un bénévole avec voiture', 16, 1)
        RETURN
    END
END;
GO




            -- une procédure stockée---------------------------------------------------
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




            -- une fonction------------------------------------------------
CREATE FUNCTION fn_NombreInterventionsParMois 
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
    WHERE YEAR(DateIntervention) = @Annee
    AND MONTH(DateIntervention) = @Mois;
    
    RETURN @NombreInterventions;
END;
GO 

