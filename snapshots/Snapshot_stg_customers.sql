{% snapshot stg_customer %}
{{
    config(
      target_database='PC_DBT_DB',
      target_schema='DBT',
      unique_key='CUSTOMER_ID',
      strategy='check',
      check_cols=["FIRST_NAME","LAST_NAME"]
    )
}}
select ID as CUSTOMER_ID,FIRST_NAME,LAST_NAME
 from {{ source('jaffle_shop', 'customers') }}
{% endsnapshot %}






	