
DROP TABLE IF EXISTS fact_sales CASCADE;
DROP TABLE IF EXISTS dim_date CASCADE;
DROP TABLE IF EXISTS dim_product CASCADE;
DROP TABLE IF EXISTS dim_supplier CASCADE;
DROP TABLE IF EXISTS dim_store CASCADE;
DROP TABLE IF EXISTS dim_seller CASCADE;
DROP TABLE IF EXISTS dim_customer CASCADE;
DROP TABLE IF EXISTS dim_brand CASCADE;
DROP TABLE IF EXISTS dim_category CASCADE;
DROP TABLE IF EXISTS dim_country CASCADE;
DROP TABLE IF EXISTS source_mock_data CASCADE;

CREATE TABLE source_mock_data (
    id INTEGER,
    customer_first_name VARCHAR(100),
    customer_last_name VARCHAR(100),
    customer_age INTEGER,
    customer_email VARCHAR(200),
    customer_country VARCHAR(100),
    customer_postal_code VARCHAR(50),
    customer_pet_type VARCHAR(50),
    customer_pet_name VARCHAR(100),
    customer_pet_breed VARCHAR(100),
    seller_first_name VARCHAR(100),
    seller_last_name VARCHAR(100),
    seller_email VARCHAR(200),
    seller_country VARCHAR(100),
    seller_postal_code VARCHAR(50),
    product_name VARCHAR(200),
    product_category VARCHAR(100),
    product_price DECIMAL(10,2),
    product_quantity INTEGER,
    sale_date DATE,
    sale_customer_id INTEGER,
    sale_seller_id INTEGER,
    sale_product_id INTEGER,
    sale_quantity INTEGER,
    sale_total_price DECIMAL(10,2),
    store_name VARCHAR(200),
    store_location VARCHAR(200),
    store_city VARCHAR(100),
    store_state VARCHAR(100),
    store_country VARCHAR(100),
    store_phone VARCHAR(50),
    store_email VARCHAR(200),
    pet_category VARCHAR(50),
    product_weight DECIMAL(10,2),
    product_color VARCHAR(50),
    product_size VARCHAR(50),
    product_brand VARCHAR(100),
    product_material VARCHAR(100),
    product_description TEXT,
    product_rating DECIMAL(3,2),
    product_reviews INTEGER,
    product_release_date DATE,
    product_expiry_date DATE,
    supplier_name VARCHAR(200),
    supplier_contact VARCHAR(100),
    supplier_email VARCHAR(200),
    supplier_phone VARCHAR(50),
    supplier_address VARCHAR(200),
    supplier_city VARCHAR(100),
    supplier_country VARCHAR(100)
);


