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


# Fonction Principale
def creer_base_de_donnees():
    # Lit et execute le script SQL LDD/LMD pour creer/peupler la BD
    connection = None
    cursor = None

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
        # Connecter a master en premier
        conn_str = (
            "Driver=ODBC Driver 17 for SQL Server;"    
            "Server=127.0.0.1,1433;"                   
            "Database=master;"                       
            "Encrypt=yes;"                             
            "TrustServerCertificate=yes;"              
            "UID=sa;"                                  
            "PWD=YourStrongPassword123!;"              
            "Connection Timeout=60;"                   
        )
        connection = pyodbc.connect(conn_str)
        cursor = connection.cursor()
        
        # Verifie si la base de donnees existe et la supprime au besoin
        cursor.execute("SELECT name FROM sys.databases WHERE name = 'Projet_Centre_Aide'")
        if cursor.fetchone():
            print("La base de donnees Projet_Centre_Aide existe. Tentative de suppression...")
            # Fermer toutes les connexions existantes a cette base
            cursor.execute("""
                ALTER DATABASE Projet_Centre_Aide SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
                DROP DATABASE Projet_Centre_Aide;
            """)
            connection.commit()
            print("Ancienne base de donnees supprimee.")

        print("Execution du script SQL...")
        # Separer et executer chaque instruction individuellement
        for statement in sql_script.split(';'):
            if statement.strip():  # Ignorer les instructions vides
                try:
                    cursor.execute(statement)
                    connection.commit()  # Commit apres chaque instruction
                except pyodbc.Error as stmt_ex:
                    print(f"Erreur lors de l'execution de l'instruction: {stmt_ex}")
                    print(f"Instruction qui a echoue: {statement[:100]}...")
                    raise    

        print("Validation des changements (commit)...")
        connection.commit() # Valide la transaction

        print("-" * 30)
        print("SUCCES : La base de donnees Projet_Centre_Aide a ete creee et peuplee avec succes.")
        print("-" * 30)

    except FileNotFoundError:
        print(f"ERREUR CRITIQUE : Le fichier SQL '{sql_file_path}' n'a pas ete trouve.")

    except pyodbc.Error as ex:
        sqlstate = ex.args[0] if len(ex.args) > 0 else 'Unknown'
        print(f"ERREUR pyodbc lors de l'execution du script SQL : {sqlstate}")
        print(ex)

        if connection:
            print("Tentative d'annulation des changements (rollback)...")
            try:
                connection.rollback()
                print("Rollback effectue.")
            except pyodbc.Error as rb_ex:
                print(f"Erreur lors du rollback : {rb_ex}")

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
