
TRUNCATE source_mock_data RESTART IDENTITY;

COPY source_mock_data (
    id, customer_first_name, customer_last_name, customer_age, customer_email,
    customer_country, customer_postal_code, customer_pet_type, customer_pet_name, customer_pet_breed,
    seller_first_name, seller_last_name, seller_email, seller_country, seller_postal_code,
    product_name, product_category, product_price, product_quantity,
    sale_date, sale_customer_id, sale_seller_id, sale_product_id,
    sale_quantity, sale_total_price,
    store_name, store_location, store_city, store_state, store_country,
    store_phone, store_email,
    pet_category, product_weight, product_color, product_size, product_brand,
    product_material, product_description, product_rating, product_reviews,
    product_release_date, product_expiry_date,
    supplier_name, supplier_contact, supplier_email, supplier_phone,
    supplier_address, supplier_city, supplier_country
)
FROM '/data/MOCK_DATA.csv' 
DELIMITER ',' 
CSV HEADER;

COPY source_mock_data (
    id, customer_first_name, customer_last_name, customer_age, customer_email,
    customer_country, customer_postal_code, customer_pet_type, customer_pet_name, customer_pet_breed,
    seller_first_name, seller_last_name, seller_email, seller_country, seller_postal_code,
    product_name, product_category, product_price, product_quantity,
    sale_date, sale_customer_id, sale_seller_id, sale_product_id,
    sale_quantity, sale_total_price,
    store_name, store_location, store_city, store_state, store_country,
    store_phone, store_email,
    pet_category, product_weight, product_color, product_size, product_brand,
    product_material, product_description, product_rating, product_reviews,
    product_release_date, product_expiry_date,
    supplier_name, supplier_contact, supplier_email, supplier_phone,
    supplier_address, supplier_city, supplier_country
)
FROM '/data/MOCK_DATA (1).csv' 
DELIMITER ',' 
CSV HEADER;

COPY source_mock_data (
    id, customer_first_name, customer_last_name, customer_age, customer_email,
    customer_country, customer_postal_code, customer_pet_type, customer_pet_name, customer_pet_breed,
    seller_first_name, seller_last_name, seller_email, seller_country, seller_postal_code,
    product_name, product_category, product_price, product_quantity,
    sale_date, sale_customer_id, sale_seller_id, sale_product_id,
    sale_quantity, sale_total_price,
    store_name, store_location, store_city, store_state, store_country,
    store_phone, store_email,
    pet_category, product_weight, product_color, product_size, product_brand,
    product_material, product_description, product_rating, product_reviews,
    product_release_date, product_expiry_date,
    supplier_name, supplier_contact, supplier_email, supplier_phone,
    supplier_address, supplier_city, supplier_country
)
FROM '/data/MOCK_DATA (2).csv' 
DELIMITER ',' 
CSV HEADER;

COPY source_mock_data (
    id, customer_first_name, customer_last_name, customer_age, customer_email,
    customer_country, customer_postal_code, customer_pet_type, customer_pet_name, customer_pet_breed,
    seller_first_name, seller_last_name, seller_email, seller_country, seller_postal_code,
    product_name, product_category, product_price, product_quantity,
    sale_date, sale_customer_id, sale_seller_id, sale_product_id,
    sale_quantity, sale_total_price,
    store_name, store_location, store_city, store_state, store_country,
    store_phone, store_email,
    pet_category, product_weight, product_color, product_size, product_brand,
    product_material, product_description, product_rating, product_reviews,
    product_release_date, product_expiry_date,
    supplier_name, supplier_contact, supplier_email, supplier_phone,
    supplier_address, supplier_city, supplier_country
)
FROM '/data/MOCK_DATA (3).csv' 
DELIMITER ',' 
CSV HEADER;

COPY source_mock_data (
    id, customer_first_name, customer_last_name, customer_age, customer_email,
    customer_country, customer_postal_code, customer_pet_type, customer_pet_name, customer_pet_breed,
    seller_first_name, seller_last_name, seller_email, seller_country, seller_postal_code,
    product_name, product_category, product_price, product_quantity,
    sale_date, sale_customer_id, sale_seller_id, sale_product_id,
    sale_quantity, sale_total_price,
    store_name, store_location, store_city, store_state, store_country,
    store_phone, store_email,
    pet_category, product_weight, product_color, product_size, product_brand,
    product_material, product_description, product_rating, product_reviews,
    product_release_date, product_expiry_date,
    supplier_name, supplier_contact, supplier_email, supplier_phone,
    supplier_address, supplier_city, supplier_country
)
FROM '/data/MOCK_DATA (4).csv' 
DELIMITER ',' 
CSV HEADER;

