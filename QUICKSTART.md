# ⚡ Démarrage Rapide - 5 Minutes

Vous êtes pressé ? Voici comment commencer en 5 minutes !

---

## 🎯 Étape 1 : Ouvrir PowerShell (1 min)

```bash
# Ouvrir PowerShell
cd C:\Users\youbitech\Desktop\Benchmark

# Configurer PowerShell (première fois seulement)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

---

## 🐳 Étape 2 : Démarrer Docker (2 min)

```bash
# Lancer le launcher
powershell -ExecutionPolicy Bypass -File launcher.ps1

# Menu → Choisir option : 4
# (Demarrer infrastructure Docker)

# Attendre 30-60 secondes que les services démarrent
```

---

## 🚀 Étape 3 : Démarrer l'Application (1 min)

```bash
# Dans le launcher (ou nouvelle fenêtre PowerShell)
# Menu → Choisir option : 2
# (Variante C - Spring MVC)

# Attendre : "Tomcat started on port(s): 8080"
```

---

## ✅ Étape 4 : Tester ! (1 min)

### Option A : Depuis le launcher
```bash
# Menu → Choisir option : 7
# (Test endpoint)
```

### Option B : Depuis le navigateur
```
http://localhost:8080/categories?page=0&size=5
```

### Option C : Depuis PowerShell
```bash
curl -X GET "http://localhost:8080/categories?page=0&size=5"
```

---

## 🎉 C'est fait !

Vous avez :
- ✅ Docker en cours d'exécution
- ✅ PostgreSQL accessible
- ✅ Application Spring Boot lancée
- ✅ Endpoints disponibles

---

## 🔗 Accès aux Services

| Service | URL |
|---------|-----|
| **Application** | http://localhost:8080 |
| **Prometheus** | http://localhost:9090 |
| **Grafana** | http://localhost:3000 (admin/admin) |
| **InfluxDB** | http://localhost:8086 |
| **PostgreSQL** | localhost:5432 (postgres/postgres) |

---

## 📝 Commandes Utiles

### Arrêter l'application
```bash
Ctrl+C dans PowerShell
```

### Arrêter Docker
```bash
# Depuis le launcher
Option : 5 (Arreter infrastructure Docker)

# Ou via PowerShell
docker-compose down
```

### Relancer tout
```bash
# Depuis le launcher
Option : 5 (Arrêter)
Attendre
Option : 4 (Démarrer)
Option : 2 (Variante C)
```

---

## 🔄 Tester les Autres Variantes

```bash
# Arrêter Variante C
Ctrl+C

# Depuis le launcher
Option : 1 (Variante A - Jersey)
Attendre "Tomcat started"

# Ou
Option : 3 (Variante D - Spring Data REST)
Attendre "Tomcat started"
```

---

## 💾 Sauvegarder les Résultats

```bash
# Avant de relancer une variante
# Exporter les métriques JMeter
# Screenshot Prometheus/Grafana
# Noter les résultats dans RESULTATS_BENCHMARK.md
```

---

## ❓ Ça ne fonctionne pas ?

| Problème | Solution |
|----------|----------|
| Port 8080 occupé | Attendre 5s et relancer OU utiliser port 8081 |
| PostgreSQL erreur | Vérifier `docker-compose ps` |
| Application slow | Vérifier `docker stats` pour ressources |
| Pas de données | Vérifier `init-db.sql` exécuté |
| Erreur compilation | `mvn clean compile -U` |

---

## 📚 Prochaine Lecture

Une fois satisfait du démarrage rapide :

1. Consulter `README.md` pour vue d'ensemble
2. Consulter `GUIDE_EXECUTION.md` pour détails
3. Consulter `TODO.md` pour plan complet

---

## 🎯 Suite

Pour les **tests JMeter** complets : consulter `TODO.md` Phase 4

---

**Créé le** : 11 janvier 2025  
**Temps estimé** : 5 minutes  
**Succès** : ✅ Lorsque vous accédez à http://localhost:8080/categories

