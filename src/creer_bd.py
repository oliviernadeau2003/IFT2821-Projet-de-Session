# creer_bd.py
import pyodbc
import os
import sys

# Importe la fonction de connexion depuis acces_bd.py
try:
    from acces_bd import get_connexion
except ImportError:
    print("ERREUR: Impossible d'importer 'get_connexion' depuis 'acces_bd.py'.")
    sys.exit(1)

SQL_FILE_NAME = 'LDD_LMD.sql'   # Nom du fichier SQL
SQL_FOLDER = 'sql'              # Nom du dossier contenant les fichiers SQL

script_dir = os.path.dirname(__file__) # Determine chemin absolu vers le fichier SQL
sql_file_path = os.path.join(script_dir, '..', SQL_FOLDER, SQL_FILE_NAME) # Construit le chemin et liens


# --- Fonction Principale ---
def creer_base_de_donnees():
    # Lit et execute le script SQL LDD/LMD pour creer/peupler la bd
    connection = None
    cursor = None

    # !!! RAPPEL TRÈS IMPORTANT !!!
    # Ce script suppose que vous avez MANUELLEMENT SUPPRIMÉ 
    # TOUTES les instructions 'GO' de votre fichier LDD_LMD.sql.
    # pyodbc ne comprend pas 'GO' et échouera si elles sont présentes.
    try:
        print(f"Lecture du script SQL depuis : {sql_file_path}")
        with open(sql_file_path, 'r', encoding='utf-8') as f:
            sql_script = f.read()
        print("Lecture du script SQL terminee.")

        # Verifie si le script n'est pas vide
        if not sql_script.strip():
            print("ERREUR: Le fichier SQL semble vide.")
            return

        print("Tentative de connexion a la base de donnees...")
        connection, cursor = get_connexion() 
        
        if not connection or not cursor:
             print("Echec de l'obtention de la connexion depuis acces_bd.")
             return 

        print("Execution du script SQL...")
        cursor.execute(sql_script) # Execute le script SQL complet
        
        print("Validation des changements (commit)...")
        connection.commit() # Valide la transaction
        
        print("-" * 30)
        print("SUCCES : La base de donnees a ete creee/peuplee avec succes.")
        print("-" * 30)

    except FileNotFoundError:
        print(f"ERREUR CRITIQUE : Le fichier SQL '{sql_file_path}' n'a pas ete trouve.")

    except pyodbc.Error as ex:
        sqlstate = ex.args[0]
        print(f"ERREUR pyodbc lors de l'execution du script SQL : {sqlstate}")
        print(ex)

        if connection:
            print("Tentative d'annulation des changements (rollback)...")
            try:
                connection.rollback()
                print("Rollback effectue.")
            except pyodbc.Error as rb_ex:
                print(f"Erreur lors du rollback : {rb_ex}")

    except ImportError:
         print("Erreur d'importation de acces_bd.py.")

    except Exception as e:
        print(f"ERREUR INATTENDUE : {e}")
        if connection:
            print("Tentative d'annulation des changements (rollback) suite a une erreur inattendue...")
            try:
                connection.rollback()
                print("Rollback effectue.")
            except pyodbc.Error as rb_ex:
                 print(f"Erreur lors du rollback : {rb_ex}")

    finally:
        # Ferme le curseur et la connexion s'ils ont ete ouverts
        if cursor:
            cursor.close()
            print("Curseur fermé.")
        if connection:
            connection.close()
            print("Connexion fermée.")

# Point d'entree du script
if __name__ == "__main__":
    creer_base_de_donnees()
