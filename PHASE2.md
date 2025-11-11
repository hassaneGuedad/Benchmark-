---

### ✅ Étape 10 : Remplir la Checklist (5 min)

Consulter `CHECKLIST.md` et cocher tous les éléments :

- [ ] Prérequis système
- [ ] Projet Maven
- [ ] Structure du projet
- [ ] Infrastructure Docker
- [ ] Base de données
- [ ] Première compilation
- [ ] Premier démarrage
- [ ] Tests endpoint
- [ ] Prometheus
- [ ] Grafana
- [ ] JMeter
- [ ] Configuration IDE

**✓ FAIT** : ___________________ (date/heure)

---

## 📊 Résultat Attendu

Quand tout est complété :

```
✅ Java 17 présent
✅ Maven compilable
✅ Docker en cours d'exécution
✅ PostgreSQL avec 2000 cat + 100K items
✅ Les 3 variantes démarrent sans erreur
✅ Endpoints répondent (200 OK)
✅ Prometheus scrape l'application
✅ Grafana peut voir les métriques
✅ Tous les prérequis JMeter en place
```

---

## 🔄 Prochaine Phase

Une fois Phase 2 validée : **Phase 3 - Préparation JMeter**

```bash
# À faire immédiatement après Phase 2
# Consultez TODO.md → Phase 3
```

---

## 📝 Notes Phase 2

```
Date de démarrage  : _____________________
Heure de démarrage : _____________________

Problèmes rencontrés :
_________________________________________________________________
_________________________________________________________________

Solutions appliquées :
_________________________________________________________________
_________________________________________________________________

Observations supplémentaires :
_________________________________________________________________
_________________________________________________________________

Prêt pour Phase 3 : ☐ OUI  ☐ NON

Signature/Initiales : __________ Date: __________
```

---

## ⏱️ Timeline Phase 2

| Étape | Durée | Cumul |
|-------|-------|-------|
| 1. Validation env | 15 min | 15 min |
| 2. Compiler | 10 min | 25 min |
| 3. Docker start | 1 min | 26 min |
| 4. Vérifier PostgreSQL | 5 min | 31 min |
| 5. Démarrer app | 1 min | 32 min |
| 6. Tester endpoints | 5 min | 37 min |
| 7. Prometheus | 5 min | 42 min |
| 8. Grafana | 5 min | 47 min |
| 9. 3 variantes | 15 min | 62 min |
| 10. Checklist | 5 min | 67 min |
| **TOTAL** | | **≈1h10** |

---

## ✅ Check Avant Passage à Phase 3

Ne passer à Phase 3 que si :

- [x] Tous les ✓ FAIT cochés ci-dessus
- [x] Aucune erreur lors du démarrage
- [x] Tous les endpoints répondent 200 OK
- [x] Prometheus scrape l'app
- [x] Grafana affiche les métriques
- [x] Les 3 variantes tournent sans erreur
- [x] PostgreSQL accessible avec données

---

**Status Phase 2** : ☐ À FAIRE  |  ☐ EN COURS  |  ☐ COMPLÉTÉE

**Date validé** : ___________________

---

Pour commencer immédiatement :

```bash
# 1. PowerShell
cd C:\Users\youbitech\Desktop\Benchmark

# 2. Compiler
mvn clean compile

# 3. Lancer le launcher
powershell -ExecutionPolicy Bypass -File launcher.ps1

# 4. Choisir option 4 (Docker)
# 5. Choisir option 2 (Variante C)
# 6. Vérifier http://localhost:8080/categories
```

**C'est parti! 🚀**
# 🚀 PHASE 2 : Validation et Démarrage - À Faire Maintenant

**Status** : Phase 1 ✅ Complétée  
**Prochaine** : Phase 2 ⏳ À commencer

---

## 📋 Checklist Phase 2

### ✅ Étape 1 : Validation de l'environnement (15 min)

Exécuter depuis PowerShell :

```bash
# 1. Vérifier Java
java -version
# Attendu: Java 17 ou supérieur

# 2. Vérifier Maven
mvn -version
# Attendu: Maven 3.8+

# 3. Vérifier Docker
docker --version
docker ps
# Attendu: Docker en cours d'exécution

# 4. Vérifier le projet
cd C:\Users\youbitech\Desktop\Benchmark
ls -la
# Attendu: pom.xml, docker-compose.yml, launcher.ps1 visibles
```

**✓ FAIT** : ___________________ (date/heure)

---

### ✅ Étape 2 : Compiler le projet (10 min)

```bash
cd C:\Users\youbitech\Desktop\Benchmark
mvn clean compile
```

**Attendu** :
```
[INFO] BUILD SUCCESS
```

**Si erreur** :
- Vérifier Java 17 : `java -version`
- Nettoyer cache Maven : `mvn clean -U compile`
- Vérifier pom.xml pas corrompu

**✓ FAIT** : ___________________ (date/heure)

---

### ✅ Étape 3 : Démarrer l'infrastructure Docker (30 sec)

