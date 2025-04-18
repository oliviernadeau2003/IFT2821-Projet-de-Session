--Transact-SQL : Implementation d'au moins un declencheur, une procedure stockee et une fonction

-- Declencheur -- 
CREATE OR ALTER TRIGGER VerifierTelephoneUsager
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
CREATE OR ALTER PROCEDURE InsererUsager
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
CREATE OR ALTER FUNCTION NombreInterventionsParMois 
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
