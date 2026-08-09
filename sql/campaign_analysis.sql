----- Campaign Analysis --------

SELECT * FROM dim_campaign;

-- Which campaigns reached the most customers?

SELECT
    dc.description AS campaign_name,
    COUNT(DISTINCT bcc.household_key) AS targeted_customers
FROM bridge_campaign_customer bcc
JOIN dim_campaign dc
    ON bcc.campaign = dc.campaign
GROUP BY dc.description
ORDER BY targeted_customers DESC;


-- Which campaigns achieved the highest coupon redemption?

SELECT
    dc.description AS campaign_name,
    COUNT(*) AS redeemed_coupons
FROM fact_coupon_redemption fcr
JOIN dim_campaign dc
    ON fcr.campaign = dc.campaign
GROUP BY dc.description
ORDER BY redeemed_coupons DESC;


-- Coupon Redemption Rate

WITH campaign_target AS (
    SELECT
        dc.description,
        COUNT(DISTINCT bcc.household_key) AS targeted_customers
    FROM bridge_campaign_customer bcc
    JOIN dim_campaign dc
        ON bcc.campaign = dc.campaign
    GROUP BY dc.description
),

campaign_redemption AS (
    SELECT
        dc.description,
        COUNT(DISTINCT fcr.household_key) AS redeemed_customers
    FROM fact_coupon_redemption fcr
    JOIN dim_campaign dc
        ON fcr.campaign = dc.campaign
    GROUP BY dc.description
)

SELECT
    ct.description AS campaign_type,
    ct.targeted_customers,
    COALESCE(cr.redeemed_customers, 0) AS redeemed_customers,
    ROUND(
        COALESCE(cr.redeemed_customers, 0) * 100.0
        / ct.targeted_customers,
        2
    ) AS redemption_rate
FROM campaign_target ct
LEFT JOIN campaign_redemption cr
    ON ct.description = cr.description
ORDER BY redemption_rate DESC;
