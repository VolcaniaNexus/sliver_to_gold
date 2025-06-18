with customer_events as (
    select 
        user_id,
        product_id,
        min(event_timestamp_utc) as first_event_timestamp,
        max(event_timestamp_utc) as last_event_timestamp
    from 
        {{ ref('stg_customer_events') }}
    group by user_id, product_id
),
 orders as (
    select
        customer_id,
        min(order_timestamp_utc) as first_order_timestamp,
        max(order_timestamp_utc) as last_order_timestamp,
        sum(CAST(order_total_usd AS DECIMAL(18, 2))) as total_lifetime_spent_usd,
        count(order_id) as total_orders_placed
    from 
        {{ ref('stg_orders') }}
    group by customer_id
)

select
    {{ dbt_utils.generate_surrogate_key(['o.customer_id']) }} as customer_key, 
    o.customer_id as customer_id,
    CASE
            WHEN o.customer_id IS NULL THEN 1 
            ELSE 0                          
    END AS is_guest_customer,
    ce.first_event_timestamp as first_event_timestamp,
    ce.last_event_timestamp as last_event_timestamp,
    o.first_order_timestamp as first_order_timestamp,
    o.last_order_timestamp as last_order_timestamp,
    o.total_lifetime_spent_usd as total_lifetime_spent_usd,
    o.total_orders_placed as total_orders_placed
from 
    orders o
join 
    customer_events ce on o.customer_id = ce.user_id