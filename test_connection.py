import pyodbc

conn_str = (
    "Driver={ODBC Driver 17 for SQL Server};"   # Version du driver odbc
    "Server=localhost;"                         # Nom de l'instance
    "Database=sql-server;"                      # Nom de la BD
    "Encrypt=yes;"                              # Chiffrer la connexion
    "TrustServerCertificate=yes;"               # Remplacer par "no" si certificat valide sur le serveur SQL
    "UID=sa;"                                   # Authentification avec SQL
    "PWD=YourStrongPassword;"                   # YourStrongPassword123!
)
cnxn = pyodbc.connect(conn_str)

