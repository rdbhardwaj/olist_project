select

    oi.order_id,
    oi.order_item_id,

    o.customer_id,
    o.order_status,
    o.purchase_timestamp,

    oi.product_id,
    oi.seller_id,
    oi.price,
    oi.freight_value,

    p.product_category_name,
    p.product_weight_g,
    p.product_length_cm,
    p.product_height_cm,
    p.product_width_cm,

    ct.product_category_name_english,

    s.seller_city,
    s.seller_state

from {{ ref('stg_order_items') }} oi

left join {{ ref('stg_orders') }} o
    on oi.order_id = o.order_id

left join {{ ref('stg_products') }} p
    on oi.product_id = p.product_id

left join {{ ref('stg_category_translations') }} ct
    on p.product_category_name = ct.product_category_name

left join {{ ref('stg_sellers') }} s
    on oi.seller_id = s.seller_id

