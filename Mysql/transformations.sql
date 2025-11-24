USE superstore;

CREATE OR REPLACE VIEW v_sales_enriched AS
SELECT 
    oi.row_id,
    o.order_id,
    o.order_date,
    YEAR(o.order_date) AS order_year,
    o.ship_date,
    o.ship_mode,
    
    c.customer_id,
    c.customer_name,
    c.segment,
    c.country,
    c.city,
    c.state,
    c.region,

    p.product_id,
    p.category,
    p.sub_category,
    p.product_name,

    oi.quantity,
    oi.sales,
    (oi.sales / NULLIF(oi.quantity,0)) AS unit_price
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON oi.product_id = p.product_id;
