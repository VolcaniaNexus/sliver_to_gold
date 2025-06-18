SELECT 
    order_id,
    customer_id,
    order_timestamp_utc,
    order_total_usd,
    currency_code,
    order_status,
    shipping_street,
    shipping_city,
    shipping_zip_code,
    shipping_country_code,
    payment_method,
    discount_applied_pct
FROM 
    {{ source('store_data', 'orders') }}