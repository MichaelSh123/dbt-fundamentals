{{
    config (
        materialized="table"
    )

}}


{{ dbt_utils.date_spine(
    datepart="month",
    start_date="cast('2019-12-31' as date)",
    end_date="cast('2021-01-01' as date)"
   )
}}