--------- Product Analysis ---------

SELECT * FROM dim_product

-- Which Product Departments generate the highest revenue?

SELECT
    dp.department,
    ROUND(SUM(ft.sales_value), 2) AS total_revenue,
    COUNT(DISTINCT ft.basket_id) AS total_orders
FROM fact_transaction ft
JOIN dim_product dp
    ON ft.product_id = dp.product_id
GROUP BY dp.department
ORDER BY total_revenue DESC;


-- Which product sub-categories generate the highest revenue?

SELECT
    dp.sub_commodity_desc AS product,
    ROUND(SUM(ft.sales_value), 2) AS total_revenue
FROM fact_transaction ft
JOIN dim_product dp
    ON ft.product_id = dp.product_id
GROUP BY dp.sub_commodity_desc
ORDER BY total_revenue DESC
LIMIT 10;


-- Do customers spend more on National brands or Private brands?

SELECT
    dp.brand,
    ROUND(SUM(ft.sales_value), 2) AS total_revenue,
    COUNT(DISTINCT ft.basket_id) AS total_orders
FROM fact_transaction ft
JOIN dim_product dp
    ON ft.product_id = dp.product_id
GROUP BY dp.brand
ORDER BY total_revenue DESC;


-- Which product categories drive the business?

SELECT
    dp.commodity_desc,
    ROUND(SUM(ft.sales_value), 2) AS total_revenue
FROM fact_transaction ft
JOIN dim_product dp
ON ft.product_id = dp.product_id
WHERE dp.commodity_desc <> 'COUPON/MISC ITEMS'
GROUP BY dp.commodity_desc
ORDER BY total_revenue DESC
LIMIT 15;




