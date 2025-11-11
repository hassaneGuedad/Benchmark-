- [ ] JMeter 5.5+ installé : `jmeter --version`
- [ ] Accessible par `jmeter` en ligne de commande
- [ ] Fichiers `.jmx` trouvés en `src/main/resources/jmeter/`
- [ ] CSV data files trouvés en `src/main/resources/test-data/`

## ✅ Configuration IDE (IntelliJ)

Si utilisation d'IntelliJ :

- [ ] Projet configuré comme Maven project
- [ ] JDK 17+ sélectionné en File → Project Structure
- [ ] Application.java reconnu en tant que classe exécutable
- [ ] Peut lancer via Run → Run Configuration

## ✅ Configuration finale

Avant de lancer les tests JMeter :

- [ ] `app.use-join-fetch: false` dans `application.yml` (pour baseline)
- [ ] `hibernate.cache.use_second_level_cache: false` (désactivé)
- [ ] `spring.jpa.show-sql: false` (désactivé)
- [ ] `logging.level.root: INFO` (pas de DEBUG)
- [ ] `server.tomcat.threads.max: 500`
- [ ] `spring.datasource.hikari.maximum-pool-size: 20`

## ✅ Données de test

- [ ] IDs de catégories générés (1-2000)
- [ ] IDs d'items générés (1-100000)
- [ ] Payloads JSON 1KB et 5KB disponibles
- [ ] CSV Data Set Config configuré dans JMeter

## ✅ Fichiers de résultats

Préparé pour stocker :

- [ ] Dossier `/results/` créé (optionnel)
- [ ] Dossier `/jmeter-logs/` créé (optionnel)
- [ ] Dossier `/screenshots/` créé pour captures

## ✅ Documentation personnelle

Avant de commencer les tests :

- [ ] Lire README.md
- [ ] Lire GUIDE_EXECUTION.md
- [ ] Lire TODO.md étapes 1-5
- [ ] Comprendre les scénarios JMeter (READ-heavy, JOIN-filter, MIXED, HEAVY-body)
- [ ] Connaître les ports : 8080 (app), 5432 (PostgreSQL), 9090 (Prometheus), 3000 (Grafana), 8086 (InfluxDB)

## 🔧 Dépannage rapide

Si erreur lors de la compilation :
```bash
mvn clean
mvn -U compile
```

Si PostgreSQL non accessible :
```bash
docker-compose restart postgres
```

Si port 8080 occupé :
```bash
netstat -ano | findstr :8080
taskkill /PID <PID> /F
```

Si Prometheus ne scrape pas :
- Vérifier que app tourne sur 8080
- Vérifier `http://localhost:8080/actuator/prometheus`
- Vérifier `prometheus.yml` contient la config

Si JMeter ne se connecte pas à InfluxDB :
- Vérifier que InfluxDB est UP : `docker-compose ps`
- Vérifier l'URL dans Backend Listener
- Vérifier les logs InfluxDB : `docker-compose logs influxdb`

## ✅ Prêt à démarrer !

Quand tous les ✅ sont cochés :

1. **Arrêter tous les services** :
   ```bash
   docker-compose down
   ```

2. **Redémarrer clean** :
   ```bash
   docker-compose up -d
   ```

3. **Vérifier tous les services** :
   ```bash
   docker-compose ps
   ```

4. **Lancer la Variante C** :
   ```bash
   mvn spring-boot:run -Dspring-boot.run.profiles=mvc
   ```

5. **Dans une autre fenêtre, lancer JMeter** :
   ```bash
   jmeter -t src/main/resources/jmeter/READ-heavy.jmx
   ```

6. **Monitorer** :
   - Prometheus : `http://localhost:9090`
   - Grafana : `http://localhost:3000`

## 📝 Notes

- Les tests JMeter prennent environ 4 heures pour les 3 variantes
- Il est recommandé de faire d'abord un test rapide (5 min) avant de lancer les tests complets
- Sauvegarder les résultats JMeter immédiatement après chaque test
- Prendre des screenshots des dashboards Prometheus/Grafana
- Remplir les tableaux T0-T7 en même temps que les tests

---

**Checklist version** : 1.0  
**Dernière mise à jour** : 2025-01-11  
**Status** : Prêt pour l'exécution
# Checklist de Préparation - Benchmark REST Services

## ✅ Prérequis système

- [ ] Windows 10/11 avec PowerShell 5.0+
- [ ] Java 17 ou supérieur installé : `java -version`
- [ ] Maven 3.8+ installé : `mvn -version`
- [ ] Docker Desktop installé et en cours d'exécution : `docker ps`
- [ ] PostgreSQL disponible via Docker Compose
- [ ] Git ou accès au projet via dossier

## ✅ Projet Maven

