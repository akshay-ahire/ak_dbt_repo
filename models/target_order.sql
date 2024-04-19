{{
    config(
        materialized="incremental",
        incremental_strategy="delete+insert",
        unique_key="order_id",
        merge_update_columns=["status", "ORDER_NAME"],
        database="PC_DBT_DB",
        schema="DBT_TARGET",
    )
}}
select 40000 + row_number() over (order by order_id) as order_id, status, order_name
from {{ ref("stg_orders") }}
