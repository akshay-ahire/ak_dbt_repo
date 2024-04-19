{{ config(materialized="table", database="PC_DBT_DB", schema="DBT_TARGET") }}

with
    snapshot_table as (
        select 30000 + row_number() over (order by customer_id) as customer_key, *
        from {{ ref("stg_customer") }}
    )
select
    customer_key,
    customer_id,
    first_name,
    last_name,
    dbt_valid_from as effective_from,
    dbt_valid_to as effective_to,
    (case when st.dbt_valid_to is null then 'TRUE' else 'FALSE' end) as status
from snapshot_table st
