{{
    config(
        materialized='table',
        database='PC_DBT_DB',
        schema='DBT_TARGET'
    )
}}

WITH SNAPSHOT_TABLE AS (
SELECT  30000+row_number() OVER (ORDER BY CUSTOMER_ID) AS customer_key ,* FROM {{ ref('stg_customer') }}
)
SELECT customer_key,CUSTOMER_ID,FIRST_NAME,LAST_NAME,DBT_VALID_FROM
         AS EFFECTIVE_FROM ,DBT_VALID_TO AS EFFECTIVE_TO,
         (CASE WHEN ST.DBT_VALID_TO IS NULL THEN 'TRUE' ELSE 'FALSE' END) AS STATUS
          FROM SNAPSHOT_TABLE ST
