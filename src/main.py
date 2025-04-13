# main.py
import src.operations_bd as operations_bd # Importe les fonctions definies dans operations_bd.py

def afficher_menu():
    # Affiche les options disponibles a l'utilisateur A CHANGER
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
    # Fonction principale de l'application qui s'execute en boucle
    while True:
        afficher_menu()
        choix = input("Entrez votre choix : ")

        if choix == '1':
            print("\n-- Liste des Usagers --")
            usagers = operations_bd.lister_les_usagers()
            if usagers:
                for usager in usagers:
                    # Adaptez l'affichage aux colonnes retournées
                    print(f"ID: {usager.id}, Code: {usager.id}, Nom: {usager.nom} {usager.prenom}") 
            else:
                print("Aucun client trouve ou erreur.")

        elif choix == '2':
            id = input("Entrez l'id de l'usager a modifier : ")
            nouveau_nom = input("Entrez le nouveau nom de famille : ")
            operations_bd.mettre_a_jour_nom_usager(id, nouveau_nom)

        elif choix == '3':
            # Demandez les parametres necessaires a l'utilisateur
            p1 = input("Entrez le paramètre 1 pour la procédure : ")
            p2 = input("Entrez le paramètre 2 pour la procédure : ")
            operations_bd.appeler_procedure_exemple(p1, p2)

        elif choix == '4':
            try:
                id_usager = int(input("Entrez l'ID de l'usager pour la fonction : "))
                code_res = operations_bd.appeler_fonction_exemple(id_usager)
                if code_res:
                    print(f"Le code retourne par la fonction est : {code_res}")
                else:
                    print("Fonction n'a rien retourné ou ID non trouvé.")

            except ValueError:
                print("Erreur : L'ID doit etre un nombre entier.")

        # --- Ajoutez ici les 'elif' pour autres options ---
        # elif choix == '10':
        #     resultats = operations_bd.executer_requete_complexe_1()
        #     # Affichez les resultats de maniere formatee
        
        elif choix == '0':
            print("Au revoir !")
            break # Sort de la boucle while
        
        else:
            print("Choix invalide. Veuillez reessayer.")

        input("\nAppuyez sur Entree pour continuer...") # Pause pour voir les resultats

if __name__ == "__main__":
    # Verification initiale de la connexion pour echouer tot si necessaire
    # (Facultatif mais recommandé)
    # from acces_bd import get_db_connection 
    # test_conn, test_cursor = get_db_connection()
    # if test_conn and test_cursor:
    #    test_cursor.close()
    #    test_conn.close()
    # else:
    #    exit("Impossible de demarrer l'application sans connexion BD.")
        
    main() # Lance l'application
