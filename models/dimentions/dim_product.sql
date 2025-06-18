with products as (
    select
        product_id,
        product_name,
        description_clean as product_description,
        main_category,
        sub_category_1,
        sub_category_2,
        price_usd as current_price_usd,
        CASE
            WHEN stock_quantity > 0 THEN 1  -- Use 1 for TRUE
            ELSE 0                          -- Use 0 for FALSE
        END AS is_available,
        supplier_id
    from 
        {{ ref('stg_products') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['product_id', 'supplier_id']) }} as product_key,
    product_id,
    product_name,
    product_description,
    main_category,
    sub_category_1,
    sub_category_2,
    current_price_usd,
    is_available,
    supplier_id
from products 
    