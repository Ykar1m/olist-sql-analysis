-- Q13: Top-revenue product in each category (delivered only)
WITH product_rev AS (
    SELECT t.product_category_name_english AS category,
           oi.product_id,
           ROUND(SUM(oi.price), 2) AS revenue
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products p ON oi.product_id = p.product_id
    LEFT JOIN product_category_name_translation t
           ON p.product_category_name = t.product_category_name
    WHERE o.order_status = 'delivered'
    GROUP BY category, oi.product_id
),
ranked AS (
    SELECT category, product_id, revenue,
           ROW_NUMBER() OVER (PARTITION BY category ORDER BY revenue DESC) AS rn
    FROM product_rev
)
SELECT category, product_id, revenue
FROM ranked
WHERE rn = 1
ORDER BY revenue DESC
LIMIT 15;
