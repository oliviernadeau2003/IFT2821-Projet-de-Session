###### IFT2821-A-H25 - Introduction aux bases de données | Projet de Session

# IFT2821 Projet Centre d'Aide

Ce projet met en œuvre un système de gestion pour un **Centre d'Aide**. L'application permet de modéliser et de gérer les différentes entités et opérations clés du centre.

#### Membres :

- Olivier Nadeau
- Yonah Lahlou
- Ahmadou Ayande

---

## Prérequis

Avant de commencer, assurez-vous d'avoir installé les logiciels suivants :

* **Docker Desktop :** Pour exécuter le conteneur SQL Server.
* **Python 3 :** (Version 3.13 ou compatible recommandée, basée sur l'environnement virtuel).
* **Git :** Pour cloner le repository.
* **ODBC Driver 17 for SQL Server :** Nécessaire pour que `pyodbc` puisse communiquer avec SQL Server.
* **(Optionnel) Azure Data Studio :** Ou un autre client SQL pour visualiser la base de données.

## Installation et Configuration Initiale

1.  **Cloner le Repository :**
    ```bash
    git clone <URL_DU_DEPOT> # Remplacez par l'URL de votre Repo Git
    cd IFT2821-Projet-de-Session # Ou le nom du dossier cloné
    ```

2.  **Configurer SQL Server avec Docker :**
    * Assurez-vous que Docker Desktop est en cours d'exécution.
    * Si vous n'avez pas encore créé le conteneur SQL Server nommé `sql-server`, exécutez la commande suivante dans votre terminal. **Attention :** Ceci téléchargera l'image SQL Server si elle n'est pas présente localement.
        ```bash
        docker run --name sql-server \
                   -e "ACCEPT_EULA=Y" \
                   -e "MSSQL_SA_PASSWORD=YourStrongPassword123!" \
                   -p 1433:1433 \
                   -d [mcr.microsoft.com/mssql/server:latest](https://mcr.microsoft.com/mssql/server:latest)
        ```
    * **Important :** Le mot de passe `YourStrongPassword123!` est utilisé ici et dans les scripts Python (`src/acces_bd.py`, `test_connexion.py`). Assurez-vous de la cohérence ou modifiez les deux endroits si nécessaire.

3.  **Configurer l'Environnement Virtuel Python :**
    ```bash
    # Créer l'environnement virtuel (s'il n'existe pas déjà)
    python3 -m venv sql_app_env 

    # Activer l'environnement (Exemple pour bash/zsh sur macOS/Linux)
    source sql_app_env/bin/activate 
    # Sur Windows (Command Prompt): .\sql_app_env\Scripts\activate.bat
    # Sur Windows (PowerShell): .\sql_app_env\Scripts\Activate.ps1
    ```

4.  **Installer les Dépendances Python :**
    ```bash
    pip install -r requirements.txt
    ```

## Étapes de Lancement de l'Application

Suivez ces étapes dans l'ordre pour démarrer et initialiser l'application :

1.  **Démarrer le Conteneur SQL Server :**
    * Via Docker Desktop : Trouvez le conteneur `sql-server` et cliquez sur "Start".
    * Via le Terminal :
        ```bash
        docker start sql-server
        ```

2.  **(Optionnel) Vérifier la Connexion au Serveur :**
    * Lancez Azure Data Studio.
    * Connectez-vous au serveur :
        * **Server:** `127.0.0.1,1433` (ou `localhost,1433`)
        * **Authentication type:** SQL Login
        * **User name:** `sa`
        * **Password:** `YourStrongPassword123!`
        * Cochez "Trust server certificate".
    * Vous devriez pouvoir vous connecter et voir les bases de données système (`master`, `tempdb`, etc.).

3.  **Activer l'Environnement Virtuel Python** (si ce n'est pas déjà fait) :
    ```bash
    source sql_app_env/bin/activate 
    # Ou la commande équivalente pour votre système d'exploitation
    ```

4.  **Tester la Connexion Python à la Base de Données :**
    Ce script vérifie que Python peut se connecter au serveur SQL et à la base `master`. Il tente aussi de se connecter à `Projet_Centre_Aide` si elle existe.
    ```bash
    python3 test_connexion.py
    ```
    Vérifiez qu'il n'y a pas d'erreurs de connexion.

5.  **Créer la Base de Données et les Tables :**
    Ce script exécute le contenu des fichiers SQL (`LDD_LMD.sql`, `T-SQL.sql`) pour créer la base de données `Projet_Centre_Aide`, ses tables, procédures stockées, etc.
    ```bash
    python3 src/creer_bd.py
    ```

6.  **Ajouter les Données Initiales (Usagers, Interventions, Plaintes) :**
    Ce script peuple la base de données avec des données de test.
    ```bash
    python3 ajout_usagers.py
    ```

7.  **Exécuter l'Application Principale :**
    Lance l'application utilisateur finale.
    ```bash
    python3 main.py
    ```
