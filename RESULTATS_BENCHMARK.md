
| Critère | Meilleure variante | Écart (justifier) |
|---------|-------------------|------------------|
| **Débit global (RPS)** | [ ] | [ ] |
| **Latence p95 (ms)** | [ ] | [ ] |
| **Stabilité (% erreurs)** | [ ] | [ ] |
| **Empreinte CPU/RAM** | [ ] | [ ] |
| **Facilité d'exposition relationnelle** | [ ] | [ ] |
| **Coût d'abstraction** | [ ] | [ ] |

### Observations générales

- **N+1 queries** : Comparaison avec/sans JOIN FETCH
  - Sans JOIN FETCH : [ ] rps, [ ] p95ms
  - Avec JOIN FETCH : [ ] rps, [ ] p95ms
  - Impact : [ ]%

- **Overhead HAL (variante D)** : [ ]% de payload supplémentaire

- **Threads : Nombre optimal observé** : [ ]

- **GC impact** : [ ]

- **Recommandation d'usage** :
  - **Variante A (Jersey)** : [ ]
  - **Variante C (@RestController)** : [ ]
  - **Variante D (Spring Data REST)** : [ ]

### Conclusions de performance

1. [ ]

2. [ ]

3. [ ]

---

**Date du test** : [ ]  
**Testeur(s)** : [ ]  
**Durée totale des tests** : [ ]h
# Tableaux de Résultats du Benchmark - Scénarios REST

## T0 — Configuration matérielle & logicielle

| Élément | Valeur |
|---------|--------|
| Machine (CPU, cœurs, RAM) | [À remplir] |
| OS / Kernel | [À remplir] |
| Java version | 17+ |
| Docker/Compose versions | [À remplir] |
| PostgreSQL version | 14+ |
| JMeter version | 5.5+ |
| Prometheus / Grafana / InfluxDB | Latest |
| JVM flags (Xms/Xmx, GC) | -Xms512m -Xmx2g |
| HikariCP (min/max/timeout) | min=10, max=20, timeout=30000ms |

## T1 — Scénarios de Charge

| Scénario | Mix de Requêtes | Paliers de Threads | Ramp-up | Durée/palier | Payload |
|----------|---|---|---|---|---|
| **READ-heavy** | 50% items list, 20% items by category, 20% cat→items, 10% cat list | 50→100→200 | 60s | 10 min | 1 KB |
| **JOIN-filter** | 70% items?categoryId, 30% item id | 60→120 | 60s | 8 min | 1 KB |
| **MIXED** | GET/POST/PUT/DELETE sur items + categories | 50→100 | 60s | 10 min | 1 KB |
| **HEAVY-body** | 50% POST items 5KB, 50% PUT items 5KB | 30→60 | 60s | 8 min | 5 KB |

## T2 — Résultats JMeter (par scénario et variante)

### Scénario READ-heavy

| Mesure | A: Jersey | C: @RestController | D: Spring Data REST |
|--------|-----------|-------------------|-------------------|
| **50 threads** | | | |
| RPS | [ ] | [ ] | [ ] |
| p50 (ms) | [ ] | [ ] | [ ] |
| p95 (ms) | [ ] | [ ] | [ ] |
| p99 (ms) | [ ] | [ ] | [ ] |
| Err % | [ ] | [ ] | [ ] |
| **100 threads** | | | |
| RPS | [ ] | [ ] | [ ] |
| p50 (ms) | [ ] | [ ] | [ ] |
| p95 (ms) | [ ] | [ ] | [ ] |
| p99 (ms) | [ ] | [ ] | [ ] |
| Err % | [ ] | [ ] | [ ] |
| **200 threads** | | | |
| RPS | [ ] | [ ] | [ ] |
| p50 (ms) | [ ] | [ ] | [ ] |
| p95 (ms) | [ ] | [ ] | [ ] |
| p99 (ms) | [ ] | [ ] | [ ] |
| Err % | [ ] | [ ] | [ ] |

### Scénario JOIN-filter

| Mesure | A: Jersey | C: @RestController | D: Spring Data REST |
|--------|-----------|-------------------|-------------------|
| **60 threads** | | | |
| RPS | [ ] | [ ] | [ ] |
| p50 (ms) | [ ] | [ ] | [ ] |
| p95 (ms) | [ ] | [ ] | [ ] |
| p99 (ms) | [ ] | [ ] | [ ] |
| Err % | [ ] | [ ] | [ ] |
| **120 threads** | | | |
| RPS | [ ] | [ ] | [ ] |
| p50 (ms) | [ ] | [ ] | [ ] |
| p95 (ms) | [ ] | [ ] | [ ] |
| p99 (ms) | [ ] | [ ] | [ ] |
| Err % | [ ] | [ ] | [ ] |

### Scénario MIXED (2 entités)

| Mesure | A: Jersey | C: @RestController | D: Spring Data REST |
|--------|-----------|-------------------|-------------------|
| **50 threads** | | | |
| RPS | [ ] | [ ] | [ ] |
| p50 (ms) | [ ] | [ ] | [ ] |
| p95 (ms) | [ ] | [ ] | [ ] |
| p99 (ms) | [ ] | [ ] | [ ] |
| Err % | [ ] | [ ] | [ ] |
| **100 threads** | | | |
| RPS | [ ] | [ ] | [ ] |
| p50 (ms) | [ ] | [ ] | [ ] |
| p95 (ms) | [ ] | [ ] | [ ] |
| p99 (ms) | [ ] | [ ] | [ ] |
| Err % | [ ] | [ ] | [ ] |

