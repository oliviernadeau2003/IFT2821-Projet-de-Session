# Script pour creer la base de donnees
import pyodbc

print("Creation et configuration de la base de données...")

try:
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

    print("Connexion à SQL Server...")
    conn = pyodbc.connect(conn_str)
    cursor = conn.cursor()

    # Lire le contenu du fichier SQL
    with open('LDD_LMD.sql', 'r') as file:
        sql_commands = file.read()

    # Executer les commandes SQL
    print("Exécution du script SQL...")

    # Executer ligne par ligne
    for line in sql_commands.split(';'):
        if line.strip():  # Ignorer les lignes vides
            try:
                cursor.execute(line)
                conn.commit()
            except pyodbc.Error as e:
                print(f"Ignore: {e}")

    print("Base de donnees creee avec succes!")

    # Verifier que la base a ete creee
    cursor.execute("SELECT name FROM sys.databases")
    print("\nBases de données disponibles:")
    for row in cursor.fetchall():
        print(f"- {row[0]}")
    
    cursor.close()
    conn.close()
    
except pyodbc.Error as e:
    print(f"Erreur: {e}")

print("Termine!")
