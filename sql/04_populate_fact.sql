
INSERT INTO fact_sales (
    transaction_id,
    customer_id,
    product_id,
    date_id,
    quantity,
    unit_price,
    total_amount
)
SELECT 
    CONCAT(s.id, '_', s.customer_email, '_', s.sale_date, '_', s.product_name),
    c.customer_id,
    p.product_id,
    d.date_id,
    s.sale_quantity,
    s.product_price,
    s.sale_total_price
FROM source_mock_data s
LEFT JOIN dim_customer c ON c.customer_email = s.customer_email
LEFT JOIN dim_product p ON p.product_name = s.product_name
LEFT JOIN dim_date d ON d.full_date = s.sale_date
ON CONFLICT (transaction_id) DO NOTHING;

SELECT COUNT(*) as fact_rows FROM fact_sales;