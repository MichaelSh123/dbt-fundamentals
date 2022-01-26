{%- macro mc_limit_in_dev(num) -%}
{% if target.name == 'dev' -%}
    LIMIT {{ num }}
{%- endif -%}
{%- endmacro -%}