{{
    config(
        materialized="incremental",
        incremental_strategy="delete+insert",
        unique_key="order_id",
        merge_update_columns=["USER_ID", "STATUS","ORDER_DATE", "ORDER_NAME"],
        database="PC_DBT_DB",
        schema="DBT_TARGET",
    )
}}
select 40000 + row_number() over (order by order_id) as order_id,CUSTOMER_ID, status,ORDER_DATE, order_name
from {{ ref("stg_orders") }}