DROP TABLE IF EXISTS dim_country CASCADE;
CREATE TABLE dim_country (
    country_id SERIAL PRIMARY KEY,
    country_name VARCHAR(100) NOT NULL UNIQUE,
    country_code VARCHAR(3),
    continent VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS dim_category CASCADE;
CREATE TABLE dim_category (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    pet_category VARCHAR(50),
    parent_category_id INTEGER REFERENCES dim_category(category_id),
    category_description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS dim_brand CASCADE;
CREATE TABLE dim_brand (
    brand_id SERIAL PRIMARY KEY,
    brand_name VARCHAR(100) NOT NULL UNIQUE,
    brand_website VARCHAR(200),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS dim_customer CASCADE;
CREATE TABLE dim_customer (
    customer_id SERIAL PRIMARY KEY,
    customer_email VARCHAR(200) UNIQUE,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    full_name VARCHAR(200),
    age INTEGER CHECK (age >= 0 AND age <= 120),
    country_id INTEGER REFERENCES dim_country(country_id),
    postal_code VARCHAR(50),
    pet_type VARCHAR(50),
    pet_name VARCHAR(100),
    pet_breed VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS dim_seller CASCADE;
CREATE TABLE dim_seller (
    seller_id SERIAL PRIMARY KEY,
    seller_email VARCHAR(200) UNIQUE,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    full_name VARCHAR(200),
    country_id INTEGER REFERENCES dim_country(country_id),
    postal_code VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS dim_store CASCADE;
CREATE TABLE dim_store (
    store_id SERIAL PRIMARY KEY,
    store_name VARCHAR(200) NOT NULL,
    store_location VARCHAR(200),
    city VARCHAR(100),
    state VARCHAR(100),
    country_id INTEGER REFERENCES dim_country(country_id),
    phone VARCHAR(50),
    email VARCHAR(200),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT unique_store_name_location UNIQUE (store_name, store_location)
);

DROP TABLE IF EXISTS dim_supplier CASCADE;
CREATE TABLE dim_supplier (
    supplier_id SERIAL PRIMARY KEY,
    supplier_name VARCHAR(200) NOT NULL UNIQUE,
    contact_person VARCHAR(100),
    email VARCHAR(200),
    phone VARCHAR(50),
    address VARCHAR(200),
    city VARCHAR(100),
    country_id INTEGER REFERENCES dim_country(country_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS dim_product CASCADE;
CREATE TABLE dim_product (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(200) NOT NULL UNIQUE,
    category_id INTEGER REFERENCES dim_category(category_id),
    brand_id INTEGER REFERENCES dim_brand(brand_id),
    price DECIMAL(10,2) CHECK (price >= 0),
    weight DECIMAL(10,2),
    color VARCHAR(50),
    size VARCHAR(50),
    material VARCHAR(100),
    description TEXT,
    rating DECIMAL(3,2) CHECK (rating >= 0 AND rating <= 5),
    reviews INTEGER CHECK (reviews >= 0),
    release_date DATE,
    expiry_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS dim_date CASCADE;
CREATE TABLE dim_date (
    date_id INTEGER PRIMARY KEY,  -- Формат YYYYMMDD
    full_date DATE NOT NULL UNIQUE,
    year INTEGER NOT NULL,
    quarter INTEGER NOT NULL CHECK (quarter BETWEEN 1 AND 4),
    month INTEGER NOT NULL CHECK (month BETWEEN 1 AND 12),
    month_name VARCHAR(20) NOT NULL,
    day_of_month INTEGER NOT NULL CHECK (day_of_month BETWEEN 1 AND 31),
    day_of_week INTEGER NOT NULL CHECK (day_of_week BETWEEN 0 AND 6),
    day_name VARCHAR(20) NOT NULL,
    week_of_year INTEGER CHECK (week_of_year BETWEEN 1 AND 53),
    is_weekend BOOLEAN NOT NULL,
    is_holiday BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


DROP TABLE IF EXISTS fact_sales CASCADE;
CREATE TABLE fact_sales (
    sale_id SERIAL PRIMARY KEY,
    transaction_id VARCHAR(200) UNIQUE NOT NULL,
    customer_id INTEGER REFERENCES dim_customer(customer_id),
    seller_id INTEGER REFERENCES dim_seller(seller_id),
    product_id INTEGER REFERENCES dim_product(product_id),
    store_id INTEGER REFERENCES dim_store(store_id),
    supplier_id INTEGER REFERENCES dim_supplier(supplier_id),
    date_id INTEGER REFERENCES dim_date(date_id),
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10,2) NOT NULL CHECK (unit_price >= 0),
    total_amount DECIMAL(10,2) NOT NULL CHECK (total_amount >= 0),
    discount DECIMAL(5,2) DEFAULT 0 CHECK (discount BETWEEN 0 AND 100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE INDEX idx_fact_customer ON fact_sales(customer_id);
CREATE INDEX idx_fact_seller ON fact_sales(seller_id);
CREATE INDEX idx_fact_product ON fact_sales(product_id);
CREATE INDEX idx_fact_store ON fact_sales(store_id);
CREATE INDEX idx_fact_supplier ON fact_sales(supplier_id);
CREATE INDEX idx_fact_date ON fact_sales(date_id);
CREATE INDEX idx_fact_transaction ON fact_sales(transaction_id);

CREATE INDEX idx_customer_email ON dim_customer(customer_email);
CREATE INDEX idx_customer_country ON dim_customer(country_id);
CREATE INDEX idx_seller_email ON dim_seller(seller_email);
CREATE INDEX idx_seller_country ON dim_seller(country_id);
CREATE INDEX idx_product_name ON dim_product(product_name);
CREATE INDEX idx_product_category ON dim_product(category_id);
CREATE INDEX idx_product_brand ON dim_product(brand_id);
CREATE INDEX idx_store_name ON dim_store(store_name);
CREATE INDEX idx_store_country ON dim_store(country_id);
CREATE INDEX idx_supplier_name ON dim_supplier(supplier_name);
CREATE INDEX idx_supplier_country ON dim_supplier(country_id);
CREATE INDEX idx_date_full_date ON dim_date(full_date);


COMMENT ON TABLE source_mock_data IS 'Исходные данные из CSV файлов (10 файлов по 1000 строк)';
COMMENT ON TABLE dim_country IS 'Измерение: страны (нормализовано для снежинки)';
COMMENT ON TABLE dim_category IS 'Измерение: категории товаров (поддерживает иерархию)';
COMMENT ON TABLE dim_brand IS 'Измерение: бренды производителей';
COMMENT ON TABLE dim_customer IS 'Измерение: покупатели';
COMMENT ON TABLE dim_seller IS 'Измерение: продавцы';
COMMENT ON TABLE dim_store IS 'Измерение: магазины';
COMMENT ON TABLE dim_supplier IS 'Измерение: поставщики';
COMMENT ON TABLE dim_product IS 'Измерение: товары (связано с категориями и брендами)';
COMMENT ON TABLE dim_date IS 'Измерение: календарь для временного анализа';
COMMENT ON TABLE fact_sales IS 'Таблица фактов: продажи товаров для домашних питомцев';



SELECT 
    '=== СТРУКТУРА БАЗЫ ДАННЫХ СОЗДАНА ===' as status;

SELECT 
    tablename,
    tableowner,
    pg_size_pretty(pg_total_relation_size(tablename::text)) as size
FROM pg_tables 
WHERE schemaname = 'public' 
    AND tablename IN (
        'source_mock_data',
        'dim_country', 'dim_category', 'dim_brand',
        'dim_customer', 'dim_seller', 'dim_store', 'dim_supplier', 'dim_product', 'dim_date',
        'fact_sales'
    )
ORDER BY tablename;

SELECT 
    '✅ Все таблицы успешно созданы' as result,
    COUNT(*) as total_tables
FROM pg_tables 
WHERE schemaname = 'public' 
    AND tablename IN (
        'source_mock_data',
        'dim_country', 'dim_category', 'dim_brand',
        'dim_customer', 'dim_seller', 'dim_store', 'dim_supplier', 'dim_product', 'dim_date',
        'fact_sales'
    );