COPY source_mock_data (
    id, customer_first_name, customer_last_name, customer_age, customer_email,
    customer_country, customer_postal_code, customer_pet_type, customer_pet_name, customer_pet_breed,
    seller_first_name, seller_last_name, seller_email, seller_country, seller_postal_code,
    product_name, product_category, product_price, product_quantity,
    sale_date, sale_customer_id, sale_seller_id, sale_product_id,
    sale_quantity, sale_total_price,
    store_name, store_location, store_city, store_state, store_country,
    store_phone, store_email,
    pet_category, product_weight, product_color, product_size, product_brand,
    product_material, product_description, product_rating, product_reviews,
    product_release_date, product_expiry_date,
    supplier_name, supplier_contact, supplier_email, supplier_phone,
    supplier_address, supplier_city, supplier_country
)
FROM '/data/MOCK_DATA (5).csv' 
DELIMITER ',' 
CSV HEADER;

COPY source_mock_data (
    id, customer_first_name, customer_last_name, customer_age, customer_email,
    customer_country, customer_postal_code, customer_pet_type, customer_pet_name, customer_pet_breed,
    seller_first_name, seller_last_name, seller_email, seller_country, seller_postal_code,
    product_name, product_category, product_price, product_quantity,
    sale_date, sale_customer_id, sale_seller_id, sale_product_id,
    sale_quantity, sale_total_price,
    store_name, store_location, store_city, store_state, store_country,
    store_phone, store_email,
    pet_category, product_weight, product_color, product_size, product_brand,
    product_material, product_description, product_rating, product_reviews,
    product_release_date, product_expiry_date,
    supplier_name, supplier_contact, supplier_email, supplier_phone,
    supplier_address, supplier_city, supplier_country
)
FROM '/data/MOCK_DATA (6).csv' 
DELIMITER ',' 
CSV HEADER;

COPY source_mock_data (
    id, customer_first_name, customer_last_name, customer_age, customer_email,
    customer_country, customer_postal_code, customer_pet_type, customer_pet_name, customer_pet_breed,
    seller_first_name, seller_last_name, seller_email, seller_country, seller_postal_code,
    product_name, product_category, product_price, product_quantity,
    sale_date, sale_customer_id, sale_seller_id, sale_product_id,
    sale_quantity, sale_total_price,
    store_name, store_location, store_city, store_state, store_country,
    store_phone, store_email,
    pet_category, product_weight, product_color, product_size, product_brand,
    product_material, product_description, product_rating, product_reviews,
    product_release_date, product_expiry_date,
    supplier_name, supplier_contact, supplier_email, supplier_phone,
    supplier_address, supplier_city, supplier_country
)
FROM '/data/MOCK_DATA (7).csv' 
DELIMITER ',' 
CSV HEADER;

COPY source_mock_data (
    id, customer_first_name, customer_last_name, customer_age, customer_email,
    customer_country, customer_postal_code, customer_pet_type, customer_pet_name, customer_pet_breed,
    seller_first_name, seller_last_name, seller_email, seller_country, seller_postal_code,
    product_name, product_category, product_price, product_quantity,
    sale_date, sale_customer_id, sale_seller_id, sale_product_id,
    sale_quantity, sale_total_price,
    store_name, store_location, store_city, store_state, store_country,
    store_phone, store_email,
    pet_category, product_weight, product_color, product_size, product_brand,
    product_material, product_description, product_rating, product_reviews,
    product_release_date, product_expiry_date,
    supplier_name, supplier_contact, supplier_email, supplier_phone,
    supplier_address, supplier_city, supplier_country
)
FROM '/data/MOCK_DATA (8).csv' 
DELIMITER ',' 
CSV HEADER;


COPY source_mock_data (
    id, customer_first_name, customer_last_name, customer_age, customer_email,
    customer_country, customer_postal_code, customer_pet_type, customer_pet_name, customer_pet_breed,
    seller_first_name, seller_last_name, seller_email, seller_country, seller_postal_code,
    product_name, product_category, product_price, product_quantity,
    sale_date, sale_customer_id, sale_seller_id, sale_product_id,
    sale_quantity, sale_total_price,
    store_name, store_location, store_city, store_state, store_country,
    store_phone, store_email,
    pet_category, product_weight, product_color, product_size, product_brand,
    product_material, product_description, product_rating, product_reviews,
    product_release_date, product_expiry_date,
    supplier_name, supplier_contact, supplier_email, supplier_phone,
    supplier_address, supplier_city, supplier_country
)
FROM '/data/MOCK_DATA (9).csv' 
DELIMITER ',' 
CSV HEADER;


