# main.py
import src.operations_bd as operations_bd # Importe les fonctions definies dans operations_bd.py
from src.acces_bd import get_connexion


def afficher_menu():
    # Affiche les options disponibles a l'utilisateur
    print("\n------------------ CENTRE D'AIDE - MENU PRINCIPAL ------------------")
    print("\n----------------------- Requetes simples -----------------------")
    print("1. Lister tous les usagers")
    print("2. Lister les benevoles avec voiture")
    print("3. Lister les interventions terminees")
    print("4. Lister les plaintes ouvertes")
    print("5. Lister les usagers par ordre alphabetique")
    print("\n---------------------- Requetes complexes ----------------------")
    print("6. Interventions avec usagers et unites de secteurs differents")
    print("7. Details des interventions avec usagers et benevoles")
    print("8. Interventions par unites preformees")
    print("9. Details des plaintes ouvertes")
    print("10. Nombre d'interventions par benevole")
    print("\n----------------- Procedures et fonctions T-SQL ----------------")
    print("11. Ajouter un nouvel usager (procedure stockee)")
    print("12. Mettre a jour un usager (avec trigger de validation)")
    print("13. Obtenir le nombre d'interventions par mois (fonction)")
    print("\n0. Quitter")
    print("--------------------------------------------------------------------")

# Determine le format d'affichage des donnees
def formater_usager(usager):
    return f"ID: {usager.id}, Nom: {usager.nom} {usager.prenom}, Tel: {usager.telephone}, Email: {usager.courriel}, Secteur: {usager.id_secteur}"

def formater_benevole(benevole):
    voiture = "Oui" if benevole.possede_voiture else "Non"
    return f"ID: {benevole.id}, Nom: {benevole.nom} {benevole.prenom}, Voiture: {voiture}, Secteur: {benevole.id_secteur}"

def formater_intervention(intervention):
    statut_map = {"Pas encore commence": "Non commence", "En cours": "En cours", "Termine": "Termine", "Annule": "Annule"}
    statut = statut_map.get(intervention.statut, intervention.statut)
    return f"ID: {intervention.id}, Date: {intervention.date_intervention}, Type: {intervention.type_aide}, Statut: {statut}"

def formater_plainte(plainte):
    return f"ID: {plainte.id}, Type: {plainte.type}, Date: {plainte.date_signalement}, Statut: {plainte.statut}"


