-- Q7: Late delivery rate by customer state (delivered orders only)
SELECT c.customer_state AS state,
       COUNT(*) AS delivered_orders,
       SUM(CASE WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date
                THEN 1 ELSE 0 END) AS late_orders,
       ROUND(100.0 * SUM(CASE WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date
                              THEN 1 ELSE 0 END) / COUNT(*), 2) AS late_pct
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
GROUP BY state
ORDER BY late_pct DESC;
