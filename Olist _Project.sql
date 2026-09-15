CREATE DATABASE olist_project;
USE olist_project;

SELECT * FROM olist_customers_dataset;
SELECT * FROM olist_geolocation_dataset;
SELECT * FROM olist_order_items_dataset;
SELECT * FROM olist_order_payments_dataset;
SELECT * FROM olist_order_reviews_dataset;
SELECT * FROM olist_orders_dataset;
SELECT * FROM olist_products_dataset;
SELECT * FROM olist_sellers_dataset;
SELECT * FROM product_category_name_translation;

RENAME TABLE
olist_customers_dataset TO customers,
olist_geolocation_dataset TO geolocation,
olist_order_items_dataset TO order_items,
olist_order_payments_dataset TO payments,
olist_order_reviews_dataset TO reviews,
olist_orders_dataset TO orders,
olist_products_dataset TO products,
olist_sellers_dataset TO sellers,
product_category_name_translation TO category_translation;

SELECT
    COUNT(*) AS total_rows,
    SUM(order_id IS NULL) AS null_order_id
FROM orders;

SELECT
    COUNT(*) AS total_rows,
    SUM(customer_id IS NULL) AS null_customer_id
FROM customers;
-------------------------------------------------------------------------------------
-- REVENUE:
 -- • Total revenue 
 -- • Monthly revenue 
 -- • Average order value 
 -- • Revenue by product category 
 -- • Revenue by seller 
 -- • Revenue by state
 ----------------------------------------------------------------------------------------------------
 SELECT ROUND (SUM(price),2) AS total_revenue
 FROM order_items;

SELECT
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS month,
    ROUND(SUM(oi.price), 2) AS monthly_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY month
ORDER BY month;

SELECT
    ROUND(SUM(oi.price) / COUNT(DISTINCT o.order_id), 2) AS average_order_value
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id;
    
SELECT
    ct.product_category_name_english AS category,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
LEFT JOIN category_translation ct
    ON p.product_category_name = ct.product_category_name
GROUP BY ct.product_category_name_english
ORDER BY total_revenue DESC
LIMIT 10;

SELECT
    oi.seller_id,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM order_items oi
JOIN sellers s
    ON oi.seller_id = s.seller_id
GROUP BY oi.seller_id
ORDER BY total_revenue DESC;


-----------------------------------------------------------------------------------------------
-- CUSTOMER EXPERIENCE: 
-- • Average review score 
-- • Review score by category 
-- • Review score by seller 
-- • Review score by state 
-- • Review score by order value
----------------------------------------------------------------------------------------------
SELECT
    ROUND(AVG(review_score), 2) AS average_review_score
FROM reviews;

SELECT
    ct.product_category_name_english AS category,
    ROUND(AVG(r.review_score), 2) AS average_review_score,
    COUNT(r.review_id) AS total_reviews
FROM reviews r
JOIN orders o
    ON r.order_id = o.order_id
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
LEFT JOIN category_translation ct
    ON p.product_category_name = ct.product_category_name
GROUP BY ct.product_category_name_english
ORDER BY average_review_score DESC;

SELECT
    oi.seller_id,
    ROUND(AVG(r.review_score), 2) AS average_review_score,
    COUNT(r.review_id) AS total_reviews
FROM reviews r
JOIN order_items oi
    ON r.order_id = oi.order_id
GROUP BY oi.seller_id
ORDER BY average_review_score DESC;

SELECT
    c.customer_state,
    ROUND(AVG(r.review_score), 2) AS average_review_score,
    COUNT(r.review_id) AS total_reviews
FROM reviews r
JOIN orders o
    ON r.order_id = o.order_id
JOIN customers c
    ON o.customer_id = c.customer_id
GROUP BY c.customer_state
ORDER BY average_review_score DESC;

SELECT
    CASE
        WHEN order_value < 100 THEN 'Low'
        WHEN order_value < 500 THEN 'Medium'
        ELSE 'High'
    END AS order_value_group,
    ROUND(AVG(review_score), 2) AS average_review_score,
    COUNT(*) AS total_reviews
FROM (
    SELECT
        o.order_id,
        SUM(oi.price) AS order_value,
        r.review_score
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    JOIN reviews r
        ON o.order_id = r.order_id
    GROUP BY o.order_id, r.review_score
) AS order_data
GROUP BY order_value_group
ORDER BY average_review_score DESC;
-----------------------------------------------------------------------------------------------
-- DELIVERY: 
-- • Estimated vs actual delivery time 
-- • Average delivery delay 
-- • Late-delivery percentage 
-- • Delivery performance by seller 
-- • Delivery performance by geography
--------------------------------------------------------------------------------------------------------
SELECT
    order_id,
    DATEDIFF(
        order_delivered_customer_date,
        order_purchase_timestamp
    ) AS actual_delivery_days,
    DATEDIFF(
        order_estimated_delivery_date,
        order_purchase_timestamp
    ) AS estimated_delivery_days
FROM orders
WHERE order_delivered_customer_date IS NOT NULL
  AND order_estimated_delivery_date IS NOT NULL;

SELECT
    ROUND(
        AVG(
            DATEDIFF(
                order_delivered_customer_date,
                order_estimated_delivery_date
            )
        ), 2
    ) AS average_delivery_delay_days
