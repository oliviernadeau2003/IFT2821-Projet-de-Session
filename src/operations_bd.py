# operations_bd.py
import pyodbc
from src.acces_bd import get_connexion # Importe la fonction du fichier acces_bd.py


# FONCTIONS POUR LES REQUETES SIMPLES (R1)
def lister_les_usagers():
    # R1.1 : Afficher l'ensemble des usagers enregistres dans la table Usager.
    conn, cursor = None, None # Initialisation pour le bloc finally
    try:
        conn, cursor = get_connexion()
        sql_query = "SELECT * FROM Usager"
        cursor.execute(sql_query)
        resultats = cursor.fetchall()
        return resultats

    except pyodbc.Error as ex:
        print(f"Erreur lors de la recuperation des usagers: {ex}")
        return [] # Retourne une liste vide en cas d'erreur

    finally:
        if cursor: cursor.close()
        if conn: conn.close()

def lister_benevoles_avec_voiture():
    # R1.2 : Afficher tous les benevoles pour lesquels la colonne possede_voiture est vraie.
    conn, cursor = None, None
    try:
        conn, cursor = get_connexion()
        sql_query = "SELECT * FROM Benevole WHERE possede_voiture = 1"
        cursor.execute(sql_query)
        resultats = cursor.fetchall()
        return resultats

    except pyodbc.Error as ex:
        print(f"Erreur lors de la récupération des bénévoles: {ex}")
        return []

    finally:
        if cursor: cursor.close()
        if conn: conn.close()

def lister_interventions_terminees():
    # R1.3 : Afficher toutes les interventions dont le statut est 'Termine'.
    conn, cursor = None, None
    try:
        conn, cursor = get_connexion()
        sql_query = "SELECT * FROM Intervention WHERE status = 'Termine'"
        cursor.execute(sql_query)
        resultats = cursor.fetchall()
        return resultats

    except pyodbc.Error as ex:
        print(f"Erreur lors de la recuperation des interventions: {ex}")
        return []

    finally:
        if cursor: cursor.close()
        if conn: conn.close()

def lister_plaintes_ouvertes():
    # R1.4 : Afficher toutes les plaintes dont le statut est 'Ouvert'.
    conn, cursor = None, None
    try:
        conn, cursor = get_connexion()
        sql_query = "SELECT * FROM Plainte WHERE statut = 'Ouvert'"
        cursor.execute(sql_query)
        resultats = cursor.fetchall()
        return resultats

    except pyodbc.Error as ex:
        print(f"Erreur lors de la recuperation des plaintes: {ex}")
        return []

    finally:
        if cursor: cursor.close()
        if conn: conn.close()

def lister_usagers_par_nom():
    # R1.5 : Affiche tous les d3tails des usagers, tries par ordre alphabetique de leur nom.
    conn, cursor = None, None
    try:
        conn, cursor = get_connexion()
        sql_query = """
            SELECT id, nom, prenom, telephone, courriel, adresse, id_secteur
            FROM Usager
            ORDER BY nom
        """
        cursor.execute(sql_query)
        resultats = cursor.fetchall()
        return resultats

    except pyodbc.Error as ex:
        print(f"Erreur lors de la recuperation des usagers: {ex}")
        return []

    finally:
        if cursor: cursor.close()
        if conn: conn.close()


# FONCTIONS POUR LES REQUETES COMPLEXES (R2)
def interventions_secteurs_differents():
    # R2.1 : Afficher les interventions dont l'usager et l'equipe proviennent de secteurs differents.
    conn, cursor = None, None
    try:
        conn, cursor = get_connexion()
        sql_query = """
            SELECT Intervention.id AS id_intervention,
                   Usager.nom AS nom_usager,
                   SecteurUsager.nom AS secteur_usager,
                   SecteurEquipe.nom AS secteur_equipe
            FROM Intervention
            JOIN Usager ON Intervention.id_usager = Usager.id
            JOIN Equipe ON Intervention.id_equipe = Equipe.id
            JOIN Secteur AS SecteurUsager ON Usager.id_secteur = SecteurUsager.id
            JOIN Secteur AS SecteurEquipe ON Equipe.id_secteur = SecteurEquipe.id
            WHERE SecteurUsager.id <> SecteurEquipe.id
        """
        cursor.execute(sql_query)
        resultats = cursor.fetchall()
        return resultats

    except pyodbc.Error as ex:
        print(f"Erreur lors de l'execution de la requête complexe R2.1: {ex}")
        return []

    finally:
        if cursor: cursor.close()
        if conn: conn.close()

def details_interventions():
    # R2.2 : Pour chaque intervention, afficher l'ID, date, nom usager, secteur et noms des benevoles.
    conn, cursor = None, None
    try:
        conn, cursor = get_connexion()
        sql_query = """
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
            LEFT JOIN Benevole AS BenevoleSecondaire ON Equipe.id_benevole_2 = BenevoleSecondaire.id
        """
        cursor.execute(sql_query)
        resultats = cursor.fetchall()
        return resultats

    except pyodbc.Error as ex:
        print(f"Erreur lors de l'execution de la requete complexe R2.2: {ex}")
        return []

    finally:
        if cursor: cursor.close()
        if conn: conn.close()

