# ajout_usagers.py
from src.operations_bd import inserer_usager
from src.acces_bd import get_connexion

def ajouter_usagers_test():
    # Ajoute des usagers de test dans la base de donnees en utilisant la procedure stockee
    usagers = [
        (1, "Dupont", "Jean", "5141234567", "jean.dupont@email.com", "123 Rue Principale", 1),
        (2, "Tremblay", "Marie", "5142345678", "marie.tremblay@email.com", "456 Rue Secondaire", 2),
        (3, "Lavoie", "Pierre", "5143456789", "pierre.lavoie@email.com", "789 Avenue Principale", 3),
        (4, "Gagnon", "Sophie", "5144567890", "sophie.gagnon@email.com", "234 Boulevard Central", 1),
        (5, "Roy", "Luc", "5145678901", "luc.roy@email.com", "567 Rue du Parc", 4),
        (6, "Morin", "Claude", "5146789012", "claude.morin@email.com", "890 Avenue des Pins", 5),
        (7, "Fortin", "Nathalie", "5147890123", "nathalie.fortin@email.com", "321 Rue des Fleurs", 6),
        (8, "Bouchard", "Robert", "5148901234", "robert.bouchard@email.com", "654 Boulevard des Erables", 7),
        (9, "Gauthier", "Isabelle", "5149012345", "isabelle.gauthier@email.com", "987 Rue du Lac", 8),
        (10, "Bergeron", "Martin", "5140123456", "martin.bergeron@email.com", "345 Avenue du Mont", 9)
        (11, "Sanchez", "Elena", "5141235001", "elena.sanchez@email.com", "118 Calle Principal", 1),
        (12, "Wong", "Liu", "5141235002", "liu.wong@email.com", "229 Canton Road", 2),
        (13, "Lambert", "Monique", "5141235003", "monique.lambert@email.com", "330 Rue des Pins", 3),
        (14, "Johnson", "David", "5141235004", "david.johnson@email.com", "441 Oak Street", 4),
        (15, "Weber", "Klaus", "5141235005", "klaus.weber@email.com", "552 Berliner Strasse", 5),
        (16, "Conti", "Maria", "5141235006", "maria.conti@email.com", "663 Via Venezia", 6),
        (17, "Jung", "Min-Ho", "5141235007", "minho.jung@email.com", "774 Seoul Street", 7),
        (18, "Lopez", "Javier", "5141235008", "javier.lopez@email.com", "885 Plaza Mayor", 8),
        (19, "Kapoor", "Deepa", "5141235009", "deepa.kapoor@email.com", "996 Mumbai Road", 9),
        (20, "Yamamoto", "Kenji", "5141235010", "kenji.yamamoto@email.com", "110 Kyoto Avenue", 10),
        (21, "Khalil", "Omar", "5141235011", "omar.khalil@email.com", "221 Cairo Street", 11),
        (22, "Popov", "Alexei", "5141235012", "alexei.popov@email.com", "332 Red Square", 12),
        (23, "Svensson", "Elsa", "5141235013", "elsa.svensson@email.com", "443 Nordic Way", 13),
        (24, "Rodriguez", "Sofia", "5141235014", "sofia.rodriguez@email.com", "554 Havana Boulevard", 14),
        (25, "Papas", "Dimitri", "5141235015", "dimitri.papas@email.com", "665 Athens Street", 15),
    ]

    # Verifie d'abord que la connexion fonctionne
    try:
        conn, cursor = get_connexion()
        cursor.close()
        conn.close()
        print("Connexion a la base de donnees reussie.")
    except Exception as e:
        print(f"Erreur de connexion: {e}")
        return False
    
    # Ajoute chaque usager avec la procedure stockee
    succes_count = 0
    for usager in usagers:
        try:
            if inserer_usager(*usager):
                succes_count += 1
                print(f"Usager ajoute: {usager[1]} {usager[2]}")
            else:
                print(f"Echec de l'ajout pour {usager[1]} {usager[2]}")
        except Exception as e:
            print(f"Erreur lors de l'ajout de {usager[1]} {usager[2]}: {e}")
    
    print(f"\n{succes_count} usagers sur {len(usagers)} ajoutes avec succes.")
    return succes_count == len(usagers)

