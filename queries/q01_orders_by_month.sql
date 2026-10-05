-- Q1: How many orders per month?
SELECT strftime('%Y-%m', order_purchase_timestamp) AS month,
       COUNT(*) AS orders
FROM orders
GROUP BY month
ORDER BY month;