def interventions_equipes_preformees():
    # R2.3 : Interventions effectuees par equipes preformees avec details.
    conn, cursor = None, None
    try:
        conn, cursor = get_connexion()
        sql_query = """
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
            WHERE Equipe.type_equipe = 'preformee'
        """
        cursor.execute(sql_query)
        resultats = cursor.fetchall()
        return resultats

    except pyodbc.Error as ex:
        print(f"Erreur lors de l'execution de la requete complexe R2.3: {ex}")
        return []

    finally:
        if cursor: cursor.close()
        if conn: conn.close()

def plaintes_ouvertes_details():
    # R2.4 : Pour chaque plainte en statut 'Ouvert', afficher les details avec usager et secteur.
    conn, cursor = None, None
    try:
        conn, cursor = get_connexion()
        sql_query = """
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
            WHERE Plainte.statut = 'Ouvert'
        """
        cursor.execute(sql_query)
        resultats = cursor.fetchall()
        return resultats

    except pyodbc.Error as ex:
        print(f"Erreur lors de l'execution de la requete complexe R2.4: {ex}")
        return []

    finally:
        if cursor: cursor.close()
        if conn: conn.close()

def nombre_interventions_par_benevole():
    # R2.5 : Nombre d'interventions par benevole avec details du secteur.
    conn, cursor = None, None
    try:
        conn, cursor = get_connexion()
        sql_query = """
            SELECT 
                Benevole.id AS id_benevole,
                Benevole.nom AS nom_benevole,
                SecteurBenevole.nom AS secteur,
                COUNT(Intervention.id) AS nb_interventions
            FROM Benevole
            JOIN Secteur AS SecteurBenevole ON Benevole.id_secteur = SecteurBenevole.id
            JOIN Equipe ON (Benevole.id = Equipe.id_benevole_1 OR Benevole.id = Equipe.id_benevole_2)
            JOIN Intervention ON Equipe.id = Intervention.id_equipe
            GROUP BY Benevole.id, Benevole.nom, SecteurBenevole.nom
        """
        cursor.execute(sql_query)
        resultats = cursor.fetchall()
        return resultats

    except pyodbc.Error as ex:
        print(f"Erreur lors de l'execution de la requete complexe R2.5: {ex}")
        return []

    finally:
        if cursor: cursor.close()
        if conn: conn.close()


# FONCTIONS POUR LES PROCEDURES STOCKEES ET FONCTIONS T-SQL
def inserer_usager(id, nom, prenom, telephone, courriel, adresse, id_secteur):
    # Utilise la procédure stockee InsererUsager pour ajouter un nouvel usager.
    conn, cursor = None, None
    try:
        conn, cursor = get_connexion()
        sql_call = "{CALL InsererUsager (?, ?, ?, ?, ?, ?, ?)}"
        cursor.execute(sql_call, id, nom, prenom, telephone, courriel, adresse, id_secteur)
        conn.commit()
        print(f"Usager {nom} {prenom} ajoute avec succes.")
        return True
    
    except pyodbc.Error as ex:
        print(f"Erreur lors de l'appel de la procédure InsererUsager: {ex}")
        if conn: conn.rollback()
        return False
    
    finally:
        if cursor: cursor.close()
        if conn: conn.close()

def obtenir_interventions_par_mois(annee, mois):
    # Utilise la fonction SQL NombreInterventionsParMois pour compter les interventions.
    conn, cursor = None, None
    try:
        conn, cursor = get_connexion()
        sql_call = "SELECT dbo.NombreInterventionsParMois(?, ?) AS NombreInterventions"
        cursor.execute(sql_call, annee, mois)
        resultat = cursor.fetchone()
        if resultat:
            return resultat.NombreInterventions
        else:
            return 0
    
    except pyodbc.Error as ex:
        print(f"Erreur lors de l'appel de la fonction NombreInterventionsParMois: {ex}")
        return -1
    
    finally:
        if cursor: cursor.close()
        if conn: conn.close()

def mettre_a_jour_usager(id, nom, prenom, telephone, courriel, adresse, id_secteur):
    # Met a jour les informations d'un usager et declenche potentiellement le trigger VerifierTelephoneUsager.
    conn, cursor = None, None
    try:
        conn, cursor = get_connexion()
        sql_update = """
            UPDATE Usager 
            SET nom = ?, prenom = ?, telephone = ?, courriel = ?, adresse = ?, id_secteur = ?
            WHERE id = ?
        """
        cursor.execute(sql_update, nom, prenom, telephone, courriel, adresse, id_secteur, id)
        conn.commit()
        print(f"Usager avec ID {id} mis s jour avec succes.")
        return True
    
    except pyodbc.Error as ex:
        print(f"Erreur lors de la mise a jour de l'usager (potentiellement declenchee par le trigger): {ex}")
        if conn: conn.rollback()
        return False
    
    finally:
        if cursor: cursor.close()
        if conn: conn.close()
