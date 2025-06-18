SELECT 
    order_item_id,
    order_id,
    product_id,
    quantity,
    unit_price_at_order_usd,
    item_notes
FROM 
    {{ source('store_data', 'order_items') }}