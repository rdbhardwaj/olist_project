{{ config(
    materialized='incremental',
    unique_key=['order_id','order_item_id'],
    incremental_strategy='delete+insert'
) }}

select

    order_id,
    order_item_id,
    product_id,
    seller_id,
    shipping_limit_date,
    price,
    freight_value

from {{ source('raw', 'order_items') }}

{% if is_incremental() %}

where order_id not in (
    select distinct order_id
    from {{ this }}
)

{% endif %}