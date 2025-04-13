# ajout_usagers.py
from src.operations_bd import inserer_usager
from src.acces_bd import get_connexion

def ajouter_usagers_test():
    """Ajoute des usagers de test dans la base de donnees en utilisant la procedure stockee"""
    
    # Liste des usagers à ajouter (id, nom, prenom, telephone, courriel, adresse, id_secteur)
    usagers = [
        (1, "Dupont", "Jean", "5141234567", "jean.dupont@email.com", "123 Rue Principale", 1),
        (2, "Tremblay", "Marie", "5142345678", "marie.tremblay@email.com", "456 Rue Secondaire", 2),
        (3, "Lavoie", "Pierre", "5143456789", "pierre.lavoie@email.com", "789 Avenue Principale", 3),
        (4, "Gagnon", "Sophie", "5144567890", "sophie.gagnon@email.com", "234 Boulevard Central", 1),
        (5, "Roy", "Luc", "5145678901", "luc.roy@email.com", "567 Rue du Parc", 4)
    ]
    
    # Vérifie d'abord que la connexion fonctionne
    try:
        conn, cursor = get_connexion()
        cursor.close()
        conn.close()
        print("Connexion à la base de données réussie.")
    except Exception as e:
        print(f"Erreur de connexion: {e}")
        return False
    
    # Ajoute chaque usager avec la procédure stockée
    succes_count = 0
    for usager in usagers:
        try:
            if inserer_usager(*usager):
                succes_count += 1
                print(f"Usager ajouté: {usager[1]} {usager[2]}")
            else:
                print(f"Échec de l'ajout pour {usager[1]} {usager[2]}")
        except Exception as e:
            print(f"Erreur lors de l'ajout de {usager[1]} {usager[2]}: {e}")
    
    print(f"\n{succes_count} usagers sur {len(usagers)} ajoutés avec succès.")
    return succes_count == len(usagers)

# Compléter les insertions avec des interventions et plaintes
def completer_insertions():
    """Complète les insertions avec des interventions et des plaintes qui référencent les usagers"""
    conn, cursor = None, None
    try:
        conn, cursor = get_connexion()
        
        # Insère des interventions
        interventions = [
            (1, '2024-03-01 10:00:00', '2024-03-03 14:00:00', 'Aide menagere', 'Termine', 120, 1, 1, 1),
            (2, '2024-03-02 11:00:00', '2024-03-05 15:00:00', 'Accompagnement medical', 'En cours', None, 2, 2, 2),
            (3, '2024-03-03 12:00:00', '2024-03-10 16:00:00', 'Reparation', 'Pas encore commence', None, 3, 1, 3),
            (4, '2024-03-04 13:00:00', '2024-03-06 17:00:00', 'Aide administrative', 'Termine', 90, 4, 2, 1),
            (5, '2024-03-05 14:00:00', '2024-03-07 18:00:00', 'Livraison de repas', 'Annule', None, 5, 4, 4)
        ]
        
        for intervention in interventions:
            cursor.execute("""
                INSERT INTO Intervention 
                (id, date_demande, date_intervention, type_aide, status, duree, id_usager, id_equipe, id_secteur)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
            """, intervention)
        
        # Insère des plaintes
        plaintes = [
            (1, 'Retard', "L'equipe est arrivee en retard de 30 minutes", '2024-03-04 15:00:00', 'Ouvert', None, None, 1),
            (2, 'Qualite du service', 'Travail incomplet', '2024-03-05 16:00:00', 'En traitement', None, None, 2),
            (3, 'Comportement', 'Manque de politesse', '2024-03-06 17:00:00', 'Resolu', '2024-03-10 10:00:00', 'Excuses presentees', 4),
            (4, 'Annulation tardive', 'Intervention annulee a la derniere minute', '2024-03-07 18:00:00', 'Ferme', '2024-03-11 11:00:00', 'Compensation offerte', 5),
            (5, 'Autre', 'Mauvaise communication', '2024-03-08 19:00:00', 'Ouvert', None, None, 3)
        ]
        
        for plainte in plaintes:
            cursor.execute("""
                INSERT INTO Plainte 
                (id, type, description, date_signalement, statut, date_resolution, resolution, id_intervention)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?)
            """, plainte)
        
        conn.commit()
        print("Interventions et plaintes ajoutées avec succès.")
        return True
        
    except Exception as e:
        print(f"Erreur lors de l'ajout des interventions et plaintes: {e}")
        if conn:
            conn.rollback()
        return False
        
    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()

if __name__ == "__main__":
    # Étape 1: Ajouter les usagers via la procédure stockée
    if ajouter_usagers_test():
        # Étape 2: Compléter avec les autres données liées
        completer_insertions()
