





SELECT COUNT(*)
FROM bridge_campaign_customer;

SELECT COUNT(*)
FROM bridge_coupon_product;

SELECT COUNT(*)
FROM fact_coupon_redemption;

SELECT COUNT(*)
FROM fact_promotion;


SELECT COUNT(*)
FROM fact_transaction ft
LEFT JOIN dim_product dp
    ON ft.product_id = dp.product_id
WHERE dp.product_id IS NULL;

SELECT *
FROM dim_customer
WHERE homeowner_desc = 'Unknown';