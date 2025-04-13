--  4. Transact-SQL (15%)


        -- Implantation d'au moins un déclencheur, une procédure stockée, une fonction

            -- Declencheur------------------------------------------
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
            RAISERROR('Numéro de téléphone invalide. Doit être 10 chiffres sans espaces', 16, 1)
            ROLLBACK TRANSACTION
        END
    END
END

go




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

