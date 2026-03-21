
INSERT INTO dim_customer (customer_email, first_name, last_name, full_name, age, country)
SELECT DISTINCT
    customer_email,
    customer_first_name,
    customer_last_name,
    CONCAT(customer_first_name, ' ', customer_last_name),
    customer_age,
    customer_country
FROM source_mock_data
WHERE customer_email IS NOT NULL
ON CONFLICT (customer_email) DO NOTHING;


INSERT INTO dim_product (product_name, category, price)
SELECT DISTINCT
    product_name,
    product_category,
    product_price
FROM source_mock_data
WHERE product_name IS NOT NULL
ON CONFLICT (product_name) DO NOTHING;


INSERT INTO dim_date (date_id, full_date, year, quarter, month, month_name, 
                      day_of_month, day_of_week, day_name, is_weekend)
SELECT DISTINCT
    CAST(TO_CHAR(sale_date, 'YYYYMMDD') AS INTEGER),
    sale_date,
    EXTRACT(YEAR FROM sale_date),
    EXTRACT(QUARTER FROM sale_date),
    EXTRACT(MONTH FROM sale_date),
    TO_CHAR(sale_date, 'Month'),
    EXTRACT(DAY FROM sale_date),
    EXTRACT(DOW FROM sale_date),
    TO_CHAR(sale_date, 'Day'),
    CASE WHEN EXTRACT(DOW FROM sale_date) IN (0, 6) THEN TRUE ELSE FALSE END
FROM source_mock_data
WHERE sale_date IS NOT NULL
ON CONFLICT (date_id) DO NOTHING;

SELECT 'dim_customer' as table_name, COUNT(*) as count FROM dim_customer
UNION ALL
SELECT 'dim_product', COUNT(*) FROM dim_product
UNION ALL
SELECT 'dim_date', COUNT(*) FROM dim_date;