# Completer les insertions avec des interventions et plaintes
def completer_insertions():
    conn, cursor = None, None
    try:
        conn, cursor = get_connexion()

        # Insere des interventions
        interventions = [
            (1, '2024-03-01 10:00:00', '2024-03-03 14:00:00', 'Aide menagere', 'Termine', 120, 1, 1, 1),
            (2, '2024-03-02 11:00:00', '2024-03-05 15:00:00', 'Accompagnement medical', 'En cours', None, 2, 2, 2),
            (3, '2024-03-03 12:00:00', '2024-03-10 16:00:00', 'Reparation', 'Pas encore commence', None, 3, 1, 3),
            (4, '2024-03-04 13:00:00', '2024-03-06 17:00:00', 'Aide administrative', 'Termine', 90, 4, 2, 1),
            (5, '2024-03-05 14:00:00', '2024-03-07 18:00:00', 'Livraison de repas', 'Annule', None, 5, 4, 4),
            (6, '2024-03-06 10:00:00', '2024-03-08 14:00:00', 'Soutien informatique', 'Termine', 60, 6, 6, 5),
            (7, '2024-03-07 11:00:00', '2024-03-09 15:00:00', 'Transport', 'En cours', None, 7, 7, 6),
            (8, '2024-03-08 12:00:00', '2024-03-11 16:00:00', 'Jardinage', 'Pas encore commence', None, 8, 8, 7),
            (9, '2024-03-09 13:00:00', '2024-03-12 17:00:00', 'Lecture', 'Termine', 45, 9, 9, 8),
            (10, '2024-03-10 14:00:00', '2024-03-13 18:00:00', 'Courses', 'Annule', None, 10, 10, 9)
        ]
        
        for intervention in interventions:
            cursor.execute("""
                INSERT INTO Intervention 
                (id, date_demande, date_intervention, type_aide, status, duree, id_usager, id_equipe, id_secteur)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
            """, intervention)

        # Insere des plaintes
        plaintes = [
            (1, 'Retard', "L'equipe est arrivee en retard de 30 minutes", '2024-03-04 15:00:00', 'Ouvert', None, None, 1),
            (2, 'Qualite du service', 'Travail incomplet', '2024-03-05 16:00:00', 'En traitement', None, None, 2),
            (3, 'Comportement', 'Manque de politesse', '2024-03-06 17:00:00', 'Resolu', '2024-03-10 10:00:00', 'Excuses presentees', 4),
            (4, 'Annulation tardive', 'Intervention annulee a la derniere minute', '2024-03-07 18:00:00', 'Ferme', '2024-03-11 11:00:00', 'Compensation offerte', 5),
            (5, 'Autre', 'Mauvaise communication', '2024-03-08 19:00:00', 'Ouvert', None, None, 3),
            (6, 'Retard', 'Retard de plus d\'une heure', '2024-03-09 15:00:00', 'Ouvert', None, None, 6),
            (7, 'Qualite du service', 'Service non conforme', '2024-03-10 16:00:00', 'En traitement', None, None, 7),
            (8, 'Comportement', 'Attitude inappropriee', '2024-03-11 17:00:00', 'Resolu', '2024-03-15 10:00:00', 'Formation supplementaire', 8),
            (9, 'Annulation tardive', 'Absence non justifiee', '2024-03-12 18:00:00', 'Ferme', '2024-03-16 11:00:00', 'Remboursement effectue', 9),
            (10, 'Autre', 'Materiel endommage', '2024-03-13 19:00:00', 'Ouvert', None, None, 10)
        ]
        
        for plainte in plaintes:
            cursor.execute("""
                INSERT INTO Plainte 
                (id, type, description, date_signalement, statut, date_resolution, resolution, id_intervention)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?)
            """, plainte)
        
        conn.commit()
        print("Interventions et plaintes ajoutees avec succes.")
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
    # Etape 1: Ajouter les usagers via la procedure stockee
    if ajouter_usagers_test():
        # Etape 2: Completer avec les autres donnees liees
        completer_insertions()
