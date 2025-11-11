   Attend le message "Tomcat started on port(s): 8080"

4. **Tester un endpoint** (dans une autre PowerShell)
   ```
   Choisir option: 7 (Test endpoint)
   ```
   Devrait afficher des données JSON

### Avant un test JMeter

```
Choisir option: 1 ou 2 ou 3 (selon la variante)
```

Laisser tourner et ne pas fermer le terminal.

### Accès aux interfaces web

```
Choisir option: 8 (Ouvrir Grafana)
Choisir option: 9 (Ouvrir Prometheus)
```

Accès automatique dans le navigateur.

---

## Personnalisation du launcher

### Modifier le port par défaut

**Dans launcher.bat ou launcher.ps1** :
```
--server.port=8080  →  --server.port=8081
```

### Ajouter une variante

**Dans launcher.ps1** :
```powershell
"4" {
    Start-Variant "ma-variante" "Variante personnalisée"
}
```

### Changer les profiles JMeter

Modifier les fichiers `.jmx` dans `src/main/resources/jmeter/`

---

## Troubleshooting

### Erreur : "PowerShell est désactivé"
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Erreur : "Port 8080 déjà utilisé"
```
Choisir option: 2 ou 3 (relancer avec port 8081)
Ou tuer le processus: netstat -ano | findstr :8080
```

### Erreur : "Docker n'est pas installé"
```
Télécharger: https://www.docker.com/products/docker-desktop
Redémarrer après installation
```

### L'app ne répond pas après 30 secondes
```
Vérifier PostgreSQL: docker ps
Vérifier les logs: Spring a généralement besoin de quelques secondes
```

---

## Exemples de flux d'utilisation

### Flux 1 : Test rapide d'une variante

```
1. Launcher PowerShell
2. Choisir option 4 → Infrastructure Docker démarre
3. Attendre 30s
4. Choisir option 2 → Variante C démarre
5. Attendre "Tomcat started"
6. Nouvelle PowerShell : Choisir option 7 → Test endpoint
7. Voir les réponses JSON
8. Ctrl+C pour arrêter
```

### Flux 2 : Préparation pour JMeter

```
1. Launcher PowerShell #1
2. Choisir option 4 → Infrastructure démarre
3. Attendre que tous les services soient UP
4. Choisir option 2 → Variante C démarre
5. Choisir option 6 → Vérifier statut
6. Choisir option 9 → Ouvrir Prometheus
7. Vérifier que l'app est scrapée (http://localhost:8080/actuator/prometheus)
8. Lancer JMeter dans une autre fenêtre
9. Charger READ-heavy.jmx
10. Démarrer le test
11. Voir les métriques dans InfluxDB/Grafana
```

### Flux 3 : Tester les 3 variantes

```
1. Lancer Launcher #1
2. Choisir option 4 → Infrastructure démarre
3. Lancer Launcher #2
4. Choisir option 2 → Variante C (port 8080)
5. Attendre startup
6. Lancer JMeter
7. Test READ-heavy 50→100→200 threads
8. Récupérer les résultats JMeter et Prometheus
9. Arrêter Variante C (Ctrl+C)
10. Choisir option 1 → Variante A (port 8080)
11. Attendre startup
12. Lancer le même test JMeter
13. Etc.
```

---

## Variables d'environnement utiles

Avant de lancer le launcher :

```powershell
# Mode JOIN FETCH (optimisé)
$env:APP_USE_JOIN_FETCH="true"

# Log level DEBUG
$env:LOGGING_LEVEL_ROOT="DEBUG"

# Pool taille personnalisée
$env:SPRING_DATASOURCE_HIKARI_MAXIMUM_POOL_SIZE=30
```

---

## Raccourcis clavier

| Touche | Action |
|--------|--------|
| Ctrl+C | Arrêter l'app / Quitter le launcher |
| Ctrl+L | Effacer l'écran (PowerShell) |
| ↑/↓ | Historique des commandes (PowerShell) |
| Tab | Auto-completion (PowerShell) |

---

## Alternatives au launcher

### Via Maven directement

```bash
mvn spring-boot:run -Dspring-boot.run.profiles=mvc
```

### Via Docker (optionnel, non configuré)

```bash
docker build -t benchmark-rest .
docker run -p 8080:8080 benchmark-rest
```

### Via IDE IntelliJ

1. Ouvrir le projet
2. Run → Edit Configurations
3. Ajouter Spring Boot configuration
4. Sélectionner profile (mvc, jersey, data-rest)
5. Run

---

**Conseils** :
- Garder au moins 2-3 fenêtres PowerShell ouvertes (une pour l'app, une pour les tests, une pour les logs)
- Copier-coller les URLs pour éviter les typos
- Prendre des captures JMeter toutes les 5 min
- Monitorer Prometheus en permanence pendant les tests
3. **Lancer une variante**
   ```
   Choisir option: 2 (Variante C - Spring MVC)
   ```
# Utilisation du Launcher

## Option 1 : Batch (launcher.bat)

### Avantages
- Simple, pas de dépendance
- Fonctionne sur tous les PC Windows
- Pas besoin de PowerShell

### Comment l'utiliser
```bash
# Double-cliquer sur launcher.bat
# Ou via CMD:
cd C:\Users\youbitech\Desktop\Benchmark
launcher.bat
```

### Limitations
- Interface basique
- Pas de coloration syntaxique

---

## Option 2 : PowerShell (launcher.ps1) - RECOMMANDÉ

### Avantages
- Interface colorée et conviviale
- Meilleur feedback
- Peut tester les endpoints automatiquement
- Ouvre les navigateurs

### Comment l'utiliser

#### Première fois : Configurer PowerShell
```powershell
# Ouvrir PowerShell en tant qu'administrateur
# Exécuter :
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

#### Ensuite : Lancer le script
```bash
# Via CMD ou PowerShell :
cd C:\Users\youbitech\Desktop\Benchmark
powershell -ExecutionPolicy Bypass -File launcher.ps1

# Ou double-cliquer sur launcher.ps1 (si configured)
```

### Navigation dans le menu
```
Choisissez une option [0-9]: 1
```

---

## Étapes recommandées

### Démarrage initial

1. **Lancer le launcher** (PowerShell recommandé)
   ```
   Choisir option: 4 (Démarrer infrastructure Docker)
   ```
   Attend 30-60 secondes que les services démarrent

2. **Vérifier le statut**
   ```
   Choisir option: 6 (Status infrastructure)
   ```
   Vérifier que tous les services sont UP


