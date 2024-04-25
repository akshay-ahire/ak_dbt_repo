{{ config(materialized="table", database="PC_DBT_DB", schema="DBT_TARGET") }}
with customers as (

    select
        CUSTOMER_ID,
        FIRST_NAME,
        LAST_NAME,
	STATUS

    from {{source('Target_data','TARGET_CUSTOMER')}}
    where STATUS = 'TRUE'

),

orders as (

    select
        ORDER_ID,
        CUSTOMER_ID,
        ORDER_DATE,
        STATUS,
	ORDER_NAME

    from {{source('Target_data','TARGET_ORDER')}}

),

customer_orders as (

    select
        customer_id,

        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders

    from orders

    group by 1

),

final as (

    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders

    from customers

    left join customer_orders using (customer_id)

)

select * from final