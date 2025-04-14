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

def creer_base_de_donnees():
    connection = None
    cursor = None

    try:
        # Connexion a master
        print("Connexion a la base de donnees master...")
        master_conn_str = (
            "Driver=ODBC Driver 17 for SQL Server;"    
            "Server=127.0.0.1,1433;"                   
            "Database=master;"                       
            "Encrypt=yes;"                             
            "TrustServerCertificate=yes;"              
            "UID=sa;"                                  
            "PWD=YourStrongPassword123!;"              
            "Connection Timeout=60;"                   
        )
        connection = pyodbc.connect(master_conn_str)
        cursor = connection.cursor()
        
        # Supprimer la BD si elle existe
        print(f"Verification si {NOM_BD} existe...")
        cursor.execute(f"IF EXISTS(SELECT * FROM sys.databases WHERE name='{NOM_BD}') BEGIN ALTER DATABASE [{NOM_BD}] SET SINGLE_USER WITH ROLLBACK IMMEDIATE; DROP DATABASE [{NOM_BD}] END")
        connection.commit()
        
        # Creer la nouvelle base de donnees
        print(f"Creation de la base de donnees {NOM_BD}...")
        cursor.execute(f"CREATE DATABASE [{NOM_BD}]")
        connection.commit()
        
        # Fermer la connexion a master
        cursor.close()
        connection.close()
        
        # Lire le fichier SQL pour les tables et donnees
        print(f"Lecture du fichier SQL: {sql_file_path}")
        with open(sql_file_path, 'r', encoding='utf-8') as f:
            sql_content = f.read()
        
        # Se connecter a la nouvelle base
        print(f"Connexion a {NOM_BD}...")
        db_conn_str = (
            "Driver=ODBC Driver 17 for SQL Server;"    
            "Server=127.0.0.1,1433;"                   
            f"Database={NOM_BD};"
            "Encrypt=yes;"                             
            "TrustServerCertificate=yes;"              
            "UID=sa;"                                  
            "PWD=YourStrongPassword123!;"              
            "Connection Timeout=60;"
        )
        connection = pyodbc.connect(db_conn_str)
        cursor = connection.cursor()
        
        # Executer les commandes SQL pour creer les tables et inserer les donnees
        print("Creation des tables et insertion des donnees...")
        # Supprimer les commandes CREATE DATABASE et USE de notre script
        sql_content = sql_content.replace(f"CREATE DATABASE {NOM_BD};", "")
        sql_content = sql_content.replace(f"USE {NOM_BD};", "")
        
        # Executer chaque commande SQL individuellement
        for statement in sql_content.split(';'):
            if statement.strip():
                try:
                    cursor.execute(statement)
                    connection.commit()
                except pyodbc.Error as e:
                    print(f"Erreur lors de l'execution de: {statement[:50]}...")
                    print(f"Message d'erreur: {e}")
                    connection.rollback()
        
        print(f"\nBase de donnees {NOM_BD} creee avec succes!")

    except Exception as e:
        print(f"Erreur: {e}")
        if connection:
            try:
                connection.rollback()
            except:
                pass
    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()

if __name__ == "__main__":
    creer_base_de_donnees()
