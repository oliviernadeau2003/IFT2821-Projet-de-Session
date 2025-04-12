# Script pour acceder aux donnees
import pyodbc

def connexion_bd():
    conn_str = (
        "Driver=ODBC Driver 17 for SQL Server;"    
        "Server=127.0.0.1,1433;"                   
        "Database=LDD_LMD;"                        # Nom de votre BD
        "Encrypt=yes;"                             
        "TrustServerCertificate=yes;"              
        "UID=sa;"                                  
        "PWD=YourStrongPassword123!;"              
        "Connection Timeout=60;"                   
    )

    return pyodbc.connect(conn_str)

def afficher_tables():
    # Affiche toutes les tables de la base de donnees
    conn = connexion_bd()
    cursor = conn.cursor()

    cursor.execute("SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE'")

    print("Tables dans la base de données:")
    for row in cursor.fetchall():
        print(f"- {row[0]}")

    cursor.close()
    conn.close()

def afficher_secteurs():
    conn = connexion_bd()
    cursor = conn.cursor()
    
    cursor.execute("SELECT * FROM Secteur")
    
    print("\nListe des secteurs:")
    for row in cursor.fetchall():
        print(f"ID: {row.id}, Nom: {row.nom}")
    
    cursor.close()
    conn.close()

def afficher_benevoles():
    conn = connexion_bd()
    cursor = conn.cursor()
    
    cursor.execute("SELECT * FROM Benevole")
    
    print("\nListe des bénévoles:")
    for row in cursor.fetchall():
        print(f"ID: {row.id}, Nom: {row.nom}, Prénom: {row.prenom}")
    
    cursor.close()
    conn.close()

# Ajouter d'autres fonctions pour les autres tables

if __name__ == "__main__":
    # Afficher les tables disponibles
    afficher_tables()
    # Afficher les secteurs
    afficher_secteurs()
    # Afficher les benevoles
    afficher_benevoles()
