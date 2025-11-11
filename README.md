# Benchmark REST Services - Projet TP

Ce projet implémente un benchmark de performance pour comparer 3 variantes de Web Services REST :
- **Variante A** : JAX-RS (Jersey) + JPA/Hibernate
- **Variante C** : Spring Boot + @RestController + JPA/Hibernate  
- **Variante D** : Spring Boot + Spring Data REST

## Architecture

```
src/
├── main/
│   ├── java/
│   │   ├── com/example/
│   │   │   └── Application.java          # Spring Boot main
│   │   └── fr/univ/
│   │       ├── model/
│   │       │   ├── Category.java
│   │       │   └── Item.java
│   │       ├── repository/
│   │       │   ├── CategoryRepository.java
│   │       │   └── ItemRepository.java
│   │       ├── service/
│   │       │   ├── CategoryService.java
│   │       │   └── ItemService.java
│   │       └── controller/
│   │           ├── CategoryController.java
│   │           ├── ItemController.java
│   │           └── CategoryItemsController.java
│   └── resources/
│       ├── application.yml               # Configuration Spring
│       ├── logback.xml                  # Configuration logging
│       └── init-db.sql                  # Script d'init DB
```

## Prérequis

- Java 17+
- Maven 3.8+
- Docker & Docker Compose (pour PostgreSQL, Prometheus, Grafana, InfluxDB)
- JMeter 5.5+

## Démarrage rapide

### 1. Démarrer l'infrastructure (PostgreSQL, Prometheus, Grafana)

```bash
docker-compose up -d
```

Cela va :
- Démarrer PostgreSQL sur `localhost:5432` (user: postgres / pass: postgres)
- Initialiser la BD avec les 2000 catégories et 100 000 articles
- Démarrer Prometheus sur `localhost:9090`
- Démarrer Grafana sur `localhost:3000` (admin/admin)
- Démarrer InfluxDB sur `localhost:8086` (admin/admin123)

### 2. Compiler le projet Maven

```bash
mvn clean compile
```

### 3. Démarrer l'application Spring

**Variante C (avec @RestController)** :
```bash
mvn spring-boot:run -Dspring-boot.run.arguments="--server.port=8080"
```

**Variante D (avec Spring Data REST)** :
```bash
mvn spring-boot:run -Dspring-boot.run.arguments="--server.port=8080 --spring.data.rest.base-path=/api"
```

L'application sera disponible sur `http://localhost:8080`

### 4. Vérifier la santé de l'application

```
http://localhost:8080/actuator/health
http://localhost:8080/actuator/metrics
http://localhost:8080/actuator/prometheus
```

## Endpoints disponibles

### Categories
- `GET /categories?page=0&size=20` - Liste paginée
- `GET /categories/{id}` - Détail
- `POST /categories` - Créer
- `PUT /categories/{id}` - Mettre à jour
- `DELETE /categories/{id}` - Supprimer

### Items
- `GET /items?page=0&size=20` - Liste paginée
- `GET /items/{id}` - Détail
- `GET /items?categoryId={id}&page=0&size=20` - Filtrage par catégorie
- `POST /items` - Créer
- `PUT /items/{id}` - Mettre à jour
- `DELETE /items/{id}` - Supprimer

### Relations
- `GET /categories/{id}/items?page=0&size=20` - Items d'une catégorie

### Variante D (Spring Data REST) endpoints additionnels
- `GET /api/categories` - Exposition automatique
- `GET /api/items` - Exposition automatique
- `GET /api/items/{id}/category` - Relation inverse
- `GET /api/categories/{id}/items` - Exposition relationnelle auto

## Configuration de Prometheus/Grafana

1. Accédez à Grafana : `http://localhost:3000` (admin/admin)
2. Ajoutez Prometheus comme source de données :
   - URL: `http://prometheus:9090`
3. Importez le dashboard : fichier à créer manuellement ou à partir des métriques Prometheus

## Configuration JMeter

Pour chaque scénario de charge, créer un fichier `.jmx` avec :
- Backend Listener → InfluxDB v2 (localhost:8086, bucket: jmeter)
- HTTP Request Defaults avec l'URL de la variante
- CSV Data Set Config pour les IDs et payloads

## Variables d'environnement

Pour contrôler le comportement du benchmark :

```bash
# Mode JOIN FETCH vs N+1
export APP_USE_JOIN_FETCH=true

# Configuration JPA/Hibernate
export SPRING_JPA_HIBERNATE_DDL_AUTO=validate
export SPRING_JPA_SHOW_SQL=false
```

## Points d'attention

- **N+1 Queries** : Comparer avec/sans `@Query("... JOIN FETCH i.category WHERE ...")`
- **Validation** : Bean Validation activée par défaut
- **Sérialisation** : Jackson uniquement (pas d'autres formats)
- **Caching** : L2 cache Hibernate **désactivé** (pour comparabilité)
- **Pagination** : Taille fixe (page/size constants)

## Étapes prochaines

1. **Implémenter Variante A (Jersey)** :
   - Créer `fr.univ.jersey.resource.*` classes
   - Ajouter `web.xml` et configuration JAX-RS
   
2. **Créer les jeux de test JMeter** :
   - Scénario READ-heavy (50 threads → 200)
   - Scénario JOIN-filter (60 → 120 threads)
   - Scénario MIXED (50 → 100 threads)
   - Scénario HEAVY-body (30 → 60 threads)

3. **Instrumenter avec JMX** :
   - JVM flags: `-Dcom.sun.management.jmxremote=true`
   - JMX Exporter pour Prometheus

4. **Collecter les résultats** :
   - Remplir les tableaux T0-T7
   - Analyser les tendances JMeter/Prometheus

## Ressources

- [Spring Data JPA Documentation](https://spring.io/projects/spring-data-jpa)
- [Spring Data REST](https://spring.io/projects/spring-data-rest)
- [Jersey JAX-RS](https://jersey.java.net/)
- [JMeter Backend Listener InfluxDB](https://jmeter.apache.org/usermanual/component_reference.html#Backend_Listener)
- [Prometheus + Micrometer](https://micrometer.io/docs/registry/prometheus)

## Licence

Projet académique - Benchmark de performances.

