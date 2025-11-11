# Index de Documentation - Benchmark REST Services

Bienvenue ! Voici comment naviguer dans la documentation du projet.

---

## 🚀 **Où Commencer ?**

### Pour un **démarrage rapide** (10 min)
1. Lire `SUMMARY.md` (résumé du projet)
2. Utiliser `launcher.ps1` pour démarrer Docker
3. Utiliser `launcher.ps1` pour démarrer Variante C
4. Accéder à `http://localhost:8080/categories`

### Pour **comprendre le projet** (30 min)
1. Lire `README.md` (overview complet)
2. Parcourir la structure des dossiers
3. Lire `GUIDE_EXECUTION.md` (endpoints et commandes)
4. Consulter `PROFILS.md` (explications)

### Pour **préparer les tests** (1h)
1. Valider avec `CHECKLIST.md`
2. Lire `TODO.md` (plan étape par étape)
3. Configurer JMeter avec `LAUNCHER_GUIDE.md`
4. Préparer les données avec les scripts

### Pour **exécuter les tests** (4h)
1. Suivre `TODO.md` Phase 4
2. Utiliser `launcher.ps1` pour gérer les variantes
3. Lancer JMeter avec les scénarios fournis
4. Remplir `RESULTATS_BENCHMARK.md`

---

## 📚 **Guide des Fichiers**

### **Documentation Générale**

| Fichier | Quoi ? | Pourquoi ? | Pour qui ? |
|---------|--------|-----------|-----------|
| **README.md** | Vue d'ensemble complète | Comprendre l'architecture | Tous |
| **SUMMARY.md** | Résumé de ce qui a été créé | Avoir une vue rapide | Tous |
| **INDEX.md** | Ce fichier | Se repérer dans les docs | Tous |

### **Guides d'Exécution**

| Fichier | Quoi ? | Quand ? | Comment ? |
|---------|--------|--------|----------|
| **GUIDE_EXECUTION.md** | Comment lancer chaque variante | Avant de démarrer | Les 5 premières minutes |
| **LAUNCHER_GUIDE.md** | Guide complet du launcher | Utilisation du launcher | Pour les devs préférant GUI |
| **PROFILS.md** | Explication des profils Maven | Comprendre les configs | Devs avancés |

### **Planification & Validation**

| Fichier | Quoi ? | Quand ? | Pourquoi ? |
|---------|--------|--------|-----------|
| **TODO.md** | Plan détaillé étape par étape | Avant et pendant les tests | Pour ne rien oublier |
| **CHECKLIST.md** | Liste de validation | Avant les tests JMeter | Garantir tous les prérequis |

### **Résultats**

| Fichier | Quoi ? | Quand ? | Comment ? |
|---------|--------|--------|----------|
| **RESULTATS_BENCHMARK.md** | Tableaux T0-T7 à remplir | Après les tests | Pendant/après les runs JMeter |

---

## 🏗️ **Structure du Projet**

