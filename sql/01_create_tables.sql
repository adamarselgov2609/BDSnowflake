
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

DROP TABLE IF EXISTS dim_customer CASCADE;
CREATE TABLE dim_customer (
    customer_id SERIAL PRIMARY KEY,
    customer_email VARCHAR(200) UNIQUE,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    full_name VARCHAR(200),
    age INTEGER,
    country VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS dim_product CASCADE;
CREATE TABLE dim_product (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(200) UNIQUE,
    category VARCHAR(100),
    price DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS dim_date CASCADE;
CREATE TABLE dim_date (
    date_id INTEGER PRIMARY KEY,
    full_date DATE NOT NULL,
    year INTEGER,
    quarter INTEGER,
    month INTEGER,
    month_name VARCHAR(20),
    day_of_month INTEGER,
    day_of_week INTEGER,
    day_name VARCHAR(20),
    is_weekend BOOLEAN
);


DROP TABLE IF EXISTS fact_sales CASCADE;
CREATE TABLE fact_sales (
    sale_id SERIAL PRIMARY KEY,
    transaction_id VARCHAR(200) UNIQUE,
    customer_id INTEGER REFERENCES dim_customer(customer_id),
    product_id INTEGER REFERENCES dim_product(product_id),
    date_id INTEGER REFERENCES dim_date(date_id),
    quantity INTEGER NOT NULL,
    unit_price DECIMAL(10,2),
    total_amount DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE INDEX idx_fact_customer ON fact_sales(customer_id);
CREATE INDEX idx_fact_product ON fact_sales(product_id);
CREATE INDEX idx_fact_date ON fact_sales(date_id);