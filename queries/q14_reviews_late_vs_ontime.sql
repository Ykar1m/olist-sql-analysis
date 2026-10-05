-- Q14: Average review score, late vs on-time deliveries
WITH order_review AS (
    SELECT order_id, AVG(review_score) AS score
    FROM order_reviews
    GROUP BY order_id
)
SELECT CASE WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date
            THEN 'late' ELSE 'on_time' END AS delivery,
       COUNT(*) AS orders,
       ROUND(AVG(r.score), 2) AS avg_review_score
FROM orders o
JOIN order_review r ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
GROUP BY delivery;
