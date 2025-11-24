USE superstore;

SELECT order_year, SUM(sales) AS total_revenue
FROM v_sales_enriched
GROUP BY order_year
ORDER BY order_year;

SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, SUM(sales) AS revenue
FROM v_sales_enriched
GROUP BY month
ORDER BY month;

SELECT 
    order_year,
    SUM(sales) AS revenue,
    LAG(SUM(sales)) OVER (ORDER BY order_year) AS prev_year_revenue,
    (SUM(sales) - LAG(SUM(sales)) OVER (ORDER BY order_year)) 
        / LAG(SUM(sales)) OVER (ORDER BY order_year) AS yoy_growth
FROM v_sales_enriched
GROUP BY order_year
ORDER BY order_year;

SELECT category, SUM(sales) AS revenue
FROM v_sales_enriched
GROUP BY category
ORDER BY revenue DESC;

SELECT product_name, SUM(sales) AS revenue
FROM v_sales_enriched
GROUP BY product_name
ORDER BY revenue DESC
LIMIT 10;

SELECT region, SUM(sales) AS revenue
FROM v_sales_enriched
GROUP BY region
ORDER BY revenue DESC;

SELECT segment, SUM(sales) AS revenue
FROM v_sales_enriched
GROUP BY segment
ORDER BY revenue DESC;

SELECT customer_id, COUNT(DISTINCT order_id) AS total_orders
FROM v_sales_enriched
GROUP BY customer_id
HAVING total_orders > 1;
