.open fittrackpro.db
.mode column

-- 2.1 
INSERT INTO payments(
    member_id,
    amount,
    payment_date,
    payment_method,
    payment_type
)
-- These values will be the ones inserted for member id 11
VALUES(
    '11',
    50.00,
    datetime('now'),
    'Credit Card',
    'Monthly membership fee'
);

-- 2.2 
SELECT
    strftime('%Y-%m', payment_date) AS month,
    SUM(CAST(amount AS REAL)) AS total_revenue
FROM payments
WHERE payment_type LIKE '%membership fee%'
--Group results by year and month
GROUP BY strftime('%Y-%m', payment_date)
--Sort results chronologically by month
ORDER BY month;

-- 2.3 Retrieves all the payments made by a  day pass 
SELECT payment_id, amount, payment_date, payment_method
FROM payments
--Filter to only include Day pass payments
WHERE payment_type = 'Day pass';