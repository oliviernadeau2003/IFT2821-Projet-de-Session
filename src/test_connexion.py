# test_connexion.py
import pyodbc


try:
    # Connexion
    CONFIG_BD = (
        "Driver={ODBC Driver 17 for SQL Server};"   # Version du driver odbc
        "Server=127.0.0.1,1433;"                    # Nom de l'instance et le port TCP/IP (erreur localhost)
        "Database=master;"                          # Nom de la BD / Base master qui existe toujours
        "Encrypt=yes;"                              # Chiffrer la connexion
        "TrustServerCertificate=yes;"               # Remplacer par "no" avec certificat valide sur le serveur SQL
        "UID=sa;"                                   # Authentification avec SQL
        "PWD=YourStrongPassword123!;"               # Mot de passe
        "Connection Timeout=30;"                    # Timeout plus long
    )

    print("\nTentative de connexion...")
    cnxn = pyodbc.connect(CONFIG_BD)     # Etablit la connexion
    print("\nConnexion reussie!")
    curseur = cnxn.cursor()             # Curseur pour les requetes SQL

    # Recuperer et afficher les bases de donnees existantes
    print("\nBases de donnees disponibles:")
    curseur.execute("SELECT name FROM sys.databases")
    databases = [row.name for row in curseur.fetchall()]
    for db in databases:
        print(f"- {db}")

except pyodbc.Error as ex:
    # Gestion des erreurs de connexion a la base de donnees
    print("\nErreur de connexion a la base de donnees:")
    print("Exception: ", ex)

finally: # Fermer les ressources dans tous les cas (erreur ou pas)
    if 'curseur' in locals():
        curseur.close()             # Curseur existe - a fermer
    if 'cnxn' in locals():
        cnxn.close()                # Connexion existe - a fermer
print("\nFermeture du programme.")
