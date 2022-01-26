{%- set query_1 -%}
SELECT DISTINCT paymentmethod FROM {{ ref('stg_payments') }} WHERE payment_status = 'success'
{%- endset -%}

{%- set results = run_query(query_1) -%}

{%- if execute -%}
{%- set payment_methods = results.columns[0].values() -%}
{%- endif -%}

SELECT order_id,
{%- for val in payment_methods %}
  SUM(CASE WHEN paymentmethod = '{{ val }}' THEN payment_amount ELSE 0 END) AS amount_{{ val }} {%- if not loop.last -%}, {%- endif -%}
{%- endfor %}
FROM {{ ref('stg_payments') }}
WHERE payment_status = 'success'
GROUP BY order_id