```
Benchmark/
│
├── 📄 Fichiers de configuration
│   ├── pom.xml                          # Configuration Maven
│   ├── docker-compose.yml               # Infrastructure Docker
│   ├── prometheus.yml                   # Configuration Prometheus
│   ├── launcher.bat                     # Launcher Windows CMD
│   └── launcher.ps1                     # Launcher PowerShell
│
├── 📂 src/main/java/                    # Code source
│   ├── com/example/Application.java     # Point d'entrée Spring
│   ├── fr/univ/model/                   # Entités JPA
│   │   ├── Category.java
│   │   └── Item.java
│   ├── fr/univ/repository/              # Repositories Spring Data
│   │   ├── CategoryRepository.java
│   │   └── ItemRepository.java
│   ├── fr/univ/service/                 # Services métier
│   │   ├── CategoryService.java
│   │   └── ItemService.java
│   ├── fr/univ/controller/              # Controllers Spring MVC (Variante C)
│   │   ├── CategoryController.java
│   │   ├── ItemController.java
│   │   └── CategoryItemsController.java
│   ├── fr/univ/jersey/                  # Ressources Jersey (Variante A)
│   │   ├── resource/
│   │   │   ├── CategoryResource.java
│   │   │   ├── ItemResource.java
│   │   │   └── CategoryItemsResource.java
│   │   └── config/JerseyConfig.java
│   ├── fr/univ/config/                  # Configuration
│   │   └── RestConfiguration.java       # Spring Data REST config
│   └── fr/univ/dto/                     # DTOs
│       ├── ItemLightDTO.java
│       └── CategoryLightDTO.java
│
├── 📂 src/main/resources/               # Ressources
│   ├── application.yml                  # Config par défaut
│   ├── application-mvc.yml              # Profil Variante C
│   ├── application-jersey.yml           # Profil Variante A
│   ├── application-data-rest.yml        # Profil Variante D
│   ├── logback.xml                      # Configuration logging
│   ├── init-db.sql                      # Script BD
│   ├── jmeter/
│   │   └── READ-heavy.jmx               # Scénario JMeter
│   └── test-data/
│       ├── category_ids.csv             # IDs catégories
│       ├── item_ids.csv                 # IDs items
│       ├── item_payloads_1kb.csv        # Payloads légers
│       └── item_payloads_5kb.csv        # Payloads lourds
│
└── 📂 Documentation
    ├── README.md                        # Vue d'ensemble
    ├── SUMMARY.md                       # Résumé de mise en place
    ├── INDEX.md                         # Ce fichier
    ├── GUIDE_EXECUTION.md               # Comment exécuter
    ├── LAUNCHER_GUIDE.md                # Guide du launcher
    ├── PROFILS.md                       # Explication des profils
    ├── TODO.md                          # Plan détaillé
    ├── CHECKLIST.md                     # Validation avant tests
    └── RESULTATS_BENCHMARK.md           # Tableaux de résultats
```

---

## 🎯 **Chemins par Cas d'Usage**

### **Cas 1 : Je viens de cloner le projet**
```
1. SUMMARY.md          → Comprendre ce qui existe
2. CHECKLIST.md        → Vérifier les prérequis
3. GUIDE_EXECUTION.md  → Apprendre à démarrer
4. launcher.ps1        → Lancer l'app
```

### **Cas 2 : Je veux tester rapidement une variante**
```
1. LAUNCHER_GUIDE.md   → Utiliser le launcher
2. launcher.ps1        → Option 4 (Docker) → Option 2 (Variante C)
3. Attendre "Tomcat started"
4. http://localhost:8080/categories
```

### **Cas 3 : Je dois faire les tests JMeter complets**
```
1. CHECKLIST.md        → Valider tout
2. TODO.md             → Suivre le plan Phase 4
3. launcher.ps1        → Gérer les variantes
4. JMeter              → Exécuter les scénarios
5. RESULTATS_BENCHMARK.md → Remplir les tableaux
```

### **Cas 4 : Je dois déboguer une erreur**
```
1. GUIDE_EXECUTION.md  → Chercher "Troubleshooting"
2. README.md           → Sections de configuration
3. LAUNCHER_GUIDE.md   → Sections "Troubleshooting"
4. Consulter les logs console de l'application
```

### **Cas 5 : Je dois configurer l'infrastructure**
```
1. README.md           → Section infrastructure
2. docker-compose.yml  → Fichier de config
3. prometheus.yml      → Configuration Prometheus
4. application.yml     → Configuration Spring
```

### **Cas 6 : Je dois modifier ou ajouter une variante**
```
1. PROFILS.md          → Comprendre les profils
2. pom.xml             → Ajouter des dépendances
3. application-*.yml   → Créer un profil
4. Implémenter les classes Java
5. GUIDE_EXECUTION.md  → Ajouter la commande de lancement
```

---

## 🔍 **Recherche Rapide**

### "Comment démarrer ?"
→ **GUIDE_EXECUTION.md** → Section "Démarrage rapide"

### "Quels sont les endpoints ?"
→ **README.md** → Section "Endpoints disponibles"  
ou **GUIDE_EXECUTION.md** → Section "Endpoints"

### "Comment utiliser le launcher ?"
→ **LAUNCHER_GUIDE.md**

### "J'ai une erreur, c'est normal ?"
→ **CHECKLIST.md** → Section "Dépannage rapide"  
ou **GUIDE_EXECUTION.md** → Section "Troubleshooting"

