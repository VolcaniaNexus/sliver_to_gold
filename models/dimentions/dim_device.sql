{{ config(
    materialized='table'
) }}
SELECT  ROW_NUMBER()OVER(ORDER BY device_type) AS device_key,
        device_type,
        browser,
        os
FROM    {{ref("stg_customer_events")}}
GROUP BY    device_type,
            browser,
            os