-- select
--     id as customer_id,
--     first_name,
--     last_name

-- from raw.jaffle_shop.customers

-- instead of using database and schema again and again we will mention database name and schema name in sources.yml file

select
    id as customer_id,
    first_name,
    last_name

from {{ source('jaffle_shop', 'customers') }}