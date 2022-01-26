SELECT *
FROM {{ ref('stg_orders') }}
{{ mc_limit_in_dev(20) }}