FROM orders
WHERE order_delivered_customer_date IS NOT NULL
  AND order_estimated_delivery_date IS NOT NULL;
  
  SELECT
    ROUND(
        100.0 * SUM(
            CASE
                WHEN order_delivered_customer_date > order_estimated_delivery_date
                THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS late_delivery_percentage
FROM orders
WHERE order_delivered_customer_date IS NOT NULL
  AND order_estimated_delivery_date IS NOT NULL;
  
  SELECT
    oi.seller_id,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(
        AVG(
            DATEDIFF(
                o.order_delivered_customer_date,
                o.order_estimated_delivery_date
            )
        ), 2
    ) AS average_delay_days,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date
                THEN 1
                ELSE 0
            END
        ) / COUNT(DISTINCT o.order_id),
        2
    ) AS late_delivery_percentage
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_delivered_customer_date IS NOT NULL
  AND o.order_estimated_delivery_date IS NOT NULL
GROUP BY oi.seller_id
ORDER BY late_delivery_percentage DESC;

SELECT
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS total_orders,

    ROUND(
        AVG(
            DATEDIFF(
                o.order_delivered_customer_date,
                o.order_estimated_delivery_date
            )
        ), 2
    ) AS average_delay_days,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date
                THEN 1
                ELSE 0
            END
        ) / COUNT(DISTINCT o.order_id),
        2
    ) AS late_delivery_percentage

FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id

WHERE o.order_delivered_customer_date IS NOT NULL
  AND o.order_estimated_delivery_date IS NOT NULL

GROUP BY c.customer_state
ORDER BY late_delivery_percentage DESC;

------------------------------------------------------------------------------------------------
-- BUSINESS PERFORMANCE:
-- • High-revenue / low-rating sellers 
-- • High-revenue / low-rating categories 
-- • High-volume / poor-delivery regions 
-- • Sellers with consistently poor performance
------------------------------------------------------------------------------------------------
SELECT
    oi.seller_id,
    ROUND(SUM(oi.price), 2) AS total_revenue,
    ROUND(AVG(r.review_score), 2) AS average_rating,
    COUNT(DISTINCT oi.order_id) AS total_orders
FROM order_items oi
JOIN reviews r
    ON oi.order_id = r.order_id
GROUP BY oi.seller_id
HAVING SUM(oi.price) > 10000
   AND AVG(r.review_score) < 3
ORDER BY total_revenue DESC;

SELECT
    p.product_category_name AS category,
    ROUND(SUM(oi.price), 2) AS total_revenue,
    ROUND(AVG(r.review_score), 2) AS average_rating,
    COUNT(DISTINCT oi.order_id) AS total_orders
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
JOIN reviews r
    ON oi.order_id = r.order_id
GROUP BY p.product_category_name
HAVING SUM(oi.price) > 10000
   AND AVG(r.review_score) < 3
ORDER BY total_revenue DESC;

SELECT
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(
        AVG(
            DATEDIFF(
                o.order_delivered_customer_date,
                o.order_estimated_delivery_date
            )
        ), 2
    ) AS average_delay_days,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN o.order_delivered_customer_date >
                     o.order_estimated_delivery_date
                THEN 1
                ELSE 0
            END
        ) / COUNT(DISTINCT o.order_id),
        2
    ) AS late_delivery_percentage
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
WHERE o.order_delivered_customer_date IS NOT NULL
  AND o.order_estimated_delivery_date IS NOT NULL
GROUP BY c.customer_state
HAVING COUNT(DISTINCT o.order_id) > 1000
   AND (
       AVG(
           DATEDIFF(
               o.order_delivered_customer_date,
               o.order_estimated_delivery_date
           )
       ) > 0
       OR
       SUM(
           CASE
               WHEN o.order_delivered_customer_date >
                    o.order_estimated_delivery_date
               THEN 1
               ELSE 0
           END
       ) / COUNT(DISTINCT o.order_id) > 0.20
   )
ORDER BY late_delivery_percentage DESC;

SELECT
    s.seller_id,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(AVG(r.review_score), 2) AS average_rating,
    ROUND(
        AVG(
            DATEDIFF(
                o.order_delivered_customer_date,
                o.order_estimated_delivery_date
            )
        ), 2
    ) AS average_delay_days,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN o.order_delivered_customer_date >
                     o.order_estimated_delivery_date
                THEN 1
                ELSE 0
            END
        ) / COUNT(DISTINCT o.order_id),
        2
    ) AS late_delivery_percentage
FROM sellers s
JOIN order_items oi
    ON s.seller_id = oi.seller_id
JOIN orders o
    ON oi.order_id = o.order_id
LEFT JOIN reviews r
    ON o.order_id = r.order_id
WHERE o.order_delivered_customer_date IS NOT NULL
  AND o.order_estimated_delivery_date IS NOT NULL
GROUP BY s.seller_id
HAVING COUNT(DISTINCT o.order_id) >= 20
   AND AVG(r.review_score) < 3 
   AND
   (
       SUM(
           CASE
               WHEN o.order_delivered_customer_date >
                    o.order_estimated_delivery_date
               THEN 1
               ELSE 0
           END
       ) / COUNT(DISTINCT o.order_id)
   ) > 0.20
ORDER BY late_delivery_percentage DESC;
