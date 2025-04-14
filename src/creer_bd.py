# creer_bd.py simplifie
import pyodbc
import os
import sys

# Nom de la base de donnees a creer
NOM_BD = "Projet_Centre_Aide"

# Chemin vers le fichier SQL
SQL_FOLDER = 'sql'
SQL_FILE_NAME = 'LDD_LMD.sql'
script_dir = os.path.dirname(__file__)
sql_file_path = os.path.join(script_dir, '..', SQL_FOLDER, SQL_FILE_NAME)

def get_master_connection():
    # Etablit une connexion a la BD master
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
    return pyodbc.connect(conn_str)

def get_db_connection(db_name):
    # Etablit une connexion a la BD specifique
    conn_str = (
        "Driver=ODBC Driver 17 for SQL Server;"    
        "Server=127.0.0.1,1433;"                   
        f"Database={db_name};"
        "Encrypt=yes;"                             
        "TrustServerCertificate=yes;"              
        "UID=sa;"                                  
        "PWD=YourStrongPassword123!;"              
        "Connection Timeout=60;"
    )
    return pyodbc.connect(conn_str)

def creer_base_de_donnees():
    # Verifier si la base existe et la supprimer si necessaire
    try:
        print("Connexion a la base de donnees master...")
        conn = get_master_connection()
        cursor = conn.cursor()
        
        # Verifier si la base existe
        print(f"Verification si {NOM_BD} existe...")
        cursor.execute(f"SELECT name FROM sys.databases WHERE name = '{NOM_BD}'")
        exists = cursor.fetchone() is not None
        
        if exists:
            # Supprimer la base
            cursor.execute(f"DROP DATABASE [{NOM_BD}]")
            conn.commit()
            print(f"Base {NOM_BD} supprimee.")
        
        cursor.close()
        conn.close()
    
    except Exception as e:
        print(f"Erreur lors de la verification/suppression de la base: {e}")
        return False
    
    # Creer la nouvelle base de donnees (dans une connexion separee)
    try:
        print(f"Creation de la base de donnees {NOM_BD}...")
        conn = get_master_connection()
        cursor = conn.cursor()
        
        # Creer la base
        cursor.execute(f"CREATE DATABASE [{NOM_BD}]")
        conn.commit()
        print(f"Base {NOM_BD} creee avec succes.")
        
        cursor.close()
        conn.close()
    except Exception as e:
        print(f"Erreur lors de la creation de la base: {e}")
        return False
    
    # Lire le script SQL
    try:
        print(f"Lecture du fichier SQL: {sql_file_path}")
        with open(sql_file_path, 'r', encoding='utf-8') as f:
            sql_content = f.read()
        
        # Supprimer les commandes CREATE DATABASE et USE
        sql_content = sql_content.replace(f"CREATE DATABASE {NOM_BD};", "")
        sql_content = sql_content.replace(f"USE {NOM_BD};", "")
    except Exception as e:
        print(f"Erreur lors de la lecture du fichier SQL: {e}")
        return False
    
    # Executer le script sur la nouvelle base
    try:
        print(f"Connexion a {NOM_BD} pour executer le script SQL...")
        conn = get_db_connection(NOM_BD)
        cursor = conn.cursor()
        
        # Executer chaque commande SQL individuellement
        print("Creation des tables et insertion des donnees...")
        
        statements = sql_content.split(';')
        total = len(statements)
        count = 0
        
        for statement in statements:
            if statement.strip():
                try:
                    cursor.execute(statement)
                    conn.commit()
                    count += 1
                    if count % 10 == 0:  # Afficher progression tous les 10 statements
                        print(f"Progres: {count}/{total} instructions executees")
                except pyodbc.Error as e:
                    print(f"Erreur lors de l'execution de: {statement[:50]}...")
                    print(f"Message d'erreur: {e}")
                    # On continue avec les autres instructions
        
        print(f"\nBase de donnees {NOM_BD} configuree!")
        
        cursor.close()
        conn.close()
        return True
    
    except Exception as e:
        print(f"Erreur generale: {e}")
        return False

if __name__ == "__main__":
    creer_base_de_donnees()
