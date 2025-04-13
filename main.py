# main.py
import operations_bd # Importe les fonctions definies dans operations_bd.py

def afficher_menu():
    # Affiche les options disponibles à l'utilisateur
    print("\n--- Menu Principal ---")
    print("1. Lister tous les clients")
    print("2. Mettre a jour le nom d'un client")
    print("3. Executer la procedure exemple")
    print("4. Obtenir le code client via fonction")
    # Ajoutez ici les options correspondant aux fonctions dans operations_bd.py
    print("...") 
    print("10. Ma requête complexe 1") 
    print("11. Ma requête complexe 2")
    # ... assurez-vous d'avoir plus de 10 options appelant du SQL
    print("0. Quitter")
    print("--------------------")

def main():
    """Fonction principale de l'application."""
    while True:
        afficher_menu()
        choix = input("Entrez votre choix : ")

        if choix == '1':
            print("\n-- Liste des Clients --")
            clients = operations_bd.lister_tous_les_clients()
            if clients:
                for client in clients:
                    # Adaptez l'affichage aux colonnes retournées
                    print(f"ID: {client.id}, Code: {client.code}, Nom: {client.firstName} {client.lastName}") 
            else:
                print("Aucun client trouvé ou erreur.")
        
        elif choix == '2':
            code = input("Entrez le code du client à modifier : ")
            nouveau_nom = input("Entrez le nouveau nom de famille : ")
            operations_bd.mettre_a_jour_nom_client(code, nouveau_nom)

        elif choix == '3':
            # Demandez les paramètres nécessaires à l'utilisateur
            p1 = input("Entrez le paramètre 1 pour la procédure : ")
            p2 = input("Entrez le paramètre 2 pour la procédure : ")
            operations_bd.appeler_procedure_exemple(p1, p2)
            
        elif choix == '4':
            try:
                id_client = int(input("Entrez l'ID du client pour la fonction : "))
                code_res = operations_bd.appeler_fonction_exemple(id_client)
                if code_res:
                    print(f"Le code retourné par la fonction est : {code_res}")
                else:
                    print("Fonction n'a rien retourné ou ID non trouvé.")
            except ValueError:
                print("Erreur : L'ID doit être un nombre entier.")

        # --- Ajoutez ici les 'elif' pour VOS autres options ---
        # elif choix == '10':
        #     resultats = db_operations.executer_requete_complexe_1()
        #     # Affichez les resultats de manière formatée
        
        elif choix == '0':
            print("Au revoir !")
            break # Sort de la boucle while
        
        else:
            print("Choix invalide. Veuillez réessayer.")

        input("\nAppuyez sur Entrée pour continuer...") # Pause pour voir les résultats

if __name__ == "__main__":
    # Vérification initiale de la connexion pour échouer tôt si nécessaire
    # (Facultatif mais recommandé)
    # from acces_bd import get_db_connection 
    # test_conn, test_cursor = get_db_connection()
    # if test_conn and test_cursor:
    #    test_cursor.close()
    #    test_conn.close()
    # else:
    #    exit("Impossible de démarrer l'application sans connexion BD.")
        
    main() # Lance l'application