- [ ] `pom.xml` compilable : `mvn clean compile`
- [ ] Dépendances téléchargées (première compilation peut prendre 2-5 min)
- [ ] Pas d'erreurs d'import dans l'IDE

## ✅ Structure du projet

Vérifier la présence de :

- [ ] `src/main/java/com/example/Application.java`
- [ ] `src/main/java/fr/univ/model/Category.java`
- [ ] `src/main/java/fr/univ/model/Item.java`
- [ ] `src/main/java/fr/univ/repository/CategoryRepository.java`
- [ ] `src/main/java/fr/univ/repository/ItemRepository.java`
- [ ] `src/main/java/fr/univ/service/CategoryService.java`
- [ ] `src/main/java/fr/univ/service/ItemService.java`
- [ ] `src/main/java/fr/univ/controller/CategoryController.java`
- [ ] `src/main/java/fr/univ/controller/ItemController.java`
- [ ] `src/main/java/fr/univ/jersey/resource/CategoryResource.java`
- [ ] `src/main/java/fr/univ/jersey/resource/ItemResource.java`
- [ ] `src/main/java/fr/univ/config/RestConfiguration.java`
- [ ] `src/main/resources/application.yml`
- [ ] `src/main/resources/application-mvc.yml`
- [ ] `src/main/resources/application-jersey.yml`
- [ ] `src/main/resources/application-data-rest.yml`
- [ ] `src/main/resources/logback.xml`
- [ ] `docker-compose.yml`
- [ ] `prometheus.yml`

## ✅ Documentation

Vérifier la présence de :

- [ ] `README.md`
- [ ] `GUIDE_EXECUTION.md`
- [ ] `TODO.md`
- [ ] `LAUNCHER_GUIDE.md`
- [ ] `RESULTATS_BENCHMARK.md`
- [ ] `PROFILS.md`

## ✅ Scripts

Vérifier la présence de :

- [ ] `launcher.bat`
- [ ] `launcher.ps1`
- [ ] `src/main/resources/init-db.sql`
- [ ] `src/main/resources/jmeter/READ-heavy.jmx`
- [ ] `src/main/resources/test-data/category_ids.csv`
- [ ] `src/main/resources/test-data/item_ids.csv`

## ✅ Infrastructure Docker

- [ ] Docker Desktop en cours d'exécution
- [ ] `docker-compose.yml` au root du projet
- [ ] Tester le démarrage : `docker-compose up -d`
- [ ] Vérifier les services : `docker-compose ps`
- [ ] Accès PostgreSQL : `psql -U postgres -d benchmark_db -c "SELECT 1"`
- [ ] Accès Prometheus : `curl http://localhost:9090/-/healthy`
- [ ] Accès Grafana : `curl -u admin:admin http://localhost:3000/api/health`
- [ ] Accès InfluxDB : `curl http://localhost:8086/health`

## ✅ Base de données

- [ ] PostgreSQL démarré
- [ ] Base `benchmark_db` créée
- [ ] Tables `category` et `item` créées
- [ ] 2000+ catégories insérées : `SELECT COUNT(*) FROM category;`
- [ ] 100000+ items insérés : `SELECT COUNT(*) FROM item;`
- [ ] Indexes créés : `SELECT * FROM pg_indexes WHERE tablename='item';`

## ✅ Première compilation

```bash
cd C:\Users\youbitech\Desktop\Benchmark
mvn clean compile
```

- [ ] Compilation réussie (BUILD SUCCESS)
- [ ] Pas d'erreurs de dépendances
- [ ] Classes générées dans `target/classes/`

## ✅ Premier démarrage - Variante C

```bash
mvn spring-boot:run -Dspring-boot.run.profiles=mvc --server.port=8080
```

- [ ] Application démarre en moins de 30 secondes
- [ ] Message "Tomcat started on port(s): 8080 with context path ''"
- [ ] Pas d'erreurs en console

## ✅ Tests endpoint

```bash
curl -X GET "http://localhost:8080/categories?page=0&size=5"
```

- [ ] HTTP 200 reçu
- [ ] Réponse JSON avec des catégories
- [ ] Pas d'erreur 500

## ✅ Prometheus

- [ ] Accessible : `http://localhost:9090`
- [ ] Application scrapée : `http://localhost:9090/targets`
- [ ] Status "UP" pour `localhost:8080`
- [ ] Métriques visibles : `http_requests_total`

## ✅ Grafana

- [ ] Accessible : `http://localhost:3000`
- [ ] Login admin/admin fonctionne
- [ ] Prometheus configuré comme data source
- [ ] Peut créer des requêtes simples

## ✅ InfluxDB

- [ ] Accessible : `http://localhost:8086`
- [ ] UI disponible
- [ ] Bucket `jmeter` prêt (pour JMeter Backend Listener)

## ✅ JMeter


