
INSERT INTO dim_country (country_name)
SELECT DISTINCT country_name FROM (
    SELECT customer_country as country_name FROM source_mock_data WHERE customer_country IS NOT NULL
    UNION
    SELECT seller_country FROM source_mock_data WHERE seller_country IS NOT NULL
    UNION
    SELECT store_country FROM source_mock_data WHERE store_country IS NOT NULL
    UNION
    SELECT supplier_country FROM source_mock_data WHERE supplier_country IS NOT NULL
) t
WHERE country_name IS NOT NULL
ON CONFLICT (country_name) DO NOTHING;

INSERT INTO dim_category (category_name, pet_category)
SELECT DISTINCT 
    product_category,
    pet_category
FROM source_mock_data 
WHERE product_category IS NOT NULL
ON CONFLICT (category_name) DO NOTHING;

INSERT INTO dim_brand (brand_name)
SELECT DISTINCT product_brand 
FROM source_mock_data 
WHERE product_brand IS NOT NULL
ON CONFLICT (brand_name) DO NOTHING;

INSERT INTO dim_customer (
    customer_email, 
    first_name, 
    last_name, 
    full_name, 
    age, 
    country_id,
    postal_code,
    pet_type,
    pet_name,
    pet_breed
)
SELECT DISTINCT
    s.customer_email,
    s.customer_first_name,
    s.customer_last_name,
    CONCAT(COALESCE(s.customer_first_name, ''), ' ', COALESCE(s.customer_last_name, '')) as full_name,
    s.customer_age,
    c.country_id,
    s.customer_postal_code,
    s.customer_pet_type,
    s.customer_pet_name,
    s.customer_pet_breed
FROM source_mock_data s
LEFT JOIN dim_country c ON c.country_name = s.customer_country
WHERE s.customer_email IS NOT NULL
ON CONFLICT (customer_email) DO NOTHING;


INSERT INTO dim_seller (
    seller_email,
    first_name,
    last_name,
    full_name,
    country_id,
    postal_code
)
SELECT DISTINCT
    s.seller_email,
    s.seller_first_name,
    s.seller_last_name,
    CONCAT(COALESCE(s.seller_first_name, ''), ' ', COALESCE(s.seller_last_name, '')) as full_name,
    c.country_id,
    s.seller_postal_code
FROM source_mock_data s
LEFT JOIN dim_country c ON c.country_name = s.seller_country
WHERE s.seller_email IS NOT NULL
ON CONFLICT (seller_email) DO NOTHING;


INSERT INTO dim_store (
    store_name,
    store_location,
    city,
    state,
    country_id,
    phone,
    email
)
SELECT DISTINCT
    s.store_name,
    COALESCE(s.store_location, 'Main Store') as store_location,
    s.store_city,
    s.store_state,
    c.country_id,
    s.store_phone,
    s.store_email
FROM source_mock_data s
LEFT JOIN dim_country c ON c.country_name = s.store_country
WHERE s.store_name IS NOT NULL
  AND s.store_name != ''
ON CONFLICT (store_name, store_location) DO NOTHING;


INSERT INTO dim_supplier (
    supplier_name,
    contact_person,
    email,
    phone,
    address,
    city,
    country_id
)
SELECT DISTINCT
    s.supplier_name,
    s.supplier_contact,
    s.supplier_email,
    s.supplier_phone,
    s.supplier_address,
    s.supplier_city,
    c.country_id
FROM source_mock_data s
LEFT JOIN dim_country c ON c.country_name = s.supplier_country
WHERE s.supplier_name IS NOT NULL
ON CONFLICT (supplier_name) DO NOTHING;

INSERT INTO dim_product (
    product_name,
    category_id,
    brand_id,
    price,
    weight,
    color,
    size,
    material,
    description,
    rating,
    reviews,
    release_date,
    expiry_date
)
SELECT DISTINCT
    s.product_name,
    cat.category_id,
    b.brand_id,
    s.product_price,
    s.product_weight,
    s.product_color,
    s.product_size,
    s.product_material,
    s.product_description,
    s.product_rating,
    s.product_reviews,
    s.product_release_date,
    s.product_expiry_date
FROM source_mock_data s
LEFT JOIN dim_category cat ON cat.category_name = s.product_category
LEFT JOIN dim_brand b ON b.brand_name = s.product_brand
WHERE s.product_name IS NOT NULL
ON CONFLICT (product_name) DO NOTHING;

INSERT INTO dim_date (
    date_id,
    full_date,
    year,
    quarter,
    month,
    month_name,
    day_of_month,
    day_of_week,
    day_name,
    week_of_year,
    is_weekend
)
SELECT DISTINCT
    CAST(TO_CHAR(sale_date, 'YYYYMMDD') AS INTEGER) as date_id,
    sale_date,
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(QUARTER FROM sale_date) as quarter,
    EXTRACT(MONTH FROM sale_date) as month,
    TO_CHAR(sale_date, 'Month') as month_name,
    EXTRACT(DAY FROM sale_date) as day_of_month,
    EXTRACT(DOW FROM sale_date) as day_of_week,
    TO_CHAR(sale_date, 'Day') as day_name,
    EXTRACT(WEEK FROM sale_date) as week_of_year,
    CASE WHEN EXTRACT(DOW FROM sale_date) IN (0, 6) THEN TRUE ELSE FALSE END as is_weekend
