# ajout_usagers.py
from src.acces_bd import get_connexion
from src.operations_bd import inserer_usager

def ajouter_usagers_test():
    # Ajoute des usagers de test dans la base de donnees en utilisant la procedure stockee
    usagers = [
        (1, "Garcia", "Alejandro", "5141235001", "alejandro.garcia@email.com", "100 Calle Principal", 1),
        (2, "Wang", "Li", "5141235002", "li.wang@email.com", "200 Nanjing Road", 2),
        (3, "Dupont", "Marie", "5141235003", "marie.dupont@email.com", "300 Rue de Rivoli", 3),
        (4, "Smith", "Emma", "5141235004", "emma.smith@email.com", "400 Baker Street", 4),
        (5, "Schmidt", "Hans", "5141235005", "hans.schmidt@email.com", "500 Berliner Strasse", 5),
        (6, "Bianchi", "Giuseppe", "5141235006", "giuseppe.bianchi@email.com", "600 Via Roma", 6),
        (7, "Lee", "Min-Ho", "5141235007", "minho.lee@email.com", "700 Gangnam Boulevard", 7),
        (8, "Fernandez", "Carmen", "5141235008", "carmen.fernandez@email.com", "800 Plaza Mayor", 8),
        (9, "Singh", "Arjun", "5141235009", "arjun.singh@email.com", "900 Gandhi Road", 9),
        (10, "Yamamoto", "Haruki", "5141235010", "haruki.yamamoto@email.com", "1000 Sakura Street", 10),
        (11, "Al-Farsi", "Omar", "5141235011", "omar.alfarsi@email.com", "1100 Al Wasl Road", 11),
        (12, "Kuznetsov", "Anastasia", "5141235012", "anastasia.kuznetsov@email.com", "1200 Nevsky Avenue", 12),
        (13, "Andersson", "Lars", "5141235013", "lars.andersson@email.com", "1300 Stockholm Street", 13),
        (14, "Perez", "Juana", "5141235014", "juana.perez@email.com", "1400 Havana Road", 14),
        (15, "Christodoulou", "Andreas", "5141235015", "andreas.christodoulou@email.com", "1500 Athens Boulevard", 15),
        (16, "Oliveira", "Fernanda", "5141235016", "fernanda.oliveira@email.com", "1600 Copacabana Avenue", 16),
        (17, "Kim", "Ji-Young", "5141235017", "jiyoung.kim@email.com", "1700 Seoul Street", 17),
        (18, "Amrani", "Fatima", "5141235018", "fatima.amrani@email.com", "1800 Casablanca Road", 18),
        (19, "Prapaporn", "Somchai", "5141235019", "somchai.prapaporn@email.com", "1900 Bangkok Lane", 19),
        (20, "Levy", "Moshe", "5141235020", "moshe.levy@email.com", "2000 Tel Aviv Boulevard", 20),
        (21, "Baptiste", "Jean", "5141235021", "jean.baptiste@email.com", "2100 Port-au-Prince Street", 21),
        (22, "Muller", "Thomas", "5141235022", "thomas.muller@email.com", "2200 Zurich Avenue", 22),
        (23, "Kowalski", "Piotr", "5141235023", "piotr.kowalski@email.com", "2300 Warsaw Boulevard", 23),
        (24, "Costa", "Mariana", "5141235024", "mariana.costa@email.com", "2400 Lisbon Street", 24),
        (25, "De Leon", "Manuel", "5141235025", "manuel.deleon@email.com", "2500 Manila Road", 25),
        (26, "Shevchenko", "Oksana", "5141235026", "oksana.shevchenko@email.com", "2600 Kiev Avenue", 26),
        (27, "Leroy", "Claire", "5141235027", "claire.leroy@email.com", "2700 Montmartre Street", 27),
        (28, "Wagner", "Markus", "5141235028", "markus.wagner@email.com", "2800 Friedrichshain Road", 28),
        (29, "Martinez", "Elena", "5141235029", "elena.martinez@email.com", "2900 El Raval Boulevard", 29),
        (30, "Gupta", "Raj", "5141235030", "raj.gupta@email.com", "3000 Varanasi Avenue", 30),
        (31, "Suzuki", "Takashi", "5141235031", "takashi.suzuki@email.com", "3100 Shinjuku Street", 31),
        (32, "Hassan", "Aisha", "5141235032", "aisha.hassan@email.com", "3200 Medina Road", 32),
        (33, "Sokolov", "Igor", "5141235033", "igor.sokolov@email.com", "3300 Arbat Boulevard", 33),
        (34, "Lindberg", "Elsa", "5141235034", "elsa.lindberg@email.com", "3400 Sodermalm Avenue", 34),
        (35, "Rodriguez", "Carlos", "5141235035", "carlos.rodriguez@email.com", "3500 Vedado Street", 35),
        (36, "Papadakis", "Dimitris", "5141235036", "dimitris.papadakis@email.com", "3600 Plaka Road", 36),
        (37, "Santos", "Lucas", "5141235037", "lucas.santos@email.com", "3700 Copacabana Boulevard", 37),
        (38, "Park", "Ji-Hye", "5141235038", "jihye.park@email.com", "3800 Gangnam Avenue", 38),
        (39, "El Fassi", "Nadia", "5141235039", "nadia.elfassi@email.com", "3900 Fes El Bali Street", 39),
        (40, "Sommai", "Pranee", "5141235040", "pranee.sommai@email.com", "4000 Sukhumvit Road", 40),
        (41, "Cohen", "Sarah", "5141235041", "sarah.cohen@email.com", "4100 Tel Aviv Port Boulevard", 41),
        (42, "Thompson", "David", "5141235042", "david.thompson@email.com", "4200 Port of Spain Avenue", 42),
        (43, "Becker", "Johann", "5141235043", "johann.becker@email.com", "4300 Zurich Old Town Street", 43),
        (44, "Wojcik", "Anna", "5141235044", "anna.wojcik@email.com", "4400 Kazimierz Road", 44),
        (45, "Silva", "Joao", "5141235045", "joao.silva@email.com", "4500 Alfama Boulevard", 45),
        (46, "Reyes", "Lucia", "5141235046", "lucia.reyes@email.com", "4600 Intramuros Avenue", 46),
        (47, "Bondarenko", "Viktor", "5141235047", "viktor.bondarenko@email.com", "4700 Maidan Street", 47),
        (48, "Dubois", "Sylvie", "5141235048", "sylvie.dubois@email.com", "4800 Pigalle Road", 48),
        (49, "Romano", "Marco", "5141235049", "marco.romano@email.com", "4900 Trastevere Boulevard", 49),
        (50, "Yilmaz", "Ayse", "5141235050", "ayse.yilmaz@email.com", "5000 Sultanahmet Avenue", 50)
    ]

    # Verifie d'abord que la connexion fonctionne
    try:
        conn, cursor = get_connexion()
        cursor.close()
        conn.close()
        #print("\nConnexion a la base de donnees reussie.\n")
    except Exception as e:
        print(f"Erreur de connexion: {e}")
        return False
    
    # Ajoute chaque usager avec la procedure stockee
    succes_count = 0
    for usager in usagers:
        try:
            if inserer_usager(*usager):
                succes_count += 1
                #print(f"Usager ajoute: {usager[1]} {usager[2]}")
            else:
                print(f"Echec de l'ajout pour {usager[1]} {usager[2]}")
        except Exception as e:
            print(f"Erreur lors de l'ajout de {usager[1]} {usager[2]}: {e}")
    
    print(f"\n{succes_count} usagers sur {len(usagers)} ajoutes avec succes.\n")
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
