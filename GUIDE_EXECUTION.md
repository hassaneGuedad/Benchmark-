# Guide d'exécution - Variantes du Benchmark

## Prérequis

1. **PostgreSQL 14+** démarré sur localhost:5432
2. **Maven 3.8+** installé
3. **Java 17+** configuré
4. **Docker Compose** (optionnel) pour l'infrastructure complète

## Démarrage de l'infrastructure complète

```bash
# Démarrer tous les services (PostgreSQL, Prometheus, Grafana, InfluxDB)
docker-compose up -d

# Vérifier le statut
docker-compose ps

# Arrêter les services
docker-compose down
```

## Variante A : Jersey + JPA/Hibernate

### Démarrage

```bash
cd C:\Users\youbitech\Desktop\Benchmark

# Compiler
mvn clean compile

# Lancer l'application Jersey
mvn spring-boot:run -Dspring-boot.run.profiles=jersey -Dspring-boot.run.arguments="--server.port=8080"
```

### Endpoints
- `http://localhost:8080/api/categories`
- `http://localhost:8080/api/items`
- `http://localhost:8080/api/categories/{id}/items`

### Métriques Prometheus
- `http://localhost:8080/actuator/prometheus` (avec Spring Boot Actuator)

## Variante C : Spring Boot @RestController + JPA/Hibernate

### Démarrage

```bash
# Compiler
mvn clean compile

# Lancer l'application Spring MVC
mvn spring-boot:run -Dspring-boot.run.profiles=mvc -Dspring-boot.run.arguments="--server.port=8080"
```

### Endpoints
- `http://localhost:8080/categories`
- `http://localhost:8080/items`
- `http://localhost:8080/categories/{id}/items`

### Métriques Prometheus
- `http://localhost:8080/actuator/prometheus`

## Variante D : Spring Boot + Spring Data REST

### Démarrage

```bash
# Compiler
mvn clean compile

# Lancer l'application Spring Data REST
mvn spring-boot:run -Dspring-boot.run.profiles=data-rest -Dspring-boot.run.arguments="--server.port=8080"
```

### Endpoints
- `http://localhost:8080/api/categories`
- `http://localhost:8080/api/items`
- `http://localhost:8080/api/categories/{id}/items` (exposition automatique)
- `http://localhost:8080/api/items/{id}/category` (relation inverse)

### Format de réponse (HAL+JSON)
```json
{
  "_embedded": {
    "categories": [...]
  },
  "_links": {
    "self": {...}
  },
  "page": {...}
}
```

### Métriques Prometheus
- `http://localhost:8080/actuator/prometheus`

## Mode de développement vs Mode JOIN FETCH

### Mode baseline (N+1 queries par défaut)

```bash
mvn spring-boot:run -Dspring-boot.run.arguments="--app.use-join-fetch=false"
```

### Mode JOIN FETCH (optimisé)

```bash
mvn spring-boot:run -Dspring-boot.run.arguments="--app.use-join-fetch=true"
```

## Tester les endpoints avec cURL

### GET Categories (paginé)
```bash
curl -X GET "http://localhost:8080/categories?page=0&size=20"
```

### GET Item par ID
```bash
curl -X GET "http://localhost:8080/items/1"
```

### GET Items par Catégorie
```bash
curl -X GET "http://localhost:8080/items?categoryId=1&page=0&size=20"
```

### POST Créer une catégorie
```bash
curl -X POST "http://localhost:8080/categories" \
  -H "Content-Type: application/json" \
  -d '{"code":"CAT_NEW","name":"Nouvelle Catégorie"}'
```

### PUT Mettre à jour une catégorie
```bash
curl -X PUT "http://localhost:8080/categories/1" \
  -H "Content-Type: application/json" \
  -d '{"code":"CAT_UPDATED","name":"Catégorie Mise à jour"}'
```

### DELETE Supprimer une catégorie
```bash
curl -X DELETE "http://localhost:8080/categories/1"
```

## Paramètres de configuration

### Variables d'environnement

```bash
# Activer le JOIN FETCH
set APP_USE_JOIN_FETCH=true

# Changer le port
set SERVER_PORT=8081

# Configuration Postgres
set SPRING_DATASOURCE_URL=jdbc:postgresql://localhost:5432/benchmark_db
set SPRING_DATASOURCE_USERNAME=postgres
set SPRING_DATASOURCE_PASSWORD=postgres
```

### Fichiers de configuration

- `application.yml` - Configuration par défaut
- `application-jersey.yml` - Profil Jersey (Variante A)
- `application-mvc.yml` - Profil Spring MVC (Variante C)
- `application-data-rest.yml` - Profil Spring Data REST (Variante D)

## Accès à Grafana

1. Ouvrir `http://localhost:3000`
2. Se connecter : admin / admin
3. Ajouter Prometheus comme source de données :
   - URL: `http://prometheus:9090`
4. Créer des dashboards pour les métriques JVM et JMeter

## Logs

Les logs sont écrits dans :
- Console (stdout)
- Fichier : `./logs/spring.log`

Pour plus de détails, modifier le niveau de log dans `application.yml` :
```yaml
logging:
  level:
    fr.univ: DEBUG
    org.hibernate.SQL: DEBUG
```

## Checklist avant chaque run JMeter

- [ ] PostgreSQL démarré et accessible
- [ ] Application lancée sur le bon port (8080, 8081, 8082)
- [ ] Prometheus scrape l'application (vérifier `http://localhost:9090`)
- [ ] InfluxDB accessible sur localhost:8086
- [ ] Pas d'autres instances de l'app en cours d'exécution
- [ ] Logs configurés pour ne pas ralentir l'app
- [ ] Cache L2 Hibernate désactivé (`hibernate.cache.use_second_level_cache=false`)
- [ ] HTTP cache désactivé (Spring ne cache pas par défaut)

## Arrêt propre

```bash
# Arrêter l'application (Ctrl+C dans le terminal)

# Arrêter les services Docker
docker-compose down

# Optionnel : supprimer les volumes (réinitialiser les données)
docker-compose down -v
```

## Troubleshooting

### Erreur : Port 8080 déjà utilisé
```bash
# Utiliser un autre port
mvn spring-boot:run -Dspring-boot.run.arguments="--server.port=8081"

# Ou tuer le processus existant (Windows)
netstat -ano | findstr :8080
taskkill /PID <PID> /F
```

### Erreur : Impossible de se connecter à PostgreSQL
```bash
# Vérifier que PostgreSQL est démarré
docker-compose ps

# Vérifier les identifiants dans application.yml
# Par défaut : user=postgres, password=postgres, host=localhost, port=5432
```

### Erreur : Table n'existe pas
```bash
# Vérifier que le script init-db.sql a été exécuté
psql -U postgres -d benchmark_db -f src/main/resources/init-db.sql

# Ou réinitialiser la BD
docker-compose down -v
docker-compose up -d
```

### Performance faible
- Vérifier que le cache Hibernate est désactivé
- Vérifier que les statistiques Hibernate ne sont pas activées
- Vérifier les logs (peut être activé en DEBUG et ralentir)
- Vérifier les indexes de la BD : `CREATE INDEX idx_item_category ON item(category_id);`

## Ressources utiles

- [Spring Boot Documentation](https://spring.io/projects/spring-boot)
- [Spring Data REST](https://spring.io/projects/spring-data-rest)
- [Jersey Documentation](https://eclipse-ee4j.github.io/jersey/)
- [PostgreSQL CLI](https://www.postgresql.org/docs/current/app-psql.html)
- [JMeter Best Practices](https://jmeter.apache.org/usermanual/best-practices.html)

