{%- macro mc_cents_to_dolars(amount, rate, round_to=2 ) -%}
    round(1.00 * {{ amount }} / {{ rate }}, {{round_to}})
{%- endmacro -%}


