{% snapshot stg_customers %}
{{
    config(
      target_database='PC_DBT_DB',
      target_schema='DBT',
      unique_key='CUSTOMER_ID',
      strategy='check',
      check_cols=["FIRST_NAME","LAST_NAME"]
    )
}}
select CUSTOMER_ID,FIRST_NAME,LAST_NAME
 from {{ source('Stage_data', 'stg_customers') }}
{% endsnapshot %}






	