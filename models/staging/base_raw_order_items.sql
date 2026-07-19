with source as (
        select * from {{ source('raw', 'order_items') }}
  ),
  renamed as (
      select
          {{ adapter.quote("ORDER_ID") }},
        {{ adapter.quote("ORDER_ITEM_ID") }},
        {{ adapter.quote("PRODUCT_ID") }},
        {{ adapter.quote("SELLER_ID") }},
        {{ adapter.quote("SHIPPING_LIMIT_DATE") }},
        {{ adapter.quote("PRICE") }},
        {{ adapter.quote("FREIGHT_VALUE") }}

      from source
  )
  select * from renamed
    