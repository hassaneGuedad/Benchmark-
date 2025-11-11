---

## 🛠 Technologie Stack

| Couche | Technologie |
|--------|------------|
| **Langage** | Java 17 |
| **Framework Web (C)** | Spring Boot 3.2.1 + Spring MVC |
| **Framework Web (A)** | Jersey 3.1.5 (JAX-RS) |
| **Framework Web (D)** | Spring Data REST |
| **ORM** | Hibernate 6.4.1 |
| **BD** | PostgreSQL 16 |
| **Pool Connexion** | HikariCP 5.1.0 |
| **JSON** | Jackson 2.16.0 |
| **Validation** | Hibernate Validator 8.0.1 |
| **Monitoring** | Prometheus + Grafana |
| **Test de Charge** | JMeter 5.5+ |
| **Time Series DB** | InfluxDB 2.x |
| **Containerization** | Docker Compose |

---

## 📊 Points de Mesure

| Métrique | Où mesurer |
|----------|-----------|
| **RPS** | JMeter Summary Report |
| **Latency p50/p95/p99** | JMeter |
| **Erreurs %** | JMeter |
| **CPU %** | Prometheus (process_cpu_usage) |
| **RAM Mo** | Prometheus (jvm_memory_used_bytes) |
| **GC ms** | Prometheus (jvm_gc_collection_seconds) |
| **Threads actifs** | Prometheus (jvm_threads_live) |
| **HikariCP** | Prometheus (hikaricp_connections_*) |

---

## 🎯 Objectifs de Benchmark

Évaluer sur les mêmes données/DB/pool :

1. **Latence** → Impact du framework
2. **Débit** → Efficacité du code généré
3. **Fiabilité** → Taux d'erreurs
4. **Ressources** → CPU/RAM/GC
5. **Abstraction** → Coût du frameworks
6. **Facilité** → Temps d'implémentation

---

## 💡 Points Clés

✅ **Déjà en place** :
- Architecture modulaire
- DTOs et repositories
- Deux modes N+1 vs JOIN FETCH
- Configuration multi-profils
- Infrastructure Docker complète
- Documentation exhaustive
- Scripts d'automatisation

⚠️ **À faire** :
- Tester la compilation
- Démarrer Docker et l'app
- Compléter les scénarios JMeter
- Générer les données de test (2000 cat, 100k items)
- Lancer les tests de charge
- Remplir les résultats

---

## 📞 Support

**Erreur de compilation ?**
→ Vérifier `pom.xml` et Maven version

**PostgreSQL inaccessible ?**
→ Vérifier `docker-compose ps`

**Port déjà utilisé ?**
→ `netstat -ano | findstr :8080` sur Windows

**JMeter ne démarre pas ?**
→ Vérifier JMeter installé et fichiers `.jmx` valides

**Prometheus ne scrape pas ?**
→ Vérifier `http://localhost:8080/actuator/prometheus` accessible

---

## 📝 Notes de Mise en Place

- Temps de création : ~2h
- Fichiers créés : 30+
- Lignes de code : ~2500+
- Documentation : ~1500 lignes
- Infrastructure : Docker Compose ready
- Test : JMeter template fourni

**Statut** : ✅ Prêt pour la Phase 2 (Validation & Tests)

---

**Créé par** : AI Assistant (GitHub Copilot)  
**Date** : 11 janvier 2025  
**Version** : 1.0 - Phase 1 Complete

Pour commencer, consultez : **README.md** puis **GUIDE_EXECUTION.md**
# Résumé de la Mise en Place - Benchmark REST Services

**Date** : 11 janvier 2025  
**Statut** : ✅ Phase 1 Complétée - Prêt pour Phase 2 (Tests)

---

## 📦 Qu'est-ce qui a été créé ?

