-- select
--     id as order_id,
--     user_id as customer_id,
--     order_date,
--     status
-- from raw.jaffle_shop.orders

-- instead of using database and schema again and again we will mention database name and schema name in sources.yml file


select
    id as order_id,
    user_id as customer_id,
    order_date,
    status

from {{ source('jaffle_shop', 'orders') }}