```bash
# Option 1 : Via launcher.ps1
powershell -ExecutionPolicy Bypass -File launcher.ps1
# Choisir option : 4

# Option 2 : Via Docker Compose directement
docker-compose up -d
```

**Attendu** :
```
benchmark-postgres     Up (healthy)
benchmark-prometheus   Up
benchmark-grafana      Up
benchmark-influxdb     Up
```

**Vérifier** :
```bash
docker-compose ps
# Tous les services doivent être "Up"
```

**Si erreur** :
- Docker Desktop doit être ouvert
- Port 5432 ne doit pas être occupé

**✓ FAIT** : ___________________ (date/heure)

---

### ✅ Étape 4 : Vérifier PostgreSQL (5 min)

```bash
# Tester la connexion
psql -U postgres -d benchmark_db -c "SELECT COUNT(*) as categories FROM category;"

# Attendu: 2000+ rows
# Ou via GUI: pgAdmin, DBeaver, etc.
```

**Vérifier aussi les items** :
```bash
psql -U postgres -d benchmark_db -c "SELECT COUNT(*) as items FROM item;"
# Attendu: 100000+ rows
```

**Si tables vides** :
```bash
# Réexécuter le script init
psql -U postgres -d benchmark_db -f src/main/resources/init-db.sql
```

**✓ FAIT** : ___________________ (date/heure)

---

### ✅ Étape 5 : Démarrer l'application (1 min)

**Via Launcher PowerShell** :
```bash
# Menu option : 2 (Variante C - Spring MVC)
```

**Via Maven direct** :
```bash
mvn spring-boot:run -Dspring-boot.run.profiles=mvc
```

**Attendu** (après ~15-20 sec) :
```
Tomcat started on port(s): 8080 with context path ''
```

**✓ FAIT** : ___________________ (date/heure)

---

### ✅ Étape 6 : Tester les endpoints (5 min)

**Via PowerShell** :
```bash
curl -X GET "http://localhost:8080/categories?page=0&size=5"
```

**Ou via navigateur** :
```
http://localhost:8080/categories?page=0&size=5
http://localhost:8080/items?page=0&size=5
http://localhost:8080/categories/1
```

**Attendu** :
```json
{
  "content": [
    {
      "id": 1,
      "code": "CAT0001",
      "name": "Catégorie 1",
      "updatedAt": "2025-01-11T..."
    }
  ],
  "pageable": {...},
  "totalElements": 2000
}
```

**✓ FAIT** : ___________________ (date/heure)

---

### ✅ Étape 7 : Vérifier Prometheus (5 min)

**Accéder à Prometheus** :
```
http://localhost:9090
```

**Vérifier que l'app est scrapée** :
1. Aller à Status → Targets
2. Chercher "localhost:8080"
3. Status doit être "UP" (vert)

**Si "DOWN"** :
- Vérifier que l'app tourne toujours
- Vérifier que `/actuator/prometheus` répond
- Vérifier prometheus.yml contient la bonne config

**Tester une métrique** :
1. Faire une requête : `curl http://localhost:8080/categories`
2. Aller dans Prometheus
3. Chercher : `http_requests_total`
4. Chercher : `process_cpu_usage`

**✓ FAIT** : ___________________ (date/heure)

---

### ✅ Étape 8 : Vérifier Grafana (5 min)

**Accéder à Grafana** :
```
http://localhost:3000
Login: admin
Password: admin
```

**Configurer Prometheus comme source** :
1. Cliquer sur "Connections" (ou "Data Sources")
2. Chercher Prometheus
3. Si absent : "Add new data source"
4. URL: `http://prometheus:9090`
5. Save

**Créer un test dashboard** :
1. Nouveau Dashboard
2. Ajouter un panel
3. Requête : `process_cpu_usage`
4. Voir le graphique se remplir

**✓ FAIT** : ___________________ (date/heure)

---

### ✅ Étape 9 : Tester les 3 Variantes (15 min)

#### Variante A (Jersey)

```bash
# Arrêter Variante C (Ctrl+C)
# Démarrer Variante A
mvn spring-boot:run -Dspring-boot.run.profiles=jersey

# Attendre "Tomcat started"
# Tester
curl http://localhost:8080/api/categories
```

**Attendu** : 200 OK avec données

**✓ FAIT** : ___________________ (date/heure)

#### Variante C (Spring MVC)

```bash
# Arrêter Variante A (Ctrl+C)
# Démarrer Variante C
mvn spring-boot:run -Dspring-boot.run.profiles=mvc

# Attendre "Tomcat started"
# Tester
curl http://localhost:8080/categories
```

**Attendu** : 200 OK avec données

**✓ FAIT** : ___________________ (date/heure)

#### Variante D (Spring Data REST)

```bash
# Arrêter Variante C (Ctrl+C)
# Démarrer Variante D
mvn spring-boot:run -Dspring-boot.run.profiles=data-rest

# Attendre "Tomcat started"
# Tester
curl http://localhost:8080/api/categories
```

**Attendu** : 200 OK avec **HAL format** (liens _links, _embedded)

**✓ FAIT** : ___________________ (date/heure)