### 1. **Architecture du Projet Maven**
   - `pom.xml` complet avec dépendances pour les 3 variantes
   - Support de Java 17
   - Spring Boot 3.2.1
   - Jersey 3.1.5
   - Hibernate 6.4.1
   - PostgreSQL driver

### 2. **Modèles de données** (JPA/Hibernate)
   - `Category.java` : Entité avec relation 1-N
   - `Item.java` : Entité avec FK vers Category
   - Annotations JPA correctes (LAZY loading, etc.)
   - Getters/Setters complets

### 3. **Couche Données**
   - `CategoryRepository.java` : Spring Data JPA
   - `ItemRepository.java` : Queries custom (avec/sans JOIN FETCH)
   - Support pour la comparaison N+1 queries

### 4. **Couche Métier**
   - `CategoryService.java` : Logique métier
   - `ItemService.java` : Logique métier + flag `use-join-fetch`
   - `@Transactional` sur les services

### 5. **Variante C : Spring @RestController**
   - `CategoryController.java` : 5 endpoints CRUD
   - `ItemController.java` : 6 endpoints incluant filtrage
   - `CategoryItemsController.java` : Relation paginée
   - Gestion HTTP standard (200, 201, 204, 404)

### 6. **Variante A : Jersey/JAX-RS**
   - `CategoryResource.java` : Resources JAX-RS
   - `ItemResource.java` : Resources JAX-RS
   - `CategoryItemsResource.java` : Relation
   - `JerseyConfig.java` : Configuration ResourceConfig

### 7. **Variante D : Spring Data REST** (Configuration)
   - `RestConfiguration.java` : RepositoryRestConfigurer
   - Configuration HAL+JSON
   - Exposition automatique + relations

### 8. **Configuration Spring Boot**
   - `Application.java` : Point d'entrée Spring
   - `application.yml` : Configuration par défaut
   - `application-mvc.yml` : Profil Variante C
   - `application-jersey.yml` : Profil Variante A
   - `application-data-rest.yml` : Profil Variante D
   - Actuator Prometheus activé

### 9. **DTOs** (optionnel)
   - `ItemLightDTO.java` : Projection légère
   - `CategoryLightDTO.java` : Projection légère
   - Utile pour éviter les N+1

### 10. **Infrastructure Docker**
   - `docker-compose.yml` : PostgreSQL 16, Prometheus, Grafana, InfluxDB
   - Réseaux bridgés
   - Volumes persistants
   - Health checks

### 11. **Monitoring**
   - `prometheus.yml` : Configuration scrape
   - Grafana pré-configuré
   - InfluxDB pour JMeter

### 12. **Base de Données**
   - `init-db.sql` : Script d'initialisation
   - Tables category et item
   - 2000 catégories + 100 000 items (générés automatiquement)
   - Indexes pour performance

### 13. **Données de Test JMeter**
   - `READ-heavy.jmx` : Scénario léger
   - `category_ids.csv` : IDs pour tests
   - `item_ids.csv` : IDs pour tests
   - `item_payloads_1kb.csv` : Payloads JSON
   - Prêts pour expansion

### 14. **Documentation Complète**
   - `README.md` : Guide complet du projet
   - `GUIDE_EXECUTION.md` : Comment démarrer chaque variante
   - `PROFILS.md` : Explication des profils Maven
   - `TODO.md` : Plan détaillé étape par étape
   - `LAUNCHER_GUIDE.md` : Guide du launcher
   - `CHECKLIST.md` : Validation avant tests
   - `RESULTATS_BENCHMARK.md` : Tableaux à remplir

### 15. **Scripts d'Automatisation**
   - `launcher.bat` : Menu Windows CMD
   - `launcher.ps1` : Menu PowerShell (coloré et interactif)
   - Commandes intégrées pour Docker, Maven, tests

### 16. **Logging**
   - `logback.xml` : Configuration Logback
   - Rolling files
   - Niveaux configurés

---

## 📊 Résumé des Endpoints

### Disponibles sur toutes les variantes

