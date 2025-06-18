SELECT 
    product_id,
    product_name,
    description_clean,
    main_category,
    sub_category_1,
    sub_category_2,
    price_usd,
    stock_quantity,
    weight_kg,
    length_cm,
    width_cm,
    height_cm,
    is_available,
    last_updated_at_utc,
    supplier_id
FROM 
    {{ source('store_data', 'products') }}