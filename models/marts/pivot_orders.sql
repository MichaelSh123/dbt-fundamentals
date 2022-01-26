{%- set query_1 -%}
SELECT DISTINCT LAST_DAY(order_date, month) AS "month" FROM {{ ref('stg_orders') }} WHERE status = 'completed' 
{%- endset -%}

{%- set results = run_query(query_1) -%}

{%- if execute -%}
{%- set years = results.columns[0].values() -%}
{%- endif -%}

SELECT customer_id, 
    {%- for col in years %}
    COUNT(CASE WHEN "month" = '{{ col }}' THEN 1 ELSE NULL END) AS "_{{ col }}_num_orders" {%- if not loop.last -%} , {%- endif -%}
    {%- endfor %}
FROM 
(
    SELECT LAST_DAY(order_date, month) AS "month", customer_id
    FROM {{ ref('stg_orders') }}
    WHERE status = 'completed'
) t
GROUP BY 1