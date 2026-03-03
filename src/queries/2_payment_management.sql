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
GROUP BY strftime('%Y-%m', payment_date)
ORDER BY month;

-- 2.3 
SELECT payment_id, amount, payment_date, payment_method
FROM payments
WHERE payment_type = 'Day pass';