# Fonction principale
def main():
    # Verifie la connexion au demarrage
    try:
        conn, cursor = get_connexion()
        cursor.close()
        conn.close()
        print("\nConnexion a la base de donnees reussie. Demarrage de l'application...")
    except Exception as e:
        print(f"Erreur de connexion a la base de donnees: {e}")
        print("Impossible de demarrer l'application sans connexion a la base de donnees.")
        return

    while True:
        afficher_menu()
        choix = input("\nEntrez votre choix : ")

        # REQUETES SIMPLES
        if choix == '1':
            print("\n-- Liste des usagers --")
            usagers = operations_bd.lister_les_usagers()
            if usagers:
                for usager in usagers:
                    print(formater_usager(usager))
            else:
                print("Aucun usager trouve ou erreur.")

        elif choix == '2':
            print("\n-- Liste des benevoles avec voiture --")
            benevoles = operations_bd.lister_benevoles_avec_voiture()
            if benevoles:
                for benevole in benevoles:
                    print(formater_benevole(benevole))
            else:
                print("Aucun benevole avec voiture trouve ou erreur.")

        elif choix == '3':
            print("\n-- Liste des interventions terminees --")
            interventions = operations_bd.lister_interventions_terminees()
            if interventions:
                for intervention in interventions:
                    print(formater_intervention(intervention))
            else:
                print("Aucune intervention terminee trouvee ou erreur.")

        elif choix == '4':
            print("\n-- Liste des plaintes ouvertes --")
            plaintes = operations_bd.lister_plaintes_ouvertes()
            if plaintes:
                for plainte in plaintes:
                    print(formater_plainte(plainte))
            else:
                print("Aucune plainte ouverte trouvee ou erreur.")

        elif choix == '5':
            print("\n-- Liste des usagers par ordre alphabetique --")
            usagers = operations_bd.lister_usagers_par_nom()
            if usagers:
                for usager in usagers:
                    print(formater_usager(usager))
            else:
                print("Aucun usager trouve ou erreur.")

        # REQUETES COMPLEXES
        elif choix == '6':
            print("\n-- Interventions avec secteurs differents --")
            resultats = operations_bd.interventions_secteurs_differents()
            if resultats:
                for r in resultats:
                    print(f"Intervention #{r.id_intervention}: Usager {r.nom_usager} (Secteur: {r.secteur_usager}) - Unite de secteur: {r.secteur_unite}")
            else:
                print("Aucun resultat trouve ou erreur.")

        elif choix == '7':
            print("\n-- Details complets des interventions --")
            resultats = operations_bd.details_interventions()
            if resultats:
                for r in resultats:
                    benevoles = f"{r.benevole_principal}" + (f" et {r.benevole_secondaire}" if r.benevole_secondaire else "")
                    print(f"Intervention #{r.id_intervention} ({r.date_intervention}): Usager {r.nom_usager} (Secteur: {r.secteur_usager}) - Benevoles: {benevoles}")
            else:
                print("Aucun resultat trouve ou erreur.")

        elif choix == '8':
            print("\n-- Interventions par unitees preformees --")
            resultats = operations_bd.interventions_unites_preformees()
            if resultats:
                for r in resultats:
                    disponibilite = "Disponible" if r.est_disponible else "Non disponible"
                    print(f"Intervention #{r.id_intervention} ({r.date_intervention}): Usager {r.nom_usager} - Unite du secteur {r.secteur_unite} ({disponibilite})")
            else:
                print("Aucun resultat trouve ou erreur.")

        elif choix == '9':
            print("\n-- Details des plaintes ouvertes --")
            resultats = operations_bd.plaintes_ouvertes_details()
            if resultats:
                for r in resultats:
                    print(f"Plainte #{r.id_plainte} ({r.type_plainte}, {r.date_signalement}): Intervention #{r.id_intervention} - Usager {r.nom_usager} (Secteur: {r.secteur_usager})")
            else:
                print("Aucun resultat trouve ou erreur.")

        elif choix == '10':
            print("\n-- Nombre d'interventions par benevole --")
            resultats = operations_bd.nombre_interventions_par_benevole()
            if resultats:
                for r in resultats:
                    print(f"Benevole #{r.id_benevole} {r.nom_benevole} (Secteur: {r.secteur}): {r.nb_interventions} interventions")
            else:
                print("Aucun resultat trouve ou erreur.")

        # Procedures et fonctions T-SQL
        elif choix == '11':
            print("\n-- Ajouter un nouvel usager (procedure stockee) --")
            try:
                id = int(input("ID de l'usager: "))
                nom = input("Nom: ")
                prenom = input("Prenom: ")
                telephone = input("Telephone (10 chiffres): ")
                courriel = input("Courriel: ")
                adresse = input("Adresse: ")
                id_secteur = int(input("ID du secteur: "))
                
                succes = operations_bd.inserer_usager(id, nom, prenom, telephone, courriel, adresse, id_secteur)
                if succes:
                    print("Usager ajoute avec succes!")
                else:
                    print("Echec de l'ajout de l'usager.")
            except ValueError:
                print("Erreur: Les valeurs numeriques doivent etre des nombres entiers.")

        elif choix == '12':
            print("\n-- Mettre a jour un usager (avec trigger de validation) --")
            try:
                id = int(input("ID de l'usager a modifier: "))
                nom = input("Nouveau nom: ")
                prenom = input("Nouveau prenom: ")
                telephone = input("Nouveau telephone (10 chiffres): ")
                courriel = input("Nouveau courriel: ")
                adresse = input("Nouvelle adresse: ")
                id_secteur = int(input("Nouvel ID du secteur: "))
                
                succes = operations_bd.mettre_a_jour_usager(id, nom, prenom, telephone, courriel, adresse, id_secteur)
                if succes:
                    print("Usager mis a jour avec succes!")
                else:
                    print("Echec de la mise a jour de l'usager. Verifiez le format du telephone (10 chiffres sans espaces).")
            except ValueError:
                print("Erreur: Les valeurs numeriques doivent etre des nombres entiers.")

        elif choix == '13':
            print("\n-- Nombre d'interventions par mois (fonction) --")
            try:
                annee = int(input("\nAnnee (ex: 2024): "))
                mois = int(input("Mois (1-12): "))
                
                if mois < 1 or mois > 12:
                    print("Le mois doit etre entre 1 et 12.")
                    continue
                    
                nombre = operations_bd.obtenir_interventions_par_mois(annee, mois)
                if nombre >= 0:
                    print(f"Nombre d'interventions pour {mois}/{annee}: {nombre}")
                else:
                    print("Erreur lors de l'execution de la fonction.")
            except ValueError:
                print("Erreur: L'annee et le mois doivent etre des nombres entiers.")

        elif choix == '0':
            print("\nA la prochaine !")
            break
        
        else:
            print("Choix invalide. Veuillez reessayer.")

        input("\nAppuyez sur Entree pour continuer...")

if __name__ == "__main__":
    main()
