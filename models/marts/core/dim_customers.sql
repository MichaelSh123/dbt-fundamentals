WITH customer_orders AS 
(
    SELECT customer_id
        , MIN(order_date) AS first_order_date
        , MAX(order_date) AS most_recent_order_date
        , COUNT(order_id) AS number_of_orders
        , SUM(amount) AS lifetime_value
    FROM {{ ref('fct_orders') }}
    GROUP BY customer_id
)
, final AS 
(
    SELECT c.customer_id
        , c.first_name
        , c.last_name
        , co.first_order_date
        , co.most_recent_order_date
        , COALESCE(co.number_of_orders, 0) AS number_of_orders
        , IFNULL(co.lifetime_value, 0) AS lifetime_value
    FROM {{ ref('stg_customers') }} c LEFT JOIN
        customer_orders co 
    ON c.customer_id = co.customer_id
)
SELECT *
FROM final