### "Comment faire les tests JMeter ?"
→ **TODO.md** → Phase 4  
ou **RESULTATS_BENCHMARK.md** → Sections scénarios

### "Quelle est la structure du projet ?"
→ **README.md** → Section "Architecture"  
ou **SUMMARY.md** → Section "Qu'est-ce qui a été créé ?"

### "Comment configurer Prometheus/Grafana ?"
→ **README.md** → Section "Configuration de Prometheus/Grafana"

### "Comment utiliser les profils Maven ?"
→ **PROFILS.md** ou **GUIDE_EXECUTION.md** → "Démarrage par profil"

### "Quels sont les prérequis ?"
→ **README.md** → Section "Prérequis"  
ou **CHECKLIST.md** → "Prérequis système"

### "Comment générer les données de test ?"
→ **TODO.md** → Phase 2, Étape 2  
ou **GUIDE_EXECUTION.md** → "Variables d'environnement"

---

## 📞 **Navigation Rapide**

| Besoin | Fichier | Section |
|--------|---------|---------|
| Vue générale | README.md | Haut du fichier |
| Points clés | SUMMARY.md | "Points Clés" |
| Démarrage app | GUIDE_EXECUTION.md | "Variante C/D" |
| JMeter setup | TODO.md | Phase 3 |
| Jeux de données | TODO.md | Phase 3, Étape 2 |
| Résultats | RESULTATS_BENCHMARK.md | Tout le fichier |
| Erreurs | LAUNCHER_GUIDE.md | "Troubleshooting" |
| Code source | src/main/java/ | Par package |
| Config | src/main/resources/ | Files yml et xml |

---

## 📅 **Timeline Recommandée**

```
Jour 1 :
  Matin    : Lire README + GUIDE_EXECUTION
  Après-midi : Démarrer Docker + Variante C
  Soir     : CHECKLIST + validation

Jour 2 :
  Matin    : Préparer JMeter (TODO Phase 3)
  Après-midi : Tester Variante A (READ-heavy)
  Soir     : Tester Variante C (READ-heavy)

Jour 3 :
  Toute journée : Tester Variante D (tous scénarios)
  Soirée : Collecte initiale

Jour 4 :
  Matin    : Tests additionnels (JOIN-filter, MIXED, HEAVY)
  Après-midi : Remplir RESULTATS_BENCHMARK.md
  Soir     : Analyse et graphiques
```

---

## 💾 **Fichiers Importants**

### **À consulter régulièrement**
- `pom.xml` - Si compilation échoue
- `docker-compose.yml` - Si erreur Docker
- `application.yml` - Si config problème
- `launcher.ps1` - Pour démarrer l'app

### **À remplir**
- `RESULTATS_BENCHMARK.md` - Pendant/après tests

### **À garder à jour**
- `TODO.md` - Cocher les étapes complétées
- `CHECKLIST.md` - Cocher les validations

---

## 🎓 **Pour en Savoir Plus**

### Documentation Technique
- [Spring Boot](https://spring.io/projects/spring-boot)
- [Spring Data JPA](https://spring.io/projects/spring-data-jpa)
- [Spring Data REST](https://spring.io/projects/spring-data-rest)
- [Jersey](https://eclipse-ee4j.github.io/jersey/)
- [Hibernate](https://hibernate.org/)
- [PostgreSQL](https://www.postgresql.org/docs/)

### Tools
- [JMeter Guide](https://jmeter.apache.org/usermanual/)
- [Prometheus](https://prometheus.io/docs/)
- [Grafana](https://grafana.com/docs/)
- [Docker](https://docs.docker.com/)

---

## ✅ **Validation**

Avant de considérer le projet prêt :

- [ ] J'ai lu README.md
- [ ] J'ai checké CHECKLIST.md
- [ ] Docker fonctionne
- [ ] L'app démarre sans erreur
- [ ] Les endpoints répondent
- [ ] Prometheus scrape
- [ ] JMeter est installé
- [ ] Les données sont prêtes

---

**Créé le** : 11 janvier 2025  
**Version** : 1.0  
**Statut** : Phase 1 Complétée, prêt pour Phase 2

Pour commencer : 👉 **Lire README.md** puis **GUIDE_EXECUTION.md**

