{{
    config 
    (
        materialized="table"
    )

}}
WITH customers AS 
(
    SELECT id AS customer_id
        , first_name
        , last_name
    FROM raw.jaffle_shop.customers
)
, orders AS 
(
    SELECT id AS order_id
        , user_id AS customer_id
        , order_date 
        , status
    FROM raw.jaffle_shop.orders
)
, customer_orders AS 
(
    SELECT customer_id
        , MIN(order_date) AS first_order_date
        , MAX(order_date) AS most_recent_order_date
        , COUNT(order_id) AS number_of_orders
    FROM orders
    GROUP BY customer_id
)
, final AS 
(
    SELECT c.customer_id
        , c.first_name
        , c.last_name
        , co.first_order_date
        , co.most_recent_order_date
        , co.number_of_orders
    FROM customers c LEFT JOIN
        customer_orders co 
    ON c.customer_id = co.customer_id
)
SELECT *
FROM final
