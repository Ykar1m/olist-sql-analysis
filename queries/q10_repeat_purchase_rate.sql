-- Q10: What share of customers order more than once? (delivered only)
WITH cust_orders AS (
    SELECT c.customer_unique_id,
           COUNT(DISTINCT o.order_id) AS n_orders
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
)
SELECT COUNT(*) AS customers,
       SUM(CASE WHEN n_orders >= 2 THEN 1 ELSE 0 END) AS repeat_customers,
       ROUND(100.0 * SUM(CASE WHEN n_orders >= 2 THEN 1 ELSE 0 END) / COUNT(*), 2) AS repeat_pct
FROM cust_orders;
