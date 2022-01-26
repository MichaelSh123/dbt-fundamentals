SELECT 
    customer_id, order_date
    , {{ dbt_utils.surrogate_key(['customer_id', 'order_date']) }} AS id
    , COUNT(*) AS orders
FROM {{ ref('stg_orders') }}
GROUP BY 1, 2, 3