### Scénario HEAVY-body

| Mesure | A: Jersey | C: @RestController | D: Spring Data REST |
|--------|-----------|-------------------|-------------------|
| **30 threads** | | | |
| RPS | [ ] | [ ] | [ ] |
| p50 (ms) | [ ] | [ ] | [ ] |
| p95 (ms) | [ ] | [ ] | [ ] |
| p99 (ms) | [ ] | [ ] | [ ] |
| Err % | [ ] | [ ] | [ ] |
| **60 threads** | | | |
| RPS | [ ] | [ ] | [ ] |
| p50 (ms) | [ ] | [ ] | [ ] |
| p95 (ms) | [ ] | [ ] | [ ] |
| p99 (ms) | [ ] | [ ] | [ ] |
| Err % | [ ] | [ ] | [ ] |

## T3 — Ressources JVM (Prometheus) - Au pic de charge

| Métrique | A: Jersey | C: @RestController | D: Spring Data REST |
|----------|-----------|-------------------|-------------------|
| **CPU utilisé (%)** | [ ] | [ ] | [ ] |
| **Heap (Mo) pic** | [ ] | [ ] | [ ] |
| **GC time (ms/s)** | [ ] | [ ] | [ ] |
| **Threads actifs** | [ ] | [ ] | [ ] |
| **HikariCP (actifs/max)** | [ ] | [ ] | [ ] |

## T4 — Détails par endpoint (Scénario JOIN-filter)

### GET /items?categoryId=

| Variante | RPS | p95 (ms) | Err % | Observations (JOIN, N+1, projection) |
|----------|-----|---------|-------|--------------------------------------|
| A: Jersey | [ ] | [ ] | [ ] | [ ] |
| C: @RestController | [ ] | [ ] | [ ] | [ ] |
| D: Spring Data REST | [ ] | [ ] | [ ] | [ ] |

### GET /categories/{id}/items

| Variante | RPS | p95 (ms) | Err % | Observations |
|----------|-----|---------|-------|--------------|
| A: Jersey | [ ] | [ ] | [ ] | [ ] |
| C: @RestController | [ ] | [ ] | [ ] | [ ] |
| D: Spring Data REST | [ ] | [ ] | [ ] | [ ] |

## T5 — Détails par endpoint (Scénario MIXED)

### GET /items

| Variante | RPS | p95 (ms) | Err % | Observations |
|----------|-----|---------|-------|--------------|
| A: Jersey | [ ] | [ ] | [ ] | [ ] |
| C: @RestController | [ ] | [ ] | [ ] | [ ] |
| D: Spring Data REST | [ ] | [ ] | [ ] | [ ] |

### POST /items (1 KB)

| Variante | RPS | p95 (ms) | Err % | Observations |
|----------|-----|---------|-------|--------------|
| A: Jersey | [ ] | [ ] | [ ] | [ ] |
| C: @RestController | [ ] | [ ] | [ ] | [ ] |
| D: Spring Data REST | [ ] | [ ] | [ ] | [ ] |

### PUT /items/{id} (1 KB)

| Variante | RPS | p95 (ms) | Err % | Observations |
|----------|-----|---------|-------|--------------|
| A: Jersey | [ ] | [ ] | [ ] | [ ] |
| C: @RestController | [ ] | [ ] | [ ] | [ ] |
| D: Spring Data REST | [ ] | [ ] | [ ] | [ ] |

### DELETE /items/{id}

| Variante | RPS | p95 (ms) | Err % | Observations |
|----------|-----|---------|-------|--------------|
| A: Jersey | [ ] | [ ] | [ ] | [ ] |
| C: @RestController | [ ] | [ ] | [ ] | [ ] |
| D: Spring Data REST | [ ] | [ ] | [ ] | [ ] |

### GET /categories

| Variante | RPS | p95 (ms) | Err % | Observations |
|----------|-----|---------|-------|--------------|
| A: Jersey | [ ] | [ ] | [ ] | [ ] |
| C: @RestController | [ ] | [ ] | [ ] | [ ] |
| D: Spring Data REST | [ ] | [ ] | [ ] | [ ] |

### POST /categories (0.5 KB)

| Variante | RPS | p95 (ms) | Err % | Observations |
|----------|-----|---------|-------|--------------|
| A: Jersey | [ ] | [ ] | [ ] | [ ] |
| C: @RestController | [ ] | [ ] | [ ] | [ ] |
| D: Spring Data REST | [ ] | [ ] | [ ] | [ ] |

## T6 — Incidents / Erreurs

| Run # | Variante | Type d'erreur | % | Cause probable | Action corrective |
|-------|----------|---------------|---|-----------------|-------------------|
| 1 | [ ] | [ ] | [ ] | [ ] | [ ] |
| 2 | [ ] | [ ] | [ ] | [ ] | [ ] |
| 3 | [ ] | [ ] | [ ] | [ ] | [ ] |

## T7 — Synthèse & Conclusion

