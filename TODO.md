- [ ] Erreurs < 1%
- [ ] Pas de timeouts

**Collector les métriques** :
- [ ] RPS moyen
- [ ] p50, p95, p99 latency
- [ ] Taux d'erreurs
- [ ] CPU, RAM (Prometheus)

#### 3. Scénario JOIN-filter (16 min total)
```
Palier 1 : 60 threads, 8 min
Palier 2 : 120 threads, 8 min
```

#### 4. Scénario MIXED (20 min total)
```
Palier 1 : 50 threads, 10 min
Palier 2 : 100 threads, 10 min
```

#### 5. Scénario HEAVY-body (16 min total)
```
Palier 1 : 30 threads, 8 min
Palier 2 : 60 threads, 8 min
```

### Temps total par variante
- READ-heavy : 30 min
- JOIN-filter : 16 min
- MIXED : 20 min
- HEAVY-body : 16 min
- **Sous-total : 82 minutes par variante**
- **Total 3 variantes : 246 minutes ≈ 4h**

## 📈 Phase 5 : Analyse et synthèse (À FAIRE)

### Étape 1 : Remplir les tableaux T2-T7
- [ ] T2 : Résultats JMeter bruts
- [ ] T3 : Métriques JVM de Prometheus
- [ ] T4 : Détails JOIN-filter
- [ ] T5 : Détails MIXED
- [ ] T6 : Incidents/erreurs
- [ ] T7 : Synthèse et conclusion

### Étape 2 : Analyser l'impact N+1
- [ ] Variante C avec `app.use-join-fetch=false`
- [ ] Variante C avec `app.use-join-fetch=true`
- [ ] Comparer les résultats

### Étape 3 : Créer les visualisations
- [ ] Graphiques RPS vs Threads
- [ ] Graphiques Latency (p50/p95/p99)
- [ ] Graphiques CPU/RAM
- [ ] Tableau comparatif des 3 variantes

### Étape 4 : Rédiger le rapport
- [ ] Observations par scénario
- [ ] Conclusions par variante
- [ ] Recommandations d'usage
- [ ] Forces et faiblesses

## 🔧 Tâches Additionnelles (Optionnelles)

- [ ] Implémenter la Variante A (Jersey) avec ressources JAX-RS existantes
- [ ] Tester avec différents pool sizes HikariCP (10, 20, 50)
- [ ] Tester avec différents batch sizes Hibernate (10, 20, 50)
- [ ] Ajouter des projections Spring Data REST pour limiter le HAL
- [ ] Tester avec pagination de différentes tailles (20, 50, 100)
- [ ] Analyser le coût de sérialisation HAL
- [ ] Créer un graphique "Cost of Abstraction"

## 📝 Fichiers à consulter

- `README.md` - Documentation générale
- `GUIDE_EXECUTION.md` - Guide détaillé de démarrage
- `PROFILS.md` - Explication des profils Maven
- `RESULTATS_BENCHMARK.md` - Tableaux à remplir
- `docker-compose.yml` - Infrastructure Docker
- `application.yml`, `application-*.yml` - Configuration Spring

## 🛠 Commandes utiles

```bash
# Vérifier les erreurs de compilation
mvn clean compile

# Lancer une variante
mvn spring-boot:run -Dspring-boot.run.profiles=mvc

# Arrêter les services Docker
docker-compose down

# Réinitialiser la BD
docker-compose down -v

# Voir les logs d'une application
mvn spring-boot:run -Dspring-boot.run.arguments="--logging.level.root=DEBUG"

# Tester un endpoint avec cURL
curl -X GET "http://localhost:8080/categories?page=0&size=5" -H "Accept: application/json"

# Générer les IDs pour JMeter (PowerShell)
(1..100000) | ForEach-Object { $_ } > src/main/resources/test-data/item_ids.csv
```

## ⚠️ Points d'Attention

1. **Toujours arrêter l'application avant de lancer une autre variante**
   - Éviter les conflits de port (8080)

2. **Vérifier que PostgreSQL est accessible**
   - Tester : `psql -U postgres -d benchmark_db -c "SELECT COUNT(*) FROM category;"`

3. **Désactiver le cache HTTP et Hibernate L2 cache**
   - Vérifier dans `application.yml`

4. **Utiliser les mêmes conditions pour toutes les variantes**
   - Pool size, threads JVM, scénarios JMeter

5. **Enregistrer les résultats immédiatement**
   - Prendre des captures JMeter/Prometheus
   - Remplir les tableaux

6. **Relancer les tests 2-3 fois**
   - Résultats peuvent varier légèrement
   - Prendre les valeurs moyennes

## 📞 Besoin d'aide ?

