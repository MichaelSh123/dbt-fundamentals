SELECT o.order_id
    , o.customer_id
    , o.order_date
    , SUM(IFF(p.payment_status = 'success', p.payment_amount, NULL)) AS amount
FROM {{ ref('stg_orders') }} o LEFT JOIN
    {{ ref('stg_payments') }} p
ON o.order_id = p.order_id
GROUP BY 1, 2, 3