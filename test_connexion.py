# Script de test de connexion a SQL Server dans Docker
import pyodbc


try:
    # Connexion
    conn_str = (
        "Driver={ODBC Driver 17 for SQL Server};"   # Version du driver odbc
        "Server=localhost;"                         # Nom de l'instance
        "Database=sql-server;"                      # Nom de la BD
        "Encrypt=yes;"                              # Chiffrer la connexion
        "TrustServerCertificate=yes;"               # Remplacer par "no" avec certificat valide sur le serveur SQL
        "UID=sa;"                                   # Authentification avec SQL
        "PWD=YourStrongPassword;"                   # Mot de passe
    )

    cnxn = pyodbc.connect(conn_str)     # Etablit la connexion
    curseur = cnxn.cursor()             # Curseur pour les requetes SQL

    # Requete SQL test
    sqlCommand = "SELECT * FROM Secteur;"
    curseur.execute(sqlCommand)

    # Recurpere et affiche les resultats
    for row in curseur.fetchall():
        print(f"ID: {row.id}, Nom: {row.nom}")


except pyodbc.Error as ex:
    # Gestion des erreurs de connexion a la base de donnees
    print("\nErreur de connexion à la base de données:")
    print("Exception: ", ex)
    
finally:    # Fermer les ressources dans tous les cas
    if 'curseur' in locals():
        curseur.close()     # Curseur existe - à fermer
    if 'cnxn' in locals():
        cnxn.close()        # Connexion existe - a fermer
print("Programme terminé")
