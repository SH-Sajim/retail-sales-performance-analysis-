------ Fact transaction Validation -----

-- total row
SELECT COUNT(*)
FROM fact_transaction;


-- Total Column
SELECT COUNT(*) AS total_columns
FROM information_schema.columns
WHERE table_name = 'fact_transaction';


-- Data Type
SELECT
    column_name,
    data_type
FROM information_schema.columns
WHERE table_name = 'fact_transaction'
ORDER BY ordinal_position;



-- Missing Values

SELECT
    COUNT(*) AS total_rows,
    COUNT(*) - COUNT(household_key) AS household_key_null,
    COUNT(*) - COUNT(basket_id) AS basket_id_null,
    COUNT(*) - COUNT(day) AS day_null,
    COUNT(*) - COUNT(product_id) AS product_id_null,
    COUNT(*) - COUNT(quantity) AS quantity_null,
    COUNT(*) - COUNT(sales_value) AS sales_value_null,
    COUNT(*) - COUNT(store_id) AS store_id_null,
    COUNT(*) - COUNT(coupon_match_disc) AS coupon_match_disc_null,
    COUNT(*) - COUNT(coupon_disc) AS coupon_disc_null,
    COUNT(*) - COUNT(retail_disc) AS retail_disc_null,
    COUNT(*) - COUNT(trans_time) AS trans_time_null,
    COUNT(*) - COUNT(week_no) AS week_no_null
FROM fact_transaction;


-- Negative Quantity
SELECT
    COUNT(*) AS negative_quantity
FROM fact_transaction
WHERE quantity < 0;





