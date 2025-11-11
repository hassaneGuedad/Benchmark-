        (RANDOM() * 1000)::numeric(10, 2) as price,
        (RANDOM() * 1000)::int as stock,
        ((generate_series - 1) / 50 + 1) as cat_idx
    FROM generate_series(1, 100000)
)
INSERT INTO item (sku, name, price, stock, category_id)
SELECT
    i.sku,
    i.name,
    i.price,
    i.stock,
    (SELECT id FROM category ORDER BY id LIMIT 1 OFFSET ((i.cat_idx - 1) % (SELECT COUNT(*) FROM category)))
FROM generated_items i
ON CONFLICT DO NOTHING;

-- Commit des changements
COMMIT;
-- Script d'initialisation de la base de données Benchmark

-- Création de la base de données (si elle n'existe pas)
-- CREATE DATABASE benchmark_db;

-- Table des catégories
CREATE TABLE IF NOT EXISTS category (
    id BIGSERIAL PRIMARY KEY,
    code VARCHAR(32) UNIQUE NOT NULL,
    name VARCHAR(128) NOT NULL,
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_category_code ON category(code);

-- Table des articles
CREATE TABLE IF NOT EXISTS item (
    id BIGSERIAL PRIMARY KEY,
    sku VARCHAR(64) UNIQUE NOT NULL,
    name VARCHAR(128) NOT NULL,
    price NUMERIC(10, 2) NOT NULL,
    stock INT NOT NULL,
    category_id BIGINT NOT NULL REFERENCES category(id),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_item_category ON item(category_id);
CREATE INDEX IF NOT EXISTS idx_item_updated_at ON item(updated_at);
CREATE INDEX IF NOT EXISTS idx_item_sku ON item(sku);

-- Insertion de 2000 catégories de test
INSERT INTO category (code, name)
SELECT 'CAT' || LPAD(generate_series::text, 4, '0'), 'Catégorie ' || generate_series
FROM generate_series(1, 2000)
ON CONFLICT DO NOTHING;

-- Insertion de 100 000 articles distribuées sur les catégories
WITH category_ids AS (
    SELECT id FROM category ORDER BY id
),
generated_items AS (
    SELECT
        'SKU' || LPAD(generate_series::text, 6, '0') as sku,
        'Item ' || generate_series || ' - ' || random()::text as name,