FROM source_mock_data
WHERE sale_date IS NOT NULL
ON CONFLICT (date_id) DO NOTHING;


SELECT '=== СТАТИСТИКА ЗАПОЛНЕНИЯ ИЗМЕРЕНИЙ ===' as section;

SELECT 
    'dim_country' as table_name, 
    COUNT(*) as row_count,
    CASE 
        WHEN COUNT(*) > 0 THEN '✅'
        ELSE '❌'
    END as status
FROM dim_country
UNION ALL
SELECT 'dim_category', COUNT(*),
    CASE WHEN COUNT(*) > 0 THEN '✅' ELSE '❌' END
FROM dim_category
UNION ALL
SELECT 'dim_brand', COUNT(*),
    CASE WHEN COUNT(*) > 0 THEN '✅' ELSE '❌' END
FROM dim_brand
UNION ALL
SELECT 'dim_customer', COUNT(*),
    CASE WHEN COUNT(*) > 0 THEN '✅' ELSE '❌' END
FROM dim_customer
UNION ALL
SELECT 'dim_seller', COUNT(*),
    CASE WHEN COUNT(*) > 0 THEN '✅' ELSE '❌' END
FROM dim_seller
UNION ALL
SELECT 'dim_store', COUNT(*),
    CASE WHEN COUNT(*) > 0 THEN '✅' ELSE '❌' END
FROM dim_store
UNION ALL
SELECT 'dim_supplier', COUNT(*),
    CASE WHEN COUNT(*) > 0 THEN '✅' ELSE '❌' END
FROM dim_supplier
UNION ALL
SELECT 'dim_product', COUNT(*),
    CASE WHEN COUNT(*) > 0 THEN '✅' ELSE '❌' END
FROM dim_product
UNION ALL
SELECT 'dim_date', COUNT(*),
    CASE WHEN COUNT(*) > 0 THEN '✅' ELSE '❌' END
FROM dim_date
ORDER BY table_name;


SELECT '=== ПРОВЕРКА DIM_STORE ===' as section;

SELECT 
    COUNT(*) as total_stores_in_dim,
    COUNT(DISTINCT store_name) as unique_store_names,
    COUNT(DISTINCT store_location) as unique_locations
FROM dim_store;

SELECT 
    'store_mapping_check' as check_type,
    COUNT(DISTINCT s.store_name) as stores_in_source,
    COUNT(DISTINCT st.store_name) as stores_in_dim,
    COUNT(DISTINCT s.store_name) - COUNT(DISTINCT st.store_name) as missing_stores
FROM source_mock_data s
LEFT JOIN dim_store st ON st.store_name = s.store_name;


SELECT '=== ПРОВЕРКА ГОТОВНОСТИ К ЗАПОЛНЕНИЮ FACT_SALES ===' as section;

SELECT
    'customer' as entity,
    COUNT(DISTINCT s.customer_email) as source_count,
    COUNT(DISTINCT c.customer_email) as dim_count,
    COUNT(DISTINCT s.customer_email) - COUNT(DISTINCT c.customer_email) as missing
FROM source_mock_data s
LEFT JOIN dim_customer c ON c.customer_email = s.customer_email
UNION ALL
SELECT 'seller', COUNT(DISTINCT s.seller_email), COUNT(DISTINCT sel.seller_email),
    COUNT(DISTINCT s.seller_email) - COUNT(DISTINCT sel.seller_email)
FROM source_mock_data s
LEFT JOIN dim_seller sel ON sel.seller_email = s.seller_email
UNION ALL
SELECT 'product', COUNT(DISTINCT s.product_name), COUNT(DISTINCT p.product_name),
    COUNT(DISTINCT s.product_name) - COUNT(DISTINCT p.product_name)
FROM source_mock_data s
LEFT JOIN dim_product p ON p.product_name = s.product_name
UNION ALL
SELECT 'store', COUNT(DISTINCT s.store_name), COUNT(DISTINCT st.store_name),
    COUNT(DISTINCT s.store_name) - COUNT(DISTINCT st.store_name)
FROM source_mock_data s
LEFT JOIN dim_store st ON st.store_name = s.store_name
UNION ALL
SELECT 'supplier', COUNT(DISTINCT s.supplier_name), COUNT(DISTINCT sup.supplier_name),
    COUNT(DISTINCT s.supplier_name) - COUNT(DISTINCT sup.supplier_name)
FROM source_mock_data s
LEFT JOIN dim_supplier sup ON sup.supplier_name = s.supplier_name;


SELECT '=== ИЗМЕРЕНИЯ УСПЕШНО ЗАПОЛНЕНЫ ===' as status;

SELECT 
    CASE 
        WHEN (SELECT COUNT(*) FROM dim_customer) > 0
         AND (SELECT COUNT(*) FROM dim_seller) > 0
         AND (SELECT COUNT(*) FROM dim_product) > 0
         AND (SELECT COUNT(*) FROM dim_store) > 0
         AND (SELECT COUNT(*) FROM dim_date) > 0
        THEN '✅ Все измерения успешно заполнены'
        ELSE '⚠️ Некоторые измерения пусты, проверьте ошибки выше'
    END as ready_for_fact_table;