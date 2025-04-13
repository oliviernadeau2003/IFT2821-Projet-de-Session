# access_bd.py
import pyodbc
import sys


CONFIG_BD = (
    "Driver=ODBC Driver 17 for SQL Server;"    
    "Server=127.0.0.1,1433;"                   
    "Database=LDD_LMD;"                        # Nom de votre BD
    "Encrypt=yes;"                             
    "TrustServerCertificate=yes;"              
    "UID=sa;"                                  
    "PWD=YourStrongPassword123!;"              
    "Connection Timeout=60;"                   
)

# Etablit et retourne une connexion a la bd et curseur pyodbc
# Gestion d'erreurs avec blocs try/except
def get_connexion():
    conn_str = (
        f"DRIVER={CONFIG_BD['driver']};"
        f"SERVER={CONFIG_BD['server']};"
        f"DATABASE={CONFIG_BD['database']};"
    )

    try:
        connection = pyodbc.connect(conn_str)
        cursor = connection.cursor()
        print(f"Connexion reussie a la base {CONFIG_BD['database']} sur {CONFIG_BD['server']}")
        return connection, cursor

    except pyodbc.Error as ex:
        sqlstate = ex.args[0]
        print(f"Erreur de connexion à la base de données : {sqlstate}")
        print(ex)
        print("Vérifiez les paramètres dans acces_bd.py (serveur, base, driver, authentification).")
        print("Assurez-vous que le service SQL Server est démarré.")
        sys.exit(1) # Quitte le programme si la connexion échoue
