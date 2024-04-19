with target_customers as (

    select
        CUSTOMER_ID,
        FIRST_NAME,
        LAST_NAME,
	STATUS

    from {{source('Target_data','TARGET_CUSTOMER')}}

),

target_orders as (

    select
        ORDER_ID,
        CUSTOMER_ID,
        ORDER_DATE,
        STATUS,
	ORDER_N

customer_orders as (

    select
        customer_id,

        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders

    from {{source('Target_data','TARGET_ORDER')}}

    group by customer_id

),

fact_order as (

    select
        target_customers.customer_id,
        target_customers.first_name,
        target_customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders

    from customers

    left join Customers_Orders using (CUSTOMER_ID)

)

select * from fact_order