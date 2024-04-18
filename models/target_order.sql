
{{
    config(
        materialized='incremental',
        incremental_strategy='delete+insert',
        unique_key = 'order_id',
        merge_update_columns = ['status','ORDER_NAME']
        database='PC_DBT_DB'
        schema='DBT_TARGET'
    )
}}
SELECT
    
    40000 + row_number() OVER (ORDER BY order_id) AS Id,
    status,
    ORDER_NAME
FROM {{ ref("stg_orders") }}