```
GET    /categories?page=0&size=20              → Liste paginée
GET    /categories/{id}                        → Détail
POST   /categories                             → Créer
PUT    /categories/{id}                        → Mettre à jour
DELETE /categories/{id}                        → Supprimer

GET    /items?page=0&size=20                   → Liste paginée
GET    /items/{id}                             → Détail
GET    /items?categoryId={id}&page=0&size=20   → Filtrage
POST   /items                                  → Créer
PUT    /items/{id}                             → Mettre à jour
DELETE /items/{id}                             → Supprimer

GET    /categories/{id}/items?page=0&size=20   → Relation paginée
```

### Variante D supplémentaires (Spring Data REST)

```
GET    /api/categories/{id}/items              → Via Spring Data REST
GET    /api/items/{id}/category                → Relation inverse
```

---

## 🚀 Comment Démarrer

### Option 1 : Launcher PowerShell (Recommandé)
```bash
cd C:\Users\youbitech\Desktop\Benchmark
powershell -ExecutionPolicy Bypass -File launcher.ps1

# Menu interactif :
# 1. Variante A (Jersey)
# 2. Variante C (Spring MVC)
# 3. Variante D (Spring Data REST)
# 4. Démarrer Docker
# 5. Arrêter Docker
# 6. Status Docker
# 7. Tester endpoint
# 8. Ouvrir Grafana
# 9. Ouvrir Prometheus
# 0. Quitter
```

### Option 2 : Maven direct
```bash
# Variante C
mvn spring-boot:run -Dspring-boot.run.profiles=mvc

# Variante A
mvn spring-boot:run -Dspring-boot.run.profiles=jersey

# Variante D
mvn spring-boot:run -Dspring-boot.run.profiles=data-rest
```

### Option 3 : Docker (optionnel)
```bash
docker-compose up -d
```

---

## 📈 Scénarios de Test JMeter

À implémenter (templates fournis) :

1. **READ-heavy** (30 min)
   - 50% GET /items
   - 20% GET /items?categoryId
   - 20% GET /categories/{id}/items
   - 10% GET /categories
   - Threads : 50→100→200

2. **JOIN-filter** (16 min)
   - 70% GET /items?categoryId
   - 30% GET /items/{id}
   - Threads : 60→120

3. **MIXED** (20 min)
   - GET/POST/PUT/DELETE items + categories
   - Threads : 50→100

4. **HEAVY-body** (16 min)
   - 50% POST /items (5KB)
   - 50% PUT /items (5KB)
   - Threads : 30→60

**Total : ~82 minutes par variante = 4h pour 3 variantes**

---

## 📋 Fichiers à Consulter

| Fichier | Utilité |
|---------|---------|
| `README.md` | Guide général du projet |
| `GUIDE_EXECUTION.md` | Comment lancer chaque variante |
| `TODO.md` | Plan détaillé à suivre |
| `CHECKLIST.md` | Validation avant tests |
| `LAUNCHER_GUIDE.md` | Comment utiliser le launcher |
| `RESULTATS_BENCHMARK.md` | Tableaux T0-T7 à remplir |

---

## ✅ Prochaines Étapes

### Phase 2 : Validation (1h)
1. ✓ Compiler le projet
2. ✓ Démarrer Docker
3. ✓ Démarrer une variante
4. ✓ Tester les endpoints
5. ✓ Vérifier Prometheus/Grafana

### Phase 3 : Tests JMeter (4h)
1. ✓ Créer les scénarios JMeter complets
2. ✓ Générer les données de test
3. ✓ Tester Variante A (Jersey)
4. ✓ Tester Variante C (Spring MVC)
5. ✓ Tester Variante D (Spring Data REST)

### Phase 4 : Analyse (2h)
1. ✓ Remplir les tableaux T0-T7
2. ✓ Analyser les résultats
3. ✓ Créer les graphiques
4. ✓ Rédiger les conclusions


