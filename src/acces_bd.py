# access_bd.py
import pyodbc
import sys


CONFIG_BD = (
    "Driver=ODBC Driver 17 for SQL Server;"
    "Server=127.0.0.1,1433;"
    "Database=Projet_Centre_Aide;"
    "Encrypt=yes;"
    "TrustServerCertificate=yes;"
    "UID=sa;"
    "PWD=YourStrongPassword123!;"
    "Connection Timeout=60;"
)

# Etablit et retourne une connexion a la bd et curseur pyodbc
def get_connexion():
    try:
        connection = pyodbc.connect(CONFIG_BD)
        cursor = connection.cursor()
        print(f"Connexion reussie a la base de donnees Projet_Centre_Aide")
        return connection, cursor

    except pyodbc.Error as ex:
        sqlstate = ex.args[0] if len(ex.args) > 0 else 'Unknown'
        print(f"Erreur de connexion a la base de donnees : {sqlstate}")
        print(ex)
        sys.exit(1) # Quitter le programme si la connexion echoue
