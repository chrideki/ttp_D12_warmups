-- Find the mean, min, max, stdev for the interval of time (in days) between purchases for each customer, 
-- as a way of measuring purchasing-frequency for each customer. Also calculate the number of orders for each 
-- customer.
-- (See the *hints* and expected results files for ideas)

WITH data_info AS(
    SELECT
        order_id,
        customer_id,
        contact_name,
        order_date,
        order_date - LAG(order_date,1) OVER(PARTITION BY customer_id ORDER BY order_date) AS day_interval
    FROM customers
    JOIN orders USING (customer_id)
)
SELECT
    customer_id,
    contact_name,
    MIN(day_interval) AS min, 
    ROUND(AVG(day_interval), 2) AS mean,
    MAX(day_interval) AS max,
    ROUND(stddev(day_interval), 2) AS std,
    COUNT(DISTINCT order_id) AS tot_orders    
FROM data_info
GROUP BY customer_id, contact_name
ORDER BY mean;