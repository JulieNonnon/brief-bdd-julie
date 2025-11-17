# Mise en place de la base de données

Cette étape regroupe l’ensemble des scripts nécessaires à la création de la base de données, à l’importation d’un échantillon de données et au chargement des données via des tables tampons avant insertion dans les tables finales.

L’objectif est de fournir un environnement contrôlé permettant :

- de créer la structure complète de la base,
- de tester les processus d'import,
- de manipuler des données issues d’un fichier CSV,
- de préparer des imports fiables et reproductibles.

---

## 📂 Arborescence du dossier

Etape3/
│
├── Creation-db/
│ └── create-database.sql
│
├── Echantillonnage/
│ ├── adresses-samples.csv
│ └── sample-datas.sql
│
└── Tables-tampons/
├── main-staging-datas.sql
├── staging-address-datas.sql
├── staging-geolocation-data.sql
├── staging-parcel-address-datas.sql
├── staging-parcel-datas.sql
├── staging-street-datas.sql
└── staging-town-data.sql

# 1️⃣ Création de la base de données

📁 **Fichier :** `Creation-db/create-database.sql`

Ce script contient :

- la création de la base `bddban`,
- la définition de toutes les tables principales :
  - `parcel`
  - `town`
  - `street`
  - `geolocation`
  - `address`
  - `parcel_address`
- la création des clés primaires et étrangères,
- la suppression préalable des tables si elles existent déjà (sécurisé avec `DROP TABLE IF EXISTS`).

Ce script constitue la **structure principale** du projet.

---

# 2️⃣ Échantillonnage des données

📁 **Fichiers :**  
- `Echantillonnage/adresses-samples.csv`  
- `Echantillonnage/sample-datas.sql`

### 🎯 Objectif

L’objectif de ce dossier est de fournir un **échantillon léger** (environ 20 lignes) issu d’un fichier CSV d’origine bien plus volumineux.  
Il est destiné à :

- effectuer des tests d’importation sans surcharge,
- valider la structure des données,
- vérifier la cohérence avant chargement de grosses volumétries.

### 📝 Contenu

#### `adresses-samples.csv`
Un fichier CSV contenant un petit ensemble d’adresses représentatives de la future base : lieux-dits, numéros de rues, communes, géolocalisation, etc.

#### `sample-datas.sql`
Un script SQL permettant :

- d’importer cet échantillon dans une table tampon ou table de staging,
- de prétraiter ou normaliser les données selon les besoins,
- de valider le format des colonnes avant import réel.

---

# 3️⃣ Tables tampons (Staging)

📁 **Dossier :** `Tables-tampons/`

Ce dossier contient tous les scripts permettant de gérer les **tables tampons**, aussi appelées **tables de staging**.

### 🎯 Rôle des tables tampons

Les tables tampons servent à :

- charger temporairement les données brutes (issues du CSV),
- nettoyer, transformer et harmoniser ces données,
- les redistribuer ensuite dans les tables définitives (`parcel`, `town`, `street`, etc.).

Ce processus permet d’assurer une qualité optimale avant insertion dans la base finale.

---

# 🗂️ Description des scripts de staging

Voici un résumé clair de chaque script :

### 📌 `main-staging-datas.sql`
- Point d'entrée principal du processus de staging.
- Exécute dans un ordre cohérent les autres scripts de staging.
- Peut inclure la création des tables tampons si nécessaire.

---

### 📌 `staging-address-datas.sql`
- Charge les données d’adresses (numéros, voies, lieux-dits).
- Traite les champs d’identification associés à la table `address`.

---

### 📌 `staging-geolocation-data.sql`
- Charge les coordonnées X/Y ou longitude/latitude.
- Vérifie la conformité ou la précision des données géographiques.
- Alimente ensuite la table `geolocation`.

---

### 📌 `staging-parcel-address-datas.sql`
- Gère la relation entre les parcelles et les adresses.
- Remplit la table de liaison tampon avant distribution dans `parcel_address`.

---

### 📌 `staging-parcel-datas.sql`
- Prépare les données liées aux parcelles cadastrales.
- Nettoie les identifiants cadastraux avant insertion dans `parcel`.

---

### 📌 `staging-street-datas.sql`
- Gère les données relatives aux voies : noms, numéros, codes postaux.
- Prépare les liens entre adresses et voies.

---

### 📌 `staging-town-data.sql`
- Gère les données liées aux communes (INSEE, libellés, anciennes communes).
- Alimente ensuite la table `town`.

---

# 🔄 Processus global d'import des données

Le flux complet d’importation est le suivant :

1. 📥 **Import du CSV** dans une table tampon via `sample-datas.sql`
2. 🧹 **Nettoyage & harmonisation** des données dans les tables tampons (scripts `staging-*`)
3. 🧭 **Redistribution** des données depuis les tables tampons vers les tables finales
4. 🗄️ **Création automatique des relations** dans `parcel_address`
5. ✔️ **Validation** de la cohérence des données

Ce fonctionnement permet d’importer les données de manière fiable et contrôlée.

---

# 📝 Conclusion

Ce dossier constitue la base complète du workflow d’intégration des données :

- création de la base,
- traitement initial des données CSV,
- nettoyage via tables tampons,
- insertion finale dans les tables définitives.