SELECT 
    '=== СТАТИСТИКА ИМПОРТА ===' as section;

SELECT 
    COUNT(*) as total_records,
    COUNT(DISTINCT id) as unique_ids,
    COUNT(DISTINCT customer_email) as unique_customers,
    COUNT(DISTINCT seller_email) as unique_sellers,
    COUNT(DISTINCT product_name) as unique_products,
    COUNT(DISTINCT product_category) as unique_categories,
    COUNT(DISTINCT product_brand) as unique_brands,
    COUNT(DISTINCT store_name) as unique_stores,
    COUNT(DISTINCT supplier_name) as unique_suppliers,
    MIN(sale_date) as earliest_sale_date,
    MAX(sale_date) as latest_sale_date,
    SUM(sale_quantity) as total_items_sold,
    SUM(sale_total_price) as total_sales_amount
FROM source_mock_data;


SELECT 
    '=== ПРОВЕРКА ДУБЛИКАТОВ ===' as section;

SELECT 
    COUNT(*) as total_records,
    COUNT(DISTINCT id) as unique_ids,
    COUNT(*) - COUNT(DISTINCT id) as duplicate_count,
    CASE 
        WHEN COUNT(*) = COUNT(DISTINCT id) 
        THEN '✅ Нет дубликатов по id'
        ELSE '⚠️ Есть дубликаты по id'
    END as duplicate_check
FROM source_mock_data;


SELECT 
    '=== РАСПРЕДЕЛЕНИЕ ПО ДАТАМ ===' as section;

SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    COUNT(*) as sales_count,
    SUM(sale_quantity) as items_sold,
    SUM(sale_total_price) as total_amount
FROM source_mock_data
GROUP BY EXTRACT(YEAR FROM sale_date), EXTRACT(MONTH FROM sale_date)
ORDER BY year, month;

SELECT 
    '=== ПРОВЕРКА NULL ЗНАЧЕНИЙ ===' as section;

SELECT 
    'customer_email' as field_name,
    COUNT(*) as total_records,
    COUNT(CASE WHEN customer_email IS NULL THEN 1 END) as null_count,
    ROUND(COUNT(CASE WHEN customer_email IS NULL THEN 1 END) * 100.0 / COUNT(*), 2) as null_percent
FROM source_mock_data
UNION ALL
SELECT 'seller_email', COUNT(*), COUNT(CASE WHEN seller_email IS NULL THEN 1 END),
    ROUND(COUNT(CASE WHEN seller_email IS NULL THEN 1 END) * 100.0 / COUNT(*), 2)
FROM source_mock_data
UNION ALL
SELECT 'product_name', COUNT(*), COUNT(CASE WHEN product_name IS NULL THEN 1 END),
    ROUND(COUNT(CASE WHEN product_name IS NULL THEN 1 END) * 100.0 / COUNT(*), 2)
FROM source_mock_data
UNION ALL
SELECT 'sale_date', COUNT(*), COUNT(CASE WHEN sale_date IS NULL THEN 1 END),
    ROUND(COUNT(CASE WHEN sale_date IS NULL THEN 1 END) * 100.0 / COUNT(*), 2)
FROM source_mock_data
UNION ALL
SELECT 'store_name', COUNT(*), COUNT(CASE WHEN store_name IS NULL THEN 1 END),
    ROUND(COUNT(CASE WHEN store_name IS NULL THEN 1 END) * 100.0 / COUNT(*), 2)
FROM source_mock_data
UNION ALL
SELECT 'supplier_name', COUNT(*), COUNT(CASE WHEN supplier_name IS NULL THEN 1 END),
    ROUND(COUNT(CASE WHEN supplier_name IS NULL THEN 1 END) * 100.0 / COUNT(*), 2)
FROM source_mock_data;


SELECT 
    '=== ИМПОРТ ЗАВЕРШЕН ===' as status;

SELECT 
    CASE 
        WHEN COUNT(*) = 10000 
        THEN '✅ УСПЕХ: Импортировано ' || COUNT(*)::VARCHAR || ' записей (ожидалось 10000)'
        ELSE '⚠️ ВНИМАНИЕ: Импортировано ' || COUNT(*)::VARCHAR || ' записей (ожидалось 10000)'
    END as import_result
FROM source_mock_data;