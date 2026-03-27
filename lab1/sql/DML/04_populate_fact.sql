
TRUNCATE fact_sales RESTART IDENTITY;

INSERT INTO fact_sales (
    transaction_id,
    customer_id,
    seller_id,
    product_id,
    store_id,
    supplier_id,
    date_id,
    quantity,
    unit_price,
    total_amount,
    discount,
    created_at
)
SELECT 
    CONCAT(
        COALESCE(s.id::VARCHAR, '0'), '_',
        COALESCE(REPLACE(s.customer_email, '@', '_'), 'unknown'), '_',
        COALESCE(TO_CHAR(s.sale_date, 'YYYYMMDD'), 'unknown'), '_',
        COALESCE(REPLACE(s.product_name, ' ', '_'), 'unknown')
    ) as transaction_id,
    
    c.customer_id,
    sel.seller_id,
    p.product_id,
    st.store_id,
    sup.supplier_id,
    d.date_id,
    
    s.sale_quantity as quantity,
    s.product_price as unit_price,
    s.sale_total_price as total_amount,
    
    CASE 
        WHEN s.sale_quantity > 0 
         AND s.product_price > 0 
         AND s.sale_total_price < (s.product_price * s.sale_quantity)
        THEN ROUND(
            ((s.product_price * s.sale_quantity) - s.sale_total_price) / 
            (s.product_price * s.sale_quantity) * 100, 
            2
        )
        ELSE 0 
    END as discount,
    
    CURRENT_TIMESTAMP as created_at
    
FROM source_mock_data s

INNER JOIN dim_customer c ON c.customer_email = s.customer_email
INNER JOIN dim_seller sel ON sel.seller_email = s.seller_email
INNER JOIN dim_product p ON p.product_name = s.product_name
INNER JOIN dim_store st ON st.store_name = s.store_name
INNER JOIN dim_supplier sup ON sup.supplier_name = s.supplier_name
INNER JOIN dim_date d ON d.full_date = s.sale_date


ON CONFLICT (transaction_id) DO NOTHING;

SELECT '=== СТАТИСТИКА FACT_SALES ===' as section;

SELECT 
    COUNT(*) as total_fact_rows,
    SUM(quantity) as total_items_sold,
    SUM(total_amount) as total_revenue,
    ROUND(AVG(discount), 2) as avg_discount_percent,
    MIN(created_at) as first_insert,
    MAX(created_at) as last_insert
FROM fact_sales;

SELECT '=== ПРОВЕРКА ЦЕЛОСТНОСТИ СВЯЗЕЙ ===' as section;

SELECT 
    'customer_id' as field_name,
    COUNT(*) as total_records,
    COUNT(CASE WHEN customer_id IS NULL THEN 1 END) as null_count,
    CASE 
        WHEN COUNT(CASE WHEN customer_id IS NULL THEN 1 END) = 0 
        THEN '✅ OK' 
        ELSE '❌ PROBLEM' 
    END as status
FROM fact_sales
UNION ALL
SELECT 'seller_id', COUNT(*), COUNT(CASE WHEN seller_id IS NULL THEN 1 END),
    CASE WHEN COUNT(CASE WHEN seller_id IS NULL THEN 1 END) = 0 THEN '✅ OK' ELSE '❌ PROBLEM' END
FROM fact_sales
UNION ALL
SELECT 'product_id', COUNT(*), COUNT(CASE WHEN product_id IS NULL THEN 1 END),
    CASE WHEN COUNT(CASE WHEN product_id IS NULL THEN 1 END) = 0 THEN '✅ OK' ELSE '❌ PROBLEM' END
FROM fact_sales
UNION ALL
SELECT 'store_id', COUNT(*), COUNT(CASE WHEN store_id IS NULL THEN 1 END),
    CASE WHEN COUNT(CASE WHEN store_id IS NULL THEN 1 END) = 0 THEN '✅ OK' ELSE '❌ PROBLEM' END
FROM fact_sales
UNION ALL
SELECT 'supplier_id', COUNT(*), COUNT(CASE WHEN supplier_id IS NULL THEN 1 END),
    CASE WHEN COUNT(CASE WHEN supplier_id IS NULL THEN 1 END) = 0 THEN '✅ OK' ELSE '❌ PROBLEM' END
FROM fact_sales
UNION ALL
SELECT 'date_id', COUNT(*), COUNT(CASE WHEN date_id IS NULL THEN 1 END),
    CASE WHEN COUNT(CASE WHEN date_id IS NULL THEN 1 END) = 0 THEN '✅ OK' ELSE '❌ PROBLEM' END
FROM fact_sales;


SELECT '=== ПРОВЕРКА УНИКАЛЬНОСТИ TRANSACTION_ID ===' as section;

SELECT 
    COUNT(*) as total_records,
    COUNT(DISTINCT transaction_id) as unique_transactions,
    COUNT(*) - COUNT(DISTINCT transaction_id) as duplicate_count,
    CASE 
        WHEN COUNT(*) = COUNT(DISTINCT transaction_id) 
        THEN '✅ Все transaction_id уникальны'
        ELSE '⚠️ Есть дубликаты transaction_id'
    END as uniqueness_check
FROM fact_sales;

SELECT '=== СРАВНЕНИЕ С ИСХОДНЫМИ ДАННЫМИ ===' as section;

