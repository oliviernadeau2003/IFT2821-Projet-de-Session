# operations_bd.py
import pyodbc
from src.acces_bd import get_connexion # Importe la fonction du fichier acces_bd.py

def afficher_les_usagers():
    # Recupere et affiche la liste de tous les usagers
    conn, cursor = None, None # Initialisation pour le bloc finally
    
    try:
        conn, cursor = get_connexion()
        sql_query = "SELECT id, nom, prenom FROM Usager"
        cursor.execute(sql_query)
        resultats = cursor.fetchall() # Recupere toutes les lignes
        return resultats
    
    except pyodbc.Error as ex:
        print(f"Erreur lors de la recuperation des clients: {ex}")
        return [] # Retourne une liste vide en cas d'erreur

    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()

def mettre_a_jour_nom_usager(id_usager, nouveau_nom):
    # Met a jour le nom d'un usage base sur son id
    conn, cursor = None, None
    try:
        conn, cursor = get_connexion()
        sql_update = "UPDATE Usager SET nom = ? WHERE id = ?"
        cursor.execute(sql_update, nouveau_nom, id_usager) # Ordre important
        conn.commit() # Sauvegarder les changements
        print(f"Client avec code '{id_usager}' mis a jour.")
        return True
    
    except pyodbc.Error as ex:
        print(f"Erreur lors de la mise a jour du client '{id_usager}': {ex}")
        conn.rollback() # Annule les changements en cas d'erreur
        return False
    
    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()

def appeler_procedure_exemple(parametre1, parametre2):
    # Appelle une procedure stockee 'NomDeProcedure'
    conn, cursor = None, None
    try:
        conn, cursor = get_connexion()
        # Adaptez le nom de la procedure et les parametres
        sql_call = "{CALL NomDeProcedure (?, ?)}" 
        cursor.execute(sql_call, parametre1, parametre2)
        
        # Si la procedure retourne des resultats (SELECT e l'interieur)
        # results = cursor.fetchall() 
        # Traitez les resultats ici si necessaire

        conn.commit() # Si la procedure modifie des donnees
        print("Procedure stockee executee.")
        # return results # Si elle retourne des resultats
        return True # Ou simplement un succes
    except pyodbc.Error as ex:
        print(f"Erreur lors de l'appel de la procedure: {ex}")
        # conn.rollback() # Si elle modifie des donnees
        return False
    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()

def appeler_fonction_exemple(parametre_id): # Exemple pour une fonction UDF
    # Appelle une fonction 'dbo.ufnGetCusCode' et retourne le resultat
    conn, cursor = None, None
    try:
        conn, cursor = get_connexion()
        # Adaptez le nom de la fonction et le parametre
        sql_call = "SELECT dbo.ufnGetCusCode(?) AS ResultatFonction" 
        cursor.execute(sql_call, parametre_id)
        resultat = cursor.fetchone() # Recupere la seule ligne/colonne attendue
        if resultat:
            return resultat.ResultatFonction # Acces par nom de colonne alias
        else:
            return None
    except pyodbc.Error as ex:
        print(f"Erreur lors de l'appel de la fonction: {ex}")
        return None
    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()

# Ajoutez fonctions pour requetes et T-SQL
    # Ex: une fonction pour chaque requete de requetes.sql
    # Ex: une fonction pour appeler trigger (indirectement via INSERT/UPDATE/DELETE)
    # Ex: une fonction pour utiliser curseur (si pertinent depuis Python)
