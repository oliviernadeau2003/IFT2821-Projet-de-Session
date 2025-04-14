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
    bases_donnees = [row.name for row in curseur.fetchall()]
    for bd in bases_donnees:
        print(f"- {bd}")

# Test de connexion a la base Projet_Centre_Aide si elle existe
    if 'Projet_Centre_Aide' in bases_donnees:
        print("\nTentative de connexion a Projet_Centre_Aide...")
        cnxn.close()  # Ferme la connexion actuelle
        
        config_projet = (
            "Driver={ODBC Driver 17 for SQL Server};"
            "Server=127.0.0.1,1433;"
            "Database=Projet_Centre_Aide;"
            "Encrypt=yes;"
            "TrustServerCertificate=yes;"
            "UID=sa;"
            "PWD=YourStrongPassword123!;"
            "Connection Timeout=30;"
        )
        
        cnxn = pyodbc.connect(config_projet)
        print("Connexion a Projet_Centre_Aide reussie!")
    else:
        print("\nLa base Projet_Centre_Aide n'existe pas encore. Executez creer_bd.py pour la creer.")

except pyodbc.Error as ex:
    # Gestion des erreurs de connexion a la base de donnees
    print("\nErreur de connexion a la base de donnees:")
    print("Exception: ", ex)

finally: # Fermer les ressources dans tous les cas (erreur ou pas)
    if 'curseur' in locals() and curseur:
        curseur.close()            # Curseur existe - a fermer
    if 'cnxn' in locals() and cnxn:
        cnxn.close()                # Connexion existe - a fermer
print("\nFermeture du programme.")
