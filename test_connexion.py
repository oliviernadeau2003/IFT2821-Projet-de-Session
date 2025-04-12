import pyodbc

conn_str = (
    "Driver={ODBC Driver 17 for SQL Server};"   # Version du driver odbc
    "Server=localhost;"                         # Nom de l'instance
    "Database=sql-server;"                      # Nom de la BD
    "Encrypt=yes;"                              # Chiffrer la connexion
    "TrustServerCertificate=yes;"
    "UID=sa;"
    "PWD=YourStrongPassword;"
)
cnxn = pyodbc.connect(conn_str)
