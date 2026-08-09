----- Customer Analysis --------

SELECT * FROM dim_customer;

-- Which Age Group generates the highest revenue?
SELECT
    dc.classification_1 AS age_group,
    ROUND(SUM(ft.sales_value), 2) AS total_revenue
FROM fact_transaction ft
INNER JOIN dim_customer dc
    ON ft.household_key = dc.household_key
GROUP BY dc.classification_1
ORDER BY total_revenue DESC;


SELECT *
FROM dim_customer
LIMIT 10;



-- Which Homeownership Segment spends the most?

SELECT
    dc.homeowner_desc,
    ROUND(SUM(ft.sales_value), 2) AS total_revenue,
    COUNT(DISTINCT ft.household_key) AS customers
FROM fact_transaction ft
INNER JOIN dim_customer dc
    ON ft.household_key = dc.household_key
GROUP BY dc.homeowner_desc
ORDER BY total_revenue DESC;


-- What percentage of customers are repeat customers?
SELECT
    household_key,
    COUNT(DISTINCT basket_id) AS total_orders
FROM fact_transaction
GROUP BY household_key
ORDER BY total_orders DESC;


-- Repeat Customer Summary

WITH customer_orders AS (
    SELECT
        household_key,
        COUNT(DISTINCT basket_id) AS total_orders
    FROM fact_transaction
    GROUP BY household_key
)

SELECT
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE total_orders = 1) AS one_time_customers,
    COUNT(*) FILTER (WHERE total_orders > 1) AS repeat_customers,
    ROUND(COUNT(*) FILTER (WHERE total_orders > 1) * 100.0 / COUNT(*), 2) AS repeat_customer_rate
FROM customer_orders;




SELECT
    total_orders,
    COUNT(*) AS customer_count
FROM (
    SELECT
        household_key,
        COUNT(DISTINCT basket_id) AS total_orders
    FROM fact_transaction
    GROUP BY household_key
) t
GROUP BY total_orders
ORDER BY total_orders;



SELECT
    total_orders,
    COUNT(*) AS customer_count
FROM (
    SELECT
        household_key,
        COUNT(DISTINCT basket_id) AS total_orders
    FROM fact_transaction
    GROUP BY household_key
) t
GROUP BY total_orders
ORDER BY total_orders;
