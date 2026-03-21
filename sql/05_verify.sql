
SELECT 
    'source_mock_data' as table_name, 
    COUNT(*) as row_count 
FROM source_mock_data
UNION ALL
SELECT 'dim_customer', COUNT(*) FROM dim_customer
UNION ALL
SELECT 'dim_product', COUNT(*) FROM dim_product
UNION ALL
SELECT 'dim_date', COUNT(*) FROM dim_date
UNION ALL
SELECT 'fact_sales', COUNT(*) FROM fact_sales;

SELECT 
    CASE 
        WHEN (SELECT COUNT(*) FROM source_mock_data) = (SELECT COUNT(*) FROM fact_sales)
        THEN '✅ Все 10000 транзакций перенесены'
        ELSE '❌ Потеря данных'
    END as integrity_check;