SELECT 
    'source_mock_data' as data_source,
    COUNT(*) as record_count,
    SUM(sale_quantity) as total_quantity,
    SUM(sale_total_price) as total_amount
FROM source_mock_data
UNION ALL
SELECT 
    'fact_sales',
    COUNT(*),
    SUM(quantity),
    SUM(total_amount)
FROM fact_sales;

SELECT 
    CASE 
        WHEN (SELECT COUNT(*) FROM source_mock_data) = (SELECT COUNT(*) FROM fact_sales)
        THEN '✅ Все ' || (SELECT COUNT(*) FROM source_mock_data)::VARCHAR || ' записей успешно перенесены'
        ELSE '⚠️ Потеряно ' || 
             ((SELECT COUNT(*) FROM source_mock_data) - (SELECT COUNT(*) FROM fact_sales))::VARCHAR || 
             ' записей'
    END as data_integrity_check;


SELECT '=== АНАЛИТИЧЕСКИЕ ПРОВЕРКИ ===' as section;

SELECT 
    cat.category_name,
    COUNT(*) as sales_count,
    SUM(fs.quantity) as total_items,
    SUM(fs.total_amount) as total_revenue,
    ROUND(AVG(fs.discount), 2) as avg_discount
FROM fact_sales fs
JOIN dim_product p ON fs.product_id = p.product_id
JOIN dim_category cat ON p.category_id = cat.category_id
GROUP BY cat.category_name
ORDER BY total_revenue DESC;

SELECT 
    d.year,
    d.month_name,
    COUNT(*) as sales_count,
    SUM(fs.quantity) as items_sold,
    SUM(fs.total_amount) as monthly_revenue
FROM fact_sales fs
JOIN dim_date d ON fs.date_id = d.date_id
GROUP BY d.year, d.month, d.month_name
ORDER BY d.year, d.month;

SELECT 
    c.full_name as customer_name,
    c.customer_email,
    COUNT(fs.sale_id) as purchase_count,
    SUM(fs.total_amount) as total_spent,
    ROUND(AVG(fs.total_amount), 2) as avg_purchase_value
FROM fact_sales fs
JOIN dim_customer c ON fs.customer_id = c.customer_id
GROUP BY c.customer_id, c.full_name, c.customer_email
ORDER BY total_spent DESC
LIMIT 5;

SELECT 
    p.product_name,
    cat.category_name,
    COUNT(fs.sale_id) as sales_count,
    SUM(fs.quantity) as total_sold,
    SUM(fs.total_amount) as total_revenue
FROM fact_sales fs
JOIN dim_product p ON fs.product_id = p.product_id
JOIN dim_category cat ON p.category_id = cat.category_id
GROUP BY p.product_name, cat.category_name
ORDER BY total_revenue DESC
LIMIT 5;


SELECT '=== РЕЗУЛЬТАТ ТРАНСФОРМАЦИИ ===' as section;

SELECT 
    CASE 
        WHEN (SELECT COUNT(*) FROM fact_sales) = 10000
         AND (SELECT COUNT(CASE WHEN customer_id IS NULL THEN 1 END) FROM fact_sales) = 0
         AND (SELECT COUNT(CASE WHEN seller_id IS NULL THEN 1 END) FROM fact_sales) = 0
         AND (SELECT COUNT(CASE WHEN product_id IS NULL THEN 1 END) FROM fact_sales) = 0
         AND (SELECT COUNT(CASE WHEN store_id IS NULL THEN 1 END) FROM fact_sales) = 0
         AND (SELECT COUNT(CASE WHEN supplier_id IS NULL THEN 1 END) FROM fact_sales) = 0
         AND (SELECT COUNT(CASE WHEN date_id IS NULL THEN 1 END) FROM fact_sales) = 0
        THEN '✅ МОДЕЛЬ "СНЕЖИНКА" УСПЕШНО ПОСТРОЕНА!
        
Статистика:
- Все 10,000 транзакций перенесены
- Все внешние ключи заполнены (0 NULL)
- Все transaction_id уникальны
- Данные готовы для аналитики'
        ELSE '⚠️ Есть проблемы в модели, проверьте отчеты выше'
    END as final_result;

SELECT 
    '📊 ИНФОРМАЦИЯ О МОДЕЛИ' as info;

SELECT 
    'Количество записей в fact_sales' as metric, 
    COUNT(*)::VARCHAR as value 
FROM fact_sales
UNION ALL
SELECT 'Количество уникальных покупателей', COUNT(DISTINCT customer_id)::VARCHAR 
FROM fact_sales
UNION ALL
SELECT 'Количество уникальных продавцов', COUNT(DISTINCT seller_id)::VARCHAR 
FROM fact_sales
UNION ALL
SELECT 'Количество уникальных товаров', COUNT(DISTINCT product_id)::VARCHAR 
FROM fact_sales
UNION ALL
SELECT 'Количество уникальных магазинов', COUNT(DISTINCT store_id)::VARCHAR 
FROM fact_sales
UNION ALL
SELECT 'Количество уникальных поставщиков', COUNT(DISTINCT supplier_id)::VARCHAR 
FROM fact_sales
UNION ALL
SELECT 'Общая выручка', ROUND(SUM(total_amount)::NUMERIC, 2)::VARCHAR 
FROM fact_sales
UNION ALL
SELECT 'Средний чек', ROUND(AVG(total_amount)::NUMERIC, 2)::VARCHAR 
FROM fact_sales;