SELECT order_id, SUM(PAYMENT_AMOUNT) AS total_amount
FROM {{ ref('stg_payments') }}
GROUP BY 1
HAVING SUM(PAYMENT_AMOUNT) < 0