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

try:
    # Establish connection
    conn = pyodbc.connect(conn_str)
    cursor = conn.cursor()
    
    # Test query
    cursor.execute("SELECT @@VERSION")
    row = cursor.fetchone()
    print(f"Connection successful! SQL Server version: {row[0]}")
    
    # Close connections
    cursor.close()
    conn.close()
except Exception as e:
    print(f"Connection failed: {str(e)}")
