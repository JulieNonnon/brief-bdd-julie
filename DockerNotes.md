# Déploiement de la base PostgreSQL avec Docker

Ce projet fournit un environnement PostgreSQL prêt à l’emploi via Docker et Docker Compose.  
Il permet de déployer facilement une base de données nommée **`bddban`**, accessible en local.

---

## 📦 Prérequis

Avant de commencer, assurez-vous d’avoir installé :

- **Docker**
- **Docker Compose** (inclus automatiquement dans Docker Desktop)

---

 Le script SQL d’initialisation peut être ajouté plus tard si nécessaire en utilisant le mécanisme `/docker-entrypoint-initdb.d/`.

---

## 🚀 Lancer la base PostgreSQL

Dans un terminal, placez-vous dans le dossier contenant le fichier `docker-compose.yml`, puis exécutez :

```bash
docker-compose up -d
```

Cette commande :

- télécharge l’image PostgreSQL (si absente),
- crée un conteneur nommé bddban2,
- initialise la base bddban,
- démarre le service en arrière-plan.

---

## 🛑 Arrêter le service

```bash
docker-compose down
```

Le conteneur est supprimé, mais les données restent conservées grâce au volume Docker.

---

## 📊 Persistance des données

La base utilise un volume nommé postgres_data, défini ainsi :

```yaml
volumes:
  postgres_data:
```

Ce volume permet de :

- conserver les données même après suppression du conteneur,
- réutiliser la base lors des prochains redémarrages.

Pour supprimer complètement la base :

```bash
docker-compose down -v
```
⚠️ Cette commande supprime définitivement toutes les données.

---

## 🔌 Connexion à la base PostgreSQL

Le service PostgreSQL écoute sur le port :

- 5433 côté machine locale
- 5432 côté conteneur (port interne PostgreSQL)

Pour vous connecter :

### ✔️ Via psql (ligne de commande)

```bash
psql -h localhost -p 5433 -U julie -d bddban
```
Mot de passe : louvre

### ✔️ Via un client graphique (DBeaver, pgAdmin etc ...)

Créer une nouvelle base de données Postgres et y renseigner les informations suivantes :

- **Host** : `localhost`  
- **Port** : `5433`  
- **Database** : `bddban`  
- **User** : `julie`  
- **Password** : `louvre`

## 🔄 Relancer la base après modification du docker-compose

Si vous modifiez le fichier docker-compose.yml, redémarrez avec :

```bash
docker-compose down
docker-compose up -d
```

Les données resteront préservées.