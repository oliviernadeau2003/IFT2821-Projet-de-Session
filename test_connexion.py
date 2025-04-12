# Script de test de connexion a SQL Server dans Docker
import pyodbc


try:
    # Connexion
    conn_str = (
        "Driver={ODBC Driver 17 for SQL Server};"   # Version du driver odbc
        "Server=127.0.0.1,1433;"                    # Nom de l'instance et le port TCP/IP (erreur localhost)
        "Database=master;"                          # Nom de la BD / Base master qui existe toujours
        "Encrypt=yes;"                              # Chiffrer la connexion
        "TrustServerCertificate=yes;"               # Remplacer par "no" avec certificat valide sur le serveur SQL
        "UID=sa;"                                   # Authentification avec SQL
        "PWD=YourStrongPassword123!;"               # Mot de passe
        "Connection Timeout=30;"                    # Timeout plus long
    )

    print("Tentative de connexion...")
    cnxn = pyodbc.connect(conn_str)     # Etablit la connexion
    print("Connexion reussie!")
    curseur = cnxn.cursor()             # Curseur pour les requetes SQL

    # Verifier les bases de donnees existantes
    print("\nBases de données disponibles:")
    curseur.execute("SELECT name FROM sys.databases")
    databases = [row.name for row in curseur.fetchall()]
    for db in databases:
        print(f"- {db}")

    # Requete SQL test
    #sqlCommand = "SELECT * FROM Secteur;"
    #curseur.execute(sqlCommand)

    # Recurpere et affiche les resultats
    #for row in curseur.fetchall():
    #    print(f"ID: {row.id}, Nom: {row.nom}")

except pyodbc.Error as ex:
    # Gestion des erreurs de connexion a la base de donnees
    print("\nErreur de connexion à la base de données:")
    print("Exception: ", ex)
    
finally:    # Fermer les ressources dans tous les cas
    if 'curseur' in locals():
        curseur.close()     # Curseur existe - à fermer
    if 'cnxn' in locals():
        cnxn.close()        # Connexion existe - a fermer
print("Fermeture du programme.")