- **Compilation** : Vérifier le pom.xml et la version Java (17+)
- **Erreur PostgreSQL** : Vérifier les identifiants dans application.yml
- **Port déjà utilisé** : `netstat -ano | findstr :8080` (Windows)
- **Pas de métriques** : Vérifier que Prometheus scrape http://localhost:8080/actuator/prometheus

---

**Dernière mise à jour** : 2025-01-11  
**Status** : Phase 2 prête à commencer
# Plan d'Exécution du TP - Benchmark REST Services

## ✅ Phase 1 : Mise en place du projet (COMPLÉTÉE)

- [x] Structure Maven avec pom.xml
- [x] Modèles de données (Category, Item)
- [x] Repositories Spring Data (CategoryRepository, ItemRepository)
- [x] Services métier (CategoryService, ItemService)
- [x] Controllers Spring (@RestController)
- [x] Ressources Jersey (JAX-RS)
- [x] Configuration Spring Boot + Profiles
- [x] Docker Compose (PostgreSQL, Prometheus, Grafana, InfluxDB)
- [x] Documentation et guides

## 📋 Phase 2 : Préparation et validation (À FAIRE)

### Étape 1 : Vérifier la compilation
```bash
cd C:\Users\youbitech\Desktop\Benchmark
mvn clean compile
```
**Objectif** : S'assurer qu'il n'y a pas d'erreurs de compilation
**Attendu** : BUILD SUCCESS

### Étape 2 : Démarrer l'infrastructure Docker
```bash
docker-compose up -d
```
**Objectif** : Vérifier que PostgreSQL, Prometheus, Grafana, InfluxDB démarrent
**Attendu** : Tous les services UP and running

### Étape 3 : Initialiser la base de données
```bash
# Option 1 : Via Docker (automatique au démarrage)
# Option 2 : Via psql
psql -U postgres -d benchmark_db -f src/main/resources/init-db.sql
```
**Objectif** : Créer les tables et insérer les données de test
**Attendu** : 2000 catégories + 100 000 articles

### Étape 4 : Démarrer la Variante C (Spring MVC)
```bash
mvn spring-boot:run -Dspring-boot.run.profiles=mvc -Dspring-boot.run.arguments="--server.port=8080"
```
**Objectif** : Vérifier que l'application démarre sans erreurs
**Attendu** : "Tomcat started on port(s): 8080"

### Étape 5 : Tester les endpoints
```bash
curl -X GET "http://localhost:8080/categories?page=0&size=5"
```
**Objectif** : Vérifier que les endpoints sont accessibles
**Attendu** : Response HTTP 200 avec données JSON

### Étape 6 : Accéder à Prometheus
```
http://localhost:9090
```
**Objectif** : Vérifier que Prometheus scrape l'application
**Attendu** : Métriques visibles dans la requête : `http_requests_total`

### Étape 7 : Accéder à Grafana
```
http://localhost:3000 (admin/admin)
```
**Objectif** : Créer un dashboard simple pour JVM metrics
**Attendu** : Dashboard visible avec CPU, Memory, Threads

## 🚀 Phase 3 : Préparation JMeter (À FAIRE)

### Étape 1 : Créer les fichiers JMeter
- [ ] `READ-heavy.jmx` - Déjà créé, à affiner
- [ ] `JOIN-filter.jmx` - À créer
- [ ] `MIXED.jmx` - À créer
- [ ] `HEAVY-body.jmx` - À créer

### Étape 2 : Créer les fichiers de données
- [ ] `category_ids.csv` - Créé (30 premières lignes, à générer 2000)
- [ ] `item_ids.csv` - Créé (50 lignes, à générer 100 000)
- [ ] `item_payloads_1kb.csv` - Créé, à compléter
- [ ] `item_payloads_5kb.csv` - À créer
- [ ] `category_payloads.csv` - À créer

### Étape 3 : Paramétrer JMeter
- [ ] InfluxDB Backend Listener (configuré dans le JMX)
- [ ] HTTP Request Defaults
- [ ] CSV Data Set Config
- [ ] Désactiver les listeners (sauf Backend Listener)

## 📊 Phase 4 : Exécution des tests (À FAIRE)

### Pour chaque variante (A, C, D) :

#### 1. Démarrer l'application sur le port 8080
```bash
mvn spring-boot:run -Dspring-boot.run.profiles=<profile> --server.port=8080
```

#### 2. Scénario READ-heavy (30 min total)
```
Palier 1 : 50 threads, 10 min
Palier 2 : 100 threads, 10 min
Palier 3 : 200 threads, 10 min
```

**Checkpoint** : Vérifier dans JMeter
- [ ] RPS stable

