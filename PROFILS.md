# Générer un assembly (all-in-one)
mvn clean assembly:assembly
```
## Profils Maven pour chaque variante

Ce projet utilise des profils Maven pour compiler et exécuter les 3 variantes indépendamment.

### Variante C (Spring @RestController) - Profil par défaut

```bash
# Compiler et exécuter
mvn clean spring-boot:run

# Ou démarrer sur port spécifique
mvn clean spring-boot:run -Dspring-boot.run.arguments="--server.port=8080"
```

### Variante D (Spring Data REST)

```bash
# Modifier application.yml ou passer la config en paramètre
mvn clean spring-boot:run -Dspring-boot.run.arguments="--server.port=8080"
```

### Variante A (Jersey) - À implémenter

À développer dans la phase suivante du TP.

## Configuration pour chaque variante

### application.yml - Variante C (@RestController)
```yaml
app:
  use-join-fetch: false  # Mode baseline (N+1 queries)
```

### application.yml - Variante D (Spring Data REST)
```yaml
spring:
  data:
    rest:
      base-path: /api  # Tous les endpoints sont sous /api
```

## Commandes Maven utiles

```bash
# Nettoyer et compiler
mvn clean compile

# Exécuter les tests
mvn test

# Package en JAR
mvn clean package

# Package en JAR avec dépendances
mvn clean package -DskipTests

# Vérifier les dépendances
mvn dependency:tree


