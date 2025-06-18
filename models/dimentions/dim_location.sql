{{ config(
    materialized='table'
) }}
WITH
    distinct_addresses
AS
(
    SELECT  DISTINCT
            a.shipping_street,
            a.shipping_city,
            a.shipping_zip_code,
            a.shipping_country_code
    FROM    {{ref('stg_orders')}} a
)
SELECT  ROW_NUMBER()OVER(ORDER BY shipping_country_code) AS location_key,
        shipping_street,
        shipping_city,
        shipping_zip_code,
        shipping_country_code
FROM    distinct_addresses